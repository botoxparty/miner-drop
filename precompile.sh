#!/bin/sh

zipFile="stak.zip"
stakDirectory="xmr-stak-2.1.0"
cleanup="rm -rf stak* && rm -rf xmr*"

echo "*********** BUILDING ***********"

eval $cleanup

wget https://codeload.github.com/fireice-uk/xmr-stak/zip/v2.1.0 -O $zipFile
unzip -q $zipFile
cd $stakDirectory

PS3='Select the platform: '
options=("NVIDIA" "AMD" "CPU")
select opt in "${options[@]}"
do
  case $opt in
      "NVIDIA")
        brew tap caskroom/drivers
        brew cask install nvidia-cuda
        brew install hwloc libmicrohttpd gcc openssl cmake
        cmake . -DOPENSSL_ROOT_DIR=/usr/local/opt/openssl -DOpenCL_ENABLE=OFF
        make install
        break
        ;;
      "AMD")
        echo "Wrong arguments"
        exit 1
        ;;
      "CPU")
        brew install hwloc libmicrohttpd gcc openssl cmake
        cmake . -DOPENSSL_ROOT_DIR=/usr/local/opt/openssl -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF
        make install
        break
        ;;
      *)
        echo $opt
        echo "Wrong arguments"
        exit 1
        ;;
  esac
done

cp ../com.miner.stak.plist ./bin
cp ../config.txt ./bin
cp ../cpu.txt ./bin
cd "./bin" && tar -zcvf ../../bin/binaries.tar.gz .
cd ../..
eval $cleanup


echo "*********** FINISHED: ./bin/binaries.tar.gz is your output ***********"
