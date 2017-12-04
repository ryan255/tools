#!/bin/bash
oldUrl=$1
gitName=${oldUrl##*/}  #截取 xxx-xxx.git
tar="http://code.saas.crland.com.cn/zt-member/"$gitName
fileName=${gitName%.*}  #截取 xxx-xxx

git clone $1
cd $fileName

for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
    git branch --track ${branch##*/} $branch
done
git fetch --all
git pull --all

git branch
git remote set-url origin $tar
git fetch --all
git add .
git commit -m "migrate commit."
git push --all

git remote -v