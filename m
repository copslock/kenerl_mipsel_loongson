Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBINPNB21376
	for linux-mips-outgoing; Tue, 18 Dec 2001 15:25:23 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBINPJo21371
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 15:25:19 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fBIMOuX12807;
	Tue, 18 Dec 2001 17:24:56 -0500
Date: Tue, 18 Dec 2001 17:24:56 -0500
From: Jim Paris <jim@jtan.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: ISA
Message-ID: <20011218172456.A12735@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20011218164409.A12517@neurosis.mit.edu> <Pine.GSO.3.96.1011218225404.10322C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1011218225404.10322C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Dec 18, 2001 at 11:01:04PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > 1) Isn't the purpose of ioremap to remap I/O memory addresses to
> >    physical ones?  For an ISA architecture like mine, this means
> >    it needs to add isa_slot_offset.
> 
>  Yes it is.  Also see Documentation/IO-mapping.txt and the Alpha port.

So I should modify ioremap to return (addr+isa_slot_offset) when
CONFIG_ISA is defined and the given I/O address is in the 16 MB ISA
range.  That will make things work according to Linus' description of
how they should.

>  It *has to* contain the system RAM.  Otherwise a device driver would be
> allowed to grab a chunk of that memory successfully, possibly destroying
> the system.  Now it gets an error and can gracefully handle it if it tries
> to get the memory for some, possibly legitimate reason. 

Okay, point.  So the i82365 driver is at fault when it calls
check_mem_region(ISA_address).  How should I fix that?  Should it
call check_mem_region(ioremap(ISA_address)) instead?  

Or should /proc/iomap contain physical addresses, which the i82365
driver has no way of knowing without breaking abstractions?  (And if
that's the case, how should I do it?  Create isa_check_mem_region?)

-jim
