Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 18:48:04 +0200 (CEST)
Received: from witte.sonytel.be ([80.88.33.193]:35515 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133490AbWEaQr4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2006 18:47:56 +0200
Received: from chinchilla.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k4VGlsCQ016416;
	Wed, 31 May 2006 18:47:54 +0200 (MEST)
Date:	Wed, 31 May 2006 18:47:54 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] fix some compiler warnings (field width, unused variable)
In-Reply-To: <20060601.010003.39154219.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.62.0605311840170.18323@chinchilla.sonytel.be>
References: <20060601.010003.39154219.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 1 Jun 2006, Atsushi Nemoto wrote:
> Fix following warnings:
> linux/arch/mips/kernel/setup.c:432: warning: field width is not type int (arg 2)
> linux/arch/mips/kernel/setup.c:432: warning: field width is not type int (arg 4)
> linux/arch/mips/kernel/syscall.c:279: warning: unused variable `len'
> linux/arch/mips/kernel/syscall.c:280: warning: unused variable `name'
> linux/arch/mips/math-emu/dp_fint.c:32: warning: unused variable `xc'
> linux/arch/mips/math-emu/dp_flong.c:32: warning: unused variable `xc'
> linux/arch/mips/math-emu/sp_fint.c:32: warning: unused variable `xc'
> linux/arch/mips/math-emu/sp_flong.c:32: warning: unused variable `xc'
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index bcf1b10..132b65d 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -426,9 +426,9 @@ static inline void bootmem_init(void)
>  		if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
>  			printk("initrd extends beyond end of memory "
>  			       "(0x%0*Lx > 0x%0*Lx)\ndisabling initrd\n",

`%L' is obsolete for long long, use `%ll' instead.

> -			       sizeof(long) * 2,
> +			       (int)(sizeof(long) * 2),
>  			       (unsigned long long)CPHYSADDR(initrd_end),

As CPHYSADDR() returns a ptrdiff_t, what about using `%t' instead?
Ah, that one doesn't print hex (hmm, C99 doesn't seem to tell).

You can cast to `void *' and use `%p' to get hex, and the field width will
automagically be `2*sizeof(void *)', according to lib/vsprintf.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
