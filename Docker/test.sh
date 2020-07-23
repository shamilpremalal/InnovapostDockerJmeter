#!/bin/bash
#
# Test the JMeter Docker image using a trivial test plan.

# Example for using User Defined Variables with JMeter
# These will be substituted in JMX test script
# See also: http://stackoverflow.com/questions/14317715/jmeter-changing-user-defined-variables-from-command-line

echo "PWD IS ============================================================================="
cd ..
PV_DIR=$(PWD)
PWD

TR_DIR=Test_Reports
TS_DIR=Test_Script
TD_DIR=Test_Data

# Reporting dir: start fresh
R_DIR=${TR_DIR}/Report
rm -rf ${R_DIR} > /dev/null 2>&1
mkdir -p ${R_DIR}

/bin/rm -f ${R_DIR}/result.jtl ${R_DIR}/jmeter.log  > /dev/null 2>&1

cd Docker
PWD
./run.sh -Dlog_level.jmeter=DEBUG \
	-n -t ${PV_DIR}/${TS_DIR}/google.jmx -l ${TR_DIR}/result.jtl -j ${TR_DIR}/jmeter.log \
	-e -o ${R_DIR}

cd ..
PWD
echo "==== jmeter.log ===="
cat ${R_DIR}/jmeter.log

echo "==== Raw Test Report ===="
cat ${R_DIR}/result.jtl

echo "==== HTML Test Report ===="
echo "See HTML test report in ${R_DIR}/index.html"

echo "=====Step 1: Create a folder with the current timestamp===="
M_DIR=${TR_DIR}/All_Reports/Report_$(date +"%d_%m_%Y_%H_%M")
rm -rf ${M_DIR} > /dev/null 2>&1
mkdir -p ${M_DIR}

echo "=====Step 2: Copy everything from /Reports to specific Folder==="
cp -r ${R_DIR} ${M_DIR}
echo "${M_DIR}"