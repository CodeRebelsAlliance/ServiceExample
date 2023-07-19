@echo off

REM Set the virtual environment name
set VENV_NAME=.venv

REM Check if virtual environment exists
if exist %VENV_NAME% (
    echo Virtual environment already exists. Skipping creation.
) else (
    REM Create the virtual environment
    python -m venv %VENV_NAME%
    if %errorlevel% neq 0 (
        echo Failed to create the virtual environment.
        exit /b 1
    )
)

REM Activate the virtual environment
call %VENV_NAME%\Scripts\activate.bat
if %errorlevel% neq 0 (
    echo Failed to activate the virtual environment.
    exit /b 1
)

REM Check requirements
pip check requirements.txt
if %errorlevel% neq 0 (
    echo Some requirements are missing or have conflicts. Installing them now.
    pip install -r requirements.txt
    if %errorlevel% neq 0 (
        echo Failed to install the requirements.
        exit /b 1
    )
)

REM Run the Python application
flask run --debug
if %errorlevel% neq 0 (
    echo Failed to run the Python application.
    exit /b 1
)