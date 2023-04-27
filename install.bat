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

if %cv% geq %dv% (
    echo La version actual de Python es igual o superior a %desired_version%, no se requiere actualizar
    goto UpdatePip
) else (
    echo Actualizando Python a la version %desired_version%...
    pause
)

:InstallPython
powershell -Command "& { iwr -useb https://www.python.org/ftp/python/%desired_version%/python-%desired_version%-amd64.exe -OutFile python-installer.exe }"
.\python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
if %errorlevel% neq 0 (
    echo Error al instalar Python
    pause
    exit /b 1
)
del .\python-installer.exe
echo Python instalado correctamente

:UpdatePip
echo Actualizando pip...
python -m pip install --upgrade pip
if %errorlevel% neq 0 (
    echo Error al actualizar pip
    pause
    exit /b 1
)

echo Instalando dependencias...
python -m pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo Error al instalar dependencias
    pause
    exit /b 1
)

echo.
echo Instalacion completada. Presione cualquier tecla para salir.
pause
