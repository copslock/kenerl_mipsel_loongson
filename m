Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIMSEd19683
	for linux-mips-outgoing; Tue, 18 Dec 2001 14:28:14 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIMS8o19680;
	Tue, 18 Dec 2001 14:28:08 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fBILS6J12500;
	Tue, 18 Dec 2001 16:28:06 -0500
Date: Tue, 18 Dec 2001 16:28:06 -0500
From: Jim Paris <jim@jtan.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011218162806.A12456@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu> <20011218162506.A24659@dea.linux-mips.net> <20011218135712.B11726@neurosis.mit.edu> <20011218185850.A18856@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011218185850.A18856@dea.linux-mips.net>; from ralf@oss.sgi.com on Tue, Dec 18, 2001 at 06:58:50PM -0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > How so?  See the memory map I just sent in my other mail.  Should I be
> > adding isa_slot_offset to calls to check/request/release_mem_region?
> > Or should I make a isa_{check,request,release}_mem_region that adds
> > this in?  In which case, doesn't that turn /proc/iomem into a general
> > memory map rather than an I/O memory map?
> 
> It's a general memory map.  Basically you have an memory address space
> and an I/O space.  The latter should be treated as an entirely independant
> thing just like on x86 where special instructions (in / out) are necessary
> to access it.  On MIPS the difference is more blurry as this I/O port
> addres space is accessible through normal load / store instructions.

The ports are dealt with by /proc/ioports.  What about /proc/iomem?
The ISA ports and ISA memory are seperate, and the ports work fine and
just as I would expect them to.  But for memory, where should the
PCMCIA driver be reserving space?  Should I 
1) make /proc/iomem contain addresses relative to the start of I/O memory,
   just as /proc/ioports contains addresses relative to the start of
   I/O port space?  This will only work if I stop letting the kernel
   reserve the iomem resource for system memory.
2) make the i82365 driver use absolute addresses in /proc/iomem, by
   adding (isa_slot_offset - KSEG1) to all *_mem_resource calls?
   (breaks i82365 for other arches)
3) Invent a new resource "isamem", reserve the correct absolute
   addresses in "iomem", and the modify the i82365 driver to use 
   "isamem" instead?  (again breaks i82365 for other arches)

> Well, calling ioremap anyway is ok. 

How is calling ioremap anyway ok?  If I

1) call ioremap and then use read[bwl], then isa_slot_offset never
   comes into play and nothing works
2) call ioremap and then use isa_read[bwl], then KSEG1 gets included
   twice and nothing works

> The whole isa_* thing was invented to
> make keeping the large number of antique ISA drivers that don't have any
> maintainers alive.

I'm willing to take the "maintainer" role here and rewrite the driver
properly, but I'm still not understanding what the proper way is.
Given the current way the I/O memory is handled on MIPS, the only way
I can get the i82365 driver working breaks it for every other arch.

-jim
