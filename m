Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB48g3V17421
	for linux-mips-outgoing; Tue, 4 Dec 2001 00:42:03 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB48fxo17417
	for <linux-mips@oss.sgi.com>; Tue, 4 Dec 2001 00:41:59 -0800
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 16BACz-0003Eo-00; Tue, 04 Dec 2001 08:41:41 +0100
Date: Tue, 4 Dec 2001 08:41:40 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: Florian Lohoff <flo@rfc822.org>
cc: Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: 2.4.16 success on Indy (was Re: 2.4.16 success on Decstation
 5000/150)
In-Reply-To: <20011203192543.A10394@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.21.0112040829360.12262-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from QUOTED-PRINTABLE to 8bit by oss.sgi.com id fB48g0o17419
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 3 Dec 2001, Florian Lohoff wrote:

> Ok - the IRQ8 get enabled because i have CONFIG_RTC set and in
> drivers/char/rtc.c around line 730 it requests:
> 
> if(request_irq(RTC_IRQ, rtc_interrupt, SA_INTERRUPT, "rtc", NULL))

ehh, you compiled MC146818 driver for Indy... that's not good idea - IP22
uses Dallas DS1286 RAMified Watcgdog Timekeeper. Enable CONFIG_SGI_DS1286
if you want RTC driver.

> Immediatly afterwards the massive ammount of IRQs. With 100Hz and 160
> Chars across the screen - I would expect 1-2 lines/s on the screen.
> Instead the screen fills up within tens of seconds which seems to me
> like non acked IRQ.

strange... you enabled FIFO full interrupt and it really arrived!(?) I'm
really curious what that means. Unfortunately only few SGI engeneers know
how Indy works and they don't tell it anyone :-(

	laïa
