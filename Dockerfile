# boilerplate for a python dev environment
ARG BASE_IMAGE=ubuntu:22.04
FROM ${BASE_IMAGE}

ARG USER=root
ARG PYTHON_VERSION=3.11

WORKDIR /work
SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# setup timezone
RUN apt-get update;\
  apt-get install -yq tzdata;\
  ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime;\
  dpkg-reconfigure -f noninteractive tzdata;

# install OS deps
COPY os-install.sh ./
RUN ./os-install.sh

# run as non-root user (potentially!)
RUN id -u ${USER} &>/dev/null || useradd -ms /bin/bash ${USER}
USER ${USER}
WORKDIR /home/${USER}/work

# install hermit and binary deps
COPY --chown=${USER}:${USER} bin/ bin/
COPY --chown=${USER}:${USER} *.js *.json ./
COPY --chown=${USER}:${USER} Makefile ./
RUN make pre-install;
RUN make install;
# install chrome (needed for pdf/pptx generation)
RUN . ./bin/activate-hermit;\
  npx @puppeteer/browsers install chrome@116.0.5793.0
ENV CHROME_PATH=/home/${USER}/work/chrome/linux-116.0.5793.0/chrome-linux64/chrome

# copy slide source
COPY --chown=${USER}:${USER} assets/ assets/
COPY --chown=${USER}:${USER} entrypoint.sh slides.md ./

ENTRYPOINT [ "./entrypoint.sh" ]
