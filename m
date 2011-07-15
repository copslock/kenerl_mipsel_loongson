Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2011 13:42:16 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:49648 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491808Ab1GOLld (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jul 2011 13:41:33 +0200
Received: by eyh6 with SMTP id 6so733147eyh.36
        for <linux-mips@linux-mips.org>; Fri, 15 Jul 2011 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HqyXfd35gNmwJ7kQy8BI/FArBMzUlaH9AMbShWHPuXw=;
        b=fkc5oGSBitS25dE+6xeSNuQqVK+EHh//BU2JiOJfB98NolVa93L9VlQPovxMnLL828
         ynlhmKLjpUA6lRdSVEEtidtHigjC2l0elAM3ipv9ab4LVr47JL7U5ZjCQyMBLChDRZVa
         smrzStjIj21vZLyHvc/ADZpzjAcz3h1SomoUY=
Received: by 10.204.23.208 with SMTP id s16mr1128099bkb.352.1310730087615;
        Fri, 15 Jul 2011 04:41:27 -0700 (PDT)
Received: from localhost.localdomain (178-191-8-8.adsl.highway.telekom.at [178.191.8.8])
        by mx.google.com with ESMTPS id q1sm794249faa.3.2011.07.15.04.41.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jul 2011 04:41:26 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC PATCH V3 1/2] MIPS: Alchemy: Au1300 SoC support
Date:   Fri, 15 Jul 2011 13:41:17 +0200
Message-Id: <1310730078-30265-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1310730078-30265-1-git-send-email-manuel.lauss@googlemail.com>
References: <1310730078-30265-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10920

Add basic support for the Au1300 variant(s):
- New GPIO/Interrupt controller
- DBDMA ids
- USB setup
- enable various PSC drivers
- detection code.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
V3: removed debug code, tidied some comments, renamed gpiolib hook functions.
V2: simplified plat_irq_dispatch which made the assembly significantly smaller.

 arch/mips/alchemy/Kconfig                        |    8 +
 arch/mips/alchemy/common/Makefile                |    4 +-
 arch/mips/alchemy/common/dbdma.c                 |   48 +++-
 arch/mips/alchemy/common/gpioint.c               |  411 ++++++++++++++++++++++
 arch/mips/alchemy/common/gpiolib-au1300.c        |   54 +++
 arch/mips/alchemy/common/platform.c              |   31 ++-
 arch/mips/alchemy/common/power.c                 |    3 +
 arch/mips/alchemy/common/sleeper.S               |   73 ++++
 arch/mips/alchemy/common/time.c                  |    1 +
 arch/mips/alchemy/common/usb.c                   |  277 +++++++++++++++
 arch/mips/alchemy/common/vss.c                   |   84 +++++
 arch/mips/include/asm/cpu.h                      |    1 +
 arch/mips/include/asm/mach-au1x00/au1000.h       |  223 +++++++++++-
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |   33 ++
 arch/mips/include/asm/mach-au1x00/gpio-au1300.h  |  250 +++++++++++++
 arch/mips/include/asm/mach-au1x00/gpio.h         |    4 +
 arch/mips/kernel/cpu-probe.c                     |    7 +
 drivers/i2c/busses/Kconfig                       |    6 +-
 drivers/spi/Kconfig                              |    6 +-
 drivers/usb/Kconfig                              |    2 +-
 drivers/usb/host/ehci-hcd.c                      |    2 +-
 drivers/usb/host/ohci-au1xxx.c                   |   13 +-
 drivers/video/Kconfig                            |   10 +-
 sound/soc/au1x/Kconfig                           |    6 +-
 24 files changed, 1516 insertions(+), 41 deletions(-)
 create mode 100644 arch/mips/alchemy/common/gpioint.c
 create mode 100644 arch/mips/alchemy/common/gpiolib-au1300.c
 create mode 100644 arch/mips/alchemy/common/vss.c
 create mode 100644 arch/mips/include/asm/mach-au1x00/gpio-au1300.h

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 2ccfd4a..30277fd 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -2,6 +2,10 @@
 config ALCHEMY_GPIOINT_AU1000
 	bool
 
+# au1300-style GPIO/INT controller
+config ALCHEMY_GPIOINT_AU1300
+	bool
+
 # select this in your board config if you don't want to use the gpio
 # namespace as documented in the manuals.  In this case however you need
 # to create the necessary gpio_* functions in your board code/headers!
@@ -158,3 +162,7 @@ config SOC_AU1550
 config SOC_AU1200
 	bool
 	select ALCHEMY_GPIOINT_AU1000
+
+config SOC_AU1300
+	bool
+	select ALCHEMY_GPIOINT_AU1300
diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index 575db47..39a2fd6 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -6,14 +6,16 @@
 #
 
 obj-y += prom.o time.o clocks.o platform.o power.o setup.o \
-	sleeper.o dma.o dbdma.o usb.o
+	sleeper.o dma.o dbdma.o usb.o vss.o
 
 obj-$(CONFIG_ALCHEMY_GPIOINT_AU1000) += irq.o
+obj-$(CONFIG_ALCHEMY_GPIOINT_AU1300) += gpioint.o
 
 # optional gpiolib support
 ifeq ($(CONFIG_ALCHEMY_GPIO_INDIRECT),)
  ifeq ($(CONFIG_GPIOLIB),y)
   obj-$(CONFIG_ALCHEMY_GPIOINT_AU1000) += gpiolib-au1000.o
+  obj-$(CONFIG_ALCHEMY_GPIOINT_AU1300) += gpiolib-au1300.o
  endif
 endif
 
diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 3a5abb5..83c02a2 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -40,8 +40,6 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
-
 /*
  * The Descriptor Based DMA supports up to 16 channels.
  *
@@ -152,6 +150,47 @@ static dbdev_tab_t dbdev_tab[] = {
 
 #endif /* CONFIG_SOC_AU1200 */
 
