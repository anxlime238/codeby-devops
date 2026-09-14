#!/bin/bash
set -e

echo "192.168.56.20 anna-lesson8.local www.anna-lesson8.local" >> /etc/hosts

cp /vagrant/lesson8.crt /usr/local/share/ca-certificates/

update-ca-certificates -v

curl https://anna-lesson8.local
curl -I http://anna-lesson8.local
curl -I http://www.anna-lesson8.local
curl -I https://www.anna-lesson8.local
