Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIMiEJ20152
	for linux-mips-outgoing; Tue, 18 Dec 2001 14:44:14 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIMiBo20147
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 14:44:11 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fBILi9812560
	for linux-mips@oss.sgi.com; Tue, 18 Dec 2001 16:44:09 -0500
Date: Tue, 18 Dec 2001 16:44:09 -0500
From: Jim Paris <jim@jtan.com>
To: linux-mips@oss.sgi.com
Subject: Re: ISA
Message-ID: <20011218164409.A12517@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20011218150423.A12143@neurosis.mit.edu> <035001c18802$6af8d8d0$5601010a@prefect>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <035001c18802$6af8d8d0$5601010a@prefect>; from brad@ltc.com on Tue, Dec 18, 2001 at 03:27:29PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > Okay, so I'll change the i82365 driver to use isa_{read,write}[bwl]
> > instead of ioremap & {read,write}[bwl], when CONFIG_ISA is defined.
> > That shouldn't break other architectures.
> 
> Admittedly I haven't studied this, but ugh... can't we let isa_* die?

I am all for letting it die, but I'm still not getting a clear answer
on what the alternative is.  The only way to avoid isa_* as I see it
is to fix two problems in the MIPS kernel:

1) Isn't the purpose of ioremap to remap I/O memory addresses to
   physical ones?  For an ISA architecture like mine, this means
   it needs to add isa_slot_offset.
2) /proc/iomem should not contain system RAM.  The RAM is not 
   in I/O memory space on my system, so why does it show up in the
   iomem resource?  On x86, sure, I/O and RAM memory space are the
   same, but they're not here.

Please explain to me again why the current implementation of these two
behaviors is correct.  If both of these problems are fixed, the i82365
driver will work _as is_, as will any other ISA driver that calls 
ioremap() before using {read,write}[bwl].

-jim

 
