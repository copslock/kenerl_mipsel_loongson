Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 20:11:33 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:37584 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904073Ab1KJTKI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2011 20:10:08 +0100
Received: by mail-fx0-f49.google.com with SMTP id r25so119238faa.36
        for <multiple recipients>; Thu, 10 Nov 2011 11:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5F/ABSYi3indz/2IQ7U4+gT+VRqa2TPFlQ4fJYSTeug=;
        b=TM6sSa1FhM7TaBl+hnJ7ViEgKJdGpv/RhJhqMvX6nUlux9x7fYLHLud12uOV/nxAPI
         5dqhRLr0Wpu84HvUhcer1pbKIWaf9Nim0qSI5dr4Higv5oTDRFOwc2z5FMzxxPEQjDv9
         h0/4fOtpfRtIfFP+syDaOiUrXvT83TmptobU8=
Received: by 10.152.103.51 with SMTP id ft19mr5189817lab.42.1320952208619;
        Thu, 10 Nov 2011 11:10:08 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-13-175.adsl.highway.telekom.at. [188.22.13.175])
        by mx.google.com with ESMTPS id tu2sm8213580lab.11.2011.11.10.11.10.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 11:10:07 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH mips-next 3/3] MIPS: Alchemy: merge Au1000 and Au1300-style IRQ controller code.
Date:   Thu, 10 Nov 2011 20:09:38 +0100
Message-Id: <1320952178-14228-4-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.2
In-Reply-To: <1320952178-14228-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320952178-14228-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9703

With a generic plat_irq_dispatch (for Alchemy at least) code for
both interrupt controller types can coexist in a single kernel
image and be autodetected at runtime.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/Makefile  |    5 +-
 arch/mips/alchemy/common/gpioint.c |  413 ---------------------
 arch/mips/alchemy/common/irq.c     |  719 +++++++++++++++++++++++++++---------
 3 files changed, 550 insertions(+), 587 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/gpioint.c

diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index d3f5c51..407ebc0 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -6,10 +6,7 @@
 #
 
 obj-y += prom.o time.o clocks.o platform.o power.o setup.o \
-	sleeper.o dma.o dbdma.o vss.o
-
-obj-$(CONFIG_ALCHEMY_GPIOINT_AU1000) += irq.o
-obj-$(CONFIG_ALCHEMY_GPIOINT_AU1300) += gpioint.o
+	sleeper.o dma.o dbdma.o vss.o irq.o
 
 # optional gpiolib support
 ifeq ($(CONFIG_ALCHEMY_GPIO_INDIRECT),)
