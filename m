Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2004 19:50:37 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:54983 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225322AbUKUTuc>;
	Sun, 21 Nov 2004 19:50:32 +0000
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id iALJoUGU015081;
	Sun, 21 Nov 2004 20:50:30 +0100 (MET)
Date: Sun, 21 Nov 2004 20:50:30 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
In-Reply-To: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be>
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 21 Nov 2004, Thiemo Seufer wrote:
> currently we have a large number of TLB refill handlers written in
> hand-optimized assembly which are mostly indentical. The appended
> patch removes them all, and adds a micro-assembler instead which
> synthesizes the proper variant for the CPU at runtime.

Woow.....

I found a few typos (in the comments, didn't verify the code ;-)

    s/Systhesize/Synthesize/
    s/systhesizer/synthesizer/

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
