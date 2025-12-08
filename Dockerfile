FROM python:3.13-alpine

RUN apk add git && \
  rm -r /var/cache && \
  sed -i s_/root_/outputs_ /etc/passwd && \
  git clone https://github.com/zanllp/sd-webui-infinite-image-browsing.git /infimage && \
  python -m venv /infimage/venv && \
  /infimage/venv/bin/pip install --upgrade pip && \
  /infimage/venv/bin/pip install -r /infimage/requirements.txt

COPY entry.sh /usr/local/bin
COPY config.json /

ENV IIB_CACHE_DIR=/infimage/cache
VOLUME /infimage/cache /infimage/iib_db_backup

WORKDIR /infimage
CMD [ "sh", "-c", "/usr/local/bin/entry.sh" ]
