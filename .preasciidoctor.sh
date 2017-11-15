#!/bin/sh

mkdir -p /tmp/rules

for x in $(find rules/sch -type f); do

	echo "Generate table for $(basename $x)"

	saxon-xquery -s:$x -q:tools/xquery/rules_asciidoc.xquery -o:/tmp/rules/$(basename $x).adoc

done
