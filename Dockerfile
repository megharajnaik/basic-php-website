# # FROM ubuntu:18.04
# # ARG DEBIAN_FRONTEND=noninteractive
# # #RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//https:\/\/archive.ubuntu.com\/ubuntu\//g' /etc/apt/sources.list
# # RUN sed -i 's/http:\/\/archive.ubuntu.com\//http:\/\/us.archive.ubuntu.com\//g' /etc/apt/sources.list
# # RUN apt-get update -y && apt-get install -y apache2
# # RUN apt-get install -y php libapache2-mod-php
# # COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
# # ADD . /var/www/html/
# # EXPOSE 80
# # ENTRYPOINT apachectl -D FOREGROUND


# FROM ubuntu:18.04
# ARG DEBIAN_FRONTEND=noninteractive

# # Set DNS
# RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# # Update repository and install apache
# RUN sed -i 's/http:\/\/archive.ubuntu.com\//http:\/\/us.archive.ubuntu.com\//g' /etc/apt/sources.list
# RUN apt-get update -y && apt-get install -y apache2
# RUN apt-get install -y php libapache2-mod-php

# # Copy configurations and files
# COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
# ADD . /var/www/html/

# # Expose port and start Apache
# EXPOSE 80
# ENTRYPOINT apachectl -D FOREGROUND


# Use Ubuntu 18.04 as the base image
FROM ubuntu:18.04

# Set non-interactive frontend for apt-get
ARG DEBIAN_FRONTEND=noninteractive

# Set DNS to Google DNS to ensure network access
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Update package sources and install Apache2
RUN sed -i 's/http:\/\/archive.ubuntu.com\//http:\/\/us.archive.ubuntu.com\//g' /etc/apt/sources.list
RUN apt-get update -y && apt-get install -y apache2

# Install PHP and Apache module for PHP
RUN apt-get install -y php libapache2-mod-php

# Ensure the 000-default.conf file exists in the build context
# Make sure to update the file path based on where the file actually is in your project directory
#COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY config/000-default.conf /etc/apache2/sites-available/000-default.conf


# Add your PHP app code to the Docker image (adjust the path as needed)
ADD . /var/www/html/

# Expose port 80 to access the web server
EXPOSE 80

# Start Apache in the foreground
ENTRYPOINT apachectl -D FOREGROUND
