@echo off

echo Comprobando si Python esta instalado...
python --version > NUL 2>&1

if %errorlevel% neq 0 (
    echo Python no encontrado. Instale Python antes de actualizar pip.
    goto End
)

:UpdatePip
set /p updatePip="Desea actualizar pip? (S/N): "
if /i "%updatePip%" EQU "S" (
    echo Actualizando pip...
    python -m pip install --upgrade pip
    if %errorlevel% neq 0 (
        echo Error al actualizar pip
        pause
        exit /b 1
    )
    echo Pip actualizado correctamente
) else if /i "%updatePip%" EQU "N" (
    echo Actualizacion de pip cancelada.
) else (
    echo Por favor ingrese 'S' o 'N'.
    goto UpdatePip
)

:End
echo Proceso finalizado. Presione cualquier tecla para salir.
pause
