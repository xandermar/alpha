# filename: build.sh

echo "Remove everything in DOCS"
rm -rf docs/* &&

echo "Copy views to docs/"
cp views/primary.html docs/index.html &&

echo "Implement all components"

echo "Deploy to GitHub"
git add . &&
git commit -m "Run BUILD" && 
git push origin main -f