diff --git a/arch/mips/alchemy/common/gpioint.c b/arch/mips/alchemy/common/gpioint.c
deleted file mode 100644
index daaaab0..0000000
--- a/arch/mips/alchemy/common/gpioint.c
+++ /dev/null
@@ -1,413 +0,0 @@
-/*
- * gpioint.c - Au1300 GPIO+Interrupt controller (I call it "GPIC") support.
- *
- * Copyright (c) 2009-2011 Manuel Lauss <manuel.lauss@googlemail.com>
- *
- * licensed under the GPLv2.
- */
-
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/syscore_ops.h>
-#include <linux/types.h>
-
-#include <asm/irq_cpu.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/gpio-au1300.h>
-
-static int au1300_gpic_settype(struct irq_data *d, unsigned int type);
-
-/* setup for known onchip sources */
-struct gpic_devint_data {
-	int irq;	/* linux IRQ number */
-	int type;	/* IRQ_TYPE_ */
-	int prio;	/* irq priority, 0 highest, 3 lowest */
-	int internal;	/* internal source (no ext. pin)? */
-};
-
-static const struct gpic_devint_data au1300_devints[] __initdata = {
-	/* multifunction: gpio pin or device */
-	{ AU1300_UART1_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
-	{ AU1300_UART2_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
-	{ AU1300_UART3_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
-	{ AU1300_SD1_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
-	{ AU1300_SD2_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
-	{ AU1300_PSC0_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
-	{ AU1300_PSC1_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
-	{ AU1300_PSC2_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
-	{ AU1300_PSC3_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
-	{ AU1300_NAND_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
-	/* au1300 internal */
-	{ AU1300_DDMA_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ AU1300_MMU_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ AU1300_MPU_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ AU1300_GPU_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ AU1300_UDMA_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ AU1300_TOY_INT,	 IRQ_TYPE_EDGE_RISING,	1, 1, },
-	{ AU1300_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING,	1, 1, },
-	{ AU1300_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING,	1, 1, },
-	{ AU1300_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING,	1, 1, },
-	{ AU1300_RTC_INT,	 IRQ_TYPE_EDGE_RISING,	1, 1, },
-	{ AU1300_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING,	1, 1, },
-	{ AU1300_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING,	1, 1, },
-	{ AU1300_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING,	0, 1, },
-	{ AU1300_UART0_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ AU1300_SD0_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ AU1300_USB_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ AU1300_LCD_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ AU1300_BSA_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ AU1300_MPE_INT,	 IRQ_TYPE_EDGE_RISING,	1, 1, },
-	{ AU1300_ITE_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ AU1300_AES_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ AU1300_CIM_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
-	{ -1, },	/* terminator */
-};
-
-
-/*
- * au1300_gpic_chgcfg - change PIN configuration.
- * @gpio:	pin to change (0-based GPIO number from datasheet).
- * @clr:	clear all bits set in 'clr'.
- * @set:	set these bits.
- *
- * modifies a pins' configuration register, bits set in @clr will
- * be cleared in the register, bits in @set will be set.
- */
-static inline void au1300_gpic_chgcfg(unsigned int gpio,
-				      unsigned long clr,
-				      unsigned long set)
-{
-	void __iomem *r = AU1300_GPIC_ADDR;
-	unsigned long l;
-
-	r += gpio * 4;	/* offset into pin config array */
-	l = __raw_readl(r + AU1300_GPIC_PINCFG);
-	l &= ~clr;
-	l |= set;
-	__raw_writel(l, r + AU1300_GPIC_PINCFG);
-	wmb();
-}
-
-/*
- * au1300_pinfunc_to_gpio - assign a pin as GPIO input (GPIO ctrl).
- * @pin:	pin (0-based GPIO number from datasheet).
- *
- * Assigns a GPIO pin to the GPIO controller, so its level can either
- * be read or set through the generic GPIO functions.
- * If you need a GPOUT, use au1300_gpio_set_value(pin, 0/1).
- * REVISIT: is this function really necessary?
- */
-void au1300_pinfunc_to_gpio(enum au1300_multifunc_pins gpio)
-{
-	au1300_gpio_direction_input(gpio + AU1300_GPIO_BASE);
-}
-EXPORT_SYMBOL_GPL(au1300_pinfunc_to_gpio);
-
-/*
- * au1300_pinfunc_to_dev - assign a pin to the device function.
- * @pin:	pin (0-based GPIO number from datasheet).
- *
- * Assigns a GPIO pin to its associated device function; the pin will be
- * driven by the device and not through GPIO functions.
- */
-void au1300_pinfunc_to_dev(enum au1300_multifunc_pins gpio)
-{
-	void __iomem *r = AU1300_GPIC_ADDR;
-	unsigned long bit;
-
-	r += GPIC_GPIO_BANKOFF(gpio);
-	bit = GPIC_GPIO_TO_BIT(gpio);
-	__raw_writel(bit, r + AU1300_GPIC_DEVSEL);
-	wmb();
-}
-EXPORT_SYMBOL_GPL(au1300_pinfunc_to_dev);
-
-/*
- * au1300_set_irq_priority -  set internal priority of IRQ.
- * @irq:	irq to set priority (linux irq number).
- * @p:		priority (0 = highest, 3 = lowest).
- */
-void au1300_set_irq_priority(unsigned int irq, int p)
-{
-	irq -= ALCHEMY_GPIC_INT_BASE;
-	au1300_gpic_chgcfg(irq, GPIC_CFG_IL_MASK, GPIC_CFG_IL_SET(p));
-}
-EXPORT_SYMBOL_GPL(au1300_set_irq_priority);
-
-/*
- * au1300_set_dbdma_gpio - assign a gpio to one of the DBDMA triggers.
- * @dchan:	dbdma trigger select (0, 1).
- * @gpio:	pin to assign as trigger.
- *
- * DBDMA controller has 2 external trigger sources; this function
- * assigns a GPIO to the selected trigger.
- */
-void au1300_set_dbdma_gpio(int dchan, unsigned int gpio)
-{
-	unsigned long r;
-
-	if ((dchan >= 0) && (dchan <= 1)) {
-		r = __raw_readl(AU1300_GPIC_ADDR + AU1300_GPIC_DMASEL);
-		r &= ~(0xff << (8 * dchan));
-		r |= (gpio & 0x7f) << (8 * dchan);
-		__raw_writel(r, AU1300_GPIC_ADDR + AU1300_GPIC_DMASEL);
-		wmb();
-	}
-}
-
-/**********************************************************************/
-
-static inline void gpic_pin_set_idlewake(unsigned int gpio, int allow)
-{
-	au1300_gpic_chgcfg(gpio, GPIC_CFG_IDLEWAKE,
-			   allow ? GPIC_CFG_IDLEWAKE : 0);
-}
-
-static void au1300_gpic_mask(struct irq_data *d)
-{
-	void __iomem *r = AU1300_GPIC_ADDR;
-	unsigned long bit, irq = d->irq;
-
-	irq -= ALCHEMY_GPIC_INT_BASE;
-	r += GPIC_GPIO_BANKOFF(irq);
-	bit = GPIC_GPIO_TO_BIT(irq);
-	__raw_writel(bit, r + AU1300_GPIC_IDIS);
-	wmb();
-
-	gpic_pin_set_idlewake(irq, 0);
-}
-
-static void au1300_gpic_unmask(struct irq_data *d)
-{
-	void __iomem *r = AU1300_GPIC_ADDR;
-	unsigned long bit, irq = d->irq;
-
-	irq -= ALCHEMY_GPIC_INT_BASE;
-
-	gpic_pin_set_idlewake(irq, 1);
-
-	r += GPIC_GPIO_BANKOFF(irq);
-	bit = GPIC_GPIO_TO_BIT(irq);
-	__raw_writel(bit, r + AU1300_GPIC_IEN);
-	wmb();
-}
-
-static void au1300_gpic_maskack(struct irq_data *d)
-{
-	void __iomem *r = AU1300_GPIC_ADDR;
-	unsigned long bit, irq = d->irq;
-
-	irq -= ALCHEMY_GPIC_INT_BASE;
-	r += GPIC_GPIO_BANKOFF(irq);
-	bit = GPIC_GPIO_TO_BIT(irq);
-	__raw_writel(bit, r + AU1300_GPIC_IPEND);	/* ack */
-	__raw_writel(bit, r + AU1300_GPIC_IDIS);	/* mask */
-	wmb();
-
-	gpic_pin_set_idlewake(irq, 0);
-}
-
-static void au1300_gpic_ack(struct irq_data *d)
-{
-	void __iomem *r = AU1300_GPIC_ADDR;
-	unsigned long bit, irq = d->irq;
-
-	irq -= ALCHEMY_GPIC_INT_BASE;
-	r += GPIC_GPIO_BANKOFF(irq);
-	bit = GPIC_GPIO_TO_BIT(irq);
-	__raw_writel(bit, r + AU1300_GPIC_IPEND);	/* ack */
-	wmb();
-}
-
-static struct irq_chip au1300_gpic = {
-	.name		= "GPIOINT",
-	.irq_ack	= au1300_gpic_ack,
-	.irq_mask	= au1300_gpic_mask,
-	.irq_mask_ack	= au1300_gpic_maskack,
-	.irq_unmask	= au1300_gpic_unmask,
-	.irq_set_type	= au1300_gpic_settype,
-};
-
-static int au1300_gpic_settype(struct irq_data *d, unsigned int type)
-{
-	unsigned long s;
-	unsigned char *name = NULL;
-	irq_flow_handler_t hdl = NULL;
-
-	switch (type) {
-	case IRQ_TYPE_LEVEL_HIGH:
-		s = GPIC_CFG_IC_LEVEL_HIGH;
-		name = "high";
-		hdl = handle_level_irq;
-		break;
-	case IRQ_TYPE_LEVEL_LOW:
-		s = GPIC_CFG_IC_LEVEL_LOW;
-		name = "low";
-		hdl = handle_level_irq;
-		break;
-	case IRQ_TYPE_EDGE_RISING:
-		s = GPIC_CFG_IC_EDGE_RISE;
-		name = "posedge";
-		hdl = handle_edge_irq;
-		break;
-	case IRQ_TYPE_EDGE_FALLING:
-		s = GPIC_CFG_IC_EDGE_FALL;
-		name = "negedge";
-		hdl = handle_edge_irq;
-		break;
-	case IRQ_TYPE_EDGE_BOTH:
-		s = GPIC_CFG_IC_EDGE_BOTH;
-		name = "bothedge";
-		hdl = handle_edge_irq;
-		break;
-	case IRQ_TYPE_NONE:
-		s = GPIC_CFG_IC_OFF;
-		name = "disabled";
-		hdl = handle_level_irq;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	__irq_set_chip_handler_name_locked(d->irq, &au1300_gpic, hdl, name);
-
-	au1300_gpic_chgcfg(d->irq - ALCHEMY_GPIC_INT_BASE, GPIC_CFG_IC_MASK, s);
-
-	return 0;
-}
-
-/******************************************************************************/
-
-static unsigned long alchemy_gpic_pmdata[ALCHEMY_GPIC_INT_NUM + 6];
-
-static int alchemy_gpic_suspend(void)
-{
-	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1300_GPIC_PHYS_ADDR);
-	int i;
-
-	/* save 4 interrupt mask status registers */
-	alchemy_gpic_pmdata[0] = __raw_readl(base + AU1300_GPIC_IEN + 0x0);
-	alchemy_gpic_pmdata[1] = __raw_readl(base + AU1300_GPIC_IEN + 0x4);
-	alchemy_gpic_pmdata[2] = __raw_readl(base + AU1300_GPIC_IEN + 0x8);
-	alchemy_gpic_pmdata[3] = __raw_readl(base + AU1300_GPIC_IEN + 0xc);
-
-	/* save misc register(s) */
-	alchemy_gpic_pmdata[4] = __raw_readl(base + AU1300_GPIC_DMASEL);
-
-	/* molto silenzioso */
-	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x0);
-	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x4);
-	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x8);
-	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0xc);
-	wmb();
-
-	/* save pin/int-type configuration */
-	base += AU1300_GPIC_PINCFG;
-	for (i = 0; i < ALCHEMY_GPIC_INT_NUM; i++)
-		alchemy_gpic_pmdata[i + 5] = __raw_readl(base + (i << 2));
-
-	wmb();
-
-	return 0;
-}
-
-static void alchemy_gpic_resume(void)
-{
-	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1300_GPIC_PHYS_ADDR);
-	int i;
-
-	/* disable all first */
-	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x0);
-	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x4);
-	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x8);
-	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0xc);
-	wmb();
-
-	/* restore pin/int-type configurations */
-	base += AU1300_GPIC_PINCFG;
-	for (i = 0; i < ALCHEMY_GPIC_INT_NUM; i++)
-		__raw_writel(alchemy_gpic_pmdata[i + 5], base + (i << 2));
-	wmb();
-
-	/* restore misc register(s) */
-	base = (void __iomem *)KSEG1ADDR(AU1300_GPIC_PHYS_ADDR);
-	__raw_writel(alchemy_gpic_pmdata[4], base + AU1300_GPIC_DMASEL);
-	wmb();
-
-	/* finally restore masks */
-	__raw_writel(alchemy_gpic_pmdata[0], base + AU1300_GPIC_IEN + 0x0);
-	__raw_writel(alchemy_gpic_pmdata[1], base + AU1300_GPIC_IEN + 0x4);
-	__raw_writel(alchemy_gpic_pmdata[2], base + AU1300_GPIC_IEN + 0x8);
-	__raw_writel(alchemy_gpic_pmdata[3], base + AU1300_GPIC_IEN + 0xc);
-	wmb();
-}
-
-static struct syscore_ops alchemy_gpic_pmops = {
-	.suspend	= alchemy_gpic_suspend,
-	.resume		= alchemy_gpic_resume,
-};
-
-static void alchemy_gpic_dispatch(unsigned int irq, struct irq_desc *d)
-{
-	int i = __raw_readl(AU1300_GPIC_ADDR + AU1300_GPIC_PRIENC);
-	generic_handle_irq(ALCHEMY_GPIC_INT_BASE + i);
-}
-
-static void __init alchemy_gpic_init_irq(const struct gpic_devint_data *dints)
-{
-	int i;
-	void __iomem *bank_base;
-
-	register_syscore_ops(&alchemy_gpic_pmops);
-	mips_cpu_irq_init();
-
-	/* disable & ack all possible interrupt sources */
-	for (i = 0; i < 4; i++) {
-		bank_base = AU1300_GPIC_ADDR + (i * 4);
-		__raw_writel(~0UL, bank_base + AU1300_GPIC_IDIS);
-		wmb();
-		__raw_writel(~0UL, bank_base + AU1300_GPIC_IPEND);
-		wmb();
-	}
-
-	/* register an irq_chip for them, with 2nd highest priority */
-	for (i = ALCHEMY_GPIC_INT_BASE; i <= ALCHEMY_GPIC_INT_LAST; i++) {
-		au1300_set_irq_priority(i, 1);
-		au1300_gpic_settype(irq_get_irq_data(i), IRQ_TYPE_NONE);
-	}
-
-	/* setup known on-chip sources */
-	while ((i = dints->irq) != -1) {
-		au1300_gpic_settype(irq_get_irq_data(i), dints->type);
-		au1300_set_irq_priority(i, dints->prio);
-
-		if (dints->internal)
-			au1300_pinfunc_to_dev(i - ALCHEMY_GPIC_INT_BASE);
-
-		dints++;
-	}
-
-	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 2, alchemy_gpic_dispatch);
-	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 3, alchemy_gpic_dispatch);
-	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 4, alchemy_gpic_dispatch);
-	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 5, alchemy_gpic_dispatch);
-}
-
-/**********************************************************************/
-
-void __init arch_init_irq(void)
-{
-	switch (alchemy_get_cputype()) {
-	case ALCHEMY_CPU_AU1300:
-		alchemy_gpic_init_irq(&au1300_devints[0]);
-		break;
-	}
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned long r = (read_c0_status() & read_c0_cause()) >> 8;
-	do_IRQ(MIPS_CPU_IRQ_BASE + __ffs(r & 0xff));
-}
diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index ee80a32..94fbcd1 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -25,16 +25,15 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/bitops.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
 
 #include <asm/irq_cpu.h>
