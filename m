Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 16:49:08 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:15109 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021598AbXGKPtG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 16:49:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 991A6E1D03;
	Wed, 11 Jul 2007 17:48:31 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fa3Xsp9VAZqh; Wed, 11 Jul 2007 17:48:31 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 51549E1C67;
	Wed, 11 Jul 2007 17:48:31 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6BFmcQa017508;
	Wed, 11 Jul 2007 17:48:38 +0200
Date:	Wed, 11 Jul 2007 16:48:35 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Songmao Tian <tiansm@lemote.com>
cc:	LinuxBIOS Mailing List <linuxbios@linuxbios.org>,
	marc.jones@amd.com, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: about cs5536 interrupt ack
In-Reply-To: <4694F4EB.8040000@lemote.com>
Message-ID: <Pine.LNX.4.64N.0707111634430.26459@blysk.ds.pg.gda.pl>
References: <4694A495.1050006@lemote.com> <Pine.LNX.4.64N.0707111347360.26459@blysk.ds.pg.gda.pl>
 <4694F4EB.8040000@lemote.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3635/Wed Jul 11 13:30:51 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 11 Jul 2007, Songmao Tian wrote:

> > Huh?  Have you managed to find an 8259A clone *that* broken?  So what does
> > it return if you write 0xc to the address 0x20 in the I/O port space and
> > then read back from that location?  You should complain to the 
> >   
> 
> It's the value of IRR, so guess IRR. AMD has well documented cs5536, I
> appreciate that.

 Indeed.  I am surprised they have decided to drop the poll command -- it 
surely does not require much logic as it mostly reuses what's used to 
produce the vector anyway and it is commonly used when 8259A 
implementations are interfaced to non-i386 processors.  PPC is another 
example.

> > More or less -- 3-5 should probably be the outcome of a single read
> > transaction from the north bridge.  I.e. you issue a read to a "magic"
> > location, 3-5 happen, and the data value returned is the vector presented by
> > the interrupt controller on the PCI bus.
> >   
> yeah, we can implement a register in north bridge.

 Strictly speaking it would not be a register, but a "PCI INTA address 
space" much like PCI memory or I/O port address spaces.  Though as the 
former ignores addresses driven on the bus, the space occupied does not 
have to be extensive -- I would assume whatever slot size is available 
with the address decoder you have implemented would do.

> > You can still dispatch interrupts manually by examining the IRR register,
> > but having a way to ask the 8259A's prioritiser would be nice.  Although
> > given such a lethal erratum you report I would not count on the prioritiser
> > to provide any useful flexibility...
> >   
> yeah, that's a straight thought, tried but failed:(, patch followed.

 You may have to modify other functions from arch/mips/kernel/i8259.c; 
yes, this makes the whole experience not as pretty as one would hope...

  Maciej
