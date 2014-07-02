#!/bin/bash
echo "FETCHING.."
git fetch
git checkout origin/master

echo "BUILDING.."
rm -Rf /tmp/jekyll-build
jekyll build --destination /tmp/jekyll-build

echo "DEPLOYING..."
git --git-dir /tmp/jekyll-build/.git init .
git --git-dir /tmp/jekyll-build/.git add .
git --git-dir /tmp/jekyll-build/.git commit -m "deploying"
git --git-dir /tmp/jekyll-build/.git remote add origin git@github.com:DockerConfLondon/site.git 
git --git-dir /tmp/jekyll-build/.git push --force origin master:gh-pages
