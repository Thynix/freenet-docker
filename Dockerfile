FROM openjdk:jre-alpine
MAINTAINER Florent Daigniere <nextgens@freenetproject.org>

ENV USER_ID 1000
ENV GROUP_ID 1000
ENV BUILD 1480

RUN addgroup -g $GROUP_ID -S freenet && adduser -S -u $USER_ID -G freenet -h /freenet -s /bin/sh -g "Freenet" freenet

WORKDIR /freenet

RUN apk add --update \
  gnupg \
  wget \
  && rm -rf /var/cache/apk/*

RUN mkdir -p data && chown -R freenet:freenet /freenet

USER freenet

ADD release-managers.asc /release-managers.asc
ADD ./run /freenet/run

EXPOSE 8888 9481
VOLUME ["/freenet/data"]
CMD ["/freenet/run"]
