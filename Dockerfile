FROM alpine:3.9
LABEL maintainer="Peter Grainger<peter@grainger.xyz>"

LABEL "com.github.actions.name"="Add labels to PR"
LABEL "com.github.actions.description"="Add a label to a PR.  Pre-defined colours for labels\n 'whiskey squad', 'pending review', 'pending qa'"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="red"

RUN	apk add --no-cache \
  bash \
  ca-certificates \
  curl \
  jq

COPY add-labels.sh /usr/bin/add-labels.sh

ENTRYPOINT ["/bin/bash", "-c", "add-labels.sh"]