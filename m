Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9TMd4u21620
	for linux-mips-outgoing; Mon, 29 Oct 2001 14:39:04 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9TMcv021617
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 14:38:57 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9TMejB05842;
	Mon, 29 Oct 2001 14:40:45 -0800
Message-ID: <3BDDDA7A.329F827D@mvista.com>
Date: Mon, 29 Oct 2001 14:38:50 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Bradley D. LaRonde" <brad@ltc.com>
CC: linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: PATCH: pci_auto bridge support
References: <20011026210746.A20395@dev1.ltc.com> <3BDDACD2.7121F905@mvista.com> <04c801c160b0$1d62f660$3501010a@ltc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Bradley D. LaRonde" wrote:
> 
> I considered that, but since only this small chuck of run-once surrogate
> bios autoconfig code needs to know, I figured better keep it separate.
> 

I would vote to put it inside the hose structure:

. It makes a workaround look like a real fix. :-)

. In other implementations of pci_auto, hose is the private sys data of a pci
dev. Having a bus number inside is very useful (e.g., pci_ops can tell whether
it is type0 of type1 configuration based on the bus number rather than a shaky
NULL parent bus pointer).  In the future, all pci_auto should be combined into
the pci driver.  So that is probably the right direction to go.

I think hose may evolve to be the data structure that represents the topology
of PCI buses.  It should have more uses in the future (e.g., the standard IRQ
routing across PCI-PCI bridges).


Jun

> 
> ----- Original Message -----
> From: "Jun Sun" <jsun@mvista.com>
> To: "Bradley D. LaRonde" <brad@ltc.com>
> Cc: <linux-mips@oss.sgi.com>; <linux-mips-kernel@lists.sourceforge.net>
> Sent: Monday, October 29, 2001 2:24 PM
> Subject: Re: PATCH: pci_auto bridge support
> 
> >
> > Brad,
> >
> > Have you considered embedding "topbus" argument into hose structure?  That
> > sounds like potentially better solution.
> >
> >
> >
> > "Bradley D. LaRonde" wrote:
> > >
> > > 2001-10-26  Bradley D. LaRonde <brad@ltc.com>
> > >
> > > * PCI bridge support.  See change log entry below.
> > >
> > > --- arch/mips/kernel/pci_auto.c 2001/08/18 06:21:53     1.1
> > > +++ arch/mips/kernel/pci_auto.c 2001/10/27 01:01:21
> > > @@ -4,6 +4,7 @@
> > >   * Author: Matt Porter <mporter@mvista.com>
> > >   *
> > >   * Copyright 2000, 2001 MontaVista Software Inc.
> > > + * Copyright 2001 Bradley D. LaRonde <brad@ltc.com>
> > >   *
> > >   * This program is free software; you can redistribute  it and/or
> modify it
> > >   * under  the terms of  the GNU General  Public License as published by
> the
> > > @@ -19,6 +20,15 @@
> > >   * . change most int to u32.
> > >   *
> > >   * Further modified to include it as mips generic code,
> ppopov@mvista.com.
> > > + *
> > > + * 2001-10-26  Bradley D. LaRonde <brad@ltc.com>
> > > + * - Add a top_bus argument to the "early config" functions so that
> > > + *   they can set a fake parent bus pointer to convince the underlying
> > > + *   pci ops to use type 1 configuration for sub busses.
> > > + * - Set bridge base and limit registers correctly.
> > > + * - Align io and memory base properly before and after bridge setup.
> > > + * - Don't fall through to pci_setup_bars for bridge.
> > > + * - Reformat the debug output to look more like lspci's output.
> > >   */
