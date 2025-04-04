# 🧰 Streamlit App NSIS Installer

This repository contains an **NSIS script** to build a Windows installer for a Streamlit-based Python application. It includes a Python virtual environment and sets up shortcuts and uninstallation logic.

## 🚀 Features

- Packages your Streamlit app along with its virtual environment
- Creates desktop and Start Menu shortcuts
- Generates a `launch_app.bat` script to run the app with the bundled environment
- Clean uninstallation support
- Fully customizable NSIS `.nsi` file

---

## 📁 Project Structure

```
.
├── app/                  # Your Streamlit app files
│   └── app.py
├── .venv/                # Python virtual environment
│   └── Scripts/, Lib/, ...
├── app_icon.ico          # Icon used in installer and shortcuts
├── install.nsi           # NSIS script
└── README.md
```

---

## 📝 NSIS Script (`install.nsi`) Overview

This file is the **heart of the installer** logic. You can open and edit it with any text editor.

### Key Arguments / Definitions

| Variable         | Description                                          |
|------------------|------------------------------------------------------|
| `APPNAME`        | Name of your app (used in shortcut names, UI, etc.) |
| `COMPANYNAME`    | Publisher/company name                               |
| `APP_VERSION`    | Version displayed in the uninstaller registry        |
| `DESCRIPTION`    | Short app description shown during installation      |
| `INSTALLSIZE`    | Approx. install size in KB (for registry info)       |

Example from the script:
```nsis
!define APPNAME "MyStreamlitApp"
!define COMPANYNAME "GirinSoft"
!define APP_VERSION "1.0.0"
!define DESCRIPTION "A Streamlit-based Python application"
```

### Major Components in the Script

| Section                  | Purpose                                              |
|--------------------------|------------------------------------------------------|
| `!include`               | Loads NSIS libraries (UI, File utils, etc.)          |
| `MUI_PAGE_*`             | Defines the UI flow for installation/uninstallation  |
| `Section "Install"`      | Main install logic: file copying, shortcuts, etc.    |
| `Section "Uninstall"`    | Clean-up: removes files, registry entries, etc.      |
| `WriteUninstaller`       | Generates an uninstaller `uninstall.exe`             |
| `CreateShortcut`         | Adds desktop and start menu launchers                |
| `FileWrite` to `.bat`    | Writes a `launch_app.bat` that starts the app        |

---

## 🛠️ How to Build the Installer

### ✅ Prerequisites

- [NSIS](https://nsis.sourceforge.io/Download) installed
- Python app + virtual environment ready

### 🧪 Steps

1. **Clone the Repo:**
   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
   ```

2. **Add Your App Files:**
   - Place your app in the `app/` directory.
   - Place your virtual environment (e.g., `.venv/`) at the root.

3. **Customize the Script (Optional):**
   Modify values at the top of `install.nsi` to match your project.

4. **Compile Using NSIS:**
   - Open `install.nsi` in the NSIS compiler (or right-click → Compile NSIS Script).
   - Output will be `StreamlitAppInstaller.exe`.

---

## 📦 What the Installer Does

- Installs files to `C:\Program Files\YourCompany\YourApp`
- Adds desktop and Start Menu shortcuts
- Creates a `launch_app.bat` to run Streamlit with the correct Python interpreter
- Registers uninstaller in Add/Remove Programs

---

## 🧼 Uninstallation

The uninstaller removes:

- All installed files and folders
- Shortcuts from Desktop and Start Menu
- Registry entries related to the app

---

## 🐞 Debug Tips

- Use `DetailPrint` in NSIS to show logs during install.
- To test the installer:
  - Use a virtual machine or test user account.
  - Clean the install directory between builds.

---