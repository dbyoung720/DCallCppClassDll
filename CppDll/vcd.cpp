// vcd.cpp : 定义 DLL 的导出函数。
//

#include "framework.h"
#include "vcd.h"

// 这是已导出类的构造函数。
CppDll::CppDll()
{
    return;
}

int CppDll::MyAdd(int a, int b)
{
    return a + b;
}

void CppDll::ShowMSG()
{
    ::MessageBoxA(0, (LPCSTR)"Delphi 调用 VC 类的成员函数", (LPCSTR)"系统提示：", MB_OK);
}