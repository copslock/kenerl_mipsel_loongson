Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBKEl4G06796
	for linux-mips-outgoing; Thu, 20 Dec 2001 06:47:04 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBKEkwX06793
	for <linux-mips@oss.sgi.com>; Thu, 20 Dec 2001 06:46:58 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id OAA21957;
	Thu, 20 Dec 2001 14:45:53 +0100 (MET)
Date: Thu, 20 Dec 2001 14:45:53 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jun Sun <jsun@mvista.com>,
   jim@jtan.com, Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: ISA
In-Reply-To: <Pine.GSO.3.96.1011220143454.3556C-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0112201444280.502-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 20 Dec 2001, Maciej W. Rozycki wrote:
> On Thu, 20 Dec 2001, Geert Uytterhoeven wrote:
> > >  Well, as I stated in another mail (but in another thread, I think) you
> > > may try request_mem_region(virt_to_phys(ioremap(...))), especially as you
> > > really want to reserve an area in the CPU's physical address space and not
> > > in the bus's one.
> > 
> > So we must update all existing drivers that use ISA memory space anyway.
> 
>  Not many of them calls request_mem_region()...  Not that it is good. 
> 
> > IMHO still better to add isa_request_mem_region() while we're at it, so we can
> > solve this in an arch-specific way. Ia32 can still say
> > 
> >     #define isa_request_mem_region	request_mem_region
> 
>  And then "<bus>_request_mem_region" for every new bus supported??? 

Yes, you have <bus>_ioremap() anyway, since plain ioremap() is for PCI only.

And then struct busops starts looking like an interesting direction...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
