FROM ubuntu:24.04
LABEL maintainer="Parkeymon, EsserGaming"
USER root
RUN echo "Building.."
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt install -y gnupg ca-certificates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN add-apt-repository ppa:dotnet/backports
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386
RUN apt-get install -y ffmpeg
RUN ffmpeg -version
RUN apt-get install -y aspnetcore-runtime-9.0 aspnetcore-runtime-8.0
RUN apt-get install -y mono-complete

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
