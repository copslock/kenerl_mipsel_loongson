Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Apr 2004 03:52:24 +0100 (BST)
Received: from mx3out.umbc.edu ([IPv6:::ffff:130.85.25.12]:60340 "EHLO
	mx3out.umbc.edu") by linux-mips.org with ESMTP id <S8225747AbUDPCwX>;
	Fri, 16 Apr 2004 03:52:23 +0100
Received: from webmail.umbc.edu (nuts.umbc.edu [130.85.24.70])
	by mx3out.umbc.edu (8.12.10/8.12.10/UMBC-Central 1.1.2.1  mxout  1.2.2.3) with SMTP id i3G2qKD2008613
	for <linux-mips@linux-mips.org>; Thu, 15 Apr 2004 22:52:20 -0400 (EDT)
Received: from 130.85.168.85
        (SquirrelMail authenticated user yiwang1)
        by webmail.umbc.edu with HTTP;
        Thu, 15 Apr 2004 22:52:20 -0400 (EDT)
Message-ID: <1279.130.85.168.85.1082083940.squirrel@webmail.umbc.edu>
Date: Thu, 15 Apr 2004 22:52:20 -0400 (EDT)
Subject: building mips cross compiler -- an error when compiling glibc
From: yiwang1@umbc.edu
To: linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3
Importance: Normal
X-AvMilter-Key: 1082084241:d60ea87feda58c82b300969e60e17056
X-Avmilter: Message Skipped, too small
X-Processed-By: MilterMonkey Version 0.9 -- http://www.membrain.com/miltermonkey
Return-Path: <yiwang1@umbc.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yiwang1@umbc.edu
Precedence: bulk
X-list: linux-mips

Hi, I'm building a mips cross compiler on a i686 machine. The sources I
used are:
gcc-3.2.2
glibc-2.3.2
binutils-2.14.90.0.8
linux-2.4.20

I can successfully finish binutils installation and gcc bootstrap
installation. I also finished copying kernel headers. Then I met a problem
when compiling glibc. The error is like this:
... ...
/home/xmt/mips/bin/mipsel-linuxelf-gcc ../sysdeps/unix/sysv/linux/sa_len.c
-c -std=gnu99 -O2 -Wall -Winline -Wstrict-prototypes -Wwrite-strings
-mabi=32 -mips3
     -I../include -I. -I/home/doudou/build-glibc/socket -I.. -I../libio 
-I/home/doudou/build-glibc -I../sysdeps/mips/elf
-I../linuxthreads/sysdeps/unix/sysv/linux/mips
-I../linuxthreads/sysdeps/unix/sysv/linux
-I../linuxthreads/sysdeps/pthread -I../sysdeps/pthread
-I../linuxthreads/sysdeps/unix/sysv -I../linuxthreads/sysdeps/unix
-I../linuxthreads/sysdeps/mips -I../sysdeps/unix/sysv/linux/mips
-I../sysdeps/unix/sysv/linux -I../sysdeps/gnu
-I../sysdeps/unix/common -I../sysdeps/unix/mman
-I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix/mips
-I../sysdeps/unix -I../sysdeps/posix -I../sysdeps/mips/mipsel
-I../sysdeps/mips/fpu -I../sysdeps/mips -I../sysdeps/wordsize-32
-I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64
-I../sysdeps/ieee754 -I../sysdeps/generic/elf -I../sysdeps/generic 
-nostdinc -isystem
/home/xmt/mips/bin/../lib/gcc-lib/mipsel-linuxelf/3.2.2/include
-isystem /home/xmt/mips/include/ -D_LIBC_REENTRANT -D_LIBC_REENTRANT
-include ../include/libc-symbols.h  -DPIC     -o
/home/doudou/build-glibc/socket/sa_len.o
In file included from /home/xmt/mips/include/linux/config.h:4,
                 from /home/xmt/mips/include/asm/types.h:12,
                 from ../sysdeps/unix/sysv/linux/netatalk/at.h:22,
                 from ../sysdeps/unix/sysv/linux/sa_len.c:22:
/home/xmt/mips/include/linux/autoconf.h:1:2: #error Invalid kernel header
included in userspace
make[2]: *** [/home/doudou/build-glibc/socket/sa_len.o] Error 1
make[2]: Leaving directory `/home/doudou/glibc-2.3.2/socket'
make[1]: *** [socket/subdir_lib] Error 2
make[1]: Leaving directory `/home/doudou/glibc-2.3.2'
make: *** [all] Error 2

The first error is at autoconf.h. My configure command line is:

CC="/home/xmt/mips/bin/mipsel-linuxelf-gcc" CFLAGS="-O2 -mips3 -mabi=32"
AR="/home/xmt/mips/bin/mipsel-linuxelf-ar"
RANLIB="/home/xmt/mips/bin/mipsel-linuxelf-ranlib"
../glibc-2.3.2/configure --prefix=/home/xmt/mips/ --host=mipsel-linuxelf
--build=i686-pc-linux-gnu --without-tls --without-__thread
--enable-add-ons=linuxthreads --enable-kernel=2.4.20 --with-gd=no
--without-cvs --disable-profile --with-headers="/home/xmt/mips/include/"

Any ideas on how to solve this problem? Thanks.

Sam
---------
UMBC
