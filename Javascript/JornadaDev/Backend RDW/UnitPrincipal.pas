unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  System.JSON,
  uRESTDWBaseIDQX,
  uDWConsts,
  uDWJSONObject,
  uDWJSONTools,
  ServerUtils,

  Controller.Carro;

type
  TFrmPrincipal = class(TForm)
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    RESTDWServerQXID : TRESTDWServerQXID;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    RESTDWServerQXID.Active := false;
    RESTDWServerQXID.Free;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    RESTDWServerQXID := TRESTDWServerQXID.Create(nil);

    // Autenticacao basica...
    RESTDWServerQXID.AuthenticationOptions.AuthorizationOption := TRDWAuthOption.rdwAOBasic;
    TRDWAuthOptionBasic(RESTDWServerQXID.AuthenticationOptions.OptionParams).Username := 'imotors';
    TRDWAuthOptionBasic(RESTDWServerQXID.AuthenticationOptions.OptionParams).Password := '102030';


    // CORS...
    RESTDWServerQXID.CORS := true;
    RESTDWServerQXID.CORS_CustomHeaders.Clear;
    RESTDWServerQXID.CORS_CustomHeaders.Add('Access-Control-Allow-Origin=*');
    RESTDWServerQXID.CORS_CustomHeaders.Add('Access-Control-Allow-Methods=GET, POST, PATCH, PUT, DELETE, OPTIONS');
    RESTDWServerQXID.CORS_CustomHeaders.Add('Access-Control-Allow-Headers=Content-Type, Origin, Accept, Authorization, X-CUSTOM-HEADER');


    // Registrar as rotas...
    Controller.Carro.RegistrarRotas;


    RESTDWServerQXID.Bind(8082, false);
end;

end.
