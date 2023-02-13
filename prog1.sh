#! /bin/bash

# Contants; add more if necessary
MISSING_ARGS_MSG="src and dest missing"
MORE_ARGS_MSG="Exactly 2 arguments required"

# FILL
bak_dir(){
	count=`find $1 -mindepth 1 -maxdepth 1 -name *.c| wc -l`
	move_current_dir="y"
	if [ $count -gt 3 ] ; then
		read -p "these files are going to be moved, press y/Y to continue: " input
		if [[ $input != "y" ]] && [[ $input != "Y" ]] ; then
		    move_current_dir="n"
		fi
	fi
	if [[ $move_current_dir == "y" ]] ; then
	    for file in `find $1 -mindepth 1 -maxdepth 1 -name "*.c"`
	    do
	    	echo $file
	    	fileName=${file##*/}
	    	mv $file $2"/"$fileName
	    done
	fi
    

    for file in `find $1 -mindepth 1 -maxdepth 1 -d`
    do
        if [ -d $file ]
        then
            if [[ $file != '.' && $file != '..' ]]
            then
            	dirName=${file##*/}
            	destDir=$2"/"$dirName
            	mkdir $destDir
                bak_dir $file $destDir
            fi
        fi
    done
}

if [ $# == 0 ] ; then
echo $MISSING_ARGS_MSG
exit 1;
fi
if [ $# != 2 ] ; then
echo $MORE_ARGS_MSG
exit 1;
fi

if [ ! -d $1 ]; then
  echo "src not found"
  exit 1;
fi

srcDir=${1##*/}
destDir=$2"/"$srcDir

if [ -d $2 ]; then
  rm -rf $2
fi
mkdir $2

if [ -d $destDir ]; then
  rm -rf $destDir
fi
file_count=`find $1 -name *.c | wc -l`
[[ $file_count -gt 0 ]] && mkdir $destDir
bak_dir $1 $destDir
