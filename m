Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2012 17:25:06 +0200 (CEST)
Received: from mail-vb0-f49.google.com ([209.85.212.49]:36970 "EHLO
        mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903509Ab2GXPYr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2012 17:24:47 +0200
Received: by vbbfo1 with SMTP id fo1so6162857vbb.36
        for <multiple recipients>; Tue, 24 Jul 2012 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iKaGGX7fqP6xW1eiqV3hPpSDMwsVlfXxPcfuy/Y3l+c=;
        b=vkLj/Sr2MN0YeQfPdEytrwZCiDnjbxlr5RA/d2TbysipFhQrWybyBt2m53NkMAQ2ou
         4MnVKkvPV9NdUocne3bCewC8zz/YD1R6rzsvdiJm/0ZjtiVyCfIJVzQf1J9IawQB+EOn
         H9mcfO0M/5L0aLd+Q7pzDb8MyVHcZhD5JDUM40iP+fpRzusUOTqiPO67cDLvjemiRL8X
         25ofceIIGdMOzLzQRW4ZqQmzv57iAn9QKKoyX9YysQH3gTSb6mxzoSu1j3UyWbAPfIYT
         Q1lzah7RV2gYEM51mtzwdsWqex8qpnbmnrh6mQFBetRGzGXsI9v4LMIqibDwSevQUnAw
         ppXg==
Received: by 10.52.68.165 with SMTP id x5mr13885203vdt.2.1343143481219; Tue,
 24 Jul 2012 08:24:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.204.200 with HTTP; Tue, 24 Jul 2012 08:24:20 -0700 (PDT)
In-Reply-To: <1341653400-24860-1-git-send-email-keguang.zhang@gmail.com>
References: <1341653400-24860-1-git-send-email-keguang.zhang@gmail.com>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Tue, 24 Jul 2012 23:24:20 +0800
Message-ID: <CAJhJPsXPqDZL7aD8nhQkqVjGHZ52attwWdUU8CoC0bAgZNrM7A@mail.gmail.com>
Subject: Re: [PATCH V7 2/4] MIPS: Add board support for Loongson1B
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Cc:     wuzhangjin@gmail.com, zhzhl555@gmail.com,
        Kelvin Cheung <keguang.zhang@gmail.com>
Content-Type: multipart/alternative; boundary=20cf307f309614995004c594f6b6
X-archive-position: 33965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

--20cf307f309614995004c594f6b6
Content-Type: text/plain; charset=ISO-8859-1

Hi Ralf,

I have submitted "V7 (updated)" for 3 of the 4 patches.
And patch 1 is unchanged.
New bundle is here:
http://patchwork.linux-mips.org/bundle/kelvin/Loongson1B%20support

2012/7/7 Kelvin Cheung <keguang.zhang@gmail.com>

> This patch adds basic platform devices for Loongson1B,
> including serial port, ethernet, usb, rtc and interrupt handler.
>
> Loongson1B UART is compatible with NS16550A.
> Loongson1B GMAC is built around Synopsys IP Core.
>
> Use normal descriptor instead of enhanced descriptor.
> Thanks to Giuseppe for updating the normal descriptor
> in stmmac driver.
>
> Thanks to Zhao Zhang for implementing the RTC driver.
>
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
>
> ---
> V7(updated):
>         1.Remove 'ifdef' of platform devices. (Asked by Ralf)
>         2.Modify plat_stmmacenet_data accordingly due to the change
>           of upstream.
> ---
>  arch/mips/include/asm/mach-loongson1/irq.h       |   73 ++++++++++
>  arch/mips/include/asm/mach-loongson1/loongson1.h |   44 ++++++
>  arch/mips/include/asm/mach-loongson1/platform.h  |   23 +++
>  arch/mips/include/asm/mach-loongson1/prom.h      |   24 +++
>  arch/mips/include/asm/mach-loongson1/regs-clk.h  |   33 +++++
>  arch/mips/include/asm/mach-loongson1/regs-wdt.h  |   22 +++
>  arch/mips/include/asm/mach-loongson1/war.h       |   25 ++++
>  arch/mips/loongson1/common/clock.c               |  165
> ++++++++++++++++++++++
>  arch/mips/loongson1/common/irq.c                 |  147
> +++++++++++++++++++
>  arch/mips/loongson1/common/platform.c            |  124 ++++++++++++++++
>  arch/mips/loongson1/common/prom.c                |   87 ++++++++++++
>  arch/mips/loongson1/common/reset.c               |   45 ++++++
>  arch/mips/loongson1/common/setup.c               |   29 ++++
>  arch/mips/loongson1/ls1b/board.c                 |   33 +++++
>  14 files changed, 874 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-loongson1/irq.h
>  create mode 100644 arch/mips/include/asm/mach-loongson1/loongson1.h
>  create mode 100644 arch/mips/include/asm/mach-loongson1/platform.h
>  create mode 100644 arch/mips/include/asm/mach-loongson1/prom.h
>  create mode 100644 arch/mips/include/asm/mach-loongson1/regs-clk.h
>  create mode 100644 arch/mips/include/asm/mach-loongson1/regs-wdt.h
>  create mode 100644 arch/mips/include/asm/mach-loongson1/war.h
>  create mode 100644 arch/mips/loongson1/common/clock.c
>  create mode 100644 arch/mips/loongson1/common/irq.c
>  create mode 100644 arch/mips/loongson1/common/platform.c
>  create mode 100644 arch/mips/loongson1/common/prom.c
>  create mode 100644 arch/mips/loongson1/common/reset.c
>  create mode 100644 arch/mips/loongson1/common/setup.c
>  create mode 100644 arch/mips/loongson1/ls1b/board.c
>
> diff --git a/arch/mips/include/asm/mach-loongson1/irq.h
> b/arch/mips/include/asm/mach-loongson1/irq.h
> new file mode 100644
> index 0000000..ccc42cc
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson1/irq.h
> @@ -0,0 +1,73 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * IRQ mappings for Loongson1.
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +
> +#ifndef __ASM_MACH_LOONGSON1_IRQ_H
> +#define __ASM_MACH_LOONGSON1_IRQ_H
> +
> +/*
> + * CPU core Interrupt Numbers
> + */
> +#define MIPS_CPU_IRQ_BASE              0
> +#define MIPS_CPU_IRQ(x)                        (MIPS_CPU_IRQ_BASE + (x))
> +
> +#define SOFTINT0_IRQ                   MIPS_CPU_IRQ(0)
> +#define SOFTINT1_IRQ                   MIPS_CPU_IRQ(1)
> +#define INT0_IRQ                       MIPS_CPU_IRQ(2)
> +#define INT1_IRQ                       MIPS_CPU_IRQ(3)
> +#define INT2_IRQ                       MIPS_CPU_IRQ(4)
> +#define INT3_IRQ                       MIPS_CPU_IRQ(5)
> +#define INT4_IRQ                       MIPS_CPU_IRQ(6)
> +#define TIMER_IRQ                      MIPS_CPU_IRQ(7)         /* cpu
> timer */
> +
> +#define MIPS_CPU_IRQS          (MIPS_CPU_IRQ(7) + 1 - MIPS_CPU_IRQ_BASE)
> +
> +/*
> + * INT0~3 Interrupt Numbers
> + */
> +#define LS1X_IRQ_BASE                  MIPS_CPU_IRQS
> +#define LS1X_IRQ(n, x)                 (LS1X_IRQ_BASE + (n << 5) + (x))
> +
> +#define LS1X_UART0_IRQ                 LS1X_IRQ(0, 2)
> +#define LS1X_UART1_IRQ                 LS1X_IRQ(0, 3)
> +#define LS1X_UART2_IRQ                 LS1X_IRQ(0, 4)
> +#define LS1X_UART3_IRQ                 LS1X_IRQ(0, 5)
> +#define LS1X_CAN0_IRQ                  LS1X_IRQ(0, 6)
> +#define LS1X_CAN1_IRQ                  LS1X_IRQ(0, 7)
> +#define LS1X_SPI0_IRQ                  LS1X_IRQ(0, 8)
> +#define LS1X_SPI1_IRQ                  LS1X_IRQ(0, 9)
> +#define LS1X_AC97_IRQ                  LS1X_IRQ(0, 10)
> +#define LS1X_DMA0_IRQ                  LS1X_IRQ(0, 13)
> +#define LS1X_DMA1_IRQ                  LS1X_IRQ(0, 14)
> +#define LS1X_DMA2_IRQ                  LS1X_IRQ(0, 15)
> +#define LS1X_PWM0_IRQ                  LS1X_IRQ(0, 17)
> +#define LS1X_PWM1_IRQ                  LS1X_IRQ(0, 18)
> +#define LS1X_PWM2_IRQ                  LS1X_IRQ(0, 19)
> +#define LS1X_PWM3_IRQ                  LS1X_IRQ(0, 20)
> +#define LS1X_RTC_INT0_IRQ              LS1X_IRQ(0, 21)
> +#define LS1X_RTC_INT1_IRQ              LS1X_IRQ(0, 22)
> +#define LS1X_RTC_INT2_IRQ              LS1X_IRQ(0, 23)
> +#define LS1X_TOY_INT0_IRQ              LS1X_IRQ(0, 24)
> +#define LS1X_TOY_INT1_IRQ              LS1X_IRQ(0, 25)
> +#define LS1X_TOY_INT2_IRQ              LS1X_IRQ(0, 26)
> +#define LS1X_RTC_TICK_IRQ              LS1X_IRQ(0, 27)
> +#define LS1X_TOY_TICK_IRQ              LS1X_IRQ(0, 28)
> +
> +#define LS1X_EHCI_IRQ                  LS1X_IRQ(1, 0)
> +#define LS1X_OHCI_IRQ                  LS1X_IRQ(1, 1)
> +#define LS1X_GMAC0_IRQ                 LS1X_IRQ(1, 2)
> +#define LS1X_GMAC1_IRQ                 LS1X_IRQ(1, 3)
> +
> +#define LS1X_IRQS              (LS1X_IRQ(4, 31) + 1 - LS1X_IRQ_BASE)
> +
> +#define NR_IRQS                        (MIPS_CPU_IRQS + LS1X_IRQS)
> +
> +#endif /* __ASM_MACH_LOONGSON1_IRQ_H */
> diff --git a/arch/mips/include/asm/mach-loongson1/loongson1.h
> b/arch/mips/include/asm/mach-loongson1/loongson1.h
> new file mode 100644
> index 0000000..0440627
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson1/loongson1.h
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * Register mappings for Loongson1.
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +
> +#ifndef __ASM_MACH_LOONGSON1_LOONGSON1_H
> +#define __ASM_MACH_LOONGSON1_LOONGSON1_H
> +
> +#define DEFAULT_MEMSIZE                        256     /* If no memsize
> provided */
> +
> +/* Loongson1 Register Bases */
> +#define LS1X_INTC_BASE                 0x1fd01040
> +#define LS1X_EHCI_BASE                 0x1fe00000
> +#define LS1X_OHCI_BASE                 0x1fe08000
> +#define LS1X_GMAC0_BASE                        0x1fe10000
> +#define LS1X_GMAC1_BASE                        0x1fe20000
> +
> +#define LS1X_UART0_BASE                        0x1fe40000
> +#define LS1X_UART1_BASE                        0x1fe44000
> +#define LS1X_UART2_BASE                        0x1fe48000
> +#define LS1X_UART3_BASE                        0x1fe4c000
> +#define LS1X_CAN0_BASE                 0x1fe50000
> +#define LS1X_CAN1_BASE                 0x1fe54000
> +#define LS1X_I2C0_BASE                 0x1fe58000
> +#define LS1X_I2C1_BASE                 0x1fe68000
> +#define LS1X_I2C2_BASE                 0x1fe70000
> +#define LS1X_PWM_BASE                  0x1fe5c000
> +#define LS1X_WDT_BASE                  0x1fe5c060
> +#define LS1X_RTC_BASE                  0x1fe64000
> +#define LS1X_AC97_BASE                 0x1fe74000
> +#define LS1X_NAND_BASE                 0x1fe78000
> +#define LS1X_CLK_BASE                  0x1fe78030
> +
> +#include <regs-clk.h>
> +#include <regs-wdt.h>
> +
> +#endif /* __ASM_MACH_LOONGSON1_LOONGSON1_H */
> diff --git a/arch/mips/include/asm/mach-loongson1/platform.h
> b/arch/mips/include/asm/mach-loongson1/platform.h
> new file mode 100644
> index 0000000..2f17161
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson1/platform.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +
> +#ifndef __ASM_MACH_LOONGSON1_PLATFORM_H
> +#define __ASM_MACH_LOONGSON1_PLATFORM_H
> +
> +#include <linux/platform_device.h>
> +
> +extern struct platform_device ls1x_uart_device;
> +extern struct platform_device ls1x_eth0_device;
> +extern struct platform_device ls1x_ehci_device;
> +extern struct platform_device ls1x_rtc_device;
> +
> +void ls1x_serial_setup(void);
> +
> +#endif /* __ASM_MACH_LOONGSON1_PLATFORM_H */
> diff --git a/arch/mips/include/asm/mach-loongson1/prom.h
> b/arch/mips/include/asm/mach-loongson1/prom.h
> new file mode 100644
> index 0000000..b871dc4
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson1/prom.h
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +#ifndef __ASM_MACH_LOONGSON1_PROM_H
> +#define __ASM_MACH_LOONGSON1_PROM_H
> +
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +
> +/* environment arguments from bootloader */
> +extern unsigned long memsize, highmemsize;
> +
> +/* loongson-specific command line, env and memory initialization */
> +extern char *prom_getenv(char *name);
> +extern void __init prom_init_cmdline(void);
> +
> +#endif /* __ASM_MACH_LOONGSON1_PROM_H */
> diff --git a/arch/mips/include/asm/mach-loongson1/regs-clk.h
> b/arch/mips/include/asm/mach-loongson1/regs-clk.h
> new file mode 100644
> index 0000000..5b9635a
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson1/regs-clk.h
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * Loongson1 Clock Register Definitions.
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +#ifndef __ASM_MACH_LOONGSON1_REGS_CLK_H
> +#define __ASM_MACH_LOONGSON1_REGS_CLK_H
> +
> +#define LS1X_CLK_REG(x) \
> +               ((void __iomem *)KSEG1ADDR(LS1X_CLK_BASE + (x)))
> +
> +#define LS1X_CLK_PLL_FREQ              LS1X_CLK_REG(0x0)
> +#define LS1X_CLK_PLL_DIV               LS1X_CLK_REG(0x4)
> +
> +/* Clock PLL Divisor Register Bits */
> +#define DIV_DC_EN                      (0x1 << 31)
> +#define DIV_DC                         (0x1f << 26)
> +#define DIV_CPU_EN                     (0x1 << 25)
> +#define DIV_CPU                                (0x1f << 20)
> +#define DIV_DDR_EN                     (0x1 << 19)
> +#define DIV_DDR                                (0x1f << 14)
> +
> +#define DIV_DC_SHIFT                   26
> +#define DIV_CPU_SHIFT                  20
> +#define DIV_DDR_SHIFT                  14
> +
> +#endif /* __ASM_MACH_LOONGSON1_REGS_CLK_H */
> diff --git a/arch/mips/include/asm/mach-loongson1/regs-wdt.h
> b/arch/mips/include/asm/mach-loongson1/regs-wdt.h
> new file mode 100644
> index 0000000..d339fe7
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson1/regs-wdt.h
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * Loongson1 Watchdog register definitions.
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +#ifndef __ASM_MACH_LOONGSON1_REGS_WDT_H
> +#define __ASM_MACH_LOONGSON1_REGS_WDT_H
> +
> +#define LS1X_WDT_REG(x) \
> +               ((void __iomem *)KSEG1ADDR(LS1X_WDT_BASE + (x)))
> +
> +#define LS1X_WDT_EN                    LS1X_WDT_REG(0x0)
> +#define LS1X_WDT_SET                   LS1X_WDT_REG(0x4)
> +#define LS1X_WDT_TIMER                 LS1X_WDT_REG(0x8)
> +
> +#endif /* __ASM_MACH_LOONGSON1_REGS_WDT_H */
> diff --git a/arch/mips/include/asm/mach-loongson1/war.h
> b/arch/mips/include/asm/mach-loongson1/war.h
> new file mode 100644
> index 0000000..e3680a8
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson1/war.h
> @@ -0,0 +1,25 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General
> Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
> + */
> +#ifndef __ASM_MACH_LOONGSON1_WAR_H
> +#define __ASM_MACH_LOONGSON1_WAR_H
> +
> +#define R4600_V1_INDEX_ICACHEOP_WAR    0
> +#define R4600_V1_HIT_CACHEOP_WAR       0
> +#define R4600_V2_HIT_CACHEOP_WAR       0
> +#define R5432_CP0_INTERRUPT_WAR                0
> +#define BCM1250_M3_WAR                 0
> +#define SIBYTE_1956_WAR                        0
> +#define MIPS4K_ICACHE_REFILL_WAR       0
> +#define MIPS_CACHE_SYNC_WAR            0
> +#define TX49XX_ICACHE_INDEX_INV_WAR    0
> +#define RM9000_CDEX_SMP_WAR            0
> +#define ICACHE_REFILLS_WORKAROUND_WAR  0
> +#define R10000_LLSC_WAR                        0
> +#define MIPS34K_MISSED_ITLB_WAR                0
> +
> +#endif /* __ASM_MACH_LOONGSON1_WAR_H */
> diff --git a/arch/mips/loongson1/common/clock.c
> b/arch/mips/loongson1/common/clock.c
> new file mode 100644
> index 0000000..2d98fb0
> --- /dev/null
> +++ b/arch/mips/loongson1/common/clock.c
> @@ -0,0 +1,165 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <asm/clock.h>
> +#include <asm/time.h>
> +
> +#include <loongson1.h>
> +
> +static LIST_HEAD(clocks);
> +static DEFINE_MUTEX(clocks_mutex);
> +
> +struct clk *clk_get(struct device *dev, const char *name)
> +{
> +       struct clk *c;
> +       struct clk *ret = NULL;
> +
> +       mutex_lock(&clocks_mutex);
> +       list_for_each_entry(c, &clocks, node) {
> +               if (!strcmp(c->name, name)) {
> +                       ret = c;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&clocks_mutex);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(clk_get);
> +
> +unsigned long clk_get_rate(struct clk *clk)
> +{
> +       return clk->rate;
> +}
> +EXPORT_SYMBOL(clk_get_rate);
> +
> +static void pll_clk_init(struct clk *clk)
> +{
> +       u32 pll;
> +
> +       pll = __raw_readl(LS1X_CLK_PLL_FREQ);
> +       clk->rate = (12 + (pll & 0x3f)) * 33 / 2
> +                       + ((pll >> 8) & 0x3ff) * 33 / 1024 / 2;
> +       clk->rate *= 1000000;
> +}
> +
> +static void cpu_clk_init(struct clk *clk)
> +{
> +       u32 pll, ctrl;
> +
> +       pll = clk_get_rate(clk->parent);
> +       ctrl = __raw_readl(LS1X_CLK_PLL_DIV) & DIV_CPU;
> +       clk->rate = pll / (ctrl >> DIV_CPU_SHIFT);
> +}
> +
> +static void ddr_clk_init(struct clk *clk)
> +{
> +       u32 pll, ctrl;
> +
> +       pll = clk_get_rate(clk->parent);
> +       ctrl = __raw_readl(LS1X_CLK_PLL_DIV) & DIV_DDR;
> +       clk->rate = pll / (ctrl >> DIV_DDR_SHIFT);
> +}
> +
> +static void dc_clk_init(struct clk *clk)
> +{
> +       u32 pll, ctrl;
> +
> +       pll = clk_get_rate(clk->parent);
> +       ctrl = __raw_readl(LS1X_CLK_PLL_DIV) & DIV_DC;
> +       clk->rate = pll / (ctrl >> DIV_DC_SHIFT);
> +}
> +
> +static struct clk_ops pll_clk_ops = {
> +       .init   = pll_clk_init,
> +};
> +
> +static struct clk_ops cpu_clk_ops = {
> +       .init   = cpu_clk_init,
> +};
> +
> +static struct clk_ops ddr_clk_ops = {
> +       .init   = ddr_clk_init,
> +};
> +
> +static struct clk_ops dc_clk_ops = {
> +       .init   = dc_clk_init,
> +};
> +
> +static struct clk pll_clk = {
> +       .name   = "pll",
> +       .ops    = &pll_clk_ops,
> +};
> +
> +static struct clk cpu_clk = {
> +       .name   = "cpu",
> +       .parent = &pll_clk,
> +       .ops    = &cpu_clk_ops,
> +};
> +
> +static struct clk ddr_clk = {
> +       .name   = "ddr",
> +       .parent = &pll_clk,
> +       .ops    = &ddr_clk_ops,
> +};
> +
> +static struct clk dc_clk = {
> +       .name   = "dc",
> +       .parent = &pll_clk,
> +       .ops    = &dc_clk_ops,
> +};
> +
> +int clk_register(struct clk *clk)
> +{
> +       mutex_lock(&clocks_mutex);
> +       list_add(&clk->node, &clocks);
> +       if (clk->ops->init)
> +               clk->ops->init(clk);
> +       mutex_unlock(&clocks_mutex);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(clk_register);
> +
> +static struct clk *ls1x_clks[] = {
> +       &pll_clk,
> +       &cpu_clk,
> +       &ddr_clk,
> +       &dc_clk,
> +};
> +
> +int __init ls1x_clock_init(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(ls1x_clks); i++)
> +               clk_register(ls1x_clks[i]);
> +
> +       return 0;
> +}
> +
> +void __init plat_time_init(void)
> +{
> +       struct clk *clk;
> +
> +       /* Initialize LS1X clocks */
> +       ls1x_clock_init();
> +
> +       /* setup mips r4k timer */
> +       clk = clk_get(NULL, "cpu");
> +       if (IS_ERR(clk))
> +               panic("unable to get dc clock, err=%ld", PTR_ERR(clk));
> +
> +       mips_hpt_frequency = clk_get_rate(clk) / 2;
> +}
> diff --git a/arch/mips/loongson1/common/irq.c
> b/arch/mips/loongson1/common/irq.c
> new file mode 100644
> index 0000000..41bc8ff
> --- /dev/null
> +++ b/arch/mips/loongson1/common/irq.c
> @@ -0,0 +1,147 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <asm/irq_cpu.h>
> +
> +#include <loongson1.h>
> +#include <irq.h>
> +
> +#define LS1X_INTC_REG(n, x) \
> +               ((void __iomem *)KSEG1ADDR(LS1X_INTC_BASE + (n * 0x18) +
> (x)))
> +
> +#define LS1X_INTC_INTISR(n)            LS1X_INTC_REG(n, 0x0)
> +#define LS1X_INTC_INTIEN(n)            LS1X_INTC_REG(n, 0x4)
> +#define LS1X_INTC_INTSET(n)            LS1X_INTC_REG(n, 0x8)
> +#define LS1X_INTC_INTCLR(n)            LS1X_INTC_REG(n, 0xc)
> +#define LS1X_INTC_INTPOL(n)            LS1X_INTC_REG(n, 0x10)
> +#define LS1X_INTC_INTEDGE(n)           LS1X_INTC_REG(n, 0x14)
> +
> +static void ls1x_irq_ack(struct irq_data *d)
> +{
> +       unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
> +       unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
> +
> +       __raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
> +                       | (1 << bit), LS1X_INTC_INTCLR(n));
> +}
> +
> +static void ls1x_irq_mask(struct irq_data *d)
> +{
> +       unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
> +       unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
> +
> +       __raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
> +                       & ~(1 << bit), LS1X_INTC_INTIEN(n));
> +}
> +
> +static void ls1x_irq_mask_ack(struct irq_data *d)
> +{
> +       unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
> +       unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
> +
> +       __raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
> +                       & ~(1 << bit), LS1X_INTC_INTIEN(n));
> +       __raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
> +                       | (1 << bit), LS1X_INTC_INTCLR(n));
> +}
> +
> +static void ls1x_irq_unmask(struct irq_data *d)
> +{
> +       unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
> +       unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
> +
> +       __raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
> +                       | (1 << bit), LS1X_INTC_INTIEN(n));
> +}
> +
> +static struct irq_chip ls1x_irq_chip = {
> +       .name           = "LS1X-INTC",
> +       .irq_ack        = ls1x_irq_ack,
> +       .irq_mask       = ls1x_irq_mask,
> +       .irq_mask_ack   = ls1x_irq_mask_ack,
> +       .irq_unmask     = ls1x_irq_unmask,
> +};
> +
> +static void ls1x_irq_dispatch(int n)
> +{
> +       u32 int_status, irq;
> +
> +       /* Get pending sources, masked by current enables */
> +       int_status = __raw_readl(LS1X_INTC_INTISR(n)) &
> +                       __raw_readl(LS1X_INTC_INTIEN(n));
> +
> +       if (int_status) {
> +               irq = LS1X_IRQ(n, __ffs(int_status));
> +               do_IRQ(irq);
> +       }
> +}
> +
> +asmlinkage void plat_irq_dispatch(void)
> +{
> +       unsigned int pending;
> +
> +       pending = read_c0_cause() & read_c0_status() & ST0_IM;
> +
> +       if (pending & CAUSEF_IP7)
> +               do_IRQ(TIMER_IRQ);
> +       else if (pending & CAUSEF_IP2)
> +               ls1x_irq_dispatch(0); /* INT0 */
> +       else if (pending & CAUSEF_IP3)
> +               ls1x_irq_dispatch(1); /* INT1 */
> +       else if (pending & CAUSEF_IP4)
> +               ls1x_irq_dispatch(2); /* INT2 */
> +       else if (pending & CAUSEF_IP5)
> +               ls1x_irq_dispatch(3); /* INT3 */
> +       else if (pending & CAUSEF_IP6)
> +               ls1x_irq_dispatch(4); /* INT4 */
> +       else
> +               spurious_interrupt();
> +
> +}
> +
> +struct irqaction cascade_irqaction = {
> +       .handler = no_action,
> +       .name = "cascade",
> +       .flags = IRQF_NO_THREAD,
> +};
> +
> +static void __init ls1x_irq_init(int base)
> +{
> +       int n;
> +
> +       /* Disable interrupts and clear pending,
> +        * setup all IRQs as high level triggered
> +        */
> +       for (n = 0; n < 4; n++) {
> +               __raw_writel(0x0, LS1X_INTC_INTIEN(n));
> +               __raw_writel(0xffffffff, LS1X_INTC_INTCLR(n));
> +               __raw_writel(0xffffffff, LS1X_INTC_INTPOL(n));
> +               /* set DMA0, DMA1 and DMA2 to edge trigger */
> +               __raw_writel(n ? 0x0 : 0xe000, LS1X_INTC_INTEDGE(n));
> +       }
> +
> +
> +       for (n = base; n < LS1X_IRQS; n++) {
> +               irq_set_chip_and_handler(n, &ls1x_irq_chip,
> +                                        handle_level_irq);
> +       }
> +
> +       setup_irq(INT0_IRQ, &cascade_irqaction);
> +       setup_irq(INT1_IRQ, &cascade_irqaction);
> +       setup_irq(INT2_IRQ, &cascade_irqaction);
> +       setup_irq(INT3_IRQ, &cascade_irqaction);
> +}
> +
> +void __init arch_init_irq(void)
> +{
> +       mips_cpu_irq_init();
> +       ls1x_irq_init(LS1X_IRQ_BASE);
> +}
> diff --git a/arch/mips/loongson1/common/platform.c
> b/arch/mips/loongson1/common/platform.c
> new file mode 100644
> index 0000000..e92d59c
> --- /dev/null
> +++ b/arch/mips/loongson1/common/platform.c
> @@ -0,0 +1,124 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/phy.h>
> +#include <linux/serial_8250.h>
> +#include <linux/stmmac.h>
> +#include <asm-generic/sizes.h>
> +
> +#include <loongson1.h>
> +
> +#define LS1X_UART(_id)                                         \
> +       {                                                       \
> +               .mapbase        = LS1X_UART ## _id ## _BASE,    \
> +               .irq            = LS1X_UART ## _id ## _IRQ,     \
> +               .iotype         = UPIO_MEM,                     \
> +               .flags          = UPF_IOREMAP | UPF_FIXED_TYPE, \
> +               .type           = PORT_16550A,                  \
> +       }
> +
> +static struct plat_serial8250_port ls1x_serial8250_port[] = {
> +       LS1X_UART(0),
> +       LS1X_UART(1),
> +       LS1X_UART(2),
> +       LS1X_UART(3),
> +       {},
> +};
> +
> +struct platform_device ls1x_uart_device = {
> +       .name           = "serial8250",
> +       .id             = PLAT8250_DEV_PLATFORM,
> +       .dev            = {
> +               .platform_data = ls1x_serial8250_port,
> +       },
> +};
> +
> +void __init ls1x_serial_setup(void)
> +{
> +       struct clk *clk;
> +       struct plat_serial8250_port *p;
> +
> +       clk = clk_get(NULL, "dc");
> +       if (IS_ERR(clk))
> +               panic("unable to get dc clock, err=%ld", PTR_ERR(clk));
> +
> +       for (p = ls1x_serial8250_port; p->flags != 0; ++p)
> +               p->uartclk = clk_get_rate(clk);
> +}
> +
> +/* Synopsys Ethernet GMAC */
> +static struct resource ls1x_eth0_resources[] = {
> +       [0] = {
> +               .start  = LS1X_GMAC0_BASE,
> +               .end    = LS1X_GMAC0_BASE + SZ_64K - 1,
> +               .flags  = IORESOURCE_MEM,
> +       },
> +       [1] = {
> +               .name   = "macirq",
> +               .start  = LS1X_GMAC0_IRQ,
> +               .flags  = IORESOURCE_IRQ,
> +       },
> +};
> +
> +static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
> +       .bus_id         = 0,
> +       .phy_mask       = 0,
> +};
> +
> +static struct plat_stmmacenet_data ls1x_eth_data = {
> +       .bus_id         = 0,
> +       .phy_addr       = -1,
> +       .mdio_bus_data  = &ls1x_mdio_bus_data,
> +       .has_gmac       = 1,
> +       .tx_coe         = 1,
> +};
> +
> +struct platform_device ls1x_eth0_device = {
> +       .name           = "stmmaceth",
> +       .id             = 0,
> +       .num_resources  = ARRAY_SIZE(ls1x_eth0_resources),
> +       .resource       = ls1x_eth0_resources,
> +       .dev            = {
> +               .platform_data = &ls1x_eth_data,
> +       },
> +};
> +
> +/* USB EHCI */
> +static u64 ls1x_ehci_dmamask = DMA_BIT_MASK(32);
> +
> +static struct resource ls1x_ehci_resources[] = {
> +       [0] = {
> +               .start  = LS1X_EHCI_BASE,
> +               .end    = LS1X_EHCI_BASE + SZ_32K - 1,
> +               .flags  = IORESOURCE_MEM,
> +       },
> +       [1] = {
> +               .start  = LS1X_EHCI_IRQ,
> +               .flags  = IORESOURCE_IRQ,
> +       },
> +};
> +
> +struct platform_device ls1x_ehci_device = {
> +       .name           = "ls1x-ehci",
> +       .id             = -1,
> +       .num_resources  = ARRAY_SIZE(ls1x_ehci_resources),
> +       .resource       = ls1x_ehci_resources,
> +       .dev            = {
> +               .dma_mask = &ls1x_ehci_dmamask,
> +       },
> +};
> +
> +/* Real Time Clock */
> +struct platform_device ls1x_rtc_device = {
> +       .name           = "ls1x-rtc",
> +       .id             = -1,
> +};
> diff --git a/arch/mips/loongson1/common/prom.c
> b/arch/mips/loongson1/common/prom.c
> new file mode 100644
> index 0000000..1f8e49f
> --- /dev/null
> +++ b/arch/mips/loongson1/common/prom.c
> @@ -0,0 +1,87 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * Modified from arch/mips/pnx833x/common/prom.c.
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +#include <linux/serial_reg.h>
> +#include <asm/bootinfo.h>
> +
> +#include <loongson1.h>
> +#include <prom.h>
> +
> +int prom_argc;
> +char **prom_argv, **prom_envp;
> +unsigned long memsize, highmemsize;
> +
> +char *prom_getenv(char *envname)
> +{
> +       char **env = prom_envp;
> +       int i;
> +
> +       i = strlen(envname);
> +
> +       while (*env) {
> +               if (strncmp(envname, *env, i) == 0 && *(*env+i) == '=')
> +                       return *env + i + 1;
> +               env++;
> +       }
> +
> +       return 0;
> +}
> +
> +static inline unsigned long env_or_default(char *env, unsigned long dfl)
> +{
> +       char *str = prom_getenv(env);
> +       return str ? simple_strtol(str, 0, 0) : dfl;
> +}
> +
> +void __init prom_init_cmdline(void)
> +{
> +       char *c = &(arcs_cmdline[0]);
> +       int i;
> +
> +       for (i = 1; i < prom_argc; i++) {
> +               strcpy(c, prom_argv[i]);
> +               c += strlen(prom_argv[i]);
> +               if (i < prom_argc-1)
> +                       *c++ = ' ';
> +       }
> +       *c = 0;
> +}
> +
> +void __init prom_init(void)
> +{
> +       prom_argc = fw_arg0;
> +       prom_argv = (char **)fw_arg1;
> +       prom_envp = (char **)fw_arg2;
> +
> +       prom_init_cmdline();
> +
> +       memsize = env_or_default("memsize", DEFAULT_MEMSIZE);
> +       highmemsize = env_or_default("highmemsize", 0x0);
> +}
> +
> +void __init prom_free_prom_memory(void)
> +{
> +}
> +
> +#define PORT(offset)   (u8 *)(KSEG1ADDR(LS1X_UART0_BASE + offset))
> +
> +void __init prom_putchar(char c)
> +{
> +       int timeout;
> +
> +       timeout = 1024;
> +
> +       while (((readb(PORT(UART_LSR)) & UART_LSR_THRE) == 0)
> +                       && (timeout-- > 0))
> +               ;
> +
> +       writeb(c, PORT(UART_TX));
> +}
> diff --git a/arch/mips/loongson1/common/reset.c
> b/arch/mips/loongson1/common/reset.c
> new file mode 100644
> index 0000000..fb979a7
> --- /dev/null
> +++ b/arch/mips/loongson1/common/reset.c
> @@ -0,0 +1,45 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/pm.h>
> +#include <asm/reboot.h>
> +
> +#include <loongson1.h>
> +
> +static void ls1x_restart(char *command)
> +{
> +       __raw_writel(0x1, LS1X_WDT_EN);
> +       __raw_writel(0x5000000, LS1X_WDT_TIMER);
> +       __raw_writel(0x1, LS1X_WDT_SET);
> +}
> +
> +static void ls1x_halt(void)
> +{
> +       while (1) {
> +               if (cpu_wait)
> +                       cpu_wait();
> +       }
> +}
> +
> +static void ls1x_power_off(void)
> +{
> +       ls1x_halt();
> +}
> +
> +static int __init ls1x_reboot_setup(void)
> +{
> +       _machine_restart = ls1x_restart;
> +       _machine_halt = ls1x_halt;
> +       pm_power_off = ls1x_power_off;
> +
> +       return 0;
> +}
> +
> +arch_initcall(ls1x_reboot_setup);
> diff --git a/arch/mips/loongson1/common/setup.c
> b/arch/mips/loongson1/common/setup.c
> new file mode 100644
> index 0000000..62128cc
> --- /dev/null
> +++ b/arch/mips/loongson1/common/setup.c
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +#include <asm/bootinfo.h>
> +
> +#include <prom.h>
> +
> +void __init plat_mem_setup(void)
> +{
> +       add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
> +}
> +
> +const char *get_system_type(void)
> +{
> +       unsigned int processor_id = (&current_cpu_data)->processor_id;
> +
> +       switch (processor_id & PRID_REV_MASK) {
> +       case PRID_REV_LOONGSON1B:
> +               return "LOONGSON LS1B";
> +       default:
> +               return "LOONGSON (unknown)";
> +       }
> +}
> diff --git a/arch/mips/loongson1/ls1b/board.c
> b/arch/mips/loongson1/ls1b/board.c
> new file mode 100644
> index 0000000..295b1be
> --- /dev/null
> +++ b/arch/mips/loongson1/ls1b/board.c
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify
> it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> + * option) any later version.
> + */
> +
> +#include <platform.h>
> +
> +#include <linux/serial_8250.h>
> +#include <loongson1.h>
> +
> +static struct platform_device *ls1b_platform_devices[] __initdata = {
> +       &ls1x_uart_device,
> +       &ls1x_eth0_device,
> +       &ls1x_ehci_device,
> +       &ls1x_rtc_device,
> +};
> +
> +static int __init ls1b_platform_init(void)
> +{
> +       int err;
> +
> +       ls1x_serial_setup();
> +
> +       err = platform_add_devices(ls1b_platform_devices,
> +                                  ARRAY_SIZE(ls1b_platform_devices));
> +       return err;
> +}
> +
> +arch_initcall(ls1b_platform_init);
> --
> 1.7.1
>
>


-- 
Best Regards!
Kelvin

--20cf307f309614995004c594f6b6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ralf,<br><br>I have submitted &quot;V7 (updated)&quot; for 3 of the 4 pa=
tches.<br>And patch 1 is unchanged.<br>New bundle is here:<br><a href=3D"ht=
tp://patchwork.linux-mips.org/bundle/kelvin/Loongson1B%20support" target=3D=
"_blank">http://patchwork.linux-mips.org/bundle/kelvin/Loongson1B%20support=
</a><br>

<br><div class=3D"gmail_quote">2012/7/7 Kelvin Cheung <span dir=3D"ltr">&lt=
;<a href=3D"mailto:keguang.zhang@gmail.com" target=3D"_blank">keguang.zhang=
@gmail.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

This patch adds basic platform devices for Loongson1B,<br>
including serial port, ethernet, usb, rtc and interrupt handler.<br>
<br>
Loongson1B UART is compatible with NS16550A.<br>
Loongson1B GMAC is built around Synopsys IP Core.<br>
<br>
Use normal descriptor instead of enhanced descriptor.<br>
Thanks to Giuseppe for updating the normal descriptor<br>
in stmmac driver.<br>
<br>
Thanks to Zhao Zhang for implementing the RTC driver.<br>
<br>
Signed-off-by: Kelvin Cheung &lt;<a href=3D"mailto:keguang.zhang@gmail.com"=
>keguang.zhang@gmail.com</a>&gt;<br>
<br>
---<br>
V7(updated):<br>
=A0 =A0 =A0 =A0 1.Remove &#39;ifdef&#39; of platform devices. (Asked by Ral=
f)<br>
=A0 =A0 =A0 =A0 2.Modify plat_stmmacenet_data accordingly due to the change=
<br>
=A0 =A0 =A0 =A0 =A0 of upstream.<br>
---<br>
=A0arch/mips/include/asm/mach-loongson1/irq.h =A0 =A0 =A0 | =A0 73 ++++++++=
++<br>
=A0arch/mips/include/asm/mach-loongson1/loongson1.h | =A0 44 ++++++<br>
=A0arch/mips/include/asm/mach-loongson1/platform.h =A0| =A0 23 +++<br>
=A0arch/mips/include/asm/mach-loongson1/prom.h =A0 =A0 =A0| =A0 24 +++<br>
=A0arch/mips/include/asm/mach-loongson1/regs-clk.h =A0| =A0 33 +++++<br>
=A0arch/mips/include/asm/mach-loongson1/regs-wdt.h =A0| =A0 22 +++<br>
=A0arch/mips/include/asm/mach-loongson1/war.h =A0 =A0 =A0 | =A0 25 ++++<br>
=A0arch/mips/loongson1/common/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0165 =
++++++++++++++++++++++<br>
=A0arch/mips/loongson1/common/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A014=
7 +++++++++++++++++++<br>
=A0arch/mips/loongson1/common/platform.c =A0 =A0 =A0 =A0 =A0 =A0| =A0124 ++=
++++++++++++++<br>
=A0arch/mips/loongson1/common/prom.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 8=
7 ++++++++++++<br>
=A0arch/mips/loongson1/common/reset.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 45 =
++++++<br>
=A0arch/mips/loongson1/common/setup.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 29 =
++++<br>
=A0arch/mips/loongson1/ls1b/board.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 3=
3 +++++<br>
=A014 files changed, 874 insertions(+), 0 deletions(-)<br>
=A0create mode 100644 arch/mips/include/asm/mach-loongson1/irq.h<br>
=A0create mode 100644 arch/mips/include/asm/mach-loongson1/loongson1.h<br>
=A0create mode 100644 arch/mips/include/asm/mach-loongson1/platform.h<br>
=A0create mode 100644 arch/mips/include/asm/mach-loongson1/prom.h<br>
=A0create mode 100644 arch/mips/include/asm/mach-loongson1/regs-clk.h<br>
=A0create mode 100644 arch/mips/include/asm/mach-loongson1/regs-wdt.h<br>
=A0create mode 100644 arch/mips/include/asm/mach-loongson1/war.h<br>
=A0create mode 100644 arch/mips/loongson1/common/clock.c<br>
=A0create mode 100644 arch/mips/loongson1/common/irq.c<br>
=A0create mode 100644 arch/mips/loongson1/common/platform.c<br>
=A0create mode 100644 arch/mips/loongson1/common/prom.c<br>
=A0create mode 100644 arch/mips/loongson1/common/reset.c<br>
=A0create mode 100644 arch/mips/loongson1/common/setup.c<br>
=A0create mode 100644 arch/mips/loongson1/ls1b/board.c<br>
<br>
diff --git a/arch/mips/include/asm/mach-loongson1/irq.h b/arch/mips/include=
/asm/mach-loongson1/irq.h<br>
new file mode 100644<br>
index 0000000..ccc42cc<br>
--- /dev/null<br>
+++ b/arch/mips/include/asm/mach-loongson1/irq.h<br>
@@ -0,0 +1,73 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * IRQ mappings for Loongson1.<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+<br>
+#ifndef __ASM_MACH_LOONGSON1_IRQ_H<br>
+#define __ASM_MACH_LOONGSON1_IRQ_H<br>
+<br>
+/*<br>
+ * CPU core Interrupt Numbers<br>
+ */<br>
+#define MIPS_CPU_IRQ_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A00<br>
+#define MIPS_CPU_IRQ(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(MI=
PS_CPU_IRQ_BASE + (x))<br>
+<br>
+#define SOFTINT0_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MIPS_CPU_IRQ(0)<b=
r>
+#define SOFTINT1_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MIPS_CPU_IRQ(1)<b=
r>
+#define INT0_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MIPS_CPU_IRQ(=
2)<br>
+#define INT1_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MIPS_CPU_IRQ(=
3)<br>
+#define INT2_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MIPS_CPU_IRQ(=
4)<br>
+#define INT3_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MIPS_CPU_IRQ(=
5)<br>
+#define INT4_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MIPS_CPU_IRQ(=
6)<br>
+#define TIMER_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MIPS_CPU_IRQ(=
7) =A0 =A0 =A0 =A0 /* cpu timer */<br>
+<br>
+#define MIPS_CPU_IRQS =A0 =A0 =A0 =A0 =A0(MIPS_CPU_IRQ(7) + 1 - MIPS_CPU_I=
RQ_BASE)<br>
+<br>
+/*<br>
+ * INT0~3 Interrupt Numbers<br>
+ */<br>
+#define LS1X_IRQ_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MIPS_CPU_IRQS<br>
+#define LS1X_IRQ(n, x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (LS1X_IRQ_BASE + (n=
 &lt;&lt; 5) + (x))<br>
