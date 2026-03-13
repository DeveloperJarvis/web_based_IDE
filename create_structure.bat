@echo off

REM Root directory
@REM set ROOT=log_pattern_detection_tool
set ROOT=.

REM Create directories if they do not exist
call :create_folder "%ROOT%"
call :create_folder "%ROOT%\config"
call :create_folder "%ROOT%\docs"
call :create_folder "%ROOT%\logs"
call :create_folder "%ROOT%\tests"
call :create_folder "%ROOT%\tests\api"
call :create_folder "%ROOT%\tests\executor"
call :create_folder "%ROOT%\tests\websocket"
call :create_folder "%ROOT%\tests\integration"
call :create_folder "%ROOT%\frontend"
call :create_folder "%ROOT%\frontend\css"
call :create_folder "%ROOT%\frontend\js"
call :create_folder "%ROOT%\frontend\assets"
call :create_folder "%ROOT%\frontend\assets\icons"
call :create_folder "%ROOT%\frontend\assets\images"
call :create_folder "%ROOT%\frontend\vendor"
call :create_folder "%ROOT%\frontend\vendor\monaco-editor"
call :create_folder "%ROOT%\backend"
call :create_folder "%ROOT%\backend\api"
call :create_folder "%ROOT%\backend\api\routes"
call :create_folder "%ROOT%\backend\api\controllers"
call :create_folder "%ROOT%\backend\api\schemas"
call :create_folder "%ROOT%\backend\websocket"
call :create_folder "%ROOT%\backend\executor"
call :create_folder "%ROOT%\backend\sandbox"
call :create_folder "%ROOT%\backend\queue"
call :create_folder "%ROOT%\backend\workers"
call :create_folder "%ROOT%\backend\models"
call :create_folder "%ROOT%\backend\services"
call :create_folder "%ROOT%\backend\storage"
call :create_folder "%ROOT%\backend\config"
call :create_folder "%ROOT%\backend\utils"
call :create_folder "%ROOT%\sandbox"
call :create_folder "%ROOT%\sandbox\docker"
call :create_folder "%ROOT%\sandbox\runtime"
call :create_folder "%ROOT%\sandbox\policies"
call :create_folder "%ROOT%\scripts"

REM Create files only if they do not exist
REM Python source files (with header)
call :create_py_file "%ROOT%\main.py"
call :create_py_file "%ROOT%\setup.py"

call :create_py_file "%ROOT%\config\__init__.py"
call :create_py_file "%ROOT%\config\config.py"

