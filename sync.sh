#!/bin/bash
[[ "$TRAVIS_BRANCH" = "master" && "$TRAVIS_PULL_REQUEST" = false ]] && aws s3 sync public/ s3://${BUCKET}/${BUCKET_KEY} || echo "No sync done. Only sync when Pull Request -> Master"
