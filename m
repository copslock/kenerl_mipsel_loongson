Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 14:41:28 +0200 (CEST)
Received: from mail-yh0-f41.google.com ([209.85.213.41]:44979 "EHLO
        mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012036AbaJVMl0UUiez convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 14:41:26 +0200
Received: by mail-yh0-f41.google.com with SMTP id i57so3393823yha.28
        for <multiple recipients>; Wed, 22 Oct 2014 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=N8Io/8rka18+rU1/JuJ6mwurOublkf1YbaUzd4WEC/k=;
        b=KOzmbLwjFsxYyegEnuYanhf2XFg8PLbIigMUZQ+SwKpI+oB+gkJZHJ1PIxTa8/PH0M
         ozWsuKKOV0Webei5wGqCLURFXS0QIEth06s1az+0EQoiGgs3K4cgRlEmGMGYjA3/u/L1
         OU1graqsBzin4RD1rPP2fCzg8Jv6Nhc9iVsWTvNtwMwqeU+lM/kirMCh4mY5sMF86ycL
         gfwRnSBRHoNtJeCSj+hCoki/wKD+dk2tamrdXXsBvVdfLOBsBL/BLadueJeHlvUAPAmf
         qVsoVXyBUfYmgXhdoXJHQSOyfoo4dgKj7ZN7ikjfI+qLoO+bSfibnsR8XLit7vcfs6YV
         bTpg==
X-Received: by 10.236.31.33 with SMTP id l21mr59036999yha.14.1413981680059;
 Wed, 22 Oct 2014 05:41:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.196 with HTTP; Wed, 22 Oct 2014 05:40:58 -0700 (PDT)
In-Reply-To: <5446EDF9.3010107@openwrt.org>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
 <1413932631-12866-2-git-send-email-ryazanov.s.a@gmail.com> <5446EDF9.3010107@openwrt.org>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Wed, 22 Oct 2014 16:40:58 +0400
Message-ID: <CAHNKnsTZth9XTWRLS8et4OE6WaNpg8XK-EY8GLuhik-i+u=fPg@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] MIPS: ath25: add common parts
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-10-22 3:36 GMT+04:00 John Crispin <blogic@openwrt.org>:
> Hi Sergey,
>
> Thanks for the patches, a few comments inline
>
Thank you for detailed review!

> On 22/10/2014 01:03, Sergey Ryazanov wrote:
>> Add common code for Atheros AR5312 and Atheros AR2315 SoCs families.
>>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> ---
>>
>> Changes since v1:
>>   - rename MIPS machine ar231x -> ath25
>>
>>  arch/mips/Kbuild.platforms                         |  1 +
>>  arch/mips/Kconfig                                  | 13 ++++
>>  arch/mips/ath25/Makefile                           | 11 ++++
>>  arch/mips/ath25/Platform                           |  6 ++
>>  arch/mips/ath25/board.c                            | 53 +++++++++++++++
>>  arch/mips/ath25/devices.c                          | 11 ++++
>>  arch/mips/ath25/devices.h                          | 16 +++++
>>  arch/mips/ath25/prom.c                             | 26 ++++++++
>>  arch/mips/include/asm/mach-ath25/ath25.h           | 29 +++++++++
>>  .../include/asm/mach-ath25/cpu-feature-overrides.h | 76 ++++++++++++++++++++++
>>  arch/mips/include/asm/mach-ath25/dma-coherence.h   | 64 ++++++++++++++++++
>>  arch/mips/include/asm/mach-ath25/gpio.h            | 16 +++++
>>  arch/mips/include/asm/mach-ath25/war.h             | 25 +++++++
>>  13 files changed, 347 insertions(+)
>>  create mode 100644 arch/mips/ath25/Makefile
>>  create mode 100644 arch/mips/ath25/Platform
>>  create mode 100644 arch/mips/ath25/board.c
>>  create mode 100644 arch/mips/ath25/devices.c
>>  create mode 100644 arch/mips/ath25/devices.h
>>  create mode 100644 arch/mips/ath25/prom.c
>>  create mode 100644 arch/mips/include/asm/mach-ath25/ath25.h
>>  create mode 100644 arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
>>  create mode 100644 arch/mips/include/asm/mach-ath25/dma-coherence.h
>>  create mode 100644 arch/mips/include/asm/mach-ath25/gpio.h
>>  create mode 100644 arch/mips/include/asm/mach-ath25/war.h
>>
>> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
>> index f5e18bf..1780c74 100644
>> --- a/arch/mips/Kbuild.platforms
>> +++ b/arch/mips/Kbuild.platforms
>> @@ -2,6 +2,7 @@
>>
>>  platforms += alchemy
>>  platforms += ar7
>> +platforms += ath25
>>  platforms += ath79
>>  platforms += bcm47xx
>>  platforms += bcm63xx
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 652bd79..54abb9a 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -96,6 +96,19 @@ config AR7
>>         Support for the Texas Instruments AR7 System-on-a-Chip
>>         family: TNETD7100, 7200 and 7300.
>>
>> +config ATH25
>> +     bool "Atheros AR231x/AR531x SoC support"
>> +     select CEVT_R4K
>> +     select CSRC_R4K
>> +     select DMA_NONCOHERENT
>> +     select IRQ_CPU
>> +     select SYS_HAS_CPU_MIPS32_R1
>> +     select SYS_SUPPORTS_BIG_ENDIAN
>> +     select SYS_SUPPORTS_32BIT_KERNEL
>> +     select ARCH_REQUIRE_GPIOLIB
>
> you probably do not want to select GPIOLIB since the driver is dropped
> from the series.
>
Yep, sure.

