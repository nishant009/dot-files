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

br_name=`git rev-parse --abbrev-ref HEAD`
target=$target/$br_name
mkdir -p $target

if [ -z "$2" -o "$2" == " " ]; then
    lst_fname="filenames.lst"
    echo "No list filename specified. Defaulting to \"$lst_fname\" ..."
else
    lst_fname=$2.lst
fi

list="$target/$lst_fname"
base=`pwd`
git status | while read line; do if echo $line | grep -q "modified:"; then fname=`echo $line | sed -e 's/modified: //g'`; echo "$base/$fname" >> $list; echo " Copying $fname to $target"; cp $fname $target; fi done
