unit Passwords;

interface

type
  TPasswordAlgorithm = (paAES, paSHA);
  IPasswordGenerator = interface
    ['{16C5CD04-5051-4557-BA3C-3AE932147C6A}']
    function getAlgorithm: TPasswordAlgorithm;
    function encrypt (const aValue: string): string;

    property Algorithm: TPasswordAlgorithm read getAlgorithm;
  end;

  IPassword = interface
    ['{6C85FF1F-C5BC-4E66-974D-1622A6F908A7}']
    function encryptPassword (const aPassword: string): string;
  end;

  TAESAlgorithm = class (TInterfacedObject, IPasswordGenerator)
  private
    fAlgorithm: TPasswordAlgorithm;
  public
    constructor Create;
    function encrypt (const aValue: string): string;
    function getAlgorithm: TPasswordAlgorithm;
  end;

  TSHAAlgorithm = class (TInterfacedObject, IPasswordGenerator)
  private
    fAlgorithm: TPasswordAlgorithm;
  {$REGION 'MyRegion'}
    function encrypt (const aValue: string): string;
    function getAlgorithm: TPasswordAlgorithm;
  {$ENDREGION}
  public
    constructor Create;
  end;

  TPassword = class (TInterfacedObject, IPassword)
  private
    fGenerator: IPasswordGenerator;
  public
    constructor Create(const aAlgorithm: IPasswordGenerator);
    function encryptPassword (const aPassword: string): string;
  end;

implementation

constructor TAESAlgorithm.Create;
begin
  inherited;
  fAlgorithm:=paAES;
end;

function TAESAlgorithm.encrypt(const aValue: string): string;
begin
  // use AES algorithm
  Result:=aValue+' - AES Encrypted';
end;

function TAESAlgorithm.getAlgorithm: TPasswordAlgorithm;
begin
  Result:=fAlgorithm;
end;

{ TSHAAlgorithm }

constructor TSHAAlgorithm.Create;
begin
  inherited;
  fAlgorithm:=paSHA;
end;

function TSHAAlgorithm.encrypt(const aValue: string): string;
begin
  // use SHA algorithm
  Result:=aValue+' - SHA Encrypted';
end;

function TSHAAlgorithm.getAlgorithm: TPasswordAlgorithm;
begin
  Result:=fAlgorithm;
end;

constructor TPassword.Create(const aAlgorithm: IPasswordGenerator);
begin
  inherited Create;
  fGenerator:=aAlgorithm;
end;

function TPassword.encryptPassword (const aPassword: string): string;
begin
  Result:=fGenerator.encrypt(aPassword);
end;

end.
