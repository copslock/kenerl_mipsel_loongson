Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2005 19:43:03 +0100 (BST)
Received: from witte.sonytel.be ([80.88.33.193]:42158 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S3465688AbVJUSmn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2005 19:42:43 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j9LIggva006496;
	Fri, 21 Oct 2005 20:42:42 +0200 (MEST)
Date:	Fri, 21 Oct 2005 20:42:42 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Chris Boot <bootc@bootc.net>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [Slightly-OT] VR4110 core
In-Reply-To: <4358F910.2020204@bootc.net>
Message-ID: <Pine.LNX.4.62.0510212038220.9129@numbat.sonytel.be>
References: <435818D5.7080807@bootc.net> <Pine.LNX.4.62.0510210958520.32398@numbat.sonytel.be>
 <4358EA41.4090001@bootc.net> <Pine.LNX.4.62.0510211536380.32398@numbat.sonytel.be>
 <4358F910.2020204@bootc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 21 Oct 2005, Chris Boot wrote:
> Geert Uytterhoeven wrote:
> > On Fri, 21 Oct 2005, Chris Boot wrote:
> > > Hmm, glancing at the "Product Letter" I have, it does mention "Enhanced
> > > Multi-Media Architecture" so I'm guessing its an EMMA SoC indeed.
> > 
> > Do you have to part number?
> 
> Did I not send one?! It must have been late...
> 
> It's a uPD61032, marked D61032GL on the chip. The exact markings are:
> NEC JAPAN
> D61032GL
> 9949EK019

That's indeed the EMMA.

> There's a couple of 2MB SDRAM chips just next to the CPU (both from different
> manufacturers, and with different pinouts, interestingly enough), 2 Amtel 2MB

IIRC, there's a separate 2 MiB SDRAM for MPEG decoding.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
