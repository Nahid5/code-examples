#!/bin/bash

if [ ${#@} == 0 ]; then
    echo -e "Download Important Files:\n-h: Host\n-u: SSH User\n-d: Download Location"
fi

print_usage() {
    echo -e "Download Important Files:\n-h: Host\n-u: SSH User\n-d: Download Location"
}

# : after variable means it's required
while getopts 'h:u:d:o' flag; do
  case "${flag}" in
    h) host="$OPTARG" ;;
    u) user="$OPTARG" ;;
    d) downloadloc="$OPTARG" ;;
    *) print_usage
       exit 1 ;;
  esac
done

frida-ps -a -H "$host"
echo -e "\n\n"
read -p "Select Identifier for App: " app_name
echo -e "\n"
objection -N -h "$host" -g "$app_name" run env

echo -e "\n\n"
read -p "Select paths to download. Seperate with a comma (,): " folders
echo -e "\n"

IFS=', ' read -r -a folder_list <<< "$folders"
for element in "${folder_list[@]}"
do
    #echo "$element"
    scp -r "$user"@"$host":"$element" "$downloadloc"
done