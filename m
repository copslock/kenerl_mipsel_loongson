Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 10:22:31 +0100 (BST)
Received: from c2ce9fba.adsl.oleane.fr ([IPv6:::ffff:194.206.159.186]:42920
	"EHLO avalon.france.sdesigns.com") by linux-mips.org with ESMTP
	id <S8225721AbUEKJW2>; Tue, 11 May 2004 10:22:28 +0100
Received: from avalon.france.sdesigns.com (localhost.localdomain [127.0.0.1])
	by avalon.france.sdesigns.com (8.12.8/8.12.8) with ESMTP id i4B9MQ1q004741
	for <linux-mips@linux-mips.org>; Tue, 11 May 2004 11:22:26 +0200
Received: (from michon@localhost)
	by avalon.france.sdesigns.com (8.12.8/8.12.8/Submit) id i4B9MMJE004739
	for linux-mips@linux-mips.org; Tue, 11 May 2004 11:22:22 +0200
X-Authentication-Warning: avalon.france.sdesigns.com: michon set sender to em@realmagic.fr using -f
Subject: Re: new platform
From: Emmanuel Michon <em@realmagic.fr>
To: linux-mips@linux-mips.org
In-Reply-To: <20040510214927.GB22442@linux-mips.org>
References: <1084199090.12536.1314.camel@avalon.france.sdesigns.com>
	 <20040510214927.GB22442@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: REALmagic France SAS
Message-Id: <1084267342.2222.1348.camel@avalon.france.sdesigns.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 May 2004 11:22:22 +0200
Return-Path: <em@realmagic.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: em@realmagic.fr
Precedence: bulk
X-list: linux-mips

On Mon, 2004-05-10 at 23:49, Ralf Baechle wrote:
> On Mon, May 10, 2004 at 04:24:51PM +0200, Emmanuel Michon wrote:
> 
> > I plan to port linux-mips to a a 32bit 4KEc based (little endian)
> > hardware design.
> > 
> > I have three questions:
> > 
> > Q1- The nice book `see mips run' states that it's better that the
> > physical address map fits entirely in kseg1 (in 0x0-0x2000_0000).
> > 
> > I would not be the first to plan for a lot of RAM and I understand
> > HIGHMEM patch is ok if an extra RAM area is out of reach of kseg1.
> 
> Using highmem in general is a baaad idea.  The option only exists at all
> for MIPS because of a user who didn't want to try something as unorthodox
> as 64-bit kernels ...
> 
> Highmem implies significant extra overhead and complexity for software
> that runs in kernel space.  Avoid like the plague if you can.
> 
> > But what if my PCI devices I/O do not lie in kseg1? I may program the
> > TLB to see them thru kseg2 (but kseg2 seems to be the place where page
> > tables are stored...)
> 
> Doesn't really matter.  It's nice to have devices in the lower 512MB of
> physical address space because that means the TLB will not be used - a
> nice performance bonus.
> 
> Whatever - the driver API to use is ioremap.

You mean that after basic probing you always access PCI devices thru the
TLB?

> 
> > Q2- Most hardware platforms have their SDRAM chips mapped at
> > physical address 0x0. Mine does not. Am I going ahead of problems?
> 
> It won't work ;-)
> 
> You at least need some memory at physical address zero because exception
> vectors are located in the first few k of physical address space.  Of
> course you could avoid that by having the BEV bit set in the status
> register so exceptions would go via 0xbfc00000 - but that's an uncached
> address, likely even in a flash so performance would go down the drain ...

Well my 4KEc core has a CP0 register called EBase (15 select 1) that
allows to put the vectors anywhere (excepted reset/softreset/nmi/ejtag).

> 
> > It seems to be assumed at a lot of places (I have already ported YAMON).
> > 
> > Q3- I'd rather stick to a 2.4.x linux port. But... should I use:
> 
> Depending on what exactly you want to do you should take a look at 2.6.
> 
> > a- the latest official 2.4.x kernel
> > b- the latest 2.4.x-preY kernel
> 
> kernel.org kernels won't work out of the box or at least your chances
> are worse due to the lag in merging MIPS code from to kernel.org.
> 
> > c- the latest linux-mips.org 2.4.x kernel
> > d- cvs -z3 -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co -r linux_2_4
> 
> D - where C and D are the basically the same anyway - I've stopped making
> snapshot tarballs years ago, so you'll have to fetch from cvs.

Thanks

Sincerely yours,

E.M.

> 
>   Ralf
> 
> 
