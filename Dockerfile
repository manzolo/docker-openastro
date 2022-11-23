FROM ubuntu:20.04
MAINTAINER Andrea Manzi manzolo@libero.it

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install prerequisites
RUN apt update && apt install -y software-properties-common

# Install prerequisites (xauth, zip, ecc.)
RUN sh -c 'echo "deb http://archive.ubuntu.com/ubuntu focal main universe" > /etc/apt/sources.list.d/universe.list' \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key 3B4FE6ACC0B21F32 \
	&& apt update \
	&& apt install -y xauth wget zip unzip libxtst-dev lsb-release \
	&& apt-get clean

RUN add-apt-repository ppa:pellesimon/ppa \
	&& apt update \
	&& apt install -y openastro.org python3-swisseph libcanberra-gtk3-module python3-gi-cairo language-pack-en

# Remove universe repository
RUN rm -rf /etc/apt/sources.list.d/universe.list && apt update && apt upgrade -y && apt autoremove && apt autoclean && apt clean
	
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
