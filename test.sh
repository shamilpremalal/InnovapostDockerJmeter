#!/bin/bash
#
# Test the JMeter Docker image using a test test plan.

TR_DIR=Test_Reports
TS_DIR=Test_Script
TD_DIR=Test_Data


# Reporting dir: start fresh
R_DIR=${TR_DIR}/Report/
rm -rf ${R_DIR} > /dev/null 2>&1
mkdir -p ${R_DIR}

/bin/rm -f ${TR_DIR}/result.jtl ${TR_DIR}/jmeter.log  > /dev/null 2>&1

./run.sh -Dlog_level.jmeter=DEBUG \
	-n -t ${TS_DIR}/google.jmx -l ${TR_DIR}/result.jtl -j ${TR_DIR}/jmeter.log -p ${TS_DIR}/user.properties \
	-e -o ${R_DIR}

echo "==== jmeter.log ===="
cat ${TR_DIR}/jmeter.log

echo "==== Raw Test Report ===="
cat ${TR_DIR}/result.jtl

echo "==== HTML Test Report ===="
echo "See HTML test report in ${R_DIR}index.html"
#########Entering Code to check if reports is generated#########

reportExistance=${R_DIR}index.html
if [ -f "$file" ]
then
	echo "$file found, Success in Generating Report."
else
	echo "$file not found, Error in Generating Report."
fi
################################################################
echo "=====Step 1: Create a folder with the current timestamp===="
M_DIR=${TR_DIR}/All_Reports/Report_$(date +"%d_%m_%Y_%H_%M")
rm -rf ${M_DIR} > /dev/null 2>&1
mkdir -p ${M_DIR}

echo "=====Step 2: Copy everything from /Reports to specific Folder==="
cp -r ${R_DIR} ${M_DIR}
echo "${M_DIR}"

#########Entering Code to check if reports is generated#########

reportExistance=${M_DIR}/index.html
if [ -f "$file" ]
then
	echo "$file found, Success in Retrieving Report."
else
	echo "$file not found, Error in Retrieving Report."
fi
################################################################

echo "=====Step 3: Pushing Files to Git==="
git add .
sleep 2
git commit -m "Adding Latest Reports $(date +"%d_%m_%Y_%H_%M")"
sleep 2
git push
sleep 15

echo "=====Step 4: Removing all Docker Containers/Images==="
docker stop $(docker ps -aq)
sleep 2
docker rm $(docker ps -aq)
sleep 2
docker rmi $(docker images -q)
sleep 2


