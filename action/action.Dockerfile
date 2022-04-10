# DOCKERFILE FOR GITHUB ACTIONS
#
# This Dockerfile is used by GitHub Action for the Cynnexis/expand-emoji action.
#
# You can pass the following arguments to the build:
# - EXPAND_EMOJI_TAG: The git tag of Cynnexis/expand-emoji to use. Defaults to
#   "v1.0.0".
# - JQ_VERSION: The version of stedolan/jq to use. Defaults to "1.6".
#
FROM ubuntu:20.04

# The git tag of Cynnexis/expand-emoji to use.
ARG EXPAND_EMOJI_TAG=v1.0.0

# The version of stedolan/jq to use.
ARG JQ_VERSION=1.6

# Install programs
ADD https://github.com/Cynnexis/expand-emoji/releases/download/${EXPAND_EMOJI_TAG}/expand-emoji-linux-amd64 /usr/bin/expand-emoji
ADD https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 /usr/bin/jq

COPY action-entry-point.bash /usr/bin/action-entry-point.bash

RUN \
	# Make installed programs executable
	chmod a+x /usr/bin/expand-emoji /usr/bin/jq /usr/bin/action-entry-point.bash

ENTRYPOINT [ "/usr/bin/action-entry-point.bash" ]
