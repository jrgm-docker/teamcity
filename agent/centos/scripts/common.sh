#!/usr/bin/env sh

set -e
set -x

# update and install required packages
yum --quiet -y update
yum --quiet -y install epel-release
yum --quiet repolist
yum --quiet -y install $(cat /scripts/yum-requirements.txt)

# install node 6.x
cd /var/tmp
git clone git://github.com/isaacs/nave.git
cd nave
git checkout -b v2.2.3-branch v2.2.3
./nave.sh install 6.11.2 2>nave-install.log
ln -s /root/.nave/installed/6.11.2/bin/node /usr/bin/node
ln -s /root/.nave/installed/6.11.2/bin/npm /usr/bin/npm
/usr/bin/npm install -g bower

# this depends on `js` that was previously installed by yum above
curl --silent -L http://github.com/micha/jsawk/raw/master/jsawk > /usr/local/bin/jsawk
chmod 755 /usr/local/bin/jsawk

# install java jdk
JDKRPM=jdk-8u144-linux-x64.rpm
KEYVALUE=090f390dda5b47b9b721c7dfaa008135
wget --no-verbose --no-cookies \
  --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/8u144-b01/$KEYVALUE/$JDKRPM
echo "dcc4c903506766ec4c50a969babdd856  $JDKRPM" >> MD5SUM
md5sum -c MD5SUM
rpm -Uvh $JDKRPM
rm -f $JDKRPM MD5SUM
