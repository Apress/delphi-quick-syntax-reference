unit Applications;

interface

type
  TOSList = array[0..2] of string;
  TApplicationType = (atUndefined, atFinancial, atGame, atUtility);
  TCustomApplication = class
  private
    class function getSupportedOS: TOSList; static;
  public
    class property SupportedOS: TOSList read getSupportedOS;
  end;

  TBaseApplication = class (TCustomApplication)
  private
    fAppType: TApplicationType;
  protected
    function getVersion: string; virtual;
  public
    constructor Create; virtual;

    property AppType: TApplicationType read fAppType write fAppType;
    property Version: string read getVersion;
  end;

  TFinApplication = class (TBaseApplication)
  protected
    function getVersion: string; override;
  public
    constructor Create; override;
  end;

  TGameApplication = class (TBaseApplication)
  private
    fMultiPlayer: boolean;
  protected
    function getVersion: string; override;
  public
    constructor Create; override;
    property MultiPlayer: boolean read fMultiPlayer write fMultiPlayer;
  end;

implementation

class function TCustomApplication.getSupportedOS: TOSList;
begin
  Result[0]:='Windows 7';
  Result[1]:='Windows 8';
  Result[2]:='Windows 10';
end;

constructor TBaseApplication.Create;
begin
  inherited;
  fAppType:=atUndefined;
end;

function TBaseApplication.getVersion: string;
begin
  Result := '0.0.0';
end;

constructor TFinApplication.Create;
begin
  inherited;
  fAppType:=atFinancial;
end;

function TFinApplication.getVersion: string;
begin
  Result:='3.2.2-alpha';
end;

constructor TGameApplication.Create;
begin
  inherited;
  AppType:=atGame;
  fMultiPlayer:=true;
end;

function TGameApplication.getVersion: string;
begin
  Result:='1.0.0';
end;

end.
