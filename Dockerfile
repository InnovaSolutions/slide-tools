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
RUN apt-get install -yq curl git wget;\
  apt-get install -yq build-essential;

# install chrome (needed for html generation)
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -;\
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update;\
  apt-get -y install google-chrome-stable

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

# copy slide source
COPY --chown=${USER}:${USER} assets/ assets/
COPY --chown=${USER}:${USER} entrypoint.sh slides.md ./

ENTRYPOINT [ "./entrypoint.sh" ]
