FROM nginx:1.12.0-alpine
MAINTAINER ototadana@gmail.com

ENV GIT_VERSION 2.11.1-r0
ENV TAIGA_BRANCH stable
ENV TAIGA_FRONT_VERSION 413ce28fb37614f8864180c86e21311652b2bdd6

RUN apk add --no-cache git=${GIT_VERSION}

RUN mkdir /taiga \
    && git clone https://github.com/xpfriend/taiga-front-dist.git /taiga/taiga-front-dist \
    && cd /taiga/taiga-front-dist \
    && git checkout ${TAIGA_BRANCH} \
    && echo "${TAIGA_FRONT_VERSION}" > /taiga/version

COPY ./bin/. /taiga/bin/
RUN chmod +x /taiga/bin/*

CMD ["/bin/sh", "/taiga/bin/start.sh"]
