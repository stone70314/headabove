#!/bin/bash

wget https://github.com/techcode1001/replit_root/releases/download/v1.0/yt.zip
unzip yt.zip
unzip root.zip 
tar -xvf root.tar.xz
sleep 5
./dist/proot -S . /bin/bash
