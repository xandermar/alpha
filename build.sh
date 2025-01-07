# filename: build.sh

echo "Install dependencies"
sudo apt-get install -y jq sass

echo "Remove everything in DOCS"
rm -rf docs/* &&

echo "Copy views to docs/"
cp views/primary.html docs/index.html &&

echo "Build dynamic content"
curl -o content.json https://raw.githubusercontent.com/xandermar/action-build/refs/heads/main/content.json
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

echo "Deploy to GitHub"
# Check if there are any changes
if [[ $(git status --porcelain) ]]; then
# If there are changes, add, commit, and push
git config --global user.email "GitHub@xandermar.com" &&
git config --global user.name "GitHub Actions Builder" &&
git add . &&
git commit -m "Run BUILD" &&
git push origin main -f
else
echo "No changes to commit."
fi
