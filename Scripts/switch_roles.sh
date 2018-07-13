#!/bin/bash

OATH_SECRET='J7TE6OBQM76BOMVUABT7AUQMJQZLAXRMXTATFNSLDTFJ242RKE5UCKHVATP2V672'

role=''
token=''
user=''
env=0
gateway_id='352584152229'
token=$(oathtool --totp -b $OATH_SECRET)

show_help () {
read -d '' help <<- EOF
Usage:
  aws-login [-<account option> | -a <account name>][-u <username>][-r <role name>][-h]

Options:
  -r  Set the role to assume. [required]
  -u  Set the username to use. [required]
  -d  Set the account to Sandbox. [default]
  -l  Set the account to Legacy.
  -p  Set the account to Production.
  -s  Set the account to Staging.
  -h  Show the help screen.

Examples:
  aws-login -u JohnDoe -r ReadOnly -d
EOF

printf "\n$help\n\n"

}

# Reset in case getopts has been used previously in the shell.
OPTIND=1

# Parse command line args
while getopts "dhlpr:st:u:a:" opt; do
  case "$opt" in
    d)
      env=0
      ;;
    h)
      show_help
      return 0
      ;;
    l)
      env=1
      ;;
    p)
      env=3
      ;;
    r)
      role=$OPTARG
      ;;
    s)
      env=2
      ;;
    u)
      user=$OPTARG
      ;;
    *)
      echo 'Invalid option, see usage...'
      show_help
      return 1
      ;;
  esac
done

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

account_id=''
case $env in
  0)
    account_name="Sandbox"
    account_id="340753100125"
    ;;
  1)
    account_name="Legacy"
    account_id="640607819574"
    ;;
  2)
    account_name="Staging"
    account_id="281059476650"
    ;;
  3)
    account_name="Production"
    account_id="058511034767"
    ;;
esac

if [ -z "$role" ]; then
  printf '\e[91mError! No role name provided.\n'
  return 1
fi

if [ -z "$token" ]; then
  printf '\e[91mError! No MFA token provided.\n'
  return 1
fi

if [ -z "$user" ]; then
  printf '\e[91mError! No user provided.\n'
  return 1
fi

printf "\nLogging into \e[93m$account_name ($account_id)\e[0m as \e[93m$role\e[0m using Token of \e[93m$token\e[0m\n"

serial='arn:aws:iam::'$gateway_id':mfa/'$user
result=`aws sts assume-role --role-arn arn:aws:iam::$account_id:role/$role --role-session-name $user --output json --serial-number $serial --token-code $token`

if [ $? -ne 0 ]; then
  return 1
fi

key_id=`echo $result | jq -r '.Credentials.AccessKeyId'`
secret_key=`echo $result | jq -r '.Credentials.SecretAccessKey'`
session_token=`echo $result | jq -r '.Credentials.SessionToken'`

printf "\e[32mSuccessfully Setup AWS Session!\n\n"


export AWS_CURRENT_ACCOUNT="$account_name ($account_id)"
export AWS_CURRENT_ROLE=$role
export AWS_ACCESS_KEY_ID=$key_id
export AWS_SECRET_ACCESS_KEY=$secret_key
export AWS_SESSION_TOKEN=$session_token

