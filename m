Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACDDuS19630
	for linux-mips-outgoing; Mon, 12 Nov 2001 05:13:56 -0800
Received: from mail.sonytel.be (main.sonytel.be [195.0.45.167])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACDDp019627
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 05:13:51 -0800
Received: from mullein.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id OAA29043;
	Mon, 12 Nov 2001 14:11:27 +0100 (MET)
Date: Mon, 12 Nov 2001 14:11:26 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Jun Sun <jsun@mvista.com>, Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
In-Reply-To: <Pine.GSO.3.96.1011112135012.24771I-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0111121410230.11251-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 12 Nov 2001, Maciej W. Rozycki wrote:
> On Sun, 11 Nov 2001, Geert Uytterhoeven wrote:
> > > In other words, with such a driver, once you implemented rtc_get_time()
> > > and rtc_set_time(), which is required by the kernel anyway, you will
> > > automatically get a free /dev/rtc/ driver.
> > >
> > > This is the idea behind the generic MIPS rtc driver.  See the patch below.
> >
> > Oh no, don't tell me we now have (at least) _three_ of these floating around
> > :-)
> >
> >   - On m68k, we have drivers/char/genrtc.c (not yet merged, check out CVS, see
> >     http://linux-m68k-cvs.apia.dhs.org/).
> >   - On PPC, we have drivers/macintosh/rtc.c.
> >   - On MIPS, we now have your drivers/char/mips_rtc.c.
>
>  Agreed, what's wrong with drivers/char/rtc.c?  It even works for the

It's for MC146818 RTCs only.

> DECstation which maps its RTC in an unusual (but nice) way -- it's just a
> matter of initializing rtc_ops appropriately.  See arch/mips/dec/rtc-dec.c
> for an example.
>
>  Unless you use a non-MC146818 RTC, which you need to write a separate
> driver for anyway.

Yep, so that's why both m68k and PPC have common routines to read/write the
RTC, with a /dev/rtc-compatible abstraction on top of it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
