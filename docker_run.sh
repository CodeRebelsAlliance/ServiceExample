#!/bin/bash

# Get the current branch name
#current_branch=$(git rev-parse --abbrev-ref HEAD)

# Check if the current branch is 'main'
#if [[ "$current_branch" == "main" ]]; then
#  echo "Currently on the main branch."
#  docker run -d -p 5000:5000 -v json-data:/app/json -v music-data:/app/MusicDownloads --name songrequests songrequests:latest
#else
#  echo "Currently on a different branch: $current_branch"
#  docker run -d -p 5555:5000 -e SERVER_VERSION=test --name songrequests_branch songrequests:0.9
#fi

docker run -d -p 5000:5000 -p 2222:22 -v json-data:/app/data -v music-data:/app/MusicDownloads --name songrequests songrequests:latest
