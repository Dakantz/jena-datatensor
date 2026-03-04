FROM ubuntu:24.04

# install maven, java 21, and git
RUN apt-get update && \
    apt-get install -y maven openjdk-21-jdk git wget gcc build-essential make

WORKDIR /jena-bins
# install apache jena and fuseki
RUN wget https://archive.apache.org/dist/jena/binaries/apache-jena-5.2.0.tar.gz
RUN wget https://archive.apache.org/dist/jena/binaries/apache-jena-fuseki-5.2.0.tar.gz
RUN mkdir jena-fuseki
RUN mkdir jena
RUN tar -xzf apache-jena-fuseki-5.2.0.tar.gz -C /jena-bins/jena-fuseki/ --strip-components=1
RUN tar -xzf apache-jena-5.2.0.tar.gz -C /jena-bins/jena/ --strip-components=1
ENV JENA_HOME=/jena-bins/jena
ENV PATH="$PATH:$JENA_HOME/bin"
ENV PATH="$PATH:/jena-bins/jena-fuseki"

# set the working directory
WORKDIR /app
# install openblas
RUN apt-get install -y libopenblas-dev

COPY jena-datatensor/src /app/src
COPY jena-datatensor/pom.xml /app/
RUN mvn clean install
COPY custom-fuseki-server /jena-bins/jena-fuseki/custom-fuseki-server
ENV CLASSPATH="/app/target/*"