> [snip]
>
>
>> diff --git a/arch/mips/ath25/board.c b/arch/mips/ath25/board.c
>> new file mode 100644
>> index 0000000..cbc6d7b
>> --- /dev/null
>> +++ b/arch/mips/ath25/board.c
>> @@ -0,0 +1,53 @@
>> +/*
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + *
>> + * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
>> + * Copyright (C) 2006 FON Technology, SL.
>> + * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
>> + * Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <asm/irq_cpu.h>
>> +#include <asm/reboot.h>
>> +#include <asm/bootinfo.h>
>> +#include <asm/time.h>
>> +
>> +static void ath25_halt(void)
>> +{
>> +     local_irq_disable();
>> +     while (1)
>> +             ;
>
> please use unreachable() macro here from include/linux/compiler.h
>
will do

> [snip]
>
>> diff --git a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
>> new file mode 100644
>> index 0000000..c1aebdc
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
>> @@ -0,0 +1,76 @@
>> +/*
>> + *  Atheros AR231x/AR531x SoC specific CPU feature overrides
>> + *
>> + *  Copyright (C) 2008 Gabor Juhos <juhosg@openwrt.org>
>> + *
>> + *  This file was derived from: include/asm-mips/cpu-features.h
>> + *   Copyright (C) 2003, 2004 Ralf Baechle
>> + *   Copyright (C) 2004 Maciej W. Rozycki
>> + *
>> + *  This program is free software; you can redistribute it and/or modify it
>> + *  under the terms of the GNU General Public License version 2 as published
>> + *  by the Free Software Foundation.
>> + *
>> + */
>> +#ifndef __ASM_MACH_ATH25_CPU_FEATURE_OVERRIDES_H
>> +#define __ASM_MACH_ATH25_CPU_FEATURE_OVERRIDES_H
>> +
>> +/*
>> + * The Atheros AR531x/AR231x SoCs have MIPS 4Kc/4KEc core.
>> + */
>> +#define cpu_has_tlb                  1
>> +#define cpu_has_4kex                 1
>> +#define cpu_has_3k_cache             0
>> +#define cpu_has_4k_cache             1
>> +#define cpu_has_tx39_cache           0
>> +#define cpu_has_sb1_cache            0
>> +#define cpu_has_fpu                  0
>> +#define cpu_has_32fpr                        0
>> +#define cpu_has_counter                      1
>> +/* #define cpu_has_watch             ? */
>> +/* #define cpu_has_divec             ? */
>> +/* #define cpu_has_vce                       ? */
>> +/* #define cpu_has_cache_cdex_p              ? */
>> +/* #define cpu_has_cache_cdex_s              ? */
>> +/* #define cpu_has_prefetch          ? */
>> +/* #define cpu_has_mcheck            ? */
>> +#define cpu_has_ejtag                        1
>> +
>> +/*
>> + * The MIPS 4Kc V0.9 core in the AR5312/AR2312 have problems with the
>> + * ll/sc instructions.
>> + */
>> +#define cpu_has_llsc                 0
>> +
>> +#define cpu_has_mips16                       0
>> +#define cpu_has_mdmx                 0
>> +#define cpu_has_mips3d                       0
>> +#define cpu_has_smartmips            0
>> +
>> +/* #define cpu_has_vtag_icache               ? */
>> +/* #define cpu_has_dc_aliases                ? */
>> +/* #define cpu_has_ic_fills_f_dc     ? */
>> +/* #define cpu_has_pindexed_dcache   ? */
>> +
>> +/* #define cpu_icache_snoops_remote_store    ? */
>
>
> please drop the ones with a "?"
>
Ok

