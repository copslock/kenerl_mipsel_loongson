Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBKEN9v05360
	for linux-mips-outgoing; Thu, 20 Dec 2001 06:23:09 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBKEN1X05355
	for <linux-mips@oss.sgi.com>; Thu, 20 Dec 2001 06:23:02 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id OAA19378;
	Thu, 20 Dec 2001 14:14:29 +0100 (MET)
Date: Thu, 20 Dec 2001 14:14:29 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jun Sun <jsun@mvista.com>,
   jim@jtan.com, Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: ISA
In-Reply-To: <Pine.GSO.3.96.1011220135315.3556A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0112201411310.502-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 20 Dec 2001, Maciej W. Rozycki wrote:
> On Wed, 19 Dec 2001, Geert Uytterhoeven wrote:
> > OK, so I can check for < 16 MB in ioremap(), and readb() and friends will
> > handle it fine. You're not supposed to call ioremap() for real RAM anyway, so
> > there's no ambiguity.
> > 
> > But what about request_mem_region() and friends? How can I distinguish between
> > ISA memory and the first 16 MB of RAM (or ROM, or whatever my board has there)?
> 
>  Well, as I stated in another mail (but in another thread, I think) you
> may try request_mem_region(virt_to_phys(ioremap(...))), especially as you
> really want to reserve an area in the CPU's physical address space and not
> in the bus's one.

So we must update all existing drivers that use ISA memory space anyway.

IMHO still better to add isa_request_mem_region() while we're at it, so we can
solve this in an arch-specific way. Ia32 can still say

    #define isa_request_mem_region	request_mem_region

> > Or am I not supposed to let those things show up in /proc/iomem?
> 
>  I think the appearance is not the point here.  The point is to prevent a
> driver from accessing an already occupied area. 

Right.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
