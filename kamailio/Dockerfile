FROM debian:stretch

LABEL MAINTAINER David Villasmil <david.villasmil.work@gmail.com>

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2021-08-01

# avoid httpredir errors
RUN sed -i 's/httpredir/deb/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && apt-get update && apt-get install --assume-yes gnupg wget curl unzip jq tshark
# kamailio repo
RUN echo "deb http://deb.kamailio.org/kamailio53 stretch main" >   /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -

WORKDIR /root
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN ln -s /usr/local/bin/aws /usr/bin/aws
RUN rm -rf awscliv2.zip

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -

RUN apt-get update && apt-get install -y software-properties-common apt-transport-https
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

RUN apt-get update && apt-get install -y git sipsak supervisor vim-tiny kamailio kamailio-extra-modules kamailio-mysql-modules kamailio-websocket-modules kamailio-utils-modules kamailio-tls-modules kamailio-xml-modules procps net-tools sngrep traceroute --assume-yes 

# Download and install specific version
RUN groupadd --system consul
RUN useradd -s /sbin/nologin --system -g consul consul
RUN curl https://releases.hashicorp.com/consul/1.10.1/consul_1.10.1_linux_amd64.zip -o consul_1.10.1_linux_amd64.zip
RUN unzip consul_1.10.1_linux_amd64.zip
RUN chmod +x consul
RUN mv consul /usr/bin/consul

WORKDIR /root
RUN curl -O https://releases.hashicorp.com/consul-template/0.19.5/consul-template_0.19.5_linux_amd64.tgz
RUN tar -xvzf consul-template_0.19.5_linux_amd64.tgz 
RUN mv consul-template /usr/bin/consul-template
RUN rm -rf consul-template_0.19.5_linux_amd64.tgz

COPY ./supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./kamailio-consul-service.json /etc/consul.d/kamailio-consul-service.json

COPY ./start_kam.sh /start_kam.sh
COPY ./start_consul_agent.sh /start_consul_agent.sh
COPY ./consul.hcl /etc/consul.d/consul.hcl

RUN chmod +x /start_kam.sh
RUN chmod +x /start_consul_agent.sh
RUN chown consul:consul /start_consul_agent.sh /etc/consul.d/kamailio-consul-service.json

EXPOSE 5060/udp
EXPOSE 5060/tcp

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
#ENTRYPOINT [ "/start_kam.sh" ]
CMD ["/usr/bin/supervisord"]