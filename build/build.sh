#!/usr/bin/env bash
set -u

name="letsencrypt-dcos"
version=$(git rev-parse HEAD 2>/dev/null | cut -c 1-7)
image="${image:-brentley/letsencrypt-dcos}"

docker build -t $image:$version .
