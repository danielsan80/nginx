FROM debian:stretch

ARG DOMAIN
ARG FRAMEWORK

ENV DOMAIN ${DOMAIN:-app.dev}
ENV FRAMEWORK ${FRAMEWORK:-php}

RUN apt-get update && apt-get install -y \
   nginx \
   vim vim-gtk3

ADD nginx.conf /etc/nginx/

ADD vhosts/${FRAMEWORK}.conf /etc/nginx/sites-available/
#ADD default.conf /etc/nginx/sites-available/
#ADD php-generic.conf /etc/nginx/sites-available/

RUN ln -sf /etc/nginx/sites-available/${FRAMEWORK}.conf /etc/nginx/sites-enabled/${FRAMEWORK}.conf
#RUN ln -sf /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled
#RUN ln -sf /etc/nginx/sites-available/php-generic.conf /etc/nginx/sites-enabled/php-generic

# RUN sed -i "s/server_name\s\([^\s]*\)\s\([^;]*\);/server_name ${DOMAIN} www.${DOMAIN};/g" /etc/nginx/sites-enabled/${FRAMEWORK}.conf

RUN rm /etc/nginx/sites-enabled/default

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

#RUN echo 'alias ll="ls -alhF"' >> ~/.bashrc

CMD ["nginx"]

EXPOSE 80
#EXPOSE 443 #HTTPS