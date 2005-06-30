Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 08:26:52 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.192]:59066 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8226032AbVF3H0h> convert rfc822-to-8bit;
	Thu, 30 Jun 2005 08:26:37 +0100
Received: by zproxy.gmail.com with SMTP id 14so36813nzn
        for <linux-mips@linux-mips.org>; Thu, 30 Jun 2005 00:26:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AGXpFmm5HDEVbsaFfHkSKnJH5Ng19fW5Tg4gXwnsw1mewBD2AVmFRiD9zdQzf5bMpKY95HKgl/XngulEaC59t1xRnScIGvj6bs5e/rEY5uK3OXHaa0gYt7FUHHwedwto6K2ui/MepjOZ40nt4ioqtqrpPqYAKEOQD1ywcURLGuA=
Received: by 10.36.36.19 with SMTP id j19mr140343nzj;
        Thu, 30 Jun 2005 00:26:15 -0700 (PDT)
Received: by 10.36.49.5 with HTTP; Thu, 30 Jun 2005 00:26:14 -0700 (PDT)
Message-ID: <73e6204505063000264527f601@mail.gmail.com>
Date:	Thu, 30 Jun 2005 15:26:14 +0800
From:	zhan rongkai <zhanrk@gmail.com>
Reply-To: zhan rongkai <zhanrk@gmail.com>
To:	linux-mips@linux-mips.org
Subject: I built a mipsel-linux toolchain, but it doesn't work
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zhanrk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhanrk@gmail.com
Precedence: bulk
X-list: linux-mips

Hi folks,

At last night, I built a mipsel-linux cross-toolchain according to the
following steps:

1) The list of GNU Toolchain source packages
=======================================================

* binutils: binutils-2.16.1.tar.gz
*      gcc: gcc-3.4.4.tar.gz
*    Linux: Linux-2.6.12.tar.bz2 (from www.kernel.org)
*   uClibc: uClibc-0.9.27.tar.gz
*      gdb: gdb-6.3.tar.gz

2 build binutils
----------------------

	# mkdir /opt/src
	# cp ~/binutils-2.16.1.tar.bz2 /opt/src/
	# cd /opt/src
	# tar jxvf binutils-2.16.1.tar.bz2
	# mkdir build-binutils
	# cd build-binutils
	# ../binutils-2.16.1/configure --prefix=/opt/gnu-toolch/mipsel-linux-uclibc \
	                               --target=mipsel-linux
	# make all install
	# export PATH=/opt/gnu-toolch/mipsel-linux-uclibc/bin:$PATH

3 Build bootstrap GCC
-----------------------------

	# cp ~/gcc-3.4.4.tar.bz2 /opt/src
	# tar jxvf gcc-3.4.4.tar.bz2
	# mkdir /opt/src/build-gcc-core
	# cd build-gcc-core
	# ../gcc-3.4.4/configure --prefix=/opt/gnu-toolch/mipsel-linux-uclibc \
           --target=mipsel-linux --without-headers --enable-languages=c \
           --disable-shared --disable-threads
	# make all install

4 Build uClibc
--------------------

4.1 Prepare Linux Kernel Header files for uClibc
--------------------------------------------------------------

	# cp ~/linux-2.6.12.tar.bz2 /opt/src
	# cd /opt/src
	# tar jxvf linux-2.6.12.tar.bz2
	# cd /opt/src/linux-2.6.12
	# make xconfig
	# make prepare CROSS_COMPILE=mipsel-linux-

This will generate the header file version.h in the directory
'include/linux', and build the 'asm' symbol link correctly.

4.2 Build uClibc
-----------------------

	# cp ~/uClibc-0.9.27.tar.bz2 /opt/src
	# cd /opt/src
	# tar jxvf uClibc-0.9.27.tar.bz2
	# cd uClibc-0.9.27
	# make menuconfig
	# make CROSS=mipsel-linux-

4.3 Install uClibc
-----------------

	# make PREFIX=/opt/gnu-toolch/mipsel-linux-uclibc/mipsel-linux install

The run-time shared libraries, the static libraries and the header
files of uClibc will be installed into this directory tree:

