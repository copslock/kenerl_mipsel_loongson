Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 16:13:21 +0000 (GMT)
Received: from 216-166-237-83.clec.madisonriver.net ([IPv6:::ffff:216.166.237.83]:43020
	"EHLO dpr338") by linux-mips.org with ESMTP id <S8225329AbSLRQNU>;
	Wed, 18 Dec 2002 16:13:20 +0000
Received: from dprn03.deltartp.com ([216.166.210.181]) by 216.166.237.83 with InterScan Messaging Security Suite; Wed, 18 Dec 2002 11:20:37 -0800
Received: by dprn03.deltartp.com with Internet Mail Service (5.5.2653.19)
	id <YQ1S4BQG>; Wed, 18 Dec 2002 10:57:22 -0500
Message-ID: <A4E787A2467EF849B00585F14C9005590689B4@dprn03.deltartp.com>
From: Chien-Lung Wu <cwu@deltartp.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Cc: Chien-Lung Wu <cwu@deltartp.com>
Subject: Help in cross-compiler
Date: Wed, 18 Dec 2002 10:57:16 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <cwu@deltartp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cwu@deltartp.com
Precedence: bulk
X-list: linux-mips

Hi,

I am working on the embedded linux system on bug endian mips (mips-linux).
As I understand, I need to get the cross-compiler work on my linux-i686 host
(redhat 7.2).
Following the Bradly's "Building a modern MIPS cross-toolchain for linux",
 I download following packages:

	binutils-2.11
	gcc-2.95
	glibc-2.2.5
	glibc-linuxthreads-2.2.5

And following the procedue:
1. build the cross-binutils
	tar -xzf binutils-2.11.tar.gz

	mkdir mips-binutils-2.11
	cd mips-binutils-2.11

	../binutils-2.11/configure 	--target=mips-linux \
				--prefix=/usr/toolchain-mips
	
--libdir='${exec_prefix}'/mips-linux/i386-linux-lib

	make 
	make install
	cd ..

	Everything is fine.

2. build the C cross-compiler

	tar -xzf gcc-2.95.tar.gz
	mkdir mips-gcc-2.95
	cd mips-gcc-2.95

	../gcc-2.95/configure --target=mips-linux
--prefix=/usr/toolchain-mips --enable-languages=c \
	--disable-shared --with-headers=/usr/include


	make
	make install
 	cd ..

As thw warning, The --with-headers causes configure to make a copy of the
headers at the specified location into /usr/local/mipsel-linux/sys-includes
and to run fixincludes on them. These headers are then used by xgcc during
the cross-building of libgcc.a (which is part of building the static C
compiler). This means that you'll need some MIPS host headers laying around
somewhere, including the linux and asm subdirectories from the Linux kernel.
Maybe you have them from your previous cross-compiler installation. If not,
there are various creative ways of obtaining them, including grabbing them
from some MIPS distribution. There is also the dubious hack of using your
hosts's headers (--with-headers=/usr/include) instead. The key word here is
"dubious"; you have been warned. 
Since I can not get "some MIPS host headers", I use the dubious hack.
And it seems get the build of C cross-compiler work.
3. Cross-build glibc
	tar -xzf glibc.tar.gz
	cd glibc
	patch -i ../glibc-2.2.5-mips-build-gmon.diff
	tar -xzf ../glibc-linuxthreads.tar.gz
	cd ..
	mkdir mipsel-glibc
	cd mipsel-glibc

	CFLAGS="-O2 -g -finline-limit=10000" ../glibc/configure
--host=i686-linux\
 	 --enable-add-ons --prefix=/usr

	make
	make install install_root=/usr/local/mips-linux/glibc
	cd ..

	cp -a /usr/local/mips-linux/glibc/lib/*
/usr/toolchain/mips-linux/lib/
	cp -a /usr/local/mips-linux/glibc/usr/include/*
/usr/toolchain/mips-linux/include/
	cp -a /usr/local/mips-linux/glibc/usr/lib/*
/usr/toolchain/mips-linux/lib/
	
	GROUP ( /usr/toolchain/mips-linux/lib/libc.so.6 
  		/usr/toolchain/mipsel-linux/lib/libc_nonshared.a )

	It works fine!

4. Build the final C and C++ cross-compilers
	cd mipsel-gcc 
	../gcc/configure --target=mipsel-linux  prefic=/usr/toolchain
--enable-languages=c,c++ 
	make 
	make install


However, I got the error_message:

home/cross-compiler1/mips-gcc-2.95/gcc/xgcc
-B/home/cross-compiler1/mips-gcc-2.95/gcc/
-B/usr/toolchain1-mips/mips-linux/bin/ -c -g -O2 -fvtable-thunks
-D_GNU_SOURCE
-fno-implicit-templates -I../../../gcc-2.95/libstdc++
-I../../../gcc-2.95/libstdc++/stl -I../libio
-I../../../gcc-2.95/libstdc++/../libio -nostdinc++ -D_IO_MTSAFE_IO
../../../gcc-2.95/libstdc++/cmathi.cc
In file included from
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/math.h:350,
    from ../../../gcc-2.95/libstdc++/cmath:7,
    from ../../../gcc-2.95/libstdc++/cmathi.cc:7:
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
      In function `double atan2(double, double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:426:
      unknown register name `st(1)' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
      In function `float atan2f(float, float)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:426:
      unknown register name `st(1)' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
      In function `long double atan2l(long double, long double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:426:
      unknown register name `st(1)' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
      In function `long double __atan2l(long double, long double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:427:
      unknown register name `st(1)' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
      In function `double fmod(double, double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:430:
    unknown register name `ax' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `float fmodf(float, float)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:430:
    unknown register name `ax' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `long double fmodl(long double, long double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:430:
    unknown register name `ax' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `double atan(double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:467:
    unknown register name `st(1)' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `float atanf(float)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:467:
    unknown register name `st(1)' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `long double atanl(long double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:467:
    unknown register name `st(1)' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `double log1p(double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:540:
    unknown register name `st(1)' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `float log1pf(float)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:540:
    unknown register name `st(1)' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `long double log1pl(long double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:540:
    unknown register name `st(1)' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `long int lrintf(float)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:611:
    unknown register name `st' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `long int lrint(double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:616:
    unknown register name `st' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `long int lrintl(long double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:621:
    unknown register name `st' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `long long int llrintf(float)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:634:
    unknown register name `st' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `long long int llrint(double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:639:
    unknown register name `st' in `asm'
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:
    In function `long long int llrintl(long double)':
 
/usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys-
include/bits/mathinline.h:644:
    unknown register name `st' in `asm'
    make[1]: *** [cmathi.o] Error 1
    make[1]: Leaving directory
    `/home/cross-compiler1/mips-gcc-2.95/mips-linux/libstdc++'
    make: *** [all-target-libstdc++] Error 2

Does any have any idea to fix this error?
When I build the C cross-compiler, I use the "dubious hack"
--with-headers=/usr/include copy the "MIPS host header files". Are there any
other ways to copy the MIPS-host headers?
Thanks for your help.

Chien-Lung
