Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 12:33:01 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:21894 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224908AbUAVMdB>;
	Thu, 22 Jan 2004 12:33:01 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i0MCWww2025974;
	Thu, 22 Jan 2004 13:32:58 +0100 (MET)
Date: Thu, 22 Jan 2004 13:32:58 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Jun Sun <jsun@mvista.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6] set up conswitchp when CONFIG_VT is set
In-Reply-To: <20040122122832.GA4482@linux-mips.org>
Message-ID: <Pine.GSO.4.58.0401221331160.1408@waterleaf.sonytel.be>
References: <20040121162032.F29705@mvista.com> <Pine.GSO.4.58.0401221052100.1408@waterleaf.sonytel.be>
 <20040122122832.GA4482@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 22 Jan 2004, Ralf Baechle wrote:
> On Thu, Jan 22, 2004 at 10:52:59AM +0100, Geert Uytterhoeven wrote:
> > | +#ifdef CONFIG_VT
> > | +#if defined(CONFIG_VGA_CONSOLE)
> > | +        conswitchp = &vga_con;
> > | +#elif defined(CONFIG_DUMMY_CONSOLE)
> > | +        conswitchp = &dummy_con;
> > | +#endif
> > | +#endif
> >
> > Isn't the #ifdef CONFIG_VT superfluous?
>
> No; if CONFIG_VT is undefined conswitchp is undefined also; DUMMY_CONSOLE
> however is still selectable if CONFIG_VT is off so there could be
> unsatisfied references to consitchp.

DUMMY_CONSOLE can be set in drivers/video/console/Kconfig only.
drivers/video/console/Kconfig is included by drivers/video/Kconfig only, and
its inclusion depends on VT.
Hence the #ifdef CONFIG_VT is superfluous, unless the above isn't true for the
MIPS tree (I checked plain 2.6.1).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
