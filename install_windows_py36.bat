@echo off
setlocal

echo Using Python:
python --version
python -c "import sys; print(sys.executable)"
if errorlevel 1 goto :error

echo.
echo Upgrading pip/setuptools/wheel...
python -m pip install --upgrade pip setuptools wheel
if errorlevel 1 goto :error

echo.
echo Installing runtime dependencies...
python -m pip install -r requirements\requirements-windows-python36.txt
if errorlevel 1 goto :error

echo.
echo Generating resources.py from resources.qrc...
python -m PyQt5.pyrcc_main -o resources.py resources.qrc
if errorlevel 1 goto :error

echo.
echo Installing labelImg_OBB into the current environment...
python -m pip install -e . --no-deps
if errorlevel 1 goto :error

echo.
echo Install complete.
echo Run the app with:
echo python labelImg.py
goto :end

:error
echo.
echo Installation failed. Review the error output above.
exit /b 1

:end
endlocal
