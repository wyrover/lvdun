@echo off
setlocal EnableDelayedExpansion
set vc="C:\Program Files (x86)\Microsoft Visual Studio 9.0\Common7\IDE\devenv.exe"
if not exist %vc% (
  echo devenv.exe·������:%vc%
  goto done
)
set basedir="%~dp0"
copy /y nul %basedir%\log.txt
echo vc_version = vc9>>%basedir%\log.txt

set sln="%basedir:~1,-1%GreenShield.sln"
echo ���ڱ��� %sln%...
%vc% %sln% /Rebuild Release
if not %errorlevel%==0 (
	echo rebuild %sln% failed
	goto done
)
cd /d "%basedir:~1,-1%\Release"
for /r %%i in (*.exe *.dll) do (
   call :printversion "%%i" %%~nxi
)

for %%b in (GreenShield,GsNet,GsNetFilter,GSPre) do (
	for %%i in (.dll,.map,.exe,.pdb) do (
		copy /y "%basedir:~1,-1%\Release\*%%i" !pdbdir!
	)
	md !pdbdir!\%%b_cod
	copy /y "%basedir:~1,-1%%%b\Release\*.cod" !pdbdir!\%%b_cod\
)
echo �������
goto done

:printversion
set build_date=%date:~0,10%
set build_date=%build_date:/=-%
set build_time=%time:~0,8%
set build_time=%build_time::=-%
set bin_path=%1
set bin_path=%bin_path:\=\\%
set bin_path=%bin_path:~1,-1%
echo %bin_path%
for /f "skip=1" %%i in ('wmic datafile where "Name='%bin_path%'" get Version') do (
	if "%bin_path:~-3,1000%" == "exe" (
		set pdbdir=%basedir:~1,-1%\%%i\pdb__%build_date%__%build_time%__%random%\
		md !pdbdir!
		echo about create commit_setup_log.txt
		copy /y nul !pdbdir!\commit_setup_log.txt
	)
	echo %2=%%i>>!pdbdir!\commit_setup_log.txt
	echo %2=%%i>>%basedir%\log.txt
	goto :eof
)

:done
pause
@echo on