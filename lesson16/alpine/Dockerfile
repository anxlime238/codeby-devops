# syntax=docker/dockerfile:1

FROM alpine:latest
RUN apk update
RUN apk add nginx
RUN mkdir -p /opt/www
COPY index.html /opt/www/index.html
COPY nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
