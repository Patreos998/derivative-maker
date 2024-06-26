#!/bin/bash

set -x
set -e

REPO_URL="$1"
COMMIT_BRANCH="$2"
VERSION_TAG="$3"

main() {
  echo "$0: START"
  echo "Running source code installation script..."
  echo "CI repository URL: $REPO_URL"
  echo "CI Branch: $COMMIT_BRANCH"

  clean_old_source
  install_source_code
  checkout_code

  echo "$0: END"
}

clean_old_source() {
  if [ -d "/home/ansible/derivative-maker" ]; then
    rm -rf "/home/ansible/derivative-maker"
  fi

  if [ -d "/home/ansible/derivative-binary" ]; then
    rm -rf "/home/ansible/derivative-binary"
  fi
}

install_source_code() {
  cd "/home/ansible"
  git clone --depth=1 "https://github.com/$REPO_URL"
  cd "/home/ansible/derivative-maker"
  git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
  git fetch --all --tags
}

checkout_code(){
  if [ -z "$VERSION_TAG" ]; then
    git checkout "$COMMIT_BRANCH"
  else
    git checkout "$VERSION_TAG"
  fi
}

main
