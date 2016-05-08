#!/usr/bin/env bash
set -u

name="letsencrypt-dcos"
version="${version:-latest}"
image="${image:-brentley/letsencrypt-dcos}"

docker build -t $image:$version .
