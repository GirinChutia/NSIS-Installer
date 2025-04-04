; Define variables
!define APPNAME "MyStreamlitApp"
!define COMPANYNAME "GirinSoft"
!define APP_VERSION "1.0.0"
!define DESCRIPTION "A Streamlit-based Python application"
!define VERSIONMAJOR 1
!define VERSIONMINOR 0
!define INSTALLSIZE 150000

; Include necessary NSIS libraries
!include "MUI2.nsh"
!include "FileFunc.nsh"

; General settings
Name "${APPNAME}"
OutFile "StreamlitAppInstaller.exe"
InstallDirRegKey HKCU "Software\${COMPANYNAME}\${APPNAME}" ""
InstallDir "$PROGRAMFILES\${COMPANYNAME}\${APPNAME}"

; Request application privileges
RequestExecutionLevel admin

; Interface settings
!define MUI_ICON "app_icon.ico"
!define MUI_UNICON "app_icon.ico"
!define MUI_WELCOMEPAGE_TITLE "Welcome to ${APPNAME} Setup"
!define MUI_WELCOMEPAGE_TEXT "This will install ${APPNAME} on your computer.$\r$\n$\r$\n${DESCRIPTION}"
!define MUI_FINISHPAGE_RUN "$INSTDIR\launch_app.bat"
!define MUI_FINISHPAGE_RUN_TEXT "Launch ${APPNAME}"

; Define the pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; Set the language
!insertmacro MUI_LANGUAGE "English"

; Installation section
Section "Install"
    SetRegView 64 ; Ensure 64-bit registry view (moved inside the section)
    SetOutPath "$INSTDIR"
    
    ; Create directories
    CreateDirectory "$INSTDIR\app"
    CreateDirectory "$INSTDIR\.venv"

    ; Copy your app files
    SetOutPath "$INSTDIR\app"
    File /r "app\*.*"

    ; Copy the venv files
    ; SetOutPath "$INSTDIR\.venv"
    ; File /r ".venv\*.*"

    SetOutPath "$INSTDIR\7-Zip"
    File /r "7-Zip\*.*"

    ; Copy the zipped .venv file
    SetOutPath "$INSTDIR"
    File ".venv.zip"

    ; Copy the app icon
    File "app_icon.ico"

    ; Extract the .venv.zip file
    nsExec::ExecToLog '"$INSTDIR\7-Zip\7z.exe" x "$INSTDIR\.venv.zip" -o"$INSTDIR\.venv" -y'
    Delete "$INSTDIR\.venv.zip"

    ; Create the batch file to launch the app
    FileOpen $0 "$INSTDIR\launch_app.bat" w
    FileWrite $0 '@echo off$\r$\n'
    FileWrite $0 'cd /d "%~dp0"$\r$\n'
    FileWrite $0 '"%~dp0.venv\.venv\Scripts\python.exe" -m streamlit run "%~dp0app\app.py"$\r$\n'
    FileWrite $0 'pause$\r$\n'
    FileClose $0
    
    ; Create shortcuts
    CreateDirectory "$SMPROGRAMS\${COMPANYNAME}"
    CreateShortcut "$SMPROGRAMS\${COMPANYNAME}\${APPNAME}.lnk" "$INSTDIR\launch_app.bat" "" "$INSTDIR\app_icon.ico"
    CreateShortcut "$DESKTOP\${APPNAME}.lnk" "$INSTDIR\launch_app.bat" "" "$INSTDIR\app_icon.ico"
    
    ; Write installation info to registry
    WriteRegStr HKCU "Software\${COMPANYNAME}\${APPNAME}" "" $INSTDIR
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayName" "${APPNAME}"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayIcon" "$\"$INSTDIR\app_icon.ico$\""
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "Publisher" "${COMPANYNAME}"
    
    ; Create uninstaller
    WriteUninstaller "$INSTDIR\uninstall.exe"
    
SectionEnd

; Uninstaller section
Section "Uninstall"
    
    ; Remove installed files and directories
    RMDir /r "$INSTDIR\app"
    RMDir /r "$INSTDIR\.venv"
    RMDir /r "$INSTDIR\7-Zip"
    Delete "$INSTDIR\launch_app.bat"
    Delete "$INSTDIR\app_icon.ico"
    Delete "$INSTDIR\uninstall.exe"
    RMDir "$INSTDIR"
    
    ; Remove shortcuts
    Delete "$SMPROGRAMS\${COMPANYNAME}\${APPNAME}.lnk"
    RMDir "$SMPROGRAMS\${COMPANYNAME}"
    Delete "$DESKTOP\${APPNAME}.lnk"
    
    ; Remove registry entries
    DeleteRegKey HKCU "Software\${COMPANYNAME}\${APPNAME}"
    DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}"
    
SectionEnd