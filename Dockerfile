FROM nginx:1.11.4-alpine
MAINTAINER ototadana@gmail.com

ENV GIT_VERSION 2.8.3-r0
ENV TAIGA_BRANCH pocci

RUN apk add --no-cache git=${GIT_VERSION}

RUN mkdir /taiga \
    && git clone https://github.com/xpfriend/taiga-front-dist.git /taiga/taiga-front-dist \
    && cd /taiga/taiga-front-dist \
    && git checkout ${TAIGA_BRANCH}

COPY ./bin/. /taiga/bin/
RUN chmod +x /taiga/bin/*

CMD ["/bin/sh", "/taiga/bin/start.sh"]
