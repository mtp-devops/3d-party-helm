#!/bin/bash

# This script you can use when all Helm-code changes of Velero project
# with tags are already merged to main branch

# Just update array of new versions from tags

NEW_TAGS=('2.31.7' '2.31.8' '2.31.9' '2.32.0' '2.32.1' '2.32.2' '2.32.3' '2.32.4' '2.32.5' '2.32.6' '3.0.0' '3.1.0')

for VELERO_VERSION in ${NEW_TAGS[@]}; do
  echo '----- Build new Velero version - '${VELERO_VERSION}' -----'
  git checkout -b cp-velero-${VELERO_VERSION}-build cp-velero-${VELERO_VERSION}
  helm package velero
  mkdir docs
  mv velero-${VELERO_VERSION}.tgz docs/
  git add docs/velero-${VELERO_VERSION}.tgz
  git commit -m "cp-velero-"${VELERO_VERSION}"-build"
  git push --set-upstream origin cp-velero-${VELERO_VERSION}-build
  
  echo '----- Merge built version '${VELERO_VERSION}' to main branch and indexing Helm repo -----'
  export COMMIT=$(git log -n 1 --format="%h")
  git checkout main
  git pull
  git cherry-pick ${COMMIT}
  git push origin main
  helm repo index docs --url https://mtp-devops.github.io/3d-party-helm
  git add docs/*
  git commit -m "Index Helm repo"
  git push origin main
done