From ubuntu:22.04

LABEL version="1.0.0"
LABEL maintainer="mapcir@outlook.com"
LABEL description="Mapcir API - Client Server following Mapcir Maps API"
LABEL website="https://mapcir.io"

ENV DEBIAN_FRONTEND noninteractive
ARG TZ
ENV TZ ${TZ:-America/New_York}
ARG LANG
ENV LANG ${LANG:-en_US}

ENV MAPCIR_USER root
ENV MAPCIR_DIR /var/mapcir
ENV MAPCIR_APP ${MAPCIR_DIR}/mapcir-api
ENV MAPCIR_SERVICE ${MAPCIR_DIR}/mapcir-api.service

# update ubuntu && and install packages
RUN apt-get update \
	&& apt-get upgrade -y \
    && apt-get install -y locales

# Configure timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  	&& echo $TZ > /etc/timezone

# Configure localisation
RUN locale-gen $LANG.UTF-8 \
  	&& update-locale LANG=$LANG.UTF-8

# install curl (required)
RUN apt-get install -y libcurl4-openssl-dev

# make dir & copy files
RUN mkdir ${MAPCIR_DIR}
COPY mapcir-api ${MAPCIR_APP}
COPY mapcir-api.service ${MAPCIR_SERVICE}

# configuration
# RUN sed -i -e "s|USER=root|USER=${MAPCIR_USER}|g" ${MAPCIR_SERVICE} && \
#	  sed -i -e "s|ROOT_DIR=/var/mapcir|ROOT_DIR=${MAPCIR_DIR}|g" ${MAPCIR_SERVICE}

# run service
RUN chmod +x ${MAPCIR_SERVICE}
CMD ${MAPCIR_SERVICE} start && bash
