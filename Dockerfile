FROM nginx:1.11.9-alpine
MAINTAINER ototadana@gmail.com

ENV GIT_VERSION 2.8.3-r0
ENV TAIGA_BRANCH stable
ENV TAIGA_FRONT_VERSION f967102255bfd03f2096b8bac2aae8a2b9a17f7a

RUN apk add --no-cache git=${GIT_VERSION}

RUN mkdir /taiga \
    && git clone https://github.com/xpfriend/taiga-front-dist.git /taiga/taiga-front-dist \
    && cd /taiga/taiga-front-dist \
    && git checkout ${TAIGA_BRANCH} \
    && echo "${TAIGA_FRONT_VERSION}" > /taiga/version

COPY ./bin/. /taiga/bin/
RUN chmod +x /taiga/bin/*

CMD ["/bin/sh", "/taiga/bin/start.sh"]
