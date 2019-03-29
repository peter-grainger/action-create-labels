#!/bin/bash
set -e
set -o pipefail

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

URI=https://api.github.com
API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

pr_number=$(jq --raw-output .pull_request.id "$GITHUB_EVENT_PATH")
owner=$(jq --raw-output .pull_request.head.repo.owner.login "$GITHUB_EVENT_PATH")
repo=$(jq --raw-output .pull_request.head.repo.name "$GITHUB_EVENT_PATH")

curl -XPOST -fsSL \
	-H "${AUTH_HEADER}" \
	-H "${API_HEADER}" \
	-d "[$*]" \
	"${URI}/repos/${owner}/${repo}/issues/${pr_number}/labels"

exit 0