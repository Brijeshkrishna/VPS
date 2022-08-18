FROM archlinux

RUN pacman -Syu --noconfirm

RUN pacman -Sy openssh iproute2 --noconfirm 

RUN pacman -Sc --noconfirm 

RUN mkdir /var/run/sshd

RUN useradd --user-group --create-home --system user_root

EXPOSE 22

RUN echo 'root:root' | chpasswd

RUN mkdir /root/.ssh

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN /usr/bin/ssh-keygen -A

CMD ["/usr/bin/sh","./run_at_start.sh"]
