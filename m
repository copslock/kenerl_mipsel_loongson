Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 16:36:06 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:60158 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492038Ab0FCOgA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 16:36:00 +0200
Received: by wyj26 with SMTP id 26so108801wyj.36
        for <multiple recipients>; Thu, 03 Jun 2010 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=0omDyI/zfEkqGS7Wm1gpCz2yex2DEMTN38GfVUrOsr4=;
        b=YOuEkB/YI8eZBEims7miI5Q+xZOBEIUvZ9Vzx8MyI8zGvUUmfitlLQS5AFQ911gK6X
         j9ZCV2aw/sBbCShZk9W51KxlCBtKmynb3VdId0AYg47zbWY53Xa2B3Zocy8xNW8usPZj
         bkqDaXvPnOqdH/709zy18CqnMLPzfMrubwGCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=HBZdnHZ7xv8VMdA6exCELrEcFN3ZqXfrDdHDgV1J4qabj89sEwKBC1taMyADHBw8Kp
         d7eGww4zPbQGp5D6kMPtzr9DiXB8oY6Z38ObJwHhXezYClJi2OZlz0k6x2FHXsfr4//O
         O9c/j7tchrgsDGr24DFlPPVn/Haf97oOSA2V8=
Received: by 10.227.141.201 with SMTP id n9mr9686892wbu.31.1275575435563;
        Thu, 03 Jun 2010 07:30:35 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id t70sm87082weq.14.2010.06.03.07.30.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 07:30:35 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [RFC][PATCH 02/26] MIPS: jz4740: Add IRQ handler code
Date:   Thu, 3 Jun 2010 16:29:26 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.32-22-server; KDE/4.4.2; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de> <1275505397-16758-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1275505397-16758-3-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201006031629.26424.florian@openwrt.org>
X-archive-position: 27051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2445

