FROM ubuntu:xenial
LABEL maintainer "sujaikumar@gmail.com"

RUN apt-get update && apt-get upgrade -y -q && apt-get install -y -q \
    software-properties-common \
    libboost-iostreams-dev libboost-system-dev libboost-filesystem-dev \
    zlibc gcc-multilib apt-utils zlib1g-dev python \
    cmake tcsh build-essential g++ git wget gzip perl

RUN add-apt-repository -y ppa:webupd8team/java && apt-get update 

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y -q oracle-java8-installer  
RUN apt-get install -y -q oracle-java8-set-default

ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle
ENV CLASSPATH=/usr/lib/jvm/java-8-oracle/bin

RUN wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.22-61.0/interproscan-5.22-61.0-64-bit.tar.gz && \
    wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.22-61.0/interproscan-5.22-61.0-64-bit.tar.gz.md5 && \
    md5sum -c interproscan-5.22-61.0-64-bit.tar.gz.md5

RUN tar -pxvzf interproscan-5.22-61.0-64-bit.tar.gz && rm interproscan-5.22-61.0-64-bit.tar.gz

WORKDIR /interproscan-5.22-61.0/data

RUN wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/data/panther-data-11.1.tar.gz && \
    wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/data/panther-data-11.1.tar.gz.md5 && \
    md5sum -c panther-data-11.1.tar.gz.md5

RUN tar -pxvzf panther-data-11.1.tar.gz && rm panther-data-11.1.tar.gz.md5

# RUN adduser --disabled-password --gecos '' dockeruser

ENV PATH="/interproscan-5.22-61.0/:${PATH}"

WORKDIR /interproscan-5.22-61.0

COPY signalp-4.1f.Linux.tar.gz /
RUN  tar -xzf /signalp-4.1f.Linux.tar.gz -C /interproscan-5.22-61.0/bin/signalp/4.1 --strip-components 1

COPY tmhmm-2.0c.Linux.tar.gz /
RUN  tar -xzf /tmhmm-2.0c.Linux.tar.gz -C / && \
     cp /tmhmm-2.0c/bin/decodeanhmm.Linux_x86_64  /interproscan-5.22-61.0/bin/tmhmm/2.0c/decodeanhmm && \
     cp /tmhmm-2.0c/lib/TMHMM2.0.model  /interproscan-5.22-61.0/data/tmhmm/2.0c/TMHMM2.0c.model

#COPY phobius101_linux.tar.gz /
#RUN  tar -xzf /phobius101_linux.tar.gz -C /interproscan-5.22-61.0/bin/phobius/1.01 --strip-components 3

RUN mkdir /data
RUN chmod a+w /interproscan-5.22-61.0
