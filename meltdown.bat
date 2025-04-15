@echo off
:: =========================================================================
:: CONFIGURACIÓN (Lista de procesos pesados que suelen colapsar el sistema)
:: =========================================================================
SET PROCESOS=chrome.exe node.exe slack.exe discord.exe teams.exe zoom.exe firefox.exe brave.exe code.exe

:: =========================================================================
:: SECUENCIA DE CIERRE (Pánico)
:: =========================================================================

:: 1. Matar procesos pesados enumerados en la lista.
echo Cerrando procesos pesados...
FOR %%P IN (%PROCESOS%) DO (
    taskkill /IM %%P /F 2>nul
)

:: 2. (OPCIONAL) Reiniciar el explorador de Windows.
::    Descomentar si deseas “refrescar” completamente el entorno.
:: taskkill /IM explorer.exe /F
:: start explorer.exe

echo.
echo =====================================
echo   Procesos críticos finalizados
echo =====================================
echo.
pause
exit
