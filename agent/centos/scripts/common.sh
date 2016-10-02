#!/usr/bin/env sh

set -e 

# update and install required packages
yum --quiet -y update
yum --quiet -y install epel-release
yum --quiet repolist
yum --quiet -y install $(cat /scripts/yum-requirements.txt)

# install node 4.x
cd /var/tmp
git clone git://github.com/isaacs/nave.git
cd nave
git checkout -b v1.0.1-branch v1.0.1
./nave.sh usemain 4 2>nave-install.log
ln -s /usr/local/bin/node /usr/bin/node
ln -s /usr/local/bin/npm /usr/bin/npm
/usr/local/bin/npm install -g bower

# this depends on `js` that was previously installed by yum above
curl --silent -L http://github.com/micha/jsawk/raw/master/jsawk > /usr/local/bin/jsawk
chmod 755 /usr/local/bin/jsawk

# install java jdk
wget --no-verbose --no-cookies \
  --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/7u76-b13/jdk-7u76-linux-x64.rpm
echo "993d0d6425951d2a3fe39d8ad2e550fc  jdk-7u76-linux-x64.rpm" >> MD5SUM
md5sum -c MD5SUM
rpm -Uvh jdk-7u76-linux-x64.rpm
rm -f jdk-7u76-linux-x64.rpm MD5SUM
