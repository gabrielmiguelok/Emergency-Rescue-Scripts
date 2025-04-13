@echo off
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: meltdown.bat
:: -------------------------------------------------------------------------
:: MIT License
::
:: Copyright (c) 2025
:: 
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

REM 1. Cerrar procesos de alto consumo.
taskkill /IM chrome.exe /F
taskkill /IM node.exe /F
taskkill /IM slack.exe /F
taskkill /IM discord.exe /F
taskkill /IM teams.exe /F
taskkill /IM zoom.exe /F
taskkill /IM firefox.exe /F
taskkill /IM brave.exe /F
taskkill /IM code.exe /F

REM 2. (OPCIONAL) Reiniciar Explorer.exe. Descomentar si lo necesitas.
REM taskkill /IM explorer.exe /F
REM start explorer.exe

echo Procesos críticos finalizados.
exit