+#ifdef CONFIG_SOC_AU1300
+	{ DSCR_CMD0_UART0_TX, DEV_FLAGS_OUT, 0, 8,  0x10100004, 0, 0 },
+	{ DSCR_CMD0_UART0_RX, DEV_FLAGS_IN,  0, 8,  0x10100000, 0, 0 },
+	{ DSCR_CMD0_UART1_TX, DEV_FLAGS_OUT, 0, 8,  0x10101004, 0, 0 },
+	{ DSCR_CMD0_UART1_RX, DEV_FLAGS_IN,  0, 8,  0x10101000, 0, 0 },
+	{ DSCR_CMD0_UART2_TX, DEV_FLAGS_OUT, 0, 8,  0x10102004, 0, 0 },
+	{ DSCR_CMD0_UART2_RX, DEV_FLAGS_IN,  0, 8,  0x10102000, 0, 0 },
+	{ DSCR_CMD0_UART3_TX, DEV_FLAGS_OUT, 0, 8,  0x10103004, 0, 0 },
+	{ DSCR_CMD0_UART3_RX, DEV_FLAGS_IN,  0, 8,  0x10103000, 0, 0 },
+
+	{ DSCR_CMD0_SDMS_TX0, DEV_FLAGS_OUT, 4, 8,  0x10600000, 0, 0 },
+	{ DSCR_CMD0_SDMS_RX0, DEV_FLAGS_IN,  4, 8,  0x10600004, 0, 0 },
+	{ DSCR_CMD0_SDMS_TX1, DEV_FLAGS_OUT, 8, 8,  0x10601000, 0, 0 },
+	{ DSCR_CMD0_SDMS_RX1, DEV_FLAGS_IN,  8, 8,  0x10601004, 0, 0 },
+
+	{ DSCR_CMD0_AES_RX, DEV_FLAGS_IN ,   4, 32, 0x10300008, 0, 0 },
+	{ DSCR_CMD0_AES_TX, DEV_FLAGS_OUT,   4, 32, 0x10300004, 0, 0 },
+
+	{ DSCR_CMD0_PSC0_TX, DEV_FLAGS_OUT,  0, 16, 0x10a0001c, 0, 0 },
+	{ DSCR_CMD0_PSC0_RX, DEV_FLAGS_IN,   0, 16, 0x10a0001c, 0, 0 },
+	{ DSCR_CMD0_PSC1_TX, DEV_FLAGS_OUT,  0, 16, 0x10a0101c, 0, 0 },
+	{ DSCR_CMD0_PSC1_RX, DEV_FLAGS_IN,   0, 16, 0x10a0101c, 0, 0 },
+	{ DSCR_CMD0_PSC2_TX, DEV_FLAGS_OUT,  0, 16, 0x10a0201c, 0, 0 },
+	{ DSCR_CMD0_PSC2_RX, DEV_FLAGS_IN,   0, 16, 0x10a0201c, 0, 0 },
+	{ DSCR_CMD0_PSC3_TX, DEV_FLAGS_OUT,  0, 16, 0x10a0301c, 0, 0 },
+	{ DSCR_CMD0_PSC3_RX, DEV_FLAGS_IN,   0, 16, 0x10a0301c, 0, 0 },
+
+	{ DSCR_CMD0_LCD, DEV_FLAGS_ANYUSE,   0, 0,  0x00000000, 0, 0 },
+	{ DSCR_CMD0_NAND_FLASH, DEV_FLAGS_IN, 0, 0, 0x00000000, 0, 0 },
+
+	{ DSCR_CMD0_SDMS_TX2, DEV_FLAGS_OUT, 4, 8,  0x10602000, 0, 0 },
+	{ DSCR_CMD0_SDMS_RX2, DEV_FLAGS_IN,  4, 8,  0x10602004, 0, 0 },
+
+	{ DSCR_CMD0_CIM_SYNC, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
+
+	{ DSCR_CMD0_UDMA, DEV_FLAGS_ANYUSE,  0, 32, 0x14001810, 0, 0 },
+
+	{ DSCR_CMD0_DMA_REQ0, 0, 0, 0, 0x00000000, 0, 0 },
+	{ DSCR_CMD0_DMA_REQ1, 0, 0, 0, 0x00000000, 0, 0 },
+#endif /* CONFIG_SOC_AU1300 */
+
 	{ DSCR_CMD0_THROTTLE, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
 	{ DSCR_CMD0_ALWAYS, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
 
@@ -1044,6 +1083,9 @@ static int __init au1xxx_dbdma_init(void)
 	case ALCHEMY_CPU_AU1200:
 		irq_nr = AU1200_DDMA_INT;
 		break;
+	case ALCHEMY_CPU_AU1300:
+		irq_nr = AU1300_DDMA_INT;
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -1061,5 +1103,3 @@ static int __init au1xxx_dbdma_init(void)
 	return ret;
 }
 subsys_initcall(au1xxx_dbdma_init);
-
-#endif /* defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200) */
diff --git a/arch/mips/alchemy/common/gpioint.c b/arch/mips/alchemy/common/gpioint.c
new file mode 100644
index 0000000..b8cd336
--- /dev/null
+++ b/arch/mips/alchemy/common/gpioint.c
@@ -0,0 +1,411 @@
+/*
+ * gpioint.c - Au1300 GPIO+Interrupt controller (I call it "GPIC") support.
+ *
+ * Copyright (c) 2009-2011 Manuel Lauss <manuel.lauss@googlemail.com>
+ *
+ * licensed under the GPLv2.
+ */
+
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/syscore_ops.h>
+#include <linux/types.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/gpio-au1300.h>
+
+static int au1300_gpic_settype(struct irq_data *d, unsigned int type);
+
+/* setup for known onchip sources */
+struct gpic_devint_data {
+	int irq;	/* linux IRQ number */
+	int type;	/* IRQ_TYPE_ */
+	int prio;	/* irq priority, 0 highest, 3 lowest */
+	int internal;	/* internal source (no ext. pin)? */
+};
+
+static const struct gpic_devint_data au1300_devints[] __initdata = {
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
+};
+
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
+/**********************************************************************/
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
+static void __init alchemy_gpic_init_irq(const struct gpic_devint_data *dints)
+{
+	int i;
+	void __iomem *bank_base;
+
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
+	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
+}
+
+static unsigned long alchemy_gpic_pmdata[ALCHEMY_GPIC_INT_NUM + 6];
+
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
+static struct syscore_ops alchemy_gpic_pmops = {
+	.suspend	= alchemy_gpic_suspend,
+	.resume		= alchemy_gpic_resume,
+};
+
+/**********************************************************************/
+
+void __init arch_init_irq(void)
+{
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1300:
+		alchemy_gpic_init_irq(&au1300_devints[0]);
+		register_syscore_ops(&alchemy_gpic_pmops);
+		break;
+	}
+}
+
+#define CAUSEF_GPIC (CAUSEF_IP2 | CAUSEF_IP3 | CAUSEF_IP4 | CAUSEF_IP5)
+
+void plat_irq_dispatch(void)
+{
+	unsigned long i, c = read_c0_cause() & read_c0_status();
+
+	if (c & CAUSEF_IP7)				/* c0 timer */
+		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
+	else if (likely(c & CAUSEF_GPIC)) {
+		i = __raw_readl(AU1300_GPIC_ADDR + AU1300_GPIC_PRIENC);
+		do_IRQ(i + ALCHEMY_GPIC_INT_BASE);
+	} else
+		spurious_interrupt();
+}
diff --git a/arch/mips/alchemy/common/gpiolib-au1300.c b/arch/mips/alchemy/common/gpiolib-au1300.c
new file mode 100644
index 0000000..afccd03
--- /dev/null
+++ b/arch/mips/alchemy/common/gpiolib-au1300.c
@@ -0,0 +1,54 @@
+/*
+ * Au1300-style GPIO/INT Controller GPIOLIB support
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/gpio.h>
+
+#include <asm/mach-au1x00/gpio-au1300.h>
+
+static int alchemy_gpic_get(struct gpio_chip *chip, unsigned int off)
+{
+	return au1300_gpio_get_value(off + AU1300_GPIO_BASE);
+}
+
+static void alchemy_gpic_set(struct gpio_chip *chip, unsigned int off, int v)
+{
+	au1300_gpio_set_value(off + AU1300_GPIO_BASE, v);
+}
+
+static int alchemy_gpic_dir_input(struct gpio_chip *chip, unsigned int off)
+{
+	return au1300_gpio_direction_input(off + AU1300_GPIO_BASE);
+}
+
+static int alchemy_gpic_dir_output(struct gpio_chip *chip, unsigned int off,
+				   int v)
+{
+	return au1300_gpio_direction_output(off + AU1300_GPIO_BASE, v);
+}
+
+static int alchemy_gpic_gpio_to_irq(struct gpio_chip *chip, unsigned int off)
+{
+	return au1300_gpio_to_irq(off + AU1300_GPIO_BASE);
+}
+
+static struct gpio_chip au1300_gpiochip = {
+	.label			= "au1300",
+	.direction_input	= alchemy_gpic_dir_input,
+	.direction_output	= alchemy_gpic_dir_output,
+	.get			= alchemy_gpic_get,
+	.set			= alchemy_gpic_set,
+	.to_irq			= alchemy_gpic_gpio_to_irq,
+	.base			= AU1300_GPIO_BASE,
+	.ngpio			= AU1300_GPIO_NUM,
+};
+
+static int __init au1300_gpiochip_init(void)
+{
+	return gpiochip_add(&au1300_gpiochip);
+}
+arch_initcall(au1300_gpiochip_init);
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index a5b37b3..932f697 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -82,6 +82,12 @@ static struct plat_serial8250_port au1x00_uart_data[][4] __initdata = {
 		PORT(AU1000_UART0_PHYS_ADDR, AU1200_UART0_INT),
 		PORT(AU1000_UART1_PHYS_ADDR, AU1200_UART1_INT),
 	},
+	[ALCHEMY_CPU_AU1300] = {
+		PORT(AU1300_UART0_PHYS_ADDR, AU1300_UART0_INT),
+		PORT(AU1300_UART1_PHYS_ADDR, AU1300_UART1_INT),
+		PORT(AU1300_UART2_PHYS_ADDR, AU1300_UART2_INT),
+		PORT(AU1300_UART3_PHYS_ADDR, AU1300_UART3_INT),
+	},
 };
 
 static struct platform_device au1xx0_uart_device = {
@@ -122,10 +128,12 @@ static unsigned long alchemy_ohci_data[][2] __initdata = {
 	[ALCHEMY_CPU_AU1100] = { AU1000_USB_OHCI_PHYS_ADDR, AU1100_USB_HOST_INT },
 	[ALCHEMY_CPU_AU1550] = { AU1550_USB_OHCI_PHYS_ADDR, AU1550_USB_HOST_INT },
 	[ALCHEMY_CPU_AU1200] = { AU1200_USB_OHCI_PHYS_ADDR, AU1200_USB_INT },
+	[ALCHEMY_CPU_AU1300] = { AU1300_USB_OHCI0_PHYS_ADDR, AU1300_USB_INT },
 };
 
 static unsigned long alchemy_ehci_data[][2] __initdata = {
 	[ALCHEMY_CPU_AU1200] = { AU1200_USB_EHCI_PHYS_ADDR, AU1200_USB_INT },
+	[ALCHEMY_CPU_AU1300] = { AU1300_USB_EHCI_PHYS_ADDR, AU1300_USB_INT },
 };
 
 static int __init _new_usbres(struct resource **r, struct platform_device **d)
@@ -169,8 +177,8 @@ static void __init alchemy_setup_usb(int ctype)
 		printk(KERN_INFO "Alchemy USB: cannot add OHCI0\n");
 
 
-	/* setup EHCI0: Au1200 */
-	if (ctype == ALCHEMY_CPU_AU1200) {
+	/* setup EHCI0: Au1200/Au1300 */
+	if ((ctype == ALCHEMY_CPU_AU1200) || (ctype == ALCHEMY_CPU_AU1300)) {
 		if (_new_usbres(&res, &pdev))
 			return;
 
@@ -187,6 +195,25 @@ static void __init alchemy_setup_usb(int ctype)
 		if (platform_device_register(pdev))
 			printk(KERN_INFO "Alchemy USB: cannot add EHCI0\n");
 	}
+
+	/* Au1300: OHCI1 */
+	if (ctype == ALCHEMY_CPU_AU1300) {
+		if (_new_usbres(&res, &pdev))
+			return;
+
+		res[0].start = AU1300_USB_OHCI1_PHYS_ADDR;
+		res[0].end = res[0].start + 0x100 - 1;
+		res[0].flags = IORESOURCE_MEM;
+		res[1].start = AU1300_USB_INT;
+		res[1].end = res[1].start;
+		res[1].flags = IORESOURCE_IRQ;
+		pdev->name = "au1xxx-ohci";
+		pdev->id = 1;
+		pdev->dev.dma_mask = &alchemy_ohci_dmamask;
+
+		if (platform_device_register(pdev))
+			printk(KERN_INFO "Alchemy USB: cannot add OHCI1\n");
+	}
 }
 
 /*** AU1100 LCD controller ***/
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index e53b4ce..1b9bbb8 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -128,6 +128,9 @@ void au_sleep(void)
 	case ALCHEMY_CPU_AU1200:
 		alchemy_sleep_au1550();
 		break;
+	case ALCHEMY_CPU_AU1300:
+		alchemy_sleep_au1300();
+		break;
 	}
 
 	restore_core_regs();
