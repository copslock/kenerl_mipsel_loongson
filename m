Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA28282 for <linux-archive@neteng.engr.sgi.com>; Mon, 7 Dec 1998 16:48:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA29392
	for linux-list;
	Mon, 7 Dec 1998 16:46:10 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA35499
	for <linux@engr.sgi.com>;
	Mon, 7 Dec 1998 16:46:08 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-46.netscape.com [205.217.237.46]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04790
	for <linux@engr.sgi.com>; Mon, 7 Dec 1998 16:46:06 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from tintin.mcom.com (tintin.mcom.com [205.217.233.42])
	by netscape.com (8.8.5/8.8.5) with ESMTP id QAA17123
	for <linux@engr.sgi.com>; Mon, 7 Dec 1998 16:46:06 -0800 (PST)
Received: from netscape.com ([205.217.243.67]) by
          tintin.mcom.com (Netscape Messaging Server 4.0) with ESMTP id
          F3MFGT00.P3P for <linux@engr.sgi.com>; Mon, 7 Dec 1998 16:46:05 -0800 
Message-ID: <366C75A8.E997D9EC@netscape.com>
Date: Mon, 07 Dec 1998 19:41:12 -0500
From: Mike Shaver <shaver@netscape.com>
Organization: Just Another Snake Cult
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux/SGI <linux@cthulhu.engr.sgi.com>
Subject: compiling CVS kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Trying to get my new disk and stuff all working (thanks, Kev!), so that
I can take Yet Another Futile Run At EFS, and I can't compile the kernel
out of CVS:

[shaver@zamboni linux]$ gmake CROSS_COMPILE=mips-linux- boot
mips-linux-gcc -D__KERNEL__ -I/work/sgi-linux/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
-mcpu=r4600 -mips2 -pipe  -c -o init/main.o init/main.c
/work/sgi-linux/linux/include/linux/sched.h: In function `on_sig_stack':
In file included from init/main.c:17:
/work/sgi-linux/linux/include/linux/sched.h:528: `current' undeclared
(first use this function)
/work/sgi-linux/linux/include/linux/sched.h:528: (Each undeclared
identifier is reported only once
/work/sgi-linux/linux/include/linux/sched.h:528: for each function it
appears in.)
/work/sgi-linux/linux/include/linux/sched.h:530: warning: control
reaches end of non-void function
/work/sgi-linux/linux/include/linux/sched.h: In function `sas_ss_flags':
/work/sgi-linux/linux/include/linux/sched.h:534: `current' undeclared
(first use this function)
/work/sgi-linux/linux/include/linux/sched.h:536: warning: control
reaches end of non-void function
/work/sgi-linux/linux/include/linux/sched.h: In function `suser':
/work/sgi-linux/linux/include/linux/sched.h:561: `current' undeclared
(first use this function)
/work/sgi-linux/linux/include/linux/sched.h: In function `fsuser':
/work/sgi-linux/linux/include/linux/sched.h:570: `current' undeclared
(first use this function)
/work/sgi-linux/linux/include/linux/sched.h: In function `capable':
/work/sgi-linux/linux/include/linux/sched.h:586: `current' undeclared
(first use this function)
/work/sgi-linux/linux/include/linux/mm.h: In function `expand_stack':
In file included from /work/sgi-linux/linux/include/linux/slab.h:14,
                 from /work/sgi-linux/linux/include/linux/malloc.h:4,
                 from /work/sgi-linux/linux/include/linux/proc_fs.h:6,
                 from init/main.c:24:
/work/sgi-linux/linux/include/linux/mm.h:353: `current' undeclared
(first use this function)
gmake: *** [init/main.o] Error 1

Thoughts?

Mike

-- 
1840216.79 1276744.78
