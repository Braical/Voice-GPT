@echo off
set desired_version=3.9.9

echo Comprobando si Python esta instalado...
python --version > NUL 2>&1

if %errorlevel% neq 0 (
    echo Python no encontrado.
    :InstallPythonPrompt
    set /p installPython="Desea instalar Python %desired_version%? (s/n): "
    if /i "%installPython%" EQU "s" (
        goto InstallPython
    ) else if /i "%installPython%" EQU "n" (
        echo Instalacion de Python cancelada.
        goto End
    ) else (
        echo Por favor ingrese 's' o 'n'.
        goto InstallPythonPrompt
    )
) else (
    for /f "tokens=* USEBACKQ" %%F in (`python --version`) do (
        set current_version=%%F
    )
    set current_version=%current_version:Python =%
    echo Version actual de Python: %current_version%
)

:UpdatePip
set /p updatePip="Desea actualizar pip? (s/n): "
if /i "%updatePip%" EQU "s" (
    echo Actualizando pip...
    python -m pip install --upgrade pip
    if %errorlevel% neq 0 (
        echo Error al actualizar pip
        pause
        exit /b 1
    )
) else if /i "%updatePip%" EQU "n" (
    echo Actualizacion de pip cancelada.
) else (
    echo Por favor ingrese 's' o 'n'.
    goto UpdatePip
)

echo Instalando dependencias...
set /p installDeps="Desea instalar las dependencias del proyecto? (s/n): "
if /i "%installDeps%" EQU "S" (
    python -m pip install -r requirements.txt
    if %errorlevel% neq 0 (
        echo Error al instalar dependencias
        pause
        exit /b 1
    )
) else if /i "%installDeps%" EQU "s" (
    echo Instalacion de dependencias cancelada.
) else (
    echo Por favor ingrese 's' o 'n'.
    goto InstallDependencies
)

echo.
echo Instalacion completada. Presione cualquier tecla para salir.
pause
exit

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
goto UpdatePip

:End
echo Instalacion cancelada. Presione cualquier tecla para salir.
pause
