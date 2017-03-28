FROM nginx:1.11.12-alpine
MAINTAINER ototadana@gmail.com

ENV GIT_VERSION 2.8.3-r0
ENV TAIGA_BRANCH stable
ENV TAIGA_FRONT_VERSION 1ebd8d0271deb658c53ace8054c148783a47d241

RUN apk add --no-cache git=${GIT_VERSION}

RUN mkdir /taiga \
    && git clone https://github.com/xpfriend/taiga-front-dist.git /taiga/taiga-front-dist \
    && cd /taiga/taiga-front-dist \
    && git checkout ${TAIGA_BRANCH} \
    && echo "${TAIGA_FRONT_VERSION}" > /taiga/version

COPY ./bin/. /taiga/bin/
RUN chmod +x /taiga/bin/*

CMD ["/bin/sh", "/taiga/bin/start.sh"]
