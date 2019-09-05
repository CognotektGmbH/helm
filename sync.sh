#!/bin/bash
[[ "$TRAVIS_BRANCH" = "master" && "$TRAVIS_PULL_REQUEST" = false ]] && aws s3 sync public/ s3://${BUCKET}/${BUCKET_KEY}
[[ ! -z  "$TRAVIS_BRANCH" ]] && echo "TRAVIS_BRANCH not empty: ---$TRAVIS_BRANCH---"
[[ ! -z  "$TRAVIS_PULL_REQUEST" ]] && echo "TRAVIS_PULL_REQUEST not empty: ---$TRAVIS_PULL_REQUEST---"