+<br>
+#define LS1X_UART0_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LS1X_IRQ(0, 2)<br>
+#define LS1X_UART1_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LS1X_IRQ(0, 3)<br>
+#define LS1X_UART2_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LS1X_IRQ(0, 4)<br>
+#define LS1X_UART3_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LS1X_IRQ(0, 5)<br>
+#define LS1X_CAN0_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 6)<br=
>
+#define LS1X_CAN1_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 7)<br=
>
+#define LS1X_SPI0_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 8)<br=
>
+#define LS1X_SPI1_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 9)<br=
>
+#define LS1X_AC97_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 10)<b=
r>
+#define LS1X_DMA0_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 13)<b=
r>
+#define LS1X_DMA1_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 14)<b=
r>
+#define LS1X_DMA2_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 15)<b=
r>
+#define LS1X_PWM0_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 17)<b=
r>
+#define LS1X_PWM1_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 18)<b=
r>
+#define LS1X_PWM2_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 19)<b=
r>
+#define LS1X_PWM3_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 20)<b=
r>
+#define LS1X_RTC_INT0_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 21)<br>
+#define LS1X_RTC_INT1_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 22)<br>
+#define LS1X_RTC_INT2_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 23)<br>
+#define LS1X_TOY_INT0_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 24)<br>
+#define LS1X_TOY_INT1_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 25)<br>
+#define LS1X_TOY_INT2_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 26)<br>
+#define LS1X_RTC_TICK_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 27)<br>
+#define LS1X_TOY_TICK_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(0, 28)<br>
+<br>
+#define LS1X_EHCI_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(1, 0)<br=
>
+#define LS1X_OHCI_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_IRQ(1, 1)<br=
>
+#define LS1X_GMAC0_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LS1X_IRQ(1, 2)<br>
+#define LS1X_GMAC1_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LS1X_IRQ(1, 3)<br>
+<br>
+#define LS1X_IRQS =A0 =A0 =A0 =A0 =A0 =A0 =A0(LS1X_IRQ(4, 31) + 1 - LS1X_I=
RQ_BASE)<br>
+<br>
+#define NR_IRQS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(MIPS_CPU_I=
RQS + LS1X_IRQS)<br>
+<br>
+#endif /* __ASM_MACH_LOONGSON1_IRQ_H */<br>
diff --git a/arch/mips/include/asm/mach-loongson1/loongson1.h b/arch/mips/i=
nclude/asm/mach-loongson1/loongson1.h<br>
new file mode 100644<br>
index 0000000..0440627<br>
--- /dev/null<br>
+++ b/arch/mips/include/asm/mach-loongson1/loongson1.h<br>
@@ -0,0 +1,44 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * Register mappings for Loongson1.<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+<br>
+#ifndef __ASM_MACH_LOONGSON1_LOONGSON1_H<br>
+#define __ASM_MACH_LOONGSON1_LOONGSON1_H<br>
+<br>
+#define DEFAULT_MEMSIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0256=
 =A0 =A0 /* If no memsize provided */<br>
