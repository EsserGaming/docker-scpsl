FROM ubuntu
LABEL maintainer="Parkeymon, EsserGaming"
USER root

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
