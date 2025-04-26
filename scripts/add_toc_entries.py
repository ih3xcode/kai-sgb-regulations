#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import re
import glob

def add_toc_entries_to_file(file_path):
    """
    Add \addcontentsline commands to section and subsection headings in LaTeX files,
    but only if they don't already exist.
    """
    print(f"Processing: {file_path}")
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Function to check if a section already has an addcontentsline
    def replace_if_needed(match):
        full_match = match.group(1)  # Full section/subsection command
        title = match.group(2)       # Just the title content
        toc_type = "section" if "\\section" in full_match else "subsection"
        
        # Check if there's already an addcontentsline after this heading
        # Looking for the pattern: the heading, possibly followed by whitespace, 
        # followed by an \addcontentsline with the same title
        pattern = re.escape(full_match) + r'\s*\\addcontentsline\{toc\}\{' + toc_type + r'\}\{' + re.escape(title) + r'\}'
        if re.search(pattern, content):
            # If it already exists, just return the original heading
            return full_match
        else:
            # If it doesn't exist, add the addcontentsline
            return f"{full_match}\n\\addcontentsline{{toc}}{{{toc_type}}}{{{title}}}"
    
    # Process section headings
    modified_content = re.sub(
        r'(\\section\*{([^}]+)})',
        replace_if_needed,
        content
    )
    
    # Process subsection headings in the already modified content
    modified_content = re.sub(
        r'(\\subsection\*{([^}]+)})',
        replace_if_needed,
        modified_content
    )
    
    # Only write to file if changes were made
    if content != modified_content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(modified_content)
        print(f"Updated: {file_path}")
    else:
        print(f"No changes needed for: {file_path}")

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