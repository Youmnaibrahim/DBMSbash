#!/bin/bash

export LC_COLLATE=C
shopt -s extglob


function taplenameconstrain(){
var='!@#$%^&*()'
listdatabases
read -p "enter your database you want to access " name
read -p "enter your table name " table
if  [[  $table =~ [0-9]+$ ]]; then
        echo " ERROR name of table can not contain number"
        taplenameconstrain
elif
    [[ $table =~ [$var] ]];  then
         echo " ERROR name of taple can't have regex"
         taplenameconstrain
elif
    [[ -z "$table" ]];  then
         echo "ERROR taple can't be empty"
         taplenameconstrain
elif 
    [[  $table = *" "* ]];  then
         echo "ERROR taple can't contain spaces"
         taplenameconstrain
else 
    touch databases/$name/$table
    touch databases/$name/.metadata/$table
    createcolumn databases/$name/.metadata/$table
fi

}
taplenameconstrain


#-------------------------------------------------------


function createcolumn(){
   while true:
   do
    read -p "enter the number of coloum " coloumnumber
    if [[ $coloumnumber =~ ^[0-9]+$ ]]; then
    for (( i = 1 ; i <= $coloumnumber ; i++ ))
    do
        while true;
        do
            read -p "enter column name " cn
            if [[ -z $cn ]]  || [[ ! $cn =~ ^[a-zA-Z]+[a-zA-Z0-9]*$  ]]; then
                echo "column field must be charachters only"
            else
                break
            fi
        done
        if (( $i == $columnnumber )); then
            echo "$cn" >> $1 
            echo "database created succefully"
            mainmenu
        elif (( $i < $columnnumber )); then
            echo -e "$cn;" >> $1 
        fi 
    else
        echo "column number cannot be empty or string"
    fi

    done

}





