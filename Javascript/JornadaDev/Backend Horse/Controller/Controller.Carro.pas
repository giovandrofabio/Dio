unit Controller.Carro;

interface

uses Horse,
     System.JSON,
     System.SysUtils,
     Controller.Comum,
     DAO.Carro;

procedure RegistrarRotas;
procedure ListarCarros(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure ListarCarrosId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure CadastrarCarro(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure RegistrarRotas;
begin
   THorse.Get('/carros', ListarCarros);
   THorse.Get('/carros/:id_carro', ListarCarrosId);
   THorse.Post('/carros', CadastrarCarro);
end;

procedure ListarCarros(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   car: TCarro;
   busca: string;
begin
   try
      try
         car := TCarro.Create;

         try
            busca := Req.Query.Items['busca'];
         except
            busca := '';
         end;

         Res.Send<TJSONArray>(car.Listar(busca));
      except on ex:Exception do
         Res.Send<TJSONArray>(TJSONArray.Create).status(500);
      end;

   finally
      car.Free;
   end;
end;

procedure ListarCarrosId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   car: TCarro;
   JsonArray: TJSONArray;
begin
   try
      try
         car := TCarro.Create;

         try
            car.ID_CARRO := Req.Params.Items['id_carro'].ToInteger;
         except
            car.ID_CARRO := 99999;
         end;

         JsonArray := car.Listar('');

         if JsonArray.Size > 0 then
            Res.Send<TJSONArray>(JsonArray)
         else
            Res.Send<TJSONArray>(JsonArray).Status(THTTPStatus.NotFound);

      except on ex:Exception do
         Res.Send<TJSONArray>(TJSONArray.Create).status(THTTPStatus.InternalServerError);
      end;

   finally
      car.Free;
   end;
end;

procedure CadastrarCarro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   car: TCarro;
   body: TJSONValue;
begin
   try
      try
         car                := TCarro.Create;
         body               := Req.Body<TJSONObject>;
         car.FABRICANTE     := body.GetValue<string>('fabricante','');
         car.MODELO         := body.GetValue<string>('modelo','');
         car.DETALHES       := body.GetValue<string>('detalhes','');
         car.ANO_FABRICACAO := body.GetValue<Integer>('ano_fabricacao',0);
         car.ANO_MODELO     := body.GetValue<Integer>('ano_modelo',0);
         car.COR            := body.GetValue<string>('cor','');
         car.VALOR          := body.GetValue<Double>('valor',0);
         car.KM             := body.GetValue<Integer>('km',0);
         car.CAMBIO         := body.GetValue<string>('cambio','');
         car.COMBUSTIVEL    := body.GetValue<string>('combustivel','');
         car.CIDADE         := body.GetValue<string>('cidade','');
         car.UF             := body.GetValue<string>('uf','');
         car.IND_TROCA      := body.GetValue<string>('ind_troca','');
         car.URL_FOTO       := body.GetValue<string>('url_foto','');
         car.CONTATO        := body.GetValue<string>('contato','');
         car.TELEFONE       := body.GetValue<string>('telefone','');

         car.Adicionar;

         Res.Send<TJSONObject>(CreateJsonObj('id_carro', car.ID_CARRO)).Status(THTTPStatus.Created);
      Except on ex:Exception do
         Res.Send<TJSONObject>(CreateJsonObj('erro', ex.Message)).Status(THTTPStatus.InternalServerError);
      end;

   finally
      car.Free
   end;
end;

end.
