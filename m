Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2004 10:00:05 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:37510 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225526AbUGHJAA>;
	Thu, 8 Jul 2004 10:00:00 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i688xwXK025081;
	Thu, 8 Jul 2004 10:59:58 +0200 (MEST)
Date: Thu, 8 Jul 2004 10:59:58 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sridhar Adagada <asridhars@gmail.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Optimisation
In-Reply-To: <f013fac60407072338b65f8fd@mail.gmail.com>
Message-ID: <Pine.GSO.4.58.0407081053500.12221@waterleaf.sonytel.be>
References: <f013fac60407072338b65f8fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 8 Jul 2004, Sridhar Adagada wrote:
> As you can see $6 is the length, my confusion is at the lines 12-14,
> 19, 20 why is the length added with 65535 and the comparison with 0

It's not `added with 65535', but `ANDed with 65535'. MIPS32 has 32-bit integer
operations only. If you want to do 16-bit math, all data has to be masked.

Anyway, for performance, it's better to do 32-bit math only.

> short cal_xxx(short *abs, short *coef, short len, short base)
> {
>  short i;
>  short sum = 0;
>
>  for (i = 0; i < length; i++)
>  {
>    sum += ( (unsigned int)abs[i] * (unsigned int)coef[i] );

Why cast to unsigned int while sum is a short? Unless you really want to rely
on sum being a short, you better make it int and do the truncation to short
after the loop.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
