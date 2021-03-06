unit DAO.Carro;

interface

uses FireDAC.Comp.Client,
     FireDAC.DApt,
     Data.DB,
     System.JSON,
     System.SysUtils,
     System.StrUtils,
     DataSet.Serialize,
     DAO.Connection;

type
   TCarro = class
   private
      FConn: TFDConnection;
      FID_CARRO: integer;
      FANO_FABRICACAO: integer;
      FCOR: string;
      FCAMBIO: string;
      FVALOR: double;
      FKM: integer;
      FUF: string;
      FDETALHES: string;
      FMODELO: string;
      FIND_TROCA: string;
      FANO_MODELO: integer;
      FFABRICANTE: string;
      FCONTATO: string;
      FCIDADE: string;
      FCOMBUSTIVEL: string;
      FTELEFONE: string;
      FURL_FOTO: string;
      procedure Validate(operacao: string);
   public
      constructor Create;
      destructor Destroy; override;

      property ID_CARRO: integer Read FID_CARRO write FID_CARRO;
      property FABRICANTE: string read FFABRICANTE write FFABRICANTE;
      property MODELO: string read FMODELO write FMODELO;
      property DETALHES: string read FDETALHES write FDETALHES;
      property ANO_FABRICACAO: integer read FANO_FABRICACAO write FANO_FABRICACAO;
      property ANO_MODELO: integer read FANO_MODELO write FANO_MODELO;
      property COR: string read FCOR write FCOR;
      property VALOR: double read FVALOR write FVALOR;
      property KM: integer read FKM write FKM;
      property CAMBIO: string read FCAMBIO write FCAMBIO;
      property COMBUSTIVEL: string read FCOMBUSTIVEL write FCOMBUSTIVEL;
      property CIDADE: string read FCIDADE write FCIDADE;
      property UF: string read FUF write FUF;
      property IND_TROCA: string read FIND_TROCA write FIND_TROCA;
      property URL_FOTO: string read FURL_FOTO write FURL_FOTO;
      property CONTATO: string read FCONTATO write FCONTATO;
      property TELEFONE: string read FTELEFONE write FTELEFONE;

      function Listar(busca: string) : TJSONArray;
      procedure Adicionar;
   end;

implementation

{ TCarro }

constructor TCarro.Create;
begin
   FConn := TConnection.CreateConnection;
end;

destructor TCarro.Destroy;
begin
  if Assigned(FConn) then
     FConn.Free;

  inherited;
end;

function TCarro.Listar(busca: string): TJSONArray;
var
   qry: TFDQuery;
begin
   try
      qry            := TFDQuery.Create(nil);
      qry.Connection := FConn;

      with qry do
      begin
         Active := False;
         SQL.Clear;
         SQL.Add('SELECT * FROM TAB_CARRO C');
         SQL.Add('WHERE ID_CARRO > 0');

         if ID_CARRO > 0 then
         begin
            SQL.Add('AND ID_CARRO = :ID_CARRO');
            ParamByName('ID_CARRO').Value := ID_CARRO;
         end;

         if busca <> '' then
         begin
            SQL.Add('AND (MODELO LIKE :MODELO');
            SQL.Add('    OR FABRICANTE LIKE :FABRICANTE');
            SQL.Add('    OR DETALHES LIKE :DETALHES )');
            ParamByName('MODELO').Value     := '%' + busca + '%';
            ParamByName('FABRICANTE').Value := '%' + busca + '%';
            ParamByName('DETALHES').Value   := '%' + busca + '%';
         end;

         SQL.Add('ORDER BY ID_CARRO DESC');
         Active := True;
      end;

      Result := qry.ToJSONArray();
   finally
      qry.DisposeOf
   end;
end;

procedure TCarro.Validate(operacao: string);
begin
   if (FABRICANTE.IsEmpty) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Fabricante n?o informado');

   if (MODELO.IsEmpty) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Modelo n?o informado');

   if (CONTATO.IsEmpty) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Contato n?o informado');

   if (TELEFONE.IsEmpty) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Telefone n?o informado');

   if (DETALHES.IsEmpty) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Detalhes do carro n?o informado');

   if (CIDADE.IsEmpty) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Cidade n?o informado');

   if (UF.IsEmpty) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Fabricante n?o informado');

   if (ANO_FABRICACAO <= 0) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Ano de Fabrica??o n?o informado');

   if (ANO_MODELO <= 0) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Ano do modelo n?o informado');

   if (CONTATO.IsEmpty) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Contato n?o informado');

   if (COR.IsEmpty) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Cor n?o informado');

   if (KM < 0) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('KM n?o informado');

   if (CAMBIO.IsEmpty) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('C?mbio n?o informado');

   if (COMBUSTIVEL.IsEmpty) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Combust?vel n?o informado');

   if (VALOR <= 0) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Valor n?o informado');

   if (VALOR <= 0) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Valor n?o informado');

   if (URL_FOTO.IsEmpty) AND MatchStr(operacao,['Adicionar']) then
      raise Exception.Create('Foto n?o informado');
end;

procedure TCarro.Adicionar;
var
   qry: TFDQuery;
   json: TJSONObject;
begin
   Validate('Adicionar');

   try
      qry            := TFDQuery.Create(nil);
      qry.Connection := FConn;

      with qry do
      begin
         Active := False;
         SQL.Clear;
         SQL.Add('INSERT INTO TAB_CARRO(FABRICANTE, MODELO, DETALHES, ANO_FABRICACAO, ');
         SQL.Add('ANO_MODELO, COR, VALOR, KM, CAMBIO, COMBUSTIVEL, CIDADE, ');
         SQL.Add('UF, IND_TROCA, URL_FOTO, CONTATO, TELEFONE)');
         SQL.Add('VALUES(:FABRICANTE, :MODELO, :DETALHES, :ANO_FABRICACAO, ');
         SQL.Add(':ANO_MODELO, :COR, :VALOR, :KM, :CAMBIO, :COMBUSTIVEL, :CIDADE,');
         SQL.Add(':UF, :IND_TROCA, :URL_FOTO, :CONTATO, :TELEFONE);');
         SQL.Add('SELECT last_insert_rowid() AS ID_CARRO;');

         ParamByName('FABRICANTE').Value     := FABRICANTE;
         ParamByName('MODELO').Value         := MODELO;
         ParamByName('DETALHES').Value       := DETALHES;
         ParamByName('ANO_FABRICACAO').Value := ANO_FABRICACAO;
         ParamByName('ANO_MODELO').Value     := ANO_MODELO;
         ParamByName('COR').Value            := COR;
         ParamByName('VALOR').Value          := VALOR;
         ParamByName('KM').Value             := KM;
         ParamByName('CAMBIO').Value         := CAMBIO;
         ParamByName('COMBUSTIVEL').Value    := COMBUSTIVEL;
         ParamByName('CIDADE').Value         := CIDADE;
         ParamByName('UF').Value             := UF;
         ParamByName('IND_TROCA').Value      := IND_TROCA;
         ParamByName('URL_FOTO').Value       := URL_FOTO;
         ParamByName('CONTATO').Value        := CONTATO;
         ParamByName('TELEFONE').Value       := TELEFONE;

         Active := True;

         ID_CARRO := FieldByName('ID_CARRO').AsInteger;
      end;

   finally
      qry.DisposeOf
   end;
end;

end.
