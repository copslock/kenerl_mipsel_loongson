Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Oct 2002 16:13:04 +0200 (CEST)
Received: from mail2.sonytel.be ([195.0.45.172]:13023 "EHLO mail.sonytel.be")
	by linux-mips.org with ESMTP id <S1123926AbSJWONE>;
	Wed, 23 Oct 2002 16:13:04 +0200
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA15889;
	Wed, 23 Oct 2002 16:12:38 +0200 (MET DST)
Date: Wed, 23 Oct 2002 16:12:39 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Schulze <joey@infodrom.org>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] Correct monochrome selection
In-Reply-To: <20021019170534.GS14430@finlandia.infodrom.north.de>
Message-ID: <Pine.GSO.4.21.0210231612060.2882-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sat, 19 Oct 2002, Martin Schulze wrote:
> please apply the patch below which will add proper handling for
> monochrome graphic cards.
> 
> Both changes are required since there are graphic cards out in the
> voi^Wwild that are monochrome but have bits_per_pixel set to something
> else than 1, e.g. PMAG-AA which uses 8 bits per pixel but ignores 7 of
> it.
> 
> Since currently no such card is supported, this change wasn't
> required.  However, we developed support for the PMAG-AA card and we
> would like to add support for it to the Linux kernel, of course.

HP300 TopCat uses a similar scheme, and is supported by Linux/m68k.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
