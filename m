Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2003 15:18:55 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:40091 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225197AbTEBOSw>;
	Fri, 2 May 2003 15:18:52 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0p/8.8.6) with ESMTP id QAA01361;
	Fri, 2 May 2003 16:18:41 +0200 (MET DST)
Date: Fri, 2 May 2003 16:18:42 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: initrd_header for mips64 kernel
In-Reply-To: <20030502.220517.74756988.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.GSO.4.21.0305021617560.5468-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 2 May 2003, Atsushi Nemoto wrote:
> I found that initrd_header in mips64 cvs kernel is broken.  The
> initrd_header should be consist of two 32bit words while 32bit
> addinitrd is used for 64bit kernel too.
> 
> diff -ur linux-mips-cvs/arch/mips64/kernel/setup.c linux.new/arch/mips64/kernel/setup.c
> --- linux-mips-cvs/arch/mips64/kernel/setup.c	Wed Apr  9 22:06:57 2003
> +++ linux.new/arch/mips64/kernel/setup.c	Fri May  2 21:47:36 2003
> @@ -245,7 +245,7 @@
>  {
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	unsigned long tmp;
> -	unsigned long *initrd_header;
> +	unsigned int *initrd_header;

I think you better use u32 if it must be a 32-bit value.

>  #endif
>  	unsigned long bootmap_size;
>  	unsigned long start_pfn, max_pfn;
> @@ -255,7 +255,7 @@
>  	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8;
>  	if (tmp < (unsigned long)&_end)
>  		tmp += PAGE_SIZE;
> -	initrd_header = (unsigned long *)tmp;
> +	initrd_header = (unsigned int *)tmp;
>  	if (initrd_header[0] == 0x494E5244) {
>  		initrd_start = (unsigned long)&initrd_header[2];
>  		initrd_end = initrd_start + initrd_header[1];

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
