import os
import subprocess

# Define the folder to zip and the output zip file
folder_to_zip = ".venv"
output_zip = ".venv.zip"
seven_zip_path = "7-Zip/7z.exe"  # Path to 7z.exe (ensure it's in the same directory or provide the full path)

# Ensure the folder exists
if os.path.exists(folder_to_zip):
    # Run the 7z command to zip the folder
    try:
        subprocess.run([seven_zip_path, "a", output_zip, folder_to_zip], check=True)
        print(f"Zipped '{folder_to_zip}' into '{output_zip}' successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while zipping: {e}")
else:
    print(f"Folder '{folder_to_zip}' does not exist.")