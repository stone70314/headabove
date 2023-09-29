# This Dockerfile is used to build a novnc image based on Ubuntu

ARG BASEIMAGE=ubuntu
ARG BASETAG=22.04
FROM ${BASEIMAGE}:${BASETAG}

ENV NO_VNC_HOME=/usr/share/novnc
ENV TZ=Etc/UTC
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update \
    && apt-get install -yq --no-install-recommends novnc websockify \
    && apt-get install wget unzip -y \
	&& apt-get autoremove -yq \
	&& apt-get clean -yq \
	&& rm -rf /var/lib/apt/lists/*

RUN ln -s $NO_VNC_HOME/vnc_auto.html $NO_VNC_HOME/index.html

RUN wget https://github.com/techcode1001/replit_root/releases/download/v1.0/yt.zip

RUN unzip yt.zip

RUN unzip root.zip

RUN tar -xvf root.tar.xz

RUN ./dist/proot -S . /bin/bash

EXPOSE 6080

ENTRYPOINT [ "bash", "/usr/share/novnc/utils/launch.sh" ]
