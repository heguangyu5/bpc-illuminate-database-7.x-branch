#!/bin/bash

[[ "$1" == "" ]] && {
    echo "Usage: ./bpc-prepare.sh src.list"
    exit
}

rm -rf ./Illuminate/Database/
rsync -a                        \
      --exclude=".*"            \
      -f"- Illuminate/"         \
      -f"+ */"                  \
      -f"- *"                   \
      ./                        \
      ./Illuminate/Database/

echo "placeholder-database.php" > ./Illuminate/src.list

for i in `cat $1`
do
    if [[ "$i" == \#* ]]
    then
        echo $i
    else
        echo "Database/$i" >> ./Illuminate/src.list
        filename=`basename -- $i`
        if [ "${filename##*.}" == "php" ]
        then
            echo "phptobpc $i"
            phptobpc $i > ./Illuminate/Database/$i
        else
            echo "cp       $i"
            cp $i ./Illuminate/Database/$i
        fi
    fi
done
cp bpc.conf Makefile ./Illuminate/
