Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 18:18:26 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:29358 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023472AbYAOSSO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 18:18:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0FIICb8015018;
	Tue, 15 Jan 2008 18:18:12 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0FIIC0e015017;
	Tue, 15 Jan 2008 18:18:12 GMT
Date:	Tue, 15 Jan 2008 18:18:12 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080115181812.GA14816@linux-mips.org>
References: <20080115112420.GA7347@alpha.franken.de> <20080115131145.GA5189@linux-mips.org> <20080115135300.GB5189@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080115135300.GB5189@linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 15, 2008 at 01:53:00PM +0000, Ralf Baechle wrote:

> > > we are facing a strange problem with lenny/sid chroots on IP28. The
> > > machine locks up after issuing a few ls/ps commands in a chroot
> > > bash. This only happens with a lenny/sid chroot, but not with etch.
> > > The major difference is probably the updare to glibc2.7. Since
> > > IP28 isn't really a nice R10k machine, it would be good, if someone
> > > with a working IP27/IP30 could try a lenny/sid chroot and tell us,
> > > if it's working/not working.
> > 
> > Which CPU revision do you hit these problems on?
> 
> On IRC Thomas said it's rev 2.5.
> 
> R10000 upto version 2.6 has a broken store conditional so needs
> R10000_LLSC_WAR enabled.  The sympthom is that SC succeed even though
> it should have failed so for example two multiple competing CPUs can
> take a spinlock.  There is an erratum for this one.
> 
> Another bug is when a rdhwr $29 opcode is encountered in a branch delay
> slot.  This will result in the CPU stopping execution of instructions
> but an NMI can recover it.  For emulation performance reasons gcc no
> longer places rdhwr $29 in delay slots, so this one is no longer
> encountered in C code but still could be in assembler code.  This one
> isn't covered by any errata.
> 
> There seem to be more funnies but to the best I can say they were never
> officially documented in errata either.

So I tested the rootfs provided by Florian and more or less as expected
it immediately took out the 2 CPU R10000 v2.7 Origin I was testing on.
Seems like only one CPU stopped, as the machine was pinging and reacts
to NMIs.  So could well be the effect I observed ages ago when trying to
convert to glibc 2.4.

  Ralf
