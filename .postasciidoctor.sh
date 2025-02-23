#!/bin/sh

if [ -d "/target/site" ]; then
    mv /target/guide/* /target/site
else
    mkdir -p /target/site
    mv /target/guide/* /target/site
fi
rm -r /target/guide
