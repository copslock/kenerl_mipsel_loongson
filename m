Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA51503 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Feb 1999 20:32:00 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA54027
	for linux-list;
	Fri, 26 Feb 1999 20:30:57 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA50881
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Feb 1999 20:30:55 -0800 (PST)
	mail_from (gkm@total.net)
Received: from wacky.total.net (wacky.total.net [205.236.175.121]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA06696
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Feb 1999 20:30:54 -0800 (PST)
	mail_from (gkm@total.net)
From: gkm@total.net
Received: from total.net (local-182.montreal.mpact.net [204.19.168.182])
	by wacky.total.net (8.9.1/8.8.5) with ESMTP id XAA21725
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Feb 1999 23:30:52 -0500 (EST)
Message-Id: <199902270430.XAA21725@wacky.total.net>
X-Mailer: exmh version 2.0.2
To: linux@cthulhu.engr.sgi.com
Subject: Re: 2.2.1 MIPS kernel sources plus Indy kernel binaries uploaded 
In-Reply-To: Your message of "Sat, 27 Feb 1999 00:16:17 +0100."
             <19990227001617.A4022@alpha.franken.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Feb 1999 23:30:50 -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> After syncing my two source trees with CVS, I've exported a tarball
> and uploaded it to
> 
> ftp://ftp.linux.sgi.com/pub/linux/mips/test/linux-2.2.1-990226.tar.gz
> 
I've tried compiling this on a base hardhat installation and here's the 
resuults so far.. (no, haven't gotten a kernel out of it yet)

First, there's no modutils.  I grabbed modutils2.1.121 and that compiled and 
installed fine.
Next, it almost immediately blew up on a lack of a current structure.
I found that /usr/include/asm/current.h had a conditional defining of the 
struct if C_language was defines, and something else if ASMing.  I just took 
out the conditional(don't know if it's the right thing, but compiling went 
alot further)
Lastly(and most messily) it got to arch mips and tried some ASMing.
Here's a short piece of that:
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe -c indyIRQ.S -o indyIRQ.o
/usr/src/linux/include/asm/mipsregs.h: Assembler messages:
/usr/src/linux/include/asm/mipsregs.h:177: Error: unrecognized opcode `extern'
/usr/src/linux/include/asm/mipsregs.h:177: Error: Bad expression
/usr/src/linux/include/asm/mipsregs.h:177: Error: Missing ')' assumed
/usr/src/linux/include/asm/mipsregs.h:177: Error: Rest of line ignored. First ignored character is `i'.
/usr/src/linux/include/asm/mipsregs.h:177: Error: unrecognized opcode `__asm__'
/usr/src/linux/include/asm/mipsregs.h:177: Error: unrecognized opcode `__res'
/usr/src/linux/include/asm/mipsregs.h:177: Error: Rest of line ignored. First ignored character is `}'.
/usr/src/linux/include/asm/mipsregs.h:177: Error: unrecognized opcode `res'
/usr/src/linux/include/asm/mipsregs.h:177: Error: unrecognized opcode `res'

How has everyone else faired in the compiling game?  :)

Greg
