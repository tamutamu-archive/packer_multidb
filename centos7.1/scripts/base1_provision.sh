#!/bin/bash -eux

### copy provisoning scripts
mkdir -p /var/packer_build/
cp -rf /tmp/packer_build /var/
cd /var/packer_build
find ./ -name '*.sh' -type f -print | xargs chmod 777


### execute provisoning scripts
BASEDIR=/var/packer_build

# base
bash -l $BASEDIR/base/base.sh
bash -l $BASEDIR/base/reboot.sh
