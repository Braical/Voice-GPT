@echo off

set desired_version=3.10.2

:: Verifica si Python ya está instalado
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python no encontrado, instalando...
    goto InstallPython
) else (
    for /f "tokens=* USEBACKQ" %%F in (`python --version`) do (
        set current_version=%%F
    )
    set current_version=%current_version:Python =%
    echo Version actual de Python: %current_version%
)

:: Verifica si la version actual es igual o superior a la version deseada
for /f "tokens=1-3 delims=." %%a in ("%current_version%") do set /a cv=%%a*10000 + %%b*100 + %%c
for /f "tokens=1-3 delims=." %%a in ("%desired_version%") do set /a dv=%%a*10000 + %%b*100 + %%c

if %cv% geq %dv% (
    echo La version actual de Python es igual o superior a %desired_version%, no se requiere actualizar
    goto UpdatePip
) else (
    echo Actualizando Python a la version %desired_version%...
)

:InstallPython
powershell -Command "& { iwr -useb https://www.python.org/ftp/python/%desired_version%/python-%desired_version%-amd64.exe -OutFile python-installer.exe }"
.\python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
del .\python-installer.exe
echo Python instalado correctamente

:UpdatePip
echo Actualizando pip...
python -m pip install --upgrade pip

echo Instalando dependencias...
python -m pip install -r requirements.txt

echo.
echo Instalacion completada. Presione cualquier tecla para salir.
pause >nul
