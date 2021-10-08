#!/bin/bash
red=$'\e[1;31m'
grn=$'\e[1;32m'
ylw=$'\e[1;33m'
end=$'\e[0m'

if [ ${#@} == 0 ]; then
    echo -e "Test Script, args not required:\n-f: First\n-s: Second"
fi

print_usage() {
    echo -e "Test Script, args not required:\n-f: First\n-s: Second"
}

# : after variable means it's required
while getopts 'f s' flag; do
  case "${flag}" in
    f) first=t ;;
    s) second=t ;;
    *) print_usage
       exit 1 ;;
  esac
done


if [ "$first" -a "$second" ]; then
    echo "$red" "First and Second" "$end"
elif [ "$first" -a ! "$second" ]; then
  echo "$red" "First" "$end"
elif [ "$second" -a ! "$first" ]; then
  echo "$red" "Second" "$end"
fi