Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Feb 2005 12:37:35 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:39120 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225204AbVB1MhT>;
	Mon, 28 Feb 2005 12:37:19 +0000
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j1SCTeGU000746;
	Mon, 28 Feb 2005 13:29:40 +0100 (MET)
Date:	Mon, 28 Feb 2005 13:29:35 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Jeroen Vreeken <pe1rxq@amsat.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: sparse and mips
In-Reply-To: <20050228121120.GA11719@linux-mips.org>
Message-ID: <Pine.LNX.4.62.0502281325390.5171@numbat.sonytel.be>
References: <422256A3.2030407@amsat.org> <20050228121120.GA11719@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 28 Feb 2005, Ralf Baechle wrote:
> On Mon, Feb 28, 2005 at 12:24:19AM +0100, Jeroen Vreeken wrote:
> > I tried compiling my switch driver with sparse to see if I did some 
> > stupid casts and got a lot of warnings.... (attached below)
> > Are others using sparse with mips kernels and getting the same?
> > Or has nobody taken the time to fix it up?
> > (The byteorder stuff should creap up everywhere or not?)
> 
> Not to my knowledge.  I always meant to as a preventive maintenance meassure
> but somehow there was always something more important to do ...
> 
> > include/asm/byteorder.h:27:4: warning: "MIPS, but neither __MIPSEB__, 
> > nor __MIPSEL__???"
> > include/linux/kernel.h:200:2: warning: "Please fix asm/byteorder.h"
> 
> A result of sparse not knowing about MIPS yet.
> 
> > include/linux/aio_abi.h:59:2: warning: edit for your odd byteorder.
> 
> Same.

You're using 2.6.10?

When I played with sparse on m68k (cross-compile environment), I had to make
some modifications to arch/m68k/Makefile, to pass a few additional flags to
sparse in case of cross-compilation. Later these changes were moved to the main
Makefile, since they were valid for all architectures if cross-compilation was
involved.

So I suggest to take a look at CHECKFLAGS in the main Makefile of the latest
version (2.6.11-rc5) first, and see whether it works there.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
