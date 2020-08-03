program Chapter02;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.TypInfo,
  System.Types;

type
  TChapter = (cChapter01, cChapter02, cChapter3, cChapter4);
  TChaptersRead = set of TChapter;

  TPermission = (pCreate, pRead, pUpdate, pDelete);
  TGroup = set of TPermission;

  TMixedArray = array[0..9] of array of string;

  TBookFormat = (bfHardCopy, bfPDF);
  TBook = record
    Title: string;
    Pages: Integer;
    case Format: TBookFormat of
      bfHardCopy: (InStock: Boolean);
      bfPDF: (DownloadURL: string[100]);
  end;

  TRandomPassword = record
    Password: string;
  public
    constructor Create (const aSalt: string);
  end;

constructor TRandomPassword.Create(const aSalt: string);
begin
  inherited;
  Password:=aSalt + '$%HJKFbmnmn';
end;

////////////////////////////////////
///  This compiles only in 10.4  ///
////////////////////////////////////
type
  TRandomPasswordCustom = record
    Password: string;
  public
    class operator Initialize (out Dest: TRandomPasswordCustom);
    class operator Finalize (var Dest: TRandomPasswordCustom);
  end;

class operator TRandomPasswordCustom.Initialize (out Dest: TRandomPasswordCustom);
begin
  Dest.Password:='$%HJKFbmnmn';
end;

class operator TRandomPasswordCustom.Finalize (var Dest: TRandomPasswordCustom);
begin
  Writeln('Record is finalised')
end;
////////////////////////////////////

type
  TLogType<T> = record
    procedure logType;
  end;

procedure TLogType<T>.logType;
begin
  Writeln(GetTypeName(TypeInfo(T)));
end;

const
  PUBLISHER = 'Apress';
  NORMAL_SHIFT = 8;
  EXTENDED_SHIFT = 12;
  WAGE_PER_HOUR = 10;
  NORMAL_DAILY_WAGE = NORMAL_SHIFT * WAGE_PER_HOUR;
  EXTENDED_DAILY_WAGE = EXTENDED_SHIFT * WAGE_PER_HOUR * 1.30;
  CHAPTER_TITLES : array[0..2] of string =
                                       ('Introduction','Chapter 1','Chapter 2');

var
  progress: TChaptersRead;
  admin: TGroup;

  arrStatic: array[0..9] of string;

  arrDual: array[0..9] of array[0..9] of string;
  arrDualAlt: array[0..9, 0..9] of string;

  arrMulti: array[0..9, 0..9, 0..9] of string;

  arrDynamic: array of string;
  arrDynamicMulti: array of array of String;

  arrMixed: array[0..9] of array of string;
  arrMixedReverse: array of array[0..9] of string;
  arrMixedAlt: TMixedArray;

  genArray: TArray<string>;
  arrTyped: System.TArray<string>; // or, arrTyped: TStringDynArray;
  arrTypedDual: System.TArray<TArray<string>>;

  thisBook: TBook;

  password: TRandomPassword;
  customPassword: TRandomPasswordCustom;

  passAddress: Pointer;

  flex: Variant;

  logInteger: TLogType<integer>;
  logString: TLogType<string>;
  logRandomPassword: TLogType<TRandomPassword>;
// Line comment
{ Some other comment}
(* Yet another comment type *)

(* Comments in
             Multiple lines
      { and in multiple levels }
*)


begin
  // Strings
  Writeln('----- Strings ------------------------------------------------');
  Writeln('Delphi''s fantastic world!');
  // *** This works in Delphi 10.3 and above ***
  var s:='Delphi Quick Reference';
  writeln(s[1]);
  Writeln(s[Low(s)]);
  Writeln(Pos('Reference', 'Delphi Quick Reference'));
  writeln('Delphi Quick Reference'.IndexOf('Reference'));
  Writeln('Delphi Quick Reference'.Substring(0, 'Delphi'.Length).ToUpper);
  Writeln('--------------------------------------------------------------');

  // Sets
  Writeln('----- Sets ---------------------------------------------------');
  progress:=[cChapter01, cChapter02];

  admin:=[];
  admin:=admin + [pCreate];
  admin:=admin + [pUpdate..pDelete];

  Writeln(pCreate in admin);
  Writeln(pRead in admin);
  Writeln(pUpdate in admin);
  Writeln(pDelete in admin);
  Writeln('--------------------------------------------------------------');

  admin:=admin - [pDelete];
  Writeln(pDelete in admin);
  Writeln('--------------------------------------------------------------');

  admin:=admin * [pCreate];

  for var t in admin do
    Writeln(GetEnumName(TypeInfo(TPermission), Ord(t)));
  Writeln('--------------------------------------------------------------');

  // Arrays
  Writeln('----- Arrays -------------------------------------------------');
  arrStatic[0]:='Delphi';
  arrStatic[4]:='Quick Reference';

  arrMulti[3][2][7]:='Multidimensional Array';
  Writeln(arrMulti[3, 2, 7]);

  SetLength(arrDynamic, 10);
  arrDynamic[0]:='Delphi';
  writeln(arrDynamic[0]);

  SetLength(arrDynamicMulti, 10, 10);
  arrDynamicMulti[5][3]:='Quick Reference';
  Writeln(arrDynamicMulti[5][3]);

  SetLength(arrMixed[0], 10);
  arrMixed[0, 5]:='Delphi';
  Writeln(arrMixed[0][5]);

  SetLength(arrMixedReverse, 10);
  arrMixedReverse[3][5]:='Quick Reference';
  Writeln(arrMixedReverse[3][5]);

  SetLength(arrMixedAlt[3], 10);
  arrMixedAlt[3, 3]:='Delphi';
  writeln(arrMixedAlt[3, 3]);

  SetLength(arrTyped, 10);
  arrTyped[3]:='Typed';
  writeln(arrTyped[3]);

  SetLength(arrTypedDual, 10, 10);
  arrTypedDual[5, 5]:='Typed Dual';
  Writeln(arrTypedDual[5, 5]);

  SetLength(genArray, 10);
  genArray[2]:='Generic Array';
  Writeln(genArray[2]);

  // Records
  Writeln('----- Records ------------------------------------------------');
  thisBook.Title:='Delphi Quick Reference Book';
  thisBook.Pages:=100;
  writeln(thisBook.Title);
  Writeln(thisBook.Pages);

  thisBook.Format:=bfHardCopy;
  thisBook.InStock:=true;
  writeln(thisBook.InStock);

  thisBook.Format:=bfPDF;
  thisBook.DownloadURL:='http://';
  writeln(thisBook.DownloadURL);

  writeln(password.Password);
  password:=TRandomPassword.Create('123');
  writeln(password.Password);

  // *** This works in Delphi 10.4 and above ***
  Writeln('Custom Record Password: '+customPassword.Password);

  Writeln('----- Pointers ------------------------------------------------');
  passAddress:=@password;
//  passAddress:=Addr(password);
  writeln(integer(passAddress).ToHexString);

  Writeln('----- Variants ------------------------------------------------');
  flex:= 30;
  Writeln('Flex as integer: ', flex);
  flex:= 'Thirty';
  Writeln('Flex as string: ', flex);

  Writeln('----- Generics ------------------------------------------------');
  logInteger.logType;
  logString.logType;
  logRandomPassword.logType;
  
  Writeln;
  Writeln('Press Enter to exit...');
  Readln;
end.
