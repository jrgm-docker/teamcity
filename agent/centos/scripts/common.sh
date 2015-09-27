#!/usr/bin/env sh

set -e 

# update and install required packages
yum --quiet -y update
yum --quiet -y install epel-release
yum --quiet repolist
yum --quiet -y install $(cat /scripts/yum-requirements.txt)

# nodejs@0.10 and modern npm@2
cd /var/tmp
git clone git://github.com/isaacs/nave.git
cd nave
git checkout -b v0.5.1 178a055c4fe90ce64ecadbb059f595e2230b575e
./nave.sh usemain 0.10 2>/dev/null
ln -s /usr/local/bin/node /usr/bin/node
ln -s /usr/local/bin/npm /usr/bin/npm
/usr/local/bin/npm install -g npm@2
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
