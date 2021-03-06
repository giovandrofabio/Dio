unit UnitLogin;

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
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Layouts;

type
  TFrmLogin = class(TForm)
    Image1: TImage;
    Layout1: TLayout;
    Image2: TImage;
    Layout2: TLayout;
    Label1: TLabel;
    rectComprar: TRectangle;
    Image3: TImage;
    Label2: TLabel;
    recVender: TRectangle;
    Image4: TImage;
    Label3: TLabel;
    procedure rectComprarClick(Sender: TObject);
    procedure recVenderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses
   UnitPrincipal,
   UnitCarroCad;

{$R *.fmx}

procedure TFrmLogin.rectComprarClick(Sender: TObject);
begin
   if not Assigned(FrmPrincipal) then
      Application.CreateForm(TFrmPrincipal, FrmPrincipal);

   FrmPrincipal.Show;
end;


procedure TFrmLogin.recVenderClick(Sender: TObject);
begin
   if not Assigned(FrmCarroCad) then
      Application.CreateForm(TFrmCarroCad, FrmCarroCad);

   FrmCarroCad.Show;
end;

end.
