@echo off
setlocal
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0publish_to_github.ps1"
set EXITCODE=%ERRORLEVEL%
echo.
if not "%EXITCODE%"=="0" (
  echo Deployment failed with exit code %EXITCODE%.
) else (
  echo Deployment command completed successfully.
)
echo Press any key to close this window.
pause >nul
exit /b %EXITCODE%
