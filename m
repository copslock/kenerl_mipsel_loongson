Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2011 12:05:24 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:33892 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492587Ab1AMLFU convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Jan 2011 12:05:20 +0100
Received: by gxk27 with SMTP id 27so644352gxk.36
        for <multiple recipients>; Thu, 13 Jan 2011 03:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dOUL8xWrmSWPqRjDiSrJZ2vummhKiVvQ/F1Mvno7O3o=;
        b=sYmU48sG+FDR1+4KL/ZCzKN6GUgyjYMHCZRitwzHbY3HOcP7Y4n9VIpp3TJ2la7Jl8
         ZpVsTLrSxpw7c624va5v3iCsrHU3S0qC1dlAtBMDXYEv48oK5lVbiUFMHh6V+1y5FU8r
         p8uBH4zgWCmoNM2qvgWjhEZGoO5aTNLVVwV3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NYu8qj+xx5BO0Gjq5xQGRxVSo/m3ONeVNL//UCf7hIhSi5jq/W1bICQtC24j4F7GTv
         wcBZGA4tmA8vHR9aQdXV4ptsXIgz2g3Y17I1Rc+Oeqb5wWWirXSPhXL47K1ZRax6VeOK
         H3NTlSrS5z3ZE7fDZg6Pbn32I3PH4+Oh/gxFo=
MIME-Version: 1.0
Received: by 10.151.50.18 with SMTP id c18mr3490117ybk.0.1294916713495; Thu,
 13 Jan 2011 03:05:13 -0800 (PST)
Received: by 10.150.186.12 with HTTP; Thu, 13 Jan 2011 03:05:13 -0800 (PST)
In-Reply-To: <1294257379-417-2-git-send-email-blogic@openwrt.org>
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>
        <1294257379-417-2-git-send-email-blogic@openwrt.org>
Date:   Thu, 13 Jan 2011 12:05:13 +0100
Message-ID: <AANLkTinBovWsPak3cCNRMigC8mxUwEik2oB3kSsw-YQL@mail.gmail.com>
Subject: Re: [PATCH 01/10] MIPS: lantiq: add initial support for Lantiq SoCs
From:   Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <daniel.schwierzeck@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.schwierzeck@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi John,

I have some additional suggestions.

