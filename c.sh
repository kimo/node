#!/bin/sh

set -e

MAKE=make

if [ $OSTYPE = ""]
then
    echo "We are on freebsd"
    MAKE=gmake
fi

#if ["$os" = "freebsd7.0"]  
#then
#elif ["$os" = "freebsd8.4"]
#then
#    echo "We are on freebsd"
#    MAKE=gmake
#fi

echo "Script executed from: ${PWD}"
BASEDIR=$(dirname $0)
echo "Script location: ${BASEDIR}"

# check to see if node exists at $HOME
echo "comes here"
echo $HOME

os=${OSTYPE}

echo $os

NODE=${HOME}/bin/node

echo $NODE

REQUIRED_NODE_VERSION="v0.11.10"
if [ -x $NODE ]
then
    NODE_VERSION=`$NODE -v`
else
    NODE_VERSION=1
fi

echo $NODE_VERSION

PYTHON=python
PYTHON27=${HOME}/bin/python2.7
REQUIRED_PYTHON_VERSION="Python 2.7.6"

if [ -x $PYTHON27 ]
then
    echo "python exists"
    PYTHON_VERSION=`$PYTHON27 --version`
else
    PYTHON_VERSION="1"
fi

if [ $NODE_VERSION = $REQUIRED_NODE_VERSION ]
then
    echo "Correct version of node found!"
    exit 0
else
    echo "Installing the required node version '$REQUIRED_NODE_VERSION' "
    echo "===THIS IS A ONE TIME step for your environment. This takes about 10 minutes. Please be patient.= ==="
    if [ -x $PYTHON27 ]
    then
	echo "python exists"
	PYTHON_VERSION=`$PYTHON27 --version`
	echo "Correct version of python found!"
    else
	echo "Installing the required python version '$REQUIRED_PYTHON_VERSION' "
	echo "===THIS IS A ONE TIME step for your environment. This takes about 2 minutes. Please be patient.= ==="
	(cd ../Python-2.7.6; ./configure --prefix=$HOME; make; make install;)
	if [ -x $PYTHON27 ]
	then
	    echo "Python successfully installed" 
	else
	    echo "Python 2.7.6 installation failed. Aborting!!"
	    exit 1
	fi
    fi
    echo $HOME
    $PYTHON27 ./configure --prefix=$HOME
    $MAKE install

fi
