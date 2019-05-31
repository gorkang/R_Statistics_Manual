# Set book build with Travis

# assume you have initialized the git repository,
# and are under the directory of the book repository now

This has to be done once
# create a branch named gh-pages and clean up everything
```
git checkout --orphan gh-pages
git rm -rf .
```
# create a hidden file .nojekyll
```
touch .nojekyll
git add .nojekyll

git commit -m"Initial commit"
git push origin gh-pages
```

