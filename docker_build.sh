#!/bin/bash

# Get the current branch name
#current_branch=$(git rev-parse --abbrev-ref HEAD)
#
# Check if the current branch is 'main'
#if [[ "$current_branch" == "main" ]]; then
#	echo "Currently on the main branch."
#	docker build -t songrequests:latest .
#else
#	echo "Currently on a different branch: $current_branch"
#	docker build -t songrequests:0.9 .
#fi

docker build -t songrequests:latest .


