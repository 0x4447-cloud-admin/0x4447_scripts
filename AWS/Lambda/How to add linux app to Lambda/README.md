# How to extract an executable from Linux and add it to a Lambda



docker run -it -v /tmp:/tmp IMAGE ID /bin/bash
docker exec -it 7bb32fd1659a /bin/bash

Go to the TMP dir so we can mess there as much as we want with no
consequences.

```
cd /tmp
```

Install the yumdownloader utility.

```
yum install yum-utils
```

Add the non standard repo so we can actually download ffmpeg.

```
rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
rpm -Uvh http://li.nux.ro/download/nux/dextop/el6/x86_64/nux-dextop-release-0-2.el6.nux.noarch.rpm
```

Download the ffmpeg package to the drive without installing it.

```
yumdownloader -x \*i686 --archlist=x86_64 ffmpeg
yumdownloader -x \*i686 --archlist=x86_64 epel-release
```

Unpack the ffmpeg RPM so we have access to each individual compiled
app and libraries.

```
rpm2cpio ffmpeg-*.rpm | cpio -idmv
```

copy the app and all it's libraries