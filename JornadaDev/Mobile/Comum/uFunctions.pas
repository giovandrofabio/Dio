unit uFunctions;

interface

uses
  System.Net.HttpClientComponent, FMX.Graphics, System.Classes,
  System.SysUtils, System.Net.HttpClient, System.JSON, Data.DB,
  FMX.ListView.Types, FMX.TextLayout, System.Types, FMX.StdCtrls;


procedure LoadImageFromURL(img: TBitmap; url: string);
procedure LoadBitmapFromBlob(Bitmap: TBitmap; Blob: TBlobField);
function GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
function GetLabelHeight(const L: TLabel; const Width: single): Integer;
function RetornoJsonObject(json, pair: string): string;
function Round2(aValue:double):double;
function iif(condicao: boolean; result1, result2: string): string; overload;
function iif(condicao: boolean; result1, result2: integer): integer; overload;
function iif(condicao: boolean; result1, result2: boolean): boolean; overload;
function ifEmpty(value: string; result2: string): string; overload;
function FormataData(dt: string): string;

implementation

procedure LoadImageFromURL(img: TBitmap; url: string);
var
    http : TNetHTTPClient;
    vStream : TMemoryStream;
begin
    try
        try
            http := TNetHTTPClient.Create(nil);
            vStream :=  TMemoryStream.Create;

            if (Pos('https', LowerCase(url)) > 0) then
                  HTTP.SecureProtocols  := [THTTPSecureProtocol.TLS1,
                                            THTTPSecureProtocol.TLS11,
                                            THTTPSecureProtocol.TLS12];

            http.Get(url, vStream);
            vStream.Position  :=  0;


            img.LoadFromStream(vStream);
        except
        end;

    finally
        vStream.DisposeOf;
        http.DisposeOf;
    end;
end;

procedure LoadBitmapFromBlob(Bitmap: TBitmap; Blob: TBlobField);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    Blob.SaveToStream(ms);
    ms.Position := 0;
    Bitmap.LoadFromStream(ms);
  finally
    ms.Free;
  end;
end;

function GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
var
  Layout: TTextLayout;
begin
  // Create a TTextLayout to measure text dimensions
  Layout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    Layout.BeginUpdate;
    try
      // Initialize layout parameters with those of the drawable
      Layout.Font.Assign(D.Font);
      Layout.VerticalAlign := D.TextVertAlign;
      Layout.HorizontalAlign := D.TextAlign;
      Layout.WordWrap := D.WordWrap;
      Layout.Trimming := D.Trimming;
      Layout.MaxSize := TPointF.Create(Width, TTextLayout.MaxLayoutSize.Y);
      Layout.Text := Text;
    finally
      Layout.EndUpdate;
    end;
    // Get layout height
    Result := Round(Layout.Height);
    // Add one em to the height
    Layout.Text := 'm';
    Result := Result + Round(Layout.Height);
  finally
    Layout.Free;
  end;
end;

function GetLabelHeight(const L: TLabel; const Width: single): Integer;
var
  Layout: TTextLayout;
begin
  // Create a TTextLayout to measure text dimensions
  Layout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    Layout.BeginUpdate;
    try
      // Initialize layout parameters with those of the drawable
      Layout.Font.Assign(L.Font);
      Layout.VerticalAlign := L.TextSettings.VertAlign;
      Layout.HorizontalAlign := L.TextSettings.HorzAlign;
      Layout.WordWrap := L.WordWrap;
      Layout.Trimming := L.Trimming;
      Layout.MaxSize := TPointF.Create(Width, TTextLayout.MaxLayoutSize.Y);
      Layout.Text := L.Text;
    finally
      Layout.EndUpdate;
    end;

    // Get layout height
    Result := Round(Layout.Height);

    // Add one em to the height
    //Layout.Text := 'm';
    //Result := Result + Round(Layout.Height);
  finally
    Layout.Free;
  end;
end;

function RetornoJsonObject(json, pair: string): string;
var
    jsonObj: TJSONObject;
begin
    Result := '';

    try
        jsonObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONObject;
        Result := jsonObj.GetValue<string>(pair, '');
        jsonObj.DisposeOf;
    except
    end;
end;

function iif(condicao: boolean; result1, result2: string): string;
begin
    if condicao then
        Result := result1
    else
        Result := result2;
end;

function iif(condicao: boolean; result1, result2: integer): integer;
begin
    if condicao then
        Result := result1
    else
        Result := result2;
end;

function iif(condicao: boolean; result1, result2: boolean): boolean;
begin
    if condicao then
        Result := result1
    else
        Result := result2;
end;

function Round2(aValue:double):double;
begin
  Round2:=Round(aValue*100)/100;
end;

// Formato: 2021-10-09T14:11:28.877Z
function FormataData(dt: string): string;
begin
    Result := Copy(dt, 9, 2) + '/' + Copy(dt, 6, 2) + '/' + Copy(dt, 1, 4) + ' ' + Copy(dt, 12, 5);
end;

function ifEmpty(value: string; result2: string): string;
begin
    if value.IsEmpty then
        Result := result2
    else
        Result := value;
end;

end.
