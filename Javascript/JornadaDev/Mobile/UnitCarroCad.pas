unit UnitCarroCad;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.JSON,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Objects,
  FMX.ListBox,
  FMX.Edit,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.StdCtrls,

  uFunctions;

type
  TFrmCarroCad = class(TForm)
    recToolbar: TRectangle;
    imgVoltar: TImage;
    lblTitulo: TLabel;
    VScroll: TVertScrollBox;
    Layout1: TLayout;
    lblValor: TLabel;
    edtContato: TEdit;
    Layout2: TLayout;
    Label1: TLabel;
    Layout3: TLayout;
    Label2: TLabel;
    edtFone: TEdit;
    Layout4: TLayout;
    Label3: TLabel;
    Layout5: TLayout;
    Label4: TLabel;
    edtCidade: TEdit;
    cmbUF: TComboBox;
    Layout6: TLayout;
    Label5: TLabel;
    edtFabricante: TEdit;
    Layout7: TLayout;
    Label6: TLabel;
    edtModelo: TEdit;
    Layout8: TLayout;
    Label7: TLabel;
    eddtDetalhes: TEdit;
    Layout9: TLayout;
    Label8: TLabel;
    edtAnoFabr: TEdit;
    Layout10: TLayout;
    Label9: TLabel;
    edtAnoModelo: TEdit;
    Layout12: TLayout;
    Label11: TLabel;
    edtURL: TEdit;
    Layout13: TLayout;
    Label12: TLabel;
    cmbCambio: TComboBox;
    Layout14: TLayout;
    Label13: TLabel;
    edtCor: TEdit;
    Layout15: TLayout;
    swTroca: TSwitch;
    Layout16: TLayout;
    Label15: TLabel;
    edtKm: TEdit;
    Layout11: TLayout;
    Label10: TLabel;
    cmbCombustivel: TComboBox;
    recVisualizar: TRectangle;
    Label16: TLabel;
    imgFoto: TImage;
    Layout17: TLayout;
    Label17: TLabel;
    edtValor: TEdit;
    rectSalvar: TRectangle;
    Label14: TLabel;
    procedure imgVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rectSalvarClick(Sender: TObject);
    procedure recVisualizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCarroCad: TFrmCarroCad;

implementation

uses DataModuleCarro;

{$R *.fmx}

procedure TFrmCarroCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action       := TCloseAction.caFree;
   FrmCarroCad := nil;
end;

procedure TFrmCarroCad.imgVoltarClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmCarroCad.rectSalvarClick(Sender: TObject);
var
   json : TJSONObject;
begin
   json := TJSONObject.Create;
   try
      try
         json.AddPair('contato', edtContato.Text);
         json.AddPair('telefone', edtFone.Text);
         json.AddPair('cidade', edtCidade.Text);
         json.AddPair('uf', cmbUF.Selected.Text);
         json.AddPair('fabricante', edtFabricante.Text);
         json.AddPair('modelo', edtModelo.Text);
         json.AddPair('detalhes', eddtDetalhes.Text);
         json.AddPair('ano_fabricacao', TJSONNumber.Create(ifEmpty(edtAnoFabr.Text,'0').ToInteger));
         json.AddPair('ano_modelo', TJSONNumber.Create(ifEmpty(edtAnoModelo.Text,'0').ToInteger));
         json.AddPair('cor', edtCor.Text);
         json.AddPair('km', TJSONNumber.Create(ifEmpty(edtKm.Text,'-1').ToInteger));
         json.AddPair('cambio', cmbCambio.Selected.Text);
         json.AddPair('combustivel', cmbCombustivel.Selected.Text);
         json.AddPair('valor', TJSONNumber.Create(ifEmpty(edtValor.Text,'0').ToDouble));
         json.AddPair('ind_troca', iif(swTroca.IsChecked,'S','N'));
         json.AddPair('url_foto', edtURL.Text);

         DmCarro.Inserir(json);

         Close;

      except on Ex: Exception do
         ShowMessage(Ex.Message);
      end;
   finally
      json.DisposeOf;
   end;
end;

procedure TFrmCarroCad.recVisualizarClick(Sender: TObject);
begin
   uFunctions.LoadImageFromURL(imgFoto.Bitmap, edtURL.Text);
end;

end.
