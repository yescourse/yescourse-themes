#!/bin/bash

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

pushd "${SCRIPT_DIR}"

export SASS_PATH=".:../../.."

CSS_PATH=../../css

options="--style compressed"

compiler=sass

if [ "$1" = "--expanded" ]
then
    options="--style expanded"
fi

# path where relative imports can be found (assumes run from scss/ dir)
options="$options -I $SCRIPT_DIR"

function compile()
{
	echo "Compiling $1 to ${CSS_PATH}/$2 using ${compiler}"
	mkdir -p ${CSS_PATH}
	# shellcheck disable=SC2086
	${compiler} ${options} "$1" ${CSS_PATH}/"$2"
}

file=theme.scss
compile ${file} ${file%.scss}.css

popd
