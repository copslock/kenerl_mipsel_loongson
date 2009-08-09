Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Aug 2009 11:24:41 +0200 (CEST)
Received: from mail-pz0-f179.google.com ([209.85.222.179]:49794 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492336AbZHIJYa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Aug 2009 11:24:30 +0200
Received: by pzk9 with SMTP id 9so2440325pzk.21
        for <linux-mips@linux-mips.org>; Sun, 09 Aug 2009 02:24:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Q3WOxl8MojeZWT3Vdz7XCVO+3c3ZYFb0gkVD0e4JeYM=;
        b=Y50sInO2LmGIo/rurZj4qr0h9UPnrU/qUO6eQ0n6VW8/TAZwjPzvr1K9HQGLrZxTMZ
         4ah7eaaAF8gnOmoY0P9g6wvyzkQeip+xTHMHtBhLq7tkHBHr0tsqXd1sn4HrgSszcgCJ
         vKJyw/t0EfhYcITqBZS8n+WjXl1d8cByizyfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kNddhiIL7sye3WqW5tOE+csDchq7LSEUVn5Rzyh9+7bJubxSdqlOi4Xt0kEt9LJ87r
         MbFxysKXL8N6ctaoFevXTYwmORA5dzGhN7snDg2Le23C7GgDWLUuJWLpH+RtCzyBj9Wi
         c+pDM4YTMFEid0uVlixTutbH5StAdBC/JdUDQ=
MIME-Version: 1.0
Received: by 10.142.187.6 with SMTP id k6mr243280wff.50.1249809861485; Sun, 09 
	Aug 2009 02:24:21 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0908090943560.13271@ask.diku.dk>
References: <Pine.LNX.4.64.0908090943560.13271@ask.diku.dk>
Date:	Sun, 9 Aug 2009 11:24:21 +0200
Message-ID: <10f740e80908090224p13d2119do9e4f4d7730ed001e@mail.gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 3/3] drivers/video: Correct use of 
	request_region/request_mem_region
From:	Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
To:	Julia Lawall <julia@diku.dk>
Cc:	linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert.uytterhoeven@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, Aug 9, 2009 at 09:44, Julia Lawall<julia@diku.dk> wrote:
> From: Julia Lawall <julia@diku.dk>
>
> request_region should be used with release_region, not request_mem_region.
>
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @r1@
> expression start;
> @@
>
> request_region(start,...)
>
> @b1@
> expression r1.start;
> @@
>
> request_mem_region(start,...)
>
> @depends on !b1@
> expression r1.start;
> expression E;
> @@
>
> - release_mem_region
> + release_region
>  (start,E)
> // </smpl>
>
> Signed-off-by: Julia Lawall <julia@diku.dk>
>
> ---
>  drivers/video/gbefb.c  |    4 ++--
>  drivers/video/tdfxfb.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff -u -p a/drivers/video/gbefb.c b/drivers/video/gbefb.c
> --- a/drivers/video/gbefb.c
> +++ b/drivers/video/gbefb.c
> @@ -1246,7 +1246,7 @@ out_tiles_free:
>  out_unmap:
>        iounmap(gbe);
>  out_release_mem_region:
> -       release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
> +       release_region(GBE_BASE, sizeof(struct sgi_gbe));

GBE_BASE seems to be MMIO (it's mapped using ioremap()), so it looks like the
release_mem_region() is actually correct, while the request_region() should be
request_mem_region() instead

>  out_release_framebuffer:
>        framebuffer_release(info);
>
> @@ -1265,7 +1265,7 @@ static int __devexit gbefb_remove(struct
>                iounmap(gbe_mem);
>        dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
>                          (void *)gbe_tiles.cpu, gbe_tiles.dma);
> -       release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
> +       release_region(GBE_BASE, sizeof(struct sgi_gbe));

Ditto.

> diff -u -p a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
> --- a/drivers/video/tdfxfb.c
> +++ b/drivers/video/tdfxfb.c
> @@ -1571,8 +1571,8 @@ out_err_iobase:
>        if (default_par->mtrr_handle >= 0)
>                mtrr_del(default_par->mtrr_handle, info->fix.smem_start,
>                         info->fix.smem_len);
> -       release_mem_region(pci_resource_start(pdev, 2),
> -                          pci_resource_len(pdev, 2));
> +       release_region(pci_resource_start(pdev, 2),
> +                      pci_resource_len(pdev, 2));
>  out_err_screenbase:
>        if (info->screen_base)
>                iounmap(info->screen_base);

This one looks OK.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
