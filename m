Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAD6ML328242
	for linux-mips-outgoing; Mon, 12 Nov 2001 22:22:21 -0800
Received: from mail.sonytel.be (main.sonytel.be [195.0.45.167])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAD6MH028239
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 22:22:18 -0800
Received: from mullein.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id HAA01510;
	Tue, 13 Nov 2001 07:20:51 +0100 (MET)
Date: Tue, 13 Nov 2001 07:20:51 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: Roman Zippel <zippel@linux-m68k.org>, Jun Sun <jsun@mvista.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>, rz@linux-m68k.org
Subject: Re: [RFC] generic MIPS RTC driver
In-Reply-To: <20011112183158.C16490@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.GSO.4.21.0111130720400.10875-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 12 Nov 2001, Tom Rini wrote:
> On Mon, Nov 12, 2001 at 09:54:55PM +0100, Roman Zippel wrote:
> > Geert Uytterhoeven wrote:
> > > > Geert, what is the abstraction they used?
> > >
> > > At first sight, we only use get_rtc_time() and mach_hwclk().
> >
> > Over the weekend I changed it into set_rtc_time()/get_rtc_time(), which
> > are now defined in <asm/rtc.h>, so mach_hwclk() is gone in the generic
> > part.
>
> Could you please post a copy of this?  I wanna go and try and get the
> rest of the PPC world going on it, if you didn't do that already.

http://linux-m68k-cvs.apia.dhs.org/

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
