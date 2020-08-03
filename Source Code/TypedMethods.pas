unit TypedMethods;

interface

type
  TTaxFunc = function (const Amount: Double): Double;
  TMenuProc = procedure;
  TAnonProc = reference to procedure;
  TAnonFunc = reference to function (const switch: string): string;

function exitFunc: string;
procedure calculateTaxes;
procedure showMenu;
procedure anonMethod;
procedure anonFunc;
procedure anonFuncWithParam(const func: TAnonFunc);
procedure multiProc; overload;
procedure multiProc(const Value: string); overload;
//This overloading approach does not work
//procedure multiProc(var Value: string); overload;
procedure multiProc(const Value: string; const SubElement: integer); overload;

implementation

uses
  System.Math, System.Types, System.SysUtils;

// *********************
// The bands and the rates are fictional - for demonstration only
// *********************

function taxUK(const Amount: Double): Double;
begin
  Result:=0.00;
  if CompareValue(Amount, 10001) = LessThanValue then
    Result:=Amount * 0.10
  else
    if CompareValue(Amount, 50001) = LessThanValue  then
    begin
      Result:=10000 * 0.10;
      Result:=Result + (Amount - 10000) * 0.30;
    end
    else
    begin
      Result:=10000 * 0.10;
      Result:=Result + 50000 * 0.30;
      Result:=Result + (Amount - 60000) * 0.50;
    end;
end;

function taxItaly(const Amount: Double): Double;
begin
  Result:=0.00;
  if CompareValue(Amount, 100001) = LessThanValue  then
  begin
    Result:=100000 * 0.40
  end
  else
  begin
    Result:=100000 * 0.40;
    Result:=Result + (Amount - 100000) * 0.50;
    Result:=Result * 1.15;
  end;
end;

function exitFunc: string;
begin
  Exit('Just Exited the Function');
end;

procedure calculateTaxes;
var
  taxFunc: TTaxFunc;
begin
  taxFunc:=taxUK;
  Writeln('For UK: ', format('%8.2f', [taxFunc(80000)]));
  taxFunc:=taxItaly;
  Writeln('For Italy: ', format('%8.2f', [taxFunc(80000)]));
end;

procedure showMainMenu;
begin
  Writeln('1. Option 1');
  Writeln('2. Option 2');
  Writeln('0. Continue');
end;

procedure show1SubMenu;
begin
  Writeln('A. Option 1-A');
  writeln('B. Option 2-B');
end;

procedure showMenu;
var
  menu: TMenuProc;
  option: Integer;
begin
  option:=0;
  menu:=showMainMenu;
  menu();
  Write('Enter 1,2 or 0:');
  readln(option);
  if option = 0 then
    Exit;
  if option = 1 then
  begin
    menu:=show1SubMenu;
    menu;
  end;
end;

procedure anonMethod;
var
  proc: TAnonProc;
begin
  proc:=procedure
        begin
          Writeln('A call from inside an anonymous procedure');
        end;
  proc;
end;

procedure anonFunc;
var
  func: TAnonFunc;
  // Or use a predefined method
  // func: TFunc<string, string>;
  // In this case, you need to remove the keyword const from the definition of
  // func in the code
  temperature: integer;
begin
  func:= function(const switch: string): string
         begin
           Write('The temperature is '+temperature.ToString+' and the heating is '+switch+'. ');
           if temperature <= 24 then
           begin
             if switch='ON' then
               writeln('The room will get warm soon');
             if switch='OFF' then
               writeln('Maybe you need to turn the heating on?');
           end
           else
           begin
             if switch='ON' then
               writeln('This may be getting very hot...');
             if switch='OFF' then
               writeln('Nice...you save energy and help the environment');
           end;
         end;

  Randomize;
  for temperature := 16 to 28 do
  begin
    if Random(100) < 50 then
      func('ON')
    else
      func('OFF');
  end;
end;

procedure anonFuncWithParam(const func: TAnonFunc);
begin
  func('INTERMEDIATE SWITCH STATE');
end;

procedure multiProc; overload;
begin
  // For demonstration only
end;

procedure multiProc(const Value: string); overload;
begin
  // For demonstration only
end;

procedure multiProc(const Value: string; const SubElement: integer); overload;
begin
  // For demonstration only
end;

end.
