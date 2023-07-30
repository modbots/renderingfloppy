FROM kalilinux/kali-rolling

ENV TTY_VER 1.6.1
#ENV USER kali
#ENV PASSWORD kali

RUN apt-get -y update && \
    apt-get install -y curl && \
    curl -sLk https://github.com/tsl0922/ttyd/releases/download/${TTY_VER}/ttyd_linux.x86_64 -o ttyd_linux && \
    chmod +x ttyd_linux && \
    cp ttyd_linux /usr/local/bin/

RUN echo 'Installing additional packages...' && \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install \
	sudo \
	wget \
        unzip \
	screen \
	-y --show-progress 
RUN curl https://my.webhookrelay.com/webhookrelay/downloads/install-cli.sh | bash
COPY vless.sh /vless.sh
RUN chmod 744 /vless.sh
COPY run_ttyd.sh /run_ttyd.sh
RUN chmod 744 /run_ttyd.sh
RUN relay login -k ce10e352-5cf9-4c4d-b0b7-a9834f7b74b1 -s k74jiYF1Kzo2

CMD ["/bin/bash","/run_ttyd.sh"]
