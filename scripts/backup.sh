#!/bin/bash

# first delete previous backup
rclone delete -vv drive:minecraft/backups --drive-use-trash=false #--dry-run

# server backup dir
src_dir=/home/botond/servers/minecraft/survival-2022/Backups/

# num of files
n=3

# get array of paths of top n files sorted by date modified
mapfile -t files < <(ls -t $src_dir | head -n $n)

# for each file name
for file in "${files[@]}"; do
        # get abs path by concat with src dir with each file name
        abs_path=$(readlink -f "$src_dir/$file")
        # upload file via abs path to drive
        rclone copy -vv $abs_path drive:minecraft/backups #--dry-run
done
