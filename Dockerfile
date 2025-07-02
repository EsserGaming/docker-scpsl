FROM ubuntu
LABEL maintainer="Parkeymon, EsserGaming"
USER root

RUN apt-get update

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
