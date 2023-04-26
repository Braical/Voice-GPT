@echo off

:: Verifica si Python ya está instalado
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python no encontrado, instalando...
    powershell -Command "& { iwr -useb https://www.python.org/ftp/python/3.10.2/python-3.10.2-amd64.exe -OutFile python-installer.exe }"
    .\python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    del .\python-installer.exe
    echo Python instalado correctamente
) else (
    echo Python ya esta instalado
)

echo Actualizando pip...
python -m pip install --upgrade pip

echo Instalando dependencias...
python -m pip install -r requirements.txt

echo.
echo Instalacion completada. Presione cualquier tecla para salir.
pause >nul
