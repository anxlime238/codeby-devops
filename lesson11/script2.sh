#!/bin/bash

# script2.sh предназначен для выполнения некоторых действий над файлами,
# созданными в результате выполнения script1.sh
#
# Изменения script2.sh по сравнению с предыдущей версией:
# 1. Добавлены комментарии
# 2. Константы переименованы и приведены в верхний регистр
# 3. Добавлены разные функции для выполнения разных участков кода
# 4. Добавлены коды выхода из функций

# Константы
TARGET_DIR="$HOME/myfolder"

# Функция предназначена для проверки наличия директории перед основными действиями
check_directory () {
	
	if [ ! -d "$TARGET_DIR" ]; then
	    echo "Folder $TARGET_DIR doesn't exist"
	    return 1 
	fi

	return 0
}

# Функция для подсчета количества файлов в директории
count_files() {

	num_files=$(find "$TARGET_DIR" -maxdepth 1 -type f | wc -l)
	echo "There are $num_files files in $TARGET_DIR"
	
	return 0
}

# Функция для смены прав на файл file_2
fix_permissions() {
	if [ -f "$TARGET_DIR/file_2" ]; then
	    chmod 644 "$TARGET_DIR/file_2"
	fi

	return 0
}

# Функция удаляет все пустые файлы,
# в НЕпустых файлах оставляет только первую строку
process_files() {
	for file in "$TARGET_DIR"/* ; do
	    if [ ! -f "$file" ]; then
	        continue
	    fi
	
	    if [ ! -s "$file" ]; then
	        rm "$file"
	        continue
	    fi
	
	    first_line=$(head -n 1 "$file")
	    echo "$first_line" > "$file"
	
	done

	return 0
}

# Добавляем условие для успешного выхода из скрипта при отсутствии директории,
# так как это не является ошибочной ситуацией
if ! check_directory; then
	exit 0
fi 

# Запуск необходимых функций

count_files
fix_permissions
process_files

exit 0