2011/1/5 John Crispin <blogic@openwrt.org>:
> Add initial support for Mips based SoCs made by Lantiq. This series will add
> support for the XWAY family.
>
> The series allows booting a minimal system using a initramfs or NOR. Missing
> drivers and support for Amazon and GPON family will be provided in a later
> series.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/Kbuild.platforms                 |    1 +
>  arch/mips/Kconfig                          |   16 ++
>  arch/mips/include/asm/mach-lantiq/lantiq.h |   48 +++++++
>  arch/mips/include/asm/mach-lantiq/war.h    |   24 +++
>  arch/mips/lantiq/Makefile                  |    9 ++
>  arch/mips/lantiq/Platform                  |    7 +
>  arch/mips/lantiq/clk.c                     |  129 +++++++++++++++++
>  arch/mips/lantiq/clk.h                     |   18 +++
>  arch/mips/lantiq/early_printk.c            |   47 ++++++
>  arch/mips/lantiq/irq.c                     |  209 ++++++++++++++++++++++++++++
>  arch/mips/lantiq/prom.c                    |   84 +++++++++++
>  arch/mips/lantiq/prom.h                    |   26 ++++
>  arch/mips/lantiq/setup.c                   |   45 ++++++
>  13 files changed, 663 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-lantiq/lantiq.h
>  create mode 100644 arch/mips/include/asm/mach-lantiq/war.h
>  create mode 100644 arch/mips/lantiq/Makefile
>  create mode 100644 arch/mips/lantiq/Platform
>  create mode 100644 arch/mips/lantiq/clk.c
>  create mode 100644 arch/mips/lantiq/clk.h
>  create mode 100644 arch/mips/lantiq/early_printk.c
>  create mode 100644 arch/mips/lantiq/irq.c
>  create mode 100644 arch/mips/lantiq/prom.c
>  create mode 100644 arch/mips/lantiq/prom.h
>  create mode 100644 arch/mips/lantiq/setup.c
>
> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
> index 78439b8..8b7c26f 100644
> --- a/arch/mips/Kbuild.platforms
> +++ b/arch/mips/Kbuild.platforms
> @@ -10,6 +10,7 @@ platforms += dec
>  platforms += emma
>  platforms += jazz
>  platforms += jz4740
> +platforms += lantiq
>  platforms += lasat
>  platforms += loongson
>  platforms += mipssim
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 913d50d..a2396f1 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -192,6 +192,22 @@ config MACH_JZ4740
>        select SYS_HAS_EARLY_PRINTK
>        select HAVE_PWM
>
> +config LANTIQ
> +       bool "Lantiq based platforms"
> +       select DMA_NONCOHERENT
> +       select IRQ_CPU
> +       select CEVT_R4K
> +       select CSRC_R4K
> +       select SYS_HAS_CPU_MIPS32_R1
> +       select SYS_HAS_CPU_MIPS32_R2
> +       select SYS_SUPPORTS_BIG_ENDIAN
> +       select SYS_SUPPORTS_32BIT_KERNEL
> +       select SYS_SUPPORTS_MULTITHREADING
> +       select SYS_HAS_EARLY_PRINTK
> +       select ARCH_REQUIRE_GPIOLIB
> +       select SWAP_IO_SPACE
> +       select BOOT_RAW
> +
>  config LASAT
>        bool "LASAT Networks platforms"
>        select CEVT_R4K
> diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
> new file mode 100644
> index 0000000..54eb033
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
> @@ -0,0 +1,48 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> + */
> +
> +#ifndef _LANTIQ_H__
> +#define _LANTIQ_H__
> +
> +/* generic reg access functions */
> +#define ltq_r32(reg)                                           __raw_readl(reg)
> +#define ltq_w32(val, reg)                              __raw_writel(val, reg)
> +#define ltq_w32_mask(clear, set, reg)  \
> +       ltq_w32((ltq_r32(reg) & ~clear) | set, reg)
> +
> +extern unsigned int ltq_get_cpu_ver(void);
> +extern unsigned int ltq_get_soc_type(void);
> +
> +/* clock speeds */
> +#define CLOCK_60M                      60000000
> +#define CLOCK_83M                      83333333
> +#define CLOCK_111M                     111111111
> +#define CLOCK_133M                     133333333
> +#define CLOCK_167M                     166666667
> +#define CLOCK_200M                     200000000
> +#define CLOCK_266M                     266666666
> +#define CLOCK_333M                     333333333
> +#define CLOCK_400M                     400000000
> +
> +/* spinlock all ebu i/o */
> +extern spinlock_t ebu_lock;
> +
> +/* some irq helpers */
> +extern void ltq_disable_irq(unsigned int irq_nr);
> +extern void ltq_mask_and_ack_irq(unsigned int irq_nr);
> +extern void ltq_enable_irq(unsigned int irq_nr);
> +
> +#define IOPORT_RESOURCE_START          0x10000000
> +#define IOPORT_RESOURCE_END            0xffffffff
> +#define IOMEM_RESOURCE_START           0x10000000
> +#define IOMEM_RESOURCE_END             0xffffffff
> +
> +#define LTQ_FLASH_START                0x10000000
> +#define LTQ_FLASH_MAX          0x04000000
> +
> +#endif
> diff --git a/arch/mips/include/asm/mach-lantiq/war.h b/arch/mips/include/asm/mach-lantiq/war.h
> new file mode 100644
> index 0000000..01b08ef
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-lantiq/war.h
> @@ -0,0 +1,24 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + */
> +#ifndef __ASM_MIPS_MACH_LANTIQ_WAR_H
> +#define __ASM_MIPS_MACH_LANTIQ_WAR_H
> +
> +#define R4600_V1_INDEX_ICACHEOP_WAR     0
> +#define R4600_V1_HIT_CACHEOP_WAR        0
> +#define R4600_V2_HIT_CACHEOP_WAR        0
> +#define R5432_CP0_INTERRUPT_WAR         0
> +#define BCM1250_M3_WAR                  0
> +#define SIBYTE_1956_WAR                 0
> +#define MIPS4K_ICACHE_REFILL_WAR        0
> +#define MIPS_CACHE_SYNC_WAR             0
> +#define TX49XX_ICACHE_INDEX_INV_WAR     0
> +#define RM9000_CDEX_SMP_WAR             0
> +#define ICACHE_REFILLS_WORKAROUND_WAR   0
> +#define R10000_LLSC_WAR                 0
> +#define MIPS34K_MISSED_ITLB_WAR         0
> +
> +#endif
> diff --git a/arch/mips/lantiq/Makefile b/arch/mips/lantiq/Makefile
> new file mode 100644
> index 0000000..6a30de6
> --- /dev/null
> +++ b/arch/mips/lantiq/Makefile
> @@ -0,0 +1,9 @@
> +# Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> +#
> +# This program is free software; you can redistribute it and/or modify it
> +# under the terms of the GNU General Public License version 2 as published
> +# by the Free Software Foundation.
> +
> +obj-y := irq.o setup.o clk.o prom.o
> +
> +obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
> diff --git a/arch/mips/lantiq/Platform b/arch/mips/lantiq/Platform
> new file mode 100644
> index 0000000..eef587f
> --- /dev/null
> +++ b/arch/mips/lantiq/Platform
> @@ -0,0 +1,7 @@
> +#
> +# Lantiq
> +#
> +
> +platform-$(CONFIG_LANTIQ)      += lantiq/
> +cflags-$(CONFIG_LANTIQ)                += -I$(srctree)/arch/mips/include/asm/mach-lantiq
> +load-$(CONFIG_LANTIQ)          = 0xffffffff80002000
> diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
> new file mode 100644
> index 0000000..4283d92
> --- /dev/null
> +++ b/arch/mips/lantiq/clk.c
> @@ -0,0 +1,129 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + * Copyright (C) 2010 Thomas Langer <thomas.langer@lantiq.com>
> + * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/list.h>
> +
> +#include <asm/time.h>
> +#include <asm/irq.h>
> +#include <asm/div64.h>
> +
> +#include <lantiq.h>
> +
> +#include "clk.h"
> +
> +struct clk {
> +       const char *name;
> +       unsigned long rate;
> +       unsigned long (*get_rate) (void);
> +};
> +
> +static struct clk *cpu_clk;
> +static int cpu_clk_cnt;
> +
> +static unsigned int r4k_offset;
> +static unsigned int r4k_cur;

