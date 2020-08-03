#!/usr/bin/env bash

service nginx start
consul agent -dev -client 0.0.0.0 > /dev/null 2>&1 &
consul-template -template="nginx.conf.ctmpl:/etc/nginx/nginx.conf:nginx -s reload" > /dev/null 2>&1