+<br>
+/* Loongson1 Register Bases */<br>
+#define LS1X_INTC_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1fd01040<br>
+#define LS1X_EHCI_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1fe00000<br>
+#define LS1X_OHCI_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1fe08000<br>
+#define LS1X_GMAC0_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1=
fe10000<br>
+#define LS1X_GMAC1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1=
fe20000<br>
+<br>
+#define LS1X_UART0_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1=
fe40000<br>
+#define LS1X_UART1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1=
fe44000<br>
+#define LS1X_UART2_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1=
fe48000<br>
+#define LS1X_UART3_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1=
fe4c000<br>
+#define LS1X_CAN0_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1fe50000<br>
+#define LS1X_CAN1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1fe54000<br>
+#define LS1X_I2C0_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1fe58000<br>
+#define LS1X_I2C1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1fe68000<br>
+#define LS1X_I2C2_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1fe70000<br>
+#define LS1X_PWM_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1fe5c000<br>
+#define LS1X_WDT_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1fe5c060<br>
+#define LS1X_RTC_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1fe64000<br>
+#define LS1X_AC97_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1fe74000<br>
+#define LS1X_NAND_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1fe78000<br>
+#define LS1X_CLK_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1fe78030<br>
+<br>
+#include &lt;regs-clk.h&gt;<br>
+#include &lt;regs-wdt.h&gt;<br>
+<br>
+#endif /* __ASM_MACH_LOONGSON1_LOONGSON1_H */<br>
diff --git a/arch/mips/include/asm/mach-loongson1/platform.h b/arch/mips/in=
clude/asm/mach-loongson1/platform.h<br>
new file mode 100644<br>
index 0000000..2f17161<br>
--- /dev/null<br>
+++ b/arch/mips/include/asm/mach-loongson1/platform.h<br>
@@ -0,0 +1,23 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+<br>
+#ifndef __ASM_MACH_LOONGSON1_PLATFORM_H<br>
+#define __ASM_MACH_LOONGSON1_PLATFORM_H<br>
+<br>
+#include &lt;linux/platform_device.h&gt;<br>
+<br>
+extern struct platform_device ls1x_uart_device;<br>
+extern struct platform_device ls1x_eth0_device;<br>
+extern struct platform_device ls1x_ehci_device;<br>
+extern struct platform_device ls1x_rtc_device;<br>
+<br>
+void ls1x_serial_setup(void);<br>
+<br>
+#endif /* __ASM_MACH_LOONGSON1_PLATFORM_H */<br>
diff --git a/arch/mips/include/asm/mach-loongson1/prom.h b/arch/mips/includ=
e/asm/mach-loongson1/prom.h<br>
new file mode 100644<br>
index 0000000..b871dc4<br>
--- /dev/null<br>
+++ b/arch/mips/include/asm/mach-loongson1/prom.h<br>
@@ -0,0 +1,24 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+#ifndef __ASM_MACH_LOONGSON1_PROM_H<br>
+#define __ASM_MACH_LOONGSON1_PROM_H<br>
+<br>
+#include &lt;linux/io.h&gt;<br>
+#include &lt;linux/init.h&gt;<br>
+#include &lt;linux/irq.h&gt;<br>
+<br>
+/* environment arguments from bootloader */<br>
+extern unsigned long memsize, highmemsize;<br>
+<br>
+/* loongson-specific command line, env and memory initialization */<br>
+extern char *prom_getenv(char *name);<br>
+extern void __init prom_init_cmdline(void);<br>
+<br>
+#endif /* __ASM_MACH_LOONGSON1_PROM_H */<br>
diff --git a/arch/mips/include/asm/mach-loongson1/regs-clk.h b/arch/mips/in=
clude/asm/mach-loongson1/regs-clk.h<br>
new file mode 100644<br>
index 0000000..5b9635a<br>
--- /dev/null<br>
+++ b/arch/mips/include/asm/mach-loongson1/regs-clk.h<br>
@@ -0,0 +1,33 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * Loongson1 Clock Register Definitions.<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+#ifndef __ASM_MACH_LOONGSON1_REGS_CLK_H<br>
+#define __ASM_MACH_LOONGSON1_REGS_CLK_H<br>
+<br>
+#define LS1X_CLK_REG(x) \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((void __iomem *)KSEG1ADDR(LS1X_CLK_BASE + (x=
)))<br>
+<br>
+#define LS1X_CLK_PLL_FREQ =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_CLK_REG(0x0)<br>
+#define LS1X_CLK_PLL_DIV =A0 =A0 =A0 =A0 =A0 =A0 =A0 LS1X_CLK_REG(0x4)<br>
+<br>
+/* Clock PLL Divisor Register Bits */<br>
+#define DIV_DC_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 &lt;&lt;=
 31)<br>
