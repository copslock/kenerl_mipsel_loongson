Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Feb 2003 15:37:39 +0000 (GMT)
Received: from web40811.mail.yahoo.com ([IPv6:::ffff:66.218.78.188]:45421 "HELO
	web40811.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225238AbTBVPhi>; Sat, 22 Feb 2003 15:37:38 +0000
Message-ID: <20030222153725.72041.qmail@web40811.mail.yahoo.com>
Received: from [67.29.239.190] by web40811.mail.yahoo.com via HTTP; Sat, 22 Feb 2003 07:37:25 PST
Date: Sat, 22 Feb 2003 07:37:25 -0800 (PST)
From: Jiahan Chen <jiahanchen@yahoo.com>
Subject: rebuild tool for Mips
To: Mips Linux <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jiahanchen@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiahanchen@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi, 

I'm working on a project for Mips embedded spplication, 
after cross-compiler stuff setup on Redhat 7.3 environment,
I got two problems:

1. Baseline install:
I tried to install baseline stuff accoring to the 4-step
instructions in README, however, the installation failed
with the message as follows:

[root@localhost install]# ./install.redhat mipsel
mkdir -p /export/mipselroot/var/lib/rpm
rpm --root /export/mipselroot --initdb
Traceback (innermost last):
 File "./findrpm", line 47, in ?
  list.header (src, srpm, name)
 File "./findrpm", line 13, in header
  for n in os.listdir(dir):
OSError: [Errno 2] No such file or directory
Traceback (innermost last):
 File "./findrpm", line 47, in ?
  list.header (src, srpm, name)
 File "./findrpm", line 13, in header
  for n in os.listdir(dir):
OSError: [Errno 2] No such file or directory
setup does not exist.
rm -f /export/mipselroot/etc/ld.so.conf
touch /export/mipselroot/etc/ld.so.conf
touch: creating `/export/mipselroot/etc/ld.so.conf': No such file or directory
make: *** [init] Error 1
Failed to install!

2. POSIX lib with Mips cross ld:

When I tried to cross-compile a test program with POSIX pthread and shared
memory (e.g. pthread_create() and shm_open()), I got errors from
ld. As shown below, I specified lib with 
-L/export/tools/mipsel-linx/lib which contians libpthread.a
and librt.a for the above POSIX functions.
However, it seemed cross ld still to use the native default:
/lib/libpthread.so.0 first.
Based on man ld: "Directories specified on the command line are
  searched  before the default directories."
I guess that there are some config issues I have not set up properly yet.

[root@localhost shm0]# make -f Makemips
/export/tools/bin/mipsel-linux-gcc  -o ylxmem0 -L/export/tools/mipsel-linx/lib
-lpthread -lrt  ylxmem.c mallocShm.c
/export/tools/lib/gcc-lib/mipsel-linux/2.96/../../../../mipsel-linux/bin/ld:
skipping incompatible /lib/libpthread.so.0 when searching for
/lib/libpthread.so.0
/export/tools/lib/gcc-lib/mipsel-linux/2.96/../../../../mipsel-linux/bin/ld:
skipping incompatible /lib/libpthread.so.0 when searching for
/lib/libpthread.so.0
/export/tools/lib/gcc-lib/mipsel-linux/2.96/../../../../mipsel-linux/bin/ld:
skipping incompatible /lib/libpthread.so.0 when searching for
/lib/libpthread.so.0
/export/tools/lib/gcc-lib/mipsel-linux/2.96/../../../../mipsel-linux/bin/ld:
skipping incompatible /lib/libpthread.so.0 when searching for
/lib/libpthread.so.0
/export/tools/lib/gcc-lib/mipsel-linux/2.96/../../../../mipsel-linux/bin/ld:
skipping incompatible /lib/libpthread.so.0 when searching for
/lib/libpthread.so.0
/export/tools/lib/gcc-lib/mipsel-linux/2.96/../../../../mipsel-linux/bin/ld:
skipping incompatible /lib/libpthread.so.0 when searching for
/lib/libpthread.so.0
/export/tools/lib/gcc-lib/mipsel-linux/2.96/../../../../mipsel-linux/bin/ld:
cannot find /lib/libpthread.so.0
collect2: ld returned 1 exit status
make: *** [all] Error 1

Thanks a lot,

Jiahan



__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/
