Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Dec 2003 11:37:07 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:5096 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225310AbTLNLhG>;
	Sun, 14 Dec 2003 11:37:06 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBEBb2QG021237;
	Sun, 14 Dec 2003 12:37:02 +0100 (MET)
Date: Sun, 14 Dec 2003 12:37:03 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	nick@snowman.net
Subject: Re: Recently, on a uniprocessor Origin 200 ...
In-Reply-To: <20031213130602.GA10478@linux-mips.org>
Message-ID: <Pine.GSO.4.58.0312141235510.16795@waterleaf.sonytel.be>
References: <20031213130602.GA10478@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sat, 13 Dec 2003, Ralf Baechle wrote:
> CPU 0 clock is 65535MHz.
>
> [ ... am I the champion of overclocking or not :-) ]
>
> Calibrating delay loop... 130.81 BogoMIPS

Ugh, I don't want a CPU that needs 500 cycles for a decrement and a conditional
branch...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
