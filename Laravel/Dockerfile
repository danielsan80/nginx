FROM debian:buster

LABEL mantainer="m.galacci@gmail.com"

#ARG DOMAIN
#ARG FRAMEWORK

#ENV DOMAIN ${DOMAIN:-app.dev}
#ENV FRAMEWORK ${FRAMEWORK:-php}
ENV FRAMEWORK laravel

RUN apt-get update && apt-get install -y \
   nginx \
   vim vim-gtk3

COPY nginx.conf /etc/nginx/
COPY ${FRAMEWORK}.conf /etc/nginx/sites-available/

RUN ln -sf /etc/nginx/sites-available/${FRAMEWORK}.conf /etc/nginx/sites-enabled/${FRAMEWORK}.conf \
    && rm /etc/nginx/sites-enabled/default \
    && echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf \
    && usermod -u 1000 www-data \
    && echo 'alias ll="ls -alhF"' >> ~/.bashrc

# RUN sed -i "s/server_name\s\([^\s]*\)\s\([^;]*\);/server_name ${DOMAIN} www.${DOMAIN};/g" /etc/nginx/sites-enabled/${FRAMEWORK}.conf

CMD ["nginx"]

EXPOSE 80
#EXPOSE 443 #HTTPS