@echo off

set "PKG_ROOT=%~dp0.."

rem main.jl args
set "JULIA_ENVIRONMENT_PATH=%1"
set "DEBUG=--debug=no"
set "IGNORE_TELEMETRY_CRASH="
set "OLD_DEPOT_PATH=%JULIA_DEPOT_PATH%"
IF "%JULIA_LSP_STORAGE%"=="" (
    set "STORAGE_PATH=%PKG_ROOT%\store"
) ELSE (
    set "STORAGE_PATH=%JULIA_LSP_STORAGE%"
)
IF "%SYMBOL_CACHE_DOWNLOAD%"=="0" (
    set "USE_SYMSERVER_DOWNLOADS=local"
) ELSE (
    set "USE_SYMSERVER_DOWNLOADS=download"
)
IF "%SYMBOL_SERVER%"=="" (
    set "SYMSERVER_UPSTREAM=https://www.julia-vscode.org/symbolcache"
) ELSE (
    set "SYMSERVER_UPSTREAM=%SYMBOL_SERVER%"
)
IF "%JULIA_LSP_JULIA_BIN%"=="" (
    set "JULIA_LSP_JULIA_BIN=julia"
)

set "JULIA_SSI_EXE=%JULIA_LSP_JULIA_BIN%"
for /f "tokens=3" %%v in ('%JULIA_SSI_EXE% --version') do (
    set JULIA_SSI_VERSION=%%v
)

set "DETACHED=--detached=no"
set "JULIA_LOAD_PATH=;"
set "JULIA_DEPOT_PATH=%PKG_ROOT%\store\lsdepot\v1"

"%JULIA_LSP_JULIA_BIN%" --startup-file=no --history-file=no --depwarn=no "%PKG_ROOT%\extension\scripts\languageserver\main.jl" "%JULIA_ENVIRONMENT_PATH%" "%DEBUG%" "%IGNORE_TELEMETRY_CRASH%" "%OLD_DEPOT_PATH%" "%STORAGE_PATH%" "%USE_SYMSERVER_DOWNLOADS%" "%SYMSERVER_UPSTREAM%" "%DETACHED%" "%JULIA_SSI_EXE%" "%JULIA_SSI_VERSION%"
