Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2003 14:18:07 +0100 (BST)
Received: from nx5.HRZ.Uni-Dortmund.DE ([IPv6:::ffff:129.217.131.21]:54124
	"EHLO nx5.hrz.uni-dortmund.de") by linux-mips.org with ESMTP
	id <S8225196AbTETNSD>; Tue, 20 May 2003 14:18:03 +0100
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE [129.217.128.51])
	by nx5.hrz.uni-dortmund.de (Postfix) with ESMTP id 38C6A4AF8E0
	for <linux-mips@linux-mips.org>; Tue, 20 May 2003 15:17:55 +0200 (MET DST)
Received: from linuxpc1 (p508EDD8B.dip.t-dialin.net [80.142.221.139])
	(authenticated (0 bits))
	by unimail.uni-dortmund.de (8.12.9+Sun/8.11.6) with ESMTP id h4KDHjtC013930
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128 bits) verified NOT)
	for <linux-mips@linux-mips.org>; Tue, 20 May 2003 15:17:49 +0200 (MEST)
From: Benjamin =?iso-8859-1?q?Menk=FCc?= <benmen@gmx.de>
Reply-To: menkuec@auto-intern.com
To: linux-mips@linux-mips.org
Subject: mathinline.h + cross-compiler
Date: Tue, 20 May 2003 15:17:43 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305201517.43195.benmen@gmx.de>
X-MailScanner-Information: UniDo-UniMail
X-MailScanner: Found to be clean
Return-Path: <benmen@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benmen@gmx.de
Precedence: bulk
X-list: linux-mips

When I compile gcc with glibc I get the following error:

/home/benmen/mips/mipsel-gcc/gcc/xgcc -B/home/benmen/mips/mipsel-gcc/gcc/ 
-B/home/benmen/mipsel/mipsel-linux/bin/ 
-B/home/benmen/mipsel/mipsel-linux/lib/ -isystem 
/home/benmen/mipsel/mipsel-linux/include -c -DHAVE_CONFIG_H -O2 -g -O2 -I. 
-I../../../gcc-3.2.3/libiberty/../include  -W -Wall -Wtraditional -pedantic 
../../../gcc-3.2.3/libiberty/floatformat.c
../../../gcc-3.2.3/libiberty/floatformat.c: In function 
`floatformat_to_double':
/home/benmen/mipsel/include/bits/mathinline.h:524: inconsistent operand 
constraints in an `asm'
/home/benmen/mipsel/include/bits/mathinline.h:524: inconsistent operand 
constraints in an `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `atan2':
/home/benmen/mipsel/include/bits/mathinline.h:425: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `atan2f':
/home/benmen/mipsel/include/bits/mathinline.h:425: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `atan2l':
/home/benmen/mipsel/include/bits/mathinline.h:425: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `__atan2l':
/home/benmen/mipsel/include/bits/mathinline.h:426: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `fmod':
/home/benmen/mipsel/include/bits/mathinline.h:429: unknown register name `ax' 
in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `fmodf':
/home/benmen/mipsel/include/bits/mathinline.h:429: unknown register name `ax' 
in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `fmodl':
/home/benmen/mipsel/include/bits/mathinline.h:429: unknown register name `ax' 
in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `atan':
/home/benmen/mipsel/include/bits/mathinline.h:466: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `atanf':
/home/benmen/mipsel/include/bits/mathinline.h:466: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `atanl':
/home/benmen/mipsel/include/bits/mathinline.h:466: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `log1p':
/home/benmen/mipsel/include/bits/mathinline.h:539: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `log1pf':
/home/benmen/mipsel/include/bits/mathinline.h:539: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `log1pl':
/home/benmen/mipsel/include/bits/mathinline.h:539: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `asinh':
/home/benmen/mipsel/include/bits/mathinline.h:539: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `asinhf':
/home/benmen/mipsel/include/bits/mathinline.h:539: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `asinhl':
/home/benmen/mipsel/include/bits/mathinline.h:539: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `atanh':
/home/benmen/mipsel/include/bits/mathinline.h:539: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `atanhf':
/home/benmen/mipsel/include/bits/mathinline.h:539: unknown register name 
`st(1)' in `asm'
/home/benmen/mipsel/include/bits/mathinline.h: In function `atanhl':
/home/benmen/mipsel/include/bits/mathinline.h:539: unknown register name 
`st(1)' in `asm'
make[1]: *** [floatformat.o] Fehler 1
make[1]: Leaving directory 
`/home/benmen/mips/mipsel-gcc/mipsel-linux/libiberty'
make: *** [all-target-libiberty] Fehler 2
Verzeichnis: ~/mips/mipsel-gcc
[benmen@linuxpc1 mipsel-gcc]


This issue has already been in this list 
http://www.spinics.net/lists/mips/msg12229.html but without an answer... 

I have linked the asm dir from the kernel sources into my mipsel/include ... 
However I can not find a mips-specific mathinline.h... There is not 
include/bits dir for mips anywhere....

I configure gcc like this (the last 2 options don't change anything for me): 

[benmen@linuxpc1 mipsel-gcc] ../gcc-3.2.3/configure --target=mipsel-linux 
--enable-languages=c,c++ --prefix=/home/benmen/mipsel 
--with-libs=/home/benmen/mipsel/lib 
--with-headers=/home/benmen/mips/kernel/mips-2.4.20/include 
--includedir=/home/benmen/mips/include

regards,

Ben
