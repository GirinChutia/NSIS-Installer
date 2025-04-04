@echo off
start "" "%~dp0\.venv\Scripts\python.exe" -m streamlit run "%~dp0\app\app.py"