What is the sense of these variables? They are never really used.

> +
> +static struct clk cpu_clk_generic[] = {
> +       {
> +               .name = "cpu",
> +               .get_rate = ltq_get_cpu_hz,
> +       }, {
> +               .name = "fpi",
> +               .get_rate = ltq_get_fpi_hz,
> +       }, {
> +               .name = "io",
> +               .get_rate = ltq_get_io_region_clock,
> +       },
> +};
> +
> +void
> +clk_init(void)
> +{
> +       int i;
> +       cpu_clk = cpu_clk_generic;
> +       cpu_clk_cnt = ARRAY_SIZE(cpu_clk_generic);
> +       for (i = 0; i < cpu_clk_cnt; i++)
> +               printk(KERN_INFO "%s: %ld\n",
> +                       cpu_clk[i].name, clk_get_rate(&cpu_clk[i]));
> +}
> +
> +static inline int
> +clk_good(struct clk *clk)
> +{
> +       return clk && !IS_ERR(clk);
> +}
> +
> +unsigned long
> +clk_get_rate(struct clk *clk)
> +{
> +       if (unlikely(!clk_good(clk)))
> +               return 0;
> +
> +       if (clk->rate != 0)
> +               return clk->rate;
> +
> +       if (clk->get_rate != NULL)
> +               return clk->get_rate();
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(clk_get_rate);
> +
> +struct clk*
> +clk_get(struct device *dev, const char *id)
> +{
> +       int i;
> +       for (i = 0; i < cpu_clk_cnt; i++)
> +               if (!strcmp(id, cpu_clk[i].name))
> +                       return &cpu_clk[i];
> +       BUG();
> +       return ERR_PTR(-ENOENT);
> +}
> +EXPORT_SYMBOL(clk_get);
> +
> +void
> +clk_put(struct clk *clk)
> +{
> +       /* not used */
> +}
> +EXPORT_SYMBOL(clk_put);
> +
> +static inline u32
> +ltq_get_counter_resolution(void)
> +{
> +       u32 res;
> +       __asm__ __volatile__(
> +               ".set   push\n"
> +               ".set   mips32r2\n"
> +               ".set   noreorder\n"
> +               "rdhwr  %0, $3\n"
> +               "ehb\n"
> +               ".set pop\n"
> +               : "=&r" (res)
> +               : /* no input */
> +               : "memory");
> +       instruction_hazard();
> +       return res;
> +}
> +
> +void __init
> +plat_time_init(void)
> +{
> +       struct clk *clk = clk_get(0, "cpu");
> +       mips_hpt_frequency = clk_get_rate(clk) / ltq_get_counter_resolution();
> +       r4k_cur = (read_c0_count() + r4k_offset);
> +       write_c0_compare(r4k_cur);

Like stated above the r4k_cur and r4k_offset are only initailied with
0. So the last two lines
could be written as write_c0_compare(read_c0_count()) and are actually
ineffective.

> +}
> diff --git a/arch/mips/lantiq/clk.h b/arch/mips/lantiq/clk.h
> new file mode 100644
> index 0000000..3328925
> --- /dev/null
> +++ b/arch/mips/lantiq/clk.h
> @@ -0,0 +1,18 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> + */
> +
> +#ifndef _LTQ_CLK_H__
> +#define _LTQ_CLK_H__
> +
> +extern void clk_init(void);
> +
> +extern unsigned long ltq_get_cpu_hz(void);
> +extern unsigned long ltq_get_fpi_hz(void);
> +extern unsigned long ltq_get_io_region_clock(void);
> +
> +#endif
> diff --git a/arch/mips/lantiq/early_printk.c b/arch/mips/lantiq/early_printk.c
> new file mode 100644
> index 0000000..0aaf4f7
> --- /dev/null
> +++ b/arch/mips/lantiq/early_printk.c
> @@ -0,0 +1,47 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> + */
> +
> +#include <linux/init.h>
> +#include <linux/cpu.h>
> +
> +#include <lantiq.h>
> +#include <lantiq_soc.h>
> +
> +#define LTQ_ASC_BASE                   KSEG1ADDR(LTQ_ASC1_BASE)
> +#define ASC_BUF                                1024
> +#define LTQ_ASC_FSTAT          ((u32 *)(LTQ_ASC_BASE + 0x0048))
> +#define LTQ_ASC_TBUF                   ((u32 *)(LTQ_ASC_BASE + 0x0020))
> +#define TXMASK                         0x3F00
> +#define TXOFFSET                       8
> +
> +void
> +prom_putchar(char c)
> +{
> +       unsigned long flags;
> +       local_irq_save(flags);
> +       do { } while ((ltq_r32(LTQ_ASC_FSTAT) & TXMASK) >> TXOFFSET);
> +       if (c == '\n')
> +               ltq_w32('\r', LTQ_ASC_TBUF);
> +       ltq_w32(c, LTQ_ASC_TBUF);
> +       local_irq_restore(flags);
> +}
> +
> +void
> +early_printf(const char *fmt, ...)
> +{
> +       char buf[ASC_BUF];
> +       va_list args;
> +       int l;
> +       char *p, *buf_end;
> +       va_start(args, fmt);
> +       l = vsnprintf(buf, ASC_BUF, fmt, args);
> +       va_end(args);
> +       buf_end = buf + l;
> +       for (p = buf; p < buf_end; p++)
> +               prom_putchar(*p);
> +}

With CONFIG_EARLY_PRINTK enabled and prom_putchar() implemented you
can use printk() everywhere.
So an own early_printf() is not needed.

> diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
> new file mode 100644
> index 0000000..b1535ee
> --- /dev/null
> +++ b/arch/mips/lantiq/irq.c
> @@ -0,0 +1,209 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> + * Copyright (C) 2010 Thomas Langer <thomas.langer@lantiq.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +
> +#include <asm/bootinfo.h>
> +#include <asm/irq_cpu.h>
> +
> +#include <lantiq.h>
> +#include <irq.h>
> +
> +#define LTQ_ICU_BASE_ADDR      (KSEG1 | 0x1F880200)
> +
> +#define LTQ_ICU_IM0_ISR                ((u32 *)(LTQ_ICU_BASE_ADDR + 0x0000))
> +#define LTQ_ICU_IM0_IER                ((u32 *)(LTQ_ICU_BASE_ADDR + 0x0008))
> +#define LTQ_ICU_IM0_IOSR               ((u32 *)(LTQ_ICU_BASE_ADDR + 0x0010))
> +#define LTQ_ICU_IM0_IRSR               ((u32 *)(LTQ_ICU_BASE_ADDR + 0x0018))
> +#define LTQ_ICU_IM0_IMR                ((u32 *)(LTQ_ICU_BASE_ADDR + 0x0020))
> +
> +#define LTQ_ICU_IM1_ISR                ((u32 *)(LTQ_ICU_BASE_ADDR + 0x0028))
> +#define LTQ_ICU_IM2_ISR                ((u32 *)(LTQ_ICU_BASE_ADDR + 0x0050))
> +#define LTQ_ICU_IM3_ISR                ((u32 *)(LTQ_ICU_BASE_ADDR + 0x0078))
> +#define LTQ_ICU_IM4_ISR                ((u32 *)(LTQ_ICU_BASE_ADDR + 0x00A0))
> +
> +#define LTQ_ICU_OFFSET         (LTQ_ICU_IM1_ISR - LTQ_ICU_IM0_ISR)
> +
> +void
> +ltq_disable_irq(unsigned int irq_nr)
> +{
> +       u32 *ier = LTQ_ICU_IM0_IER;
> +       irq_nr -= INT_NUM_IRQ0;
> +       ier += LTQ_ICU_OFFSET * (irq_nr / INT_NUM_IM_OFFSET);
> +       irq_nr %= INT_NUM_IM_OFFSET;
> +       ltq_w32(ltq_r32(ier) & ~(1 << irq_nr), ier);
> +}
> +EXPORT_SYMBOL(ltq_disable_irq);
> +
> +void
> +ltq_mask_and_ack_irq(unsigned int irq_nr)
> +{
> +       u32 *ier = LTQ_ICU_IM0_IER;
> +       u32 *isr = LTQ_ICU_IM0_ISR;
> +       irq_nr -= INT_NUM_IRQ0;
> +       ier += LTQ_ICU_OFFSET * (irq_nr / INT_NUM_IM_OFFSET);
> +       isr += LTQ_ICU_OFFSET * (irq_nr / INT_NUM_IM_OFFSET);
> +       irq_nr %= INT_NUM_IM_OFFSET;
> +       ltq_w32(ltq_r32(ier) & ~(1 << irq_nr), ier);
> +       ltq_w32((1 << irq_nr), isr);
> +}
> +EXPORT_SYMBOL(ltq_mask_and_ack_irq);
> +
> +static void
> +ltq_ack_irq(unsigned int irq_nr)
> +{
> +       u32 *isr = LTQ_ICU_IM0_ISR;
> +       irq_nr -= INT_NUM_IRQ0;
> +       isr += LTQ_ICU_OFFSET * (irq_nr / INT_NUM_IM_OFFSET);
> +       irq_nr %= INT_NUM_IM_OFFSET;
> +       ltq_w32((1 << irq_nr), isr);
> +}
> +
> +void
> +ltq_enable_irq(unsigned int irq_nr)
> +{
> +       u32 *ier = LTQ_ICU_IM0_IER;
> +       irq_nr -= INT_NUM_IRQ0;
> +       ier += LTQ_ICU_OFFSET  * (irq_nr / INT_NUM_IM_OFFSET);
> +       irq_nr %= INT_NUM_IM_OFFSET;
> +       ltq_w32(ltq_r32(ier) | (1 << irq_nr), ier);
> +}
> +EXPORT_SYMBOL(ltq_enable_irq);
> +
> +static unsigned int
> +ltq_startup_irq(unsigned int irq)
> +{
> +       ltq_enable_irq(irq);
> +       return 0;
> +}
> +
> +static void
> +ltq_end_irq(unsigned int irq)
> +{
> +       if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
> +               ltq_enable_irq(irq);
> +}
> +
> +static struct irq_chip
> +ltq_irq_type = {
> +       "ltq_irq",
> +       .startup = ltq_startup_irq,
> +       .enable = ltq_enable_irq,
> +       .disable = ltq_disable_irq,
> +       .unmask = ltq_enable_irq,
> +       .ack = ltq_ack_irq,
> +       .mask = ltq_disable_irq,
> +       .mask_ack = ltq_mask_and_ack_irq,
> +       .end = ltq_end_irq,
> +};
> +
> +static void
> +ltq_hw_irqdispatch(int module)
> +{
> +       u32 irq;
> +
> +       irq = ltq_r32(LTQ_ICU_IM0_IOSR + (module * LTQ_ICU_OFFSET));
> +       if (irq == 0)
> +               return;
> +
> +       /* silicon bug causes only the msb set to 1 to be valid. all
> +          other bits might be bogus */
> +       irq = __fls(irq);
> +       do_IRQ((int)irq + INT_NUM_IM0_IRL0 + (INT_NUM_IM_OFFSET * module));
> +}
> +
> +#define DEFINE_HWx_IRQDISPATCH(x) \
> +static void ltq_hw ## x ## _irqdispatch(void)\
> +{\
> +       ltq_hw_irqdispatch(x); \
> +}
> +DEFINE_HWx_IRQDISPATCH(0)
> +DEFINE_HWx_IRQDISPATCH(1)
> +DEFINE_HWx_IRQDISPATCH(2)
> +DEFINE_HWx_IRQDISPATCH(3)
> +DEFINE_HWx_IRQDISPATCH(4)

The interrupt line IM0-IRL22 is shared by PCI (INT A) and EBU. Thus
ltq_hw0_irqdispatch()
should clear the PCI bit (5th bit) in EBU_PCC_ISTAT register (EBU_BASE
+ 0xA0) if you enable
this interrupt in pcibios_plat_dev_init().
This is undocumented in the hardware manuals but can be found in all
Lantiq BSP's.

> +
> +static void ltq_hw5_irqdispatch(void)
> +{
> +       do_IRQ(MIPS_CPU_TIMER_IRQ);
> +}
> +
> +asmlinkage void
> +plat_irq_dispatch(void)
> +{
> +       unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
> +       unsigned int i;
> +
> +       if (pending & CAUSEF_IP7) {
> +               do_IRQ(MIPS_CPU_TIMER_IRQ);
> +               goto out;
> +       } else {
> +               for (i = 0; i < 5; i++) {
> +                       if (pending & (CAUSEF_IP2 << i)) {
> +                               ltq_hw_irqdispatch(i);
> +                               goto out;
> +                       }
> +               }
> +       }
> +       printk(KERN_ALERT "Spurious IRQ: CAUSE=0x%08x\n", read_c0_status());
> +
> +out:
> +       return;
> +}
> +
> +static struct irqaction
> +cascade = {
> +       .handler = no_action,
> +       .flags = IRQF_DISABLED,
> +       .name = "cascade",
> +};
> +
> +void __init
> +arch_init_irq(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < 5; i++)
> +               ltq_w32(0, LTQ_ICU_IM0_IER + (i * LTQ_ICU_OFFSET));

Perhaps pending interrupts should be cleared too with
ltq_w32(~0, LTQ_ICU_IM0_ISR + (i * LTQ_ICU_OFFSET));

> +
> +       mips_cpu_irq_init();
> +
> +       for (i = 2; i <= 6; i++)
> +               setup_irq(i, &cascade);
> +
> +       if (cpu_has_vint) {
> +               printk(KERN_INFO "Setting up vectored interrupts\n");
> +               set_vi_handler(2, ltq_hw0_irqdispatch);
> +               set_vi_handler(3, ltq_hw1_irqdispatch);
> +               set_vi_handler(4, ltq_hw2_irqdispatch);
> +               set_vi_handler(5, ltq_hw3_irqdispatch);
> +               set_vi_handler(6, ltq_hw4_irqdispatch);
> +               set_vi_handler(7, ltq_hw5_irqdispatch);
> +       }
> +
> +       for (i = INT_NUM_IRQ0;
> +               i <= (INT_NUM_IRQ0 + (5 * INT_NUM_IM_OFFSET)); i++)
> +               set_irq_chip_and_handler(i, &ltq_irq_type,
> +                       handle_level_irq);
> +
> +       #if !defined(CONFIG_MIPS_MT_SMP) && !defined(CONFIG_MIPS_MT_SMTC)
> +       set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 |
> +               IE_IRQ3 | IE_IRQ4 | IE_IRQ5);
> +       #else
> +       set_c0_status(IE_SW0 | IE_SW1 | IE_IRQ0 | IE_IRQ1 |
> +               IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5);
> +       #endif
> +}
> +
> +unsigned int __cpuinit
> +get_c0_compare_int(void)
> +{
> +       return CP0_LEGACY_COMPARE_IRQ;
> +}
> diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
> new file mode 100644
> index 0000000..6561e4e
> --- /dev/null
> +++ b/arch/mips/lantiq/prom.c
> @@ -0,0 +1,84 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <asm/bootinfo.h>
> +#include <asm/time.h>
> +
> +#include <lantiq.h>
> +
> +#include "prom.h"
> +#include "clk.h"
> +
> +static struct ltq_soc_info soc_info;
> +
> +/* for Multithreading (APRP) on MIPS34K */
> +unsigned long physical_memsize;
> +
> +/* all access to the ebu must be locked */
> +DEFINE_SPINLOCK(ebu_lock);
> +EXPORT_SYMBOL_GPL(ebu_lock);

