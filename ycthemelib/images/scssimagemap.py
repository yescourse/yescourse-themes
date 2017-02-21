#!/usr/bin/env python
from __future__ import absolute_import, print_function, unicode_literals
from PIL import Image
import os
import subprocess
import sys

IMAGE_EXTENSIONS = {'.png', '.jpg', '.gif'}


def main(images_path, css_rel_path, output_path):
    images_path = os.path.abspath(images_path)
    image_data = []
    for subdir, dirs, files in os.walk(images_path):
        for file_name in files:
            __, ext = os.path.splitext(file_name)
            if ext.lower() not in IMAGE_EXTENSIONS:
                continue
            file_path = os.path.abspath(os.path.join(subdir, file_name))
            rel_path = os.path.relpath(file_path, images_path)
            image_info = {
                'path': rel_path,
                'url': os.path.join(css_rel_path, rel_path)
            }
            dimensions = get_dimensions(file_path)
            if not dimensions:
                continue
            image_info.update(dimensions)
            md5sum = get_md5sum(file_path)
            if not md5sum:
                continue
            image_info['md5'] = md5sum

            image_data.append(get_scss_map_entry(image_info))
    scss_map_str = '$YC-IMAGE_DATA: (\n   {}\n);'.format(',\n   '.join(image_data))
    with open(output_path, 'w') as output_file:
        output_file.write(scss_map_str.encode('utf-8'))
    return 0


def get_dimensions(image_file_path):
    try:
        image = Image.open(image_file_path)
        width, height = image.size
        return {
            'width': width,
            'height': height,
        }
    except IOError:
        return None


def get_md5sum(image_file_path):
    try:
        parts = subprocess.check_output(
            ['md5sum', image_file_path]
        ).split(' ')
        return parts[0]
    except subprocess.CalledProcessError:
        return


def get_scss_map_entry(image_info):
    return (
        '"{path}": (width: {width}, height: {height}, '
        'url: "{url}", md5: "{md5}")'.format(**image_info)
    )

if __name__ == '__main__':
    if len(sys.argv) < 4:
        sys.stderr.write(
            'Usage: {} <path to images> <path relative to CSS> '
            '<output file>\n'.format(
                sys.argv[0])
        )
        sys.exit(1)
    exit_code = main(sys.argv[1], sys.argv[2], sys.argv[3])
    sys.exit(exit_code)
