FROM ubuntu:latest
MAINTAINER Eric McConkey <eric@ericmcconkey.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
	&& echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache \
	&& apt-get update \
	&& apt-get -y upgrade \
	&& apt-get -y install \
	apache2 \
	libapache2-mod-php7.0 \
	libapache2-mod-rpaf \
	php7.0 \
	php7.0-mysql \
	php7.0-mbstring \
	php7.0-soap \
	php7.0-curl \
	php7.0-gd \
	php7.0-mcrypt \
	php7.0-zip \
	php-pclzip \
	php7.0-xml \
	php-mongodb \
	php-tcpdf \
	bandwidthd \
	nano \
	curl \
	unzip \
	pwgen \
	git-core \
	ssmtp \
	&& rm -rf /var/lib/apt \
	&& /usr/sbin/useradd webuser -s /bin/bash

RUN a2enmod php7.0 && a2enmod rewrite && a2enmod remoteip

RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini \
	&& sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.0/apache2/php.ini \
	&& sed -i "s/post_max_size = .*$/post_max_size = 20M/" /etc/php/7.0/apache2/php.ini \
	&& sed -i "s/upload_max_filesize = .*$/upload_max_filesize = 20M/" /etc/php/7.0/apache2/php.ini \
	&& echo "Listen 80" > /etc/apache2/ports.conf

RUN rm -f /etc/apache2/sites-enabled/000-default.conf \
	&& rm -f /etc/apache2/envvars \
	&& rm -f /var/www/html/index.html \
	&& echo "Webserver is up" > /var/www/html/index.html

ENV APACHE_RUN_USER webuser
ENV APACHE_RUN_GROUP webuser
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV RPAF_PROXY_SERVER 127.0.0.1
ENV SMTP_RELAY_HOST 10.0.0.1
ENV SMTP_RELAY_PORT 25
ENV SMTP_HOSTNAME localhost
ENV SMTP_REWRITE_DOMAIN localhost

VOLUME  ["/etc/apache2/sites-enabled", "/var/www/html", "/var/log/apache2", "/etc/ssmtp" ]

EXPOSE 80

ADD run-apache.sh /run-apache.sh
ADD site.conf /etc/apache2/sites-enabled/site.conf
ADD ssmtp.conf /etc/ssmtp/ssmtp.conf
ADD bandwidthd.conf.orig /etc/bandwidthd/bandwidthd.conf.orig
ADD setup-bandwidthd.pl /setup-bandwidthd.pl

CMD ["/run-apache.sh"]
