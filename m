Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Oct 2004 19:01:49 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:61383 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225004AbUJJSBh>;
	Sun, 10 Oct 2004 19:01:37 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i9AI1SMp023376;
	Sun, 10 Oct 2004 20:01:29 +0200 (MEST)
Date: Sun, 10 Oct 2004 20:01:28 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pete Popov <ppopov@embeddedalley.com>
cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: PATCH
In-Reply-To: <1097428659.4627.10.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.61.0410102000530.5826@waterleaf.sonytel.be>
References: <1097428659.4627.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 10 Oct 2004, Pete Popov wrote:
> Ralf, or anyone else, any suggestions on how to get a patch like the one
> below accepted in 2.6? It's needed due to the 36 bit address of the
> pcmcia controller on the Au1x CPUs.

Perhaps you can ask the PPC people? Book E PPC has 36-bit I/O as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
