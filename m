Received:  by oss.sgi.com id <S305155AbQAGRAb>;
	Fri, 7 Jan 2000 09:00:31 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:20032 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbQAGRAS>;
	Fri, 7 Jan 2000 09:00:18 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA08134; Fri, 7 Jan 2000 08:59:30 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA55458
	for linux-list;
	Fri, 7 Jan 2000 08:22:45 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA56933
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 7 Jan 2000 08:22:27 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from gatekeep.ti.com (gatekeep.ti.com [192.94.94.61]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA07773
	for <linux@cthulhu.engr.sgi.com>; Fri, 7 Jan 2000 08:21:45 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from dlep9.itg.ti.com ([157.170.135.38])
	by gatekeep.ti.com (8.9.3/8.9.3) with ESMTP id KAA02544
	for <linux@cthulhu.engr.sgi.com>; Fri, 7 Jan 2000 10:21:39 -0600 (CST)
Received: from dlep9.itg.ti.com (localhost [127.0.0.1])
	by dlep9.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA00945
	for <linux@cthulhu.engr.sgi.com>; Fri, 7 Jan 2000 10:21:39 -0600 (CST)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep9.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA00941
	for <linux@cthulhu.engr.sgi.com>; Fri, 7 Jan 2000 10:21:38 -0600 (CST)
Received: from ti.com (IDENT:jharrell@pcp97780pcs.sc.ti.com [158.218.100.100])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA14745;
	Fri, 7 Jan 2000 10:21:38 -0600 (CST)
Message-ID: <387612F1.99CD5C92@ti.com>
Date:   Fri, 07 Jan 2000 09:23:13 -0700
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com
CC:     kernel@ti.com
Subject: C/Assembler question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I seem to be having problems with the compiler in getting a  c/assembly
listing.  I have tried a couple sets of the tools and seem to be
getting the same error with both sets.  Is my syntax correct on the line
below?  Its the -Wa,-a=pc_keyb.lst that seems to cause the
problem.

mips-linux-gcc -D__KERNEL__ -I/home/jharrell/work/mips_linux/include -g
-Wa,-a=pc_keyb.lst -Wall -Wstrict-prototypes -Wa,-a -O2
-fomit-frame-pointer  -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips3
-pipe   -c -o pc_keyb.o pc_keyb.c


This is the error that I get when I attempt it:

pc_keyb.c: In function `kb_wait':
pc_keyb.c:103: warning: unused variable `status'
{standard input}: Assembler messages:
{standard input}:565: Fatal error: Symbol kb_wait already defined.


Is there a formatting problem with this command?  Any help would be
greatly appreciated.

Thanks,
Jeff

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
