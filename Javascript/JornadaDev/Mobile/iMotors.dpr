program iMotors;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitLogin in 'UnitLogin.pas' {FrmLogin},
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  UnitCarroDetalhe in 'UnitCarroDetalhe.pas' {FrmCarroDetalhe},
  UnitCarroCad in 'UnitCarroCad.pas' {FrmCarroCad},
  DataModuleCarro in 'Services\DataModuleCarro.pas' {DmCarro: TDataModule},
  uFunctions in 'Comum\uFunctions.pas',
  uOpenViewUrl in 'Comum\uOpenViewUrl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.
