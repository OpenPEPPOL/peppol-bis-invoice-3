@echo off
setlocal

REM Set the PROJECT variable to the current directory
set "PROJECT=%~dp0"

REM Check if the target directory exists, if so, remove it
if exist "%PROJECT%target" (
    docker run --rm -i -v "%PROJECT%:/src" alpine:3.11 rm -rf /src/target
)

REM Structure
docker run --rm -i ^
    -v "%PROJECT%:/src" ^
    -v "%PROJECT%target:/target" ^
    difi/vefa-structure:0.7

REM Validator
docker run --rm -i -v "%PROJECT%:/src" anskaffelser/validator:2.1.0 build -x -t -n eu.peppol.postaward.v3.billing -a rules,guide -target target/validator /src

REM Generate adoc-files from rules
REM CEN-EN16931-UBL
docker run --rm -i -v "%PROJECT%:/src" -v "%PROJECT%target/generated:/target" --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/CEN-EN16931-UBL.sch -q:tools/xquery/rules_asciidoc_cen.xquery -o:/target/CEN-EN16931-UBL-GENERAL.sch.adoc
docker run --rm -i -v "%PROJECT%:/src" -v "%PROJECT%target/generated:/target" --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/CEN-EN16931-UBL.sch -q:tools/xquery/rules_asciidoc_cen_syntax.xquery -o:/target/CEN-EN16931-UBL-SYNTAX.sch.adoc

REM PEPPOL-EN16931-UBL
docker run --rm -i -v "%PROJECT%:/src" -v "%PROJECT%target/generated:/target" --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/PEPPOL-EN16931-UBL.sch -q:tools/xquery/rules_asciidoc_peppol.xquery -o:/target/PEPPOL-EN16931-UBL-GENERAL.sch.adoc
docker run --rm -i -v "%PROJECT%:/src" -v "%PROJECT%target/generated:/target" --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/PEPPOL-EN16931-UBL.sch -q:tools/xquery/rules_asciidoc_peppol_national.xquery -o:/target/PEPPOL-EN16931-UBL-NATIONAL.sch.adoc

REM Example files
docker run --rm -i -v "%PROJECT%target/site/files:/src" alpine:3.6 rm -rf /src/BIS-Billing3-Examples.zip
docker run --rm -i -v "%PROJECT%rules/examples:/src" -v "%PROJECT%target/site/files:/target" -w /src kramos/alpine-zip -r /target/BIS-Billing3-Examples.zip .

REM Guides
docker run --rm -i -v "%PROJECT%:/documents" -v "%PROJECT%target:/target" difi/asciidoctor

REM Fix ownership
docker run --rm -i -v "%PROJECT%:/src" alpine:3.11 sh -c "chown -R $(id -u).$(id -g) /src/target"

endlocal
