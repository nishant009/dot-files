#!/bin/bash

# Put secret here
OATH_SECRET='' 
pin=$(oathtool --totp -b $OATH_SECRET)
printf  "\nAuth Pin: \e[92m${pin}\e[39m\n"
printf  "\e[34mPin saved to clipboard\e[39m\n\n"
echo $pin | pbcopy

