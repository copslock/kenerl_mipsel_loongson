Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g02AiHd06504
	for linux-mips-outgoing; Wed, 2 Jan 2002 02:44:17 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g02AiBg06499
	for <linux-mips@oss.sgi.com>; Wed, 2 Jan 2002 02:44:11 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA19298;
	Wed, 2 Jan 2002 10:41:40 +0100 (MET)
Date: Wed, 2 Jan 2002 10:41:39 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: Jun Sun <jsun@mvista.com>, Jim Paris <jim@jtan.com>,
   Alan Cox <alan@lxorguk.ukuu.org.uk>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: ISA
In-Reply-To: <016d01c192fb$518a9dd0$5601010a@prefect>
Message-ID: <Pine.GSO.4.21.0201021040260.1574-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 1 Jan 2002, Bradley D. LaRonde wrote:
> ----- Original Message -----
> From: "Jun Sun" <jsun@mvista.com>
> To: "Jim Paris" <jim@jtan.com>
> Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; "Geert Uytterhoeven"
> <Geert.Uytterhoeven@sonycom.com>; "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>;
> "Linux/MIPS Development" <linux-mips@oss.sgi.com>
> Sent: Tuesday, January 01, 2002 2:22 PM
> Subject: Re: ISA
> 
> 
> > 1. each address space has an id.
> > 2. kernel pre-defines a couple of well-known ones, 0 for CPU physical,
> >    1 for virtual, etc.
> > 3. When drivers discover the devices, they get the address and also
> >    the address space id where the address resides.
> > 4. there are a set of macro's that converts/maps an address or an
> >    address region from one space to another.
> 
> The first thing that jumps out at me is that now every bus access has an
> added switch in it.
> 
> Either that or drivers would get back access function pointers, but that
> eliminates the chance to inline trivial bus accesses.

Not completely. ioremap() and friends can handle the address space ID and
return an appropriate pointer. That pointer can still be handled by readl() and
friends.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
