Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 22:49:30 +0100 (BST)
Received: from p508B5AFA.dip.t-dialin.net ([IPv6:::ffff:80.139.90.250]:64600
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225783AbUEJVt3>; Mon, 10 May 2004 22:49:29 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4ALnRxT012350;
	Mon, 10 May 2004 23:49:27 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4ALnR38012349;
	Mon, 10 May 2004 23:49:27 +0200
Date: Mon, 10 May 2004 23:49:27 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Emmanuel Michon <em@realmagic.fr>
Cc: linux-mips@linux-mips.org
Subject: Re: new platform
Message-ID: <20040510214927.GB22442@linux-mips.org>
References: <1084199090.12536.1314.camel@avalon.france.sdesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084199090.12536.1314.camel@avalon.france.sdesigns.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 10, 2004 at 04:24:51PM +0200, Emmanuel Michon wrote:

> I plan to port linux-mips to a a 32bit 4KEc based (little endian)
> hardware design.
> 
> I have three questions:
> 
> Q1- The nice book `see mips run' states that it's better that the
> physical address map fits entirely in kseg1 (in 0x0-0x2000_0000).
> 
> I would not be the first to plan for a lot of RAM and I understand
> HIGHMEM patch is ok if an extra RAM area is out of reach of kseg1.

Using highmem in general is a baaad idea.  The option only exists at all
for MIPS because of a user who didn't want to try something as unorthodox
as 64-bit kernels ...

Highmem implies significant extra overhead and complexity for software
that runs in kernel space.  Avoid like the plague if you can.

> But what if my PCI devices I/O do not lie in kseg1? I may program the
> TLB to see them thru kseg2 (but kseg2 seems to be the place where page
> tables are stored...)

Doesn't really matter.  It's nice to have devices in the lower 512MB of
physical address space because that means the TLB will not be used - a
nice performance bonus.

Whatever - the driver API to use is ioremap.

> Q2- Most hardware platforms have their SDRAM chips mapped at
> physical address 0x0. Mine does not. Am I going ahead of problems?

It won't work ;-)

You at least need some memory at physical address zero because exception
vectors are located in the first few k of physical address space.  Of
course you could avoid that by having the BEV bit set in the status
register so exceptions would go via 0xbfc00000 - but that's an uncached
address, likely even in a flash so performance would go down the drain ...

> It seems to be assumed at a lot of places (I have already ported YAMON).
> 
> Q3- I'd rather stick to a 2.4.x linux port. But... should I use:

Depending on what exactly you want to do you should take a look at 2.6.

> a- the latest official 2.4.x kernel
> b- the latest 2.4.x-preY kernel

kernel.org kernels won't work out of the box or at least your chances
are worse due to the lag in merging MIPS code from to kernel.org.

> c- the latest linux-mips.org 2.4.x kernel
> d- cvs -z3 -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co -r linux_2_4

D - where C and D are the basically the same anyway - I've stopped making
snapshot tarballs years ago, so you'll have to fetch from cvs.

  Ralf
