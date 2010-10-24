Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2010 20:37:16 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:51029 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491119Ab0JXSgt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Oct 2010 20:36:49 +0200
Received: by wyf22 with SMTP id 22so2735558wyf.36
        for <linux-mips@linux-mips.org>; Sun, 24 Oct 2010 11:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=iqosYp6XkgBIgWIKGb8ryvdBsP+IofO8Tvnfv5FsJSw=;
        b=Ou3QKlReEWB5nlF5AnYdlfr8Emil6IBpLMg16ieJRUwl63wXWC3lywu1A4ORVOHz4L
         hwW5MaxsarS+SoSJ76+8nHa6a83m/i0IU1jzFhGddVOSMfb1+4WpR3vtEiQiFwpoClwm
         kdv1bv5RP1W1PI1SOmA+BxlyLjHtTRFPMzfWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gd3RvIH1B4YYIGqgBfZwNZRHXdOou9zkrQJMJXmJzuQWUM5oWrT6xNDUoM2p9J/Gk7
         lP5Yctfy6DEIDyXTxtR9Sw3ntCmSA1bZBZ7vi7MjtzKgxDSQJgZO/seakK/W+fn2So73
         IdylVLrBbsGIgu+j2L6tVujLrs1X297yxrJmM=
Received: by 10.227.151.205 with SMTP id d13mr4431518wbw.159.1287945402778;
        Sun, 24 Oct 2010 11:36:42 -0700 (PDT)
Received: from localhost.localdomain (188-22-0-103.adsl.highway.telekom.at [188.22.0.103])
        by mx.google.com with ESMTPS id i19sm4836481wbe.11.2010.10.24.11.36.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 11:36:41 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RESEND 1/2] MIPS: Alchemy: Au1300 SoC support
Date:   Sun, 24 Oct 2010 20:36:32 +0200
Message-Id: <1287945393-10080-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1287945393-10080-1-git-send-email-manuel.lauss@googlemail.com>
References: <1287945393-10080-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Add support for the Au1300 SoC: New GPIO/Interrupt controller code,
basic integration.  Sleepcode taken from RMI sources.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/Kconfig                        |    9 +
 arch/mips/alchemy/common/Makefile                |    2 +
 arch/mips/alchemy/common/dbdma.c                 |   48 ++-
 arch/mips/alchemy/common/gpioint.c               |  468 ++++++++++++++++++++++
 arch/mips/alchemy/common/gpiolib-au1300.c        |   54 +++
 arch/mips/alchemy/common/platform.c              |    9 +
 arch/mips/alchemy/common/power.c                 |    9 +-
 arch/mips/alchemy/common/sleeper.S               |   73 ++++
 arch/mips/alchemy/common/time.c                  |    1 +
 arch/mips/include/asm/cpu.h                      |    8 +
 arch/mips/include/asm/mach-au1x00/au1000.h       |  198 +++++++++-
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |   33 ++
 arch/mips/include/asm/mach-au1x00/gpio-au1300.h  |  250 ++++++++++++
 arch/mips/include/asm/mach-au1x00/gpio.h         |    4 +
 arch/mips/kernel/cpu-probe.c                     |   18 +
 drivers/i2c/busses/Kconfig                       |    6 +-
 drivers/spi/Kconfig                              |    2 +-
 drivers/video/Kconfig                            |    8 +-
 sound/soc/au1x/Kconfig                           |    6 +-
 19 files changed, 1187 insertions(+), 19 deletions(-)
 create mode 100644 arch/mips/alchemy/common/gpioint.c
 create mode 100644 arch/mips/alchemy/common/gpiolib-au1300.c
 create mode 100644 arch/mips/include/asm/mach-au1x00/gpio-au1300.h

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 2ccfd4a..21b232c 100644
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
@@ -158,3 +162,8 @@ config SOC_AU1550
 config SOC_AU1200
 	bool
 	select ALCHEMY_GPIOINT_AU1000
