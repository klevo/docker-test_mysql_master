FROM dockerfile/percona

# The tunnel is established through ssh
RUN apt-get update && apt-get install -y openssh-server

RUN useradd -d /home/tunnels -m tunnels && \
  echo "AllowUsers root tunnels" >> /etc/ssh/sshd_config

ADD keys/* /home/tunnels/.ssh/
RUN chmod 0700 /home/tunnels/.ssh && \
  chmod 0600 /home/tunnels/.ssh/id_rsa && \
  chmod 0644 /home/tunnels/.ssh/id_rsa.pub && \
  cat /home/tunnels/.ssh/id_rsa.pub > /home/tunnels/.ssh/authorized_keys && \
  chown -R tunnels:tunnels /home/tunnels/.ssh

# Define mountable directories.
VOLUME ["/etc/mysql", "/var/lib/mysql", "/backups"]

ADD start /start
# Define default command.
CMD ["/start"]

# Expose ports.
EXPOSE 3306 22