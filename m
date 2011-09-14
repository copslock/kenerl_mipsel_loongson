Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 16:12:19 +0200 (CEST)
Received: from mail-gx0-f169.google.com ([209.85.161.169]:59989 "EHLO
        mail-gx0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491127Ab1INOMN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Sep 2011 16:12:13 +0200
Received: by gxk3 with SMTP id 3so1920006gxk.28
        for <multiple recipients>; Wed, 14 Sep 2011 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fgT7NMt+ksYj17kGtQtou94gyTObEqeiD3l49RNmnCY=;
        b=BqQXaqkjz9SMOxN578dLkRR6KliWdZdOpHbvrBJIMDNCH4CF8HNw1fECZcg/mMs4Dw
         r2zLNGxVj/9b92ZBg+lWO07H+r6mfdXsQHB2fGnuHEr8HD/Ucp4CKNbyIjsmZVTpVOxW
         JPWKtnVAbAwDuPTNQVN4IMCMLGGFPgI0MMxis=
MIME-Version: 1.0
Received: by 10.52.76.68 with SMTP id i4mr2461516vdw.213.1316009526591; Wed,
 14 Sep 2011 07:12:06 -0700 (PDT)
Received: by 10.220.84.82 with HTTP; Wed, 14 Sep 2011 07:12:06 -0700 (PDT)
In-Reply-To: <4E70955D.8050106@metafoo.de>
References: <1315997270-14332-1-git-send-email-keguang.zhang@gmail.com>
        <4E70955D.8050106@metafoo.de>
Date:   Wed, 14 Sep 2011 22:12:06 +0800
Message-ID: <CAJhJPsV1sKOSbpn3bQa2FCTM+rm8LeuMEt5SkqXscV8xmZcr+g@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add basic support for Loongson1B
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, wuzhangjin@gmail.com, r0bertz@gentoo.org,
        chenj@lemote.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7152

2011/9/14, Lars-Peter Clausen <lars@metafoo.de>:
> On 09/14/2011 12:47 PM, keguang.zhang@gmail.com wrote:
>> From: Zhang, Keguang <keguang.zhang@gmail.com>
>>
>> This patch adds basic support for Loongson1B
>> including serial, timer and interrupt handler.
>>
>> Loongson 1B is a 32-bit SoC designed by Institute of
>> Computing Technology (ICT), Chinese Academy of Sciences (CAS),
>> which implements the MIPS32 release 2 instruction set.
>>
>> Signed-off-by: Zhang, Keguang <keguang.zhang@gmail.com>
>> ---
>>
>> [...
>> diff --git a/arch/mips/include/asm/mach-loongson1/regs-clk.h
>> b/arch/mips/include/asm/mach-loongson1/regs-clk.h
>> new file mode 100644
>> index 0000000..acffd4f
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-loongson1/regs-clk.h
>> @@ -0,0 +1,32 @@
>> +/*
>> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
>> + *
>> + * Loongson1 Clock Register Definitions.
>> + *
>> + * This program is free software; you can redistribute  it and/or modify
>> it
>> + * under  the terms of  the GNU General  Public License as published by
>> the
>> + * Free Software Foundation;  either version 2 of the  License, or (at
>> your
>> + * option) any later version.
>> + */
>> +
>> +#ifndef __ASM_MACH_LOONGSON1_REGS_CLK_H
>> +#define __ASM_MACH_LOONGSON1_REGS_CLK_H
>> +
>> +#define LOONGSON1_CLK_REG(x)		((void __iomem *)(LOONGSON1_CLK_BASE +
>> (x)))
>> +
>> +#define	CLK_PLL_FREQ			LOONGSON1_CLK_REG(0x0)
>> +#define	CLK_PLL_DIV			LOONGSON1_CLK_REG(0x4)
>> +
>> +/* Clock PLL Divisor Register Bits */
>> +#define	DIV_DC_EN			(0x1 << 31)
>> +#define DIV_DC				(0x1f << 26)
>> +#define	DIV_CPU_EN			(0x1 << 25)
>> +#define DIV_CPU				(0x1f << 20)
>> +#define	DIV_DDR_EN			(0x1 << 19)
>> +#define DIV_DDR				(0x1f << 14)
>> +
>> +#define	DIV_DC_SHIFT			(26)
>> +#define	DIV_CPU_SHIFT			(20)
>> +#define	DIV_DDR_SHIFT			(14)
>> +
>
> In my opinion these defines should be namespaced, same goes for the other
> register definitions.

I will take care about this.

