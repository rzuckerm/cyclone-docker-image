FROM ubuntu:18.04

COPY CYCLONE_* /tmp/
RUN apt-get update && \
    apt-get install -y git gcc-multilib make && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/mingodad/cyclone && \
    cd cyclone && \
    ./configure \
        --prefix=/usr/local \
        --build=i686-pc-linux-gnu \
        CC="gcc -m32 -g" \
        TARGET_CC="gcc -m32 -b i686-pc-linux-gnu" \
        TARGET_CFLAGS=" -m32 -g -march=i686" && \
    ./mk-it-32.sh && \
    ./mk-it-32.sh install && \
    cd / && \
    rm -rf /opt/cyclone && \
    apt-get remove -y git make && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
