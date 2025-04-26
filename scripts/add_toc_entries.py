#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import re
import glob

def add_toc_entries_to_file(file_path):
    """
    Add \addcontentsline commands to section and subsection headings in LaTeX files.
    """
    print(f"Processing: {file_path}")
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Add \addcontentsline to \section* commands
    modified_content = re.sub(
        r'(\\section\*{([^}]+)})',
        r'\1\n\\addcontentsline{toc}{section}{\2}',
        content
    )
    
    # Add \addcontentsline to \subsection* commands
    modified_content = re.sub(
        r'(\\subsection\*{([^}]+)})',
        r'\1\n\\addcontentsline{toc}{subsection}{\2}',
        modified_content
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
        add_toc_entries_to_file(file_path)

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