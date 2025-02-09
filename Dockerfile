FROM ubuntu:22.04
LABEL maintainer="Parkeymon, EsserGaming"
USER root
RUN echo "Building.."
RUN apt-get update
RUN apt install -y gnupg ca-certificates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update
RUN apt-get install -y ffmpeg
RUN ffmpeg -version
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get update && apt-get install -y aspnetcore-runtime-8.0 aspnetcore-runtime-9.0
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y mono-complete
RUN adduser --home /home/container container --disabled-password --gecos "" --uid 999
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
