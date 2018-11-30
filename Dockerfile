FROM php:7-alpine3.8

RUN apk --no-cache add tini

ARG PHPCOMPATINFO_VERSION=5.0.12

RUN wget http://bartlett.laurent-laville.org/get/phpcompatinfo-${PHPCOMPATINFO_VERSION}.phar -O /usr/local/bin/phpcompatinfo \
  && chmod +x /usr/local/bin/phpcompatinfo

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]

CMD ["phpcompatinfo"]
