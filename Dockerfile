#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

#Creating user
RUN groupadd -g 1000 gadm
RUN useradd -m -u 1000 -g 1000 gadm

# Add files.
ADD root/.bashrc /home/gadm/.bashrc
ADD root/.scripts/* /home/gadm/

# Set environment variables.
ENV HOME /home/gadm
RUN chown -R gadm:gadm /home/gadm

# Define working directory.
WORKDIR /home/gadm
USER gadm

# Define default command.
CMD ["bash"] 
