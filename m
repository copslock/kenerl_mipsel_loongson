Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA07673; Tue, 5 Aug 1997 13:38:40 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA07348 for linux-list; Tue, 5 Aug 1997 11:52:07 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA07298 for <linux@engr.sgi.com>; Tue, 5 Aug 1997 11:51:57 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA14097
	for <linux@engr.sgi.com>; Tue, 5 Aug 1997 11:51:56 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id OAA06002 for linux@engr.sgi.com; Tue, 5 Aug 1997 14:48:33 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708051848.OAA06002@neon.ingenia.ca>
Subject: indyIRQ.S
To: linux@cthulhu.engr.sgi.com (Linux/SGI list)
Date: Tue, 5 Aug 1997 14:48:32 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Up-to-the-minute copy of the kernel, Ralf's Intel binutils, etc.

mips-linux-gcc -D__KERNEL__ -I/export/sgi-linux/kernel/linux/include -D__GOGOGO__ -c indyIRQ.S -o indyIRQ.o
indyIRQ.S: Assembler messages:
indyIRQ.S:72: Warning: No .cprestore pseudo-op used in PIC code
indyIRQ.S:83: Warning: No .cprestore pseudo-op used in PIC code
indyIRQ.S:95: Warning: No .cprestore pseudo-op used in PIC code
indyIRQ.S:107: Warning: No .cprestore pseudo-op used in PIC code
indyIRQ.S:124: Warning: No .cprestore pseudo-op used in PIC code
indyIRQ.S:75: Error: Can not represent relocation in this object file format
indyIRQ.S:86: Error: Can not represent relocation in this object file format
indyIRQ.S:98: Error: Can not represent relocation in this object file format
indyIRQ.S:110: Error: Can not represent relocation in this object file format
indyIRQ.S:127: Error: Can not represent relocation in this object file format
make[1]: *** [indyIRQ.o] Error 1
make[1]: *** Waiting for unfinished jobs....

Any ideas?

I'm also seeing a problem with asm/atomic.h and the like; stuff about
invalid operands for binary +, etc.  I expect it's a CFLAGS or GCC
spec file thing, but those should both be standard.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Linux: because every cycle counts.
#>
#> "I don't know what you do for a living[...]" -- perry@piermont.com
#>        "I change the world." -- davem@caip.rutgers.edu
