Received:  by oss.sgi.com id <S305179AbQACWtp>;
	Mon, 3 Jan 2000 14:49:45 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:27511 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305166AbQACWt3>; Mon, 3 Jan 2000 14:49:29 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA09796; Mon, 3 Jan 2000 14:52:12 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA99621
	for linux-list;
	Mon, 3 Jan 2000 14:34:38 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA39037
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 3 Jan 2000 14:34:35 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from jester.ti.com (jester.ti.com [192.94.94.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA02843
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 Jan 2000 14:34:34 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from dlep9.itg.ti.com ([157.170.135.38])
	by jester.ti.com (8.9.3/8.9.3) with ESMTP id QAA20669
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 Jan 2000 16:33:58 -0600 (CST)
Received: from dlep9.itg.ti.com (localhost [127.0.0.1])
	by dlep9.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA01617
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 Jan 2000 16:34:33 -0600 (CST)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep9.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA01610
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 Jan 2000 16:34:33 -0600 (CST)
Received: from ti.com (IDENT:jharrell@pcp97780pcs.sc.ti.com [158.218.100.100])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA05096;
	Mon, 3 Jan 2000 16:34:32 -0600 (CST)
Message-ID: <38712453.B0BCE0CD@ti.com>
Date:   Mon, 03 Jan 2000 15:36:03 -0700
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com
CC:     bbrown@ti.com
Subject: C/Assembler listing files
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Has anyone tried to generate an interleaved C and Assembler listing file
with
the MIPS cross compilation tools?  I tried to pass the following flags
to gcc
(and the assembler):

-Wa,-ahl=file.txt

I get the following errors:
--------------------------------------------------------
mips-linux-gcc -D__KERNEL__ -I/home/jharrell/work/mips_linux/include
-Wall -g -Wa,-alh=signal.lst  -Wstrict-prototypes -O2
-fomit-frame-pointer  -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips3
-pipe   -DEXPORT_SYMTAB -c signal.c
signal.c: In function `dequeue_signal':
signal.c:106: warning: assignment from incompatible pointer type
signal.c:107: warning: assignment from incompatible pointer type
{standard input}: Assembler messages:
{standard input}:541: Fatal error: Symbol signals_init already defined.
signal.c: In function `sys_rt_sigprocmask':
signal.c:698: output pipe has been closed
cpp: output pipe has been closed

---------------------------------------------------------------

If I remove the  "-Wa,-ahl=file.txt" the kernel compiles with no
errors.  I attempt a
similar type of command on the x386 version of gcc and it seems to
work.  Is this a
command that is not supported on the MIPS cross-compilation tools?  Any
information
on this would be greatly appreciated.


Thanks,
Jeff Harrell

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
