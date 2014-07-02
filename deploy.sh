#!/bin/bash

echo ${DOCKER_CON_ENV:-STAGING}

if [[ ${DOCKER_CON_ENV:-STAGING} == "production" ]]; then
  REPO=git@github.com:DockerConfLondon/DockerConfLondon.github.io.git
else
  REPO=git@github.com:DConfLdnStaging/DConfLdnStaging.github.io.git
fi

echo "DEPLOYING TO $REPO"

echo "STASHING.."
git stash

echo "BUILDING.."
rm -Rf /tmp/jekyll-build
jekyll build --destination /tmp/jekyll-build

echo "DEPLOYING..."
git --git-dir /tmp/jekyll-build/.git init .
cd /tmp/jekyll-build/ && git add .
git --git-dir /tmp/jekyll-build/.git commit -m "deploying"
git --git-dir /tmp/jekyll-build/.git remote add origin $REPO
git --git-dir /tmp/jekyll-build/.git push --force origin master
