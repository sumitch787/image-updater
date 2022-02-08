#!/bin/sh
set -e

#ENV's
#IMAGE_UPDATE_PATH= PATH TO MANIFEST FILE
#TAG= TAG TO UPDATE WITH
#BRANCH= BRANCH TO PULL
#REPO= REPO TO UPDATE
#IMAGE= IMAGE NAME TO UPDATE
#GITHUB_TOKEN = TOKEN TO USE 

check_env(){
if [ -z $REPO ] & [ -z $GITHUB_TOKEN ];
then
  printf "values of REPO and GITHUB_TOKEN not provided \n"
  exit 1
else
  printf "==========Welcome to Image Updater v0.0.1==========\n\n"
  add_token_to_url
  git_checkout
  update_image
  git_push
fi
}

add_token_to_url(){
url=$(echo $REPO | awk -F "//" '{print $2}')
REPO=https://$GITHUB_TOKEN@$url
}

git_checkout(){
if [ -z "$BRANCH" ];
then
  printf "BRANCH value not provided\n"
  exit 1
else
git clone --depth 1 -b $BRANCH $REPO $WORK_DIR
fi
}

update_image(){
printf "==========Updating File with Latest Image Tag==========\n"
if [ -z "$IMAGE_UPDATE_PATH" ] & [ -z "$IMAGE" ] & [ -z "$TAG" ];
then
  printf "IMAGE_UPDATE_PATH,IMAGE and TAG value not provided\n"
  exit 1
else
  replace_image=$(yq e '.spec.template.spec.containers.[].image' $IMAGE_UPDATE_PATH | egrep "$IMAGE")
  if [ ! -z "$replace_image" ]; then
     sed -i "s~$replace_image~$IMAGE:$TAG~g" $IMAGE_UPDATE_PATH
     echo "File Updated"
  else
    exit 1
  fi
fi
}

git_push(){
  printf "==========Starting to Update Git Repo==========\n"
  git config --global user.name "ImageUpdater"
  git config --global user.email "imageupdater@example.com"
  git add .
  git commit -m "Image Updated to $IMAGE:$TAG"
  git push
  echo "==========Completed==========\n"
}
#START
check_env
