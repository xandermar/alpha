# filename: build.sh

echo "Install dependencies"
# Check if the operating system is Ubuntu
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "ubuntu" ]]; then
        echo "This is Ubuntu!"
        sudo apt-get install -y jq sass
    else
        echo "This is not Ubuntu. It's $ID."
    fi
else
    echo "Cannot determine the operating system."
fi

echo "Remove everything in DOCS"
rm -rf docs/* &&

echo "Copy CNAME to DOCS"
cp CNAME docs/

echo "Copy views to docs/"
cp views/primary.html docs/index.html &&

echo "Implment menu in docs/index.html"
# cat components/menu.sh to MENU
MENU=$(cat components/menu.sh)
# replace {menu} in docs/index.html with $MENU
sed -i 's/{menu}/<a href="\/articles">articles<\/a>/g' docs/index.html

echo "Build dynamic content"
curl -o content.json https://raw.githubusercontent.com/xandermar/alpha/refs/heads/main/content.json
# Read the content.json and create HTML files
cat content.json | jq -c '.[]' | while read entity; do
  path=$(echo "$entity" | jq -r '.path')
  html=$(echo "$entity" | jq -r '.html')
  file_name="docs/$path"
  mkdir -p "$(dirname $file_name)"
  echo "$html" > "$file_name"
  echo "Created: $file_name"
done

echo "Implement all components"

echo "Implement secondary view"
# find all directories in docs/ and copy views/secondary.html to each directory
items=($(ls -d docs/*/ | xargs -n 1 basename))
for item in "${items[@]}"; do
  cp views/secondary.html "docs/$item/index.html"
done

