#!/bin/sh

PROJECT=$(dirname $(readlink -f "$0"))

if [ -e $PROJECT/target ]; then
    docker run --rm -i -v $PROJECT:/src alpine:3.6 rm -rf /src/target
fi

# Structure
docker run --rm -i \
    -v $PROJECT:/src \
    -v $PROJECT/target:/target \
    difi/vefa-structure:0.6


# Validator
docker run --rm -i -v $PROJECT:/src anskaffelser/validator:2.1.0 build -x -t -n eu.peppol.postaward.v3.billing -a rules,guide -target target/validator /src


# Generate adoc-files from rules

# CEN-EN16931-CII
#docker run --rm -i -v $PROJECT:/src -v $PROJECT/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/CEN-EN16931-CII.sch -q:tools/xquery/rules_asciidoc_cen.xquery -o:/target/CEN-EN16931-CII-GENERAL.sch.adoc
#docker run --rm -i -v $PROJECT:/src -v $PROJECT/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/CEN-EN16931-CII.sch -q:tools/xquery/rules_asciidoc_cen_syntax.xquery -o:/target/CEN-EN16931-CII-SYNTAX.sch.adoc

# CEN-EN16931-UBL
docker run --rm -i -v $PROJECT:/src -v $PROJECT/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/CEN-EN16931-UBL.sch -q:tools/xquery/rules_asciidoc_cen.xquery -o:/target/CEN-EN16931-UBL-GENERAL.sch.adoc
docker run --rm -i -v $PROJECT:/src -v $PROJECT/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/CEN-EN16931-UBL.sch -q:tools/xquery/rules_asciidoc_cen_syntax.xquery -o:/target/CEN-EN16931-UBL-SYNTAX.sch.adoc

# PEPPOL-EN16931-UBL
docker run --rm -i -v $PROJECT:/src -v $PROJECT/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/PEPPOL-EN16931-UBL.sch -q:tools/xquery/rules_asciidoc_peppol.xquery -o:/target/PEPPOL-EN16931-UBL-GENERAL.sch.adoc
docker run --rm -i -v $PROJECT:/src -v $PROJECT/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/PEPPOL-EN16931-UBL.sch -q:tools/xquery/rules_asciidoc_peppol_national.xquery -o:/target/PEPPOL-EN16931-UBL-NATIONAL.sch.adoc


# Guides
docker run --rm -i -v $PROJECT:/documents -v $PROJECT/target:/target difi/asciidoctor


# Fix ownership
docker run --rm -i -v $PROJECT:/src alpine:3.6 chown -R $(id -g $USER).$(id -g $USER) /src/target
