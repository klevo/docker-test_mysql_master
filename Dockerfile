FROM dockerfile/percona

# The tunnel is established through ssh
RUN apt-get install -y openssh-server

RUN useradd -d /home/tunnels -m tunnels

# Define mountable directories.
VOLUME ["/etc/mysql", "/var/lib/mysql", "/backups"]

# Define default command.
CMD ["mysqld_safe"]

# Expose ports.
EXPOSE 3306