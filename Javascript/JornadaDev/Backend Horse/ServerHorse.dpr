program ServerHorse;

uses
  Vcl.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  Controller.Carro in 'Controller\Controller.Carro.pas',
  Controller.Comum in 'Controller\Controller.Comum.pas',
  DAO.Connection in 'DAO\DAO.Connection.pas',
  DAO.Carro in 'DAO\DAO.Carro.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
