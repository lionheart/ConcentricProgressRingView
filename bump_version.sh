#!/bin/bash

if [ "$1" != "" ]; then
  sed -i "" "s/\(s.version[ ]*=[ ]\).*/\1 \"$1\"/g" ConcentricProgressRingView.podspec
  git add .
  git commit -m "bump version to $1"
  git tag $1
  git push origin master
  git push --tags
  pod trunk push
fi
