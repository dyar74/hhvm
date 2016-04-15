FROM hhvm/hhvm-proxygen:latest
MAINTAINER dyar74 <mudrui@gmail.com>

RUN apt-get update -y && apt-get install -y curl git
# Install composer
RUN mkdir /opt/composer
RUN curl -sS https://getcomposer.org/installer | hhvm --php -- --install-dir=/opt/composer

# Install app
RUN rm -rf /var/www/public
ADD . /var/www/public
RUN cd /var/www/public && hhvm /opt/composer/composer.phar  global require "fxp/composer-asset-plugin:~1.1.1" && hhvm /opt/composer/composer.phar create-project --prefer-dist yiisoft/yii2-app-basic basic  
#&& hhvm /opt/composer/composer.phar update

# Reconfigure HHVM
ADD hhvm.prod.ini /etc/hhvm/site.ini

EXPOSE 80