@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "__VSCMD_ARG_NO_LOGO=1"
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set "VSDEVCMD="

if exist "%VSWHERE%" (
	for /f "tokens=*" %%i in ('"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath') do (
		set "VSDEVCMD=%%i\Common7\Tools\VsDevCmd.bat"
	)
)

if not defined VSDEVCMD if exist "%ProgramFiles%\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat" set "VSDEVCMD=%ProgramFiles%\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat"
if not defined VSDEVCMD if exist "%ProgramFiles%\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" set "VSDEVCMD=%ProgramFiles%\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat"
if not defined VSDEVCMD if exist "%ProgramFiles%\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat" set "VSDEVCMD=%ProgramFiles%\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat"
if not defined VSDEVCMD if exist "%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\VsDevCmd.bat" set "VSDEVCMD=%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\VsDevCmd.bat"
if not defined VSDEVCMD if exist "%ProgramFiles%\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\VsDevCmd.bat" set "VSDEVCMD=%ProgramFiles%\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\VsDevCmd.bat"

if not defined VSDEVCMD (
	echo ERROR: Visual Studio x64 C++ tools were not found.
	exit /b 1
)

call "%VSDEVCMD%" -arch=x64 -host_arch=x64
if errorlevel 1 exit /b 1

if /i "%~1"=="--check" (
	echo VSCMD_ARG_TGT_ARCH=%VSCMD_ARG_TGT_ARCH%
	where cl.exe
	exit /b 0
)

pwsh.exe -NoLogo
