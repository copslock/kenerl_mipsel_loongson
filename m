Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA00445 for <linux-archive@neteng.engr.sgi.com>; Tue, 29 Sep 1998 16:24:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA94608
	for linux-list;
	Tue, 29 Sep 1998 16:23:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA77692
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 29 Sep 1998 16:23:57 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from bronx.patser.net (9dyn101.breda.casema.net [195.96.116.101]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA09825
	for <linux@cthulhu.engr.sgi.com>; Tue, 29 Sep 1998 16:23:48 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from infopact.nl (root@localhost [127.0.0.1])
	by bronx.patser.net (8.9.0/8.9.0) with ESMTP id BAA00332
	for <linux@cthulhu.engr.sgi.com>; Wed, 30 Sep 1998 01:29:10 +0200
Message-ID: <36116D45.E34A6FEF@infopact.nl>
Date: Wed, 30 Sep 1998 01:29:09 +0200
From: Richard Hartensveld <richardh@infopact.nl>
X-Mailer: Mozilla 4.05 [en] (X11; I; Linux 2.1.121 i686)
MIME-Version: 1.0
To: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: crosscompiling on debian/i386
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

i'm trying to crosscompile a linux/sgi kernel on a debian/i386 machine
with the binutils and the mips-linux-gcc compiler from the linux-sgi ftp
site.

But i keep getting the following  error, does anyone know what i am
doing wrong.?
I'm trying to compile  for a r5000 cpu.

(the dependancies works fine)

wilderness:/usr/src/linux# make CROSS_COMPILE=mips-linux- zImage
mips-linux-gcc -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -
O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r8000 -mips2
-pipe  -c
 -o init/main.o init/main.c
/usr/src/linux/include/linux/sched.h: In function `on_sig_stack':
In file included from init/main.c:17:
/usr/src/linux/include/linux/sched.h:528: `current' undeclared (first
use this f
unction)
/usr/src/linux/include/linux/sched.h:528: (Each undeclared identifier is
reporte
d only once
/usr/src/linux/include/linux/sched.h:528: for each function it appears
in.)
/usr/src/linux/include/linux/sched.h:530: warning: control reaches end
of non-vo
id function
/usr/src/linux/include/linux/sched.h: In function `sas_ss_flags':
/usr/src/linux/include/linux/sched.h:534: `current' undeclared (first
use this f
unction)
/usr/src/linux/include/linux/sched.h:536: warning: control reaches end
of non-vo
id function
/usr/src/linux/include/linux/sched.h: In function `suser':
/usr/src/linux/include/linux/sched.h:561: `current' undeclared (first
use this f
unction)
/usr/src/linux/include/linux/sched.h: In function `fsuser':
/usr/src/linux/include/linux/sched.h:570: `current' undeclared (first
use this f
unction)
/usr/src/linux/include/linux/sched.h: In function `capable':
/usr/src/linux/include/linux/sched.h:586: `current' undeclared (first
use this f
unction)
/usr/src/linux/include/linux/mm.h: In function `expand_stack':
In file included from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:6,
                 from init/main.c:24:
/usr/src/linux/include/linux/mm.h:353: `current' undeclared (first use
this func
tion)
make: *** [init/main.o] Error 1


Anyone who could help?

Richard
