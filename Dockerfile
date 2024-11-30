# FROM ubuntu:18.04
# ARG DEBIAN_FRONTEND=noninteractive
# #RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//https:\/\/archive.ubuntu.com\/ubuntu\//g' /etc/apt/sources.list
# RUN sed -i 's/http:\/\/archive.ubuntu.com\//http:\/\/us.archive.ubuntu.com\//g' /etc/apt/sources.list
# RUN apt-get update -y && apt-get install -y apache2
# RUN apt-get install -y php libapache2-mod-php
# COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
# ADD . /var/www/html/
# EXPOSE 80
# ENTRYPOINT apachectl -D FOREGROUND


FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive

# Set DNS
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Update repository and install apache
RUN sed -i 's/http:\/\/archive.ubuntu.com\//http:\/\/us.archive.ubuntu.com\//g' /etc/apt/sources.list
RUN apt-get update -y && apt-get install -y apache2
RUN apt-get install -y php libapache2-mod-php

# Copy configurations and files
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
ADD . /var/www/html/

# Expose port and start Apache
EXPOSE 80
ENTRYPOINT apachectl -D FOREGROUND
