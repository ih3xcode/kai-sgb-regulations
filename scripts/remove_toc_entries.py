#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import re
import glob

def remove_toc_entries_from_file(file_path):
    """
    Remove all \addcontentsline commands from LaTeX files.
    """
    print(f"Processing: {file_path}")
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Remove all \addcontentsline lines
    modified_content = re.sub(
        r'\\addcontentsline\{toc\}\{(?:section|subsection)\}\{[^}]+\}\n?',
        '',
        content
    )
    
    # Write the modified content back to the file
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(modified_content)
    
    print(f"Updated: {file_path}")

def process_directory(directory):
    """
    Process all .tex files in a directory.
    """
    print(f"Processing directory: {directory}")
    
    # Find all .tex files matching Розділ_*.tex pattern
    section_files = glob.glob(os.path.join(directory, 'Розділ_*.tex'))
    
    for file_path in section_files:
        remove_toc_entries_from_file(file_path)

def main():
    """
    Main function to process all directories.
    """
    directories = [
        'Положення_про_ОСС',
        'Положення_про_СУД',
        'Положення_про_СР_КАІ'
    ]
    
    for directory in directories:
        if os.path.isdir(directory):
            process_directory(directory)
        else:
            print(f"Warning: Directory not found: {directory}")

if __name__ == "__main__":
    main() 