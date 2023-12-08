# Slide Tools

[![Open in Dev Containers](https://img.shields.io/static/v1?label=Dev%20Containers&message=Open&color=blue&logo=visualstudiocode)](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/InnovaSolutions/slide-tools.git)

Build slides from markdown in html, pdf, and pptx formats. Uses Marp to build slides and PlantUML support for diagrams.

## How to run

1. Install chrome if not installed (needed for HTML slides)
2. From a bash shell: `make pre-install`
3. Reopen bash shell
4. `make`

## How to run using docker

1. Install `docker` (obvious, I know. note docker-compose is auto installed)
2. `make slides-docker`

## How to run using development containers

1. Install VSCode development containers plugin
2. Open in VSCode Development containers (ctrl-shift P, Development Containers: Open folder in container)
3. From a bash shell: `make`
