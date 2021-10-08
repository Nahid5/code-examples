#!/bin/bash
red=$'\e[1;31m'
grn=$'\e[1;32m'
ylw=$'\e[1;33m'
end=$'\e[0m'

#How to test: ./args-required-read-file.sh -f aa -s aa -n test-numbers-file.txt

if [ ${#@} == 0 ]; then
    echo -e "Test Script, args not required:\n-f: First\n-s: Second\n-n: Numbers"
fi

print_usage() {
    echo -e "Test Script, args not required:\n-f: First\n-s: Second\n-n: Numbers"
}

# : after variable means it's required
while getopts 'f:s:n:o' flag; do
  case "${flag}" in
    f) first="$OPTARG" ;;
    s) second="$OPTARG" ;;
    n) numbers="$OPTARG" ;;
    o)
        if [ ! -z "$OPTARG" ]
        then
            opt="$OPTARG"
        fi
        ;;
    *) print_usage
       exit 1 ;;
  esac
done


#Numbers file

if [ ! -z "$numbers" ]
then
   list_of_nums=$(<$numbers)
    ##If you mean the naked - at the end of the tar command, that's common on many commands that want to use a file.
    echo "Pipe Content As File" | cat - 
    while read -r i; do
        if [ ! -z "$first" ]
        then
            #Execute command and get output
            output=$(python3 test.py "$i")
        fi
        if [[ $output == *"Not"* ]];
        then
          echo "$red" "$i is not a number" "$end"
        elif [[ $output == *"Is"* ]];
        then
          echo "$grn" "$i is a number" "$end"
        fi
    done <<< "$list_of_nums"
fi