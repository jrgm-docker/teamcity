#!/usr/bin/env sh

# The files server/scripts/common.sh and agent/centos/scripts/common.sh must be identical.

set -e
set -x

# update and install required packages
yum --quiet -y update
yum --quiet -y install epel-release
yum --quiet repolist
yum --quiet -y install $(cat /scripts/yum-requirements.txt)

# install node 10.x
cd /var/tmp
git clone git://github.com/isaacs/nave.git
cd nave
git checkout -b v2.2.3-branch v2.2.3
./nave.sh usemain 10 2>nave-install.log
ln -s /usr/local/bin/node /usr/bin/node
ln -s /usr/local/bin/npm /usr/bin/npm
/usr/local/bin/npm install -g bower

# this depends on `js` that was previously installed by yum above
curl --silent -L http://github.com/micha/jsawk/raw/master/jsawk > /usr/local/bin/jsawk
chmod 755 /usr/local/bin/jsawk

# install java jdk
JDKRPM=jdk-8u201-linux-x64.rpm
KEYVALUE=42970487e3af4f5aa5bca3f542482c60
BUILDNUM=8u201-b09
wget --no-verbose --no-cookies \
  --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  https://download.oracle.com/otn-pub/java/jdk/$BUILDNUM/$KEYVALUE/$JDKRPM
echo "c4ecb536002798fa12b644ae9bc70b43  $JDKRPM" >> MD5SUM
md5sum -c MD5SUM
rpm -Uvh $JDKRPM
rm -f $JDKRPM MD5SUM
