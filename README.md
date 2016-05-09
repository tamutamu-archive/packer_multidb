# packer_multidb

### Overview

### Description

### Setup

- [Oracle](./centos7.1/packer_build/oracle12c/install) と[DB2](./centos7.1/packer_build/db2/install)のインストールフォルダにインストールファイルを格納する。

    - centos7.1/packer_build/oracle12c/install/
        - linuxamd64_12102_database_1of2.zip
        - linuxamd64_12102_database_2of2.zip
    - centos7.1/packer_build/db2/install/
        - v10.5_linuxx64_expc.tar.gz
        - v10.5_linuxx64_nlpack.tar.gz
        
### Build

- centos7.1/build.bat を実行。

### Test

```
cd packer_multidb/debug
vagrant up
```
