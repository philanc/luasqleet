

@setlocal

@rem -- adjust the following!!
@set VC=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC
@set WKI=C:\Program Files (x86)\Windows Kits\10\Include\10.0.10240.0
@set WKL=C:\Program Files (x86)\Windows Kits\10\Lib\10.0.10240.0

@set PATH=%PATH%;%VC%\bin
@set INCLUDE=%VC%\include;%WKI%\um;%WKI%\shared;%WKI%\ucrt
@set LIB=%WKL%\um\x86;%WKL%\ucrt\x86;%VC%\lib;%VC%\lib\store

@set lua=lua5.3.4
@set luaincl=..\lua\src

@del luasqleet.obj luasql.obj
@del luasqleet.lib luasqleet.dll

@set  CCFLAGS=/D_USRDLL /D_WINDLL /DLUA_BUILD_AS_DLL /DWIN32


cl /c /I %luaincl% %CCFLAGS% luasqleet.c luasql.c sqleet.c
link /DLL /DEF:luasqleet.def /OUT:luasqleet.dll luasqleet.obj luasql.obj sqleet.obj lua\%lua%.lib

@rem -- also build the standalone sqlite "shell" 
@rem -- with encryption support:  sqleet.exe

@del sqleet.exe 
cl sqleet.c shell.c



