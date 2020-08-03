unit Computers;

interface

type
  TComputer = class
    Memory: Word;
  end;

  THardDrive = class;
  TSizeScale = (ssB, ssKB, ssMB, ssGB, ssTB);
  TComputerBuild = class
  private
    fDisplayedMemory: string;
    procedure killAllPrograms;
  protected

  public
    HardDrive: THardDrive;
    Memory: Word;

    constructor CreateWithHD(const aHardDrive: THardDrive);
    destructor Destroy; override;
    procedure shutDown;
    procedure add(const aUser: string); overload;
    procedure add(const aHD: THardDrive); overload;
  published
//    MemoryScale: string;
  end;

  THardDrive = class
  private
    fManufacturer: string;
    fSerial: string;
    fContent: array[0..1000, 0..10000] of Byte;
    function getContent(Cylinder, Sector: Word): byte;
    function getSerial: String;
    procedure setContent(Cylinder, Sector: Word; const Value: byte);
    procedure setSerial(const Value: String);
  public
    Capacity: Word;
    HostComputer: TComputerBuild;

    constructor Create;
    property Content[Cylinder, Sector: Word]: byte read getContent write setContent;
    property Manufacturer: string read fManufacturer write fManufacturer;
    property Serial: String read getSerial write setSerial;
  end;

implementation

uses
  SysUtils;

constructor TComputerBuild.CreateWithHD(const aHardDrive: THardDrive);
begin
  inherited Create;
  // Add more initialisation code here
end;

destructor TComputerBuild.Destroy;
begin
  // Add code here
  inherited;
end;

{ TComputerBuild }

procedure TComputerBuild.add(const aHD: THardDrive);
begin

end;

procedure TComputerBuild.add(const aUser: string);
begin

end;

procedure TComputerBuild.killAllPrograms;
begin
  writeln('All applications exited');
end;

procedure TComputerBuild.shutDown;
begin
  killAllPrograms;
  // Now shut the computer down
  writeln('Shutting down computer...');
  Writeln('Computer is off');
end;

constructor THardDrive.Create;
var
  cyl: Integer;
  sec: integer;
begin
  inherited;
  Randomize;
  for cyl := Low(fContent) to High(fContent) do
    for sec := Low(fContent[cyl]) to High(fContent[cyl]) do
      fContent[cyl, sec]:=Random(255);
end;

function THardDrive.getContent(Cylinder, Sector: Word): byte;
begin
  // Note that there is no check of boundary values for fContent
  Result:=fContent[Cylinder, Sector];
end;

function THardDrive.getSerial: String;
begin
  result:=fSerial;
end;

procedure THardDrive.setContent(Cylinder, Sector: Word; const Value: byte);
begin
  // Note that there is no check of boundary values for fContent
  fContent[Cylinder, Sector]:=Value;
end;

procedure THardDrive.setSerial(const Value: String);
begin
  fSerial:=Value.ToLower;
end;

end.
