Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA05593 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Feb 1999 06:28:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA90954
	for linux-list;
	Wed, 3 Feb 1999 06:27:56 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA94165
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 3 Feb 1999 06:27:54 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from perron-null.patser.net (9dyn49.breda.casema.net [195.96.116.49]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA09564
	for <linux@cthulhu.engr.sgi.com>; Wed, 3 Feb 1999 06:27:52 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from infopact.nl (indigo2.patser.net [192.168.6.40])
	by perron-null.patser.net (8.9.0/8.9.0) with ESMTP id PAA31009
	for <linux@cthulhu.engr.sgi.com>; Wed, 3 Feb 1999 15:14:45 +0100
Message-ID: <36B85DD8.CCF82EDE@infopact.nl>
Date: Wed, 03 Feb 1999 06:31:52 -0800
From: Richard Hartensveld <richard@infopact.nl>
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.5 IP22)
MIME-Version: 1.0
To: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Compilation errors
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I'm trying to build the latest cvs tree (first kernel i'm trying to
compile locally on this challenge S)

Does anyone know what's going wrong? the same kernel compiles flawlessly
on my linux/x86 system with a crosscompiler.

Down here is the error.


[root@tux linux]# make zImage
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r8000 -mips2
-pipe  -c -o init/main.o init/main.c
/usr/src/linux/include/linux/sched.h: In function `on_sig_stack':
In file included from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/linux/sched.h:528: `current' undeclared (first
use this function)
/usr/src/linux/include/linux/sched.h:528: (Each undeclared identifier is
reported only once
/usr/src/linux/include/linux/sched.h:528: for each function it appears
in.)
/usr/src/linux/include/linux/sched.h:530: warning: control reaches end
of non-void function
/usr/src/linux/include/linux/sched.h: In function `sas_ss_flags':
/usr/src/linux/include/linux/sched.h:534: `current' undeclared (first
use this function)
/usr/src/linux/include/linux/sched.h:536: warning: control reaches end
of non-void function
/usr/src/linux/include/linux/sched.h: In function `suser':
/usr/src/linux/include/linux/sched.h:561: `current' undeclared (first
use this function)
/usr/src/linux/include/linux/sched.h: In function `fsuser':
/usr/src/linux/include/linux/sched.h:570: `current' undeclared (first
use this function)
/usr/src/linux/include/linux/sched.h: In function `capable':
/usr/src/linux/include/linux/sched.h:586: `current' undeclared (first
use this function)
/usr/src/linux/include/linux/mm.h: In function `expand_stack':
In file included from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/linux/mm.h:349: `current' undeclared (first use
this function)
init/main.c: In function `do_basic_setup':
init/main.c:1242: `current' undeclared (first use this function)
make: *** [init/main.o] Error 1


Cheers,

Richard
