#!/bin/bash

SCRIPTDIR=`dirname "$(readlink -f "$0")"`

pushd ${SCRIPTDIR}

export SASS_PATH=".:../../.."

CSS_PATH=../../css

options="--style compressed"

# FIXME: once sassc is installed in the VM remove this and just use sassc
if [[ $(type -P sassc) ]]
then
    compiler=sassc
else
    compiler=scss
fi

if [ "$1" = "--expanded" ]
then
    options="--style expanded --line-numbers"
fi

if [ ${compiler} = "sassc" ]
then
    # sassc does not look at the SASS_PATH env, rather needs to be passed in
    options="$options --load-path $SASS_PATH"
fi

function compile()
{
	echo "Compiling $1 to ${CSS_PATH}/$2 using ${compiler}"
	mkdir -p ${CSS_PATH}
	${compiler} ${options} $1 ${CSS_PATH}/$2
}

for file in theme.scss
do
	compile ${file} ${file%.scss}.css
done

popd
