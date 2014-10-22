Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 10:32:03 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37146 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011292AbaJVIcA5wSgl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 10:32:00 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 2E0B72800EA;
        Wed, 22 Oct 2014 10:30:55 +0200 (CEST)
Received: from dicker-alter.lan (p548C87DD.dip0.t-ipconnect.de [84.140.135.221])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed, 22 Oct 2014 10:30:55 +0200 (CEST)
Message-ID: <54476B7D.3030700@openwrt.org>
Date:   Wed, 22 Oct 2014 10:31:57 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 01/13] MIPS: ath25: add common parts
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com> <1413932631-12866-2-git-send-email-ryazanov.s.a@gmail.com>
In-Reply-To: <1413932631-12866-2-git-send-email-ryazanov.s.a@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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



On 22/10/2014 01:03, Sergey Ryazanov wrote:
> Add common code for Atheros AR5312 and Atheros AR2315 SoCs families.
> 
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> ---
> 
> Changes since v1:
>   - rename MIPS machine ar231x -> ath25
> 
>  arch/mips/Kbuild.platforms                         |  1 +
>  arch/mips/Kconfig                                  | 13 ++++
>  arch/mips/ath25/Makefile                           | 11 ++++
>  arch/mips/ath25/Platform                           |  6 ++
>  arch/mips/ath25/board.c                            | 53 +++++++++++++++
>  arch/mips/ath25/devices.c                          | 11 ++++
>  arch/mips/ath25/devices.h                          | 16 +++++
>  arch/mips/ath25/prom.c                             | 26 ++++++++
>  arch/mips/include/asm/mach-ath25/ath25.h           | 29 +++++++++
>  .../include/asm/mach-ath25/cpu-feature-overrides.h | 76 ++++++++++++++++++++++
>  arch/mips/include/asm/mach-ath25/dma-coherence.h   | 64 ++++++++++++++++++
>  arch/mips/include/asm/mach-ath25/gpio.h            | 16 +++++
>  arch/mips/include/asm/mach-ath25/war.h             | 25 +++++++
>  13 files changed, 347 insertions(+)
>  create mode 100644 arch/mips/ath25/Makefile
>  create mode 100644 arch/mips/ath25/Platform
>  create mode 100644 arch/mips/ath25/board.c
>  create mode 100644 arch/mips/ath25/devices.c
>  create mode 100644 arch/mips/ath25/devices.h
>  create mode 100644 arch/mips/ath25/prom.c
>  create mode 100644 arch/mips/include/asm/mach-ath25/ath25.h
>  create mode 100644 arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
>  create mode 100644 arch/mips/include/asm/mach-ath25/dma-coherence.h
>  create mode 100644 arch/mips/include/asm/mach-ath25/gpio.h
>  create mode 100644 arch/mips/include/asm/mach-ath25/war.h
> 
> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
> index f5e18bf..1780c74 100644
> --- a/arch/mips/Kbuild.platforms
> +++ b/arch/mips/Kbuild.platforms
> @@ -2,6 +2,7 @@
>  
>  platforms += alchemy
>  platforms += ar7
> +platforms += ath25
>  platforms += ath79
>  platforms += bcm47xx
>  platforms += bcm63xx
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 652bd79..54abb9a 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -96,6 +96,19 @@ config AR7
>  	  Support for the Texas Instruments AR7 System-on-a-Chip
>  	  family: TNETD7100, 7200 and 7300.
>  
> +config ATH25
> +	bool "Atheros AR231x/AR531x SoC support"
> +	select CEVT_R4K
> +	select CSRC_R4K
> +	select DMA_NONCOHERENT
> +	select IRQ_CPU
> +	select SYS_HAS_CPU_MIPS32_R1
> +	select SYS_SUPPORTS_BIG_ENDIAN
> +	select SYS_SUPPORTS_32BIT_KERNEL
> +	select ARCH_REQUIRE_GPIOLIB
> +	help
> +	  Support for Atheros AR231x and Atheros AR531x based boards
> +
>  config ATH79
>  	bool "Atheros AR71XX/AR724X/AR913X based boards"
>  	select ARCH_REQUIRE_GPIOLIB
> diff --git a/arch/mips/ath25/Makefile b/arch/mips/ath25/Makefile
> new file mode 100644
> index 0000000..9199fa1
> --- /dev/null
> +++ b/arch/mips/ath25/Makefile
> @@ -0,0 +1,11 @@
> +#
> +# This file is subject to the terms and conditions of the GNU General Public
> +# License.  See the file "COPYING" in the main directory of this archive
> +# for more details.
> +#
> +# Copyright (C) 2006 FON Technology, SL.
> +# Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
> +# Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
> +#
> +
> +obj-y += board.o prom.o devices.o
> diff --git a/arch/mips/ath25/Platform b/arch/mips/ath25/Platform
> new file mode 100644
> index 0000000..ef3f81f
> --- /dev/null
> +++ b/arch/mips/ath25/Platform
> @@ -0,0 +1,6 @@
> +#
> +# Atheros AR531X/AR231X WiSoC
> +#
> +platform-$(CONFIG_ATH25)	+= ath25/
> +cflags-$(CONFIG_ATH25)		+= -I$(srctree)/arch/mips/include/asm/mach-ath25
> +load-$(CONFIG_ATH25)		+= 0xffffffff80041000
> diff --git a/arch/mips/ath25/board.c b/arch/mips/ath25/board.c
> new file mode 100644
> index 0000000..cbc6d7b
> --- /dev/null
> +++ b/arch/mips/ath25/board.c
> @@ -0,0 +1,53 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
> + * Copyright (C) 2006 FON Technology, SL.
> + * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
> + * Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <asm/irq_cpu.h>
> +#include <asm/reboot.h>
> +#include <asm/bootinfo.h>
> +#include <asm/time.h>
> +
> +static void ath25_halt(void)
> +{
> +	local_irq_disable();
> +	while (1)
> +		;
> +}
> +
> +void __init plat_mem_setup(void)
> +{
> +	_machine_halt = ath25_halt;
> +	pm_power_off = ath25_halt;
> +
> +	/* Disable data watchpoints */
> +	write_c0_watchlo0(0);
> +}
> +
> +asmlinkage void plat_irq_dispatch(void)
> +{
> +}
> +
> +void __init plat_time_init(void)
> +{
> +}
> +
> +unsigned int __cpuinit get_c0_compare_int(void)
> +{
> +	return CP0_LEGACY_COMPARE_IRQ;
> +}
> +
> +void __init arch_init_irq(void)
> +{
> +	clear_c0_status(ST0_IM);
> +	mips_cpu_irq_init();
> +}
> +
> diff --git a/arch/mips/ath25/devices.c b/arch/mips/ath25/devices.c
> new file mode 100644
> index 0000000..e30afbc
> --- /dev/null
> +++ b/arch/mips/ath25/devices.c
> @@ -0,0 +1,11 @@
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <asm/bootinfo.h>
> +
> +#include "devices.h"
> +
> +const char *get_system_type(void)
> +{
> +	return "Atheros (unknown)";
> +}
> +
> diff --git a/arch/mips/ath25/devices.h b/arch/mips/ath25/devices.h
> new file mode 100644
> index 0000000..edda636
> --- /dev/null
> +++ b/arch/mips/ath25/devices.h
> @@ -0,0 +1,16 @@
> +#ifndef __ATH25_DEVICES_H
> +#define __ATH25_DEVICES_H
> +
> +#include <linux/cpu.h>
> +
> +static inline bool is_ar2315(void)
> +{
> +	return (current_cpu_data.cputype == CPU_4KEC);
> +}
> +
> +static inline bool is_ar5312(void)
> +{
> +	return !is_ar2315();
> +}
> +
> +#endif
> diff --git a/arch/mips/ath25/prom.c b/arch/mips/ath25/prom.c
> new file mode 100644
> index 0000000..edf82be
> --- /dev/null
> +++ b/arch/mips/ath25/prom.c
> @@ -0,0 +1,26 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright MontaVista Software Inc
> + * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
> + * Copyright (C) 2006 FON Technology, SL.
> + * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
> + * Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
> + */
> +
> +/*
> + * Prom setup file for AR5312/AR231x SoCs
> + */
> +
> +#include <linux/init.h>
> +#include <asm/bootinfo.h>
> +
> +void __init prom_init(void)
> +{
> +}
> +
> +void __init prom_free_prom_memory(void)
> +{
> +}
> diff --git a/arch/mips/include/asm/mach-ath25/ath25.h b/arch/mips/include/asm/mach-ath25/ath25.h
> new file mode 100644
> index 0000000..bd66ce7
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-ath25/ath25.h
> @@ -0,0 +1,29 @@
> +#ifndef __ASM_MACH_ATH25_H
> +#define __ASM_MACH_ATH25_H
> +
> +#include <linux/io.h>
> +
> +#define ATH25_REG_MS(_val, _field)	(((_val) & _field##_M) >> _field##_S)
> +
> +static inline u32 ath25_read_reg(u32 reg)
> +{
> +	return __raw_readl((void __iomem *)KSEG1ADDR(reg));
> +}
> +
> +static inline void ath25_write_reg(u32 reg, u32 val)
> +{
> +	__raw_writel(val, (void __iomem *)KSEG1ADDR(reg));
> +}
> +

