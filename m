Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2003 21:10:50 +0000 (GMT)
Received: from 216-166-237-83.clec.madisonriver.net ([IPv6:::ffff:216.166.237.83]:44037
	"EHLO dpr338") by linux-mips.org with ESMTP id <S8225986AbTACVKt>;
	Fri, 3 Jan 2003 21:10:49 +0000
Received: from dprn03.deltartp.com ([216.166.210.181]) by 216.166.237.83 with InterScan Messaging Security Suite; Fri, 03 Jan 2003 16:16:56 -0800
Received: by dprn03.deltartp.com with Internet Mail Service (5.5.2653.19)
	id <YQ1SVA26>; Fri, 3 Jan 2003 15:52:35 -0500
Message-ID: <A4E787A2467EF849B00585F14C9005590689BF@dprn03.deltartp.com>
From: Chien-Lung Wu <cwu@deltartp.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: glibc-2.2.5  configuration error (cross-compiler)
Date: Fri, 3 Jan 2003 15:52:29 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <cwu@deltartp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cwu@deltartp.com
Precedence: bulk
X-list: linux-mips


Hi, 

I try to build a cross-compiler for mips-linux for mips target (idt32332).

I followed the instruction of Bradley D. LaRonde (thanks)
 http://www.ltc.com/~brad/mips/mips-cross-toolchain/

I downloaded :

	binutils-2.13
	gcc-2.95.3
	glibc-2.2.5 and glibc-linuxthreads-2.2.5

and my build system is gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
and gmake 3.79.1.

As I compiled and install binutils-2.13 and gcc-2.95.3 (1th time),
everything is fine. However, as I configured
glibc-2-2.5 following the instruction:
tar -xzf glibc-2.2.5.tar.gz 
cd glibc-2.2.5
 patch -i ../glibc-2.2.5-mips-build-gmon.diff 
tar -xzf ../glibc-linuxthreads-2.2.5.tar.gz cd .. 
mkdir mips-glibc-2.2.5-1-3
 cd mips-glibc-2.2.5-1-3
 CFLAGS="-O2 -g -finline-limit=10000" ../glibc-2.2.5/configure
--build=i686-linux \
  --host=mips-linux --enable-add-ons --prefix=/usr 
I got error as following:
////// error output //////
loading cache ./config.cache
checking host system type... mips-mips-linux-gnu
checking sysdep dirs... sysdeps/mips/elf
linuxthreads/sysdeps/unix/sysv/linux linuxthreads/sysdeps/pthread
sysdeps/pthread linuxthreads/sysdeps/unix/sysv linuxthreads/sysdeps/unix
linuxthreads/sysdeps/mips sysdeps/unix/sysv/linux/mips
sysdeps/unix/sysv/linux sysdeps/gnu sysdeps/unix/common sysdeps/unix/mman
sysdeps/unix/inet sysdeps/unix/sysv sysdeps/unix/mips sysdeps/unix
sysdeps/posix sysdeps/mips/fpu sysdeps/mips sysdeps/wordsize-32
sysdeps/ieee754/flt-32 sysdeps/ieee754/dbl-64 sysdeps/ieee754
sysdeps/generic/elf sysdeps/generic
checking for a BSD compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking for pwd... /bin/pwd
checking build system type... i686-pc-linux-gnu
checking for mips-linux-gcc... no
checking for mips-linux-cc... no
checking for gnumake... no
checking for gmake... gmake
checking version of gmake... 3.79.1, ok

*** These critical programs are missing or too old:gcc
*** Check the INSTALL file for required versions.
[root@dpr211 mips-glibc-2.2.5-1-3]# 
//// end of error output /////

As i compiled and install cross-compiler, I use the option
--prfix=/usr/xmips-1-3, that means I will
install the cross-compiler in the directory /usr/xmips-1-3. And I also check
tools and mips-linux-gcc are on my cross-compiler directory
/usr/xmips-1-3/bin.

My question is why I got the message:
	checking for mips-linux-gcc... no
	checking for mips-linux-cc... no
And how can I set up path such that this configure can find them.

Another question is the configure error.
I check the INSTALL to make sure the gcc version. It requires gcc 2.95 or
newer.
I check my host gcc is 2.96 and cross-compiler gcc is 2.95.3. 
Why do I get the configure error:
*** These critical programs are missing or too old:gcc
*** Check the INSTALL file for required versions.

Any solution to fix it. Thanks.

Chien-Lung
