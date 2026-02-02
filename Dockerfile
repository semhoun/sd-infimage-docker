FROM python:3.13-trixie

RUN apt-get update \
  && apt-get install -y git libavformat61 libavdevice61 \
    build-essential libavformat-dev libavdevice-dev \
  && git clone https://github.com/zanllp/sd-webui-infinite-image-browsing.git /infimage \
  && pip3 install -r /infimage/requirements.txt \
  && apt-get -y purge build-essential libavformat-dev libavdevice-dev \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY entry.sh /usr/local/bin
COPY config.json /

ENV IIB_CACHE_DIR=/infimage/cache
VOLUME /infimage/cache /infimage/iib_db_backup

WORKDIR /infimage
CMD [ "sh", "-c", "/usr/local/bin/entry.sh" ]
