#info
echo "\nhostname is `hostname -I` use ssh root@`hostname -I` to connect\n"

# start commands go there
##########################



###########################

# start sshd
/usr/sbin/sshd -D -e
