Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Aug 2004 09:24:37 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:30672 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224837AbUHMIYc>;
	Fri, 13 Aug 2004 09:24:32 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i7D8OAn1013782;
	Fri, 13 Aug 2004 10:24:11 +0200 (MEST)
Date: Fri, 13 Aug 2004 10:24:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: bel racu <belracu22@rediffmail.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: lsmod -- used by ?
In-Reply-To: <20040813021233.10801.qmail@webmail27.rediffmail.com>
Message-ID: <Pine.GSO.4.58.0408131023300.28832@waterleaf.sonytel.be>
References: <20040813021233.10801.qmail@webmail27.rediffmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 13 Aug 2004, bel racu wrote:
> trying to get framebuffer up on au1500 Alchemy db1500 board.
> with cyberpro 5000 chipset PCI graphics card.
>
> Able to insert the module cyber2000fb withot problem,
> and the cards gets registerd ... When issued lsmod i get some thing
> strange like this like this
>
>    #lsmod
>     Module            Size    Used by    Tainted: P
>     cyber2000fb       1776    63
>
> what is does 63 under module UsedBy meeen ?

That's the maximum number of virtual consoles configured for the system. Fbcon
increments the use count for each virtual console.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
