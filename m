Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 22:08:51 +0200 (CEST)
Received: from alg133.algor.co.uk ([62.254.210.133]:48625 "EHLO
	oval.algor.co.uk") by linux-mips.org with ESMTP id <S1122958AbSIDUIu>;
	Wed, 4 Sep 2002 22:08:50 +0200
Received: from mudchute.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g84K8Or29068;
	Wed, 4 Sep 2002 21:08:24 +0100 (BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id VAA25407;
	Wed, 4 Sep 2002 21:08:18 +0100 (BST)
Date: Wed, 4 Sep 2002 21:08:18 +0100 (BST)
Message-Id: <200209042008.VAA25407@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Matthew Dharm <mdharm@momenco.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Dominic Sweetman <dom@algor.co.uk>, Jun Sun <jsun@mvista.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Interrupt handling....
In-Reply-To: <20020904093627.A5241@momenco.com>
References: <200209040953.KAA17466@mudchute.algor.co.uk>
	<Pine.GSO.3.96.1020904144630.10619F-100000@delta.ds2.pg.gda.pl>
	<20020904093627.A5241@momenco.com>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Return-Path: <dom@mudchute.algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 91
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


Matthew Dharm (mdharm@momenco.com) writes:

> >  As I understand 0xfc00000c is the physical address.  Thus you cannot
> > reach it via KSEG0/1 (although you may use XKPHYS to get there in the
> > 64-bit mode).  Still ioremap() already handles the case mapping the area
> > requested in the KSEG2 space, so it should work just fine. 
> 
> This is the case.  The board itself has up to 1G of SDRAM.  Most of the
> boards we sell have a minimum of 512MB.  So our I/O (PCI, external devices,
> etc.) all have physical addresses in the high-end of the address space.

Well, next time, get your board designers to think before they map...

It's generally better to map some DRAM low (for boot ROMs and other
stupid programs you don't want to make big-address aware), then remap
the whole DRAM to some very high address for Linux.  Much better than
forcing you to use the TLB (or XKPHYS, if you've a 64-bit CPU) to get
at I/O.

> 64-bit mode would be great...

Bear in mind that there *isn't a 64-bit mode*.  Privileged code (which
is everything except Linux applications) can always run 64-bit
instructions; all addresses are 64-bits really, it's just the
sign-extension of the registers which makes you think you've got
32-bit pointers.  Usually a 64-bit CPU can access XKPHYS any time
it can access I/O registers.

-- 
Dominic Sweetman, 
MIPS Technologies (UK) - formerly Algorithmics
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
http://www.algor.co.uk
