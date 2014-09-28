#!/bin/ksh

## Functions

check_type() {
if [[ -f $1 ]]
then
        check_file $1
elif [[ -d $1 ]] then
        echo ""
        echo "$1 is a directory. Going deeper...\n"
        echo "----"
        OLDPWD=`pwd`
        cd $1
        workingdir=`list_dir $1`
        while read subfile
        do
                echo "Checking $1/$subfile"
                check_type "$1/$subfile"
        done < "/tmp/temp.list"
        cd $OLDPWD
fi
}

check_file() {
        cksum $1
        echo "----"
}

list_dir() {
        if [[ -f "/tmp/temp.list" ]]; then
                rm "/tmp/temp.list"
        fi
        ls $1 > "/tmp/temp.list"
}


## Main program

WORKDIR=$1
check_type $WORKDIR

if [[ -f "/tmp/temp.list" ]]; then
        rm "/tmp/temp.list"
fi
