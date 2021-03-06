unit DataModuleCarro;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  Data.DB,
  RESTRequest4D,
  uFunctions,

  FMX.ListView,
  FMX.ListView.Types,
  FMX.Graphics;

type
  TDmCarro = class(TDataModule)
    TabCarros: TFDMemTable;
    TabCarroDetalhe: TFDMemTable;
  private
    { Private declarations }
  public
    procedure Listar(busca: string);
    procedure ListarId(id_carro: integer);
    procedure Inserir(json: TJsonObject);
    procedure LvAddCar(lv: TListView; id_carro, ano_fabricacao, ano_modelo,
                       km: integer; url_foto, fabricante, modelo, detalhes, cidade, uf: string;
                       valor: Double; fotoTemp: TBitmap);
    procedure LvLoadFotos(lv: TListView);
    { Public declarations }
  end;

var
  DmCarro: TDmCarro;

const
   BaseURL = 'http://localhost:8082';

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDmCarro.Listar(busca: string);
var
   resp : iResponse;
begin
   try
      TabCarros.FieldDefs.Clear;

      resp := TRequest.New.BaseURL(BaseURL)
              .Resource('carros')
              .BasicAuthentication('imotors','102030')
              .DataSetAdapter(TabCarros)
              .AddParam('busca', busca)
              .Accept('application/json')
              .Get;

      if resp.StatusCode <> 200 then
         raise Exception.Create('Erro ao buscar carros: ' + resp.Content);

   except on Ex: Exception do
      raise Exception.Create('Erro ao buscar carros: ' + Ex.Message);
   end;
end;

procedure TDmCarro.ListarId(id_carro: integer);
var
   resp : iResponse;
begin
   try
      TabCarroDetalhe.FieldDefs.Clear;

      resp := TRequest.New.BaseURL(BaseURL)
              .Resource('carros')
              .ResourceSuffix(id_carro.ToString)
              .BasicAuthentication('imotors','102030')
              .DataSetAdapter(TabCarroDetalhe)
              .Accept('application/json')
              .Get;

      if resp.StatusCode = 404 then
         raise Exception.Create('Carro n?o encontrado')
      else if resp.StatusCode <> 200 then
         raise Exception.Create('Erro ao buscar o carro: ' + resp.Content);

   except on Ex: Exception do
      raise Exception.Create('Erro ao buscar carro: ' + Ex.Message);
   end;
end;

procedure TDmCarro.Inserir(json: TJsonObject);
var
   resp : iResponse;
begin
   try
      resp := TRequest.New.BaseURL(BaseURL)
              .Resource('carros')
              .BasicAuthentication('imotors','102030')
              .AddBody(json.ToJSON)
              .Accept('application/json')
              .Post;

      if resp.StatusCode <> 201 then
         raise Exception.Create(uFunctions.RetornoJsonObject(resp.Content, 'erro'));

   except on Ex: Exception do
      raise Exception.Create('Erro ao cadastrar o carro: ' + Ex.Message);
   end;
end;

procedure TDmCarro.LvAddCar(lv: TListView;
                            id_carro, ano_fabricacao, ano_modelo, km: integer;
                            url_foto, fabricante, modelo, detalhes, cidade, uf: string;
                            valor: Double;
                            fotoTemp: TBitmap);
begin
   with lv.Items.Add do
   begin
      Tag := id_carro;

      TListItemText(Objects.FindObject('txtModelo')).Text     := fabricante + '' + modelo;
      TListItemText(Objects.FindObject('txtDetalhes')).Text   := detalhes;
      TListItemText(Objects.FindObject('txtKm')).Text         := ano_fabricacao.ToString + '/' +
                                                                 ano_modelo.ToString + ' - ' +
                                                                 km.ToString + 'Km';
      TListItemText(Objects.FindObject('txtCidade')).Text     := cidade + ' - ' + uf;
      TListItemText(Objects.FindObject('txtValor')).Text      := FormatFloat('R$ #,##0.00', valor);
      TListItemImage(Objects.FindObject('imgFoto')).Bitmap    := fotoTemp;
      TListItemImage(Objects.FindObject('imgFoto')).TagString := url_foto;
   end;
end;

procedure TDmCarro.LvLoadFotos(lv: TListView);
var
   T: TThread;
begin
   T := TThread.CreateAnonymousThread(procedure
   var
      i:Integer;
      img: TListItemImage;
      foto: TBitmap;
   begin
      for I := 0 to lv.Items.Count - 1 do
      begin
         img := TListItemImage(lv.Items[i].Objects.FindDrawable('imgFoto'));

         if img.TagString <> '' then
         begin
            foto := TBitmap.Create;
            uFunctions.LoadImageFromURL(foto, img.TagString);

             TThread.Synchronize(TThread.Current, procedure
             begin
                img.OwnsBitmap := True;
                img.Bitmap     := foto;
             end);

             img.TagString := '';
         end;
      end;
   end);

   T.Start;
end;

end.
