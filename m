Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9LGhtf16379
	for linux-mips-outgoing; Sun, 21 Oct 2001 09:43:55 -0700
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9LGhqD16376
	for <linux-mips@oss.sgi.com>; Sun, 21 Oct 2001 09:43:52 -0700
Received: from alan by the-village.bc.nu with local (Exim 3.22 #1)
	id 15vLnU-0007CG-00; Sun, 21 Oct 2001 17:50:00 +0100
Subject: Re: IDE DMA mode in Big endian for mips
To: nemoto@toshiba-tops.co.jp (Atsushi Nemoto)
Date: Sun, 21 Oct 2001 17:50:00 +0100 (BST)
Cc: hli@quicklogic.com, linux-mips@oss.sgi.com
In-Reply-To: <20011017.113842.41627007.nemoto@toshiba-tops.co.jp> from "Atsushi Nemoto" at Oct 17, 2001 11:38:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vLnU-0007CG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>  				return 1;	/* try PIO instead of DMA */
> +#if defined(__mips__) && defined(__BIG_ENDIAN) /* XXX mips only? */
> +			outl(cpu_to_le32(hwif->dmatable_dma), dma_base + 4); /* PRD table */
> +#else
>  			outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
> +#endif

You should actually just be able to delete the #if stuff. On an LE machine
cpu_to_le32() is a null operation
