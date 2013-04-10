Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 15:57:04 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:56981 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822672Ab3DJN5DgCjoX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 15:57:03 +0200
Received: from mail-vb0-f47.google.com (mail-vb0-f47.google.com [209.85.212.47])
        by mail.nanl.de (Postfix) with ESMTPSA id 24F8A4096C;
        Wed, 10 Apr 2013 13:56:54 +0000 (UTC)
Received: by mail-vb0-f47.google.com with SMTP id x13so376582vbb.34
        for <multiple recipients>; Wed, 10 Apr 2013 06:56:59 -0700 (PDT)
X-Received: by 10.58.96.40 with SMTP id dp8mr1531480veb.41.1365602219922; Wed,
 10 Apr 2013 06:56:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.31.73 with HTTP; Wed, 10 Apr 2013 06:56:38 -0700 (PDT)
In-Reply-To: <1365594447-13068-19-git-send-email-blogic@openwrt.org>
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org> <1365594447-13068-19-git-send-email-blogic@openwrt.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 10 Apr 2013 15:56:38 +0200
Message-ID: <CAOiHx=ncb4MTyaWo+YQT722Mat6U37ExZciGX-T-GVu5c7J-wg@mail.gmail.com>
Subject: Re: [PATCH 18/18] MIPS: ralink: add support for runtime memory detection
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On 10 April 2013 13:47, John Crispin <blogic@openwrt.org> wrote:
> This allows us to add a device_node called "memorydetect" to the DT with
> information about the memory windoe of the SoC. Based on this the memory is
> detected ar runtime.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/Makefile |    2 +-
>  arch/mips/ralink/common.h |    3 ++
>  arch/mips/ralink/memory.c |  119 +++++++++++++++++++++++++++++++++++++++++++++
>  arch/mips/ralink/of.c     |    3 ++
>  4 files changed, 126 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/ralink/memory.c

(snip)

> diff --git a/arch/mips/ralink/memory.c b/arch/mips/ralink/memory.c
> new file mode 100644
> index 0000000..57f3b83
> --- /dev/null
> +++ b/arch/mips/ralink/memory.c
> @@ -0,0 +1,119 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2009 Gabor Juhos <juhosg@openwrt.org>
> + *  Copyright (C) 2013 John Crispin <blogic@openwrt.org>
> + */
> +
> +#include <linux/string.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/bootinfo.h>
> +#include <asm/addrspace.h>
> +
> +#include "common.h"
> +
> +#define MB     (1024 * 1024)

There's <linux/sizes.h>, which has macros like SZ_1M, SZ_2M, SZ_8M,
SZ_16M ... ;-)

> +
> +unsigned long ramips_mem_base;
> +unsigned long ramips_mem_size_min;
> +unsigned long ramips_mem_size_max;
> +
> +#ifdef CONFIG_SOC_RT305X
> +
> +#include <asm/mach-ralink/rt305x.h>
> +
> +static unsigned long rt5350_get_mem_size(void)
> +{
> +       void __iomem *sysc = (void __iomem *) KSEG1ADDR(RT305X_SYSC_BASE);
> +       unsigned long ret;
> +       u32 t;
> +
> +       t = __raw_readl(sysc + SYSC_REG_SYSTEM_CONFIG);
> +       t = (t >> RT5350_SYSCFG0_DRAM_SIZE_SHIFT) &
> +       RT5350_SYSCFG0_DRAM_SIZE_MASK;
> +
> +       switch (t) {
> +       case RT5350_SYSCFG0_DRAM_SIZE_2M:
> +               ret = 2 * 1024 * 1024;
> +               break;
> +       case RT5350_SYSCFG0_DRAM_SIZE_8M:
> +               ret = 8 * 1024 * 1024;
> +               break;
> +       case RT5350_SYSCFG0_DRAM_SIZE_16M:
> +               ret = 16 * 1024 * 1024;
> +               break;
> +       case RT5350_SYSCFG0_DRAM_SIZE_32M:
> +               ret = 32 * 1024 * 1024;
> +               break;
> +       case RT5350_SYSCFG0_DRAM_SIZE_64M:
> +               ret = 64 * 1024 * 1024;
> +               break;
> +       default:
> +               panic("rt5350: invalid DRAM size: %u", t);
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +#endif
> +
> +static void __init detect_mem_size(void)
> +{
> +       unsigned long size;
> +
> +#ifdef CONFIG_SOC_RT305X
> +       if (soc_is_rt5350()) {
> +               size = rt5350_get_mem_size();
> +       } else
> +#endif
> +       {
> +               void *base;
> +
> +               base = (void *) KSEG1ADDR(detect_mem_size);
> +               for (size = ramips_mem_size_min;
> +                               size < ramips_mem_size_max; size <<= 1) {
> +                       if (!memcmp(base, base + size, 1024))
> +                               break;
> +               }
> +       }
> +
> +       pr_info("memory detected: %uMB\n", (unsigned int) size / MB);
> +
> +       add_memory_region(ramips_mem_base, size, BOOT_MEM_RAM);
> +}
> +
> +int __init early_init_dt_detect_memory(unsigned long node, const char *uname,
> +                                    int depth, void *data)
> +{
> +       unsigned long l;
> +       __be32 *mem;
> +
> +       /* We are scanning "memorydetect" nodes only */
> +       if (depth != 1 || strcmp(uname, "memorydetect") != 0)
> +               return 0;
> +
> +       mem = of_get_flat_dt_prop(node, "ralink,memory", &l);
> +       if (mem == NULL)
> +               return 0;
> +
> +       if ((l / sizeof(__be32)) != 3)
> +               panic("invalid memorydetect node\n");
> +
> +       ramips_mem_base = dt_mem_next_cell(dt_root_addr_cells, &mem);
> +       ramips_mem_size_min = dt_mem_next_cell(dt_root_size_cells, &mem);
> +       ramips_mem_size_max = dt_mem_next_cell(dt_root_size_cells, &mem);
> +
> +       pr_info("memory window: 0x%llx, min: %uMB, max: %uMB\n",
> +               (unsigned long long) ramips_mem_base,
> +               (unsigned int) ramips_mem_size_min / MB,
> +               (unsigned int) ramips_mem_size_max / MB);

Is there a reason for those casts instead of just using the right
printk %-thingies?

> +
> +       detect_mem_size();
> +
> +       return 0;
> +}


Jonas
