Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 May 2003 01:35:30 +0100 (BST)
Received: from nx5.HRZ.Uni-Dortmund.DE ([IPv6:::ffff:129.217.131.21]:51953
	"EHLO nx5.hrz.uni-dortmund.de") by linux-mips.org with ESMTP
	id <S8225299AbTEKAf1> convert rfc822-to-8bit; Sun, 11 May 2003 01:35:27 +0100
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE [129.217.128.51])
	by nx5.hrz.uni-dortmund.de (Postfix) with ESMTP
	id 06C654AA1DD; Sun, 11 May 2003 02:35:24 +0200 (MET DST)
Received: from linuxpc1 (p508EFB9C.dip.t-dialin.net [80.142.251.156])
	(authenticated (0 bits))
	by unimail.uni-dortmund.de (8.12.9+Sun/8.11.6) with ESMTP id h4B0ZFtC010632
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128 bits) verified NOT);
	Sun, 11 May 2003 02:35:19 +0200 (MEST)
From: Benjamin =?iso-8859-1?q?Menk=FCc?= <benmen@gmx.de>
Reply-To: menkuec@auto-intern.com
To: Daniel Jacobowitz <dan@debian.org>
Subject: Re: compiling glibc
Date: Sun, 11 May 2003 02:35:14 +0200
User-Agent: KMail/1.5.1
References: <200305092145.43690.benmen@gmx.de> <200305101321.21232.benmen@gmx.de> <20030510194351.GA15891@nevyn.them.org>
In-Reply-To: <20030510194351.GA15891@nevyn.them.org>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305110235.14606.benmen@gmx.de>
X-MailScanner-Information: UniDo-UniMail
X-MailScanner: Found to be clean
Return-Path: <benmen@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benmen@gmx.de
Precedence: bulk
X-list: linux-mips

Hi,

now I get this weird error:

...

make[2]: Entering directory `/home/benmen/mips/glibc-cvs/misc'
rm -f /home/benmen/mips/mipsel-glibc/misc/syscall-list.d-t
{ \
 echo '/* Generated at libc build time from kernel syscall list.  */';\
 echo ''; \
 echo '#ifndef _SYSCALL_H'; \
 echo '# error "Never use <bits/syscall.h> directly; include <sys/syscall.h> 
instead."'; \
 echo '#endif'; \
 echo ''; \
 rm -f /home/benmen/mips/mipsel-glibc/misc/syscall-list.h.newt; \
 SUNPRO_DEPENDENCIES='/home/benmen/mips/mipsel-glibc/misc/syscall-list.d-t 
/home/benmen/mips/mipsel-glibc/misc/syscall-list.d' \
 mipsel-linux-gcc -mabi=32 -E -x c -I /home/benmen/mips/mipsel-glibc -nostdinc 
-isystem /home/benmen/mipsel/lib/gcc-lib/mipsel-linux/3.2.3/include -isystem 
/home/benmen/mips/kernel/mips-2.4.20/include 
../sysdeps/unix/sysv/linux/mips/sys/syscall.h -D_LIBC -dM | \
 sed -n 's@^#define __NR_\([^ ]*\) .*$@#define SYS_\1 __NR_\1@p' > 
/home/benmen/mips/mipsel-glibc/misc/syscall-list.h.newt; \
 if grep SYS_O32_ /home/benmen/mips/mipsel-glibc/misc/syscall-list.h.newt > 
/dev/null; then \
   echo '#if defined _ABI64 && _MIPS_SIM == _ABI64'; \
   sed -n 's/^\(#define SYS_\)N64_/\1/p' < 
/home/benmen/mips/mipsel-glibc/misc/syscall-list.h.newt; \
   echo '#elif defined _ABIN32 && _MIPS_SIM == _ABIN32'; \
   sed -n 's/^\(#define SYS_\)N32_/\1/p' < 
/home/benmen/mips/mipsel-glibc/misc/syscall-list.h.newt; \
   echo '#else'; \
   sed -n 's/^\(#define SYS_\)O32_/\1/p' < 
/home/benmen/mips/mipsel-glibc/misc/syscall-list.h.newt; \
   echo '#endif'; \
   sed -n '/^#define SYS_\([ON]32\|N64\)_/p' < 
/home/benmen/mips/mipsel-glibc/misc/syscall-list.h.newt; \
 else \
   cat /home/benmen/mips/mipsel-glibc/misc/syscall-list.h.newt; \
 fi; \
 rm /home/benmen/mips/mipsel-glibc/misc/syscall-list.h.newt; \
} > /home/benmen/mips/mipsel-glibc/misc/syscall-list.h.new
/bin/sh: line 1: /home/benmen/mips/mipsel-glibc/misc/syscall-list.h.new: Datei 
oder Verzeichnis nicht gefunden
mv -f /home/benmen/mips/mipsel-glibc/misc/syscall-list.h.new 
/home/benmen/mips/mipsel-glibc/misc/syscall-list.h
mv: Aufruf von stat für 
»/home/benmen/mips/mipsel-glibc/misc/syscall-list.h.new« nicht möglich: Datei 
oder Verzeichnis nicht gefunden
make[2]: *** [/home/benmen/mips/mipsel-glibc/misc/syscall-list.d] Fehler 1
make[2]: Leaving directory `/home/benmen/mips/glibc-cvs/misc'
make[1]: *** [misc/subdir_lib] Fehler 2
make[1]: Leaving directory `/home/benmen/mips/glibc-cvs'
make: *** [all] Fehler 2
Verzeichnis: ~/mips/mipsel-glibc
[benmen@linuxpc1 mipsel-glibc]

regards,

Ben
