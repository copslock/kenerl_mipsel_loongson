Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id IAA48799; Fri, 15 Aug 1997 08:26:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA02888 for linux-list; Fri, 15 Aug 1997 08:26:24 -0700
Received: from motown.detroit.sgi.com (motown.detroit.sgi.com [169.238.128.3]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA02880; Fri, 15 Aug 1997 08:26:21 -0700
Received: from localhost by motown.detroit.sgi.com via SMTP (950413.SGI.8.6.12/930416.SGI)
	 id LAA12963; Fri, 15 Aug 1997 11:26:19 -0400
Date: Fri, 15 Aug 1997 11:26:18 -0400 (EDT)
From: Jeremy Welling <jeremyw@motown.detroit.sgi.com>
Reply-To: Jeremy Welling <jeremyw@motown.detroit.sgi.com>
To: linux@cthulhu.engr.sgi.com, linux-progress@cthulhu.engr.sgi.com
Subject: Booting Linux from second disk
Message-ID: <Pine.SGI.3.94.970815111008.12486A-100000@motown.detroit.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


OK, we have /vmlinux:

-rwxr-xr-x 1 root sys 1137360 Aug 15 10:54 vmlinux

which came from:

ftp://ftp.linux.sgi.com/pub/test/vmlinux-970813-jwr.gz

We have extracted the root cpio and this is what the root dir of the
second disk looks like:
linux 8# cd /d
linux 9# ls -la
total 212785
drwxr-xr-x   18 root     sys         4096 Aug 15 10:50 .
drwxr-xr-x   21 root     sys          512 Aug 15 11:01 ..
-rw-r--r--    1 root     sys         1080 Aug 15 10:29 CONTENTS
drwxr-xr-x    2 root     sys         4096 Aug 15 10:39 bin
-rw-r--r--    1 root     sys      4480163 Aug 15 10:29 binutils-2.7.tar.gz
drwxr-xr-x    2 root     user           9 Aug 15 10:41 boot
drwxr-xr-x    2 root     user           9 Aug 15 10:41 cdrom
drwxr-xr-x    2 root     user       12288 Aug 15 10:39 dev
drwxr-xr-x    2 root     user         120 Aug 15 10:52 etc
-rw-r--r--    1 root     sys      7089723 Aug 15 10:29 gcc-2.7.2.tar.gz
-rw-r--r--    1 root     sys      5237187 Aug 15 10:29 glibc-2.0.4-1.tar.gz
-rw-r--r--    1 root     sys      3937333 Aug 15 10:29 glibc-2.0.4.tar.gz
-rw-r--r--    1 root     sys        76738 Aug 15 10:29 glibc-linuxthreads-2.0.4.tar.gz
-rw-r--r--    1 root     sys       519573 Aug 15 10:29 glibc-localedata-2.0.4.tar.gz
drwxr-xr-x    2 root     user           9 Aug 15 10:41 home
drwxr-xr-x    2 root     user        4096 Aug 15 10:41 lib
drwxr-xr-x    2 root     user           9 Aug 15 10:41 libexec
drwxr-xr-x    2 root     user           9 Aug 15 10:41 mnt
drwxr-xr-x    2 root     user           9 Aug 15 10:41 proc
drwxr-xr-x    2 root     user           9 Aug 15 10:41 pub
-rw-r--r--    1 root     sys      86418944 Aug 15 10:30 root-0.00.cpio
drwxr-xr-x    2 root     sys         4096 Aug 15 10:33 rpms
drwxr-xr-x    2 root     sys          118 Aug 15 10:39 sbin
drwxrwxrwt    2 root     user           9 Aug 15 10:41 tmp
drwxr-xr-x   11 root     user        4096 Aug 15 10:41 usr
drwxr-xr-x    2 root     user           9 Aug 15 10:41 var
-rw-r--r--    1 root     guest    1137360 Aug 15 10:49 vmlinux

FX says this about the drive:

...controller test...OK
Scsi drive type == SGI     IBM DORS-32160  WA6A


----- partitions-----
part  type       cyls             blocks          Megabytes   (base+size)
  7: xfs        5 + 6696       3125 + 4185000       2 + 2043 
  8: volhdr     0 + 5             0 + 3125          0 + 2    
 10: volume     0 + 6715          0 + 4196875       0 + 2049 
 15: xfslog  6701 + 14      4188125 + 8750       2045 + 4    

capacity is 4197405 blocks


We have tried booting miniroot, running command monitor then running sash
and we have tried:

boot /vmlinux root=/dev/sdb1 which just fails

and 

boot /vmlinux root=/dev/sdb7 which boots IRIX

HELP! :)

Any ideas?

Thanks!
                 Eric and Jeremy

P.S. Anyone internal, for now, root password is fairly obvious. linux
