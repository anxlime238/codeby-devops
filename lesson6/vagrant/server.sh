#!/bin/bash
set -e

mkdir -p /home/vagrant/.ssh

cat /vagrant/server_key.pub >> /home/vagrant/.ssh/authorized_keys

chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys
