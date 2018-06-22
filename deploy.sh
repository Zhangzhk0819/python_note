#!/bin/bash

# Add all files
git add -A

# Build gitbook and store files in _book
gitbook build

# Create a new branch gh-pages and remove all files except _book
git checkout --orphan gh-pages
git rm --cached -r .
git add deploy.sh
git clean -df
rm -rf *~

echo "*~" > .gitignore
echo "_book" >> .gitignore
git add .gitignore
git commit -m "Ignore some files"

# Copy files in _book folder to current folder
cp -r _book/* .
git add .
git commit -m "Publish book"

# Push gh-pages branch and delete it
git push -u origin gh-pages
git checkout master
git branch -D gh-pages
