Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 May 2003 22:33:52 +0100 (BST)
Received: from nx5.HRZ.Uni-Dortmund.DE ([IPv6:::ffff:129.217.131.21]:42325
	"EHLO nx5.hrz.uni-dortmund.de") by linux-mips.org with ESMTP
	id <S8225218AbTEPVds>; Fri, 16 May 2003 22:33:48 +0100
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE [129.217.128.51])
	by nx5.hrz.uni-dortmund.de (Postfix) with ESMTP id C8A304AA621
	for <linux-mips@linux-mips.org>; Fri, 16 May 2003 23:33:45 +0200 (MET DST)
Received: from linuxpc1 (p508EF54A.dip.t-dialin.net [80.142.245.74])
	(authenticated (0 bits))
	by unimail.uni-dortmund.de (8.12.9+Sun/8.11.6) with ESMTP id h4GLXatC002368
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128 bits) verified NOT)
	for <linux-mips@linux-mips.org>; Fri, 16 May 2003 23:33:41 +0200 (MEST)
From: Benjamin =?iso-8859-1?q?Menk=FCc?= <benmen@gmx.de>
Reply-To: menkuec@auto-intern.com
To: linux-mips@linux-mips.org
Subject: cvs glibc bug?
Date: Fri, 16 May 2003 23:33:34 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305162333.34877.benmen@gmx.de>
X-MailScanner-Information: UniDo-UniMail
X-MailScanner: Found to be clean
Return-Path: <benmen@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benmen@gmx.de
Precedence: bulk
X-list: linux-mips

Hi,

is this a bug?

[benmen@linuxpc1 mipsel-glibc] LC_ALL=C LD_LIBRARY_PATH="" CFLAGS="-g 
-finline-limit=10000 -O2" CC="mipsel-linux-gcc" AS="mipsel-linux-as" 
../glibc-cvs/configure --build=i686-linux --host=mipsel-linux 
--enable-add-ons --prefix=/home/benmen/mipsel 
--with-headers=/home/benmen/mips/kernel/mips-2.4.20/include --disable-profile

....

[benmen@linuxpc1 mipsel-glibc] LC_ALL=C mak

...

mipsel-linux-gcc -mabi=32 ../sysdeps/unix/sysv/linux/sigtimedwait.c -c 
-std=gnu99 -O2 -Wall -Winline -Wstrict-prototypes -Wwrite-strings 
-finline-limit=10000 -g      -I../include -I. 
-I/home/benmen/mips/mipsel-glibc/signal -I.. -I../libio  
-I/home/benmen/mips/mipsel-glibc -I../sysdeps/mips/elf 
-I../linuxthreads/sysdeps/unix/sysv/linux/mips 
-I../linuxthreads/sysdeps/unix/sysv/linux -I../linuxthreads/sysdeps/pthread 
-I../sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv 
-I../linuxthreads/sysdeps/unix -I../linuxthreads/sysdeps/mips 
-I../sysdeps/unix/sysv/linux/mips/mips32 -I../sysdeps/unix/sysv/linux/mips 
-I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common 
-I../sysdeps/unix/mman -I../sysdeps/unix/inet -I../sysdeps/unix/sysv 
-I../sysdeps/unix/mips/mips32 -I../sysdeps/unix/mips -I../sysdeps/unix 
-I../sysdeps/posix -I../sysdeps/mips/mips32 -I../sysdeps/mips 
-I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64 
-I../sysdeps/wordsize-32 -I../sysdeps/mips/fpu -I../sysdeps/ieee754 
-I../sysdeps/generic/elf -I../sysdeps/generic -nostdinc -isystem 
/home/benmen/mipsel/lib/gcc-lib/mipsel-linux/3.2.3/include -isystem 
/home/benmen/mips/kernel/mips-2.4.20/include -D_LIBC_REENTRANT -include 
../include/libc-symbols.h  -DPIC     -o 
/home/benmen/mips/mipsel-glibc/signal/sigtimedwait.o -MD -MP -MF 
/home/benmen/mips/mipsel-glibc/signal/sigtimedwait.o.dt
../sysdeps/unix/sysv/linux/sigtimedwait.c: In function `do_sigtimedwait':
../sysdeps/unix/sysv/linux/sigtimedwait.c:44: `SI_TKILL' undeclared (first use 
in this function)
../sysdeps/unix/sysv/linux/sigtimedwait.c:44: (Each undeclared identifier is 
reported only once
../sysdeps/unix/sysv/linux/sigtimedwait.c:44: for each function it appears 
in.)
make[2]: *** [/home/benmen/mips/mipsel-glibc/signal/sigtimedwait.o] Error 1
make[2]: Leaving directory `/home/benmen/mips/glibc-cvs/signal'
make[1]: *** [signal/subdir_lib] Error 2
make[1]: Leaving directory `/home/benmen/mips/glibc-cvs'
make: *** [all] Error 2

regards,

Ben