-#include <asm/mipsregs.h>
 #include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/gpio-au1300.h>
 
 /* Interrupt Controller register offsets */
 #define IC_CFG0RD	0x40
@@ -66,7 +65,17 @@
 #define IC_FALLINGCLR	0x7C
 #define IC_TESTBIT	0x80
 
-static int au1x_ic_settype(struct irq_data *d, unsigned int flow_type);
+/* per-processor fixed function irqs */
+struct alchemy_irqmap {
+	int irq;	/* linux IRQ number */
+	int type;	/* IRQ_TYPE_ */
+	int prio;	/* irq priority, 0 highest, 3 lowest */
+	int internal;	/* GPIC: internal source (no ext. pin)? */
+};
+
+static int au1x_ic_settype(struct irq_data *d, unsigned int type);
+static int au1300_gpic_settype(struct irq_data *d, unsigned int type);
+
 
 /* NOTE on interrupt priorities: The original writers of this code said:
  *
@@ -74,176 +83,207 @@ static int au1x_ic_settype(struct irq_data *d, unsigned int flow_type);
  * the USB devices-side packet complete interrupt (USB_DEV_REQ_INT)
  * needs the highest priority.
  */
-
-/* per-processor fixed function irqs */
-struct au1xxx_irqmap {
-	int im_irq;
-	int im_type;
-	int im_request;		/* set 1 to get higher priority */
+struct alchemy_irqmap au1000_irqmap[] __initdata = {
+	{ AU1000_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_UART2_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_UART3_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_SSI0_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_SSI1_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_DMA_INT_BASE,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_DMA_INT_BASE+1,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_DMA_INT_BASE+2,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_DMA_INT_BASE+3,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_DMA_INT_BASE+4,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_DMA_INT_BASE+5,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_DMA_INT_BASE+6,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_DMA_INT_BASE+7,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1000_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1000_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1000_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1000_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1000_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1000_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1000_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0, 0 },
+	{ AU1000_IRDA_TX_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_IRDA_RX_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH,  0, 0 },
+	{ AU1000_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1000_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1000_ACSYNC_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1000_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_MAC1_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1000_AC97C_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ -1, },
 };
 
-struct au1xxx_irqmap au1000_irqmap[] __initdata = {
-	{ AU1000_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_UART2_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_UART3_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_SSI0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_SSI1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_DMA_INT_BASE,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_DMA_INT_BASE+1,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_DMA_INT_BASE+2,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_DMA_INT_BASE+3,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_DMA_INT_BASE+4,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_DMA_INT_BASE+5,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_DMA_INT_BASE+6,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_DMA_INT_BASE+7,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1 },
-	{ AU1000_IRDA_TX_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_IRDA_RX_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH,  1 },
-	{ AU1000_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1000_ACSYNC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_MAC1_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1000_AC97C_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+struct alchemy_irqmap au1500_irqmap[] __initdata = {
+	{ AU1500_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1500_PCI_INTA,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1500_PCI_INTB,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1500_UART3_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1500_PCI_INTC,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1500_PCI_INTD,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1500_DMA_INT_BASE,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1500_DMA_INT_BASE+1,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1500_DMA_INT_BASE+2,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1500_DMA_INT_BASE+3,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1500_DMA_INT_BASE+4,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1500_DMA_INT_BASE+5,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1500_DMA_INT_BASE+6,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1500_DMA_INT_BASE+7,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1500_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1500_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1500_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1500_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1500_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1500_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1500_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1500_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0, 0 },
+	{ AU1500_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH,  0, 0 },
+	{ AU1500_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1500_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1500_ACSYNC_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1500_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1500_MAC1_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1500_AC97C_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
 	{ -1, },
 };
 
-struct au1xxx_irqmap au1500_irqmap[] __initdata = {
-	{ AU1500_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1500_PCI_INTA,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1500_PCI_INTB,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1500_UART3_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1500_PCI_INTC,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1500_PCI_INTD,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1500_DMA_INT_BASE,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1500_DMA_INT_BASE+1,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1500_DMA_INT_BASE+2,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1500_DMA_INT_BASE+3,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1500_DMA_INT_BASE+4,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1500_DMA_INT_BASE+5,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1500_DMA_INT_BASE+6,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1500_DMA_INT_BASE+7,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1500_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1500_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1500_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1500_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1500_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1500_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1500_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1500_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1 },
-	{ AU1500_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH,  1 },
-	{ AU1500_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1500_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1500_ACSYNC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1500_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1500_MAC1_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1500_AC97C_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+struct alchemy_irqmap au1100_irqmap[] __initdata = {
+	{ AU1100_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_SD_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_UART3_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_SSI0_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_SSI1_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_DMA_INT_BASE,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_DMA_INT_BASE+1,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_DMA_INT_BASE+2,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_DMA_INT_BASE+3,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_DMA_INT_BASE+4,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_DMA_INT_BASE+5,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_DMA_INT_BASE+6,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_DMA_INT_BASE+7,  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1100_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1100_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1100_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1100_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1100_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1100_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1100_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0, 0 },
+	{ AU1100_IRDA_TX_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_IRDA_RX_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH,  0, 0 },
+	{ AU1100_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1100_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1100_ACSYNC_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1100_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_LCD_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1100_AC97C_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
 	{ -1, },
 };
 
-struct au1xxx_irqmap au1100_irqmap[] __initdata = {
-	{ AU1100_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_SD_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_UART3_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_SSI0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_SSI1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_DMA_INT_BASE,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_DMA_INT_BASE+1,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_DMA_INT_BASE+2,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_DMA_INT_BASE+3,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_DMA_INT_BASE+4,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_DMA_INT_BASE+5,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_DMA_INT_BASE+6,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_DMA_INT_BASE+7,  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1100_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1100_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1100_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1100_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1100_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1100_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1100_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1 },
-	{ AU1100_IRDA_TX_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_IRDA_RX_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH,  1 },
-	{ AU1100_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1100_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1100_ACSYNC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1100_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_LCD_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1100_AC97C_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
+struct alchemy_irqmap au1550_irqmap[] __initdata = {
+	{ AU1550_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1550_PCI_INTA,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1550_PCI_INTB,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1550_DDMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1550_CRYPTO_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1550_PCI_INTC,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1550_PCI_INTD,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1550_PCI_RST_INT,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1550_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1550_UART3_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1550_PSC0_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1550_PSC1_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1550_PSC2_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1550_PSC3_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1550_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1550_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1550_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1550_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1550_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1550_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1550_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1550_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0, 0 },
+	{ AU1550_NAND_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1550_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH,  0, 0 },
+	{ AU1550_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1550_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   1, 0 },
+	{ AU1550_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1550_MAC1_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
 	{ -1, },
 };
 
-struct au1xxx_irqmap au1550_irqmap[] __initdata = {
-	{ AU1550_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1550_PCI_INTA,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1550_PCI_INTB,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1550_DDMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1550_CRYPTO_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1550_PCI_INTC,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1550_PCI_INTD,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1550_PCI_RST_INT,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1550_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1550_UART3_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1550_PSC0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1550_PSC1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1550_PSC2_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1550_PSC3_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1550_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1550_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1550_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1550_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1550_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1550_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1550_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1550_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1 },
-	{ AU1550_NAND_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1550_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH,  1 },
-	{ AU1550_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1550_USB_HOST_INT,	  IRQ_TYPE_LEVEL_LOW,   0 },
-	{ AU1550_MAC0_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1550_MAC1_DMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
+struct alchemy_irqmap au1200_irqmap[] __initdata = {
+	{ AU1200_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1200_SWT_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1200_SD_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1200_DDMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1200_MAE_BE_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1200_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1200_MAE_FE_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1200_PSC0_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1200_PSC1_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1200_AES_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1200_CAMERA_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1200_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1200_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1200_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1200_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1200_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1200_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1200_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1200_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0, 0 },
+	{ AU1200_NAND_INT,	  IRQ_TYPE_EDGE_RISING, 1, 0 },
+	{ AU1200_USB_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1200_LCD_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
+	{ AU1200_MAE_BOTH_INT,	  IRQ_TYPE_LEVEL_HIGH,  1, 0 },
 	{ -1, },
 };
 
-struct au1xxx_irqmap au1200_irqmap[] __initdata = {
-	{ AU1200_UART0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1200_SWT_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1200_SD_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1200_DDMA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1200_MAE_BE_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1200_UART1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1200_MAE_FE_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1200_PSC0_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1200_PSC1_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1200_AES_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1200_CAMERA_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1200_TOY_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1200_TOY_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1200_TOY_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1200_TOY_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1200_RTC_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1200_RTC_MATCH0_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1200_RTC_MATCH1_INT,  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1200_RTC_MATCH2_INT,  IRQ_TYPE_EDGE_RISING, 1 },
-	{ AU1200_NAND_INT,	  IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1200_USB_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1200_LCD_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ AU1200_MAE_BOTH_INT,	  IRQ_TYPE_LEVEL_HIGH,  0 },
-	{ -1, },
+static struct alchemy_irqmap au1300_irqmap[] __initdata = {
+	/* multifunction: gpio pin or device */
+	{ AU1300_UART1_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
+	{ AU1300_UART2_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
+	{ AU1300_UART3_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
+	{ AU1300_SD1_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
+	{ AU1300_SD2_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
+	{ AU1300_PSC0_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
+	{ AU1300_PSC1_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
+	{ AU1300_PSC2_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
+	{ AU1300_PSC3_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
+	{ AU1300_NAND_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 0, },
+	/* au1300 internal */
+	{ AU1300_DDMA_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ AU1300_MMU_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ AU1300_MPU_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ AU1300_GPU_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ AU1300_UDMA_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ AU1300_TOY_INT,	 IRQ_TYPE_EDGE_RISING,	1, 1, },
+	{ AU1300_TOY_MATCH0_INT, IRQ_TYPE_EDGE_RISING,	1, 1, },
+	{ AU1300_TOY_MATCH1_INT, IRQ_TYPE_EDGE_RISING,	1, 1, },
+	{ AU1300_TOY_MATCH2_INT, IRQ_TYPE_EDGE_RISING,	1, 1, },
+	{ AU1300_RTC_INT,	 IRQ_TYPE_EDGE_RISING,	1, 1, },
+	{ AU1300_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING,	1, 1, },
+	{ AU1300_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING,	1, 1, },
+	{ AU1300_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING,	0, 1, },
+	{ AU1300_UART0_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ AU1300_SD0_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ AU1300_USB_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ AU1300_LCD_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ AU1300_BSA_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ AU1300_MPE_INT,	 IRQ_TYPE_EDGE_RISING,	1, 1, },
+	{ AU1300_ITE_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ AU1300_AES_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ AU1300_CIM_INT,	 IRQ_TYPE_LEVEL_HIGH,	1, 1, },
+	{ -1, },	/* terminator */
 };
 
+/******************************************************************************/
 
 static void au1x_ic0_unmask(struct irq_data *d)
 {
@@ -459,6 +499,220 @@ static int au1x_ic_settype(struct irq_data *d, unsigned int flow_type)
 	return ret;
 }
 
+/******************************************************************************/
+
+/*
+ * au1300_gpic_chgcfg - change PIN configuration.
+ * @gpio:	pin to change (0-based GPIO number from datasheet).
+ * @clr:	clear all bits set in 'clr'.
+ * @set:	set these bits.
+ *
+ * modifies a pins' configuration register, bits set in @clr will
+ * be cleared in the register, bits in @set will be set.
+ */
+static inline void au1300_gpic_chgcfg(unsigned int gpio,
+				      unsigned long clr,
+				      unsigned long set)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long l;
+
+	r += gpio * 4;	/* offset into pin config array */
+	l = __raw_readl(r + AU1300_GPIC_PINCFG);
+	l &= ~clr;
+	l |= set;
+	__raw_writel(l, r + AU1300_GPIC_PINCFG);
+	wmb();
+}
+
+/*
+ * au1300_pinfunc_to_gpio - assign a pin as GPIO input (GPIO ctrl).
+ * @pin:	pin (0-based GPIO number from datasheet).
+ *
+ * Assigns a GPIO pin to the GPIO controller, so its level can either
+ * be read or set through the generic GPIO functions.
+ * If you need a GPOUT, use au1300_gpio_set_value(pin, 0/1).
+ * REVISIT: is this function really necessary?
+ */
+void au1300_pinfunc_to_gpio(enum au1300_multifunc_pins gpio)
+{
+	au1300_gpio_direction_input(gpio + AU1300_GPIO_BASE);
+}
+EXPORT_SYMBOL_GPL(au1300_pinfunc_to_gpio);
+
+/*
+ * au1300_pinfunc_to_dev - assign a pin to the device function.
+ * @pin:	pin (0-based GPIO number from datasheet).
+ *
+ * Assigns a GPIO pin to its associated device function; the pin will be
+ * driven by the device and not through GPIO functions.
+ */
+void au1300_pinfunc_to_dev(enum au1300_multifunc_pins gpio)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long bit;
+
+	r += GPIC_GPIO_BANKOFF(gpio);
+	bit = GPIC_GPIO_TO_BIT(gpio);
+	__raw_writel(bit, r + AU1300_GPIC_DEVSEL);
+	wmb();
+}
+EXPORT_SYMBOL_GPL(au1300_pinfunc_to_dev);
+
+/*
+ * au1300_set_irq_priority -  set internal priority of IRQ.
+ * @irq:	irq to set priority (linux irq number).
+ * @p:		priority (0 = highest, 3 = lowest).
+ */
+void au1300_set_irq_priority(unsigned int irq, int p)
+{
+	irq -= ALCHEMY_GPIC_INT_BASE;
+	au1300_gpic_chgcfg(irq, GPIC_CFG_IL_MASK, GPIC_CFG_IL_SET(p));
+}
+EXPORT_SYMBOL_GPL(au1300_set_irq_priority);
+
+/*
+ * au1300_set_dbdma_gpio - assign a gpio to one of the DBDMA triggers.
+ * @dchan:	dbdma trigger select (0, 1).
+ * @gpio:	pin to assign as trigger.
+ *
+ * DBDMA controller has 2 external trigger sources; this function
+ * assigns a GPIO to the selected trigger.
+ */
+void au1300_set_dbdma_gpio(int dchan, unsigned int gpio)
+{
+	unsigned long r;
+
+	if ((dchan >= 0) && (dchan <= 1)) {
+		r = __raw_readl(AU1300_GPIC_ADDR + AU1300_GPIC_DMASEL);
+		r &= ~(0xff << (8 * dchan));
+		r |= (gpio & 0x7f) << (8 * dchan);
+		__raw_writel(r, AU1300_GPIC_ADDR + AU1300_GPIC_DMASEL);
+		wmb();
+	}
+}
+
+static inline void gpic_pin_set_idlewake(unsigned int gpio, int allow)
+{
+	au1300_gpic_chgcfg(gpio, GPIC_CFG_IDLEWAKE,
+			   allow ? GPIC_CFG_IDLEWAKE : 0);
+}
+
+static void au1300_gpic_mask(struct irq_data *d)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long bit, irq = d->irq;
+
+	irq -= ALCHEMY_GPIC_INT_BASE;
+	r += GPIC_GPIO_BANKOFF(irq);
+	bit = GPIC_GPIO_TO_BIT(irq);
+	__raw_writel(bit, r + AU1300_GPIC_IDIS);
+	wmb();
+
+	gpic_pin_set_idlewake(irq, 0);
+}
+
+static void au1300_gpic_unmask(struct irq_data *d)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long bit, irq = d->irq;
+
+	irq -= ALCHEMY_GPIC_INT_BASE;
+
+	gpic_pin_set_idlewake(irq, 1);
+
+	r += GPIC_GPIO_BANKOFF(irq);
+	bit = GPIC_GPIO_TO_BIT(irq);
+	__raw_writel(bit, r + AU1300_GPIC_IEN);
+	wmb();
+}
+
+static void au1300_gpic_maskack(struct irq_data *d)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long bit, irq = d->irq;
+
+	irq -= ALCHEMY_GPIC_INT_BASE;
+	r += GPIC_GPIO_BANKOFF(irq);
+	bit = GPIC_GPIO_TO_BIT(irq);
+	__raw_writel(bit, r + AU1300_GPIC_IPEND);	/* ack */
+	__raw_writel(bit, r + AU1300_GPIC_IDIS);	/* mask */
+	wmb();
+
+	gpic_pin_set_idlewake(irq, 0);
+}
+
+static void au1300_gpic_ack(struct irq_data *d)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long bit, irq = d->irq;
+
+	irq -= ALCHEMY_GPIC_INT_BASE;
+	r += GPIC_GPIO_BANKOFF(irq);
+	bit = GPIC_GPIO_TO_BIT(irq);
+	__raw_writel(bit, r + AU1300_GPIC_IPEND);	/* ack */
+	wmb();
+}
+
+static struct irq_chip au1300_gpic = {
+	.name		= "GPIOINT",
+	.irq_ack	= au1300_gpic_ack,
+	.irq_mask	= au1300_gpic_mask,
+	.irq_mask_ack	= au1300_gpic_maskack,
+	.irq_unmask	= au1300_gpic_unmask,
+	.irq_set_type	= au1300_gpic_settype,
+};
+
+static int au1300_gpic_settype(struct irq_data *d, unsigned int type)
+{
+	unsigned long s;
+	unsigned char *name = NULL;
+	irq_flow_handler_t hdl = NULL;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		s = GPIC_CFG_IC_LEVEL_HIGH;
+		name = "high";
+		hdl = handle_level_irq;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		s = GPIC_CFG_IC_LEVEL_LOW;
+		name = "low";
+		hdl = handle_level_irq;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		s = GPIC_CFG_IC_EDGE_RISE;
+		name = "posedge";
+		hdl = handle_edge_irq;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		s = GPIC_CFG_IC_EDGE_FALL;
+		name = "negedge";
+		hdl = handle_edge_irq;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		s = GPIC_CFG_IC_EDGE_BOTH;
+		name = "bothedge";
+		hdl = handle_edge_irq;
+		break;
+	case IRQ_TYPE_NONE:
+		s = GPIC_CFG_IC_OFF;
+		name = "disabled";
+		hdl = handle_level_irq;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	__irq_set_chip_handler_name_locked(d->irq, &au1300_gpic, hdl, name);
+
+	au1300_gpic_chgcfg(d->irq - ALCHEMY_GPIC_INT_BASE, GPIC_CFG_IC_MASK, s);
+
+	return 0;
+}
+
+/******************************************************************************/
+
 static inline void ic_init(void __iomem *base)
 {
 	/* initialize interrupt controller to a safe state */
@@ -475,7 +729,7 @@ static inline void ic_init(void __iomem *base)
 	wmb();
 }
 
-static unsigned long alchemy_ic_pmdata[7 * 2];
+static unsigned long alchemy_gpic_pmdata[ALCHEMY_GPIC_INT_NUM + 6];
 
 static inline void alchemy_ic_suspend_one(void __iomem *base, unsigned long *d)
 {
@@ -508,25 +762,94 @@ static inline void alchemy_ic_resume_one(void __iomem *base, unsigned long *d)
 static int alchemy_ic_suspend(void)
 {
 	alchemy_ic_suspend_one((void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR),
-			       alchemy_ic_pmdata);
+			       alchemy_gpic_pmdata);
 	alchemy_ic_suspend_one((void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR),
-			       &alchemy_ic_pmdata[7]);
+			       &alchemy_gpic_pmdata[7]);
 	return 0;
 }
 
 static void alchemy_ic_resume(void)
 {
 	alchemy_ic_resume_one((void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR),
-			      &alchemy_ic_pmdata[7]);
+			      &alchemy_gpic_pmdata[7]);
 	alchemy_ic_resume_one((void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR),
-			      alchemy_ic_pmdata);
+			      alchemy_gpic_pmdata);
 }
 
-static struct syscore_ops alchemy_ic_syscore_ops = {
+static int alchemy_gpic_suspend(void)
+{
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1300_GPIC_PHYS_ADDR);
+	int i;
+
+	/* save 4 interrupt mask status registers */
+	alchemy_gpic_pmdata[0] = __raw_readl(base + AU1300_GPIC_IEN + 0x0);
+	alchemy_gpic_pmdata[1] = __raw_readl(base + AU1300_GPIC_IEN + 0x4);
+	alchemy_gpic_pmdata[2] = __raw_readl(base + AU1300_GPIC_IEN + 0x8);
+	alchemy_gpic_pmdata[3] = __raw_readl(base + AU1300_GPIC_IEN + 0xc);
+
+	/* save misc register(s) */
+	alchemy_gpic_pmdata[4] = __raw_readl(base + AU1300_GPIC_DMASEL);
+
+	/* molto silenzioso */
+	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x0);
+	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x4);
+	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x8);
+	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0xc);
+	wmb();
+
+	/* save pin/int-type configuration */
+	base += AU1300_GPIC_PINCFG;
+	for (i = 0; i < ALCHEMY_GPIC_INT_NUM; i++)
+		alchemy_gpic_pmdata[i + 5] = __raw_readl(base + (i << 2));
+
+	wmb();
+
+	return 0;
+}
+
+static void alchemy_gpic_resume(void)
+{
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1300_GPIC_PHYS_ADDR);
+	int i;
+
+	/* disable all first */
+	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x0);
+	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x4);
+	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0x8);
+	__raw_writel(~0UL, base + AU1300_GPIC_IDIS + 0xc);
+	wmb();
+
+	/* restore pin/int-type configurations */
+	base += AU1300_GPIC_PINCFG;
+	for (i = 0; i < ALCHEMY_GPIC_INT_NUM; i++)
+		__raw_writel(alchemy_gpic_pmdata[i + 5], base + (i << 2));
+	wmb();
+
+	/* restore misc register(s) */
+	base = (void __iomem *)KSEG1ADDR(AU1300_GPIC_PHYS_ADDR);
+	__raw_writel(alchemy_gpic_pmdata[4], base + AU1300_GPIC_DMASEL);
+	wmb();
+
+	/* finally restore masks */
+	__raw_writel(alchemy_gpic_pmdata[0], base + AU1300_GPIC_IEN + 0x0);
+	__raw_writel(alchemy_gpic_pmdata[1], base + AU1300_GPIC_IEN + 0x4);
+	__raw_writel(alchemy_gpic_pmdata[2], base + AU1300_GPIC_IEN + 0x8);
+	__raw_writel(alchemy_gpic_pmdata[3], base + AU1300_GPIC_IEN + 0xc);
+	wmb();
+}
+
+static struct syscore_ops alchemy_ic_pmops = {
 	.suspend	= alchemy_ic_suspend,
 	.resume		= alchemy_ic_resume,
 };
 
+static struct syscore_ops alchemy_gpic_pmops = {
+	.suspend	= alchemy_gpic_suspend,
+	.resume		= alchemy_gpic_resume,
+};
+
+/******************************************************************************/
+
 /* create chained handlers for the 4 IC requests to the MIPS IRQ ctrl */
 #define DISP(name, base, addr)						      \
 static void au1000_##name##_dispatch(unsigned int irq, struct irq_desc *d)    \
@@ -543,14 +866,22 @@ DISP(ic0r1, AU1000_INTC0_INT_BASE, AU1000_IC0_PHYS_ADDR + IC_REQ1INT)
 DISP(ic1r0, AU1000_INTC1_INT_BASE, AU1000_IC1_PHYS_ADDR + IC_REQ0INT)
 DISP(ic1r1, AU1000_INTC1_INT_BASE, AU1000_IC1_PHYS_ADDR + IC_REQ1INT)
 
-static void __init au1000_init_irq(struct au1xxx_irqmap *map)
+static void alchemy_gpic_dispatch(unsigned int irq, struct irq_desc *d)
+{
+	int i = __raw_readl(AU1300_GPIC_ADDR + AU1300_GPIC_PRIENC);
+	generic_handle_irq(ALCHEMY_GPIC_INT_BASE + i);
+}
+
+/******************************************************************************/
+
+static void __init au1000_init_irq(struct alchemy_irqmap *map)
 {
 	unsigned int bit, irq_nr;
 	void __iomem *base;
 
 	ic_init((void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR));
 	ic_init((void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR));
-	register_syscore_ops(&alchemy_ic_syscore_ops);
+	register_syscore_ops(&alchemy_ic_pmops);
 	mips_cpu_irq_init();
 
 	/* register all 64 possible IC0+IC1 irq sources as type "none".
@@ -567,8 +898,8 @@ static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 	/*
 	 * Initialize IC0, which is fixed per processor.
 	 */
-	while (map->im_irq != -1) {
-		irq_nr = map->im_irq;
+	while (map->irq != -1) {
+		irq_nr = map->irq;
 
 		if (irq_nr >= AU1000_INTC1_INT_BASE) {
 			bit = irq_nr - AU1000_INTC1_INT_BASE;
@@ -577,10 +908,10 @@ static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 			bit = irq_nr - AU1000_INTC0_INT_BASE;
 			base = (void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR);
 		}
-		if (map->im_request)
+		if (map->prio == 0)
 			__raw_writel(1 << bit, base + IC_ASSIGNSET);
 
-		au1x_ic_settype(irq_get_irq_data(irq_nr), map->im_type);
+		au1x_ic_settype(irq_get_irq_data(irq_nr), map->type);
 		++map;
 	}
 
@@ -590,6 +921,48 @@ static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 5, au1000_ic1r1_dispatch);
 }
 
+static void __init alchemy_gpic_init_irq(const struct alchemy_irqmap *dints)
+{
+	int i;
+	void __iomem *bank_base;
+
+	register_syscore_ops(&alchemy_gpic_pmops);
+	mips_cpu_irq_init();
+
+	/* disable & ack all possible interrupt sources */
+	for (i = 0; i < 4; i++) {
+		bank_base = AU1300_GPIC_ADDR + (i * 4);
+		__raw_writel(~0UL, bank_base + AU1300_GPIC_IDIS);
+		wmb();
+		__raw_writel(~0UL, bank_base + AU1300_GPIC_IPEND);
+		wmb();
+	}
+
+	/* register an irq_chip for them, with 2nd highest priority */
+	for (i = ALCHEMY_GPIC_INT_BASE; i <= ALCHEMY_GPIC_INT_LAST; i++) {
+		au1300_set_irq_priority(i, 1);
+		au1300_gpic_settype(irq_get_irq_data(i), IRQ_TYPE_NONE);
+	}
+
+	/* setup known on-chip sources */
+	while ((i = dints->irq) != -1) {
+		au1300_gpic_settype(irq_get_irq_data(i), dints->type);
+		au1300_set_irq_priority(i, dints->prio);
+
+		if (dints->internal)
+			au1300_pinfunc_to_dev(i - ALCHEMY_GPIC_INT_BASE);
+
+		dints++;
+	}
+
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 2, alchemy_gpic_dispatch);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 3, alchemy_gpic_dispatch);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 4, alchemy_gpic_dispatch);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 5, alchemy_gpic_dispatch);
+}
+
+/******************************************************************************/
+
 void __init arch_init_irq(void)
 {
 	switch (alchemy_get_cputype()) {
@@ -608,6 +981,12 @@ void __init arch_init_irq(void)
 	case ALCHEMY_CPU_AU1200:
 		au1000_init_irq(au1200_irqmap);
 		break;
+	case ALCHEMY_CPU_AU1300:
+		alchemy_gpic_init_irq(au1300_irqmap);
+		break;
+	default:
+		pr_err("unknown Alchemy IRQ core\n");
+		break;
 	}
 }
 
-- 
1.7.7.2
