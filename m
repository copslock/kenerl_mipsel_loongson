Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJAxhd05753
	for linux-mips-outgoing; Wed, 19 Dec 2001 02:59:43 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJAxbo05750
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 02:59:37 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA13835;
	Wed, 19 Dec 2001 10:52:47 +0100 (MET)
Date: Wed, 19 Dec 2001 10:52:47 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Jun Sun <jsun@mvista.com>, jim@jtan.com,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: ISA
In-Reply-To: <Pine.GSO.3.96.1011219031430.16267D-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0112191046380.28694-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 19 Dec 2001, Maciej W. Rozycki wrote:
> On Tue, 18 Dec 2001, Jun Sun wrote:
> > Overall, I still feel using isa_xxx() macros in the driver seems like a
> > cleaner solution.  That essentially treats ISA memory space as a separate
> 
>  It depends on what you want to do.  For one isa_xxx() functions/macros
> do not permit to control caching.
> 
> > space.  The ioremap/readb/writeb approach tries to lump ISA memory and PCI
> > memory space together but in fact we still have treat them differently (based
> > on whether the address is greater than 16MB, which is a little hackish.)

You must _not_ use readb()/writeb() and friends with ISA memory space!
You must use isa_readb()/isa_writeb() and friends!

>  The problem is a lone address doesn't really tell us what bus is it
> expected to come from.  And practically there are few systems having
> unrelated I/O buses implemented.  I don't know if any of them is supported
> by Linux.  PCI and ISA are historically related, i.e. ISA is usually
> accessed via a PCI-ISA bridge with a hardwired address mapping.  I don't
> know any system doing it differently -- even Alphas do it this way.
> 
>  The *_resource() functions might help as you may refer to particular
> resources with them, but I don't think a generic way for a multi-bus
> system was defined.  Maybe the problem needs to be discussed at
> linux-kernel.  It's generic after all. 

The problem is that ISA memory space is only half-assed considered separate:
you have seperate isa_readb()/isa_writeb() and friends, but not the
corresponding isa_io{re,un}map() and isa_{request,release}_mem_region().

So while isa_readb()/isa_writeb() and friends can add isa_slot_offset (or
how-is-it-called on your random architecture), io{re,un}map() and
{request,release}_mem_region() can't.

For I/O accesses (inb() and friends), there's no problem, since ISA I/O is a
real subset of PCI I/O.

But for memory accesses, ISA memory space is not necessarily at `address 0'.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
