#!/usr/bin/env bash
#
# This script encrypt and decrypt files
FILE_NAME="$1"
ENC=".enc"
SCRIPT_NAME="ns_encrypt"

encrypt_func() {
    if openssl enc -aes-256-cbc -a -salt -in "$FILE_NAME" -out "$FILE_NAME""$ENC"
    then
        rm -rf "$FILE_NAME"
    fi
}

decrypt_func() {
    cut_ecn_end_func;
    if openssl enc -d -aes-256-cbc -a -in "$FILE_NAME""$ENC" -out "$FILE_NAME"
    then
        rm -rf "$FILE_NAME""$ENC"
    fi
}

check_enc_func() {
    END=".$(echo "$FILE_NAME" | awk -F "." '{print $(NF)}')"
    if [ "$ENC" == "$END" ]
    then
        return 0;
    else
        return 1;
    fi
}

cut_ecn_end_func() {
    FILE_NAME="$(printf %s "${FILE_NAME//$ENC/}")"
}

usage_func() {
    echo "usage: $SCRIPT_NAME <file>"
    echo "use $SCRIPT_NAME -h to dispay help"
}
if_file_name_set_func() {
    if [ -z "$FILE_NAME" ]
    then
        usage_func
        exit 1
    fi
}

test_file_correct_func() {
    if [ -d  "$FILE_NAME" ]
    then
        echo "$FILE_NAME is directory"
        exit 1
    fi
    if [ ! -f  "$FILE_NAME" ]
    then
        echo "not such file"
        exit 1
    fi
}

main() {
    if_file_name_set_func
    test_file_correct_func
    if check_enc_func
    then decrypt_func
    else encrypt_func
    fi
}
main
