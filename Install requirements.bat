@echo off

echo Comprobando si Python esta instalado...
python --version > NUL 2>&1

if %errorlevel% neq 0 (
    echo Python no encontrado. Por favor, instale Python antes de continuar.
    pause
    exit /b 1
) else (
    for /f "tokens=* USEBACKQ" %%F in (`python --version`) do (
        set current_version=%%F
    )
    set current_version=%current_version:Python =%
    echo Version actual de Python: %current_version%
)

echo Instalando dependencias desde requirements.txt...
python -m pip install -r requirements.txt

if %errorlevel% neq 0 (
    echo Error al instalar dependencias
    pause
    exit /b 1
)

echo Dependencias instaladas correctamente. Presione cualquier tecla para salir.
pause