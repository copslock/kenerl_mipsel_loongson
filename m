Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 09:53:02 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:14992 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225254AbUAVJxB>;
	Thu, 22 Jan 2004 09:53:01 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i0M9qxw2011386;
	Thu, 22 Jan 2004 10:53:00 +0100 (MET)
Date: Thu, 22 Jan 2004 10:52:59 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6] set up conswitchp when CONFIG_VT is set
In-Reply-To: <20040121162032.F29705@mvista.com>
Message-ID: <Pine.GSO.4.58.0401221052100.1408@waterleaf.sonytel.be>
References: <20040121162032.F29705@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 21 Jan 2004, Jun Sun wrote:
> conswitchp needs to be set whenever CONFIG_VT is selected.
> Currently this job is done individually by each board in its setup
> routine, often in a wrong way.
>
> The right thing to do is to set the pointer in the common code
> and remove almost two dozens of duplicated and often wrong settings.
>
> The attached patch is for illustration only.  The removal of board settings
> is not complete.
>
> Comments?  Objections and cheers are equally welcome. :)

| --- linux/arch/mips/kernel/setup.c.orig	Tue Nov 18 10:01:24 2003
| +++ linux/arch/mips/kernel/setup.c	Wed Jan 21 16:00:47 2004
| @@ -471,6 +472,15 @@
|  	set_c0_status(ST0_CU0|ST0_KX|ST0_SX|ST0_FR);
|  #endif
|
| +#ifdef CONFIG_VT
| +#if defined(CONFIG_VGA_CONSOLE)
| +        conswitchp = &vga_con;
| +#elif defined(CONFIG_DUMMY_CONSOLE)
| +        conswitchp = &dummy_con;
| +#endif
| +#endif

Isn't the #ifdef CONFIG_VT superfluous?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