call :create_py_file "%ROOT%\backend\__init__.py"
call :create_py_file "%ROOT%\backend\main.py"
call :create_py_file "%ROOT%\backend\server.py"
call :create_py_file "%ROOT%\backend\api\__init__.py"
call :create_py_file "%ROOT%\backend\api\routes\__init__.py"
call :create_py_file "%ROOT%\backend\api\routes\execute_routes.py"
call :create_py_file "%ROOT%\backend\api\routes\health_routes.py"
call :create_py_file "%ROOT%\backend\api\routes\status_routes.py"
call :create_py_file "%ROOT%\backend\api\controllers\__init__.py"
call :create_py_file "%ROOT%\backend\api\controllers\execution_controller.py"
call :create_py_file "%ROOT%\backend\api\controllers\health_controller.py"
call :create_py_file "%ROOT%\backend\api\schemas\__init__.py"
call :create_py_file "%ROOT%\backend\api\schemas\execution_controller.py"
call :create_py_file "%ROOT%\backend\api\schemas\health_controller.py"
call :create_py_file "%ROOT%\backend\websocket\__init__.py"
call :create_py_file "%ROOT%\backend\websocket\websocket_server.py"
call :create_py_file "%ROOT%\backend\websocket\connection_manager.py"
call :create_py_file "%ROOT%\backend\websocket\output_streamer.py"
call :create_py_file "%ROOT%\backend\executor\__init__.py"
call :create_py_file "%ROOT%\backend\executor\execution_manager.py"
call :create_py_file "%ROOT%\backend\executor\code_runner.py"
call :create_py_file "%ROOT%\backend\executor\execution_context.py"
call :create_py_file "%ROOT%\backend\executor\timeout_guard.py"
call :create_py_file "%ROOT%\backend\executor\result_collector.py"
call :create_py_file "%ROOT%\backend\sandbox\__init__.py"
call :create_py_file "%ROOT%\backend\sandbox\sandbox_manager.py"
call :create_py_file "%ROOT%\backend\sandbox\container_runtime.py"
call :create_py_file "%ROOT%\backend\sandbox\resource_limits.py"
call :create_py_file "%ROOT%\backend\sandbox\filesystem_isolation.py"
call :create_py_file "%ROOT%\backend\queue\__init__.py"
call :create_py_file "%ROOT%\backend\queue\job_queue.py"
call :create_py_file "%ROOT%\backend\queue\producer.py"
call :create_py_file "%ROOT%\backend\queue\consumer.py"
call :create_py_file "%ROOT%\backend\workers\__init__.py"
call :create_py_file "%ROOT%\backend\workers\execution_worker.py"
call :create_py_file "%ROOT%\backend\workers\worker_manager.py"
call :create_py_file "%ROOT%\backend\models\__init__.py"
call :create_py_file "%ROOT%\backend\models\execution.py"
call :create_py_file "%ROOT%\backend\models\execution_status.py"
call :create_py_file "%ROOT%\backend\models\language_config.py"
call :create_py_file "%ROOT%\backend\services\__init__.py"
call :create_py_file "%ROOT%\backend\services\execution_service.py"
call :create_py_file "%ROOT%\backend\services\websocket_service.py"
call :create_py_file "%ROOT%\backend\services\sandbox_service.py"
call :create_py_file "%ROOT%\backend\storage\__init__.py"
call :create_py_file "%ROOT%\backend\storage\execution_repository.py"
call :create_py_file "%ROOT%\backend\storage\log_repository.py"
call :create_py_file "%ROOT%\backend\config\__init__.py"
call :create_py_file "%ROOT%\backend\config\settings.py"
call :create_py_file "%ROOT%\backend\config\logging_config.py"
call :create_py_file "%ROOT%\backend\config\constants.py"
call :create_py_file "%ROOT%\backend\utils\__init__.py"
call :create_py_file "%ROOT%\backend\utils\id_generator.py"
call :create_py_file "%ROOT%\backend\utils\file_utils.py"
call :create_py_file "%ROOT%\backend\utils\time_utils.py"

call :create_py_file "%ROOT%\tests\__init__.py"
call :create_py_file "%ROOT%\tests\api\__init__.py"
call :create_py_file "%ROOT%\tests\api\test_execute_api.py"
call :create_py_file "%ROOT%\tests\api\test_health_api.py"
call :create_py_file "%ROOT%\tests\executor\__init__.py"
call :create_py_file "%ROOT%\tests\executor\test_execution_manager.py"
call :create_py_file "%ROOT%\tests\executor\test_code_runner.py"
call :create_py_file "%ROOT%\tests\websocket\__init__.py"
call :create_py_file "%ROOT%\tests\websocket\test_streaming.py"
call :create_py_file "%ROOT%\tests\integration\__init__.py"
call :create_py_file "%ROOT%\tests\integration\test_end_to_end_execution.py"

REM Non-Python files (empty)
call :create_file "%ROOT%\logs\api.log"
call :create_file "%ROOT%\logs\worker.log"
call :create_file "%ROOT%\logs\execution.log"

