Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 02:04:02 +0100 (BST)
Received: from nx5.HRZ.Uni-Dortmund.DE ([IPv6:::ffff:129.217.131.21]:20733
	"EHLO nx5.hrz.uni-dortmund.de") by linux-mips.org with ESMTP
	id <S8225276AbTEJBD6>; Sat, 10 May 2003 02:03:58 +0100
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE [129.217.128.51])
	by nx5.hrz.uni-dortmund.de (Postfix) with ESMTP
	id 9ED7E4AA605; Sat, 10 May 2003 03:03:55 +0200 (MET DST)
Received: from linuxpc1 (p508EFA07.dip.t-dialin.net [80.142.250.7])
	(authenticated (0 bits))
	by unimail.uni-dortmund.de (8.12.9+Sun/8.11.6) with ESMTP id h4A13ntC027032
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128 bits) verified NOT);
	Sat, 10 May 2003 03:03:50 +0200 (MEST)
From: Benjamin =?iso-8859-1?q?Menk=FCc?= <benmen@gmx.de>
Reply-To: menkuec@auto-intern.com
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: compiling glibc
Date: Sat, 10 May 2003 03:03:48 +0200
User-Agent: KMail/1.5.1
References: <200305092145.43690.benmen@gmx.de> <20030509214501.GA18697@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20030509214501.GA18697@rembrandt.csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305100303.48870.benmen@gmx.de>
X-MailScanner-Information: UniDo-UniMail
X-MailScanner: Found to be clean
Return-Path: <benmen@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benmen@gmx.de
Precedence: bulk
X-list: linux-mips

When I add the include stuff I still get this error:

[benmen@linuxpc1 mipsel-glibc] LD_LIBRARY_PATH="" CFLAGS="-O2 -g 
-finline-limit=10000" ../glibc-2.3.2/configure --build=i686-linux 
--host=mipsel-linux --enable-add-ons --prefix=/home/benmen/mipsel 
--with-headers=/home/benmen/mips/kernel/mips-2.4.20/include

....

[benmen@linuxpc1 mipsel-glibc] make

...

make[2]: Leaving directory `/home/benmen/mips/glibc-2.3.2/csu'
make[2]: Entering directory `/home/benmen/mips/glibc-2.3.2/csu'
gcc ../sysdeps/unix/sysv/linux/init-first.c -c -std=gnu99 -O2 -Wall -Winline 
-Wstrict-prototypes -Wwrite-strings -finline-limit=10000 -g      -I../include 
-I. -I/home/benmen/mips/mipsel-glibc/csu -I.. -I../libio  
-I/home/benmen/mips/mipsel-glibc -I../sysdeps/mips/elf 
-I../linuxthreads/sysdeps/unix/sysv/linux/mips 
-I../linuxthreads/sysdeps/unix/sysv/linux -I../linuxthreads/sysdeps/pthread 
-I../sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv 
-I../linuxthreads/sysdeps/unix -I../linuxthreads/sysdeps/mips 
-I../sysdeps/unix/sysv/linux/mips -I../sysdeps/unix/sysv/linux 
-I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman 
-I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix/mips 
-I../sysdeps/unix -I../sysdeps/posix -I../sysdeps/mips/mipsel 
-I../sysdeps/mips/fpu -I../sysdeps/mips -I../sysdeps/wordsize-32 
-I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64 -I../sysdeps/ieee754 
-I../sysdeps/generic/elf -I../sysdeps/generic  -nostdinc -isystem 
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/include -isystem 
/home/benmen/mips/kernel/mips-2.4.20/include -D_LIBC_REENTRANT -include 
../include/libc-symbols.h       -DHAVE_INITFINI -o 
/home/benmen/mips/mipsel-glibc/csu/init-first.o
In file included from ../linuxthreads/descr.h:42,
                 from ../linuxthreads/internals.h:29,
                 from ../linuxthreads/sysdeps/pthread/bits/libc-lock.h:27,
                 from ../sysdeps/generic/ldsodefs.h:38,
                 from ../sysdeps/unix/sysv/linux/ldsodefs.h:25,
                 from ../sysdeps/mips/elf/ldsodefs.h:25,
                 from ../sysdeps/unix/sysv/linux/init-first.c:30:
../linuxthreads/sysdeps/mips/pt-machine.h:48: invalid register name for 
`stack_pointer'
make[2]: *** [/home/benmen/mips/mipsel-glibc/csu/init-first.o] Fehler 1
make[2]: Leaving directory `/home/benmen/mips/glibc-2.3.2/csu'
make[1]: *** [csu/subdir_lib] Fehler 2
make[1]: Leaving directory `/home/benmen/mips/glibc-2.3.2'
make: *** [all] Fehler 2

regards,

Ben
