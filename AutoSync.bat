@echo off

powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show(\"Welcome to AutoSync v1.0`nBy Abbas Sobhi - June 2025\", \"AutoSync\", 'OK', 'Information')"


Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass

powershell -ExecutionPolicy Bypass -File "C:\Users\abbas\Desktop\PDF\AutoSync\AutoSync.ps1"

pause
