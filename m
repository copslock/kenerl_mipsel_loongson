Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJ2IOn26230
	for linux-mips-outgoing; Tue, 18 Dec 2001 18:18:24 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJ2IIo26226
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 18:18:18 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBJ1HeB06737;
	Tue, 18 Dec 2001 17:17:40 -0800
Message-ID: <3C1FEAB9.F590DFFE@mvista.com>
Date: Tue, 18 Dec 2001 17:17:45 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim@jtan.com
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: ISA
References: <20011218164409.A12517@neurosis.mit.edu> <Pine.GSO.3.96.1011218225404.10322C-100000@delta.ds2.pg.gda.pl> <20011218172456.A12735@neurosis.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jim Paris wrote:
> 
> > > 1) Isn't the purpose of ioremap to remap I/O memory addresses to
> > >    physical ones?  For an ISA architecture like mine, this means
> > >    it needs to add isa_slot_offset.
> >
> >  Yes it is.  Also see Documentation/IO-mapping.txt and the Alpha port.
> 
> So I should modify ioremap to return (addr+isa_slot_offset) when
> CONFIG_ISA is defined and the given I/O address is in the 16 MB ISA
> range. 

I would consider it only as a workaround rather than a fix.

You need to make sure all other PCI-based boards have isa_slot_offset set to
0.

ioremap() has been used by many PCI device drivers, and on MIPS it assumes 1:1
mapping between PCI memory space and CPU physical space.  It have been working
so far either because PCI device BARs are shuffled around to match their
physical address (from CPU point of view) or dev structure is modified
propoerly with special fixups.

Now when people using ioremap/readb/writeb method to access ISA memory space,
which lives in the lower range of the "bus memory space", it will collide with
system ram under 1:1 mapping assumption.

Extending isa_slot_offset to something like 'mips_io_mem_offset' may be the
right way to go.  This implies 

1) all PCI-based systems need to set this value to the physical address of the
beginning of PCI memory space window.

2) ioremap() always add this base.

3) when assigning PCI BARs, we need to substract this offset from the
corresponding physical address.  Host-PCI controller needs to be setup
accordingly to do the above substractive address translation.

> 
> >  It *has to* contain the system RAM.  Otherwise a device driver would be
> > allowed to grab a chunk of that memory successfully, possibly destroying
> > the system.  Now it gets an error and can gracefully handle it if it tries
> > to get the memory for some, possibly legitimate reason.
> 
> Okay, point.  So the i82365 driver is at fault when it calls
> check_mem_region(ISA_address).  How should I fix that?  Should it
> call check_mem_region(ioremap(ISA_address)) instead?
>
> Or should /proc/iomap contain physical addresses, which the i82365
> driver has no way of knowing without breaking abstractions?  (And if
> that's the case, how should I do it?  Create isa_check_mem_region?)

Creating isa_check_mem_region() seems to be the right thing but not
necessarily the desirable thing to do, especially people are moving from ISA.

In fact, if isa_read/isa_write do break for other arches (Why would they?),
modifying the driver to use these macros might be best way to solve this
problem.

Jun


> 
> -jim
