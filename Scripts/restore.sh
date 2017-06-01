#!/bin/bash
git rev-parse
if [ $? != 0 ] ; then
    exit 1
fi

if [ -z "$1" -o "$1" == " " ]; then
    target="~/Backup"
    echo "No target specified. Defaulting to \"$target\" ..."
else
    target=$1
fi

if [ -z "$2" -o "$2" == " " ]; then
    lst_fname="filenames.lst"
    echo "No list filename specified. Defaulting to \"$lst_fname\" ..."
else
    lst_fname=$2.lst
fi

br_name=`git rev-parse --abbrev-ref HEAD`
list="$target/$br_name/$lst_fname"
if [ -d "$target/$br_name" -a ! -e $list ]; then
    echo "Error! There is no list file($lst_fname) for current branch's($br_name) backup. Exiting ..."
    exit 1
fi

if [ ! -d "$target/$br_name" ]; then
    echo "There is no backup for the current branch($br_name)."$'\n'"Do you want to restore from backups of other branches (y/n)?"
    while true; do
        read answer

        if [ $answer = 'y' -o $answer = 'n' ]; then
            break;
        else 
            echo "Please enter y or n"
            continue;
        fi
    done

    if [ $answer = 'n' ]; then
        echo "No restore done. Good bye."
        exit 0
    else
        i=1
        declare -a arr
        echo "Please choose from one of the dirs:"
        dirs=`ls -d $target/*`
        while read line; do
            full_name=`echo $line | cut -d' ' -f9` 
            arr[${i}]=`basename $full_name`
            echo "$i: ${arr[${i}]}"
            ((i++))
        done < <(echo $dirs)
        read answer
        br_name=${arr[${answer}]}
        list=$target/$br_name/$lst_fname
    fi
fi

echo "Restoring from $target/$br_name"
cat $list | while read line; do path=`dirname $line`; fname=`basename $line`; echo "Copying $fname to $path" ; cp $target/$br_name/$fname $path; done
