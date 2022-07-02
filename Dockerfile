FROM ubuntu:latest
LABEL maintainer="Suryansh"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y xfce4 xfce4-goodies xfce4-terminal tigervnc-standalone-server tigervnc-common && \
    apt install -y nmap && \
    apt install -y openssh-server

RUN echo 'root:123badpassword' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' \
	/etc/ssh/sshd_config

EXPOSE 5901 22

RUN mkdir /run/sshd
RUN mkdir ~/.vnc
RUN echo "123badpassword" | vncpasswd -f >> ~/.vnc/passwd
RUN chmod 600 ~/.vnc/passwd
COPY start.sh /
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