diff --git a/arch/mips/alchemy/common/sleeper.S b/arch/mips/alchemy/common/sleeper.S
index 77f3c74..c7bcc7e 100644
--- a/arch/mips/alchemy/common/sleeper.S
+++ b/arch/mips/alchemy/common/sleeper.S
@@ -153,6 +153,79 @@ LEAF(alchemy_sleep_au1550)
 
 END(alchemy_sleep_au1550)
 
+/* sleepcode for Au1300 memory controller type */
+LEAF(alchemy_sleep_au1300)
+
+	SETUP_SLEEP
+
+	/* cache following instructions, as memory gets put to sleep */
+	la	t0, 2f
+	la	t1, 4f
+	subu	t2, t1, t0
+
+	.set	mips3
+
+1:	cache	0x14, 0(t0)
+	subu	t2, t2, 32
+	bgez	t2, 1b
+	 addu	t0, t0, 32
+
+	.set	mips0
+
+2:	lui	a0, 0xb400		/* mem_xxx */
+
+	/* disable all ports in mem_sdportcfga */
+	sw	zero, 0x868(a0)		/* mem_sdportcfga */
+	sync
+
+	/* disable ODT */
+	li	t0, 0x03010000
+	sw	t0, 0x08d8(a0)		/* mem_sdcmd0 */
+	sw	t0, 0x08dc(a0)		/* mem_sdcmd1 */
+	sync
+
+	/* precharge */
+	li	t0, 0x23000400
+	sw	t0, 0x08dc(a0)		/* mem_sdcmd1 */
+	sw	t0, 0x08d8(a0)		/* mem_sdcmd0 */
+	sync
+
+	/* auto refresh */
+	sw	zero, 0x08c8(a0)	/* mem_sdautoref */
+	sync
+
+	/* block access to the DDR */
+	lw	t0, 0x0848(a0)		/* mem_sdconfigb */
+	li	t1, (1 << 7 | 0x3F)
+	or	t0, t0, t1
+	sw	t0, 0x0848(a0)		/* mem_sdconfigb */
+	sync
+
+	/* issue the Self Refresh command */
+	li	t0, 0x10000000
+	sw	t0, 0x08dc(a0)		/* mem_sdcmd1 */
+	sw	t0, 0x08d8(a0)		/* mem_sdcmd0 */
+	sync
+
+	/* wait for sdram to enter self-refresh mode */
+	lui	t0, 0x0300
+3:	lw	t1, 0x0850(a0)		/* mem_sdstat */
+	and	t2, t1, t0
+	bne	t2, t0, 3b
+	 nop
+
+	/* disable SDRAM clocks */
+	li	t0, ~(3<<28)
+	lw	t1, 0x0840(a0)		/* mem_sdconfiga */
+	and	t1, t1, t0		/* clear CE[1:0] */
+	sw	t1, 0x0840(a0)		/* mem_sdconfiga */
+	sync
+
+	DO_SLEEP
+4:
+
+END(alchemy_sleep_au1300)
+
 
 	/* This is where we return upon wakeup.
 	 * Reload all of the registers and return.
diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index d5da6ad..a594a85 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -178,6 +178,7 @@ static int alchemy_m2inttab[] __initdata = {
 	AU1100_RTC_MATCH2_INT,
 	AU1550_RTC_MATCH2_INT,
 	AU1200_RTC_MATCH2_INT,
+	AU1300_RTC_MATCH2_INT,
 };
 
 void __init plat_time_init(void)
diff --git a/arch/mips/alchemy/common/usb.c b/arch/mips/alchemy/common/usb.c
index f769364..0852a07 100644
--- a/arch/mips/alchemy/common/usb.c
+++ b/arch/mips/alchemy/common/usb.c
@@ -52,9 +52,263 @@
 				 USBCFG_EBE | USBCFG_EME | USBCFG_OBE |	       \
 				 USBCFG_OME)
 
+/* Au1300 USB config registers */
+#define USB_DWC_CTRL1		0x00
+#define USB_DWC_CTRL2		0x04
+#define USB_VBUS_TIMER		0x10
+#define USB_SBUS_CTRL		0x14
+#define USB_MSR_ERR		0x18
+#define USB_DWC_CTRL3		0x1C
+#define USB_DWC_CTRL4		0x20
+#define USB_OTG_STATUS		0x28
+#define USB_DWC_CTRL5		0x2C
+#define USB_DWC_CTRL6		0x30
+#define USB_DWC_CTRL7		0x34
+#define USB_PHY_STATUS		0xC0
+#define USB_INT_STATUS		0xC4
+#define USB_INT_ENABLE		0xC8
+
+#define USB_DWC_CTRL1_OTGD	0x04 /* set to DISable OTG */
+#define USB_DWC_CTRL1_HSTRS	0x02 /* set to ENable EHCI */
+#define USB_DWC_CTRL1_DCRS	0x01 /* set to ENable UDC */
+
+#define USB_DWC_CTRL2_PHY1RS	0x04 /* set to enable PHY1 */
+#define USB_DWC_CTRL2_PHY0RS	0x02 /* set to enable PHY0 */
+#define USB_DWC_CTRL2_PHYRS	0x01 /* set to enable PHY */
+
+#define USB_DWC_CTRL3_OHCI1_CKEN	(1 << 19)
+#define USB_DWC_CTRL3_OHCI0_CKEN	(1 << 18)
+#define USB_DWC_CTRL3_EHCI0_CKEN	(1 << 17)
+#define USB_DWC_CTRL3_OTG0_CKEN		(1 << 16)
+
+#define USB_SBUS_CTRL_SBCA		0x04 /* coherent access */
+
+#define USB_INTEN_FORCE			0x20
+#define USB_INTEN_PHY			0x10
+#define USB_INTEN_UDC			0x08
+#define USB_INTEN_EHCI			0x04
+#define USB_INTEN_OHCI1			0x02
+#define USB_INTEN_OHCI0			0x01
 
 static DEFINE_SPINLOCK(alchemy_usb_lock);
 
