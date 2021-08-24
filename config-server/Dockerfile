FROM debian:10-slim
LABEL Maintainer="David Villasmil (david.villasmil.work@gmail.com)" \
      Description="Simple nginx+php server"

# Install packages
RUN apt-get update && apt-get -y install nginx php php-cli php-fpm procps supervisor curl vim-tiny unzip git

# Configure nginx
COPY config/nginx-default.conf /etc/nginx/sites-enabled/default
COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Get and install consul
WORKDIR /root
RUN curl https://releases.hashicorp.com/consul/1.10.1/consul_1.10.1_linux_amd64.zip -o /tmp/consul.zip
RUN unzip /tmp/consul.zip
RUN install consul /usr/bin/consul
RUN addgroup --system consul
RUN adduser --system --home /var/consul --shell /sbin/nologin --group consul --gecos consul --disabled-password
RUN if [[ ! -d /etc/consul.d ]]; then mkdir /etc/consul.d; fi
RUN if [[ ! -d /opt/consul ]]; then mkdir /opt/consul; fi

# Copy config files
COPY ./config-server-consul-server.json /etc/consul.d/config-server-consul-server.json
COPY ./start_consul_agent.sh /start_consul_agent.sh
COPY ./consul.hcl /etc/consul.d/consul.hcl
COPY ./start_nginx.sh /start_nginx.sh
COPY ./config/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# Configure supervisord
RUN if [[ ! -d /etc/supervisor/conf.d ]]; then mkdir -p /etc/supervisor/conf.d; fi
RUN if [[ ! -d /var/log/supervisor ]]; then mkdir /var/log/supervisor; fi
COPY config/supervisord-service.conf /etc/supervisord.conf
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Expose the port nginx is reachable on
EXPOSE 8080

# Let supervisord start nginx & php-fpm
CMD ["supervisord", "--configuration", "/etc/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping

