#!/bin/bash
arr=( "$@" )
echo Your container args are: "$@"

service postfix start

name="name"

if [[ " ${arr[@]} " =~ " ${name} " ]]; then
    # put you commands here when array contains a value
    # echo "that is true"
    echo "Hi, this is $(uname) and you are here : $(pwd) && you have entered ${name}"
# else
#    echo "Please pass correct task name in argument"
#    echo "${arr[@]} is not equal to ${name}"

fi

ls="ls"
if [[ " ${arr[@]} " =~ " ${ls} " ]]; then
    # put you commands here when array contains a value
    # echo "that is true"
    echo "$(ls -ltrh)"

fi



chport="chport"
if [[ " ${arr[@]} " =~ " ${chport} " ]]; then

    for i in "${!arr[@]}"; do
    if [[ "${arr[$i]}" = "${chport}" ]]; then
        echo "the port is ${arr[$i+1]}"
        
        #sed -i "s/smtp      inet/${arr[$i+1]}      inet/g" /etc/postfix/master.cf
        sed -i -r "s/(.*?)(      inet.*?smtpd)/${arr[$i+1]}\2/g" /etc/postfix/master.cf

        postfix reload
        
    fi
    done
    


fi



banner="bnr"
if [[ " ${arr[@]} " =~ " ${banner} " ]]; then

    for i in "${!arr[@]}"; do
    if [[ "${arr[$i]}" = "${banner}" ]]; then
        echo "the proposed banner =>  ${arr[$i+1]}"
        

        sed -i -r "s/(smtpd_banner = )(.*\n?)/\1 ${arr[$i+1]}/g" /etc/postfix/main.cf

        postfix reload
        
    fi
    done
    


fi

alias="alias"
if [[ " ${arr[@]} " =~ " ${alias} " ]]; then

    for i in "${!arr[@]}"; do
    if [[ "${arr[$i]}" = "${alias}" ]]; then
        echo "the user =>  ${arr[$i+1]} mails redirect to ${arr[$i+2]}"
        

        echo "${arr[$i+1]}:      ${arr[$i+2]}" >> /etc/aliases
        newaliases
        postfix reload
        
    fi
    done
    
fi





deny="deny"


if [[ " ${arr[@]} " =~ " ${deny} " ]]; then

    for i in "${!arr[@]}"; do
    if [[ "${arr[$i]}" = "${deny}" ]]; then
        echo "deny  ${arr[$i+1]} mails"
        echo "${arr[$i+1]} REJECT" >> /etc/postfix/access      
        postmap /etc/postfix/access

        if grep -Fxq "smtpd_sender_restrictions = hash:/etc/postfix/access" /etc/postfix/main.cf
        then
            echo " smtpd_sender_restrictions already added to main.cf"
        else
            echo "smtpd_sender_restrictions = hash:/etc/postfix/access" >> /etc/postfix/main.cf
            echo "smtpd_sender_restrictions added to main.cf"

        fi

        postfix reload
        
    fi
    done
    
fi





bash="bash"
if [[ " ${arr[@]} " =~ " ${bash} " ]]; then
    # put you commands here when array contains a value
    echo "that is bash"
    /bin/bash

fi