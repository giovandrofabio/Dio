unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmPrincipal = class(TForm)
    memo: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses Horse,
     Horse.CORS,
     Horse.Jhonson,
     Horse.BasicAuthentication,
     Horse.Compression,
     Controller.Carro;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
   THorse.Use(Compression());
   THorse.Use(Jhonson());
   THorse.Use(CORS);

   THorse.Use(HorseBasicAuthentication(
   function(const AUsername, APassword: string): Boolean
   begin
      // Here inside you can access your database and validate if username and password are valid
      Result := AUsername.Equals('imotors') and APassword.Equals('102030');
   end));

   // Registro das rotas...
   Controller.Carro.RegistrarRotas;

   THorse.Listen(8082, procedure(Horse: THorse)
   begin
      memo.Lines.Add('Servidor executando na prota: ' + Horse.Port.ToString);
   end);
end;

end.
