Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jun 2003 20:20:17 +0100 (BST)
Received: from pfepc.post.tele.dk ([IPv6:::ffff:193.162.153.4]:5165 "EHLO
	pfepc.post.tele.dk") by linux-mips.org with ESMTP
	id <S8224861AbTFGTUD>; Sat, 7 Jun 2003 20:20:03 +0100
Received: from 0x50c49fa4.adsl-fixed.tele.dk (0x50c49fa4.adsl-fixed.tele.dk [80.196.159.164])
	by pfepc.post.tele.dk (Postfix) with ESMTP
	id 0F0C926293B; Sat,  7 Jun 2003 21:19:34 +0200 (CEST)
Subject: Re: pcmcia problem on pb1500
From: Jan Pedersen <jp@q-networks.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <1054919329.18838.184.camel@zeus.mvista.com>
References: <1054907964.14600.172.camel@jp> 
	<1054919329.18838.184.camel@zeus.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 07 Jun 2003 21:18:36 +0200
Message-Id: <1055013539.10775.46.camel@jp>
Mime-Version: 1.0
Return-Path: <jp@q-networks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jp@q-networks.com
Precedence: bulk
X-list: linux-mips

> Not surprising :)  The 36bit_add_xxxx patch was applied to the tree so
> it's not integrated in the source tree. So this begs the question --
> what version of linux-mips are you using? If you're using the latest cvs
> bits, applying the above 36bit patch should have failed miserably. You
> do need the 64bit_pcmcia.patch though.

I am not using linux-mips. I am using 2.4.19 directly from kernel.org.
Some files are patched from mips-linux (non-pcmcia stuff).

Tried latest cvs version from linux-mips.org this weekend. By some
reason I can't get any output on the serial port. If this kernel should
work, maybe getting the serial-port to work on this is an easier task
:-)

On the other hand, everything else I need is currently working on 2.4.19
(including pci)

Tried to do the 64bit_pcmcia.patch alone. Same result:

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
Yenta IRQ list 0000, PCI irq4
Socket status: 30000046
Yenta IRQ list 0000, PCI irq4
Socket status: 30000011
cardmgr[148]: watching 2 sockets
cardmgr[148]: could not adjust resource: IO ports 0xc00-0xcff: Invalid
argument
cardmgr[148]: could not adjust resource: IO ports 0x100-0x4ff: Invalid
argument
cardmgr[148]: could not adjust resource: memory 0x80000000-0x80ffffff:
Invalid argument
cardmgr[149]: starting, version is 3.2.4
Done.
cardmgr[cs: unable to map card memory!
14cs: unable to map card memory!
9]: initializing socket 1
cardmgr[149]: socket 1: Anonymous Memory
cardmgr[149]: module memory_cs.o not available
cardmgr[149]: executing: 'modprobe memory_cs'
cardmgr[149]: get dev info on socket 1 failed: Resource temporarily
unavailable

Best result is with no patches, where it finds my cisco card.

> 
> Take a look at the archives again and see how Jeff setup config.opts on
> the target board. That was the key.  The cardmgr is recognizing your
> card so it's reading the attribute memory successfully. You're almost
> there ;)
My configuration is based on his.
yes, it seems like it can access the attribute memory, but not the io
memory.

I was vondering about the io addresses shown with lspci -v. Are they
valid?
00:0d.0 Class 0607: 104c:ac55 (rev 01)
   I/O window 0: 00000000-00000fff
   I/O window 1: 00000000-00000003
00:0d.1 Class 0607: 104c:ac55 (rev 01)
   I/O window 0: 00000000-00000003
   I/O window 1: 00001000-00001fff

anyway, thanks a lot for helping
Jan
