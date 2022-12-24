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
elif
    [[ $table =~ [$var] ]];  then
             echo " ERROR name of taple can't have regex"
elif
    [[ -z "$table" ]];  then
         echo "ERROR taple can't be empty"
elif 
    [[  $table = *" "* ]];  then
         echo "ERROR taple can't contain spaces"
else 
    touch databases/$name/$table
    touch databases/$name/.metadata/$table
    mainmenu
fi
}
taplenameconstrain


#-------------------------------------------------------

   




