Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 19:50:58 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:35577 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225303AbUBBTu5>;
	Mon, 2 Feb 2004 19:50:57 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i12Jodw2019255;
	Mon, 2 Feb 2004 20:50:39 +0100 (MET)
Date: Mon, 2 Feb 2004 20:50:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Karsten Merker <karsten@excalibur.cologne.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: MIPS Kernel size
In-Reply-To: <20040202194622.GA25095@linux-mips.org>
Message-ID: <Pine.GSO.4.58.0402022049140.19699@waterleaf.sonytel.be>
References: <1075215091.40167af364b77@imp1-a.free.fr> <20040202140925.GB22008@linux-mips.org>
 <20040202184325.GE913@excalibur.cologne.de> <20040202185726.GB23667@linux-mips.org>
 <Pine.GSO.4.58.0402022033180.19699@waterleaf.sonytel.be>
 <20040202194622.GA25095@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 2 Feb 2004, Ralf Baechle wrote:
> On Mon, Feb 02, 2004 at 08:38:18PM +0100, Geert Uytterhoeven wrote:
> > > The Cobalt case is special; it's firmware could almost be the definition
> > > of the term crap ...
> >
> > Can't you use the firmware to load a second stage booter, which can load
> > larger kernels?
>
> That would be possible - but would still leave all the other limitations
> of the original firmware such as not supporting netboots.  Peter Horten
> seem to have worked on something better.

Unles the second stage booter supports netboots. I don't know anything about
the Cobalt firmware, but just using it to load something like uBoot should be
possible, right?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
