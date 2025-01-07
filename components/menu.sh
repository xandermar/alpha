# Filename: menu.sh

# list all directories in DOCS to array
items=($(ls -d docs/*/ | xargs -n 1 basename))

# loop through the array
for item in "${items[@]}"; do
  echo "<a href=\"/$item\">$item</a>"
done