Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 18:36:55 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:43015 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122958AbSIDQgz>; Wed, 4 Sep 2002 18:36:55 +0200
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g84GaST05268;
	Wed, 4 Sep 2002 09:36:28 -0700
Date: Wed, 4 Sep 2002 09:36:27 -0700
From: Matthew Dharm <mdharm@momenco.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dominic Sweetman <dom@algor.co.uk>, Jun Sun <jsun@mvista.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Interrupt handling....
Message-ID: <20020904093627.A5241@momenco.com>
References: <200209040953.KAA17466@mudchute.algor.co.uk> <Pine.GSO.3.96.1020904144630.10619F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020904144630.10619F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Sep 04, 2002 at 02:58:26PM +0200
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Return-Path: <mdharm@host099.momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 80
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

On Wed, Sep 04, 2002 at 02:58:26PM +0200, Maciej W. Rozycki wrote:
> On Wed, 4 Sep 2002, Dominic Sweetman wrote:
> 
> > > Which, as you can see, attempts to access address 0xfc00000c.
> > 
> > But that address is in the MIPS CPU's 'kseg2' region.  Addresses there
> > are always translated by the TLB, and you haven't got an entry.
> > 
> > Registers from things like the 2nd level interrupt controller are
> > memory mapped I/O locations, and you need to do an uncached access to
> > the appropriate physical address.
> 
>  As I understand 0xfc00000c is the physical address.  Thus you cannot
> reach it via KSEG0/1 (although you may use XKPHYS to get there in the
> 64-bit mode).  Still ioremap() already handles the case mapping the area
> requested in the KSEG2 space, so it should work just fine. 

This is the case.  The board itself has up to 1G of SDRAM.  Most of the
boards we sell have a minimum of 512MB.  So our I/O (PCI, external devices,
etc.) all have physical addresses in the high-end of the address space.

64-bit mode would be great... and we plan to go there eventually.  But, for
now, 32-bit is where we are.

> > Most MIPS hardware has registers mapped between 0-512Mbyte
> > (0-0x1fff.ffff) physical, because a MIPS CPU can do uncached accesses
> > to that using the 'kseg1' window, which occupies the 
> > 
> >   0xa000.0000-0xbfff.ffff  (CPU virtual address)
> >   0x0000.0000-0x1fff.ffff  (physical address).
> 
>  As I understand this is an exception.  Possibly the system supports more
> than 512MB of RAM and the designers wanted to avoid holes. 

This is exactly the case.  Our organization focuses on high-end computing
platforms.  512MB is becoming a minimum amount of memory for us.

Matt

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