On Wednesday 02 June 2010 21:02:53 Lars-Peter Clausen wrote:
> This patch adds support for IRQ handling on a JZ4740 SoC.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/mips/include/asm/mach-jz4740/irq.h |   55 ++++++++++
>  arch/mips/jz4740/irq.c                  |  170
> +++++++++++++++++++++++++++++++ arch/mips/jz4740/irq.h                  | 
>  21 ++++
>  3 files changed, 246 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-jz4740/irq.h
>  create mode 100644 arch/mips/jz4740/irq.c
>  create mode 100644 arch/mips/jz4740/irq.h
> 
> diff --git a/arch/mips/include/asm/mach-jz4740/irq.h
> b/arch/mips/include/asm/mach-jz4740/irq.h new file mode 100644
> index 0000000..5e27b78
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-jz4740/irq.h
> @@ -0,0 +1,55 @@
> +/*
> + *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
> + *  JZ7420/JZ4740 IRQ definitions
> + *
> + *  This program is free software; you can redistribute	 it and/or modify
> it + *  under  the terms of	 the GNU General  Public License as 
published
> by the + *  Free Software Foundation;  either version 2 of the	License, 
or
> (at your + *  option) any later version.
> + *
> + *  You should have received a copy of the  GNU General Public License
> along + *  with this program; if not, write  to the Free Software
> Foundation, Inc., + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#ifndef __ASM_MACH_JZ4740_IRQ_H__
> +#define __ASM_MACH_JZ4740_IRQ_H__
> +
> +#define MIPS_CPU_IRQ_BASE 0
> +#define JZ4740_IRQ_BASE 8
> +
> +/* 1st-level interrupts */
> +#define JZ4740_IRQ(x)	(JZ4740_IRQ_BASE + (x))
> +#define JZ4740_IRQ_I2C	JZ4740_IRQ(1)
> +#define JZ4740_IRQ_UHC	JZ4740_IRQ(3)
> +#define JZ4740_IRQ_UART1	JZ4740_IRQ(8)
> +#define JZ4740_IRQ_UART0	JZ4740_IRQ(9)
> +#define JZ4740_IRQ_SADC	JZ4740_IRQ(12)
> +#define JZ4740_IRQ_MSC	JZ4740_IRQ(14)
> +#define JZ4740_IRQ_RTC	JZ4740_IRQ(15)
> +#define JZ4740_IRQ_SSI	JZ4740_IRQ(16)
> +#define JZ4740_IRQ_CIM	JZ4740_IRQ(17)
> +#define JZ4740_IRQ_AIC	JZ4740_IRQ(18)
> +#define JZ4740_IRQ_ETH	JZ4740_IRQ(19)
> +#define JZ4740_IRQ_DMAC	JZ4740_IRQ(20)
> +#define JZ4740_IRQ_TCU2	JZ4740_IRQ(21)
> +#define JZ4740_IRQ_TCU1	JZ4740_IRQ(22)
> +#define JZ4740_IRQ_TCU0	JZ4740_IRQ(23)
> +#define JZ4740_IRQ_UDC	JZ4740_IRQ(24)
> +#define JZ4740_IRQ_GPIO3	JZ4740_IRQ(25)
> +#define JZ4740_IRQ_GPIO2	JZ4740_IRQ(26)
> +#define JZ4740_IRQ_GPIO1	JZ4740_IRQ(27)
> +#define JZ4740_IRQ_GPIO0	JZ4740_IRQ(28)
> +#define JZ4740_IRQ_IPU	JZ4740_IRQ(29)
> +#define JZ4740_IRQ_LCD	JZ4740_IRQ(30)
> +
> +/* 2nd-level interrupts */
> +#define JZ4740_IRQ_DMA(x)	((x) + JZ4740_IRQ(32))
> +
> +#define JZ4740_IRQ_INTC_GPIO(x)	(JZ4740_IRQ_GPIO0 - (x))
> +#define JZ4740_IRQ_GPIO(x)		(JZ4740_IRQ(48) + (x))
> +
> +#define NR_IRQS (JZ4740_IRQ_GPIO(127) + 1)
> +
> +#endif
> diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
> new file mode 100644
> index 0000000..46a03ee
> --- /dev/null
> +++ b/arch/mips/jz4740/irq.c
> @@ -0,0 +1,170 @@
> +/*
> + *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
> + *  JZ4740 platform IRQ support
> + *
> + *  This program is free software; you can redistribute	 it and/or modify
> it + *  under  the terms of	 the GNU General  Public License as 
published
> by the + *  Free Software Foundation;  either version 2 of the	License, 
or
> (at your + *  option) any later version.
> + *
> + *  You should have received a copy of the  GNU General Public License
> along + *  with this program; if not, write  to the Free Software
> Foundation, Inc., + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/timex.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/io.h>
> +#include <asm/mipsregs.h>
> +#include <asm/irq_cpu.h>
> +
> +#include <asm/mach-jz4740/base.h>
> +
> +static void __iomem *jz_intc_base;
> +static uint32_t jz_intc_wakeup;
> +static uint32_t jz_intc_saved;
> +
> +#define JZ_REG_INTC_STATUS	0x00
> +#define JZ_REG_INTC_MASK	0x04
> +#define JZ_REG_INTC_SET_MASK	0x08
> +#define JZ_REG_INTC_CLEAR_MASK	0x0c
> +#define JZ_REG_INTC_PENDING	0x10
> +
> +#define IRQ_BIT(x) BIT((x) - JZ4740_IRQ_BASE)
> +
> +static void intc_irq_unmask(unsigned int irq)
> +{
> +	writel(IRQ_BIT(irq), jz_intc_base + JZ_REG_INTC_CLEAR_MASK);
> +}
> +
> +static void intc_irq_mask(unsigned int irq)
> +{
> +	writel(IRQ_BIT(irq), jz_intc_base + JZ_REG_INTC_SET_MASK);
> +}
> +
> +static int intc_irq_set_wake(unsigned int irq, unsigned int on)
> +{
> +	if (on)
> +		jz_intc_wakeup |= IRQ_BIT(irq);
> +	else
> +		jz_intc_wakeup &= ~IRQ_BIT(irq);
> +
> +	return 0;
> +}
> +
> +static struct irq_chip intc_irq_type = {
> +	.name =		"INTC",
> +	.mask =		intc_irq_mask,
> +	.mask_ack =	intc_irq_mask,
> +	.unmask =	intc_irq_unmask,
> +	.set_wake =	intc_irq_set_wake,
> +};
> +
> +static irqreturn_t jz4740_cascade(int irq, void *data)
> +{
> +	uint32_t irq_reg;
> +	int intc_irq;
> +
> +	irq_reg = readl(jz_intc_base + JZ_REG_INTC_PENDING);
> +
> +	intc_irq = ffs(irq_reg);
> +	if (intc_irq)
> +		generic_handle_irq(intc_irq - 1 + JZ4740_IRQ_BASE);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction jz4740_cascade_action = {
> +	.handler = jz4740_cascade,
> +	.name = "JZ4740 cascade interrupt",
> +	.flags = IRQF_DISABLED,
> +};
> +
> +void __init arch_init_irq(void)
> +{
> +	int i;
> +	mips_cpu_irq_init();
> +
> +	jz_intc_base = ioremap(CPHYSADDR(JZ4740_INTC_BASE_ADDR), 0x14);

Better define the physical address and use ioremap directly on it.

> +
> +	for (i = JZ4740_IRQ_BASE; i < JZ4740_IRQ_BASE + 32; i++) {
> +		intc_irq_mask(i);
> +		set_irq_chip_and_handler(i, &intc_irq_type, handle_level_irq);
> +	}
> +
> +	setup_irq(2, &jz4740_cascade_action);
> +}
> +
> +asmlinkage void plat_irq_dispatch(void)
> +{
> +	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
> +	if (pending & STATUSF_IP2)
> +		do_IRQ(2);
> +	else if (pending & STATUSF_IP3)
> +		do_IRQ(3);
> +	else
> +		spurious_interrupt();
> +}
> +
> +void jz4740_intc_suspend(void)
> +{
> +	jz_intc_saved = readl(jz_intc_base + JZ_REG_INTC_MASK);
> +	writel(~jz_intc_wakeup, jz_intc_base + JZ_REG_INTC_SET_MASK);
> +	writel(jz_intc_wakeup, jz_intc_base + JZ_REG_INTC_CLEAR_MASK);
> +}
> +
> +void jz4740_intc_resume(void)
> +{
> +	writel(~jz_intc_saved, jz_intc_base + JZ_REG_INTC_CLEAR_MASK);
> +	writel(jz_intc_saved, jz_intc_base + JZ_REG_INTC_SET_MASK);
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +
> +static inline void intc_seq_reg(struct seq_file *s, const char *name,
> +	unsigned int reg)
> +{
> +	seq_printf(s, "%s:\t\t%08x\n", name, readl(jz_intc_base + reg));
> +}
> +
> +static int intc_regs_show(struct seq_file *s, void *unused)
> +{
> +	intc_seq_reg(s, "Status", JZ_REG_INTC_STATUS);
> +	intc_seq_reg(s, "Mask", JZ_REG_INTC_MASK);
> +	intc_seq_reg(s, "Pending", JZ_REG_INTC_PENDING);
> +
> +	return 0;
> +}
> +
> +static int intc_regs_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, intc_regs_show, NULL);
> +}
> +
> +static const struct file_operations intc_regs_operations = {
> +	.open		= intc_regs_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int __init intc_debugfs_init(void)
> +{
> +	(void) debugfs_create_file("jz_regs_intc", S_IFREG | S_IRUGO,
> +				NULL, NULL, &intc_regs_operations);
> +	return 0;
> +}
> +subsys_initcall(intc_debugfs_init);
> +
> +#endif
> diff --git a/arch/mips/jz4740/irq.h b/arch/mips/jz4740/irq.h
> new file mode 100644
> index 0000000..dadbd5f
> --- /dev/null
> +++ b/arch/mips/jz4740/irq.h
> @@ -0,0 +1,21 @@
> +/*
> + *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
> + *
> + *  This program is free software; you can redistribute	 it and/or modify
> it + *  under  the terms of	 the GNU General  Public License as 
published
> by the + *  Free Software Foundation;  either version 2 of the	License, 
or
> (at your + *  option) any later version.
> + *
> + *  You should have received a copy of the  GNU General Public License
> along + *  with this program; if not, write  to the Free Software
> Foundation, Inc., + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#ifndef __MIPS_JZ4740_IRQ_H__
> +#define __MIPS_JZ4740_IRQ_H__
> +
> +extern void jz4740_intc_suspend(void);
> +extern void jz4740_intc_resume(void);
> +
> +#endif
