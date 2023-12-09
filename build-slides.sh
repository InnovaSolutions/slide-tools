#!/bin/bash
# hack but functional script to build slides
set -eu
FB="$1"
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cp ${FB}.md ${SCRIPTPATH}/slides.md
cp assets/* ${SCRIPTPATH}/assets
(cd "${SCRIPTPATH}"; docker-compose run --rm slides make slides)
cp ${SCRIPTPATH}/out/slides.html ${FB}.html
cp ${SCRIPTPATH}/out/slides.pdf ${FB}.pdf
cp ${SCRIPTPATH}/out/slides.pptx ${FB}.pptx
