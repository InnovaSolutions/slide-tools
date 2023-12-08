.PHONY: all install slides

SLIDES=slides
export PATH := ./bin:${PATH}

all: install slides

pre-install:
	hermit shell-hooks
	hermit install
	@echo Reload shell to activate hermit

install:
	npm install
	mkdir -p out

slides:
	cp -r assets out
	marp --allow-local-files --html --pptx ${SLIDES}.md -o out/${SLIDES}.pptx
	marp --allow-local-files --html ${SLIDES}.md -o out/${SLIDES}.html
	marp --allow-local-files --html --pdf ${SLIDES}.md -o out/${SLIDES}.pdf
	cd out && tar cf ${SLIDES}.tar ${SLIDES}.html assets

# build slides using docker
slides-docker:
	docker-compose build
	mkdir -p out
	docker-compose run --rm slides make slides
