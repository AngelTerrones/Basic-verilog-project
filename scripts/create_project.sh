#!/bin/bash
#-------------------------------------------------------------------------------
# Copyright (C) 2014 Angel Terrones <angelterrones@gmail.com>
#-------------------------------------------------------------------------------
#
# File Name: create_project.sh
#
# Author:
#             - Angel Terrones <angelterrones@gmail.com>
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Parameter check
#-------------------------------------------------------------------------------
EXPECTED_ARGS=3
if [ $# -ne $EXPECTED_ARGS ]; then
    echo ""
    echo "ERROR : wrong number of arguments"
    echo "USAGE : create_project.sh <rtl folder> <build folder> <project name>"
    echo ""
    exit 1
fi

#-------------------------------------------------------------------------------
# Hardware folder
#-------------------------------------------------------------------------------
RTL_FOLDER=$1

#-------------------------------------------------------------------------------
# File project
#-------------------------------------------------------------------------------
FILE_PROJECT=$2/$3.prj

#-------------------------------------------------------------------------------
# Create project file
#-------------------------------------------------------------------------------
rm -f $FILE_PROJECT
touch $FILE_PROJECT

unamestr=`uname`

for module in $RTL_FOLDER; do
    for file in $(find $module -name "*.v")
    do
    if [[ "$unamestr" == 'Linux' ]]; then
        echo "\`include \"$file\"" >> $FILE_PROJECT
    else
        echo "\`include \"$(cygpath -w $file)\"" >> $FILE_PROJECT
    fi
    done
done
