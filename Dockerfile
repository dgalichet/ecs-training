FROM alpine:3.3

MAINTAINER David Galichet

RUN apk --update-cache add bash nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

COPY www/ /var/www/
COPY etc/nginx.conf /etc/nginx/nginx.conf

CMD ["/usr/sbin/nginx"]
