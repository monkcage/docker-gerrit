FROM alpine:3.18

CMD ["/bin/sh"]

ADD gerrit-3.2.12.war /
ADD entrypoint.sh /

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

RUN apk update \
    && apk upgrade \
    && apk add ca-cartificates \
    && update-ca-certificates \
    && apk add --update coreutils && rm -rf /var/cache/apk/* \
    && apk add --update openjkd11 bash git \
    && rm -rf /var/cache/apk/* \
    && /entrypoint.sh init \
    && rm -f /site/etc/{ssh,secure}* \
    && rm -Rf /site/{static,index,logs,data,index,cache,git,db.tmp}/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk

RUN /entrypoint.sh init

ENV CANONICAL_WEB_URL=
ENV HTTPD_LISTEN_URL=

EXPOSE 29418 8080

VOLUME ["/site/git", "/site/index", "/site/cache", "/site/db", "site/etc"]

ENTRYPOINT ["./entrypoint.sh"]

