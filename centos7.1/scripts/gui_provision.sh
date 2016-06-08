#!/bin/bash -eux

### execute provisoning scripts
BASEDIR=/var/packer_build

# gui
bash -l $BASEDIR/base/gui.sh
