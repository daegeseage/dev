#!/bin/bash

FILE=$(cat "$1")

# COLOR='\033[0;38;5;208;48;5;118m' # orange with bright green background
COLOR='\033[0;38;5;208m' # orange.
NC='\033[0m' # no color. symbols which stop colorising text

# echo -en "$PURPLE"
echo -en "$COLOR"
echo -n "$FILE"
echo -e "$NC"
