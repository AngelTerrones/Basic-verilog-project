#!/bin/bash
#-------------------------------------------------------------------------------
# Copyright (C) 2015 Angel Terrones <angelterrones@gmail.com>
#-------------------------------------------------------------------------------
#
# File Name: create_bitstream.sh
#
# Author:
#             - Angel Terrones <angelterrones@gmail.com>
# Description:
#       Generate FPGA bitstream
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Parameter check
#-------------------------------------------------------------------------------
EXPECTED_ARGS=5
if [ $# -ne $EXPECTED_ARGS ]; then
    echo ""
    echo "ERROR : wrong number of arguments"
    echo "USAGE : create_bitstream.sh <fpga part> <build folder> <bitstream folder> <project name> <tope file>"
    echo ""

    exit 1
fi

#-------------------------------------------------------------------------------
# move to workspace
#-------------------------------------------------------------------------------
cd $2

#-------------------------------------------------------------------------------
# copy UCF, xst_verilog, and configure xst file
#-------------------------------------------------------------------------------
cp -f ../ucf/pines.ucf $4.ucf
cp ../scripts/xst_verilog.opt .
sed -i "s/TOPE/$5/g" ./xst_verilog.opt

#-------------------------------------------------------------------------------
# Execute XFLOW
#-------------------------------------------------------------------------------
xflow -p $1                      \
      -implement high_effort.opt \
      -config bitgen.opt         \
      -synth xst_verilog.opt     \
      ./$4.prj

#-------------------------------------------------------------------------------
# copy bitstream to root folder
#-------------------------------------------------------------------------------
mkdir -p $3
cp -f ./$4.bit $3/.
