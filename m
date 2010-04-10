Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Apr 2010 12:22:16 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55699 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492466Ab0DJKWJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Apr 2010 12:22:09 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3AALrPE018741;
        Sat, 10 Apr 2010 11:21:53 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3AALmoQ018723;
        Sat, 10 Apr 2010 11:21:48 +0100
Date:   Sat, 10 Apr 2010 11:21:48 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips/txx9: Add missing MODULE_ALIAS definitions for txx9
 platform devices
Message-ID: <20100410102148.GA23809@linux-mips.org>
References: <s2y10f740e81004081152u53d1520fp812bd2defe886220@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s2y10f740e81004081152u53d1520fp812bd2defe886220@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 08, 2010 at 08:52:00PM +0200, Geert Uytterhoeven wrote:

> Hi Nemoto-san, Ralf-san,
> 
> I need the patch below to enable autoloading of the TXx9 sound driver
> on my RBTX4927.
> It works very nice as a low-power MPD player.
> 
> >From 0902bacfe10db79472c7ecd35ac28f1c02f72101 Mon Sep 17 00:00:00 2001
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Date: Thu, 8 Apr 2010 20:46:28 +0200
> Subject: [PATCH] mips/txx9: Add missing MODULE_ALIAS definitions for
> txx9 platform devices
> 
> This enables autoloading of the TXx9 sound driver on my RBTX4927.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/dma/txx9dmac.c            |    2 ++
>  sound/soc/txx9/txx9aclc-ac97.c    |    1 +
>  sound/soc/txx9/txx9aclc-generic.c |    1 +
>  3 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
> index 3ebc610..75fcf1a 100644
> --- a/drivers/dma/txx9dmac.c
> +++ b/drivers/dma/txx9dmac.c
> @@ -1359,3 +1359,5 @@ module_exit(txx9dmac_exit);
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("TXx9 DMA Controller driver");
>  MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
> +MODULE_ALIAS("platform:txx9dmac");
> +MODULE_ALIAS("platform:txx9dmac-chan");
> diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
> index 612e18b..0ec20b6 100644
> --- a/sound/soc/txx9/txx9aclc-ac97.c
> +++ b/sound/soc/txx9/txx9aclc-ac97.c
> @@ -254,3 +254,4 @@ module_exit(txx9aclc_ac97_exit);
>  MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
>  MODULE_DESCRIPTION("TXx9 ACLC AC97 driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:txx9aclc-ac97");
> diff --git a/sound/soc/txx9/txx9aclc-generic.c
> b/sound/soc/txx9/txx9aclc-generic.c
> index 3175de9..95b17f7 100644
> --- a/sound/soc/txx9/txx9aclc-generic.c
> +++ b/sound/soc/txx9/txx9aclc-generic.c
> @@ -96,3 +96,4 @@ module_exit(txx9aclc_generic_exit);
>  MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
>  MODULE_DESCRIPTION("Generic TXx9 ACLC ALSA SoC audio driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:txx9aclc-generic");

Will apply.

A while ago I noticed that all of the MIPS platform device drivers
I looked at did not have MODULE_ALIAS().

  Ralf
