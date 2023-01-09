
About This Image
-------------------
This pulls ubuntu:latest, installs apache2.4 and php7.4, gives you volumes for the /var/www/html and /etc/apache2/sites-enabled so you can manage your web content and config files out of the container. Specifically, this is useful for WordPress and custom PHP/MySQL web applications.

It also comes preconfigured with mod_rpaf in case you are running this behind a proxy, so you can log the remote host IP correctly.

Github repository: https://github.com/emcconkey/apache-php

Tags
-------------------
emcconkey/apache-php:7.0 - php version 7.0

emcconkey/apache-php:7.4 - php version 7.4

emcconkey/apache-php:latest - php version 7.4

emcconkey/apache-php:latest - php version 8.1


Quick Start
-------------------
You should mount a volume at `/var/www/html/` and store your html/php files there.

```bash
docker run --name apache-php -d -p 8080:80 \
  -v /host/path/to/html:/var/www/html/ \
  -v /host/path/to/logs:/var/log/apache2/ \
  emcconkey/apache-php
```

Copy your html/php files to /host/path/to/html and then go to the server:port combination you set up.

If you want to change the apache config, map a volume to /etc/apache2/sites-enabled and put your own apache config file there.


```bash
docker run --name apache-php -d -p 8080:80 \
  -v /host/path/to/html:/var/www/html/ \
  -v /host/path/to/logs:/var/log/apache2/ \
  -v /host/path/to/config:/etc/apache2/sites-enabled \
  emcconkey/apache-php
```

Put as many *.conf files as you want in /host/path/to/config and apache will load them on startup.

Environment Variables
-------------------
Variable: APACHE_RUN_USER
Default: webuser (uid 1000)

Variable: APACHE_RUN_GROUP
Default: webuser (gid 1000)

Variable: APACHE_LOG_DIR
Default: /var/log/apache2

Variable: APACHE_LOCK_DIR
Default: /var/lock/apache2

Variable: APACHE_PID_FILE
Default: /var/run/apache2.pid

Variable: RPAF_PROXY_SERVER
Default: 127.0.0.1

Exposed Ports
-------------------
80 is the default port apache listens on internally.

Mapping Volumes
-------------------
The following volumes are available to be mapped:
```bash
/etc/apache2/sites-enabled/
/var/www/html/
/var/log/apache2/
```
Unless you need to change the config file for something specific, you may not need to map that. It's recommended that you map the log files so they don't fill up your container.

Linking to a Database
-------------------
See https://www.conetix.com.au/blog/docker-basics-linking-and-volumes for a tutorial on how to link your containers.

Logging
-------------------
You should map /var/log/apache2/ to an appropriate location to capture the logfiles outside of the container.

PHP Modules
-------------------
The following PHP extensions are enabled. Output of get_loaded_extensions()
```ini
Core
date
libxml
openssl
pcre
zlib
filter
hash
pcntl
Reflection
SPL
session
standard
sodium
mysqlnd
PDO
xml
calendar
ctype
curl
dom
mbstring
FFI
fileinfo
ftp
gd
gettext
iconv
json
exif
mongodb
mysqli
pdo_mysql
Phar
posix
readline
shmop
SimpleXML
soap
sockets
sysvmsg
sysvsem
sysvshm
tokenizer
xmlreader
xmlwriter
xsl
zip
Zend OPcache
```
As of PHP 7.2 mcrypt is deprecated, so only the 7.0 version of this image contains mcrypt.


Apache Modules
-------------------
The following apache modules are enabled. Output of apache2ctl -M
```ini
 core_module (static)
 so_module (static)
 watchdog_module (static)
 http_module (static)
 log_config_module (static)
 logio_module (static)
 version_module (static)
 unixd_module (static)
 access_compat_module (shared)
 alias_module (shared)
 auth_basic_module (shared)
 authn_core_module (shared)
 authn_file_module (shared)
 authz_core_module (shared)
 authz_host_module (shared)
 authz_user_module (shared)
 autoindex_module (shared)
 deflate_module (shared)
 dir_module (shared)
 env_module (shared)
 filter_module (shared)
 mime_module (shared)
 mpm_prefork_module (shared)
 negotiation_module (shared)
 php7_module (shared)
 remoteip_module (shared)
 reqtimeout_module (shared)
 rewrite_module (shared)
 rpaf_module (shared)
 setenvif_module (shared)
 status_module (shared)
```

Extras
-------------------
Bandwidthd is *no longer* included by default - see https://hub.docker.com/r/emcconkey/apache-php-bandwidthd/ for the image with bandwidthd in it. 


License
-------------------
Apache + PHP docker image is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)

