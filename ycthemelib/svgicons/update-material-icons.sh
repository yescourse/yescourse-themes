#!/usr/bin/env bash

# download the material icon repo -
# git clone https://github.com/google/material-design-icons.git
# run this script and pass the path to the downloaded repo as well as the path
# to the output scss file


material_repo=$(readlink -f $1)
output_file=$(readlink -f $2)

script_dir=$(dirname "$(readlink -f "$0")")

work_dir=$(mktemp -d)

# create symlinks to original svgs, the purpose of this is to clean the name of
# the svg, as the iconsvg2scss script uses the name of the file to name the icon
cd ${work_dir}
echo "Preparing SVGs for conversion..."

svgs=$(find ${material_repo} -maxdepth 4 -type f -wholename "*/production/*_24px.svg")
cleaned_svgs=
for svg in ${svgs}
do
	cleaned_name=$(basename ${svg} | sed 's/ic_//'| sed 's/_24px//')
	if [ ! -e ${cleaned_name} ]
	then
		ln -s ${svg} ${cleaned_name}
		cleaned_svgs="${cleaned_svgs} ${work_dir}/${cleaned_name}"
	fi
done

echo "Creating scss..."
python ${script_dir}/iconsvg2scss.py 'YC-MATERIAL_ICON__DATA' ${cleaned_svgs} > ${output_file}

rm -rf ${work_dir}
