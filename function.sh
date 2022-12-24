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
    
        elif [[ $name =~ [$var] ]];  then
             echo "data base can't have regex"
                
        else
             mkdir databases/$name
             mkdir databases/$name/.metadata
             echo database created sussesful 
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
else
    echo "no tables to show "
fi
}
