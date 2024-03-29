#!/bin/bash

function trim() {
    if [ -z $1 ]; then # $1 is unset
        sed -e 's/^ *//' -e 's/ *$//'
    else
        sed -e 's/^ *//' -e 's/ *$//' -e "s/^$1//" -e "s/$1$//"
    fi
}

export TABLE_CONTENT=""

function table_column {
    local content=""
    for arg in $@; do
        content="$content | $arg"
    done
    TABLE_CONTENT="${TABLE_CONTENT}\n$content | "
}

function table_print(){
    echo -e $TABLE_CONTENT |  column -t
}

function get_timestamp(){
    echo $(date +%s)
}

# $1 : 配置文件路径
# $2 : section名称
# $3 : 键名称
function ini_get(){
    sed -n "/\[$2\]/,/\[/p" $1 | grep -v "\[" | grep $3 | awk -F '=' '{print $2}' | trim " "
}

