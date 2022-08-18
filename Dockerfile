FROM fedora

COPY run_at_start.sh ./run_at_start.sh 

RUN dnf upgrade -y

RUN dnf makecache --refresh

RUN dnf install openssh-server iproute -y

RUN mkdir /var/run/sshd

RUN useradd --user-group --create-home --system user_root

RUN echo 'root:root' |chpasswd

RUN mkdir /root/.ssh

RUN /usr/bin/ssh-keygen -A

RUN dnf clean all

EXPOSE 22

CMD ["/usr/bin/sh","./run_at_start.sh"]