This lock is only needed if you want to use software arbitration.
Normally the EBU does hardware arbitration and can be accessed safely
without lock.

> +
> +unsigned int
> +ltq_get_cpu_ver(void)
> +{
> +       return soc_info.rev;
> +}
> +EXPORT_SYMBOL(ltq_get_cpu_ver);
> +
> +unsigned int
> +ltq_get_soc_type(void)
> +{
> +       return soc_info.type;
> +}
> +EXPORT_SYMBOL(ltq_get_soc_type);
> +
> +const char*
> +get_system_type(void)
> +{
> +       return soc_info.sys_type;
> +}
> +
> +void
> +prom_free_prom_memory(void)
> +{
> +}
> +
> +static void __init
> +prom_init_cmdline(void)
> +{
> +       int argc = fw_arg0;
> +       char **argv = (char **) KSEG1ADDR(fw_arg1);
> +       int i;
> +       arcs_cmdline[0] = '\0';
> +       if (argc)
> +               for (i = 1; i < argc; i++) {
> +                       strlcat(arcs_cmdline, (char *)KSEG1ADDR(argv[i]),
> +                               COMMAND_LINE_SIZE);
> +                       if (i + 1 != argc)
> +                               strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
> +               }
> +       if (!*arcs_cmdline)
> +               strcpy(&(arcs_cmdline[0]),
> +                       "console=ttyS1,115200 rootfstype=squashfs,jffs2");
> +}
> +
> +void __init
> +prom_init(void)
> +{
> +       struct clk *clk;
> +       ltq_soc_detect(&soc_info);
> +       clk_init();
> +       clk = clk_get(0, "cpu");
> +       snprintf(soc_info.sys_type, LTQ_SYS_TYPE_LEN - 1, "%s rev1.%d %ldMhz",
> +               soc_info.name, soc_info.rev, clk_get_rate(clk) / 1000000);
> +       soc_info.sys_type[LTQ_SYS_TYPE_LEN - 1] = '\0';
> +       printk(KERN_INFO "SoC: %s\n", soc_info.sys_type);
> +       prom_init_cmdline();
> +}
> diff --git a/arch/mips/lantiq/prom.h b/arch/mips/lantiq/prom.h
> new file mode 100644
> index 0000000..3b92197
> --- /dev/null
> +++ b/arch/mips/lantiq/prom.h
> @@ -0,0 +1,26 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> + */
> +
> +#ifndef _LTQ_PROM_H__
> +#define _LTQ_PROM_H__
> +
> +#define LTQ_SYS_TYPE_LEN       0x100
> +
> +struct ltq_soc_info {
> +       unsigned char *name;
> +       unsigned int rev;
> +       unsigned int partnum;
> +       unsigned int type;
> +       unsigned char sys_type[LTQ_SYS_TYPE_LEN];
> +};
> +
> +void ltq_soc_detect(struct ltq_soc_info *i);
> +
> +void early_printf(const char *fmt, ...);
> +
> +#endif
> diff --git a/arch/mips/lantiq/setup.c b/arch/mips/lantiq/setup.c
> new file mode 100644
> index 0000000..f0f74d2
> --- /dev/null
> +++ b/arch/mips/lantiq/setup.c
> @@ -0,0 +1,45 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <asm/bootinfo.h>
> +
> +#include <lantiq.h>
> +
> +void __init
> +plat_mem_setup(void)
> +{
> +       /* assume 16M as default */
> +       unsigned long memsize = 16;
> +       char **envp = (char **) KSEG1ADDR(fw_arg2);
> +       u32 status;
> +
> +       /* make sure to have no "reverse endian" for user mode */
> +       status = read_c0_status();
> +       status &= (~(1<<25));
> +       write_c0_status(status);
> +
> +       ioport_resource.start = IOPORT_RESOURCE_START;
> +       ioport_resource.end = IOPORT_RESOURCE_END;
> +       iomem_resource.start = IOMEM_RESOURCE_START;
> +       iomem_resource.end = IOMEM_RESOURCE_END;
> +
> +       while (*envp) {
> +               char *e = (char *)KSEG1ADDR(*envp);
> +               if (!strncmp(e, "memsize=", 8)) {
> +                       e += 8;
> +                       strict_strtoul(e, 0, &memsize);
> +               }
> +               envp++;
> +       }
> +       memsize *= 1024 * 1024;
> +       add_memory_region(0x00000000, memsize, BOOT_MEM_RAM);
> +}
> --
> 1.7.2.3
>
>
>
