# Compass config for the Helium theme

# speed up compilation
require "compass/import-once/activate"

# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "../../css/"
sass_dir = "./"
images_dir = "../../images/"
javascripts_dir = "../../js"

http_images_path = "../images/"

# You can select your preferred output style here (can be overridden via the command line):
output_style = :compressed  # :expanded or :nested or :compact or :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
line_comments = false


# Workaround for compiling in vagrant devel-env on windows hosts using vboxsf.
# Sets the sass-cache to a location that isn't in the shared folder
cache_path = "/tmp/.sass-cache"

add_import_path "."
add_import_path "../../../"  # allows us to import ycthemelib

# Use MD5 sum cache busters for assets
asset_cache_buster do |http_path, file|
  if file
    Digest::MD5.hexdigest(File.read(file.path))
  else
    none 
  end
end


