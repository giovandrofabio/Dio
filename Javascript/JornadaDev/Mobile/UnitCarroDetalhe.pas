unit UnitCarroDetalhe;

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
  FMX.Objects,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  uFunctions,
  uOpenViewUrl,
  NetEncoding;

type
  TFrmCarroDetalhe = class(TForm)
    lytToolbar: TLayout;
    lblTitulo: TLabel;
    imgVoltar: TImage;
    VertScrollBox1: TVertScrollBox;
    lytFoto: TLayout;
    Layout1: TLayout;
    ImgFoto: TImage;
    lblValor: TLabel;
    Rectangle1: TRectangle;
    lblCidade: TLabel;
    rectDados: TRectangle;
    Layout2: TLayout;
    lblDetalhes: TLabel;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    Label2: TLabel;
    lblCambio: TLabel;
    Rectangle3: TRectangle;
    Label4: TLabel;
    lblTroca: TLabel;
    Layout4: TLayout;
    Rectangle4: TRectangle;
    Label6: TLabel;
    lblAno: TLabel;
    Rectangle5: TRectangle;
    Label8: TLabel;
    lblCor: TLabel;
    Layout5: TLayout;
    Rectangle6: TRectangle;
    Label10: TLabel;
    lblKm: TLabel;
    Rectangle7: TRectangle;
    Label12: TLabel;
    lblCombustivel: TLabel;
    Layout6: TLayout;
    Rectangle8: TRectangle;
    Label3: TLabel;
    lblContato: TLabel;
    Layout7: TLayout;
    rectContato: TRectangle;
    Label5: TLabel;
    procedure imgVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rectContatoClick(Sender: TObject);
  private
    FID_CARRO: Integer;
    procedure CarregarDetalhesCarro;
    { Private declarations }
  public
    { Public declarations }
    property ID_CARRO: Integer read FID_CARRO write FID_CARRO;
  end;

var
  FrmCarroDetalhe: TFrmCarroDetalhe;

implementation

uses DataModuleCarro;

{$R *.fmx}

procedure TFrmCarroDetalhe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action           := TCloseAction.caFree;
   FrmCarroDetalhe := nil;
end;

procedure TFrmCarroDetalhe.FormShow(Sender: TObject);
begin
   CarregarDetalhesCarro;
end;

procedure TFrmCarroDetalhe.imgVoltarClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCarroDetalhe.rectContatoClick(Sender: TObject);
var
   url, fone: string;
begin
    fone := '55' + rectContato.TagString;

    {$IFDEF ANDROID OR IOS}
    url := 'whatsapp://send?phone=' + fone + '&text=' + TNetEncoding.URL.Encode('Gostaria de mais detalhes sobre o ' + lblTitulo.Text);
    {$ELSE}
    url := 'https://web.whatsapp.com/send?phone=' + fone + '&text=' + TNetEncoding.URL.Encode('Gostaria de mais detalhes sobre o ' + lblTitulo.Text);
    {$ENDIF}

    OpenURL(url, true);
end;

procedure TFrmCarroDetalhe.CarregarDetalhesCarro;
var
   foto : TBitmap;
begin
   try
      with DmCarro.TabCarroDetalhe do
      begin
         DmCarro.ListarId(ID_CARRO);

         lblTitulo.Text       := FieldByName('fabricante').AsString + '' +
                                 FieldByName('modelo').AsString;
         lblValor.Text        := FormatFloat('R$ #,##0.00', FieldByName('valor').AsFloat);
         lblCidade.Text       := FieldByName('cidade').AsString + '/' +
                                 FieldByName('uf').AsString;
         lblDetalhes.Text     := FieldByName('detalhes').AsString;
         lblAno.Text          := FieldByName('ano_fabricacao').AsString + '/' + FieldByName('ano_modelo').AsString;
         lblCor.Text          := FieldByName('cor').AsString;

         if FieldByName('km').AsInteger > 0 then
            lblKm.Text        := FormatFloat('#,##', FieldByName('km').AsInteger)
         else
            lblKm.Text        := 'Zero';

         lblCombustivel.Text  := FieldByName('combustivel').AsString;
         lblCambio.Text       := FieldByName('cambio').AsString;

         if FieldByName('ind_troca').AsString = 'S' then
            lblTroca.Text    := 'Sim'
         else
            lblTroca.Text    := 'N?o';

         lblContato.Text      := FieldByName('contato').AsString;
         rectContato.TagString:= FieldByName('telefone').AsString;

         uFunctions.LoadImageFromURL(ImgFoto.Bitmap, FieldByName('url_foto').AsString);
      end;
   except on Ex: Exception do
      ShowMessage(Ex.Message);
   end;
end;


end.
