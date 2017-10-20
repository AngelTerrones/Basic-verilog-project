SHELL=bash

.FOUT=out
.PYTHON=python3
.PYTEST=pytest

.RTL_FOLDER=$(shell cd rtl; pwd)
.VERILOG_FILES=$(shell find $(.RTL_FOLDER) -name "*.v")
.TEST_FOLDER=$(shell cd test; pwd)
.SCRIPT_FOLDER=$(shell cd scripts; pwd)

#-------------------------------------------------------------------------------
# XILINX ISE
#-------------------------------------------------------------------------------
.ISE_BIN=/opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64
#.ISE_BIN=/cygdrive/c/Xilinx/14.7/ISE_DS/ISE/bin/nt
.PROJECT_NAME=Uname
.TOPE_V=tope
.FPGA=xc3s200-ft256-4
.BIT_FOLDER=bitstream

export PATH:=$(.ISE_BIN):$(PATH)
.PHONY: default clean distclean

# ********************************************************************
# Verification
# ********************************************************************
check_driver:
	@verilator --lint-only $(.RTL_FOLDER)/driver7seg.v && echo "CHECK: OK"

check_alu:
	@verilator --lint-only $(.RTL_FOLDER)/alu.v && echo "CHECK: OK"

check_tope:
	@verilator --lint-only rtl/tope.v rtl/driver7seg.v rtl/alu.v && echo "CHECK: OK"

test_alu: check_alu
	@mkdir -p $(.FOUT)/
	@$(.PYTEST) --tb=short test/test_alu.py

# ********************************************************************
# Implementation
# ********************************************************************
build-prom: $(.FOUT)/$(.BIT_FOLDER)/$(.PROJECT_NAME).mcs

program-fpga: build-prom
	@$(.SCRIPT_FOLDER)/program_fpga.sh $(.PROJECT_NAME) $(.BIT_FOLDER) $(.FOUT)

# ---
$(.FOUT)/$(.BIT_FOLDER)/$(.PROJECT_NAME).mcs: $(.VERILOG_FILES) ucf/pines.ucf
	@mkdir -p $(.FOUT)
	@$(.SCRIPT_FOLDER)/create_project.sh $(.RTL_FOLDER) $(.FOUT) $(.PROJECT_NAME)
	@$(.SCRIPT_FOLDER)/create_bitstream.sh $(.FPGA) $(.FOUT) $(.BIT_FOLDER) $(.PROJECT_NAME) $(.TOPE_V)
	@$(.SCRIPT_FOLDER)/generate_prom_file.sh $(.PROJECT_NAME) $(.BIT_FOLDER) $(.FOUT)

# ********************************************************************
# Clean
# ********************************************************************
clean:
	@rm -rf $(.FOUT)/
	@find . | grep -E "(\.vcd)" | xargs rm -rf

distclean: clean
	@find . | grep -E "(__pycache__|\.pyc|\.pyo|\.vcd|\.cache)" | xargs rm -rf
