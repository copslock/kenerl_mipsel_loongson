Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Feb 2005 09:23:52 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:26249 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224935AbVBPJXh>;
	Wed, 16 Feb 2005 09:23:37 +0000
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j1G9NZGU019364;
	Wed, 16 Feb 2005 10:23:35 +0100 (MET)
Date:	Wed, 16 Feb 2005 10:23:33 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [patch] generic framebuffer support, cleanups and buglets with
 BPP < 32
In-Reply-To: <200502151439.06976.eckhardt@satorlaser.com>
Message-ID: <Pine.LNX.4.62.0502161023050.12747@numbat.sonytel.be>
References: <200502151439.06976.eckhardt@satorlaser.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 15 Feb 2005, Ulrich Eckhardt wrote:
> Changes:
>  * removed trailing whitespace
>  * use helper function for common bitwise operations
>  * fixed several cases where either the wrong mask was used for bitops
>    or the mask was computed falsely, messing up <32 BPP support
>  * added self-tests for bitcpy_rev() algorithm in module-init function
>  * no need to use explicitly sized integers in some cases
>  * added a few comments where things weren't obvious to me

I forwarded your mail to linux-fbdev-devel.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
