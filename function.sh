#!/bin/bash

export LC_COLLATE=C
shopt -s extglob


#------------------------------------------------------------------------------------------------
#mainmenu form here we should start

function mainmenu(){
echo "welcome to main menu of data base"

select choice in  "Create New Database" "Show Databases" "Use Database" "Delete Database" "quit"
do
    case $REPLY in 
        1)
        . ./createDB.sh
          ;; 
        2) 
        . ./showDB.sh 
          ;;
        3)
         . ./useDB.sh 
          ;;
        4) 
        . ./deleteDB.sh
          ;;
        5)
            exit
          ;; 
    esac 
done
}
#-----------------------------------------------------------
#create new database

createDB() {
var='!@#$%^&*()'
echo "enter name of new Database name" 
    read name 
        if  [ -d databases/$name ]; then
             echo "this database is aleady exist"
              createDB
        elif [[ $name =~ [$var] ]];  then
             echo "data base can't have regex"
              createDB
        else
             mkdir databases/$name
             mkdir databases/$name/.metadata
             echo database created sussesful 
             mainmenu
        fi
}
#--------------------------------------------------------------
#backmenu
function backmenu(){
select choice in  "Create New Database" "Back to mainmenu" "Exit" 
do
    case $REPLY in 
        1)
             createDB
             ;; 
        2) 
             mainmenu
             ;;
        3)
             exit
             ;;
    esac 
done
}

#-----------------------------------------------------------------------------------
#deletedatabase


function deletedatabase(){

if [ -e databases/$name ]; then
     ls databases
     echo "enter database that you want to delete : "
     read name 
     
     rm -r databases/$name
     echo "successful delete database $name"

else  
    echo "database not found"
fi
}

#--------------------------------------------------------
#listing databases

function listdatabases() {
dir=databases
if [ "$(ls -A $dir)" ]; then
    ls $dir

else 
    echo "$dir is empty"
fi
}

#-------------------------------------------------------------
# this function for meni for tables
function main_menu_table(){

select choice in  "show tables" "create new table" "insert into table" "Delete table" "update table" "return to main menu"
do
    case $REPLY in 
        1)
        . ./showtables.sh
          ;; 
        2) 
        . ./createtable.sh 
          ;;
        3)
         . ./insertintotable.sh 
          ;;
        4) 
        . ./deletetable.sh
          ;;
        5)
         . ./updatetable.sh
          ;; 
        6)
         . ./mainmenu.sh
    esac 
done
}
#----------------------------------------------------------------------------
#this function for connect to databases 

function useDB(){
  # listdatabases
  # read -p "enter your database you want to access " myDB
  if [[ -d databases/$myDB  ]]; then
     echo "database is selsected $myDB"
     #cd databases/$myDB
      main_menu_table

  else
     echo "Database does not exist."
      mainmenu

  fi
}


#---------------------------------------------------------------------

#delete table
function deletetable(){

    listdatabases
    read  -p "enter you databasename " name
    ls databases/$name
    read  -p  "Enter Table Name " table 

    if [[ -e databases/$name/$table ]]; then 
        
        rm   databases/$name/$table
        echo "$table Table  deleted Successfully"
    else 
        echo "No such Table"
    fi

}
#-------------------------------------------------------------------------------

#this function to list tables

function listtables(){
listdatabases
read -p "echo enter your database name " name

if [ -n "$(ls -A databases/$name)" ]; then
        echo  "available tables"
         ls databases/$name
         return 0
else
    echo "no tables to show "
    return 1
fi
}
#-----------------------------------------------------
#functions  to create table
function taplenameconstrain(){
var='!@#$%^&*()'
listdatabases
if [ $? -eq 0 ]; then 
  while true;
  do 
  read -p "enter your database you want to access " name
  if [ -e databases/$name  ]; then
    break
  else
      echo "database doesnt exist"
  fi
  done
  while true;
  do
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
      touch databases/$name/.metadata/$table.meta
      chmod 777 databases/$name/.metadata/$table.meta
      chmod 777 databases/$name/$table
      createcolumn databases/$name/.metadata/$table.meta
      
      mainmenu
  fi
  done
elif [ $? -eq 1 ]; then
  backmenu
fi
}

function createcolumn(){
  declare -i coloumnumber
   while true;
   do
    read -p "enter the number of coloum " coloumnumber
    if [[ $coloumnumber =~ ^[0-9]+$ ]]; then
      break
    else
        echo "column number cannot be empty or string"
    fi
    done

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
        if (( $i == $coloumnumber)); then
            echo "$cn;" >> $1 
            echo "database created succefully"
            break
        elif (( $i < $coloumnumber )); then
            echo -e "$cn;" >> $1 
        fi 
    done
}