Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9U0JxO28093
	for linux-mips-outgoing; Mon, 29 Oct 2001 16:19:59 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9U0Jr028089
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 16:19:53 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9U0LfB12216;
	Mon, 29 Oct 2001 16:21:41 -0800
Message-ID: <3BDDF222.56105220@mvista.com>
Date: Mon, 29 Oct 2001 16:19:46 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Bradley D. LaRonde" <brad@ltc.com>
CC: linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: [Linux-mips-kernel]Re: PATCH: pci_auto bridge support
References: <20011026210746.A20395@dev1.ltc.com> <3BDDACD2.7121F905@mvista.com> <04c801c160b0$1d62f660$3501010a@ltc.com> <3BDDDA7A.329F827D@mvista.com> <066201c160d5$eb51ed40$3501010a@ltc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Bradley D. LaRonde" wrote:
> 
> ----- Original Message -----
> From: "Jun Sun" <jsun@mvista.com>
> To: "Bradley D. LaRonde" <brad@ltc.com>
> Cc: <linux-mips@oss.sgi.com>; <linux-mips-kernel@lists.sourceforge.net>
> Sent: Monday, October 29, 2001 5:38 PM
> Subject: [Linux-mips-kernel]Re: PATCH: pci_auto bridge support
> 
> > "Bradley D. LaRonde" wrote:
> > >
> > > I considered that, but since only this small chuck of run-once surrogate
> > > bios autoconfig code needs to know, I figured better keep it separate.
> > >
> >
> > I would vote to put it inside the hose structure:
> >
> > . It makes a workaround look like a real fix. :-)
> >
> > . In other implementations of pci_auto, hose is the private sys data of a
> pci
> > dev. Having a bus number inside is very useful (e.g., pci_ops can tell
> whether
> > it is type0 of type1 configuration based on the bus number rather than a
> shaky
> > NULL parent bus pointer).  In the future, all pci_auto should be combined
> into
> > the pci driver.  So that is probably the right direction to go.
> >
> > I think hose may evolve to be the data structure that represents the
> topology
> > of PCI buses.  It should have more uses in the future (e.g., the standard
> IRQ
> > routing across PCI-PCI bridges).
> 
> Isn't the bus topology already adequately represented in the pci_dev and
> pci_channel structures?
> 

Not really.  For example, we don't know which bus is the sub-bus of which,
directly, and how their address space translate into each other.  Those data
structures are needed when we start to support dynamically mapped and/or
arbitrarily mapped PCI memory spaces.

> I look at the pci autoconfig stuff as a bios replacement.  The fact that we
> can use some of the same structures and functions to help us implement it is
> a bonus, but not a mandate to mess with the existing model.
>

That is a right point.  I might be too far ahead of myself. :-)
 
> Isn't Linux already handling PCI-PCI bridges and multiple PCI channles fine
> already, or has our autoconfig code exposed some existing non-arch-specific
> weakness?
>

I think on PCs, P2P still largely depends on BIOS.  (Correct me if I am
wrong).

There are some post-scan_bus() mechanism to setup P2P bridges.  I have not
looked into it closely. 

Jun