+
+config SOC_AU1300
+	bool
+	select SOC_AU1X00
+	select ALCHEMY_GPIOINT_AU1300
diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index 27811fe..3b3f0ae 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -9,11 +9,13 @@ obj-y += prom.o time.o clocks.o platform.o power.o setup.o \
 	sleeper.o dma.o dbdma.o
 
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
index ca0506a..aedb7e5 100644
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
@@ -151,6 +149,47 @@ static dbdev_tab_t dbdev_tab[] = {
 
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
 
@@ -1073,6 +1112,9 @@ static int __init au1xxx_dbdma_init(void)
 	case ALCHEMY_CPU_AU1200:
 		irq_nr = AU1200_DDMA_INT;
 		break;
+	case ALCHEMY_CPU_AU1300:
+		irq_nr = AU1300_DDMA_INT;
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -1094,5 +1136,3 @@ static int __init au1xxx_dbdma_init(void)
 	return ret;
 }
 subsys_initcall(au1xxx_dbdma_init);
-
-#endif /* defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200) */
diff --git a/arch/mips/alchemy/common/gpioint.c b/arch/mips/alchemy/common/gpioint.c
new file mode 100644
index 0000000..bf2df8d
--- /dev/null
+++ b/arch/mips/alchemy/common/gpioint.c
@@ -0,0 +1,468 @@
+/*
+ * gpioint.c - Au1300 GPIO+Interrupt controller support.
+ *
+ * Copyright (c) 2009-2010 Manuel Lauss <manuel.lauss@gmail.com>
+ *
+ * licensed under the GPLv2.
+ */
+
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sysdev.h>
+#include <linux/types.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/gpio-au1300.h>
+
+#if 0
+#define DBG(x...)	printk(KERN_INFO "GPIC " x)
+#else
+#define DBG(x...)
+#endif
+
+static int au1300_gpic_settype(unsigned int irq, unsigned int type);
+
+/* setup for known onchip sources */
+struct gpic_devint_data {
+	int irq;	/* linux IRQ number */
+	int type;	/* IRQ_TYPE_ */
+	int prio;	/* irq priority, 0 highest, 3 lowest */
+	int internal;	/* internal-only source (no ext. pin)? */
+};
+
+struct gpic_devint_data au1300_devints[] __initdata = {
+	/* multifunction: gpio/device */
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
+	/* au1300 internal-only ints */
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
+struct alchemy_gpic_sysdev {
+	struct sys_device sysdev;
+	void __iomem *base;
+	unsigned long icr[6];
+	unsigned long pincfg[128];
+};
+
+
+/*
+ * au1300_gpic_modcfg - change PIN configuration.
+ * @gpio:	pin to change (0-based GPIO number from datasheet).
+ * @clr:	clear all bits set in 'clr'.
+ * @set:	set these bits.
+ *
+ * modifies a pins' configuration register, bits set in @clr will
+ * be cleared in the register, bits in @set will be set.
+ * NOTE: according to the datasheet, this should only be called
+ * for disabled interrupts!
+ */
+static inline void au1300_gpic_modcfg(unsigned int gpio,
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
+
+	DBG("MODCFG(%03d) %08lx %08lx -> %08lx\n", gpio, clr, set, l);
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
+
+	DBG("PIN2GPIN(%03d)\n", (int)gpio);
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
+
+	DBG("PIN2DEV(%03d)\n", (int)gpio);
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
+	au1300_gpic_modcfg(irq, GPIC_CFG_IL_MASK, GPIC_CFG_IL_SET(p));
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
+static void gpic_pin_set_idlewake(unsigned int gpio, int allow)
+{
+	au1300_gpic_modcfg(gpio, GPIC_CFG_IDLEWAKE,
+			   allow ? GPIC_CFG_IDLEWAKE : 0);
+
+	DBG("SETIDLEWAKE(%03d) %d\n", gpio, allow);
+}
+
+static void au1300_gpic_mask(unsigned int irq)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long bit;
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
+static void au1300_gpic_unmask(unsigned int irq)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long bit;
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
+static void au1300_gpic_maskack(unsigned int irq)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long bit;
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
+static void au1300_gpic_ack(unsigned int irq)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long bit;
+
+	irq -= ALCHEMY_GPIC_INT_BASE;
+	r += GPIC_GPIO_BANKOFF(irq);
+	bit = GPIC_GPIO_TO_BIT(irq);
+	__raw_writel(bit, r + AU1300_GPIC_IPEND);	/* ack */
+	wmb();
+}
+
+static struct irq_chip au1300_gpic = {
+	.name		= "Au1300-GPIOINT",
+	.ack		= au1300_gpic_ack,
+	.mask		= au1300_gpic_mask,
+	.mask_ack	= au1300_gpic_maskack,
+	.unmask		= au1300_gpic_unmask,
+	.set_type	= au1300_gpic_settype,
+};
+
+#define SICHN(i, h, n)		\
+	set_irq_chip_and_handler_name(i, &au1300_gpic, h, n)
+
+static int au1300_gpic_settype(unsigned int irq, unsigned int type)
+{
+	unsigned long s;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		s = GPIC_CFG_IC_LEVEL_HIGH;
+		SICHN(irq, handle_level_irq, "highlevel");
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		s = GPIC_CFG_IC_LEVEL_LOW;
+		SICHN(irq, handle_level_irq, "lowlevel");
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		s = GPIC_CFG_IC_EDGE_RISE;
+		SICHN(irq, handle_edge_irq, "riseedge");
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		s = GPIC_CFG_IC_EDGE_FALL;
+		SICHN(irq, handle_edge_irq, "falledge");
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		s = GPIC_CFG_IC_EDGE_BOTH;
+		SICHN(irq, handle_edge_irq, "bothedge");
+		break;
+	case IRQ_TYPE_NONE:
+		s = GPIC_CFG_IC_OFF;
+		SICHN(irq, handle_level_irq, "disabled");
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	au1300_gpic_modcfg(irq - ALCHEMY_GPIC_INT_BASE,
+			   GPIC_CFG_IC_MASK, s);
+
+	return 0;
+}
+
+static void __init alchemy_gpic_init_irq(struct gpic_devint_data *dints)
+{
+	int i;
+	void __iomem *bank_base;
+
+	mips_cpu_irq_init();
+
+	/* disable & ack all possible on-chip sources */
+	for (i = 0; i < 4; i++) {
+		bank_base = AU1300_GPIC_ADDR + (i * 4);
+		__raw_writel(~0UL, bank_base + AU1300_GPIC_IDIS);
+		wmb();
+		__raw_writel(~0UL, bank_base + AU1300_GPIC_IPEND);
+		wmb();
+	}
+
+	/* register all possible irq sources, with 2nd highest priority */
+	bank_base = AU1300_GPIC_ADDR + AU1300_GPIC_PINCFG;
+	for (i = ALCHEMY_GPIC_INT_BASE; i <= ALCHEMY_GPIC_INT_LAST; i++) {
+		au1300_set_irq_priority(i, 1);
+		au1300_gpic_settype(i, IRQ_TYPE_NONE);
+	}
+
+	/* setup known on-chip sources */
+	while ((i = dints->irq) != -1) {
+		au1300_gpic_settype(i, dints->type);
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
+static int alchemy_gpic_suspend(struct sys_device *dev, pm_message_t state)
+{
+	struct alchemy_gpic_sysdev *icdev =
+		container_of(dev, struct alchemy_gpic_sysdev, sysdev);
+	void __iomem *addy;
+	int i;
+
+	/* save pin configuration */
+	addy = icdev->base + AU1300_GPIC_PINCFG;
+	for (i = 0; i < 128; i++)
+		icdev->pincfg[i] = __raw_readl(addy + (i << 2));
+
+	/* save interrupt mask status */
+	icdev->icr[0] = __raw_readl(icdev->base + AU1300_GPIC_IEN + 0x0);
+	icdev->icr[1] = __raw_readl(icdev->base + AU1300_GPIC_IEN + 0x4);
+	icdev->icr[2] = __raw_readl(icdev->base + AU1300_GPIC_IEN + 0x8);
+	icdev->icr[3] = __raw_readl(icdev->base + AU1300_GPIC_IEN + 0xc);
+
+	/* misc */
+	icdev->icr[4] = __raw_readl(icdev->base + AU1300_GPIC_DMASEL);
+	wmb();
+
+	return 0;
+}
+
+static int alchemy_gpic_resume(struct sys_device *dev)
+{
+	struct alchemy_gpic_sysdev *icdev =
+		container_of(dev, struct alchemy_gpic_sysdev, sysdev);
+	void __iomem *addy;
+	int i;
+
+	/* mask all off first */
+	__raw_writel(-1, icdev->base + AU1300_GPIC_IDIS + 0x0);
+	__raw_writel(-1, icdev->base + AU1300_GPIC_IDIS + 0x4);
+	__raw_writel(-1, icdev->base + AU1300_GPIC_IDIS + 0x8);
+	__raw_writel(-1, icdev->base + AU1300_GPIC_IDIS + 0xc);
+	wmb();
+
+	/* restore pin configurations */
+	addy = icdev->base + AU1300_GPIC_PINCFG;
+	for (i = 0; i < 128; i++)
+		__raw_writel(icdev->pincfg[i], addy + (i << 2));
+	wmb();
+
+	__raw_writel(icdev->icr[4], icdev->base + AU1300_GPIC_DMASEL);
+	wmb();
+
+	/* restore masks */
+	addy = icdev->base + AU1300_GPIC_IEN;
+	__raw_writel(icdev->icr[0], addy + 0x0);
+	wmb();
+	__raw_writel(icdev->icr[1], addy + 0x4);
+	wmb();
+	__raw_writel(icdev->icr[2], addy + 0x8);
+	wmb();
+	__raw_writel(icdev->icr[3], addy + 0xc);
+	wmb();
+
+	return 0;
+}
+
+static struct sysdev_class alchemy_gpic_sysdev_class = {
+	.name		= "gpic",
+	.suspend	= alchemy_gpic_suspend,
+	.resume		= alchemy_gpic_resume,
+};
+
+static int __init alchemy_gpic_sysdev_init(void)
+{
+	struct alchemy_gpic_sysdev *icdev;
+	int err;
+
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1300:
+		break;
+	default:		/* we don't handle these */
+		return 0;
+	}
+
+	err = sysdev_class_register(&alchemy_gpic_sysdev_class);
+	if (err)
+		return err;
+
+	icdev = kzalloc(sizeof(struct alchemy_gpic_sysdev), GFP_KERNEL);
+	if (!icdev)
+		return -ENOMEM;
+
+	icdev->base = (void __iomem *)KSEG1ADDR(AU1300_GPIC_PHYS_ADDR);
+
+	icdev->sysdev.id = -1;
+	icdev->sysdev.cls = &alchemy_gpic_sysdev_class;
+	err = sysdev_register(&icdev->sysdev);
+	if (err)
+		kfree(icdev);
+
+	return err;
+}
+device_initcall(alchemy_gpic_sysdev_init);
+
+/**********************************************************************/
+
+void __init arch_init_irq(void)
+{
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1300:
+		alchemy_gpic_init_irq(&au1300_devints[0]);
+		break;
+	}
+}
+
+void plat_irq_dispatch(void)
+{
+	unsigned long c = read_c0_cause(), s = read_c0_status();
+	int i;
+
+	DBG("M %08lx  S %08lx\n", c, s);
+	c &= s;
+
+	if (c & CAUSEF_IP7)		/* c0 timer */
+		i = MIPS_CPU_IRQ_BASE + 7 - ALCHEMY_GPIC_INT_BASE;
+	else if (c & (CAUSEF_IP2 | CAUSEF_IP3 | CAUSEF_IP4 | CAUSEF_IP5)) {
+		i = __raw_readl(AU1300_GPIC_ADDR + AU1300_GPIC_PRIENC);
+		DBG("I %d\n", i);
+		if (unlikely(i == 127))
+			goto spurious;
+	} else
+		goto spurious;
+
+	do_IRQ(i + ALCHEMY_GPIC_INT_BASE);
+	return;
+spurious:
+	spurious_interrupt();
+}
diff --git a/arch/mips/alchemy/common/gpiolib-au1300.c b/arch/mips/alchemy/common/gpiolib-au1300.c
new file mode 100644
index 0000000..661cc6f
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
+static int _gpic_get(struct gpio_chip *chip, unsigned int off)
+{
+	return au1300_gpio_get_value(off + AU1300_GPIO_BASE);
+}
+
+static void _gpic_set(struct gpio_chip *chip, unsigned int off, int v)
+{
+	au1300_gpio_set_value(off + AU1300_GPIO_BASE, v);
+}
+
+static int _gpic_direction_input(struct gpio_chip *chip, unsigned int off)
+{
+	return au1300_gpio_direction_input(off + AU1300_GPIO_BASE);
+}
+
+static int _gpic_direction_output(struct gpio_chip *chip, unsigned int off,
+				   int v)
+{
+	return au1300_gpio_direction_output(off + AU1300_GPIO_BASE, v);
+}
+
+static int _gpic_gpio_to_irq(struct gpio_chip *chip, unsigned int off)
+{
+	return au1300_gpio_to_irq(off + AU1300_GPIO_BASE);
+}
+
+static struct gpio_chip au1300_gpiochip = {
+	.label			= "au1300",
+	.direction_input	= _gpic_direction_input,
+	.direction_output	= _gpic_direction_output,
+	.get			= _gpic_get,
+	.set			= _gpic_set,
+	.to_irq			= _gpic_gpio_to_irq,
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
index 3691630..e9b15cc 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -83,6 +83,11 @@ static struct plat_serial8250_port au1x00_uart_data[] = {
 #elif defined(CONFIG_SOC_AU1200)
 	PORT(UART0_PHYS_ADDR, AU1200_UART0_INT),
 	PORT(UART1_PHYS_ADDR, AU1200_UART1_INT),
+#elif defined(CONFIG_SOC_AU1300)
+	PORT(AU1300_UART0_PHYS_ADDR, AU1300_UART0_INT),
+	PORT(AU1300_UART1_PHYS_ADDR, AU1300_UART1_INT),
+	PORT(AU1300_UART2_PHYS_ADDR, AU1300_UART2_INT),
+	PORT(AU1300_UART3_PHYS_ADDR, AU1300_UART3_INT),
 #endif
 	{ },
 };
@@ -95,6 +100,7 @@ static struct platform_device au1xx0_uart_device = {
 	},
 };
 
+#ifdef FOR_PLATFORM_C_USB_HOST_INT
 /* OHCI (USB full speed host controller) */
 static struct resource au1xxx_usb_ohci_resources[] = {
 	[0] = {
@@ -122,6 +128,7 @@ static struct platform_device au1xxx_usb_ohci_device = {
 	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
 	.resource	= au1xxx_usb_ohci_resources,
 };
+#endif
 
 /*** AU1100 LCD controller ***/
 
@@ -441,7 +448,9 @@ void __init au1xxx_override_eth_cfg(unsigned int port,
 
 static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&au1xx0_uart_device,
+#ifdef FOR_PLATFORM_C_USB_HOST_INT
 	&au1xxx_usb_ohci_device,
+#endif
 #ifdef CONFIG_FB_AU1100
 	&au1100_lcd_device,
 #endif
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index e5916a5..e516cca 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -49,7 +49,9 @@
  * We only have to save/restore registers that aren't otherwise
  * done as part of a driver pm_* function.
  */
+#ifndef CONFIG_SOC_AU1300	/* ugly but quick fix */
 static unsigned int sleep_usb[2];
+#endif
 static unsigned int sleep_sys_clocks[5];
 static unsigned int sleep_sys_pinfunc;
 static unsigned int sleep_static_memctlr[4][3];
@@ -58,6 +60,7 @@ static unsigned int sleep_static_memctlr[4][3];
 static void save_core_regs(void)
 {
 #ifndef CONFIG_SOC_AU1200
+#ifndef CONFIG_SOC_AU1300	/* doesn't apply to Au1300 USB */
 	/* Shutdown USB host/device. */
 	sleep_usb[0] = au_readl(USB_HOST_CONFIG);
 
@@ -70,7 +73,7 @@ static void save_core_regs(void)
 	sleep_usb[1] = au_readl(USBD_ENABLE);
 	au_writel(0, USBD_ENABLE);
 	au_sync();
-
+#endif /* au1300 */
 #else	/* AU1200 */
 
 	/* enable access to OTG mmio so we can save OTG CAP/MUX.
@@ -126,9 +129,11 @@ static void restore_core_regs(void)
 	au_sync();
 
 #ifndef CONFIG_SOC_AU1200
+#ifndef CONFIG_SOC_AU1300	/* doesn't apply to Au1300 either */
 	au_writel(sleep_usb[0], USB_HOST_CONFIG);
 	au_writel(sleep_usb[1], USBD_ENABLE);
 	au_sync();
+#endif
 #else
 	/* enable accces to OTG memory */
 	au_writel(au_readl(USB_MSR_BASE + 4) | (1 << 6), USB_MSR_BASE + 4);
@@ -165,6 +170,8 @@ void au_sleep(void)
 			alchemy_sleep_au1000();
 		else if (cpuid <= ALCHEMY_CPU_AU1200)
 			alchemy_sleep_au1550();
+		else if (cpuid <= ALCHEMY_CPU_AU1300)
+			alchemy_sleep_au1300();
 		restore_core_regs();
 	}
 }
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
index 2aecb2f..db82325 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -179,6 +179,7 @@ static int alchemy_m2inttab[] __initdata = {
 	AU1100_RTC_MATCH2_INT,
 	AU1550_RTC_MATCH2_INT,
 	AU1200_RTC_MATCH2_INT,
+	AU1300_RTC_MATCH2_INT,
 };
 
 void __init plat_time_init(void)
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index b201a8f..0304fc8 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -33,6 +33,7 @@
 #define PRID_COMP_TOSHIBA	0x070000
 #define PRID_COMP_LSI		0x080000
 #define PRID_COMP_LEXRA		0x0b0000
+#define PRID_COMP_RMI		0x0c0000
 #define PRID_COMP_CAVIUM	0x0d0000
 #define PRID_COMP_INGENIC	0xd00000
 
@@ -121,6 +122,13 @@
 #define PRID_REV_BCM6368	0x0030
 
 /*
+ * These are the PRID's for when 23:16 == PRID_COMP_RMI
+ */
+
+#define PRID_IMP_AU13XX		0x8000
+
+
+/*
  * These are the PRID's for when 23:16 == PRID_COMP_CAVIUM
  */
 
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index a697661..9f56925 100644
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
@@ -180,6 +184,68 @@ static inline void alchemy_uart_putchar(u32 uart_phys, u8 c)
 	wmb();
 }
 
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
 /* arch/mips/au1000/common/clocks.c */
 extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
@@ -190,17 +256,22 @@ extern unsigned long au1xxx_calc_clock(void);
 /* PM: arch/mips/alchemy/common/sleeper.S, power.c, irq.c */
 void alchemy_sleep_au1000(void);
 void alchemy_sleep_au1550(void);
+void alchemy_sleep_au1300(void);
 void au_sleep(void);
 
 
 /* SOC Interrupt numbers */
-
+/* Au1000-style (IC0/1): 2 controllers with 32 sources each */
 #define AU1000_INTC0_INT_BASE	(MIPS_CPU_IRQ_BASE + 8)
 #define AU1000_INTC0_INT_LAST	(AU1000_INTC0_INT_BASE + 31)
 #define AU1000_INTC1_INT_BASE	(AU1000_INTC0_INT_LAST + 1)
 #define AU1000_INTC1_INT_LAST	(AU1000_INTC1_INT_BASE + 31)
 #define AU1000_MAX_INTR 	AU1000_INTC1_INT_LAST
 
+/* Au1300-style (GPIC): 1 controller with up to 128 sources */
+#define ALCHEMY_GPIC_INT_BASE	(MIPS_CPU_IRQ_BASE + 8)
+#define ALCHEMY_GPIC_INT_LAST	(ALCHEMY_GPIC_INT_BASE + 127)
+
 enum soc_au1000_ints {
 	AU1000_FIRST_INT	= AU1000_INTC0_INT_BASE,
 	AU1000_UART0_INT	= AU1000_FIRST_INT,
@@ -521,6 +592,43 @@ enum soc_au1200_ints {
 
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
@@ -808,6 +916,46 @@ enum soc_au1200_ints {
 #define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
 #endif
 
+/**********************************************************************/
+
+#define AU1300_ROM_PHYS_ADDR	0x10000000
+#define AU1300_OTP_PHYS_ADDR	0x10002000
+#define AU1300_UART0_PHYS_ADDR	0x10100000
+#define AU1300_UART1_PHYS_ADDR	0x10101000
+#define AU1300_UART2_PHYS_ADDR	0x10102000
+#define AU1300_UART3_PHYS_ADDR	0x10103000
+#define AU1300_GPIC_PHYS_ADDR	0x10200000
+#define AU1300_AES_PHYS_ADDR	0x10300000
+#define AU1300_GPU_PHYS_ADDR	0x10500000
+#define AU1300_SD0_PHYS_ADDR	0x10600000
+#define AU1300_SD1_PHYS_ADDR	0x10601000
+#define AU1300_SD2_PHYS_ADDR	0x10602000
+#define AU1300_SYS_PHYS_ADDR	0x10900000
+#define AU1300_PSC0_PHYS_ADDR	0x10A00000
+#define AU1300_PSC1_PHYS_ADDR	0x10A01000
+#define AU1300_PSC2_PHYS_ADDR	0x10A02000
+#define AU1300_PSC3_PHYS_ADDR	0x10A03000
+#define AU1300_VSS_PHYS_ADDR	0x11003000
+
+#define AU1300_MEM_PHYS_ADDR	0x14000000
+#define AU1300_STATIC_PHYS_ADDR	0x14001000
+#define AU1300_UDMA_PHYS_ADDR	0x14001800
+#define AU1300_DDMA_PHYS_ADDR	0x14002000
+#define AU1300_CIM_PHYS_ADDR	0x14004000
+#define AU1300_MAEITE_PHYS_ADDR	0x14010000
+#define AU1300_MAEMPE_PHYS_ADDR	0x14014000
+#define AU1300_USB_PHYS_ADDR	0x14020000
+#define AU1300_MAEBSA_PHYS_ADDR	0x14030000
+#define AU1300_LCD_PHYS_ADDR	0x15000000
+
+#ifdef CONFIG_SOC_AU1300
+#define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
+#define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
+#define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
+#endif
+
+/**********************************************************************/
+
 /* Static Bus Controller */
 #define MEM_STCFG0		0xB4001000
 #define MEM_STTIME0		0xB4001004
@@ -825,14 +973,12 @@ enum soc_au1200_ints {
 #define MEM_STTIME3		0xB4001034
 #define MEM_STADDR3		0xB4001038
 
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
 #define MEM_STNDCTL		0xB4001100
 #define MEM_STSTAT		0xB4001104
 
 #define MEM_STNAND_CMD		0x0
 #define MEM_STNAND_ADDR 	0x4
 #define MEM_STNAND_DATA 	0x20
-#endif
 
 
 /* Interrupt Controller register offsets */
@@ -942,6 +1088,52 @@ enum soc_au1200_ints {
 
 #define IC1_TESTBIT		0xB1800080
 
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
 
 /* Au1000 */
 #ifdef CONFIG_SOC_AU1000
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
index c8a553a3..17101e1 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
@@ -195,6 +195,39 @@ typedef volatile struct au1xxx_ddma_desc {
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
index b1b304e..b456e89 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -854,6 +854,21 @@ static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
 	}
 }
 
+static inline void cpu_probe_rmi(struct cpuinfo_mips *c, int cpu)
+{
+	decode_configs(c);
+
+	switch (c->processor_id & 0xff00) {
+	case PRID_IMP_AU13XX:
+		c->cputype = CPU_ALCHEMY;
+		__cpu_name[cpu] = "Au13xx";
+		break;
+	default:
+		panic("Unknown RMI core!\n");
+		break;
+	}
+}
+
 static inline void cpu_probe_sibyte(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
@@ -1011,6 +1026,9 @@ __cpuinit void cpu_probe(void)
 	case PRID_COMP_NXP:
 		cpu_probe_nxp(c, cpu);
 		break;
+	case PRID_COMP_RMI:
+		cpu_probe_rmi(c, cpu);
+		break;
 	case PRID_COMP_CAVIUM:
 		cpu_probe_cavium(c, cpu);
 		break;
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 6539ac2..17afff8 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -296,11 +296,11 @@ config I2C_AT91
 	  unless your system can cope with those limitations.
 
 config I2C_AU1550
-	tristate "Au1550/Au1200 SMBus interface"
-	depends on SOC_AU1550 || SOC_AU1200
+	tristate "Au1550/Au1200/Au1300 SMBus interface"
+	depends on SOC_AU1550 || SOC_AU1200 || SOC_AU1300
 	help
 	  If you say yes to this option, support will be included for the
-	  Au1550 and Au1200 SMBus interface.
+	  Au1550/Au1200/Au1300 SMBus interface.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-au1550.
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4b9eec6..09bfc76 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -68,7 +68,7 @@ config SPI_BFIN
 
 config SPI_AU1550
 	tristate "Au1550/Au12x0 SPI Controller"
-	depends on (SOC_AU1550 || SOC_AU1200) && EXPERIMENTAL
+	depends on (SOC_AU1550 || SOC_AU1200 || SOC_AU1300) && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  If you say yes to this option, support will be included for the
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8b31fdf..ee23979 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1711,14 +1711,14 @@ config FB_AU1100
 
 config FB_AU1200
 	bool "Au1200 LCD Driver"
-	depends on (FB = y) && MIPS && SOC_AU1200
+	depends on (FB = y) && MIPS && (SOC_AU1200 || SOC_AU1300)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	help
-	  This is the framebuffer driver for the AMD Au1200 SOC.  It can drive
-	  various panels and CRTs by passing in kernel cmd line option
-	  au1200fb:panel=<name>.
+	  This is the framebuffer driver for the AMD Au1200/Au1300 SOCs.
+	  It can drive various panels and CRTs by passing in kernel cmd line
+	  option au1200fb:panel=<name>.
 
 source "drivers/video/geode/Kconfig"
 
diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 4b67140..09a7216 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -2,12 +2,12 @@
 ## Au1200/Au1550 PSC + DBDMA
 ##
 config SND_SOC_AU1XPSC
-	tristate "SoC Audio for Au1200/Au1250/Au1550"
-	depends on SOC_AU1200 || SOC_AU1550
+	tristate "SoC Audio for Au12xx/Au13xx0/Au1550"
+	depends on SOC_AU1200 || SOC_AU1550 || SOC_AU1300
 	help
 	  This option enables support for the Programmable Serial
 	  Controllers in AC97 and I2S mode, and the Descriptor-Based DMA
-	  Controller (DBDMA) as found on the Au1200/Au1250/Au1550 SoC.
+	  Controller (DBDMA) as found on the Au12xx/Au13xx/Au1550 SoC.
 
 config SND_SOC_AU1XPSC_I2S
 	tristate
-- 
1.7.3.2
