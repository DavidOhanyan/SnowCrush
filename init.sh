#!/bin/bash

for i in $(seq -w 0 14); do
    level_dir="level$i"
    flag_file="flag$i"
    
    mkdir -p "$level_dir/Ressources"
    
    touch "$level_dir/$flag_file"
    
    touch "$level_dir/Ressources/help.md"
done

echo "All levels have been reached and created successfully."

