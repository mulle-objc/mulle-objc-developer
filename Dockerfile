FROM ubuntu:trusty

# make it fresh
# add en UTF-8 as a locale
RUN DEBIAN_FRONTEND=noninteractive \
   && apt-get update \
   && apt-get -y dist-upgrade \
   && apt-get -y install locales \
   && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen \
   && apt-get -y install wget \
   && wget -q -O- https://raw.githubusercontent.com/mulle-nat/mulle-foundation-developer/0.9.1/install-ubuntu.sh | APTFLAGS=-y sh
