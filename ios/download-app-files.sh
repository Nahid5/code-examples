#!/bin/bash
# Downloads the application data from /private/var/containers/Bundle/Application/
# Downloads the ipa /var/mobile/Containers/Data/Application/
red=$'\e[1;31m'
grn=$'\e[1;32m'
ylw=$'\e[1;33m'
end=$'\e[0m'

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

app_folders=$(objection -N -h "$host" -g "$app_name" run env)
file_paths=$(echo "$app_folders" | grep -oP '/.*' | cut -d / -f -7)
out_array=($(echo "${file_paths[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
#out_array=("$sorted_unique_paths")

length=${#out_array[@]}
#echo "${out_array[*]}"
START=0
for (( c=$START; c<$length; c++ ))
do
  scp -r "$user"@"$host":"${out_array[$c]}" "$downloadloc"
done