#!/bin/bash
# Copyleft deageseage at core12 2022

PATH1='kassa.yml'
PATH2='roles/debops.docker/tasks/main.yml'
FLAG='--syntax-check'
# colors:
PURPLE='\033[4;34m'
NC='\033[0m' # no color
WIDTH=$(tput cols) # size of terminal window.
ERR='^[1-4]$' # validation check.
PATH3="$1"

clear_screen() {
    echo -en '\033c'
}

print_string() {
    for (( i=0; i<$((WIDTH/2 - ((${#1}) - 1)/2)); i++));
    do
        echo -en ' '
    done
    echo -en "$1\n"
}

print_line() {
    echo -en "$PURPLE"
    for (( i=0; i<"$WIDTH"; i++))
    do
        echo -en ' '
    done
    echo -en "$NC\n\n"
}

start_page() {
    clear_screen
    print_line
    print_string 'This script will check syntax of playbook' 
    print_string 'choose playbook to check.' 
    print_string 'press:' 
    print_string "|1| to play $PATH1" 
    print_string "|2| to play $PATH2" 
    print_string '|3| to enter your path.'
    print_string '|4| to quit this script.'
    print_line
    read -r CHOOSE_PATH

    if ! [[ "$CHOOSE_PATH" =~ $ERR ]]
    then
        clear_screen
        start_page
    fi
}
check_yaml() {
    clear_screen
    print_line
    print_string 'yamllint start'
    yamllint "$1"
    print_line
    print_string 'yamllint end'
    print_line
    ansible-playbook "$FLAG" "$1"
}

if [[ -n "$PATH3" ]]
then
    yamllint "$PATH3"
    ansible-playbook "$FLAG" "$PATH3"
    exit 0
else
    start_page
fi

if [ "$CHOOSE_PATH" == 1 ]
then
    check_yaml "$PATH1"
fi

if [ "$CHOOSE_PATH" == 2 ]
then
    check_yaml "$PATH2"
fi

if [ "$CHOOSE_PATH" == 3 ]
then
    clear_screen
    print_line
    print_string 'enter path to your playbook.'
    print_string 'example: /path/playbook.yml'
    print_line
    read -r PATH3
    check_yaml "$PATH3"
fi

if [ "$CHOOSE_PATH" == 4 ]
then
    clear_screen
    exit 0
fi

