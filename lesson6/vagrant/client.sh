#!/bin/bash
set -e

mkdir -p /home/vagrant/.ssh
chown vagrant:vagrant /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh

sudo -u vagrant ssh-keygen -t ed25519 -f /home/vagrant/.ssh/server_key -N ""

cp /home/vagrant/.ssh/server_key.pub /vagrant/server_key.pub

echo "192.168.56.20 server" >> /etc/hosts