+static inline void __au1300_usb_phyctl(void __iomem *base, int enable)
+{
+	unsigned long r, s;
+
+	r = __raw_readl(base + USB_DWC_CTRL2);
+	s = __raw_readl(base + USB_DWC_CTRL3);
+
+	s &= USB_DWC_CTRL3_OHCI1_CKEN | USB_DWC_CTRL3_OHCI0_CKEN |
+		USB_DWC_CTRL3_EHCI0_CKEN | USB_DWC_CTRL3_OTG0_CKEN;
+
+	if (enable) {
+		/* simply enable all PHYs */
+		r |= USB_DWC_CTRL2_PHY1RS | USB_DWC_CTRL2_PHY0RS |
+		     USB_DWC_CTRL2_PHYRS;
+		__raw_writel(r, base + USB_DWC_CTRL2);
+		wmb();
+	} else if (!s) {
+		/* no USB block active, do disable all PHYs */
+		r &= ~(USB_DWC_CTRL2_PHY1RS | USB_DWC_CTRL2_PHY0RS |
+		       USB_DWC_CTRL2_PHYRS);
+		__raw_writel(r, base + USB_DWC_CTRL2);
+		wmb();
+	}
+}
+
+static inline void __au1300_ohci_control(void __iomem *base, int enable, int id)
+{
+	unsigned long r;
+
+	if (enable) {
+		__raw_writel(1, base + USB_DWC_CTRL7);  /* start OHCI clock */
+		wmb();
+
+		r = __raw_readl(base + USB_DWC_CTRL3);	/* enable OHCI block */
+		r |= (id == 0) ? USB_DWC_CTRL3_OHCI0_CKEN
+			       : USB_DWC_CTRL3_OHCI1_CKEN;
+		__raw_writel(r, base + USB_DWC_CTRL3);
+		wmb();
+
+		__au1300_usb_phyctl(base, enable);	/* power up the PHYs */
+
+		r = __raw_readl(base + USB_INT_ENABLE);
+		r |= (id == 0) ? USB_INTEN_OHCI0 : USB_INTEN_OHCI1;
+		__raw_writel(r, base + USB_INT_ENABLE);
+		wmb();
+
+		/* reset the OHCI start clock bit */
+		__raw_writel(0, base + USB_DWC_CTRL7);
+		wmb();
+	} else {
+		r = __raw_readl(base + USB_INT_ENABLE);
+		r &= ~((id == 0) ? USB_INTEN_OHCI0 : USB_INTEN_OHCI1);
+		__raw_writel(r, base + USB_INT_ENABLE);
+		wmb();
+
+		r = __raw_readl(base + USB_DWC_CTRL3);
+		r &= ~((id == 0) ? USB_DWC_CTRL3_OHCI0_CKEN
+				 : USB_DWC_CTRL3_OHCI1_CKEN);
+		__raw_writel(r, base + USB_DWC_CTRL3);
+		wmb();
+
+		__au1300_usb_phyctl(base, enable);
+	}
+}
+
+static inline void __au1300_ehci_control(void __iomem *base, int enable)
+{
+	unsigned long r;
+
+	if (enable) {
+		r = __raw_readl(base + USB_DWC_CTRL3);
+		r |= USB_DWC_CTRL3_EHCI0_CKEN;
+		__raw_writel(r, base + USB_DWC_CTRL3);
+		wmb();
+
+		r = __raw_readl(base + USB_DWC_CTRL1);
+		r |= USB_DWC_CTRL1_HSTRS;
+		__raw_writel(r, base + USB_DWC_CTRL1);
+		wmb();
+
+		__au1300_usb_phyctl(base, enable);
+
+		r = __raw_readl(base + USB_INT_ENABLE);
+		r |= USB_INTEN_EHCI;
+		__raw_writel(r, base + USB_INT_ENABLE);
+		wmb();
+	} else {
+		r = __raw_readl(base + USB_INT_ENABLE);
+		r &= ~USB_INTEN_EHCI;
+		__raw_writel(r, base + USB_INT_ENABLE);
+		wmb();
+
+		r = __raw_readl(base + USB_DWC_CTRL1);
+		r &= ~USB_DWC_CTRL1_HSTRS;
+		__raw_writel(r, base + USB_DWC_CTRL1);
+		wmb();
+
+		r = __raw_readl(base + USB_DWC_CTRL3);
+		r &= ~USB_DWC_CTRL3_EHCI0_CKEN;
+		__raw_writel(r, base + USB_DWC_CTRL3);
+		wmb();
+
+		__au1300_usb_phyctl(base, enable);
+	}
+}
+
+static inline void __au1300_udc_control(void __iomem *base, int enable)
+{
+	unsigned long r;
+
+	if (enable) {
+		r = __raw_readl(base + USB_DWC_CTRL1);
+		r |= USB_DWC_CTRL1_DCRS;
+		__raw_writel(r, base + USB_DWC_CTRL1);
+		wmb();
+
+		__au1300_usb_phyctl(base, enable);
+
+		r = __raw_readl(base + USB_INT_ENABLE);
+		r |= USB_INTEN_UDC;
+		__raw_writel(r, base + USB_INT_ENABLE);
+		wmb();
+	} else {
+		r = __raw_readl(base + USB_INT_ENABLE);
+		r &= ~USB_INTEN_UDC;
+		__raw_writel(r, base + USB_INT_ENABLE);
+		wmb();
+
+		r = __raw_readl(base + USB_DWC_CTRL1);
+		r &= ~USB_DWC_CTRL1_DCRS;
+		__raw_writel(r, base + USB_DWC_CTRL1);
+		wmb();
+
+		__au1300_usb_phyctl(base, enable);
+	}
+}
+
+static inline void __au1300_otg_control(void __iomem *base, int enable)
+{
+	unsigned long r;
+	if (enable) {
+		r = __raw_readl(base + USB_DWC_CTRL3);
+		r |= USB_DWC_CTRL3_OTG0_CKEN;
+		__raw_writel(r, base + USB_DWC_CTRL3);
+		wmb();
+
+		r = __raw_readl(base + USB_DWC_CTRL1);
+		r &= ~USB_DWC_CTRL1_OTGD;
+		__raw_writel(r, base + USB_DWC_CTRL1);
+		wmb();
+
+		__au1300_usb_phyctl(base, enable);
+	} else {
+		r = __raw_readl(base + USB_DWC_CTRL1);
+		r |= USB_DWC_CTRL1_OTGD;
+		__raw_writel(r, base + USB_DWC_CTRL1);
+		wmb();
+
+		r = __raw_readl(base + USB_DWC_CTRL3);
+		r &= ~USB_DWC_CTRL3_OTG0_CKEN;
+		__raw_writel(r, base + USB_DWC_CTRL3);
+		wmb();
+
+		__au1300_usb_phyctl(base, enable);
+	}
+}
+
+static inline int au1300_usb_control(int block, int enable)
+{
+	void __iomem *base =
+		(void __iomem *)KSEG1ADDR(AU1300_USB_CTL_PHYS_ADDR);
+	int ret = 0;
+
+	switch (block) {
+	case ALCHEMY_USB_OHCI0:
+		__au1300_ohci_control(base, enable, 0);
+		break;
+	case ALCHEMY_USB_OHCI1:
+		__au1300_ohci_control(base, enable, 1);
+		break;
+	case ALCHEMY_USB_EHCI0:
+		__au1300_ehci_control(base, enable);
+		break;
+	case ALCHEMY_USB_UDC0:
+		__au1300_udc_control(base, enable);
+		break;
+	case ALCHEMY_USB_OTG0:
+		__au1300_otg_control(base, enable);
+		break;
+	default:
+		ret = -ENODEV;
+	}
+	return ret;
+}
+
+static inline void au1300_usb_init(void)
+{
+	void __iomem *base =
+		(void __iomem *)KSEG1ADDR(AU1300_USB_CTL_PHYS_ADDR);
+
+	/* set some sane defaults.  Note: we don't fiddle with DWC_CTRL4
+	 * here at all: Port 2 routing (EHCI or UDC) must be set either
+	 * by boot firmware or platform init code; I can't autodetect
+	 * a sane setting.
+	 */
+	__raw_writel(0, base + USB_INT_ENABLE); /* disable all USB irqs */
+	wmb();
+	__raw_writel(0, base + USB_DWC_CTRL3); /* disable all clocks */
+	wmb();
+	__raw_writel(~0, base + USB_MSR_ERR); /* clear all errors */
+	wmb();
+	__raw_writel(~0, base + USB_INT_STATUS); /* clear int status */
+	wmb();
+	/* set coherent access bit */
+	__raw_writel(USB_SBUS_CTRL_SBCA, base + USB_SBUS_CTRL);
+	wmb();
+}
 
 static inline void __au1200_ohci_control(void __iomem *base, int enable)
 {
@@ -233,6 +487,9 @@ int alchemy_usb_control(int block, int enable)
 	case ALCHEMY_CPU_AU1200:
 		ret = au1200_usb_control(block, enable);
 		break;
+	case ALCHEMY_CPU_AU1300:
+		ret = au1300_usb_control(block, enable);
+		break;
 	default:
 		ret = -ENODEV;
 	}
@@ -281,6 +538,20 @@ static void au1200_usb_pm(int susp)
 	}
 }
 
+static void au1300_usb_pm(int susp)
+{
+	void __iomem *base =
+			(void __iomem *)KSEG1ADDR(AU1300_USB_CTL_PHYS_ADDR);
+	/* remember Port2 routing */
+	if (susp) {
+		alchemy_usb_pmdata[0] = __raw_readl(base + USB_DWC_CTRL4);
+	} else {
+		au1300_usb_init();
+		__raw_writel(alchemy_usb_pmdata[0], base + USB_DWC_CTRL4);
+		wmb();
+	}
+}
+
 static void alchemy_usb_pm(int susp)
 {
 	switch (alchemy_get_cputype()) {
@@ -295,6 +566,9 @@ static void alchemy_usb_pm(int susp)
 	case ALCHEMY_CPU_AU1200:
 		au1200_usb_pm(susp);
 		break;
+	case ALCHEMY_CPU_AU1300:
+		au1300_usb_pm(susp);
+		break;
 	}
 }
 
@@ -328,6 +602,9 @@ static int __init alchemy_usb_init(void)
 	case ALCHEMY_CPU_AU1200:
 		au1200_usb_init();
 		break;
+	case ALCHEMY_CPU_AU1300:
+		au1300_usb_init();
+		break;
 	}
 
 	register_syscore_ops(&alchemy_usb_pm_ops);
diff --git a/arch/mips/alchemy/common/vss.c b/arch/mips/alchemy/common/vss.c
new file mode 100644
index 0000000..d23b144
--- /dev/null
+++ b/arch/mips/alchemy/common/vss.c
@@ -0,0 +1,84 @@
+/*
+ * Au1300 media block power gating (VSS)
+ *
+ * This is a stop-gap solution until I have the clock framework integration
+ * ready. This stuff here really must be handled transparently when clocks
+ * for various media blocks are enabled/disabled.
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <asm/mach-au1x00/au1000.h>
+
+#define VSS_GATE	0x00	/* gate wait timers */
+#define VSS_CLKRST	0x04	/* clock/block control */
+#define VSS_FTR		0x08	/* footers */
+
+#define VSS_ADDR(blk)	(KSEG1ADDR(AU1300_VSS_PHYS_ADDR) + (blk * 0x0c))
+
+static DEFINE_SPINLOCK(au1300_vss_lock);
+
+/* enable a block as outlined in the databook */
+static inline void __enable_block(int block)
+{
+	void __iomem *base = (void __iomem *)VSS_ADDR(block);
+
+	__raw_writel(3, base + VSS_CLKRST);	/* enable clock, assert reset */
+	wmb();
+
+	__raw_writel(0x01fffffe, base + VSS_GATE); /* maximum setup time */
+	wmb();
+
+	/* enable footers in sequence */
+	__raw_writel(0x01, base + VSS_FTR);
+	wmb();
+	__raw_writel(0x03, base + VSS_FTR);
+	wmb();
+	__raw_writel(0x07, base + VSS_FTR);
+	wmb();
+	__raw_writel(0x0f, base + VSS_FTR);
+	wmb();
+
+	__raw_writel(0x01ffffff, base + VSS_GATE); /* start FSM too */
+	wmb();
+
+	__raw_writel(2, base + VSS_CLKRST);	/* deassert reset */
+	wmb();
+
+	__raw_writel(0x1f, base + VSS_FTR);	/* enable isolation cells */
+	wmb();
+}
+
+/* disable a block as outlined in the databook */
+static inline void __disable_block(int block)
+{
+	void __iomem *base = (void __iomem *)VSS_ADDR(block);
+
+	__raw_writel(0x0f, base + VSS_FTR);	/* disable isolation cells */
+	wmb();
+	__raw_writel(0, base + VSS_GATE);	/* disable FSM */
+	wmb();
+	__raw_writel(3, base + VSS_CLKRST);	/* assert reset */
+	wmb();
+	__raw_writel(1, base + VSS_CLKRST);	/* disable clock */
+	wmb();
+	__raw_writel(0, base + VSS_FTR);	/* disable all footers */
+	wmb();
+}
+
+void au1300_vss_block_control(int block, int enable)
+{
+	unsigned long flags;
+
+	if (alchemy_get_cputype() != ALCHEMY_CPU_AU1300)
+		return;
+
+	/* only one block at a time */
+	spin_lock_irqsave(&au1300_vss_lock, flags);
+	if (enable)
+		__enable_block(block);
+	else
+		__disable_block(block);
+	spin_unlock_irqrestore(&au1300_vss_lock, flags);
+}
+EXPORT_SYMBOL_GPL(au1300_vss_block_control);
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 5f95a4b..bb9a470 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -166,6 +166,7 @@
 #define PRID_IMP_NETLOGIC_XLS412B	0x4c00
 #define PRID_IMP_NETLOGIC_XLS408B	0x4e00
 #define PRID_IMP_NETLOGIC_XLS404B	0x4f00