>> +
>> +#define cpu_has_mips32r1             1
>> +
>> +#define cpu_has_mips64r1             0
>> +#define cpu_has_mips64r2             0
>> +
>> +#define cpu_has_dsp                  0
>> +#define cpu_has_mipsmt                       0
>> +
>> +/* #define cpu_has_nofpuex           ? */
>> +#define cpu_has_64bits                       0
>> +#define cpu_has_64bit_zero_reg               0
>> +#define cpu_has_64bit_gp_regs                0
>> +#define cpu_has_64bit_addresses              0
>> +
>> +/* #define cpu_has_inclusive_pcaches ? */
>> +
>> +/* #define cpu_dcache_line_size()    ? */
>> +/* #define cpu_icache_line_size()    ? */
>
>
> same here
>
>> +
>> +#endif /* __ASM_MACH_ATH25_CPU_FEATURE_OVERRIDES_H */
>> diff --git a/arch/mips/include/asm/mach-ath25/dma-coherence.h b/arch/mips/include/asm/mach-ath25/dma-coherence.h
>> new file mode 100644
>> index 0000000..8b3d0cc
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-ath25/dma-coherence.h
>> @@ -0,0 +1,64 @@
>> +/*
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + *
>> + * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
>> + * Copyright (C) 2007  Felix Fietkau <nbd@openwrt.org>
>> + *
>> + */
>> +#ifndef __ASM_MACH_ATH25_DMA_COHERENCE_H
>> +#define __ASM_MACH_ATH25_DMA_COHERENCE_H
>> +
>> +#include <linux/device.h>
>> +
>> +static inline dma_addr_t
>> +plat_map_dma_mem(struct device *dev, void *addr, size_t size)
>> +{
>> +     return virt_to_phys(addr);
>> +}
>> +
>> +static inline dma_addr_t
>> +plat_map_dma_mem_page(struct device *dev, struct page *page)
>> +{
>> +     return page_to_phys(page);
>> +}
>> +
>> +static inline unsigned long
>> +plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
>> +{
>> +     return dma_addr;
>> +}
>> +
>> +static inline void
>> +plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr, size_t size,
>> +                enum dma_data_direction direction)
>> +{
>> +}
>> +
>> +static inline int plat_dma_supported(struct device *dev, u64 mask)
>> +{
>> +     return 1;
>> +}
>> +
>> +static inline void plat_extra_sync_for_device(struct device *dev)
>> +{
>> +}
>> +
>> +static inline int plat_dma_mapping_error(struct device *dev,
>> +                                      dma_addr_t dma_addr)
>> +{
>> +     return 0;
>> +}
>> +
>> +static inline int plat_device_is_coherent(struct device *dev)
>> +{
>> +#ifdef CONFIG_DMA_COHERENT
>> +     return 1;
>> +#endif
>> +#ifdef CONFIG_DMA_NONCOHERENT
>> +     return 0;
>> +#endif
>> +}
>> +
>> +#endif /* __ASM_MACH_ATH25_DMA_COHERENCE_H */
>> diff --git a/arch/mips/include/asm/mach-ath25/gpio.h b/arch/mips/include/asm/mach-ath25/gpio.h
>> new file mode 100644
>> index 0000000..713564b
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-ath25/gpio.h
>> @@ -0,0 +1,16 @@
>> +#ifndef __ASM_MACH_ATH25_GPIO_H
>> +#define __ASM_MACH_ATH25_GPIO_H
>> +
>> +#include <asm-generic/gpio.h>
>> +
>> +#define gpio_get_value __gpio_get_value
>> +#define gpio_set_value __gpio_set_value
>> +#define gpio_cansleep __gpio_cansleep
>> +#define gpio_to_irq __gpio_to_irq
>> +
>> +static inline int irq_to_gpio(unsigned irq)
>> +{
>> +     return -EINVAL;
>> +}
>> +
>> +#endif       /* __ASM_MACH_ATH25_GPIO_H */
>> diff --git a/arch/mips/include/asm/mach-ath25/war.h b/arch/mips/include/asm/mach-ath25/war.h
>> new file mode 100644
>> index 0000000..e3a5250
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-ath25/war.h
>> @@ -0,0 +1,25 @@
>> +/*
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + *
>> + * Copyright (C) 2008 Felix Fietkau <nbd@openwrt.org>
>> + */
>> +#ifndef __ASM_MACH_ATH25_WAR_H
>> +#define __ASM_MACH_ATH25_WAR_H
>> +
>> +#define R4600_V1_INDEX_ICACHEOP_WAR  0
>> +#define R4600_V1_HIT_CACHEOP_WAR     0
>> +#define R4600_V2_HIT_CACHEOP_WAR     0
>> +#define R5432_CP0_INTERRUPT_WAR              0
>> +#define BCM1250_M3_WAR                       0
>> +#define SIBYTE_1956_WAR                      0
>> +#define MIPS4K_ICACHE_REFILL_WAR     0
>> +#define MIPS_CACHE_SYNC_WAR          0
>> +#define TX49XX_ICACHE_INDEX_INV_WAR  0
>> +#define RM9000_CDEX_SMP_WAR          0
>> +#define ICACHE_REFILLS_WORKAROUND_WAR        0
>> +#define R10000_LLSC_WAR                      0
>> +#define MIPS34K_MISSED_ITLB_WAR              0
>> +
>> +#endif /* __ASM_MACH_ATH25_WAR_H */
>>



-- 
BR,
Sergey

С наилучшими пожеланиями
Рязанов Сергей
