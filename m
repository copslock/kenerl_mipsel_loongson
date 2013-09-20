Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2013 09:34:00 +0200 (CEST)
Received: from mail-pb0-f47.google.com ([209.85.160.47]:33716 "EHLO
        mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818997Ab3ITHd4cZ7ja (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Sep 2013 09:33:56 +0200
Received: by mail-pb0-f47.google.com with SMTP id rr4so77689pbb.6
        for <multiple recipients>; Fri, 20 Sep 2013 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zGRYSh5b/5cQtgpNdGMdKDva3ciqwN64QlOM67UHZwg=;
        b=GHL6e2Jdyr3GrlFJx6XLUcqGKGLMeaeSy6zrU8re6BpPf2SRDD2j5nSNJqfHJ7KtDp
         ZeVJ3p3dFAoqJ/8+tML0XFFc/cLyF/OFnPdisemT98uqrpe9yetdeIKJVAj83g/yJEnY
         b2OVxCuXB0SoJOr2ibHIG63RVAIE8HBzfMDS5lFmNdLgRMBwiVpmASYLU3AiMgwuAMvX
         8uggB8zUJ/UATPswkDSx/rwYxmPsYRmhZdenqG5RsPcUVszNmNFXwSyCHESSkVSpBwB8
         3Li+lAe+yoeFCuoTAQK6GNAP7Mqgk3+a6WNSGNia1eEvcyS50Z19lLjagiwANf97kDir
         uGMg==
MIME-Version: 1.0
X-Received: by 10.68.134.202 with SMTP id pm10mr6504327pbb.2.1379662429455;
 Fri, 20 Sep 2013 00:33:49 -0700 (PDT)
Received: by 10.70.18.229 with HTTP; Fri, 20 Sep 2013 00:33:49 -0700 (PDT)
In-Reply-To: <6f500d88eb23fd9a4cfc5583f5ca17bc5f58fe24.1379641901.git.joe@perches.com>
References: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com>
        <6f500d88eb23fd9a4cfc5583f5ca17bc5f58fe24.1379641901.git.joe@perches.com>
Date:   Fri, 20 Sep 2013 09:33:49 +0200
X-Google-Sender-Auth: H1MG3HlV39247A8weZMGap-ILcA
Message-ID: <CAMuHMdW6R5qTJ0uvsUUaYBZAqFcNshPsXeMbz5hwqq5UOkJr-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] framebuffer: Remove pmag-aa-fb
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Joe Perches <joe@perches.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Adding Maciej and linux-mips

On Fri, Sep 20, 2013 at 3:53 AM, Joe Perches <joe@perches.com> wrote:
> This driver apparently hasn't compiled since 2.5 days as
> it uses a #define that isn't around anymore.
>
> Remove it.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/video/Kconfig      |  10 -
>  drivers/video/Makefile     |   1 -
>  drivers/video/pmag-aa-fb.c | 510 ---------------------------------------------
>  3 files changed, 521 deletions(-)
>  delete mode 100644 drivers/video/pmag-aa-fb.c
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 14317b7..e92798e 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1821,16 +1821,6 @@ config FB_HIT
>           This is the frame buffer device driver for the Hitachi HD64461 LCD
>           frame buffer card.
>
> -config FB_PMAG_AA
> -       bool "PMAG-AA TURBOchannel framebuffer support"
> -       depends on (FB = y) && TC
> -       select FB_CFB_FILLRECT
> -       select FB_CFB_COPYAREA
> -       select FB_CFB_IMAGEBLIT
> -       help
> -         Support for the PMAG-AA TURBOchannel framebuffer card (1280x1024x1)
> -         used mainly in the MIPS-based DECstation series.
> -
>  config FB_PMAG_BA
>         tristate "PMAG-BA TURBOchannel framebuffer support"
>         depends on FB && TC
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index e8bae8d..5c8b340 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -114,7 +114,6 @@ obj-$(CONFIG_FB_AU1100)               += au1100fb.o
>  obj-$(CONFIG_FB_AU1200)                  += au1200fb.o
>  obj-$(CONFIG_FB_VT8500)                  += vt8500lcdfb.o
>  obj-$(CONFIG_FB_WM8505)                  += wm8505fb.o
> -obj-$(CONFIG_FB_PMAG_AA)         += pmag-aa-fb.o
>  obj-$(CONFIG_FB_PMAG_BA)         += pmag-ba-fb.o
>  obj-$(CONFIG_FB_PMAGB_B)         += pmagb-b-fb.o
>  obj-$(CONFIG_FB_MAXINE)                  += maxinefb.o
> diff --git a/drivers/video/pmag-aa-fb.c b/drivers/video/pmag-aa-fb.c
> deleted file mode 100644

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