+#define PRID_IMP_NETLOGIC_AU13XX	0x8000
 
 /*
  * Definitions for 7:0 on legacy processors
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index bcf3d1e..610cc06 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -136,6 +136,7 @@ static inline int au1xxx_cpu_needs_config_od(void)
 #define ALCHEMY_CPU_AU1100	2
 #define ALCHEMY_CPU_AU1550	3
 #define ALCHEMY_CPU_AU1200	4
+#define ALCHEMY_CPU_AU1300	5
 
 static inline int alchemy_get_cputype(void)
 {
@@ -156,6 +157,9 @@ static inline int alchemy_get_cputype(void)
 	case 0x05030000:
 		return ALCHEMY_CPU_AU1200;
 		break;
+	case 0x800c0000:
+		return ALCHEMY_CPU_AU1300;
+		break;
 	}
 
 	return ALCHEMY_CPU_UNKNOWN;
@@ -166,6 +170,7 @@ static inline int alchemy_get_uarts(int type)
 {
 	switch (type) {
 	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1300:
 		return 4;
 	case ALCHEMY_CPU_AU1500:
 	case ALCHEMY_CPU_AU1200:
@@ -243,6 +248,7 @@ extern unsigned long au1xxx_calc_clock(void);
 /* PM: arch/mips/alchemy/common/sleeper.S, power.c, irq.c */
 void alchemy_sleep_au1000(void);
 void alchemy_sleep_au1550(void);
+void alchemy_sleep_au1300(void);
 void au_sleep(void);
 
 /* USB: arch/mips/alchemy/common/usb.c */
@@ -251,18 +257,97 @@ enum alchemy_usb_block {
 	ALCHEMY_USB_UDC0,
 	ALCHEMY_USB_EHCI0,
 	ALCHEMY_USB_OTG0,
+	ALCHEMY_USB_OHCI1,	/* au1300 */
 };
 int alchemy_usb_control(int block, int enable);
 
 
-/* SOC Interrupt numbers */
+/* Multifunction pins: Each of these pins can either be assigned to the
+ * GPIO controller or a on-chip peripheral.
+ * Call "au1300_pinfunc_to_dev()" or "au1300_pinfunc_to_gpio()" to
+ * assign one of these to either the GPIO controller or the device.
+ */
+enum au1300_multifunc_pins {
+	/* wake-from-str pins 0-3 */
+	AU1300_PIN_WAKE0 = 0, AU1300_PIN_WAKE1, AU1300_PIN_WAKE2,
+	AU1300_PIN_WAKE3,
+	/* external clock sources for PSCs: 4-5 */
+	AU1300_PIN_EXTCLK0, AU1300_PIN_EXTCLK1,
+	/* 8bit MMC interface on SD0: 6-9 */
+	AU1300_PIN_SD0DAT4, AU1300_PIN_SD0DAT5, AU1300_PIN_SD0DAT6,
+	AU1300_PIN_SD0DAT7,
+	/* aux clk input for freqgen 3: 10 */
+	AU1300_PIN_FG3AUX,
+	/* UART1 pins: 11-18 */
+	AU1300_PIN_U1RI, AU1300_PIN_U1DCD, AU1300_PIN_U1DSR,
+	AU1300_PIN_U1CTS, AU1300_PIN_U1RTS, AU1300_PIN_U1DTR,
+	AU1300_PIN_U1RX, AU1300_PIN_U1TX,
+	/* UART0 pins: 19-24 */
+	AU1300_PIN_U0RI, AU1300_PIN_U0DCD, AU1300_PIN_U0DSR,
+	AU1300_PIN_U0CTS, AU1300_PIN_U0RTS, AU1300_PIN_U0DTR,
+	/* UART2: 25-26 */
+	AU1300_PIN_U2RX, AU1300_PIN_U2TX,
+	/* UART3: 27-28 */
+	AU1300_PIN_U3RX, AU1300_PIN_U3TX,
+	/* LCD controller PWMs, ext pixclock: 29-31 */
+	AU1300_PIN_LCDPWM0, AU1300_PIN_LCDPWM1, AU1300_PIN_LCDCLKIN,
+	/* SD1 interface: 32-37 */
+	AU1300_PIN_SD1DAT0, AU1300_PIN_SD1DAT1, AU1300_PIN_SD1DAT2,
+	AU1300_PIN_SD1DAT3, AU1300_PIN_SD1CMD, AU1300_PIN_SD1CLK,
+	/* SD2 interface: 38-43 */
+	AU1300_PIN_SD2DAT0, AU1300_PIN_SD2DAT1, AU1300_PIN_SD2DAT2,
+	AU1300_PIN_SD2DAT3, AU1300_PIN_SD2CMD, AU1300_PIN_SD2CLK,
+	/* PSC0/1 clocks: 44-45 */
+	AU1300_PIN_PSC0CLK, AU1300_PIN_PSC1CLK,
+	/* PSCs: 46-49/50-53/54-57/58-61 */
+	AU1300_PIN_PSC0SYNC0, AU1300_PIN_PSC0SYNC1, AU1300_PIN_PSC0D0,
+	AU1300_PIN_PSC0D1,
+	AU1300_PIN_PSC1SYNC0, AU1300_PIN_PSC1SYNC1, AU1300_PIN_PSC1D0,
+	AU1300_PIN_PSC1D1,
+	AU1300_PIN_PSC2SYNC0, AU1300_PIN_PSC2SYNC1, AU1300_PIN_PSC2D0,
+	AU1300_PIN_PSC2D1,
+	AU1300_PIN_PSC3SYNC0, AU1300_PIN_PSC3SYNC1, AU1300_PIN_PSC3D0,
+	AU1300_PIN_PSC3D1,
+	/* PCMCIA interface: 62-70 */
+	AU1300_PIN_PCE2, AU1300_PIN_PCE1, AU1300_PIN_PIOS16,
+	AU1300_PIN_PIOR, AU1300_PIN_PWE, AU1300_PIN_PWAIT,
+	AU1300_PIN_PREG, AU1300_PIN_POE, AU1300_PIN_PIOW,
+	/* camera interface H/V sync inputs: 71-72 */
+	AU1300_PIN_CIMLS, AU1300_PIN_CIMFS,
+	/* PSC2/3 clocks: 73-74 */
+	AU1300_PIN_PSC2CLK, AU1300_PIN_PSC3CLK,
+};
+
+/* GPIC (Au1300) pin management: arch/mips/alchemy/common/gpioint.c */
+extern void au1300_pinfunc_to_gpio(enum au1300_multifunc_pins gpio);
+extern void au1300_pinfunc_to_dev(enum au1300_multifunc_pins gpio);
+extern void au1300_set_irq_priority(unsigned int irq, int p);
+extern void au1300_set_dbdma_gpio(int dchan, unsigned int gpio);
+
+/* Au1300 allows to disconnect certain blocks from internal power supply */
+enum au1300_vss_block {
+	AU1300_VSS_MPE = 0,
+	AU1300_VSS_BSA,
+	AU1300_VSS_GPE,
+	AU1300_VSS_MGP,
+};
+
+extern void au1300_vss_block_control(int block, int enable);
+
 
+/* SOC Interrupt numbers */
+/* Au1000-style (IC0/1): 2 controllers with 32 sources each */
 #define AU1000_INTC0_INT_BASE	(MIPS_CPU_IRQ_BASE + 8)
 #define AU1000_INTC0_INT_LAST	(AU1000_INTC0_INT_BASE + 31)
 #define AU1000_INTC1_INT_BASE	(AU1000_INTC0_INT_LAST + 1)
 #define AU1000_INTC1_INT_LAST	(AU1000_INTC1_INT_BASE + 31)
 #define AU1000_MAX_INTR 	AU1000_INTC1_INT_LAST
 
