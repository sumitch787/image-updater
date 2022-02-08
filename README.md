# image-updater
Update Image in Kubernetes Manifests

Usage:

Create Docker Image Using Dockerfile

docker build . -t image-updater:latest

Running Container using the image and pass with required Values

docker run -it --name update \
      -e IMAGE_UPDATE_PATH=./manifests/Deploy.yaml \
      -e TAG=v3 \
      -e IMAGE=myprivate/prod-add \
      -e BRANCH=main \
      -e REPO=https://github.com/somerepo.git \
      -e GITHUB_TOKEN=token \
      image-updater:latest
