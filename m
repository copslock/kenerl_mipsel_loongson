Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Feb 2013 06:23:10 +0100 (CET)
Received: from mail-we0-f179.google.com ([74.125.82.179]:39320 "EHLO
        mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816831Ab3BUFXIOEZ5h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Feb 2013 06:23:08 +0100
Received: by mail-we0-f179.google.com with SMTP id p43so5361027wea.38
        for <multiple recipients>; Wed, 20 Feb 2013 21:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=feU0tKYn0ilCIPev+kYVBdy3LJ/Nf7wnSohoLvJBObo=;
        b=uAIDCnHbV1WIQz90Cj63Ma5Ii0pIst4vcnbWKioAugdpz3wExLokibwu0Y2QJcq78w
         hr5fjTLI+azFF2RLoitL57fP4iwH/YUeLrUfIrai6QMEsBm6ircPL4YscS/PA1+AB3oG
         nfiEIIIw7uJcxd2HiatnS+qeLbqMpse41EvLrJ0yFvinkrnNcVw1DEARYoQroW/3Rp+V
         0h73REiFLVAT7nwfsif0TkFsnpbK/+4SMLXNhQXfvFJGlp0gTaa47O1lv5uwjOOyZFZU
         yJ3w5VZ4RtGiTVmnVIEG7Wnx4XElg7HZfbnelLZwYcta7VNx8Qv627EB4X7khPVrNFLu
         IMFg==
MIME-Version: 1.0
X-Received: by 10.180.75.110 with SMTP id b14mr39048095wiw.21.1361424182792;
 Wed, 20 Feb 2013 21:23:02 -0800 (PST)
Received: by 10.194.58.84 with HTTP; Wed, 20 Feb 2013 21:23:02 -0800 (PST)
In-Reply-To: <1361390840-31415-1-git-send-email-Steven.Hill@imgtec.com>
References: <1361390840-31415-1-git-send-email-Steven.Hill@imgtec.com>
Date:   Wed, 20 Feb 2013 23:23:02 -0600
Message-ID: <CACoURw5CB6HGqrtKykY2HsiwZ+dsZ4zCk1Z5+R-C7zCHv3d+Fg@mail.gmail.com>
Subject: Re: [PATCH v5] MIPS: Add option to disable software I/O coherency.
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

I tried applying this patch to the linux-mips.org 3.8-rc7 tree,
and it failed to apply on the sead3-setup.c file.  I ignored that,
and applied the rest of the patch.

This patch tested successfully on my RM7035C-based system that has
CONFIG_DMA_NONCOHERENT set.  My system works fine with this
patch applied.  Feel free to add my:

Tested-by: Shane McDonald <mcdonald.shane@gmail.com>

On Wed, Feb 20, 2013 at 2:07 PM, Steven J. Hill <Steven.Hill@imgtec.com> wrote:
> From: "Steven J. Hill" <Steven.Hill@imgtec.com>
>
> Some MIPS controllers have hardware I/O coherency. This patch
> detects those and turns off software coherency. A new kernel
> command line option also allows the user to manually turn
> software coherency on or off.
>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>  arch/mips/include/asm/dma-mapping.h                |    3 +
>  arch/mips/include/asm/mach-generic/dma-coherence.h |    2 +-
>  arch/mips/mm/c-r4k.c                               |   33 ++++++---
>  arch/mips/mm/dma-default.c                         |    6 +-
>  arch/mips/mti-malta/malta-setup.c                  |   71 ++++++++++++++++++++
>  arch/mips/mti-sead3/sead3-setup.c                  |    4 +-
>  6 files changed, 105 insertions(+), 14 deletions(-)
>
> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
> index 006b43e..206243d 100644
> --- a/arch/mips/include/asm/dma-mapping.h
> +++ b/arch/mips/include/asm/dma-mapping.h
> @@ -5,6 +5,9 @@
>  #include <asm/cache.h>
>  #include <asm-generic/dma-coherent.h>
>
> +extern int coherentio;
> +extern int hw_coherentio;
> +
>  #ifndef CONFIG_SGI_IP27        /* Kludge to fix 2.6.39 build for IP27 */
>  #include <dma-coherence.h>
>  #endif
> diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
> index 9c95177..ead4e7b 100644
> --- a/arch/mips/include/asm/mach-generic/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
> @@ -63,7 +63,7 @@ static inline int plat_device_is_coherent(struct device *dev)
>         return 1;
>  #endif
>  #ifdef CONFIG_DMA_NONCOHERENT
> -       return 0;
> +       return coherentio;
>  #endif
>  }
>
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 606e828..a363d6f 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -1379,19 +1379,34 @@ static void __cpuinit coherency_setup(void)
>         }
>  }
>
> -#if defined(CONFIG_DMA_NONCOHERENT)
> -
> -static int __cpuinitdata coherentio;
> +int coherentio = 0;    /* no DMA cache coherency (may be set by user) */
> +int hw_coherentio = 0; /* no HW DMA cache coherency (reflects real HW) */
>
>  static int __init setcoherentio(char *str)
>  {
> -       coherentio = 1;
> +       if (coherentio == 0)
> +               pr_info("Command line enabling coherentio"
> +                               " (this will break...)!!\n");
>
> +       coherentio = 1;
> +       pr_info("Hardware DMA cache coherency (command line)\n");
>         return 0;
>  }
> -
>  early_param("coherentio", setcoherentio);
> -#endif
> +
> +static int __init setnocoherentio(char *str)
> +{
> +       if (coherentio < 0)
> +               pr_info("Command line checking done before"
> +                               " plat_setup_iocoherency!!\n");
> +       if (coherentio == 1)
> +               pr_info("Command line disabling coherentio\n");
> +
> +       coherentio = 0;
> +       pr_info("Software DMA cache coherency (command line)\n");
> +       return 0;
> +}
> +early_param("nocoherentio", setnocoherentio);
>
>  static void __cpuinit r4k_cache_error_setup(void)
>  {
> @@ -1474,9 +1489,11 @@ void __cpuinit r4k_cache_init(void)
>
>         build_clear_page();
>         build_copy_page();
> -#if !defined(CONFIG_MIPS_CMP)
> +
> +       /* We want to run CMP kernels on core(s) with and without coherent caches */
> +       /* Therefore can't use CONFIG_MIPS_CMP to decide to flush cache */
>         local_r4k___flush_cache_all(NULL);
> -#endif
> +
>         coherency_setup();
>         board_cache_error_setup = r4k_cache_error_setup;
>  }
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index 3fab204..aad5f7e 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -115,7 +115,8 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
>
>                 if (!plat_device_is_coherent(dev)) {
>                         dma_cache_wback_inv((unsigned long) ret, size);
> -                       ret = UNCAC_ADDR(ret);
> +                       if (!hw_coherentio)
> +                               ret = UNCAC_ADDR(ret);
>                 }
>         }
>
> @@ -143,7 +144,8 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
>         plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
>
>         if (!plat_device_is_coherent(dev))
> -               addr = CAC_ADDR(addr);
> +               if (!hw_coherentio)
> +                       addr = CAC_ADDR(addr);
>
>         free_pages(addr, get_order(size));
>  }
> diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
> index ed68073..4187102 100644
> --- a/arch/mips/mti-malta/malta-setup.c
> +++ b/arch/mips/mti-malta/malta-setup.c
> @@ -31,6 +31,7 @@
>  #include <asm/mips-boards/maltaint.h>
>  #include <asm/dma.h>
>  #include <asm/traps.h>
> +#include <asm/gcmpregs.h>
>  #ifdef CONFIG_VT
>  #include <linux/console.h>
>  #endif
> @@ -104,6 +105,74 @@ static void __init fd_activate(void)
>  }
>  #endif
>
> +static int __init
> +plat_enable_iocoherency(void)
> +{
> +       int supported = 0;
> +       if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO) {
> +               if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
> +                       BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
> +                       pr_info("Enabled Bonito CPU coherency\n");
> +                       supported = 1;
> +               }
> +               if (strstr(fw_getcmdline(), "iobcuncached")) {
> +                       BONITO_PCICACHECTRL &= ~BONITO_PCICACHECTRL_IOBCCOH_EN;
> +                       BONITO_PCIMEMBASECFG = BONITO_PCIMEMBASECFG &
> +                               ~(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
> +                                 BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
> +                       pr_info("Disabled Bonito IOBC coherency\n");
> +               } else {
> +                       BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_IOBCCOH_EN;
> +                       BONITO_PCIMEMBASECFG |=
> +                               (BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
> +                                BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
> +                       pr_info("Enabled Bonito IOBC coherency\n");
> +               }
> +       } else if (gcmp_niocu() != 0) {
> +               /* Nothing special needs to be done to enable coherency */
> +               pr_info("CMP IOCU detected\n");
> +               if ((*(unsigned int *)0xbf403000 & 0x81) != 0x81) {
> +                       pr_crit("IOCU OPERATION DISABLED BY SWITCH"
> +                               " - DEFAULTING TO SW IO COHERENCY\n");
> +                       return 0;
> +               }
> +               supported = 1;
> +       }
> +       hw_coherentio = supported;
> +       return supported;
> +}
> +
> +static void __init
> +plat_setup_iocoherency(void)
> +{
> +#ifdef CONFIG_DMA_NONCOHERENT
> +       /*
> +        * Kernel has been configured with software coherency
> +        * but we might choose to turn it off
> +        */
> +       if (plat_enable_iocoherency()) {
> +               if (coherentio == 0)
> +                       pr_info("Hardware DMA cache coherency supported"
> +                                       " but disabled from command line\n");
> +               else {
> +                       coherentio = 1;
> +                       printk(KERN_INFO "Hardware DMA cache coherency\n");
> +               }
> +       } else {
> +               if (coherentio == 1)
> +                       pr_info("Hardware DMA cache coherency not supported"
> +                               " but enabled from command line\n");
> +               else {
> +                       coherentio = 0;
> +                       pr_info("Software DMA cache coherency\n");
> +               }
> +       }
> +#else
> +       if (!plat_enable_iocoherency())
> +               panic("Hardware DMA cache coherency not supported");
> +#endif
> +}
> +
>  #ifdef CONFIG_BLK_DEV_IDE
>  static void __init pci_clock_check(void)
>  {
> @@ -205,6 +274,8 @@ void __init plat_mem_setup(void)
>         if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO)
>                 bonito_quirks_setup();
>
> +       plat_setup_iocoherency();
> +
>  #ifdef CONFIG_BLK_DEV_IDE
>         pci_clock_check();
>  #endif
> diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
> index f012fd1..af6a22b 100644
> --- a/arch/mips/mti-sead3/sead3-setup.c
> +++ b/arch/mips/mti-sead3/sead3-setup.c
> @@ -12,9 +12,7 @@
>
>  #include <asm/mips-boards/generic.h>
>  #include <asm/prom.h>
> -
> -int coherentio;                /* 0 => no DMA cache coherency (may be set by user) */
> -int hw_coherentio;     /* 0 => no HW DMA cache coherency (reflects real HW) */
> +#include <asm/dma.h>
>
>  const char *get_system_type(void)
>  {
> --
> 1.7.9.5
>
