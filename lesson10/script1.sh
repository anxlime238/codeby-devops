#!/bin/bash

dir="$HOME/myfolder"
mkdir -p "$dir"

echo "Hello, world!" > "$dir"/file_1
date >> "$dir"/file_1

> "$dir"/file_2
chmod 777 "$dir"/file_2

tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 20 > "$dir"/file_3

> "$dir"/file_4
> "$dir"/file_5