call :create_file "%ROOT%\sandbox\docker\Dockerfile.python"
call :create_file "%ROOT%\sandbox\docker\Dockerfile.cpp"
call :create_file "%ROOT%\sandbox\docker\Dockerfile.node"
call :create_file "%ROOT%\sandbox\runtime\run_python.sh"
call :create_file "%ROOT%\sandbox\runtime\run_cpp.sh"
call :create_file "%ROOT%\sandbox\runtime\run_node.sh"
call :create_file "%ROOT%\sandbox\policies\seccomp_profile.json"
call :create_file "%ROOT%\sandbox\policies\resource_limits.json"

call :create_file "%ROOT%\scripts\start_api.sh"
call :create_file "%ROOT%\scripts\start_worker.sh"
call :create_file "%ROOT%\scripts\build_sandbox.sh"
call :create_file "%ROOT%\scripts\dev_server.sh"

call :create_file "%ROOT%\docs\system_design.md"
call :create_file "%ROOT%\docs\api_spec.md"
call :create_file "%ROOT%\docs\execution_pipeline.md"

call :create_file "%ROOT%\frontend\index.html"
call :create_file "%ROOT%\frontend\css\reset.css"
call :create_file "%ROOT%\frontend\css\layout.css"
call :create_file "%ROOT%\frontend\css\editor.css"
call :create_file "%ROOT%\frontend\css\terminal.css"
call :create_file "%ROOT%\frontend\js\app.js"
call :create_file "%ROOT%\frontend\js\editor.js"
call :create_file "%ROOT%\frontend\js\api.js"
call :create_file "%ROOT%\frontend\js\websocket.js"
call :create_file "%ROOT%\frontend\js\terminal.js"
call :create_file "%ROOT%\frontend\js\utils.js"

call :create_file "%ROOT%\requirements.txt"
call :create_file "%ROOT%\README.md"
call :create_file "%ROOT%\LICENSE"
call :create_file "%ROOT%\.gitignore"
call :create_file "%ROOT%\docker-compose.yml"

echo Folder structure created (existing files and folders were preserved).
goto :eof

REM -------------------------------------------
REM Create folders if does not exist
REM -------------------------------------------

:create_folder
if not exist "%~1" (
    mkdir "%~1"
)

REM -------------------------------------------
REM Create empty file if it does not exist
REM -------------------------------------------

:create_file
if not exist "%~1" (
    type nul > "%~1"
)

exit /b

REM -------------------------------------------
REM Create python file with GPL header
REM -------------------------------------------
:create_py_file
if exist "%~1" exit /b

set FILEPATH=%~1
set FILENAME=%~n1

(
echo # --------------------------------------------------
echo # -*- Python -*- Compatibility Header
echo #
echo # Copyright ^(C^) 2023 Developer Jarvis ^(Pen Name^)
echo #
echo # This file is part of the Log Pattern Detection Tool Library. This library is free
echo # software; you can redistribute it and/or modify it under the
echo # terms of the GNU General Public License as published by the
echo # Free Software Foundation; either version 3, or ^(at your option^)
echo # any later version.
echo #
echo # This program is distributed in the hope that it will be useful,
echo # but WITHOUT ANY WARRANTY; without even the implied warranty of
echo # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
echo # GNU General Public License for more details.
echo #
echo # You should have received a copy of the GNU General Public License
echo # along with this program. If not, see ^<https://www.gnu.org/licenses/^>.
echo #
echo # SPDX-License-Identifier: GPL-3.0-or-later
echo #
echo # Log Pattern Detection Tool - Find patterns and anomalies in large log files
echo #                       Skills: streaming I/O, algorithms, regex
echo #
echo # Author: Developer Jarvis ^(Pen Name^)
echo # Contact: https://github.com/DeveloperJarvis
echo #
echo # --------------------------------------------------
echo.
echo # --------------------------------------------------
echo # %FILENAME%% MODULE
echo # --------------------------------------------------
echo.
echo # --------------------------------------------------
echo # imports
echo # --------------------------------------------------
echo.
) > "%FILEPATH%"

exit /b