Received:  by oss.sgi.com id <S305155AbQAGWyO>;
	Fri, 7 Jan 2000 14:54:14 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:18729 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbQAGWyF>;
	Fri, 7 Jan 2000 14:54:05 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00671; Fri, 7 Jan 2000 14:54:46 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA78251
	for linux-list;
	Fri, 7 Jan 2000 14:44:28 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA31141
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 7 Jan 2000 14:44:24 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06917
	for <linux@cthulhu.engr.sgi.com>; Fri, 7 Jan 2000 14:44:22 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-9.uni-koblenz.de (cacc-9.uni-koblenz.de [141.26.131.9])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id XAA21788;
	Fri, 7 Jan 2000 23:44:10 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQAGWlj>;
	Fri, 7 Jan 2000 23:41:39 +0100
Date:   Fri, 7 Jan 2000 23:41:39 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
Cc:     linux@cthulhu.engr.sgi.com, kernel@ti.com
Subject: Re: C/Assembler question
Message-ID: <20000107234139.A20825@uni-koblenz.de>
References: <387612F1.99CD5C92@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <387612F1.99CD5C92@ti.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Jan 07, 2000 at 09:23:13AM -0700, Jeff Harrell wrote:

> I seem to be having problems with the compiler in getting a  c/assembly
> listing.  I have tried a couple sets of the tools and seem to be
> getting the same error with both sets.  Is my syntax correct on the line
> below?  Its the -Wa,-a=pc_keyb.lst that seems to cause the
> problem.
> 
> mips-linux-gcc -D__KERNEL__ -I/home/jharrell/work/mips_linux/include -g
> -Wa,-a=pc_keyb.lst -Wall -Wstrict-prototypes -Wa,-a -O2
> -fomit-frame-pointer  -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips3
> -pipe   -c -o pc_keyb.o pc_keyb.c
> 
> 
> This is the error that I get when I attempt it:
> 
> pc_keyb.c: In function `kb_wait':
> pc_keyb.c:103: warning: unused variable `status'
> {standard input}: Assembler messages:
> {standard input}:565: Fatal error: Symbol kb_wait already defined.
> 
> 
> Is there a formatting problem with this command?  Any help would be
> greatly appreciated.

This is weird.  You pass an extra option to the assembler and the
compiler begins to spit errors?  Try adding -v as well and check gcc
actually passes down to cpp / cc1 / as, maybe that explains things.

  Ralf
