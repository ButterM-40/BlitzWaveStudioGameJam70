#!/bin/sh
echo -ne '\033c\033]0;Spirits of the Wild\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/GameJam-70.x86_64" "$@"
