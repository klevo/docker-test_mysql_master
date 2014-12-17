FROM dockerfile/percona

# The tunnel is established through ssh
RUN apt-get update && apt-get install -y openssh-server

RUN useradd -d /home/tunnels -m tunnels && \
  sed -i "s/^\(AllowUsers\).*/\1 root tunnels/" /etc/ssh/sshd_config

ADD keys/* /home/tunnels/.ssh/
RUN chmod 0700 /home/tunnels/.ssh && \
  chmod 0600 /home/tunnels/.ssh/*

# Define mountable directories.
VOLUME ["/etc/mysql", "/var/lib/mysql", "/backups"]

# Define default command.
CMD ["mysqld_safe"]

# Expose ports.
EXPOSE 3306