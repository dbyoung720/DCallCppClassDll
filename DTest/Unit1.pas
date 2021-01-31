unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    FCppClassObj: Pointer;
    function MyAdd({$IFDEF WIN32}a, b: Integer; pObj: Pointer{$ELSE}pObj: Pointer; a, b: Integer {$ENDIF}): Integer;
    procedure ShowMSG({$IFDEF WIN32}R1, R2: Integer; {$ENDIF} pObj: Pointer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{$IFDEF WIN32}
function CreateCppClass: Pointer; stdcall; external 'vcd.dll' name '??0CppDll@@QAE@XZ';                      // 创建 C++ 类
function CppClass_MyAdd(a, b: Integer): Integer; stdcall; external 'vcd.dll' name '?MyAdd@CppDll@@QAEHHH@Z'; // C++ 类的导出函数 MyAdd
procedure CppClass_ShowMSG; stdcall; external 'vcd.dll' name '?ShowMSG@CppDll@@QAEXXZ';                      // C++ 类的导出函数 ShowMSG
{$ELSE}
function CreateCppClass: Pointer; cdecl; external 'vcd.dll' name '??0CppDll@@QEAA@XZ';                      // 创建 C++ 类
function CppClass_MyAdd(a, b: Integer): Integer; cdecl; external 'vcd.dll' name '?MyAdd@CppDll@@QEAAHHH@Z'; // C++ 类的导出函数 MyAdd
procedure CppClass_ShowMSG; cdecl; external 'vcd.dll' name '?ShowMSG@CppDll@@QEAAXXZ';                      // C++ 类的导出函数 ShowMSG
{$ENDIF}

procedure TForm1.FormCreate(Sender: TObject);
begin
  GetMem(FCppClassObj, 8);
  FCppClassObj := CreateCppClass;

{$IFDEF WIN32}
  Caption := IntToStr(MyAdd(4, 6, FCppClassObj));
  ShowMSG(0, 0, FCppClassObj);
{$ELSE}
  Caption := IntToStr(MyAdd(FCppClassObj, 4, 6));
  ShowMSG(FCppClassObj);
{$ENDIF}
end;

function TForm1.MyAdd({$IFDEF WIN32}a, b: Integer; pObj: Pointer{$ELSE}pObj: Pointer; a, b: Integer {$ENDIF}): Integer;
begin
  Result := CppClass_MyAdd(a, b);
end;

procedure TForm1.ShowMSG({$IFDEF WIN32}R1, R2: Integer; {$ENDIF} pObj: Pointer);
begin
  CppClass_ShowMSG;
end;

end.
