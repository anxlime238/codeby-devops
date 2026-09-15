#!/bin/bash

dir="$HOME/myfolder"

if [ ! -d "$dir" ]; then
    echo "Folder $dir doesn't exist"
    exit 0
fi

count_files=$(find "$dir" -maxdepth 1 -type f | wc -l)
echo "There are $count_files files in $dir"

if [ -f "$dir/file_2" ]; then
    chmod 644 "$dir/file_2"
fi

for file in "$dir"/* ; do
    if [ ! -f "$file" ]; then
        continue
    fi

    if [ ! -s "$file" ]; then
        rm "$file"
        continue
    fi

    first=$(head -n 1 "$file")
    echo "$first" > "$file"

done