+#define DIV_DC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1f &lt;&=
lt; 26)<br>
+#define DIV_CPU_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 &lt;&lt; 2=
5)<br>
+#define DIV_CPU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(0x1f &lt;&lt; 20)<br>
+#define DIV_DDR_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 &lt;&lt; 1=
9)<br>
+#define DIV_DDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(0x1f &lt;&lt; 14)<br>
+<br>
+#define DIV_DC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 26<br>
+#define DIV_CPU_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A020<br>
+#define DIV_DDR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014<br>
+<br>
+#endif /* __ASM_MACH_LOONGSON1_REGS_CLK_H */<br>
diff --git a/arch/mips/include/asm/mach-loongson1/regs-wdt.h b/arch/mips/in=
clude/asm/mach-loongson1/regs-wdt.h<br>
new file mode 100644<br>
index 0000000..d339fe7<br>
--- /dev/null<br>
+++ b/arch/mips/include/asm/mach-loongson1/regs-wdt.h<br>
@@ -0,0 +1,22 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * Loongson1 Watchdog register definitions.<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+#ifndef __ASM_MACH_LOONGSON1_REGS_WDT_H<br>
+#define __ASM_MACH_LOONGSON1_REGS_WDT_H<br>
+<br>
+#define LS1X_WDT_REG(x) \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((void __iomem *)KSEG1ADDR(LS1X_WDT_BASE + (x=
)))<br>
+<br>
+#define LS1X_WDT_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LS1X_WDT_REG(0x=
0)<br>
+#define LS1X_WDT_SET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LS1X_WDT_REG(0x4)=
<br>
+#define LS1X_WDT_TIMER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LS1X_WDT_REG(0x8)<b=
r>
+<br>
+#endif /* __ASM_MACH_LOONGSON1_REGS_WDT_H */<br>
diff --git a/arch/mips/include/asm/mach-loongson1/war.h b/arch/mips/include=
/asm/mach-loongson1/war.h<br>
new file mode 100644<br>
index 0000000..e3680a8<br>
--- /dev/null<br>
+++ b/arch/mips/include/asm/mach-loongson1/war.h<br>
@@ -0,0 +1,25 @@<br>
+/*<br>
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic<br>
+ * License. =A0See the file &quot;COPYING&quot; in the main directory of t=
his archive<br>
+ * for more details.<br>
+ *<br>
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle &lt;<a href=3D"mailto:ra=
lf@linux-mips.org">ralf@linux-mips.org</a>&gt;<br>
+ */<br>
+#ifndef __ASM_MACH_LOONGSON1_WAR_H<br>
+#define __ASM_MACH_LOONGSON1_WAR_H<br>
+<br>
+#define R4600_V1_INDEX_ICACHEOP_WAR =A0 =A00<br>
+#define R4600_V1_HIT_CACHEOP_WAR =A0 =A0 =A0 0<br>
+#define R4600_V2_HIT_CACHEOP_WAR =A0 =A0 =A0 0<br>
+#define R5432_CP0_INTERRUPT_WAR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00<br>
+#define BCM1250_M3_WAR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0<br>
+#define SIBYTE_1956_WAR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00<b=
r>
+#define MIPS4K_ICACHE_REFILL_WAR =A0 =A0 =A0 0<br>
+#define MIPS_CACHE_SYNC_WAR =A0 =A0 =A0 =A0 =A0 =A00<br>
+#define TX49XX_ICACHE_INDEX_INV_WAR =A0 =A00<br>
+#define RM9000_CDEX_SMP_WAR =A0 =A0 =A0 =A0 =A0 =A00<br>
+#define ICACHE_REFILLS_WORKAROUND_WAR =A00<br>
+#define R10000_LLSC_WAR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00<b=
r>
+#define MIPS34K_MISSED_ITLB_WAR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00<br>
+<br>
+#endif /* __ASM_MACH_LOONGSON1_WAR_H */<br>
diff --git a/arch/mips/loongson1/common/clock.c b/arch/mips/loongson1/commo=
n/clock.c<br>
new file mode 100644<br>
index 0000000..2d98fb0<br>
--- /dev/null<br>
+++ b/arch/mips/loongson1/common/clock.c<br>
@@ -0,0 +1,165 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/list.h&gt;<br>
+#include &lt;linux/mutex.h&gt;<br>
+#include &lt;linux/clk.h&gt;<br>
+#include &lt;linux/err.h&gt;<br>
+#include &lt;asm/clock.h&gt;<br>
+#include &lt;asm/time.h&gt;<br>
+<br>
+#include &lt;loongson1.h&gt;<br>
+<br>
+static LIST_HEAD(clocks);<br>
+static DEFINE_MUTEX(clocks_mutex);<br>
+<br>
+struct clk *clk_get(struct device *dev, const char *name)<br>
+{<br>
+ =A0 =A0 =A0 struct clk *c;<br>
+ =A0 =A0 =A0 struct clk *ret =3D NULL;<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;clocks_mutex);<br>
+ =A0 =A0 =A0 list_for_each_entry(c, &amp;clocks, node) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(c-&gt;name, name)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D c;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;clocks_mutex);<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+EXPORT_SYMBOL(clk_get);<br>
+<br>
+unsigned long clk_get_rate(struct clk *clk)<br>
+{<br>
+ =A0 =A0 =A0 return clk-&gt;rate;<br>
+}<br>
+EXPORT_SYMBOL(clk_get_rate);<br>
+<br>
+static void pll_clk_init(struct clk *clk)<br>
+{<br>
+ =A0 =A0 =A0 u32 pll;<br>
+<br>
+ =A0 =A0 =A0 pll =3D __raw_readl(LS1X_CLK_PLL_FREQ);<br>
+ =A0 =A0 =A0 clk-&gt;rate =3D (12 + (pll &amp; 0x3f)) * 33 / 2<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + ((pll &gt;&gt; 8) &amp; 0x3=
ff) * 33 / 1024 / 2;<br>
+ =A0 =A0 =A0 clk-&gt;rate *=3D 1000000;<br>
+}<br>
+<br>
+static void cpu_clk_init(struct clk *clk)<br>
+{<br>
+ =A0 =A0 =A0 u32 pll, ctrl;<br>
+<br>
+ =A0 =A0 =A0 pll =3D clk_get_rate(clk-&gt;parent);<br>
+ =A0 =A0 =A0 ctrl =3D __raw_readl(LS1X_CLK_PLL_DIV) &amp; DIV_CPU;<br>
+ =A0 =A0 =A0 clk-&gt;rate =3D pll / (ctrl &gt;&gt; DIV_CPU_SHIFT);<br>
+}<br>
+<br>
+static void ddr_clk_init(struct clk *clk)<br>
+{<br>
+ =A0 =A0 =A0 u32 pll, ctrl;<br>
+<br>
+ =A0 =A0 =A0 pll =3D clk_get_rate(clk-&gt;parent);<br>
+ =A0 =A0 =A0 ctrl =3D __raw_readl(LS1X_CLK_PLL_DIV) &amp; DIV_DDR;<br>
+ =A0 =A0 =A0 clk-&gt;rate =3D pll / (ctrl &gt;&gt; DIV_DDR_SHIFT);<br>
+}<br>
+<br>
+static void dc_clk_init(struct clk *clk)<br>
+{<br>
+ =A0 =A0 =A0 u32 pll, ctrl;<br>
+<br>
+ =A0 =A0 =A0 pll =3D clk_get_rate(clk-&gt;parent);<br>
+ =A0 =A0 =A0 ctrl =3D __raw_readl(LS1X_CLK_PLL_DIV) &amp; DIV_DC;<br>
+ =A0 =A0 =A0 clk-&gt;rate =3D pll / (ctrl &gt;&gt; DIV_DC_SHIFT);<br>
+}<br>
+<br>
+static struct clk_ops pll_clk_ops =3D {<br>
+ =A0 =A0 =A0 .init =A0 =3D pll_clk_init,<br>
+};<br>
+<br>
+static struct clk_ops cpu_clk_ops =3D {<br>
+ =A0 =A0 =A0 .init =A0 =3D cpu_clk_init,<br>
+};<br>
+<br>
+static struct clk_ops ddr_clk_ops =3D {<br>
+ =A0 =A0 =A0 .init =A0 =3D ddr_clk_init,<br>
+};<br>
+<br>
+static struct clk_ops dc_clk_ops =3D {<br>
+ =A0 =A0 =A0 .init =A0 =3D dc_clk_init,<br>
+};<br>
+<br>
+static struct clk pll_clk =3D {<br>
+ =A0 =A0 =A0 .name =A0 =3D &quot;pll&quot;,<br>
+ =A0 =A0 =A0 .ops =A0 =A0=3D &amp;pll_clk_ops,<br>
+};<br>
+<br>
+static struct clk cpu_clk =3D {<br>
+ =A0 =A0 =A0 .name =A0 =3D &quot;cpu&quot;,<br>
+ =A0 =A0 =A0 .parent =3D &amp;pll_clk,<br>
+ =A0 =A0 =A0 .ops =A0 =A0=3D &amp;cpu_clk_ops,<br>
+};<br>
+<br>
+static struct clk ddr_clk =3D {<br>
+ =A0 =A0 =A0 .name =A0 =3D &quot;ddr&quot;,<br>
+ =A0 =A0 =A0 .parent =3D &amp;pll_clk,<br>
+ =A0 =A0 =A0 .ops =A0 =A0=3D &amp;ddr_clk_ops,<br>
+};<br>
+<br>
+static struct clk dc_clk =3D {<br>
+ =A0 =A0 =A0 .name =A0 =3D &quot;dc&quot;,<br>
+ =A0 =A0 =A0 .parent =3D &amp;pll_clk,<br>
+ =A0 =A0 =A0 .ops =A0 =A0=3D &amp;dc_clk_ops,<br>
+};<br>
+<br>
+int clk_register(struct clk *clk)<br>
+{<br>
+ =A0 =A0 =A0 mutex_lock(&amp;clocks_mutex);<br>
+ =A0 =A0 =A0 list_add(&amp;clk-&gt;node, &amp;clocks);<br>
+ =A0 =A0 =A0 if (clk-&gt;ops-&gt;init)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk-&gt;ops-&gt;init(clk);<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;clocks_mutex);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+EXPORT_SYMBOL(clk_register);<br>
+<br>
+static struct clk *ls1x_clks[] =3D {<br>
+ =A0 =A0 =A0 &amp;pll_clk,<br>
+ =A0 =A0 =A0 &amp;cpu_clk,<br>
+ =A0 =A0 =A0 &amp;ddr_clk,<br>
+ =A0 =A0 =A0 &amp;dc_clk,<br>
+};<br>
+<br>
+int __init ls1x_clock_init(void)<br>
+{<br>
+ =A0 =A0 =A0 int i;<br>
+<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; ARRAY_SIZE(ls1x_clks); i++)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_register(ls1x_clks[i]);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+void __init plat_time_init(void)<br>
+{<br>
+ =A0 =A0 =A0 struct clk *clk;<br>
+<br>
+ =A0 =A0 =A0 /* Initialize LS1X clocks */<br>
+ =A0 =A0 =A0 ls1x_clock_init();<br>
+<br>
+ =A0 =A0 =A0 /* setup mips r4k timer */<br>
+ =A0 =A0 =A0 clk =3D clk_get(NULL, &quot;cpu&quot;);<br>
+ =A0 =A0 =A0 if (IS_ERR(clk))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 panic(&quot;unable to get dc clock, err=3D%ld=
&quot;, PTR_ERR(clk));<br>
+<br>
+ =A0 =A0 =A0 mips_hpt_frequency =3D clk_get_rate(clk) / 2;<br>
+}<br>
diff --git a/arch/mips/loongson1/common/irq.c b/arch/mips/loongson1/common/=
irq.c<br>
new file mode 100644<br>
index 0000000..41bc8ff<br>
--- /dev/null<br>
+++ b/arch/mips/loongson1/common/irq.c<br>
@@ -0,0 +1,147 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+#include &lt;linux/interrupt.h&gt;<br>
+#include &lt;linux/irq.h&gt;<br>
+#include &lt;asm/irq_cpu.h&gt;<br>
+<br>
+#include &lt;loongson1.h&gt;<br>
+#include &lt;irq.h&gt;<br>
+<br>
+#define LS1X_INTC_REG(n, x) \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((void __iomem *)KSEG1ADDR(LS1X_INTC_BASE + (=
n * 0x18) + (x)))<br>
+<br>
+#define LS1X_INTC_INTISR(n) =A0 =A0 =A0 =A0 =A0 =A0LS1X_INTC_REG(n, 0x0)<b=
r>
+#define LS1X_INTC_INTIEN(n) =A0 =A0 =A0 =A0 =A0 =A0LS1X_INTC_REG(n, 0x4)<b=
r>
+#define LS1X_INTC_INTSET(n) =A0 =A0 =A0 =A0 =A0 =A0LS1X_INTC_REG(n, 0x8)<b=
r>
+#define LS1X_INTC_INTCLR(n) =A0 =A0 =A0 =A0 =A0 =A0LS1X_INTC_REG(n, 0xc)<b=
r>
+#define LS1X_INTC_INTPOL(n) =A0 =A0 =A0 =A0 =A0 =A0LS1X_INTC_REG(n, 0x10)<=
br>
+#define LS1X_INTC_INTEDGE(n) =A0 =A0 =A0 =A0 =A0 LS1X_INTC_REG(n, 0x14)<br=
>
+<br>
+static void ls1x_irq_ack(struct irq_data *d)<br>
+{<br>
+ =A0 =A0 =A0 unsigned int bit =3D (d-&gt;irq - LS1X_IRQ_BASE) &amp; 0x1f;<=
br>
+ =A0 =A0 =A0 unsigned int n =3D (d-&gt;irq - LS1X_IRQ_BASE) &gt;&gt; 5;<br=
>
+<br>
+ =A0 =A0 =A0 __raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (1 &lt;&lt; bit), LS1X_INTC=
_INTCLR(n));<br>
+}<br>
+<br>
+static void ls1x_irq_mask(struct irq_data *d)<br>
+{<br>
+ =A0 =A0 =A0 unsigned int bit =3D (d-&gt;irq - LS1X_IRQ_BASE) &amp; 0x1f;<=
br>
+ =A0 =A0 =A0 unsigned int n =3D (d-&gt;irq - LS1X_IRQ_BASE) &gt;&gt; 5;<br=
>
+<br>
+ =A0 =A0 =A0 __raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp; ~(1 &lt;&lt; bit), LS1X=
_INTC_INTIEN(n));<br>
+}<br>
+<br>
+static void ls1x_irq_mask_ack(struct irq_data *d)<br>
+{<br>
+ =A0 =A0 =A0 unsigned int bit =3D (d-&gt;irq - LS1X_IRQ_BASE) &amp; 0x1f;<=
br>
+ =A0 =A0 =A0 unsigned int n =3D (d-&gt;irq - LS1X_IRQ_BASE) &gt;&gt; 5;<br=
>
+<br>
+ =A0 =A0 =A0 __raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp; ~(1 &lt;&lt; bit), LS1X=
_INTC_INTIEN(n));<br>
+ =A0 =A0 =A0 __raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (1 &lt;&lt; bit), LS1X_INTC=
_INTCLR(n));<br>
+}<br>
+<br>
+static void ls1x_irq_unmask(struct irq_data *d)<br>
+{<br>
+ =A0 =A0 =A0 unsigned int bit =3D (d-&gt;irq - LS1X_IRQ_BASE) &amp; 0x1f;<=
br>
+ =A0 =A0 =A0 unsigned int n =3D (d-&gt;irq - LS1X_IRQ_BASE) &gt;&gt; 5;<br=
>
+<br>
+ =A0 =A0 =A0 __raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (1 &lt;&lt; bit), LS1X_INTC=
_INTIEN(n));<br>
+}<br>
+<br>
+static struct irq_chip ls1x_irq_chip =3D {<br>
+ =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;LS1X-INTC&quot;,<br>
+ =A0 =A0 =A0 .irq_ack =A0 =A0 =A0 =A0=3D ls1x_irq_ack,<br>
+ =A0 =A0 =A0 .irq_mask =A0 =A0 =A0 =3D ls1x_irq_mask,<br>
+ =A0 =A0 =A0 .irq_mask_ack =A0 =3D ls1x_irq_mask_ack,<br>
+ =A0 =A0 =A0 .irq_unmask =A0 =A0 =3D ls1x_irq_unmask,<br>
+};<br>
+<br>
+static void ls1x_irq_dispatch(int n)<br>
+{<br>
+ =A0 =A0 =A0 u32 int_status, irq;<br>
+<br>
+ =A0 =A0 =A0 /* Get pending sources, masked by current enables */<br>
+ =A0 =A0 =A0 int_status =3D __raw_readl(LS1X_INTC_INTISR(n)) &amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(LS1X_INTC_INTIEN(=
n));<br>
+<br>
+ =A0 =A0 =A0 if (int_status) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D LS1X_IRQ(n, __ffs(int_status));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_IRQ(irq);<br>
+ =A0 =A0 =A0 }<br>
+}<br>
+<br>
+asmlinkage void plat_irq_dispatch(void)<br>
+{<br>
+ =A0 =A0 =A0 unsigned int pending;<br>
+<br>
+ =A0 =A0 =A0 pending =3D read_c0_cause() &amp; read_c0_status() &amp; ST0_=
IM;<br>
+<br>
+ =A0 =A0 =A0 if (pending &amp; CAUSEF_IP7)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_IRQ(TIMER_IRQ);<br>
+ =A0 =A0 =A0 else if (pending &amp; CAUSEF_IP2)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ls1x_irq_dispatch(0); /* INT0 */<br>
+ =A0 =A0 =A0 else if (pending &amp; CAUSEF_IP3)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ls1x_irq_dispatch(1); /* INT1 */<br>
+ =A0 =A0 =A0 else if (pending &amp; CAUSEF_IP4)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ls1x_irq_dispatch(2); /* INT2 */<br>
+ =A0 =A0 =A0 else if (pending &amp; CAUSEF_IP5)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ls1x_irq_dispatch(3); /* INT3 */<br>
+ =A0 =A0 =A0 else if (pending &amp; CAUSEF_IP6)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ls1x_irq_dispatch(4); /* INT4 */<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spurious_interrupt();<br>
+<br>
+}<br>
+<br>
+struct irqaction cascade_irqaction =3D {<br>
+ =A0 =A0 =A0 .handler =3D no_action,<br>
+ =A0 =A0 =A0 .name =3D &quot;cascade&quot;,<br>
+ =A0 =A0 =A0 .flags =3D IRQF_NO_THREAD,<br>
+};<br>
+<br>
+static void __init ls1x_irq_init(int base)<br>
+{<br>
+ =A0 =A0 =A0 int n;<br>
+<br>
+ =A0 =A0 =A0 /* Disable interrupts and clear pending,<br>
+ =A0 =A0 =A0 =A0* setup all IRQs as high level triggered<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 for (n =3D 0; n &lt; 4; n++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0x0, LS1X_INTC_INTIEN(n));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0xffffffff, LS1X_INTC_INTCLR(n))=
;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0xffffffff, LS1X_INTC_INTPOL(n))=
;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set DMA0, DMA1 and DMA2 to edge trigger */=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(n ? 0x0 : 0xe000, LS1X_INTC_INTE=
DGE(n));<br>
+ =A0 =A0 =A0 }<br>
+<br>
+<br>
+ =A0 =A0 =A0 for (n =3D base; n &lt; LS1X_IRQS; n++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_set_chip_and_handler(n, &amp;ls1x_irq_chi=
p,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0handle_level_irq);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 setup_irq(INT0_IRQ, &amp;cascade_irqaction);<br>
+ =A0 =A0 =A0 setup_irq(INT1_IRQ, &amp;cascade_irqaction);<br>
+ =A0 =A0 =A0 setup_irq(INT2_IRQ, &amp;cascade_irqaction);<br>
+ =A0 =A0 =A0 setup_irq(INT3_IRQ, &amp;cascade_irqaction);<br>
+}<br>
+<br>
+void __init arch_init_irq(void)<br>
+{<br>
+ =A0 =A0 =A0 mips_cpu_irq_init();<br>
+ =A0 =A0 =A0 ls1x_irq_init(LS1X_IRQ_BASE);<br>
+}<br>
diff --git a/arch/mips/loongson1/common/platform.c b/arch/mips/loongson1/co=
mmon/platform.c<br>
new file mode 100644<br>
index 0000000..e92d59c<br>
--- /dev/null<br>
+++ b/arch/mips/loongson1/common/platform.c<br>
@@ -0,0 +1,124 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+#include &lt;linux/clk.h&gt;<br>
+#include &lt;linux/dma-mapping.h&gt;<br>
+#include &lt;linux/err.h&gt;<br>
+#include &lt;linux/phy.h&gt;<br>
+#include &lt;linux/serial_8250.h&gt;<br>
+#include &lt;linux/stmmac.h&gt;<br>
+#include &lt;asm-generic/sizes.h&gt;<br>
+<br>
+#include &lt;loongson1.h&gt;<br>
+<br>
+#define LS1X_UART(_id) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mapbase =A0 =A0 =A0 =A0=3D LS1X_UART ## _id =
## _BASE, =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .irq =A0 =A0 =A0 =A0 =A0 =A0=3D LS1X_UART ## =
_id ## _IRQ, =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .iotype =A0 =A0 =A0 =A0 =3D UPIO_MEM, =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_IOREMAP | U=
PF_FIXED_TYPE, \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D PORT_16550A, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 }<br>
+<br>
+static struct plat_serial8250_port ls1x_serial8250_port[] =3D {<br>
+ =A0 =A0 =A0 LS1X_UART(0),<br>
+ =A0 =A0 =A0 LS1X_UART(1),<br>
+ =A0 =A0 =A0 LS1X_UART(2),<br>
+ =A0 =A0 =A0 LS1X_UART(3),<br>
+ =A0 =A0 =A0 {},<br>
+};<br>
+<br>
+struct platform_device ls1x_uart_device =3D {<br>
+ =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;serial8250&quot;,<br>
+ =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D PLAT8250_DEV_PLATFORM,<br>
+ =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D ls1x_serial8250_port,<br>
+ =A0 =A0 =A0 },<br>
+};<br>
+<br>
+void __init ls1x_serial_setup(void)<br>
+{<br>
+ =A0 =A0 =A0 struct clk *clk;<br>
+ =A0 =A0 =A0 struct plat_serial8250_port *p;<br>
+<br>
+ =A0 =A0 =A0 clk =3D clk_get(NULL, &quot;dc&quot;);<br>
+ =A0 =A0 =A0 if (IS_ERR(clk))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 panic(&quot;unable to get dc clock, err=3D%ld=
&quot;, PTR_ERR(clk));<br>
+<br>
+ =A0 =A0 =A0 for (p =3D ls1x_serial8250_port; p-&gt;flags !=3D 0; ++p)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 p-&gt;uartclk =3D clk_get_rate(clk);<br>
+}<br>
+<br>
+/* Synopsys Ethernet GMAC */<br>
+static struct resource ls1x_eth0_resources[] =3D {<br>
+ =A0 =A0 =A0 [0] =3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D LS1X_GMAC0_BASE,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D LS1X_GMAC0_BASE + SZ_64K - 1,=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,<br>
+ =A0 =A0 =A0 },<br>
+ =A0 =A0 =A0 [1] =3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D &quot;macirq&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D LS1X_GMAC0_IRQ,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,<br>
+ =A0 =A0 =A0 },<br>
+};<br>
+<br>
+static struct stmmac_mdio_bus_data ls1x_mdio_bus_data =3D {<br>
+ =A0 =A0 =A0 .bus_id =A0 =A0 =A0 =A0 =3D 0,<br>
+ =A0 =A0 =A0 .phy_mask =A0 =A0 =A0 =3D 0,<br>
+};<br>
+<br>
+static struct plat_stmmacenet_data ls1x_eth_data =3D {<br>
+ =A0 =A0 =A0 .bus_id =A0 =A0 =A0 =A0 =3D 0,<br>
+ =A0 =A0 =A0 .phy_addr =A0 =A0 =A0 =3D -1,<br>
+ =A0 =A0 =A0 .mdio_bus_data =A0=3D &amp;ls1x_mdio_bus_data,<br>
+ =A0 =A0 =A0 .has_gmac =A0 =A0 =A0 =3D 1,<br>
+ =A0 =A0 =A0 .tx_coe =A0 =A0 =A0 =A0 =3D 1,<br>
+};<br>
+<br>
+struct platform_device ls1x_eth0_device =3D {<br>
+ =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;stmmaceth&quot;,<br>
+ =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,<br>
+ =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(ls1x_eth0_resources),<br>
+ =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D ls1x_eth0_resources,<br>
+ =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &amp;ls1x_eth_data,<br>
+ =A0 =A0 =A0 },<br>
+};<br>
+<br>
+/* USB EHCI */<br>
+static u64 ls1x_ehci_dmamask =3D DMA_BIT_MASK(32);<br>
+<br>
+static struct resource ls1x_ehci_resources[] =3D {<br>
+ =A0 =A0 =A0 [0] =3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D LS1X_EHCI_BASE,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D LS1X_EHCI_BASE + SZ_32K - 1,<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,<br>
+ =A0 =A0 =A0 },<br>
+ =A0 =A0 =A0 [1] =3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D LS1X_EHCI_IRQ,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,<br>
+ =A0 =A0 =A0 },<br>
+};<br>
+<br>
+struct platform_device ls1x_ehci_device =3D {<br>
+ =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;ls1x-ehci&quot;,<br>
+ =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,<br>
+ =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(ls1x_ehci_resources),<br>
+ =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D ls1x_ehci_resources,<br>
+ =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .dma_mask =3D &amp;ls1x_ehci_dmamask,<br>
+ =A0 =A0 =A0 },<br>
+};<br>
+<br>
+/* Real Time Clock */<br>
+struct platform_device ls1x_rtc_device =3D {<br>
+ =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;ls1x-rtc&quot;,<br>
+ =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,<br>
+};<br>
diff --git a/arch/mips/loongson1/common/prom.c b/arch/mips/loongson1/common=
/prom.c<br>
new file mode 100644<br>
index 0000000..1f8e49f<br>
--- /dev/null<br>
+++ b/arch/mips/loongson1/common/prom.c<br>
@@ -0,0 +1,87 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * Modified from arch/mips/pnx833x/common/prom.c.<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+#include &lt;linux/serial_reg.h&gt;<br>
+#include &lt;asm/bootinfo.h&gt;<br>
+<br>
+#include &lt;loongson1.h&gt;<br>
+#include &lt;prom.h&gt;<br>
+<br>
+int prom_argc;<br>
+char **prom_argv, **prom_envp;<br>
+unsigned long memsize, highmemsize;<br>
+<br>
+char *prom_getenv(char *envname)<br>
+{<br>
+ =A0 =A0 =A0 char **env =3D prom_envp;<br>
+ =A0 =A0 =A0 int i;<br>
+<br>
+ =A0 =A0 =A0 i =3D strlen(envname);<br>
+<br>
+ =A0 =A0 =A0 while (*env) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strncmp(envname, *env, i) =3D=3D 0 &amp;&=
amp; *(*env+i) =3D=3D &#39;=3D&#39;)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return *env + i + 1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 env++;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static inline unsigned long env_or_default(char *env, unsigned long dfl)<b=
r>
+{<br>
+ =A0 =A0 =A0 char *str =3D prom_getenv(env);<br>
+ =A0 =A0 =A0 return str ? simple_strtol(str, 0, 0) : dfl;<br>
+}<br>
+<br>
+void __init prom_init_cmdline(void)<br>
+{<br>
+ =A0 =A0 =A0 char *c =3D &amp;(arcs_cmdline[0]);<br>
+ =A0 =A0 =A0 int i;<br>
+<br>
+ =A0 =A0 =A0 for (i =3D 1; i &lt; prom_argc; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(c, prom_argv[i]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 c +=3D strlen(prom_argv[i]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i &lt; prom_argc-1)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *c++ =3D &#39; &#39;;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 *c =3D 0;<br>
+}<br>
+<br>
+void __init prom_init(void)<br>
+{<br>
+ =A0 =A0 =A0 prom_argc =3D fw_arg0;<br>
+ =A0 =A0 =A0 prom_argv =3D (char **)fw_arg1;<br>
+ =A0 =A0 =A0 prom_envp =3D (char **)fw_arg2;<br>
+<br>
+ =A0 =A0 =A0 prom_init_cmdline();<br>
+<br>
+ =A0 =A0 =A0 memsize =3D env_or_default(&quot;memsize&quot;, DEFAULT_MEMSI=
ZE);<br>
+ =A0 =A0 =A0 highmemsize =3D env_or_default(&quot;highmemsize&quot;, 0x0);=
<br>
+}<br>
+<br>
+void __init prom_free_prom_memory(void)<br>
+{<br>
+}<br>
+<br>
+#define PORT(offset) =A0 (u8 *)(KSEG1ADDR(LS1X_UART0_BASE + offset))<br>
+<br>
+void __init prom_putchar(char c)<br>
+{<br>
+ =A0 =A0 =A0 int timeout;<br>
+<br>
+ =A0 =A0 =A0 timeout =3D 1024;<br>
+<br>
+ =A0 =A0 =A0 while (((readb(PORT(UART_LSR)) &amp; UART_LSR_THRE) =3D=3D 0)=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;&amp; (timeout-- &gt; 0)=
)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;<br>
+<br>
+ =A0 =A0 =A0 writeb(c, PORT(UART_TX));<br>
+}<br>
diff --git a/arch/mips/loongson1/common/reset.c b/arch/mips/loongson1/commo=
n/reset.c<br>
new file mode 100644<br>
index 0000000..fb979a7<br>
--- /dev/null<br>
+++ b/arch/mips/loongson1/common/reset.c<br>
@@ -0,0 +1,45 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+#include &lt;linux/io.h&gt;<br>
+#include &lt;linux/pm.h&gt;<br>
+#include &lt;asm/reboot.h&gt;<br>
+<br>
+#include &lt;loongson1.h&gt;<br>
+<br>
+static void ls1x_restart(char *command)<br>
+{<br>
+ =A0 =A0 =A0 __raw_writel(0x1, LS1X_WDT_EN);<br>
+ =A0 =A0 =A0 __raw_writel(0x5000000, LS1X_WDT_TIMER);<br>
+ =A0 =A0 =A0 __raw_writel(0x1, LS1X_WDT_SET);<br>
+}<br>
+<br>
+static void ls1x_halt(void)<br>
+{<br>
+ =A0 =A0 =A0 while (1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_wait)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_wait();<br>
+ =A0 =A0 =A0 }<br>
+}<br>
+<br>
+static void ls1x_power_off(void)<br>
+{<br>
+ =A0 =A0 =A0 ls1x_halt();<br>
+}<br>
+<br>
+static int __init ls1x_reboot_setup(void)<br>
+{<br>
+ =A0 =A0 =A0 _machine_restart =3D ls1x_restart;<br>
+ =A0 =A0 =A0 _machine_halt =3D ls1x_halt;<br>
+ =A0 =A0 =A0 pm_power_off =3D ls1x_power_off;<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+arch_initcall(ls1x_reboot_setup);<br>
diff --git a/arch/mips/loongson1/common/setup.c b/arch/mips/loongson1/commo=
n/setup.c<br>
new file mode 100644<br>
index 0000000..62128cc<br>
--- /dev/null<br>
+++ b/arch/mips/loongson1/common/setup.c<br>
@@ -0,0 +1,29 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+#include &lt;asm/bootinfo.h&gt;<br>
+<br>
+#include &lt;prom.h&gt;<br>
+<br>
+void __init plat_mem_setup(void)<br>
+{<br>
+ =A0 =A0 =A0 add_memory_region(0x0, (memsize &lt;&lt; 20), BOOT_MEM_RAM);<=
br>
+}<br>
+<br>
+const char *get_system_type(void)<br>
+{<br>
+ =A0 =A0 =A0 unsigned int processor_id =3D (&amp;current_cpu_data)-&gt;pro=
cessor_id;<br>
+<br>
+ =A0 =A0 =A0 switch (processor_id &amp; PRID_REV_MASK) {<br>
+ =A0 =A0 =A0 case PRID_REV_LOONGSON1B:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &quot;LOONGSON LS1B&quot;;<br>
+ =A0 =A0 =A0 default:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &quot;LOONGSON (unknown)&quot;;<br>
+ =A0 =A0 =A0 }<br>
+}<br>
diff --git a/arch/mips/loongson1/ls1b/board.c b/arch/mips/loongson1/ls1b/bo=
ard.c<br>
new file mode 100644<br>
index 0000000..295b1be<br>
--- /dev/null<br>
+++ b/arch/mips/loongson1/ls1b/board.c<br>
@@ -0,0 +1,33 @@<br>
+/*<br>
+ * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zhang@g=
mail.com">keguang.zhang@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute =A0it and/or modify=
 it<br>
+ * under =A0the terms of =A0the GNU General =A0Public License as published=
 by the<br>
+ * Free Software Foundation; =A0either version 2 of the =A0License, or (at=
 your<br>
+ * option) any later version.<br>
+ */<br>
+<br>
+#include &lt;platform.h&gt;<br>
+<br>
+#include &lt;linux/serial_8250.h&gt;<br>
+#include &lt;loongson1.h&gt;<br>
+<br>
+static struct platform_device *ls1b_platform_devices[] __initdata =3D {<br=
>
+ =A0 =A0 =A0 &amp;ls1x_uart_device,<br>
+ =A0 =A0 =A0 &amp;ls1x_eth0_device,<br>
+ =A0 =A0 =A0 &amp;ls1x_ehci_device,<br>
+ =A0 =A0 =A0 &amp;ls1x_rtc_device,<br>
+};<br>
+<br>
+static int __init ls1b_platform_init(void)<br>
+{<br>
+ =A0 =A0 =A0 int err;<br>
+<br>
+ =A0 =A0 =A0 ls1x_serial_setup();<br>
+<br>
+ =A0 =A0 =A0 err =3D platform_add_devices(ls1b_platform_devices,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_=
SIZE(ls1b_platform_devices));<br>
+ =A0 =A0 =A0 return err;<br>
+}<br>
+<br>
+arch_initcall(ls1b_platform_init);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Best Rega=
rds!<br>Kelvin<br><br><img src=3D"http://ubuntucounter.geekosophical.net/im=
g/ubuntu-blogger.php?user=3D26540"><br><br><div style id=3D"apBreakEnd" cla=
ss=3D"autoPagerS">

</div>

--20cf307f309614995004c594f6b6--
