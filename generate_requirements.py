#!/usr/bin/env python3
"""
Script to generate a clean requirements.txt from current environment
Filters out conda-specific file:// paths and keeps only pip-installable packages
"""

import subprocess
import sys
import re

def get_installed_packages():
    """Get all installed packages using uv pip freeze"""
    try:
        result = subprocess.run(['uv', 'pip', 'freeze'], 
                              capture_output=True, text=True, check=True)
        return result.stdout.strip().split('\n')
    except subprocess.CalledProcessError:
        print("Error: Could not run 'uv pip freeze'. Make sure uv is installed.")
        sys.exit(1)

def clean_requirements(packages):
    """Filter out packages with file:// paths and other conda-specific entries"""
    clean_packages = []
    
    for package in packages:
        package = package.strip()
        
        # Skip empty lines
        if not package:
            continue
            
        # Skip packages with file:// paths (conda-specific)
        if 'file:///' in package:
            continue
            
        # Skip packages with @ symbols that aren't editable installs
        if '@' in package and not package.startswith('-e'):
            continue
            
        # Skip conda-specific packages
        conda_packages = ['conda', 'conda-', 'libmamba', 'menuinst']
        if any(conda_pkg in package.lower() for conda_pkg in conda_packages):
            continue
            
        clean_packages.append(package)
    
    return clean_packages

def main():
    """Main function to generate clean requirements.txt"""
    print("🔍 Getting installed packages...")
    packages = get_installed_packages()
    
    print("🧹 Cleaning package list...")
    clean_packages = clean_requirements(packages)
    
    # Write to requirements_auto.txt
    output_file = 'requirements_auto.txt'
    with open(output_file, 'w') as f:
        f.write("# Auto-generated requirements.txt\n")
        f.write("# Created from current environment, filtered for pip compatibility\n\n")
        for package in sorted(clean_packages):
            f.write(f"{package}\n")
    
    print(f"✅ Generated {output_file} with {len(clean_packages)} packages")
    print(f"📝 Original environment had {len(packages)} packages")
    print(f"🚫 Filtered out {len(packages) - len(clean_packages)} conda-specific packages")

if __name__ == "__main__":
    main()
