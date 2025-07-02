FROM ubuntu:24.04
LABEL maintainer="Parkeymon, EsserGaming"
USER root
# Install essentials
RUN echo "Building.."
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
# Install ffmpeg
RUN apt-get install -y ffmpeg
RUN ffmpeg -version
# Make user enviorment
RUN adduser --home /home/container container --disabled-password
RUN usermod -a -G container container
RUN chown -R container:container /home/container
RUN mkdir /mnt/server
RUN chown -R container:container /mnt/server
ARG CACHBUST=1
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
