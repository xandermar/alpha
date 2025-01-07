# filename: build.sh

echo "Remove everything in DOCS"
rm -rf docs/* &&

echo "Copy views to docs/"
cp views/primary.html docs/index.html &&

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