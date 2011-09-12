Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2011 11:57:35 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:46604 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491055Ab1ILJ52 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Sep 2011 11:57:28 +0200
Received: by wwf27 with SMTP id 27so971934wwf.24
        for <multiple recipients>; Mon, 12 Sep 2011 02:57:21 -0700 (PDT)
Received: by 10.216.229.40 with SMTP id g40mr2208334weq.26.1315821441404;
        Mon, 12 Sep 2011 02:57:21 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.102.2])
        by mx.google.com with ESMTPS id p13sm15701883wbh.13.2011.09.12.02.57.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Sep 2011 02:57:20 -0700 (PDT)
Message-ID: <4E6DD754.7000907@mvista.com>
Date:   Mon, 12 Sep 2011 13:56:36 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
MIME-Version: 1.0
To:     post@pfrst.de
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        attilio.fiandrotti@gmail.com
Subject: Re: [PATCH] Impact video driver for SGI Indigo2
References: <Pine.LNX.4.64.1109111200400.4146@Indigo2.Peter>
In-Reply-To: <Pine.LNX.4.64.1109111200400.4146@Indigo2.Peter>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5715

On 11.09.2011 15:14, peter fuerst wrote:

> Here's an attempt to bloat the linux source a bit more ;-)

> This patch brings, yet missing, parts that make a Linux-driven Indigo2
> Impact (IP28 and most probably IP22-Impact) an usable desktop-machine
> "out of the box".
> The driver provides the framebuffer console and an interface for the
> Xserver (mmap'ing a DMA-pool to the shadow framebuffer and doing the
> necessary cacheflush).
> Meanwhile only a few files are affected and obviously no side-effects
> to other parts of the kernel are to be expected.

> BTW: it would be appreciated, if someone could verify, that this driver
> also works for IP22 Impact.


> Signed-off-by: peter fuerst <post@pfrst.de>

> ---

> 1) Preparation

> drivers/video/Kconfig | 6 ++++++
> drivers/video/Makefile | 1 +
> drivers/video/logo/Kconfig | 2 +-
> arch/mips/sgi-ip22/ip22-setup.c | 37 +++++++++++++++++++++++++++++++++++++
> arch/mips/configs/ip28_defconfig | 1 +
> 5 files changed, 46 insertions(+), 1 deletions(-)


> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 549b960..43dbc9f 100644
> --- a/drivers/video/Kconfig Thu Jan 1 00:00:00 1970
> +++ b/drivers/video/Kconfig Thu Mar 10 23:37:58 2011
> @@ -2383,6 +2383,12 @@ config FB_PUV3_UNIGFX
> Choose this option if you want to use the Unigfx device as a
> framebuffer device. Without the support of PCI & AGP.

    It looks like the patch is spoiled as I'm seeing two spaces at the start 
of line when looking at the message source.

>
> +config FB_IMPACT
> + tristate "SGI Indigo2 Impact graphics support"
> + depends on FB && (SGI_IP22 || SGI_IP28 || SGI_IP30)
> + help
> + SGI Indigo2 Impact (SI/HI/MI) graphics card support.
> +
> source "drivers/video/omap/Kconfig"
> source "drivers/video/omap2/Kconfig"
>
>
>

    There are alos empty lines after each file in the patch -- which shouldn't 
be there.

> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 8b83129..278c8fa 100644
> --- a/drivers/video/Makefile Thu Jan 1 00:00:00 1970
> +++ b/drivers/video/Makefile Thu Mar 10 23:44:40 2011
> @@ -141,6 +141,7 @@ obj-$(CONFIG_FB_MSM) += msm/
> obj-$(CONFIG_FB_NUC900) += nuc900fb.o
> obj-$(CONFIG_FB_JZ4740) += jz4740_fb.o
> obj-$(CONFIG_FB_PUV3_UNIGFX) += fb-puv3.o
> +obj-$(CONFIG_FB_IMPACT) += impact.o
>
> # Platform or fallback drivers go here
> obj-$(CONFIG_FB_UVESA) += uvesafb.o

    The above should be a part of the driver patch, as you can't add Makefile 
targets fow which no source files exist yet.

> diff --git a/arch/mips/sgi-ip22/ip22-setup.c b/arch/mips/sgi-ip22/ip22-setup.c
> index 5e66213..085b612 100644
> --- a/arch/mips/sgi-ip22/ip22-setup.c Thu Jan 1 00:00:00 1970
> +++ b/arch/mips/sgi-ip22/ip22-setup.c Fri May 8 01:05:13 2009
> @@ -96,4 +96,41 @@ void __init plat_mem_setup(void)
> }
> }
> #endif
> +#if defined(CONFIG_FB_IMPACT)
> + {
> + extern void setup_impact_earlycons(void);
> + /*
> + * Get graphics info before it is overwritten...
> + * E.g. @ 9000000020f02f78: ffffffff9fc6d770,900000001f000000
> + */
> +#ifdef CONFIG_ARC64
> + ULONG * (*__vec)(void) = (typeof(__vec))
> + ((ULONG*)PROMBLOCK->pvector)[8];
> + ULONG *gfxinfo = (*__vec)();
> +#else
> + /* supposed to work on both 32/64-bit kernels. */
> + int (*__vec)(void) = (typeof(__vec))
> + (long) ((int*)PROMBLOCK->pvector)[8];
> + int *gfxinfo = (typeof(gfxinfo)) (*__vec)();
> +#endif
> + /* See note on __pa() in impact.c */
> + sgi_gfxaddr = __pa((void*)gfxinfo[1]);
> + if (sgi_gfxaddr < 0x1f000000 || 0x1fa00000 <= sgi_gfxaddr)

    Immediate should generally be the right operand in comparison.

> 2) The driver

> drivers/video/impact.c | 1154 ++++++++++++++++++++++++++++++++++++++++++++++++
> include/video/impact.h | 210 +++++++++
> 2 files changed, 1364 insertions(+), 0 deletions(-)

    You should have posted it in a separate mail.

> diff --git a/drivers/video/impact.c b/drivers/video/impact.c
> new file mode 100644
> index 0000000..5ffc948
> --- /dev/null Wed Dec 8 00:46:04 2004
> +++ b/drivers/video/impact.c Mon Jul 25 00:06:58 2011
> @@ -0,0 +1,1154 @@

    I lack the time to review such a large driver, unfortunately...

WBR, Sergei
