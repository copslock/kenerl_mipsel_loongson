Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA91664 for <linux-archive@neteng.engr.sgi.com>; Fri, 2 Apr 1999 16:53:22 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA41124
	for linux-list;
	Fri, 2 Apr 1999 16:52:22 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA02558
	for <linux@engr.sgi.com>;
	Fri, 2 Apr 1999 16:52:18 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA05255
	for <linux@engr.sgi.com>; Fri, 2 Apr 1999 16:52:16 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-13.uni-koblenz.de [141.26.131.13])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA14027
	for <linux@engr.sgi.com>; Sat, 3 Apr 1999 02:52:13 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id BAA13397;
	Sat, 3 Apr 1999 01:31:02 +0200
Message-ID: <19990403013101.F11665@uni-koblenz.de>
Date: Sat, 3 Apr 1999 01:31:01 +0200
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: ALSA compile error
References: <19990402223303.A20067@bun.falkenberg.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990402223303.A20067@bun.falkenberg.se>; from Ulf Carlsson on Fri, Apr 02, 1999 at 10:33:17PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Apr 02, 1999 at 10:33:17PM -0500, Ulf Carlsson wrote:

> I've been trying with egcs 1.0.2, gcc 2.7.2, binutils 2.8.1 and binutils 2.9.1
> and it doesn't make any difference. I've also been trying without -pipe and
> -fomit-frame-pointer.

Use egcs 1.0.x and binutils 2.8.1.

> This is the error message:
> 
> gcc -O2  -DLINUX -mips2 -mcpu=r4600 -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe -I/usr/src/linux/include -I../include -c -o sound.o sound.c
> /tmp/cca03757.s: Assembler messages:
> /tmp/cca03757.s:1228: Error: Can not represent BFD_RELOC_16_PCREL_S2 relocation in this object file format
> /tmp/cca03757.s:1285: Error: Can not represent BFD_RELOC_16_PCREL_S2 relocation in this object file format

> It was something about the haifa scheduler I think.

Haifa is innocent.  You are trying to compile the thing into PIC code and
that won't work for kernel code.  Add -fno-pic -mno-abicalls and for modules
also add -mlong-calls.

  Ralf
