program Chapter03;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.StrUtils;

var
  whileControl: Integer;
  forControl: Integer;
  forINControl: Integer;

  forArray: array[0..9] of Integer = (10,20,30,40,50,60,70,80,90,100);
  forArrayDyn: array of Integer;

  grade: Integer;
  loopVar: Integer;

label
  outsideWhile;
begin
  // While
  Writeln('----- While --------------------------------------------------');
  whileControl:=0;
  while whileControl <=10 do
  begin
    writeln(whileControl);
    whileControl:=whileControl + 1;
  end;
  Writeln('--------------------------------------------------------------');

  // Repeat
  Writeln('----- Repeat -------------------------------------------------');
  whileControl:=0;
  repeat
    writeln(whileControl);
    whileControl:=whileControl + 1;
  until whileControl<=10;
  Writeln('--------------------------------------------------------------');

  whileControl:=0;
  repeat
    writeln(whileControl);
    whileControl:=whileControl + 1;
  until whileControl>=10;

  Writeln('--------------------------------------------------------------');

  // For
  Writeln('----- For ----------------------------------------------------');
  for forControl := 1 to 10 do
    Writeln(forControl);
  Writeln('--------------------------------------------------------------');

  for var newForControl := 1 to 10 do
    Writeln(newForControl);
  Writeln('--------------------------------------------------------------');

  for forControl := 10 downto 1 do
    Writeln(forControl);
  Writeln('--------------------------------------------------------------');

  for forControl := 0 to Length(forArray)-1 do
    Writeln(forArray[forControl]);
  Writeln('--------------------------------------------------------------');

  for forINControl in forArray do
    Writeln(forINControl);
  Writeln('--------------------------------------------------------------');

  for var newForINControl in forArray do
    Writeln(newForINControl);
  Writeln('--------------------------------------------------------------');

  // If
  Writeln('----- If -----------------------------------------------------');

  grade:=10;
  if grade > 5 then
    Writeln('Greater than 5')
  else
    Writeln('Less than 5');

  if grade > 5 then
  begin
    Writeln('Greater than 5');
    Writeln('You pass');
  end;

  if grade > 5 then
  begin
    Writeln('Greater than 5');
    Writeln('You pass');
  end
  else
    Writeln('You fail');

  if grade > 5 then
  begin
    Writeln('Greater than 5');
    Writeln('You pass');
  end
  else
  begin
    if grade = 5 then
      Writeln('This is borderline pass')
    else
      if grade >=3 then
        Writeln('This can be improved easily')
      else
        Writeln('This is of very poor quality');
  end;
  Writeln('--------------------------------------------------------------');
  Writeln('----- Case ---------------------------------------------------');
  case grade of
    0..2: Writeln('This is of very poor quality');
    3..4: Writeln('This can be improved easily');
       5: Writeln('This is borderline pass');
  else
    begin
      Writeln('Greater than 5');
      Writeln('You pass');
    end;
  end;

  case IndexStr('Pass', ['Fail', 'Pass', 'Honors']) of
    0: Writeln('You fail');
    1: Writeln('You pass');
    2: Writeln('You pass with honors');
  end;

  Writeln('--------------------------------------------------------------');

  Writeln('----- Exit ---------------------------------------------------');
  // *** Setting grade to 5 will terminate the program and you ***
  // *** will the rest of the code will not be executed ***
  grade:=3; // or, grade:=5 to make the code exit
  if grade = 5 then
    Exit;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Break ---------------------------------------------------');
  loopVar:=0;
  while loopVar<=10 do
  begin
    if loopVar = 3 then
      Break;
    loopVar:=loopVar + 1;
  end;
  Writeln(loopVar);
  Writeln('--------------------------------------------------------------');

  Writeln('----- Continue ------------------------------------------------');
  loopVar:=0;
  while loopVar<=10 do
  begin
    loopVar:=loopVar + 1;
    if loopVar = 3 then
      Continue;
    Writeln(loopVar);
  end;
  Writeln('--------------------------------------------------------------');

  Writeln('----- Goto ----------------------------------------------------');
  loopVar:=0;
  while loopVar<=10 do
  begin
    loopVar:=loopVar + 1;
    if loopVar = 3 then
      goto outsideWhile;
    Writeln(loopVar);
  end;
outsideWhile:
  writeln('Now outside while with a goto statement');
  Writeln('--------------------------------------------------------------');

  Writeln;
  Writeln('Press Enter to exit...');
  Readln;
end.
