#!/bin/sh
VERSION=$(<VERSION)
docker build . -t v12nio/codestream-ci-packer:latest -t v12nio/codestream-ci-packer:v$VERSION --build-arg VERSION=$VERSION
docker login --username $DOCKERUSER --password $DOCKERPASS
docker push v12nio/codestream-ci-packer:latest
docker push v12nio/codestream-ci-packer:v$VERSION