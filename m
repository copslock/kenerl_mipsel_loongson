Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 19:15:37 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:51190 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224861AbTFQSPf>;
	Tue, 17 Jun 2003 19:15:35 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA25718;
	Tue, 17 Jun 2003 11:15:29 -0700
Subject: RE: wired tlb entry?
From: Pete Popov <ppopov@mvista.com>
To: Joseph Chiu <joseph@omnilux.net>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <BPEELMGAINDCONKDGDNCCEFPDMAA.joseph@omnilux.net>
References: <BPEELMGAINDCONKDGDNCCEFPDMAA.joseph@omnilux.net>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1055873800.4383.220.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Jun 2003 11:16:40 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


Any chance you can try 2.4.21-pre4 (latest linux-mips) before we go any
further?

Pete

On Tue, 2003-06-17 at 11:12, Joseph Chiu wrote:
> (Sorry for the double-send of the original inquiry to the list -- I actually
> got bounce notices from my mailer...)
> 
> This is the kernel from almost a year ago with the changes you made to
> support the 36-bit phys addr. access on the Au1xxx.
> The Au1x00 PCMCIA (CS release 3.1.22) initialization maps phys_mem f80000000
> to virt_io c0000000.
> 
> I am running HostAP (0.0.3) on top of this PCMCIA support, using a
> Prism3-based WiFi card.
> 
> During transmit/receive activity, the hardware interrupt invokes the
> prism2_interrupt() in hostap_cs.o which, in turn reads and writes from
> registers using the virtual i/o address of c0000000.
> 
> Under light and moderate loading, there are no problems.  After heavy
> traffic loads, the system eventually dies with accesses to address c000xxxx
> (one address gets hit 95% of the time - and there were other addresses a few
> other times, but always in the c000xxxx address range).
> 
> Thanks,
> Joseph
> 
> -----Original Message-----
> From: Pete Popov [mailto:ppopov@mvista.com]
> Sent: Tuesday, June 17, 2003 10:19 AM
> To: Joseph Chiu
> Cc: Linux MIPS mailing list
> Subject: Re: wired tlb entry?
> 
> 
> On Mon, 2003-06-16 at 17:36, Joseph Chiu wrote:
> > Hi,
> > Is there a (proper) way to add a page entry in the TLB it's always valid?
> > Specifically, accesses to memory-mapped hardware (PCMCIA) causes the
> kernel
> > to oops under heavy interrupt loading.
> > It seems to me that the page entry in the TLB is getting flushed out under
> > the activity; and when the ioremap'd memory region is accesses, the
> > exception handling for the missing translation does not run.
> >
> > I'm afraid my two days of googling hasn't turned up the right information.
> > I think I just don't know the right terminology and I hope someone can at
> > least point me in the right direction.
> > Thanks.
> > Joseph
> > (I am running 2.4.18-mips)
> 
> So is this a kernel from linux-mips.org?  Are you using the 36 bit I/O
> patch in that kernel, or the pseudo-address translation hack that I
> removed later? What pcmcia I/O card are you using and what tests are you
> running?
> 
> Pete
> 
> 
> 
