FROM ubuntu:focal

LABEL maintainer="jadbin <jadbin.com@hotmail.com>"

ENV DEBIAN_FRONTEND noninteractive

# nginx
RUN apt-get update -qqy \
  && apt-get -qqy install wget \
  && apt-get -qqy install unzip \
  && apt-get -qqy install nginx

# consul
ENV CONSUL_VERSION 1.8.0

RUN wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -O /tmp/consul.zip \
  && unzip /tmp/consul.zip -d /usr/local/bin \
  && rm /tmp/consul.zip

# consul-template
ENV CONSUL_TEMPLATE_VERSION 0.25.1

RUN wget https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -O /tmp/consul-template.zip \
  && unzip /tmp/consul-template.zip -d /usr/local/bin \
  && rm /tmp/consul-template.zip

EXPOSE 8080 8300 8301 8301/udp 8302 8302/udp 8500 8600 8600/udp

ADD ./ /opt/guniflask-registry
WORKDIR /opt/guniflask-registry

RUN chmod +x start-registry.sh
CMD ./start-registry.sh
