#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

name="letsencrypt-dcos"
curl="curl -v -m3 -s -i -L -X PUT"
endpoint="http://$master/service/marathon/v2/apps/$name"

echo $DIR
$curl -H 'Content-Type: application/json' $endpoint -d "$($DIR/$name.json.sh)"
