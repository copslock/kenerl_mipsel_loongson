Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2003 14:27:28 +0000 (GMT)
Received: from smtp2.infineon.com ([IPv6:::ffff:194.175.117.77]:44423 "EHLO
	smtp2.infineon.com") by linux-mips.org with ESMTP
	id <S8225201AbTA0O11>; Mon, 27 Jan 2003 14:27:27 +0000
Received: from mucse011.eu.infineon.com (mucse011.ifx-mail1.com [172.29.27.228])
	by smtp2.infineon.com (8.12.2/8.12.2) with ESMTP id h0REPE2e012271
	for <linux-mips@linux-mips.org>; Mon, 27 Jan 2003 15:25:14 +0100 (MET)
Received: by mucse011.eu.infineon.com with Internet Mail Service (5.5.2653.19)
	id <DYMZYR1G>; Mon, 27 Jan 2003 15:27:21 +0100
Message-ID: <3A5A80BF651115469CA99C8928706CB603D7B2C2@mucse004.eu.infineon.com>
From: ZhouY.external@infineon.com
To: linux-mips@linux-mips.org
Subject: A problem about gprof
Date: Mon, 27 Jan 2003 15:27:16 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <ZhouY.external@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ZhouY.external@infineon.com
Precedence: bulk
X-list: linux-mips

Hi dear experts,
  In order to use the gprof in the SDE 5.02 toolchain, I compiled a program
with '-p' option but the compiler responsed with a error. I have checked the
startup assembly code crt0.sx. There is an address operation which need the
address of '_ecode'. Which library has the symbol '_ecode'?  Could you give
me a clue?
  Thanks in advance!

  Best regards,

  Yidan


PS. The following is the error messge:
sde-gcc -O -g -mcpu=4kc -mips32 -EB -mno-float  -DGNUSIM -D__SIM
'-Afloat(no)'
  -I../../kit/GSIM32B/../gnusim   -c    -DMCRT0 ../../kit/share/crt0.sx -o
mcrt0
.o
sde-gcc -g -p -mcpu=4kc -mips32 -EB -mno-float  -DGNUSIM -D__SIM
'-Afloat(no)'
  -I../../kit/GSIM32B/../gnusim   -c hello.c -o hello.o
sde-make[1]: Entering directory `/cygdrive/c/sde/sde/kit/GSIM32B'
sde-make[1]: Nothing to be done for `kit'.
sde-make[1]: Leaving directory `/cygdrive/c/sde/sde/kit/GSIM32B'
sde-gcc -mcpu=4kc -mips32 -EB -mno-float   -Ttext 80000400
-L../../kit/GSIM32B
../../kit/GSIM32B/ramstart.o mcrt0.o hello.o   -lc  -lram -lgcc -lc -le
-lram -l
c -lgcc ../../kit/GSIM32B/crtn.o -o ex1ram
mcrt0.o: In function `__fini':
/cygdrive/c/sde/sde/examples/helloworld/../../kit/share/crt0.sx(.text+0x60):
und
efined reference to `_ecode'
/cygdrive/c/sde/sde/examples/helloworld/../../kit/share/crt0.sx(.text+0x64):
und
efined reference to `_ecode'
collect2: ld returned 1 exit status
sde-make: *** [ex1ram] Error 1
