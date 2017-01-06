#!/usr/bin/env sh

set -e 

dbus-uuidgen --ensure

pip install supervisor

useradd xvfb
useradd teamcity

set -o errexit # exit on first command with non-zero status

function install_firefox {
  local FX_VERSION=$1
  local SUBDIR=$2
  local MD5SUM=$3

  local FX_SITE=https://download-installer.cdn.mozilla.net/pub/firefox/releases
  local FX_IMAGE=${FX_SITE}/${FX_VERSION}/linux-x86_64/en-US/firefox-${FX_VERSION}.tar.bz2
    
  wget --no-verbose -O /tmp/firefox-${FX_VERSION}.tar.bz2 "${FX_IMAGE}"
  echo "${MD5SUM}  firefox-${FX_VERSION}.tar.bz2" > MD5SUM
  md5sum -c MD5SUM

  su - teamcity -c "mkdir -p /home/teamcity/firefox-channels/${SUBDIR}/en-US"
  su - teamcity -c "tar xjf /tmp/firefox-${FX_VERSION}.tar.bz2 -C /home/teamcity/firefox-channels/${SUBDIR}/en-US"
  /home/teamcity/firefox-channels/${SUBDIR}/en-US/firefox/firefox-bin --version
}

install_firefox 50.1.0 latest 335635575a221d4eeeb83865be405b51
install_firefox 18.0.2 fx18   29903172f6fd788f04dbeb27b9193fe6
