Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB4AC8020190
	for linux-mips-outgoing; Tue, 4 Dec 2001 02:12:08 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB4AC3o20186
	for <linux-mips@oss.sgi.com>; Tue, 4 Dec 2001 02:12:04 -0800
Received: from mullein.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA22294;
	Tue, 4 Dec 2001 10:11:17 +0100 (MET)
Date: Tue, 4 Dec 2001 10:11:18 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Florian Lohoff <flo@rfc822.org>
cc: Ladislav Michl <ladislav.michl@hlubocky.del.cz>,
   Ian Chilton <ian@ichilton.co.uk>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: 2.4.16 success on Indy (was Re: 2.4.16 success on Decstation
 5000/150)
In-Reply-To: <20011204095951.A27343@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.21.0112041009520.14988-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 4 Dec 2001, Florian Lohoff wrote:
> On Tue, Dec 04, 2001 at 08:41:40AM +0100, Ladislav Michl wrote:
> > On Mon, 3 Dec 2001, Florian Lohoff wrote:
> > 
> > > Ok - the IRQ8 get enabled because i have CONFIG_RTC set and in
> > > drivers/char/rtc.c around line 730 it requests:
> > > 
> > > if(request_irq(RTC_IRQ, rtc_interrupt, SA_INTERRUPT, "rtc", NULL))
> > 
> > ehh, you compiled MC146818 driver for Indy... that's not good idea - IP22
> > uses Dallas DS1286 RAMified Watcgdog Timekeeper. Enable CONFIG_SGI_DS1286
> > if you want RTC driver.
> 
> CONFIG_RTC is set by "Enhanced Real Time Clock Support" - It seems
> there is something broken in the config system then ...

Was something changed there?

I read a report from an APUS (PPC Amiga) user who suddenly had a PC-style RTC
in his kernel, causing crashes. Could of course still be a user problem, but
since you got bitten by the same thing...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