$(PREFIX)
	|
	|-- /lib:     All uClibc shared and static libraries
	|-- /usr/bin: The ldd & readelf utilities
	|-- /sbin:    ldconfig utility
	|-- /include: All uClibc header files and linux kernel header file.

5 Build Full GCC (--enable-shared --enable-threads)
------------------------------------------------------------------

	# mkdir /opt/src/build-gcc
	# cd /opt/src/build-gcc
	# ../gcc-3.4.4/configure --prefix=/opt/gnu-toolch/mipsel-linux-uclibc \
		--target=mipsel-linux --enable-languages=c --enable-shared --enable-threads \
		--with-headers=/opt/gnu-toolch/mipsel-linux-uclibc/mipsel-linux/include
	# make all install

All the above steps are over successfully.

But when i use this toolchain to compile a simple helloworld.c
program, it fails!!! Here is the verbose information:

================================================================
# mipsel-linux-gcc --verbose -o hello-mipsel hello.c
Reading specs from
/opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4/specs
Configured with: ../gcc-3.4.4/configure
--prefix=/opt/gnu-toolch/mipsel-linux-uclibc --target=mipsel-linux
--enable-languages=c --enable-shared --enable-threads
--with-headers=/opt/gnu-toolch/mipsel-linux-uclibc/mipsel-linux/include
Thread model: posix
gcc version 3.4.4
 /opt/gnu-toolch/mipsel-linux-uclibc/libexec/gcc/mipsel-linux/3.4.4/cc1
-quiet -v hello.c -quiet -dumpbase hello.c -auxbase hello -version -o
/tmp/ccXd4elJ.s
#include "..." search starts here:
#include <...> search starts here:
 /opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4/include
 /opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4/../../../../mipsel-linux/sys-include
/opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4/../../../../mipsel-linux/include
End of search list.
GNU C version 3.4.4 (mipsel-linux)
        compiled by GNU C version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3).
GGC heuristics: --param ggc-min-expand=99 --param ggc-min-heapsize=129381
 /opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4/../../../../mipsel-linux/bin/as
-EL -no-mdebug -32 -v -KPIC -o /tmp/ccoMRDJC.o /tmp/ccXd4elJ.s
GNU assembler version 2.16.1 (mipsel-linux) using BFD version 2.16.1
 /opt/gnu-toolch/mipsel-linux-uclibc/libexec/gcc/mipsel-linux/3.4.4/collect2
--eh-frame-hdr -EL -dynamic-linker /lib/ld.so.1 -o hello-mipsel
/opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4/../../../../mipsel-linux/lib/crt1.o
/opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4/../../../../mipsel-linux/lib/crti.o
/opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4/crtbegin.o
-L/opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4
-L/opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4/../../../../mipsel-linux/lib
/tmp/ccoMRDJC.o -lgcc --as-needed -lgcc_s --no-as-needed -rpath-link
/lib:/usr/lib -lc -lgcc --as-needed -lgcc_s --no-as-needed
/opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4/crtend.o
/opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4/../../../../mipsel-linux/lib/crtn.o
/opt/gnu-toolch/mipsel-linux-uclibc/lib/gcc/mipsel-linux/3.4.4/../../../../mipsel-linux/lib/libgcc_s.so:
undefined reference to `dl_iterate_phdr'
collect2: ld returned 1 exit status
================================================================

It is that $(prefix)/mipsel-linux/lib/libgcc_s.so references the
symbol 'dl_iterate_phdr', which is defined in the uClibc libdl.a:

[zhanrk@zhanrk lib]$ mipsel-linux-nm libgcc_s.so.1 | grep -e 'dl_iterate_phdr'
         U dl_iterate_phdr
[zhanrk@zhanrk lib]$ mipsel-linux-nm -v libdl.a | grep -e 'dl_iterate_phdr'
00002780 T __dl_iterate_phdr
00002780 T dl_iterate_phdr

I don't know how to resolve this problem, someone can tell me what
should i do? Thanks in advance

--
Best Regard, 
Rongkai Zhan
