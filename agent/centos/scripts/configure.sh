#!/usr/bin/env sh

set -e 

dbus-uuidgen --ensure

pip install supervisor

useradd xvfb
useradd teamcity

# legacy Fx18 build for our testing
if [ ! -f home/teamcity/firefox-channels/fx18/en-US/firefox/firefox-bin ]; then
    wget --no-verbose \
      https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/18.0.2/linux-x86_64/en-US/firefox-18.0.2.tar.bz2
    echo "29903172f6fd788f04dbeb27b9193fe6  firefox-18.0.2.tar.bz2" > MD5SUM
    md5sum -c MD5SUM
    su - teamcity -c "mkdir -p /home/teamcity/firefox-channels/fx18/en-US"
    su - teamcity -c "tar xjf /firefox-18.0.2.tar.bz2 -C /home/teamcity/firefox-channels/fx18/en-US"
    mkdir -p /home/ubuntu/ff18/firefox
    ln -s /home/teamcity/firefox-channels/fx18/en-US/firefox/firefox-bin /home/ubuntu/ff18/firefox/firefox-bin
fi

