program ServerRDW;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  Controller.Carro in 'Controller\Controller.Carro.pas',
  DAO.Carro in 'DAO\DAO.Carro.pas',
  DAO.Connection in 'DAO\DAO.Connection.pas',
  Controller.Comum in 'Controller\Controller.Comum.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
