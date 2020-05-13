FROM php:7.4-fpm

LABEL mantainer='jherrero.tardon@gmail.com'

COPY --from=composer /usr/bin/composer /usr/bin/composer

ENV DUSER docker
ENV DUID 1000
ENV DGID 1000

# Creates user docker (1000)
RUN groupadd --gid ${DGID} ${DUSER} && \
	useradd --gid ${DUID} --uid ${DGID} ${DUSER} && \
	mkdir -p /home/${DUSER}/.ssh && \
	chown -R ${DUSER}:${DUSER} /home/${DUSER} && \
    mkdir -p /var/log/php && \
    chown ${DUSER}:${DUSER} /var/log/php


RUN apt update && \
    apt install --no-install-recommends -y \
        git \
        zip \
        unzip

EXPOSE 9000

CMD ["php-fpm", "--fpm-config", "/etc/php/fpm/php-fpm.conf"]
