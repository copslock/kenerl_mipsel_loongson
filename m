Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 May 2003 11:54:01 +0100 (BST)
Received: from nx5.HRZ.Uni-Dortmund.DE ([IPv6:::ffff:129.217.131.21]:9315 "EHLO
	nx5.hrz.uni-dortmund.de") by linux-mips.org with ESMTP
	id <S8225193AbTEKKx4> convert rfc822-to-8bit; Sun, 11 May 2003 11:53:56 +0100
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE [129.217.128.51])
	by nx5.hrz.uni-dortmund.de (Postfix) with ESMTP id BB5FE4AA7E0
	for <linux-mips@linux-mips.org>; Sun, 11 May 2003 12:53:54 +0200 (MET DST)
Received: from linuxpc1 (p508EDBF0.dip.t-dialin.net [80.142.219.240])
	(authenticated (0 bits))
	by unimail.uni-dortmund.de (8.12.9+Sun/8.11.6) with ESMTP id h4BAr3tC024362
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128 bits) verified NOT)
	for <linux-mips@linux-mips.org>; Sun, 11 May 2003 12:53:39 +0200 (MEST)
From: Benjamin =?iso-8859-1?q?Menk=FCc?= <benmen@gmx.de>
Reply-To: menkuec@auto-intern.com
To: linux-mips@linux-mips.org
Subject: Re: compiling glibc
Date: Sun, 11 May 2003 12:52:52 +0200
User-Agent: KMail/1.5.1
References: <200305092145.43690.benmen@gmx.de> <200305110235.14606.benmen@gmx.de> <20030511092828.GA3889@bogon.ms20.nix>
In-Reply-To: <20030511092828.GA3889@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305111252.52661.benmen@gmx.de>
X-MailScanner-Information: UniDo-UniMail
X-MailScanner: Found to be clean
Return-Path: <benmen@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benmen@gmx.de
Precedence: bulk
X-list: linux-mips

Now it went a little further until here:

make[2]: Leaving directory `/home/benmen/mips/glibc-cvs/misc'
make[2]: Entering directory `/home/benmen/mips/glibc-cvs/misc'
mipsel-linux-gcc -mabi=32 ../sysdeps/unix/sysv/linux/mips/brk.c -c -std=gnu99 
-O2 -Wall -Winline -Wstrict-prototypes -Wwrite-strings -finline-limit=10000 
-g      -I../include -I. -I/home/benmen/mips/mipsel-glibc/misc -I.. 
-I../libio  -I/home/benmen/mips/mipsel-glibc -I../sysdeps/mips/elf 
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
/home/benmen/mips/mipsel-glibc/misc/brk.o -MD -MP -MF 
/home/benmen/mips/mipsel-glibc/misc/brk.o.dt
as: Unbekannte Option »-O2«
make[2]: *** [/home/benmen/mips/mipsel-glibc/misc/brk.o] Fehler 1
make[2]: Leaving directory `/home/benmen/mips/glibc-cvs/misc'
make[1]: *** [misc/subdir_lib] Fehler 2
make[1]: Leaving directory `/home/benmen/mips/glibc-cvs'
make: *** [all] Fehler 2
Verzeichnis: ~/mips/mipsel-glibc
[benmen@linuxpc1 mipsel-glibc]

I am going the try now if it works when I remove the CFLAGS="-O2 ..." from my 
configure line.... however it should be possible to compile it with O2 
shouldn't it?

regards,

Ben
