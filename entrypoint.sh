#!/bin/sh
set -eu
if [ ! -f /image/bullseye.img ]; then
  mkdir -p /image && cd /image
  wget -q https://raw.githubusercontent.com/google/syzkaller/master/tools/create-image.sh -O create-image.sh
  chmod +x create-image.sh
  ./create-image.sh
  chmod 600 /image/bullseye.id_rsa
fi
exec /syzkaller/gopath/src/github.com/google/syzkaller/bin/syz-manager -config=/my.cfg