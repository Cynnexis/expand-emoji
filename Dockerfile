# DOCKERFILE FOR EXPAND-EMOJI
#
# Dockerfile that builds and contains the expand-emoji program.
#
# To build it, please execute:
#	 docker build \
#    -t cynnexis/expand-emoji \
#    --build-arg PROJECT_VERSION 0.0.1 \
#    .

########## STAGE 1 - BUILD BINARY ##########
FROM golang:1.18.0-alpine3.15 AS builder

# Install bash
RUN apk add --no-cache bash

# Change default shell to bash for conditions
SHELL ["/bin/bash", "-c"]

ENV WORKDIR=/go/expand-emoji
WORKDIR "$WORKDIR"

# Copy necessary files
COPY . .

RUN \
  # Print go version
  go version && \
  # Install dependencies
  go mod tidy && \
  # Build executable
  go build && \
  chmod +x expand-emoji && \
	# Install with symbolic link
	ln -s "$(realpath expand-emoji)" /usr/bin/expand-emoji

########## STAGE 2 - SERVE ##########
FROM scratch

COPY --from=builder /go/expand-emoji/expand-emoji /expand-emoji
ENTRYPOINT [ "/expand-emoji" ]
