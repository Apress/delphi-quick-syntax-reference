program Chapter04;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  UnitWithRoutines in 'UnitWithRoutines.pas',
  TypedMethods in 'TypedMethods.pas';

procedure simpleProc;
begin
  Writeln('This is the simplest procedure ever');
end;

function isNetworkAvailable: Boolean;
begin
  // Use some code to determine if network is available
  Result:=true; // or false
end;

procedure canVote(age: Integer);
begin
  if age <18 then
    Writeln('Can not vote')
  else
    Writeln('All good! The person can vote');
end;

procedure updateLogs(logMessage: string);
begin
  // Normally you have some more sophisticated log container
  // This simple implementation is for demonstration
  Writeln(logMessage);
end;

function getLanguage(country: string): string;
begin
  if country = 'UK' then
    Result:='English';
end;

procedure add100Classic(value: integer);
begin
  value:=value + 100;
  writeln('Classic: The value in the procedure is ', value);
end;

procedure add100Const(const value: integer);
begin
//  value:=value + 100;   // This does not compile
  writeln('Const: The value in the procedure is ', value);
end;

procedure add100Var(var value: integer);
begin
  value:=value + 100;
  writeln('Var: The value in the procedure is ', value);
end;

procedure add100ToString(out value: string);
begin
  value:=value + '100';
  writeln('Out: The value in the procedure is ', value);
end;

function addValue(const Value: integer; const Increment: integer = 100): Integer;
begin
  result:=Value + Increment;
end;

function moreThanOneDefault(const Value: integer; const Iterations: Integer = 3;
                             const Increment: integer = 100): integer;
var
  num: Integer;
begin
  Result:=Value;
  for num := 1 to Iterations do
    Result:=result + Increment;
end;

function calculateAverage(const Values: array of Integer): double;
  function calculateSum: Integer;
  var
    num: Integer;
  begin
    Result:=0;
    for num := 0 to Length(Values) - 1 do
      Result:=Result + Values[num];
  end;
begin
  if Length(Values) > 1 then
    result:=calculateSum / Length(Values)
  else
    Result:=0.00;
end;

var
  value: integer;
  valueStr: string;
  netExists: Boolean;
begin
  Writeln('----- Simple Procedures --------------------------------------');
  simpleProc;
  simpleProcInAUnit;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Functions ----------------------------------------------');
  netExists:=isNetworkAvailable;
  if isNetworkAvailable then
    writeln('Network is available')
  else
    Writeln('There is no network available');

  Writeln('Calling a function without return value');
  isNetworkAvailable;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Parameters ---------------------------------------------');
  canVote(16);
  canVote(20);
  updateLogs('This is logged message');
  Writeln(getLanguage('UK'));
  Writeln('--------------------------------------------------------------');

  Writeln('----- Classic Parameters --------------------------------------');
  value:=100;
  add100Classic(value);
  writeln('Classic: The value in the main block is ', value);
  Writeln('--------------------------------------------------------------');

  Writeln('----- Var Parameters -----------------------------------------');
  value:=200;
  add100Var(value);
  writeln('Var: The value in the main block is ', value);
  Writeln('--------------------------------------------------------------');

  Writeln('----- Out Parameters -----------------------------------------');
  valueStr:='300';
  writeln('Out: The value  in the main block before the procedure is ', valueStr);
  add100ToString(valueStr);
  writeln('Out: The value in the main block is ', valueStr);
  Writeln('--------------------------------------------------------------');

  Writeln('----- Default Values -----------------------------------------');
  Writeln('Default increment of 100 to 200: ', addValue(200));
  Writeln('Custom increment of 500 to 200: ', addValue(200, 500));

  Writeln('Default increment of 100 for 3 iterations: ', moreThanOneDefault(0));
  Writeln('Custom increment of 500 for default iterations: ', moreThanOneDefault(0, 3, 500));
  Writeln('--------------------------------------------------------------');

  Writeln('----- Exit ---------------------------------------------------');
  Writeln('A call to the exitFunc returns: '+exitFunc);
  Writeln('--------------------------------------------------------------');

  Writeln('----- Nested Procedure ------------------------------------');
  Writeln('The average of the first 5 numbers is ', calculateAverage([1, 2, 3, 4, 5]));
  Writeln('--------------------------------------------------------------');

  Writeln('----- Typed Methods ------------------------------------------');
  calculateTaxes;
  showMenu;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Anonymous Procedure ------------------------------------');
  anonMethod;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Anonymous Function -------------------------------------');
  anonFunc;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Anonymous Function with Param---------------------------');
  anonFuncWithParam(function (const switch: string): string
                    begin
                      Writeln('The current swith state is: '+switch);
                    end);
  Writeln('--------------------------------------------------------------');

  Writeln('----- Overloading --------------------------------------------');
  multiProc;
  multiProc('Test');
  multiProc('Test', 1000);
  Writeln('--------------------------------------------------------------');

  Writeln;
  Writeln('Press Enter to exit...');
  Readln;
end.