>> +#endif /* __ASM_MACH_LOONGSON1_REGS_CLK_H */
>> [...]
>> diff --git a/arch/mips/loongson1/Platform b/arch/mips/loongson1/Platform
>> new file mode 100644
>> index 0000000..92804c6
>> --- /dev/null
>> +++ b/arch/mips/loongson1/Platform
>> @@ -0,0 +1,7 @@
>> +cflags-$(CONFIG_CPU_LOONGSON1)  += \
>> +	$(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA
>> -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
>> +	-Wa,-mips32r2 -Wa,--trap
>> +
>> +platform-$(CONFIG_MACH_LOONGSON1)	+= loongson1/
>> +cflags-$(CONFIG_MACH_LOONGSON1)		+=
>> -I$(srctree)/arch/mips/include/asm/mach-loongson1
>> +load-$(CONFIG_LOONGSON1_LS1B)		+= 0xffffffff80010000
>> diff --git a/arch/mips/loongson1/common/Makefile
>> b/arch/mips/loongson1/common/Makefile
>> new file mode 100644
>> index 0000000..b279770
>> --- /dev/null
>> +++ b/arch/mips/loongson1/common/Makefile
>> @@ -0,0 +1,5 @@
>> +#
>> +# Makefile for common code of loongson1 based machines.
>> +#
>> +
>> +obj-y	+= clock.o irq.o platform.o prom.o reset.o setup.o
>> diff --git a/arch/mips/loongson1/common/clock.c
>> b/arch/mips/loongson1/common/clock.c
>> new file mode 100644
>> index 0000000..e854953
>> --- /dev/null
>> +++ b/arch/mips/loongson1/common/clock.c
>> @@ -0,0 +1,164 @@
>> +/*
>> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
>> + *
>> + * This program is free software; you can redistribute  it and/or modify
>> it
>> + * under  the terms of  the GNU General  Public License as published by
>> the
>> + * Free Software Foundation;  either version 2 of the  License, or (at
>> your
>> + * option) any later version.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/list.h>
>> +#include <linux/mutex.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <asm/clock.h>
>> +#include <asm/time.h>
>> +
>> +#include <loongson1.h>
>> +
>> +static LIST_HEAD(clocks);
>> +static DEFINE_MUTEX(clocks_mutex);
>> +
>> +struct clk *clk_get(struct device *dev, const char *name)
>> +{
>> +	struct clk *c;
>> +	struct clk *ret = NULL;
>> +
>> +	mutex_lock(&clocks_mutex);
>> +	list_for_each_entry(c, &clocks, node) {
>> +		if (!strcmp(c->name, name)) {
>> +			ret = c;
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&clocks_mutex);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(clk_get);
>> +
>> +unsigned long clk_get_rate(struct clk *clk)
>> +{
>> +	return clk->rate;
>> +}
>> +EXPORT_SYMBOL(clk_get_rate);
>> +
>
> Maybe use the generic clkdev implementation.
>
>> [...]
>> diff --git a/arch/mips/loongson1/common/irq.c
>> b/arch/mips/loongson1/common/irq.c
>> new file mode 100644
>> index 0000000..8a7287f
>> --- /dev/null
>> +++ b/arch/mips/loongson1/common/irq.c
>> @@ -0,0 +1,132 @@
>> +/*
>> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
>> + *
>> + * Based on Copyright (C) 2009 Lemote Inc.
>> + *
>> + * This program is free software; you can redistribute  it and/or modify
>> it
>> + * under  the terms of  the GNU General  Public License as published by
>> the
>> + * Free Software Foundation;  either version 2 of the  License, or (at
>> your
>> + * option) any later version.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <asm/irq_cpu.h>
>> +
>> +#include <loongson1.h>
>> +#include <irq.h>
>> +
>> +static void loongson1_irq_ack(struct irq_data *d)
>> +{
>> +	unsigned int bit = (d->irq - LOONGSON1_IRQ_BASE) & 0x1f;
>> +	unsigned int n = (d->irq - LOONGSON1_IRQ_BASE) >> 5;
>> +
>> +	__raw_writel(__raw_readl(INTC_INTCLR(n)) | (1 << bit), INTC_INTCLR(n));
>> +}
>> +
>> +static void loongson1_irq_mask(struct irq_data *d)
>> +{
>> +	unsigned int bit = (d->irq - LOONGSON1_IRQ_BASE) & 0x1f;
>> +	unsigned int n = (d->irq - LOONGSON1_IRQ_BASE) >> 5;
>> +
>> +	__raw_writel(__raw_readl(INTC_INTIEN(n)) & ~(1 << bit), INTC_INTIEN(n));
>> +}
>> +
>> +static void loongson1_irq_mask_ack(struct irq_data *d)
>> +{
>> +	unsigned int bit = (d->irq - LOONGSON1_IRQ_BASE) & 0x1f;
>> +	unsigned int n = (d->irq - LOONGSON1_IRQ_BASE) >> 5;
>> +
>> +	__raw_writel(__raw_readl(INTC_INTIEN(n)) & ~(1 << bit), INTC_INTIEN(n));
>> +	__raw_writel(__raw_readl(INTC_INTCLR(n)) | (1 << bit), INTC_INTCLR(n));
>> +}
>> +
>> +static void loongson1_irq_unmask(struct irq_data *d)
>> +{
>> +	unsigned int bit = (d->irq - LOONGSON1_IRQ_BASE) & 0x1f;
>> +	unsigned int n = (d->irq - LOONGSON1_IRQ_BASE) >> 5;
>> +
>> +	__raw_writel(__raw_readl(INTC_INTIEN(n)) | (1 << bit), INTC_INTIEN(n));
>> +}
>> +
>> +static struct irq_chip loongson1_irq_chip = {
>> +	.name		= "LOONGSON1-INTC",
>> +	.irq_ack	= loongson1_irq_ack,
>> +	.irq_mask	= loongson1_irq_mask,
>> +	.irq_mask_ack	= loongson1_irq_mask_ack,
>> +	.irq_unmask	= loongson1_irq_unmask,
>> +};
>
> looks like a perfect candidate for irq_chip_generic.
>

Thanks for your response.

-- 
Best Regards!
Kelvin
