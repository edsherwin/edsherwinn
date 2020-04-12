#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e929fab12b35f0019c493a0/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e929fab12b35f0019c493a0 
fi
curl -s -X POST https://api.stackbit.com/project/5e929fab12b35f0019c493a0/webhook/build/ssgbuild > /dev/null
make prepare && hugo --source demo --baseURL "/"
curl -s -X POST https://api.stackbit.com/project/5e929fab12b35f0019c493a0/webhook/build/publish > /dev/null
