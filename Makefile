.PHONY: all install slides

SLIDES=slides
export PATH := ./bin:${PATH}

all: install slides

# install OS deps
os-install:
	apt-get install -yq curl git wget build-essential;

# install chrome (needed for html generation)
chrome-install:
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -;\
		echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
	apt-get update;
	apt-get -y install google-chrome-stable

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
