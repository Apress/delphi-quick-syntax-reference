program Chapter05;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Computers in 'Computers.pas',
  Applications in 'Applications.pas',
  Passwords in 'Passwords.pas';

function convertAppType(const aType: TApplicationType): string;
begin
  case aType of
    atUndefined: result:='The application type has not been defined yet';
    atFinancial: result:='Financial Application';
    atGame: Result:='Game';
    atUtility: Result:='Utility';
  end;
end;

var
  myComputer: TComputer;
  buildComputer: TComputerBuild;
  hardDrive: THardDrive;
  os: string;
  app: TBaseApplication;
  generatorAES: IPasswordGenerator;
  generatorSHA: IPasswordGenerator;
  password: IPassword;
begin
  Writeln('----- Simple Object-------------------------------------------');
  myComputer:=TComputer.Create;
  // use myComputer here
  myComputer.Free;

  // This works only in 10.3 and above
  var mainComputer:=TComputer.Create;
  // use myComputer here
  mainComputer.Free;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Fields and Properties-----------------------------------');
  myComputer:=TComputer.Create;
  myComputer.Memory:=32;
  Writeln('Computer memory: ', myComputer.Memory);
  myComputer.Free;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Methods ------------------------------------------------');
  buildComputer:=TComputerBuild.Create;
//   This does not compile
//  buildComputer.killAllPrograms;
  buildComputer.shutDown;
  buildComputer.Free;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Overloading --------------------------------------------');
  hardDrive:=THardDrive.Create;
  buildComputer:=TComputerBuild.Create;
  buildComputer.add('DESKTOP-67JKU');
  buildComputer.add(hardDrive);
  hardDrive.Free;
  buildComputer.Free;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Constructor Overloading --------------------------------');
  hardDrive:=THardDrive.Create;
  buildComputer:=TComputerBuild.CreateWithHD(hardDrive);
  hardDrive.Free;
  buildComputer.Free;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Properties ---------------------------------------------');
  hardDrive:=THardDrive.Create;
  hardDrive.Serial:='XHHJU-56748-ABC';
  Writeln(hardDrive.Serial);
  Writeln(hardDrive.Content[100, 100]);
  hardDrive.Free;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Class Members and Methods ------------------------------');
  for os in TCustomApplication.SupportedOS do
    writeln(os);
  Writeln('--------------------------------------------------------------');

  Writeln('----- Inheritance --------------------------------------------');
  app:=TBaseApplication.Create;
  writeln(convertAppType(app.AppType));
  Writeln(app.Version);
  app.Free;

  app:=TFinApplication.Create;
  writeln(convertAppType(app.AppType));
  Writeln(app.Version);
  app.Free;

  app:=TGameApplication.Create;
  writeln(convertAppType(app.AppType));
  Writeln(app.Version);
  if app is TGameApplication then
    writeln('MultiPlayer: ', (app as TGameApplication).MultiPlayer);
  app.Free;

  Writeln('--------------------------------------------------------------');

  Writeln('----- Interfaces ---------------------------------------------');
  generatorAES:=TAESAlgorithm.Create;
  generatorSHA:=TSHAAlgorithm.Create;

  password:=TPassword.Create(generatorAES);
  writeln(password.encryptPassword('tywqeri'));

  password:=TPassword.Create(generatorSHA);
  Writeln(password.encryptPassword('435'));

  if Supports(password, IPassword) then
    Writeln('Interface is supported')
  else
    Writeln('Interface is not supported');
  Writeln('--------------------------------------------------------------');

  Writeln;
  Writeln('Press Enter to exit...');
  Readln;
end.
