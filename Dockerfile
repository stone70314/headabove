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
    && apt-get install wget unzip tar -y \
    && apt-get install xz-utils -y \
	&& apt-get autoremove -yq \
	&& apt-get clean -yq \
	&& rm -rf /var/lib/apt/lists/*

RUN ln -s $NO_VNC_HOME/vnc_auto.html $NO_VNC_HOME/index.html

COPY . .

RUN chmod +x just1.sh

RUN ./just1.sh

EXPOSE 6080

ENTRYPOINT [ "bash", "/usr/share/novnc/utils/launch.sh" ]
