FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
RUN sed -i 's/http:\/\/archive.ubuntu.com\//http:\/\/us.archive.ubuntu.com\//g' /etc/apt/sources.list
RUN apt-get update -y && apt-get install -y apache2
RUN apt-get install -y php libapache2-mod-php
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf  # Ensure file exists in the context
ADD . /var/www/html/
EXPOSE 80
ENTRYPOINT apachectl -D FOREGROUND
