Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2006 10:20:08 +0100 (BST)
Received: from witte.sonytel.be ([80.88.33.193]:19130 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S20039106AbWH1JUF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Aug 2006 10:20:05 +0100
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k7S9JxQe003671;
	Mon, 28 Aug 2006 11:20:03 +0200 (MEST)
Date:	Mon, 28 Aug 2006 11:19:58 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Thomas Koeller <thomas@koeller.dyndns.org>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Suppress compiler warnings
In-Reply-To: <200608271800.27441.thomas@koeller.dyndns.org>
Message-ID: <Pine.LNX.4.62.0608281018050.25303@pademelon.sonytel.be>
References: <200608271353.16681.thomas@koeller.dyndns.org>
 <Pine.LNX.4.62.0608271411250.26709@pademelon.sonytel.be>
 <200608271800.27441.thomas@koeller.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 27 Aug 2006, Thomas Koeller wrote:
> On Sunday 27 August 2006 14:12, Geert Uytterhoeven wrote:
> > On Sun, 27 Aug 2006 thomas@koeller.dyndns.org wrote:
> > > The excite platform exports hardware resources for device drivers to use.
> > > Any driver wanting to use these resources will look up them by their
> > > names. Since these resources are declared to have static linkage, but are
> > > not used in the source file defining them, the compiler used to emit an
> > > 'unused' warning, which this patch suppresses.
> >
> > How can a driver look them up, if they are not linked in in some structure?
> 
> It uses the standard platform device/driver mechanism: the platform registers
> a platform device (to which the resources are attached) with the platform bus.
> The driver registers a platform driver with the platform bus. The bus matches
> drivers and devices and calls the probe routine of any matching driver, at
> which point the driver can look up the resources using platform_get_resource_byname().

I know that.

I mean, since they are static, no one uses them yet. So each possible driver
that will want to use them should add some code to this single source file?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
