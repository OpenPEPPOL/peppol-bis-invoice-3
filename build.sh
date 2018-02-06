#!/bin/sh

PROJECT=$(dirname $(readlink -f "$0"))

if [ -e $PROJECT/target ]; then
    docker run --rm -i -v $PROJECT:/src alpine:3.6 rm -rf /src/target
fi

# Structure
docker run --rm -it \
    -v $PROJECT:/src \
    -v $PROJECT/target/site/ubl-invoice:/target \
    difi/vefa-structure:0.4.1 \
    -p /src/structure/ubl-invoice -t /target

docker run --rm -it \
    -v $PROJECT:/src \
    -v $PROJECT/target/site/ubl-creditnote:/target \
    difi/vefa-structure:0.4.1 \
    -p /src/structure/ubl-creditnote -t /target

# Validator
docker run --rm -it -v $PROJECT:/src difi/vefa-validator build -x -t -a rules,guide -target target/validator /src

# Generate adoc-files from rules

docker run --rm -it -v $(pwd):/src -v $(pwd)/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/CEN-EN16931-CII.sch -q:tools/xquery/rules_asciidoc_light.xquery -o:/target/CEN-EN16931-CII.sch.adoc
docker run --rm -it -v $(pwd):/src -v $(pwd)/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/CEN-EN16931-UBL.sch -q:tools/xquery/rules_asciidoc_light.xquery -o:/target/CEN-EN16931-UBL.sch.adoc

docker run --rm -it -v $(pwd):/src -v $(pwd)/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/PEPPOL-EN16931-UBL.sch -q:tools/xquery/rules_asciidoc.xquery -o:/target/PEPPOL-EN16931-UBL.sch.adoc

# Guides
docker run --rm -it -v $PROJECT:/documents -v $(pwd)/target:/target difi/asciidoctor

# Fix ownership
docker run --rm -i -v $PROJECT:/src alpine:3.6 chown -R $(id -g $USER).$(id -g $USER) /src/target