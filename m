Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 14:59:48 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:16035 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225209AbTBGO7r>;
	Fri, 7 Feb 2003 14:59:47 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id PAA23762;
	Fri, 7 Feb 2003 15:59:01 +0100 (MET)
Date: Fri, 7 Feb 2003 15:59:05 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alexandr Andreev <andreev@niisi.msk.ru>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Endianity problems in XFree86-4.2 XAA on MIPSEB
In-Reply-To: <3E43ECC6.8090109@niisi.msk.ru>
Message-ID: <Pine.GSO.4.21.0302071558020.13532-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 7 Feb 2003, Alexandr Andreev wrote:
> We have a MipsEB machine and a video card which has a 2D BitBLT engine.
> It looks like we found a problem in XAA when we tried to use our hardware
> 8x8 Mono Pattern Fills. The problem appears when an application uses 
> pixmaps.
> Stipple and tile with the same pixmap are drawing in the different ways
> (bytes in video memory are swapped). We looked through the XAA source tree
> and found a dubious code in xaaPCache.c.

> Did anybody see something similar on Mips EB with XFree + XAA?

Have you asked this on xfree86-devel? Some PPC people may be able to help you.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
