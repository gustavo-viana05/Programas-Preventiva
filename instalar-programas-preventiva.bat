@echo off
setlocal
title Instalacao automatica - Ferramentas de Preventiva

:: --- Pede permissao de administrador se ainda nao tiver ---
net session >nul 2>nul
if errorlevel 1 (
    echo Solicitando permissao de administrador...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

where winget >nul 2>nul
if errorlevel 1 (
    echo [ERRO] O winget nao foi encontrado neste PC.
    echo Atualize o "Instalador de Aplicativo" na Microsoft Store e tente de novo.
    pause
    exit /b 1
)

echo Instalando ferramentas (modo silencioso)...
echo.

for %%P in (
    CrystalDewWorld.CrystalDiskInfo
    CrystalDewWorld.CrystalDiskMark
    CPUID.HWMonitor
    CPUID.CPU-Z
    AnyDeskSoftwareGmbH.AnyDesk
) do (
    echo ===== %%P =====
    winget install --id %%P --exact --silent --disable-interactivity --accept-package-agreements --accept-source-agreements
    echo.
)

echo Concluido!
pause
