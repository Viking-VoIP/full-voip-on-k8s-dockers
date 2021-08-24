FROM debian:buster

LABEL MANTAINER=davidcsi/david.villasmil@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y -qq && \
    apt-get install -y -qq curl gnupg2 wget lsb-release

RUN wget -O - https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc | apt-key add -
 
RUN echo "deb http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/freeswitch.list
RUN echo "deb-src http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/freeswitch.list

ENV DEBIAN_FRONTEND dialog
RUN apt-get update -y -qq 
RUN apt-get install -y git unzip sipsak freeswitch freeswitch-mod-xml-curl freeswitch-conf-curl freeswitch-lang freeswitch-lang-en freeswitch-lang-es freeswitch-meta-codecs freeswitch-meta-conf freeswitch-mod-abstraction freeswitch-mod-amr freeswitch-mod-amrwb freeswitch-mod-av freeswitch-mod-avmd freeswitch-mod-blacklist freeswitch-mod-callcenter freeswitch-mod-cdr-csv freeswitch-mod-commands freeswitch-mod-conference freeswitch-mod-console freeswitch-mod-curl freeswitch-mod-db freeswitch-mod-dialplan-xml freeswitch-mod-directory freeswitch-mod-distributor freeswitch-mod-dptools freeswitch-mod-esf freeswitch-mod-esl freeswitch-mod-event-multicast freeswitch-mod-event-socket freeswitch-mod-expr freeswitch-mod-fifo freeswitch-mod-flite freeswitch-mod-fsk freeswitch-mod-fsv freeswitch-mod-g723-1 freeswitch-mod-g729 freeswitch-mod-hash freeswitch-mod-httapi freeswitch-mod-http-cache freeswitch-mod-local-stream freeswitch-mod-logfile freeswitch-mod-loopback freeswitch-mod-lua freeswitch-mod-mariadb freeswitch-mod-memcache freeswitch-mod-native-file freeswitch-mod-opus freeswitch-mod-pgsql freeswitch-mod-posix-timer freeswitch-mod-python freeswitch-mod-redis freeswitch-mod-rtc freeswitch-mod-rtmp freeswitch-mod-say-en freeswitch-mod-say-es freeswitch-mod-shell-stream freeswitch-mod-shout freeswitch-mod-sndfile freeswitch-mod-sofia freeswitch-mod-soundtouch freeswitch-mod-spandsp freeswitch-mod-syslog freeswitch-mod-tone-stream freeswitch-mod-valet-parking freeswitch-mod-voicemail freeswitch-mod-voicemail-ivr freeswitch-mod-xml-cdr freeswitch-mod-xml-curl freeswitch-music-default freeswitch-sounds-en-us-callie freeswitch-sounds-es-ar-mario freeswitch-systemd freeswitch-timezones gdb supervisor net-tools
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

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
RUN rm -rf /etc/freeswitch/*

COPY ./supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./startup.sh /startup.sh
COPY ./start_consul_agent.sh /start_consul_agent.sh
COPY ./freeswitch-consul-service.json /etc/consul.d/freeswitch-consul-service.json
COPY ./consul.hcl /etc/consul.d/consul.hcl

RUN mkdir /opt/consul
RUN chmod +x /start_consul_agent.sh
RUN chown consul:consul /start_consul_agent.sh /etc/consul.d/freeswitch-consul-service.json

EXPOSE 5060 5061 6080 5081
CMD ["/usr/bin/supervisord"]

# Build:
# sudo docker build -t davidv/telnyx-load-test-freeswitch:latest .
#
# Run:
# sudo docker run -v ${pwd}/conf:/etc/freeswitch --network=host -it davidv/telnyx-load-test-freeswitch:latest .