using KSEG1ADDR is a bad idea. EVA will obselete these. please use
ioremap() to get a void __iomem pointer and then use this as a
register base. the current code will also lead to a addr cast with
every call of the functions.


> +static inline u32 ath25_mask_reg(u32 reg, u32 mask, u32 val)
> +{
> +	u32 ret = ath25_read_reg(reg);
> +
> +	ret &= ~mask;
> +	ret |= val;
> +	ath25_write_reg(reg, ret);
> +
> +	return ret;
> +}
> +
> +#endif	/* __ASM_MACH_ATH25_H */
> diff --git a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
> new file mode 100644
> index 0000000..c1aebdc
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
> @@ -0,0 +1,76 @@
> +/*
> + *  Atheros AR231x/AR531x SoC specific CPU feature overrides
> + *
> + *  Copyright (C) 2008 Gabor Juhos <juhosg@openwrt.org>
> + *
> + *  This file was derived from: include/asm-mips/cpu-features.h
> + *	Copyright (C) 2003, 2004 Ralf Baechle
> + *	Copyright (C) 2004 Maciej W. Rozycki
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + */
> +#ifndef __ASM_MACH_ATH25_CPU_FEATURE_OVERRIDES_H
> +#define __ASM_MACH_ATH25_CPU_FEATURE_OVERRIDES_H
> +
> +/*
> + * The Atheros AR531x/AR231x SoCs have MIPS 4Kc/4KEc core.
> + */
> +#define cpu_has_tlb			1
> +#define cpu_has_4kex			1
> +#define cpu_has_3k_cache		0
> +#define cpu_has_4k_cache		1
> +#define cpu_has_tx39_cache		0
> +#define cpu_has_sb1_cache		0
> +#define cpu_has_fpu			0
> +#define cpu_has_32fpr			0
> +#define cpu_has_counter			1
> +/* #define cpu_has_watch		? */
> +/* #define cpu_has_divec		? */
> +/* #define cpu_has_vce			? */
> +/* #define cpu_has_cache_cdex_p		? */
> +/* #define cpu_has_cache_cdex_s		? */
> +/* #define cpu_has_prefetch		? */
> +/* #define cpu_has_mcheck		? */
> +#define cpu_has_ejtag			1
> +
> +/*
> + * The MIPS 4Kc V0.9 core in the AR5312/AR2312 have problems with the
> + * ll/sc instructions.
> + */
> +#define cpu_has_llsc			0
> +
> +#define cpu_has_mips16			0
> +#define cpu_has_mdmx			0
> +#define cpu_has_mips3d			0
> +#define cpu_has_smartmips		0
> +
> +/* #define cpu_has_vtag_icache		? */
> +/* #define cpu_has_dc_aliases		? */
> +/* #define cpu_has_ic_fills_f_dc	? */
> +/* #define cpu_has_pindexed_dcache	? */
> +
> +/* #define cpu_icache_snoops_remote_store	? */
> +
> +#define cpu_has_mips32r1		1
> +
> +#define cpu_has_mips64r1		0
> +#define cpu_has_mips64r2		0
> +
> +#define cpu_has_dsp			0
> +#define cpu_has_mipsmt			0
> +
> +/* #define cpu_has_nofpuex		? */
> +#define cpu_has_64bits			0
> +#define cpu_has_64bit_zero_reg		0
> +#define cpu_has_64bit_gp_regs		0
> +#define cpu_has_64bit_addresses		0
> +
> +/* #define cpu_has_inclusive_pcaches	? */
> +
> +/* #define cpu_dcache_line_size()	? */
> +/* #define cpu_icache_line_size()	? */
> +
> +#endif /* __ASM_MACH_ATH25_CPU_FEATURE_OVERRIDES_H */
> diff --git a/arch/mips/include/asm/mach-ath25/dma-coherence.h b/arch/mips/include/asm/mach-ath25/dma-coherence.h
> new file mode 100644
> index 0000000..8b3d0cc
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-ath25/dma-coherence.h
> @@ -0,0 +1,64 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
> + * Copyright (C) 2007  Felix Fietkau <nbd@openwrt.org>
> + *
> + */
> +#ifndef __ASM_MACH_ATH25_DMA_COHERENCE_H
> +#define __ASM_MACH_ATH25_DMA_COHERENCE_H
> +
> +#include <linux/device.h>
> +
> +static inline dma_addr_t
> +plat_map_dma_mem(struct device *dev, void *addr, size_t size)
> +{
> +	return virt_to_phys(addr);
> +}
> +
> +static inline dma_addr_t
> +plat_map_dma_mem_page(struct device *dev, struct page *page)
> +{
> +	return page_to_phys(page);
> +}
> +
> +static inline unsigned long
> +plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
> +{
> +	return dma_addr;
> +}
> +
> +static inline void
> +plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr, size_t size,
> +		   enum dma_data_direction direction)
> +{
> +}
> +
> +static inline int plat_dma_supported(struct device *dev, u64 mask)
> +{
> +	return 1;
> +}
> +
> +static inline void plat_extra_sync_for_device(struct device *dev)
> +{
> +}
> +
> +static inline int plat_dma_mapping_error(struct device *dev,
> +					 dma_addr_t dma_addr)
> +{
> +	return 0;
> +}
> +
> +static inline int plat_device_is_coherent(struct device *dev)
> +{
> +#ifdef CONFIG_DMA_COHERENT
> +	return 1;
> +#endif
> +#ifdef CONFIG_DMA_NONCOHERENT
> +	return 0;
> +#endif
> +}
> +
> +#endif /* __ASM_MACH_ATH25_DMA_COHERENCE_H */
> diff --git a/arch/mips/include/asm/mach-ath25/gpio.h b/arch/mips/include/asm/mach-ath25/gpio.h
> new file mode 100644
> index 0000000..713564b
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-ath25/gpio.h
> @@ -0,0 +1,16 @@
> +#ifndef __ASM_MACH_ATH25_GPIO_H
> +#define __ASM_MACH_ATH25_GPIO_H
> +
> +#include <asm-generic/gpio.h>
> +
> +#define gpio_get_value __gpio_get_value
> +#define gpio_set_value __gpio_set_value
> +#define gpio_cansleep __gpio_cansleep
> +#define gpio_to_irq __gpio_to_irq
> +
> +static inline int irq_to_gpio(unsigned irq)
> +{
> +	return -EINVAL;
> +}
> +
> +#endif	/* __ASM_MACH_ATH25_GPIO_H */
> diff --git a/arch/mips/include/asm/mach-ath25/war.h b/arch/mips/include/asm/mach-ath25/war.h
> new file mode 100644
> index 0000000..e3a5250
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-ath25/war.h
> @@ -0,0 +1,25 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2008 Felix Fietkau <nbd@openwrt.org>
> + */
> +#ifndef __ASM_MACH_ATH25_WAR_H
> +#define __ASM_MACH_ATH25_WAR_H
> +
> +#define R4600_V1_INDEX_ICACHEOP_WAR	0
> +#define R4600_V1_HIT_CACHEOP_WAR	0
> +#define R4600_V2_HIT_CACHEOP_WAR	0
> +#define R5432_CP0_INTERRUPT_WAR		0
> +#define BCM1250_M3_WAR			0
> +#define SIBYTE_1956_WAR			0
> +#define MIPS4K_ICACHE_REFILL_WAR	0
> +#define MIPS_CACHE_SYNC_WAR		0
> +#define TX49XX_ICACHE_INDEX_INV_WAR	0
> +#define RM9000_CDEX_SMP_WAR		0
> +#define ICACHE_REFILLS_WORKAROUND_WAR	0
> +#define R10000_LLSC_WAR			0
> +#define MIPS34K_MISSED_ITLB_WAR		0
> +
> +#endif /* __ASM_MACH_ATH25_WAR_H */
> 
