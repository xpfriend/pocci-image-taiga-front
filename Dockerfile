FROM nginx:1.13.0-alpine
MAINTAINER ototadana@gmail.com

ENV GIT_VERSION 2.11.1-r0
ENV TAIGA_BRANCH stable
ENV TAIGA_FRONT_VERSION 69e6e7241de3c82cb075dbb7dc6a1992b72cccd7

RUN apk add --no-cache git=${GIT_VERSION}

RUN mkdir /taiga \
    && git clone https://github.com/xpfriend/taiga-front-dist.git /taiga/taiga-front-dist \
    && cd /taiga/taiga-front-dist \
    && git checkout ${TAIGA_BRANCH} \
    && echo "${TAIGA_FRONT_VERSION}" > /taiga/version

COPY ./bin/. /taiga/bin/
RUN chmod +x /taiga/bin/*

CMD ["/bin/sh", "/taiga/bin/start.sh"]
