Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 19:38:49 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:57841 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225272AbUBBTis>;
	Mon, 2 Feb 2004 19:38:48 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i12JcKw2018366;
	Mon, 2 Feb 2004 20:38:20 +0100 (MET)
Date: Mon, 2 Feb 2004 20:38:18 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Karsten Merker <karsten@excalibur.cologne.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: MIPS Kernel size
In-Reply-To: <20040202185726.GB23667@linux-mips.org>
Message-ID: <Pine.GSO.4.58.0402022033180.19699@waterleaf.sonytel.be>
References: <1075215091.40167af364b77@imp1-a.free.fr> <20040202140925.GB22008@linux-mips.org>
 <20040202184325.GE913@excalibur.cologne.de> <20040202185726.GB23667@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 2 Feb 2004, Ralf Baechle wrote:
> On Mon, Feb 02, 2004 at 07:43:25PM +0100, Karsten Merker wrote:
> > Depends on what you consider "that small". Kernel size is a large
> > issue for the Cobalt series due to the firmware limits (although
> > Peter Hortons attempts at a Cobalt bootloader will hopefully help in
> > this regard). Embedded stuff and PDAs is another field where 2.6
> > currently seems to pose a problem.
>
> I really hate that term "embedded" - it's very hard to define.  Anyway,
> there's an increasing amount of so-called embedded systems with several
> gigabytes of memory and even for much smaller system 2.6 is already
> making 2.4 look pale.

Indeed. Today's embedded can easily be larger than desktop/server from only
a few years ago...

Fortunately, system size is still important for some applications. Witness the
existence of a System Size Working Group in the CE Linux Forum. So yes, some
people still care.

> The Cobalt case is special; it's firmware could almost be the definition
> of the term crap ...

Can't you use the firmware to load a second stage booter, which can load larger
kernels?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
