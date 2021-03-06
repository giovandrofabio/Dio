unit UnitPrincipal;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.Edit,
  FMX.Objects,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  FMX.StdCtrls;

type
  TFrmPrincipal = class(TForm)
    recToolbar: TRectangle;
    Image1: TImage;
    recBusca: TRectangle;
    edtBusca: TEdit;
    recBuscar: TRectangle;
    Label3: TLabel;
    lvCarros: TListView;
    imgCar: TImage;
    procedure lvCarrosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure recBuscarClick(Sender: TObject);
  private
    procedure BuscarCarros(busca: string);
    procedure ThreadCarrosTerminate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
     UnitCarroDetalhe,
     DataModuleCarro;

{$R *.fmx}

procedure TFrmPrincipal.ThreadCarrosTerminate(Sender: TObject);
begin
   if Sender is TThread then
   begin
      if Assigned(TThread(Sender).FatalException) then
      begin
         ShowMessage(Exception(TThread(Sender).FatalException).Message);
         Exit;
      end;
   end;

   with DmCarro.TabCarros do
   begin
      lvCarros.Items.Clear;
      lvCarros.BeginUpdate;

      while not Eof do
      begin
         DmCarro.LvAddCar(lvCarros,
                          FieldByName('id_carro').AsInteger,
                          FieldByName('ano_fabricacao').AsInteger,
                          FieldByName('ano_modelo').AsInteger,
                          FieldByName('km').AsInteger,
                          FieldByName('url_foto').AsString,
                          FieldByName('fabricante').AsString,
                          FieldByName('modelo').AsString,
                          FieldByName('detalhes').AsString,
                          FieldByName('cidade').AsString,
                          FieldByName('uf').AsString,
                          FieldByName('valor').AsFloat,
                          imgCar.Bitmap);
         Next;
      end;

      lvCarros.EndUpdate;
   end;

   DmCarro.LvLoadFotos(lvCarros);
end;

procedure TFrmPrincipal.BuscarCarros(busca: string);
var
   T : TThread;
begin
   if not Assigned(DmCarro) then
      Application.CreateForm(TDmCarro, DmCarro);

   T := TThread.CreateAnonymousThread(procedure
   begin
      DmCarro.Listar(busca);
   end);

   T.OnTerminate := ThreadCarrosTerminate;
   T.Start;
end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action       := TCloseAction.caFree;
   FrmPrincipal := nil;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
   BuscarCarros('');
end;

procedure TFrmPrincipal.lvCarrosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
   if not Assigned(FrmCarroDetalhe) then
      Application.CreateForm(TFrmCarroDetalhe, FrmCarroDetalhe);

   FrmCarroDetalhe.ID_CARRO := AItem.Tag;
   FrmCarroDetalhe.Show;
end;

procedure TFrmPrincipal.recBuscarClick(Sender: TObject);
begin
   BuscarCarros(edtBusca.Text);
end;

end.
