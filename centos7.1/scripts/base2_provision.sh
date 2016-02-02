#!/bin/bash -eux

### execute provisoning scripts
BASEDIR=/var/packer_build

# base2
bash -l $BASEDIR/base/vagrant.sh
bash -l $BASEDIR/base/virtualbox.sh
bash -l $BASEDIR/base/cleanup.sh
bash -l $BASEDIR/base/zerodisk.sh