Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJF8nW26213
	for linux-mips-outgoing; Wed, 19 Dec 2001 07:08:49 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJF8jo26210
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 07:08:45 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id PAA02971;
	Wed, 19 Dec 2001 15:06:32 +0100 (MET)
Date: Wed, 19 Dec 2001 15:06:32 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Jun Sun <jsun@mvista.com>,
   jim@jtan.com, Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: ISA
In-Reply-To: <E16GhG0-0002zb-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0112191456410.28777-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 19 Dec 2001, Alan Cox wrote:
> > You must _not_ use readb()/writeb() and friends with ISA memory space!
> > You must use isa_readb()/isa_writeb() and friends!
> 
> Linus is saying the reverse. Drivers are moving away from isa_
> 
> > But for memory accesses, ISA memory space is not necessarily at `address 0'.
> 
> ioremap uses ookies, its up to yoyu what you hide in the cookie from an ISA
> ioremap

OK, so I can check for < 16 MB in ioremap(), and readb() and friends will
handle it fine. You're not supposed to call ioremap() for real RAM anyway, so
there's no ambiguity.

But what about request_mem_region() and friends? How can I distinguish between
ISA memory and the first 16 MB of RAM (or ROM, or whatever my board has there)?

Or am I not supposed to let those things show up in /proc/iomem?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