+/* Au1300-style (GPIC): 1 controller with up to 128 sources */
+#define ALCHEMY_GPIC_INT_BASE	(MIPS_CPU_IRQ_BASE + 8)
+#define ALCHEMY_GPIC_INT_NUM	128
+#define ALCHEMY_GPIC_INT_LAST	(ALCHEMY_GPIC_INT_BASE + ALCHEMY_GPIC_INT_NUM - 1)
+
 enum soc_au1000_ints {
 	AU1000_FIRST_INT	= AU1000_INTC0_INT_BASE,
 	AU1000_UART0_INT	= AU1000_FIRST_INT,
@@ -583,6 +668,43 @@ enum soc_au1200_ints {
 
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
+/* Au1300 peripheral interrupt numbers */
+#define AU1300_FIRST_INT	(ALCHEMY_GPIC_INT_BASE)
+#define AU1300_UART1_INT	(AU1300_FIRST_INT + 17)
+#define AU1300_UART2_INT	(AU1300_FIRST_INT + 25)
+#define AU1300_UART3_INT	(AU1300_FIRST_INT + 27)
+#define AU1300_SD1_INT		(AU1300_FIRST_INT + 32)
+#define AU1300_SD2_INT		(AU1300_FIRST_INT + 38)
+#define AU1300_PSC0_INT		(AU1300_FIRST_INT + 48)
+#define AU1300_PSC1_INT		(AU1300_FIRST_INT + 52)
+#define AU1300_PSC2_INT		(AU1300_FIRST_INT + 56)
+#define AU1300_PSC3_INT		(AU1300_FIRST_INT + 60)
+#define AU1300_NAND_INT		(AU1300_FIRST_INT + 62)
+#define AU1300_DDMA_INT		(AU1300_FIRST_INT + 75)
+#define AU1300_MMU_INT		(AU1300_FIRST_INT + 76)
+#define AU1300_MPU_INT		(AU1300_FIRST_INT + 77)
+#define AU1300_GPU_INT		(AU1300_FIRST_INT + 78)
+#define AU1300_UDMA_INT		(AU1300_FIRST_INT + 79)
+#define AU1300_TOY_INT		(AU1300_FIRST_INT + 80)
+#define AU1300_TOY_MATCH0_INT	(AU1300_FIRST_INT + 81)
+#define AU1300_TOY_MATCH1_INT	(AU1300_FIRST_INT + 82)
+#define AU1300_TOY_MATCH2_INT	(AU1300_FIRST_INT + 83)
+#define AU1300_RTC_INT		(AU1300_FIRST_INT + 84)
+#define AU1300_RTC_MATCH0_INT	(AU1300_FIRST_INT + 85)
+#define AU1300_RTC_MATCH1_INT	(AU1300_FIRST_INT + 86)
+#define AU1300_RTC_MATCH2_INT	(AU1300_FIRST_INT + 87)
+#define AU1300_UART0_INT	(AU1300_FIRST_INT + 88)
+#define AU1300_SD0_INT		(AU1300_FIRST_INT + 89)
+#define AU1300_USB_INT		(AU1300_FIRST_INT + 90)
+#define AU1300_LCD_INT		(AU1300_FIRST_INT + 91)
+#define AU1300_BSA_INT		(AU1300_FIRST_INT + 92)
+#define AU1300_MPE_INT		(AU1300_FIRST_INT + 93)
+#define AU1300_ITE_INT		(AU1300_FIRST_INT + 94)
+#define AU1300_AES_INT		(AU1300_FIRST_INT + 95)
+#define AU1300_CIM_INT		(AU1300_FIRST_INT + 96)
+
+/**********************************************************************/
+
 /*
  * SDRAM register offsets
  */
@@ -692,22 +814,38 @@ enum soc_au1200_ints {
 
 /*
  * Physical base addresses for integrated peripherals
- * 0..au1000 1..au1500 2..au1100 3..au1550 4..au1200
+ * 0..au1000 1..au1500 2..au1100 3..au1550 4..au1200 5..au1300
  */
 
 #define AU1000_AC97_PHYS_ADDR		0x10000000 /* 012 */
+#define AU1300_ROM_PHYS_ADDR		0x10000000 /* 5 */
+#define AU1300_OTP_PHYS_ADDR		0x10002000 /* 5 */
+#define AU1300_VSS_PHYS_ADDR		0x10003000 /* 5 */
+#define AU1300_UART0_PHYS_ADDR		0x10100000 /* 5 */
+#define AU1300_UART1_PHYS_ADDR		0x10101000 /* 5 */
+#define AU1300_UART2_PHYS_ADDR		0x10102000 /* 5 */
+#define AU1300_UART3_PHYS_ADDR		0x10103000 /* 5 */
 #define AU1000_USB_OHCI_PHYS_ADDR	0x10100000 /* 012 */
 #define AU1000_USB_UDC_PHYS_ADDR	0x10200000 /* 0123 */
+#define AU1300_GPIC_PHYS_ADDR		0x10200000 /* 5 */
 #define AU1000_IRDA_PHYS_ADDR		0x10300000 /* 02 */
-#define AU1200_AES_PHYS_ADDR		0x10300000 /* 4 */
+#define AU1200_AES_PHYS_ADDR		0x10300000 /* 45 */
 #define AU1000_IC0_PHYS_ADDR		0x10400000 /* 01234 */
+#define AU1300_GPU_PHYS_ADDR		0x10500000 /* 5 */
 #define AU1000_MAC0_PHYS_ADDR		0x10500000 /* 023 */
 #define AU1000_MAC1_PHYS_ADDR		0x10510000 /* 023 */
 #define AU1000_MACEN_PHYS_ADDR		0x10520000 /* 023 */
-#define AU1100_SD0_PHYS_ADDR		0x10600000 /* 24 */
+#define AU1100_SD0_PHYS_ADDR		0x10600000 /* 245 */
+#define AU1300_SD1_PHYS_ADDR		0x10601000 /* 5 */
+#define AU1300_SD2_PHYS_ADDR		0x10602000 /* 5 */
 #define AU1100_SD1_PHYS_ADDR		0x10680000 /* 24 */
+#define AU1300_SYS_PHYS_ADDR		0x10900000 /* 5 */
 #define AU1550_PSC2_PHYS_ADDR		0x10A00000 /* 3 */
 #define AU1550_PSC3_PHYS_ADDR		0x10B00000 /* 3 */
+#define AU1300_PSC0_PHYS_ADDR		0x10A00000 /* 5 */
+#define AU1300_PSC1_PHYS_ADDR		0x10A01000 /* 5 */
+#define AU1300_PSC2_PHYS_ADDR		0x10A02000 /* 5 */
+#define AU1300_PSC3_PHYS_ADDR		0x10A03000 /* 5 */
 #define AU1000_I2S_PHYS_ADDR		0x11000000 /* 02 */
 #define AU1500_MAC0_PHYS_ADDR		0x11500000 /* 1 */
 #define AU1500_MAC1_PHYS_ADDR		0x11510000 /* 1 */
@@ -721,37 +859,96 @@ enum soc_au1200_ints {
 #define AU1000_SSI1_PHYS_ADDR		0x11680000 /* 02 */
 #define AU1500_GPIO2_PHYS_ADDR		0x11700000 /* 1234 */
 #define AU1000_IC1_PHYS_ADDR		0x11800000 /* 01234 */
-#define AU1000_SYS_PHYS_ADDR		0x11900000 /* 01234 */
+#define AU1000_SYS_PHYS_ADDR		0x11900000 /* 012345 */
 #define AU1550_PSC0_PHYS_ADDR		0x11A00000 /* 34 */
 #define AU1550_PSC1_PHYS_ADDR		0x11B00000 /* 34 */
 #define AU1000_MEM_PHYS_ADDR		0x14000000 /* 01234 */
 #define AU1000_STATIC_MEM_PHYS_ADDR	0x14001000 /* 01234 */
+#define AU1300_UDMA_PHYS_ADDR		0x14001800 /* 5 */
 #define AU1000_DMA_PHYS_ADDR		0x14002000 /* 012 */
-#define AU1550_DBDMA_PHYS_ADDR		0x14002000 /* 34 */
-#define AU1550_DBDMA_CONF_PHYS_ADDR	0x14003000 /* 34 */
+#define AU1550_DBDMA_PHYS_ADDR		0x14002000 /* 345 */
+#define AU1550_DBDMA_CONF_PHYS_ADDR	0x14003000 /* 345 */
 #define AU1000_MACDMA0_PHYS_ADDR	0x14004000 /* 0123 */
 #define AU1000_MACDMA1_PHYS_ADDR	0x14004200 /* 0123 */
-#define AU1200_CIM_PHYS_ADDR		0x14004000 /* 4 */
+#define AU1200_CIM_PHYS_ADDR		0x14004000 /* 45 */
 #define AU1500_PCI_PHYS_ADDR		0x14005000 /* 13 */
 #define AU1550_PE_PHYS_ADDR		0x14008000 /* 3 */
 #define AU1200_MAEBE_PHYS_ADDR		0x14010000 /* 4 */
 #define AU1200_MAEFE_PHYS_ADDR		0x14012000 /* 4 */
+#define AU1300_MAEITE_PHYS_ADDR		0x14010000 /* 5 */
+#define AU1300_MAEMPE_PHYS_ADDR		0x14014000 /* 5 */
 #define AU1550_USB_OHCI_PHYS_ADDR	0x14020000 /* 3 */
 #define AU1200_USB_CTL_PHYS_ADDR	0x14020000 /* 4 */
 #define AU1200_USB_OTG_PHYS_ADDR	0x14020020 /* 4 */
 #define AU1200_USB_OHCI_PHYS_ADDR	0x14020100 /* 4 */
 #define AU1200_USB_EHCI_PHYS_ADDR	0x14020200 /* 4 */
 #define AU1200_USB_UDC_PHYS_ADDR	0x14022000 /* 4 */
+#define AU1300_USB_EHCI_PHYS_ADDR	0x14020000 /* 5 */
+#define AU1300_USB_OHCI0_PHYS_ADDR	0x14020400 /* 5 */
+#define AU1300_USB_OHCI1_PHYS_ADDR	0x14020800 /* 5 */
+#define AU1300_USB_CTL_PHYS_ADDR	0x14021000 /* 5 */
+#define AU1300_USB_OTG_PHYS_ADDR	0x14022000 /* 5 */
+#define AU1300_MAEBSA_PHYS_ADDR		0x14030000 /* 5 */
 #define AU1100_LCD_PHYS_ADDR		0x15000000 /* 2 */
-#define AU1200_LCD_PHYS_ADDR		0x15000000 /* 4 */
+#define AU1200_LCD_PHYS_ADDR		0x15000000 /* 45 */
 #define AU1500_PCI_MEM_PHYS_ADDR	0x400000000ULL /* 13 */
 #define AU1500_PCI_IO_PHYS_ADDR		0x500000000ULL /* 13 */
 #define AU1500_PCI_CONFIG0_PHYS_ADDR	0x600000000ULL /* 13 */
 #define AU1500_PCI_CONFIG1_PHYS_ADDR	0x680000000ULL /* 13 */
-#define AU1000_PCMCIA_IO_PHYS_ADDR	0xF00000000ULL /* 01234 */
-#define AU1000_PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL /* 01234 */
-#define AU1000_PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL /* 01234 */
+#define AU1000_PCMCIA_IO_PHYS_ADDR	0xF00000000ULL /* 012345 */
+#define AU1000_PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL /* 012345 */
+#define AU1000_PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL /* 012345 */
+
+/**********************************************************************/
+
 
+/*
+ * Au1300 GPIO+INT controller (GPIC) register offsets and bits
+ * Registers are 128bits (0x10 bytes), divided into 4 "banks".
+ */
+#define AU1300_GPIC_PINVAL	0x0000
+#define AU1300_GPIC_PINVALCLR	0x0010
+#define AU1300_GPIC_IPEND	0x0020
+#define AU1300_GPIC_PRIENC	0x0030
+#define AU1300_GPIC_IEN		0x0040	/* int_mask in manual */
+#define AU1300_GPIC_IDIS	0x0050	/* int_maskclr in manual */
+#define AU1300_GPIC_DMASEL	0x0060
+#define AU1300_GPIC_DEVSEL	0x0080
+#define AU1300_GPIC_DEVCLR	0x0090
+#define AU1300_GPIC_RSTVAL	0x00a0
+/* pin configuration space. one 32bit register for up to 128 IRQs */
+#define AU1300_GPIC_PINCFG	0x1000
+
+#define GPIC_GPIO_TO_BIT(gpio)	\
+	(1 << ((gpio) & 0x1f))
+
+#define GPIC_GPIO_BANKOFF(gpio)	\
+	(((gpio) >> 5) * 4)
+
+/* Pin Control bits: who owns the pin, what does it do */
+#define GPIC_CFG_PC_GPIN		0
+#define GPIC_CFG_PC_DEV			1
+#define GPIC_CFG_PC_GPOLOW		2
+#define GPIC_CFG_PC_GPOHIGH		3
+#define GPIC_CFG_PC_MASK		3
+
+/* assign pin to MIPS IRQ line */
+#define GPIC_CFG_IL_SET(x)	(((x) & 3) << 2)
+#define GPIC_CFG_IL_MASK	(3 << 2)
+
+/* pin interrupt type setup */
+#define GPIC_CFG_IC_OFF		(0 << 4)
+#define GPIC_CFG_IC_LEVEL_LOW	(1 << 4)
+#define GPIC_CFG_IC_LEVEL_HIGH	(2 << 4)
+#define GPIC_CFG_IC_EDGE_FALL	(5 << 4)
+#define GPIC_CFG_IC_EDGE_RISE	(6 << 4)
+#define GPIC_CFG_IC_EDGE_BOTH	(7 << 4)
+#define GPIC_CFG_IC_MASK	(7 << 4)
+
+/* allow interrupt to wake cpu from 'wait' */
+#define GPIC_CFG_IDLEWAKE	(1 << 7)
+
+/***********************************************************************/
 
 /* Static Bus Controller */
 #define MEM_STCFG0		0xB4001000
@@ -770,14 +967,12 @@ enum soc_au1200_ints {
 #define MEM_STTIME3		0xB4001034
 #define MEM_STADDR3		0xB4001038
 
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
 #define MEM_STNDCTL		0xB4001100
 #define MEM_STSTAT		0xB4001104
 
 #define MEM_STNAND_CMD		0x0
 #define MEM_STNAND_ADDR 	0x4
 #define MEM_STNAND_DATA 	0x20
-#endif
 
 
 /* Programmable Counters 0 and 1 */
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
index 2fdacfe..14b26ff 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
@@ -187,6 +187,39 @@ typedef volatile struct au1xxx_ddma_desc {
 #define DSCR_CMD0_CIM_SYNC	26
 #endif /* CONFIG_SOC_AU1200 */
 
+#ifdef CONFIG_SOC_AU1300
+#define DSCR_CMD0_UART0_TX      0
+#define DSCR_CMD0_UART0_RX      1
+#define DSCR_CMD0_UART1_TX      2
+#define DSCR_CMD0_UART1_RX      3
+#define DSCR_CMD0_UART2_TX      4
+#define DSCR_CMD0_UART2_RX      5
+#define DSCR_CMD0_UART3_TX      6
+#define DSCR_CMD0_UART3_RX      7
+#define DSCR_CMD0_SDMS_TX0      8
+#define DSCR_CMD0_SDMS_RX0      9
+#define DSCR_CMD0_SDMS_TX1      10
+#define DSCR_CMD0_SDMS_RX1      11
+#define DSCR_CMD0_AES_TX        12
+#define DSCR_CMD0_AES_RX        13
+#define DSCR_CMD0_PSC0_TX       14
+#define DSCR_CMD0_PSC0_RX       15
+#define DSCR_CMD0_PSC1_TX       16
+#define DSCR_CMD0_PSC1_RX       17
+#define DSCR_CMD0_PSC2_TX       18
+#define DSCR_CMD0_PSC2_RX       19
+#define DSCR_CMD0_PSC3_TX       20
+#define DSCR_CMD0_PSC3_RX       21
+#define DSCR_CMD0_LCD           22
+#define DSCR_CMD0_NAND_FLASH    23
+#define DSCR_CMD0_SDMS_TX2      24
+#define DSCR_CMD0_SDMS_RX2      25
+#define DSCR_CMD0_CIM_SYNC      26
+#define DSCR_CMD0_UDMA          27
+#define DSCR_CMD0_DMA_REQ0      28
+#define DSCR_CMD0_DMA_REQ1      29
+#endif /* CONFIG_SOC_AU1300 */
+
 #define DSCR_CMD0_THROTTLE	30
 #define DSCR_CMD0_ALWAYS	31
 #define DSCR_NDEV_IDS		32
diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1300.h b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
new file mode 100644
index 0000000..5d3bf5e
--- /dev/null
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
@@ -0,0 +1,250 @@
+/*
+ * gpio-au1300.h -- GPIO control for Au1300 and compatibles.
+ *
+ * Copyright (c) 2009-2010 Manuel Lauss <manuel.lauss@gmail.com>
+ */
+
+#ifndef _GPIO_AU1300_H_
+#define _GPIO_AU1300_H_
+
+#include <asm/addrspace.h>
+#include <asm/io.h>
+#include <asm/mach-au1x00/au1000.h>
+
+#define AU1300_GPIO_BASE	0
+#define AU1300_GPIO_NUM		75
+#define AU1300_GPIO_MAX		(AU1300_GPIO_BASE + AU1300_GPIO_NUM - 1)
+
+#define AU1300_GPIC_ADDR	\
+	(void __iomem *)KSEG1ADDR(AU1300_GPIC_PHYS_ADDR)
+
+static inline int au1300_gpio_get_value(unsigned int gpio)
+{
+	void __iomem *roff = AU1300_GPIC_ADDR;
+	int bit;
+
+	gpio -= AU1300_GPIO_BASE;
+	roff += GPIC_GPIO_BANKOFF(gpio);
+	bit = GPIC_GPIO_TO_BIT(gpio);
+	return __raw_readl(roff + AU1300_GPIC_PINVAL) & bit;
+}
+
+static inline int au1300_gpio_direction_input(unsigned int gpio)
+{
+	void __iomem *roff = AU1300_GPIC_ADDR;
+	unsigned long bit;
+
+	gpio -= AU1300_GPIO_BASE;
+
+	roff += GPIC_GPIO_BANKOFF(gpio);
+	bit = GPIC_GPIO_TO_BIT(gpio);
+	__raw_writel(bit, roff + AU1300_GPIC_DEVCLR);
+	wmb();
+
+	return 0;
+}
+
+static inline int au1300_gpio_set_value(unsigned int gpio, int v)
+{
+	void __iomem *roff = AU1300_GPIC_ADDR;
+	unsigned long bit;
+
+	gpio -= AU1300_GPIO_BASE;
+
+	roff += GPIC_GPIO_BANKOFF(gpio);
+	bit = GPIC_GPIO_TO_BIT(gpio);
+	__raw_writel(bit, roff + (v ? AU1300_GPIC_PINVAL
+				    : AU1300_GPIC_PINVALCLR));
+	wmb();
+
+	return 0;
+}
+
+static inline int au1300_gpio_direction_output(unsigned int gpio, int v)
+{
+	/* hw switches to output automatically */
+	return au1300_gpio_set_value(gpio, v);
+}
+
+static inline int au1300_gpio_to_irq(unsigned int gpio)
+{
+	return AU1300_FIRST_INT + (gpio - AU1300_GPIO_BASE);
+}
+
+static inline int au1300_irq_to_gpio(unsigned int irq)
+{
+	return (irq - AU1300_FIRST_INT) + AU1300_GPIO_BASE;
+}
+
+static inline int au1300_gpio_is_valid(unsigned int gpio)
+{
+	return ((gpio >= AU1300_GPIO_BASE) && (gpio <= AU1300_GPIO_MAX));
+}
+
+static inline int au1300_gpio_cansleep(unsigned int gpio)
+{
+	return 0;
+}
+
+static inline void alchemy_gpio1_input_enable(void)
+{
+	__raw_writel(0, (void __iomem *)KSEG1ADDR(AU1300_SYS_PHYS_ADDR) + 0x110);
+	wmb();
+}
+
+/* hardware remembers gpio 0-63 levels on powerup */
+static inline int au1300_gpio_getinitlvl(unsigned int gpio)
+{
+	void __iomem *roff = AU1300_GPIC_ADDR;
+	unsigned long v;
+
+	if (unlikely(gpio > 63))
+		return 0;
+	else if (gpio > 31) {
+		gpio -= 32;
+		roff += 4;
+	}
+
+	v = __raw_readl(roff + AU1300_GPIC_RSTVAL);
+	return (v >> gpio) & 1;
+}
+
+/**********************************************************************/
+
+/* Linux gpio framework integration.
+*
+* 4 use cases of Alchemy GPIOS:
+*(1) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=y:
+*	Board must register gpiochips.
+*(2) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=n:
+*	A gpiochip for the 75 GPIOs is registered.
+*
+*(3) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=y:
+*	the boards' gpio.h must provide	the linux gpio wrapper functions,
+*
+*(4) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=n:
+*	inlinable gpio functions are provided which enable access to the
+*	Au1300 gpios only by using the numbers straight out of the data-
+*	sheets.
+
+* Cases 1 and 3 are intended for boards which want to provide their own
+* GPIO namespace and -operations (i.e. for example you have 8 GPIOs
+* which are in part provided by spare Au1300 GPIO pins and in part by
+* an external FPGA but you still want them to be accssible in linux
+* as gpio0-7. The board can of course use the alchemy_gpioX_* functions
+* as required).
+*/
+
+#ifndef CONFIG_GPIOLIB
+
+
+#ifndef CONFIG_ALCHEMY_GPIO_INDIRECT	/* case (4) */
+
+static inline int gpio_direction_input(unsigned int gpio)
+{
+	return au1300_gpio_direction_input(gpio);
+}
+
+static inline int gpio_direction_output(unsigned int gpio, int v)
+{
+	return au1300_gpio_direction_output(gpio, v);
+}
+
+static inline int gpio_get_value(unsigned int gpio)
+{
+	return au1300_gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value(unsigned int gpio, int v)
+{
+	au1300_gpio_set_value(gpio, v);
+}
+
+static inline int gpio_get_value_cansleep(unsigned gpio)
+{
+	return gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value_cansleep(unsigned gpio, int value)
+{
+	gpio_set_value(gpio, value);
+}
+
+static inline int gpio_is_valid(unsigned int gpio)
+{
+	return au1300_gpio_is_valid(gpio);
+}
+
+static inline int gpio_cansleep(unsigned int gpio)
+{
+	return au1300_gpio_cansleep(gpio);
+}
+
+static inline int gpio_to_irq(unsigned int gpio)
+{
+	return au1300_gpio_to_irq(gpio);
+}
+
+static inline int irq_to_gpio(unsigned int irq)
+{
+	return au1300_irq_to_gpio(irq);
+}
+
+static inline int gpio_request(unsigned int gpio, const char *label)
+{
+	return 0;
+}
+
+static inline void gpio_free(unsigned int gpio)
+{
+}
+
+static inline int gpio_set_debounce(unsigned gpio, unsigned debounce)
+{
+	return -ENOSYS;
+}
+
+static inline void gpio_unexport(unsigned gpio)
+{
+}
+
+static inline int gpio_export(unsigned gpio, bool direction_may_change)
+{
+	return -ENOSYS;
+}
+
+static inline int gpio_sysfs_set_active_low(unsigned gpio, int value)
+{
+	return -ENOSYS;
+}
+
+static inline int gpio_export_link(struct device *dev, const char *name,
+				   unsigned gpio)
+{
+	return -ENOSYS;
+}
+
+#endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
+
+
+#else	/* CONFIG GPIOLIB */
+
+
+/* using gpiolib to provide up to 2 gpio_chips for on-chip gpios */
+#ifndef CONFIG_ALCHEMY_GPIO_INDIRECT	/* case (2) */
+
+/* get everything through gpiolib */
+#define gpio_to_irq	__gpio_to_irq
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define irq_to_gpio	au1300_irq_to_gpio
+
+#include <asm-generic/gpio.h>
+
+#endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
+
+
+#endif	/* !CONFIG_GPIOLIB */
+
+#endif /* _GPIO_AU1300_H_ */
diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h b/arch/mips/include/asm/mach-au1x00/gpio.h
index c3f60cd..4d6edea 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio.h
@@ -5,6 +5,10 @@
 
 #include <asm/mach-au1x00/gpio-au1000.h>
 
+#elif defined(CONFIG_ALCHEMY_GPIOINT_AU1300)
+
+#include <asm/mach-au1x00/gpio-au1300.h>
+
 #endif
 
 #endif	/* _ALCHEMY_GPIO_H_ */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index bb133d1..50da1a8 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1011,6 +1011,13 @@ static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
 {
 	decode_configs(c);
 
+	if ((c->processor_id & 0xff00) == PRID_IMP_NETLOGIC_AU13XX) {
+		c->cputype = CPU_ALCHEMY;
+		__cpu_name[cpu] = "Au1300";
+		/* following stuff is not for Alchemy */
+		return;
+	}
+
 	c->options = (MIPS_CPU_TLB       |
 			MIPS_CPU_4KEX    |
 			MIPS_CPU_COUNTER |
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 646068e..afafa35 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -300,11 +300,11 @@ config I2C_AT91
 	  unless your system can cope with those limitations.
 
 config I2C_AU1550
-	tristate "Au1550/Au1200 SMBus interface"
-	depends on SOC_AU1550 || SOC_AU1200
+	tristate "Au1550/Au1200/Au1300 SMBus interface"
+	depends on MIPS_ALCHEMY
 	help
 	  If you say yes to this option, support will be included for the
-	  Au1550 and Au1200 SMBus interface.
+	  Au1550/Au1200/Au1300 SMBus interface.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-au1550.
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index de35c3a..aac451e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -90,12 +90,12 @@ config SPI_BFIN_SPORT
 	  will be called spi_bfin_sport.
 
 config SPI_AU1550
-	tristate "Au1550/Au12x0 SPI Controller"
-	depends on (SOC_AU1550 || SOC_AU1200) && EXPERIMENTAL
+	tristate "Au1550/Au12x0/Au13xx SPI Controller"
+	depends on MIPS_ALCHEMY && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  If you say yes to this option, support will be included for the
-	  Au1550 SPI controller (may also work with Au1200,Au1210,Au1250).
+	  PSC SPI controller found on Au1550, Au12xx, Au13xx.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called au1550_spi.
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 48f1781..ec33212 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -56,7 +56,7 @@ config USB_ARCH_HAS_EHCI
 	boolean
 	default y if PPC_83xx
 	default y if PPC_MPC512x
-	default y if SOC_AU1200
+	default y if MIPS_ALCHEMY
 	default y if ARCH_IXP4XX
 	default y if ARCH_W90X900
 	default y if ARCH_AT91SAM9G45
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index f8030ee..d561d4e 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1191,7 +1191,7 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_hcd_sh_driver
 #endif
 
-#ifdef CONFIG_SOC_AU1200
+#ifdef CONFIG_MIPS_ALCHEMY
 #include "ehci-au1xxx.c"
 #define	PLATFORM_DRIVER		ehci_hcd_au1xxx_driver
 #endif
diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
index 299d719..a89396b 100644
--- a/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -89,7 +89,7 @@ static const struct hc_driver ohci_au1xxx_hc_driver = {
 
 static int ohci_hcd_au1xxx_drv_probe(struct platform_device *pdev)
 {
-	int ret;
+	int ret, unit;
 	struct usb_hcd *hcd;
 
 	if (usb_disabled())
@@ -120,7 +120,9 @@ static int ohci_hcd_au1xxx_drv_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
-	if (alchemy_usb_control(ALCHEMY_USB_OHCI0, 1)) {
+	unit = (hcd->rsrc_start == AU1300_USB_OHCI1_PHYS_ADDR) ?
+			ALCHEMY_USB_OHCI1 : ALCHEMY_USB_OHCI0;
+	if (alchemy_usb_control(unit, 1)) {
 		printk(KERN_INFO "%s: controller init failed!\n", pdev->name);
 		ret = -ENODEV;
 		goto err3;
@@ -135,7 +137,7 @@ static int ohci_hcd_au1xxx_drv_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	alchemy_usb_control(ALCHEMY_USB_OHCI0, 0);
+	alchemy_usb_control(unit, 0);
 err3:
 	iounmap(hcd->regs);
 err2:
@@ -148,9 +150,12 @@ err1:
 static int ohci_hcd_au1xxx_drv_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	int unit;
 
+	unit = (hcd->rsrc_start == AU1300_USB_OHCI1_PHYS_ADDR) ?
+			ALCHEMY_USB_OHCI1 : ALCHEMY_USB_OHCI0;
 	usb_remove_hcd(hcd);
-	alchemy_usb_control(ALCHEMY_USB_OHCI0, 0);
+	alchemy_usb_control(unit, 0);
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 5e19de9..e2155fe 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1754,16 +1754,16 @@ config FB_AU1100
 	  au1100fb:panel=<name>.
 
 config FB_AU1200
-	bool "Au1200 LCD Driver"
-	depends on (FB = y) && MIPS && SOC_AU1200
+	bool "Au1200/Au1300 LCD Driver"
+	depends on (FB = y) && MIPS_ALCHEMY
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
 	select FB_SYS_FOPS
 	help
-	  This is the framebuffer driver for the AMD Au1200 SOC.  It can drive
-	  various panels and CRTs by passing in kernel cmd line option
-	  au1200fb:panel=<name>.
+	  This is the framebuffer driver for the Au1200/Au1300 SOCs.
+	  It can drive various panels and CRTs by passing in kernel cmd line
+	  option au1200fb:panel=<name>.
 
 config FB_VT8500
 	bool "VT8500 LCD Driver"
diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 4b67140..894428b 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -2,12 +2,12 @@
 ## Au1200/Au1550 PSC + DBDMA
 ##
 config SND_SOC_AU1XPSC
-	tristate "SoC Audio for Au1200/Au1250/Au1550"
-	depends on SOC_AU1200 || SOC_AU1550
+	tristate "SoC Audio for Au12xx/Au13xx/Au1550"
+	depends on MIPS_ALCHEMY
 	help
 	  This option enables support for the Programmable Serial
 	  Controllers in AC97 and I2S mode, and the Descriptor-Based DMA
-	  Controller (DBDMA) as found on the Au1200/Au1250/Au1550 SoC.
+	  Controller (DBDMA) as found on the Au12xx/Au13xx/Au1550 SoC.
 
 config SND_SOC_AU1XPSC_I2S
 	tristate
-- 
1.7.6
