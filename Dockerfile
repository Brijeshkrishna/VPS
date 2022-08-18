FROM ubuntu:20.04

WORKDIR /

RUN if [ -e "run_at_start.sh" ] ; then COPY run_at_start.sh /run_at_start.sh ; fi  

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install apt-utils openssh-server iproute2 software-properties-common -y
 
RUN mkdir /var/run/sshd

RUN useradd --user-group --create-home --system mogenius

RUN echo 'root:root' | chpasswd

EXPOSE 22

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN add-apt-repository universe
RUN add-apt-repository multiverse
RUN add-apt-repository main

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get clean
RUN apt-get autoclean

RUN if [ -e "/run_at_start.sh" ] ; then RUN run_at_start.sh ; fi

CMD "/usr/bin/ip a ; /usr/sbin/sshd -D -e"
