Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2003 08:29:35 +0100 (BST)
Received: from pfepc.post.tele.dk ([IPv6:::ffff:193.162.153.4]:52271 "EHLO
	pfepc.post.tele.dk") by linux-mips.org with ESMTP
	id <S8225201AbTFIH3b>; Mon, 9 Jun 2003 08:29:31 +0100
Received: from 0x50c49fa4.adsl-fixed.tele.dk (0x50c49fa4.adsl-fixed.tele.dk [80.196.159.164])
	by pfepc.post.tele.dk (Postfix) with ESMTP
	id A0BB726299C; Mon,  9 Jun 2003 09:29:21 +0200 (CEST)
Subject: Re: pcmcia problem on pb1500
From: Jan Pedersen <jp@q-networks.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <1055110501.11039.2.camel@adsl.pacbell.net>
References: <1054907964.14600.172.camel@jp>
	<1054919329.18838.184.camel@zeus.mvista.com> <1055013539.10775.46.camel@jp>
	 <1055110501.11039.2.camel@adsl.pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 09 Jun 2003 09:28:18 +0200
Message-Id: <1055143704.17835.16.camel@jp>
Mime-Version: 1.0
Return-Path: <jp@q-networks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jp@q-networks.com
Precedence: bulk
X-list: linux-mips

> Take a look at the toplevel Makefile. I bet you got the head of
> linux-mips which is 2.5 and, yes, it's quite borked right now :) I've
> made some progress on the Pb1500 but until I get that board fully
> functioning, I won't update the rest.  To get 2.4, do a "cvs update
> -rlinux_2_4".

No luck :-(

Tried 2.4.21-pre3 from linux-mips.org with both patches. This should be
the configuration Jeff got to work.
<cardmgr[159]: watching 2 sockets
<cardmgr[159]: could not adjust resource: IO ports 0-0x1fff: Invalid
argument
<cardmgr[159]: could not adjust resource: IO ports 0xc00-0xcff: Invalid
argument
<cardmgr[159]: could not adjust resource: IO ports 0x100-0x4ff: Invalid
argument
<cardmgr[159]: could not adjust resource: memory 0x40000000-0x41ffffff:
Invalid argument
<cardmgr[160]: starting, version is 3.2.4
<Done.
<cardmgr[1cs: unable to map card memory!
<60cs: unable to map card memory!

tried 2.4 from linux-mips.org
<Linux Kernel Card Services 3.1.22
<  options:  [pci] [cardbus]
<yenta 00:0d.1: Preassigned resource 0 busy, reconfiguring...
<yenta 00:0d.1: Preassigned resource 1 busy, reconfiguring...
<yenta 00:0d.1: Preassigned resource 2 busy, reconfiguring...
<Yenta IRQ list 0000, PCI irq1
<Socket status: 30000046
<Yenta IRQ list 0000, PCI irq1
<Socket status: 30000011
<cardmgr[159]: watching 2 sockets
<cardmgr[159]: could not adjust resource: IO ports 0-0x1fff: Invalid
argument
<cardmgr[159]: could not adjust resource: IO ports 0xc00-0xcff: Invalid
argument
<cardmgr[159]: could not adjust resource: IO ports 0x100-0x4ff: Invalid
argument
<cardmgr[159]: could not adjust resource: memory 0x40000000-0x41ffffff:
<Invalid argument
<cardmgr[160]: starting, version is 3.2.4
<Done.
<cardmgrcs: unable to map card memory!
<[1cs: unable to map card memory!

tried same with 64bit_pcmcia.patch
same result. I guess that the 36bit patch is included in this kernel?

Tried 2.4.21 & 2.4.21-pre7 from kernel.org
They die when initializing pci.

Are there different versions of the 36bit-patch? Mine is named
36bit_addr_121302.patch

regards
Jan

> 
> > On the other hand, everything else I need is currently working on 2.4.19
> > (including pci)
> > 
> > Tried to do the 64bit_pcmcia.patch alone. Same result:
> > 
> > Linux Kernel Card Services 3.1.22
> >   options:  [pci] [cardbus]
> > Yenta IRQ list 0000, PCI irq4
> > Socket status: 30000046
> > Yenta IRQ list 0000, PCI irq4
> > Socket status: 30000011
> > cardmgr[148]: watching 2 sockets
> > cardmgr[148]: could not adjust resource: IO ports 0xc00-0xcff: Invalid
> > argument
> > cardmgr[148]: could not adjust resource: IO ports 0x100-0x4ff: Invalid
> > argument
> > cardmgr[148]: could not adjust resource: memory 0x80000000-0x80ffffff:
> > Invalid argument
> > cardmgr[149]: starting, version is 3.2.4
> > Done.
> > cardmgr[cs: unable to map card memory!
> > 14cs: unable to map card memory!
> > 9]: initializing socket 1
> > cardmgr[149]: socket 1: Anonymous Memory
> > cardmgr[149]: module memory_cs.o not available
> > cardmgr[149]: executing: 'modprobe memory_cs'
> > cardmgr[149]: get dev info on socket 1 failed: Resource temporarily
> > unavailable
> > 
> > Best result is with no patches, where it finds my cisco card.
> > 
> > > 
> > > Take a look at the archives again and see how Jeff setup config.opts on
> > > the target board. That was the key.  The cardmgr is recognizing your
> > > card so it's reading the attribute memory successfully. You're almost
> > > there ;)
> > My configuration is based on his.
> > yes, it seems like it can access the attribute memory, but not the io
> > memory.
> > 
> > I was vondering about the io addresses shown with lspci -v. Are they
> > valid?
> 
> I think so, yes.
> 
> Pete
> 
> > 00:0d.0 Class 0607: 104c:ac55 (rev 01)
> >    I/O window 0: 00000000-00000fff
> >    I/O window 1: 00000000-00000003
> > 00:0d.1 Class 0607: 104c:ac55 (rev 01)
> >    I/O window 0: 00000000-00000003
> >    I/O window 1: 00001000-00001fff
> > 
> > anyway, thanks a lot for helping
> > Jan
> > 
> > 
> > 
> > 
> 
