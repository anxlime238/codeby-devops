# syntax=docker/dockerfile:1

FROM debian:11

# обнаружились проблемные пакеты, поэтому удаляем их из списка пакетов
RUN sed -i '/bullseye-security/d' /etc/apt/sources.list && apt-get update && apt-get install -y nginx
RUN mkdir -p /opt/www
COPY index.html /opt/www/index.html
COPY nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT ["nginx", "-g", "daemon off;"]
EXPOSE 80
