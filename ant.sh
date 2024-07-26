#!/bin/bash

function disp() {

clear
echo "EDITING $FILE"
echo ""
awk '{printf("%03d %s\n", NR, $0)}' $FILE | xargs -I {} echo -e "\e[33m{}\e[0m"
echo ""

}

[[ -n $1 ]] && FILE=$1 || FILE=0

while [ $FILE = 0 ] ; do

clear

echo '                                                                     '
echo '        _,-`\_                                                       '
echo '       `      `\                                                     '
echo '      _,-`\     |      ANT TEXT EDITOR                               '
echo '   ,-`     \ _ _|_     v0.0                                          '
echo '   `       /\   | \                                                  '
echo '         /\     /\ \   [f] - open a file                             '
echo '         \/     \/ /   [h] - print the help message                  '
echo '         |        /    [q] - quit ant                                '
echo '         /_ _    /                                                   '
echo '        //   ```\\                                                   '
echo '        \|      |/                                                   '
echo '                                                                     '
echo '                                                                     '

read -rp ": " START

case $START in
    f)
        read -rp "FILE NAME: " FILE
        touch $FILE; break
        ;;
    q)
        clear
        exit
        ;;
esac

done

# ----------

while true; do

disp

read -rp ": " INPUT

case $INPUT in
    !i)
        disp
        read -rp "LINE: " LINE
        read -rp "INSERT: " TEXT
        sed -i ''$LINE'i'$TEXT'' $FILE
        ;;
    !r)
        disp
        read -rp "LINE: " LINE
        read -rp "INSERT: " TEXT
        sed -i -e ''$LINE'd' $FILE && sed -i ''$LINE'i'$TEXT'' $FILE
        ;;
    !a)
        disp
        read -rp "APPEND: " TEXT
        echo $TEXT >> $FILE
        ;;
    !x)
        disp
        read -rp "LINE: " LINE
        sed -i -e ''$LINE'd' $FILE
        ;;
    !f)
        disp
        read -rp "FILE: " FILE
        touch $FILE
        ;;
    !c)
        disp
        read -rp "LINE: " LINE
        CB=$(sed -n ''$LINE'p' $FILE)
        echo $CB
        ;;
    !pr)
        disp
        read -rp "LINE: " LINE
        sed -i -e ''$LINE'd' $FILE && sed -i ''$LINE'i'$CB'' $FILE
        ;;
    !pi)
        disp
        read -rp "LINE: " LINE
        sed -i ''$LINE'i'$CB'' $FILE
        ;;
    !pa)
        disp
        echo $CB >> $FILE
        ;;
    !q)
        clear
        exit
        ;;
    *)
        echo $INPUT >> $FILE
        ;;
esac

done