Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 07:04:35 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:4337 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224902AbVITGEN>;
	Tue, 20 Sep 2005 07:04:13 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j8K64Cva024940;
	Tue, 20 Sep 2005 08:04:12 +0200 (MEST)
Date:	Tue, 20 Sep 2005 08:03:56 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Christoph Hellwig <hch@lst.de>
cc:	Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] switch sibyte profiling driver to ->compat_ioctl
In-Reply-To: <20050919150822.GB13478@lst.de>
Message-ID: <Pine.LNX.4.62.0509200802570.2617@numbat.sonytel.be>
References: <20050919150822.GB13478@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 19 Sep 2005, Christoph Hellwig wrote:
> --- linux-2.6.orig/arch/mips/sibyte/sb1250/bcm1250_tbprof.c	2005-09-18 13:46:52.000000000 +0200
> +++ linux-2.6/arch/mips/sibyte/sb1250/bcm1250_tbprof.c	2005-09-19 15:13:53.000000000 +0200
> @@ -364,7 +366,8 @@
>  	.open		= sbprof_tb_open,
>  	.release	= sbprof_tb_release,
>  	.read		= sbprof_tb_read,
> -	.ioctl		= sbprof_tb_ioctl,
> +	.unlocked_ioctl	= sbprof_tb_ioctl,
> +	.comapt_ioctl	= sbprof_tb_ioctl,
         ^^^^^^^^^^^^
>  	.mmap		= NULL,
>  };

DISCLAIMER: I didn't check whether the spelling error is in the struct
definition as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
