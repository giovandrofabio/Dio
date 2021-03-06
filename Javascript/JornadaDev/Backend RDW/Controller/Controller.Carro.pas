unit Controller.Carro;

interface

uses System.JSON,
     System.Classes,
     System.SysUtils,
     ServerUtils,
     uDWConsts,
     uDWJSONObject,
     Controller.Comum,
     DAO.Carro;

procedure RegistrarRotas;

procedure ListarCarros(Sender: TObject; RequestHeader: TStringList;
                     Const Params: TDWParams; Var ContentType: String;
                     Var Result: String; Const RequestType: TRequestType;
                     Var StatusCode: Integer; Var ErrorMessage: String;
                     Var OutCustomHeader : TStringList);

procedure CadastrarCarro(Sender: TObject; RequestHeader: TStringList;
                     Const Params: TDWParams; Var ContentType: String;
                     Var Result: String; Const RequestType: TRequestType;
                     Var StatusCode: Integer; Var ErrorMessage: String;
                     Var OutCustomHeader : TStringList);

procedure RotasCarros(Sender: TObject; RequestHeader: TStringList;
                     Const Params: TDWParams; Var ContentType: String;
                     Var Result: String; Const RequestType: TRequestType;
                     Var StatusCode: Integer; Var ErrorMessage: String;
                     Var OutCustomHeader : TStringList);

implementation

uses UnitPrincipal;

procedure RegistrarRotas;
begin
    FrmPrincipal.RESTDWServerQXID.AddUrl('carros', [crGet, crPost], RotasCarros, true);
end;

procedure RotasCarros(Sender: TObject; RequestHeader: TStringList;
                     Const Params: TDWParams; Var ContentType: String;
                     Var Result: String; Const RequestType: TRequestType;
                     Var StatusCode: Integer; Var ErrorMessage: String;
                     Var OutCustomHeader : TStringList);
begin
    case RequestType of
        rtGet: ListarCarros(Sender, RequestHeader, Params, ContentType, Result,
                            RequestType, StatusCode, ErrorMessage, OutCustomHeader);

        rtPost: CadastrarCarro(Sender, RequestHeader, Params, ContentType, Result,
                               RequestType, StatusCode, ErrorMessage, OutCustomHeader);
    end;
end;

procedure ListarCarros(Sender: TObject; RequestHeader: TStringList;
                     Const Params: TDWParams; Var ContentType: String;
                     Var Result: String; Const RequestType: TRequestType;
                     Var StatusCode: Integer; Var ErrorMessage: String;
                     Var OutCustomHeader : TStringList);
var
    car: TCarro;
    busca: string;
    jsonArray: TJSONArray;
begin
     try
        try
            car := TCarro.Create;

            try
                busca := Params.ItemsString['busca'].AsString; //  http://localhost:8082/carros?busca=Sport
            except
                busca := '';
            end;

            try
                car.id_carro := Params.ItemsString['0'].AsInteger; // http://localhost:8082/carros/29
            except
                car.id_carro := 0;
            end;

            jsonArray := car.Listar(busca);

            if jsonArray.Size = 0 then
                StatusCode := 404;

            Result := jsonArray.ToJSON;
            jsonArray.DisposeOf;

        except on ex:exception do
            begin
                Result := CreateJsonObjStr('erro', ex.Message);
                StatusCode := 500;
            end;
        end;
    finally
        car.Free;
    end;
end;

procedure CadastrarCarro(Sender: TObject; RequestHeader: TStringList;
                     Const Params: TDWParams; Var ContentType: String;
                     Var Result: String; Const RequestType: TRequestType;
                     Var StatusCode: Integer; Var ErrorMessage: String;
                     Var OutCustomHeader : TStringList);
var
    car : TCarro;
    body : System.JSON.TJsonValue;
begin
    try
        try
            car := TCarro.Create;

            body               := ParseBody(Params.RawBody.AsString);
            car.FABRICANTE     := body.GetValue<string>('fabricante', '');
            car.MODELO         := body.GetValue<string>('modelo', '');
            car.DETALHES       := body.GetValue<string>('detalhes', '');
            car.ANO_FABRICACAO := body.GetValue<integer>('ano_fabricacao', 0);
            car.ANO_MODELO     := body.GetValue<integer>('ano_modelo', 0);
            car.COR            := body.GetValue<string>('cor', '');
            car.VALOR          := body.GetValue<double>('valor', 0);
            car.KM             := body.GetValue<integer>('km', 0);
            car.CAMBIO         := body.GetValue<string>('cambio', '');
            car.COMBUSTIVEL    := body.GetValue<string>('combustivel', '');
            car.CIDADE         := body.GetValue<string>('cidade', '');
            car.UF             := body.GetValue<string>('uf', '');
            car.IND_TROCA      := body.GetValue<string>('ind_troca', '');
            car.URL_FOTO       := body.GetValue<string>('url_foto', '');
            car.CONTATO        := body.GetValue<string>('contato', '');
            car.TELEFONE       := body.GetValue<string>('telefone', '');
            body.DisposeOf;

            car.Adicionar;

            Result     := CreateJsonObjStr('id_carro', car.ID_CARRO);
            StatusCode := 201;

        except on ex:exception do
            begin
                Result     := CreateJsonObjStr('erro', ex.Message);
                StatusCode := 500;
            end;
        end;

    finally
        car.Free;
    end;
end;

end.
