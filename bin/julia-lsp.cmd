@echo off

set "PKG_ROOT=%~dp0.."

rem main.jl args
set "JULIA_ENVIRONMENT_PATH=%1"
set "DEBUG=--debug=no"
set "IGNORE_TELEMETRY_CRASH="
set "OLD_DEPOT_PATH=%JULIA_DEPOT_PATH%"
if "%JULIA_LSP_STORAGE%"=="" set "STORAGE_PATH=%PKG_ROOT%\store" || set "STORAGE_PATH=%JULIA_LSP_STORAGE%"
set "USE_SYMSERVER_DOWNLOADS=download"
set "SYMSERVER_UPSTREAM=https://www.julia-vscode.org/symbolcache"
set "DETACHED=--detached=no"

set "JULIA_LOAD_PATH=:"
set "JULIA_DEPOT_PATH=%PKG_ROOT%\store\lsdepot\v1"

julia --startup-file=no --history-file=no --depwarn=no "%PKG_ROOT%\extension\scripts\languageserver\main.jl" "%JULIA_ENVIRONMENT_PATH%" "%DEBUG%" "%IGNORE_TELEMETRY_CRASH%" "%OLD_DEPOT_PATH%" "%STORAGE_PATH%" "%USE_SYMSERVER_DOWNLOADS%" "%SYMSERVER_UPSTREAM%" "%DETACHED%"
