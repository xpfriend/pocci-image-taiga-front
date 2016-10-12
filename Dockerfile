FROM nginx:1.11.5-alpine
MAINTAINER ototadana@gmail.com

ENV GIT_VERSION 2.8.3-r0
ENV TAIGA_BRANCH stable
ENV TAIGA_FRONT_VERSION 20fc32400aa8888035086b190bcefed2dc650252

RUN apk add --no-cache git=${GIT_VERSION}

RUN mkdir /taiga \
    && git clone https://github.com/xpfriend/taiga-front-dist.git /taiga/taiga-front-dist \
    && cd /taiga/taiga-front-dist \
    && git checkout ${TAIGA_BRANCH} \
    && echo "${TAIGA_FRONT_VERSION}" > /taiga/version

COPY ./bin/. /taiga/bin/
RUN chmod +x /taiga/bin/*

CMD ["/bin/sh", "/taiga/bin/start.sh"]
