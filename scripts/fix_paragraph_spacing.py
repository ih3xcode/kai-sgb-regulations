#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import re
import glob
import difflib
import argparse

def fix_paragraph_spacing(file_path, overwrite=False):
    """
    Знаходить нумеровані пункти (як 1.1.1., 1.2.3.) і додає порожній рядок 
    після них, якщо такого ще немає.
    
    Args:
        file_path (str): Шлях до файлу для обробки
        overwrite (bool): Якщо True, перезаписується оригінальний файл. Якщо False, створюється новий файл з суфіксом _fixed
    """
    print(f"Обробка файлу: {file_path}")
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Зберігаємо оригінальні рядки для відображення diff
    original_lines = content.splitlines(True)
    
    # Замість послідовного застосування кількох регулярних виразів, 
    # використаємо підхід з обробкою рядків окремо
    lines = content.splitlines(True)  # True зберігає символи нового рядка
    modified_lines = []
    i = 0
    
    while i < len(lines):
        current_line = lines[i]
        modified_lines.append(current_line)
        
        # Перевіряємо, чи поточний рядок містить нумерований пункт або \end{enumerate}
        is_numbered_item = re.match(r'\s+\d+\.\d+\.\d+\.|\s+\d+\.\d+\.|\s+\d+\.', current_line)
        is_end_enumerate = r'\end{enumerate}' in current_line
        
        # Перевіряємо, чи після поточного рядка немає порожнього рядка
        needs_empty_line = False
        if (is_numbered_item or is_end_enumerate) and i < len(lines) - 1:
            next_line = lines[i + 1]
            if next_line.strip():  # Якщо наступний рядок не пустий
                needs_empty_line = True
        
        # Додаємо порожній рядок, якщо потрібно
        if needs_empty_line:
            modified_lines.append('\n')
        
        i += 1
    
    modified_content = ''.join(modified_lines)
    
    # Якщо були зміни, виводимо їх та зберігаємо файл
    if content != modified_content:
        # Відображення різниці (diff)
        diff = difflib.unified_diff(
            original_lines, 
            modified_content.splitlines(True),
            fromfile=f"{file_path} (до)",
            tofile=f"{file_path} (після)",
            n=3
        )
        
        print("\nЗміни:")
        diff_output = ''.join(diff)
        print(diff_output)
        
        # Визначаємо шлях для запису змін
        output_path = file_path
        
        # Запис змін у файл
        if overwrite:
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(modified_content)
            print(f"Файл оновлено: {output_path}")
    else:
        print(f"Файл не потребує змін: {file_path}")

def process_directory(directory, overwrite=False):
    """
    Обробляє всі .tex файли в директорії.
    """
    print(f"Обробка директорії: {directory}")
    
    # Знаходимо всі .tex файли, що відповідають шаблону Розділ_*.tex
    section_files = glob.glob(os.path.join(directory, 'Розділ_*.tex'))
    
    for file_path in section_files:
        fix_paragraph_spacing(file_path, overwrite)

def main():
    """
    Головна функція для обробки всіх директорій.
    """
    # Додаємо аргументи командного рядка
    parser = argparse.ArgumentParser(description='Виправлення форматування пунктів у .tex файлах')
    parser.add_argument('--overwrite', action='store_true', help='Перезаписувати оригінальні файли замість створення нових')
    args = parser.parse_args()

    directories = [
        'Положення_про_ОСС',
        'Положення_про_СУД',
        'Положення_про_СР_КАІ'
    ]
    
    for directory in directories:
        if os.path.isdir(directory):
            process_directory(directory, args.overwrite)
        else:
            print(f"Попередження: Директорія не знайдена: {directory}")

if __name__ == "__main__":
    main() 