Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9H5nFE18652
	for linux-mips-outgoing; Tue, 16 Oct 2001 22:49:15 -0700
Received: from mail.sonytel.be (main.sonytel.be [195.0.45.167])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9H5nAD18639
	for <linux-mips@oss.sgi.com>; Tue, 16 Oct 2001 22:49:10 -0700
Received: from mullein.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id HAA18408;
	Wed, 17 Oct 2001 07:48:40 +0200 (MET DST)
Date: Wed, 17 Oct 2001 07:48:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
cc: hli@quicklogic.com, Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: IDE DMA mode in Big endian for mips
In-Reply-To: <20011017.113842.41627007.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.4.21.0110170746440.8715-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 17 Oct 2001, Atsushi Nemoto wrote:
> >>>>> On Tue, 16 Oct 2001 10:28:56 -0400, "Hanks Li" <hli@quicklogic.com> said:
> hli> We are working on the IDE/ATAPI for mips. When I changed to Big
> hli> endian mode, the following information appared, and the program
> hli> hang.
> 
> When I tried PCI-IDE in BigEndian (with 2.4.6 kernel), this patch
> solved my problem.
> 
> --- linux/drivers/ide/ide-dma.c:1.1.1.1	Fri Jul  6 11:24:54 2001
> +++ linux/drivers/ide/ide-dma.c	Fri Aug 17 20:17:30 2001
> @@ -492,7 +492,11 @@
>  			SELECT_READ_WRITE(hwif,drive,func);
>  			if (!(count = ide_build_dmatable(drive, func)))
>  				return 1;	/* try PIO instead of DMA */
> +#if defined(__mips__) && defined(__BIG_ENDIAN) /* XXX mips only? */
> +			outl(cpu_to_le32(hwif->dmatable_dma), dma_base + 4); /* PRD table */
> +#else
>  			outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
> +#endif

Since cpu_to_le32() does nothing on little endian, you can rewrite it like

    #if defined(__mips__) /* XXX mips only? */
			    outl(cpu_to_le32(hwif->dmatable_dma), dma_base + 4); /* PRD table */
    #else
			    outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
    #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
