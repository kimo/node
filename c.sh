#!/bin/sh
mkdir -p ~/local
DIR=$(echo ~/local)
echo $DIR
./configure --prefix=$DIR
