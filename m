Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 20:27:30 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:37407 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494032AbZKCT1H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2009 20:27:07 +0100
Received: by ewy12 with SMTP id 12so963634ewy.0
        for <linux-mips@linux-mips.org>; Tue, 03 Nov 2009 11:27:00 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CStglZw6E/lQ0bCBs3dxBD85T68wvIcAQK3zR8E00UU=;
        b=UefaKs1RjHGgBEG8mbfTGFja/ji1m+dKhoeGfDUO7eyBl0oV9BmIPTQPoyDq+pa3W+
         4gH8HuxefEZaLzdi8qnIg2E7F85Jnn1eYyA6X8jkwMZQFtf1O3kq/8muh2w10HOhLR5K
         grvGt+PAlIf83Se/5/6cA2ciNIihgIoPF6AjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=agx4BfVIVy6YmqnW+fWQTueVOy47fI5jJ1AmbibejC+SxfeqYW/BCa+HYLtwKMHfY0
         llnk8Jcd6lzDuDSasaj76sa4qGqy4HTkninXkgcQ4tZgWSoe9uqpRyRM8RLRdvcA+6uP
         wzBY6pqem17PS3YYOeq/zf8hGlMZCUUqn8U2c=
Received: by 10.216.87.68 with SMTP id x46mr167431wee.2.1257276419936;
        Tue, 03 Nov 2009 11:26:59 -0800 (PST)
Received: from localhost.localdomain (p5496F342.dip.t-dialin.net [84.150.243.66])
        by mx.google.com with ESMTPS id p10sm1157027gvf.29.2009.11.03.11.26.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 11:26:59 -0800 (PST)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Kevin Hickey <khickey@netlogicmicro.com>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH -queue 1/2] MIPS: Alchemy: Au1300 SoC support
Date:	Tue,  3 Nov 2009 20:27:02 +0100
Message-Id: <1257276423-26413-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1257276423-26413-1-git-send-email-manuel.lauss@gmail.com>
References: <1257276423-26413-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Add support for the Au1300 SoC: New GPIO/Interrupt controller code,
basic integration.

doesn't work quite right yet: serial console uart doesn't generate
enough interrupts.

---
 arch/mips/alchemy/Kconfig                        |   23 +-
 arch/mips/alchemy/common/Makefile                |    9 +-
 arch/mips/alchemy/common/dbdma.c                 |   48 +++-
 arch/mips/alchemy/common/gpioint.c               |  374 ++++++++++++++++++++++
 arch/mips/alchemy/common/gpiolib-au1300.c        |   54 +++
 arch/mips/alchemy/common/platform.c              |    9 +
 arch/mips/alchemy/common/power.c                 |   18 +-
 arch/mips/alchemy/common/time.c                  |    1 +
 arch/mips/include/asm/cpu.h                      |    8 +
 arch/mips/include/asm/mach-au1x00/au1000.h       |  189 +++++++++++
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |   33 ++
 arch/mips/include/asm/mach-au1x00/gpio-au1300.h  |  211 ++++++++++++
 arch/mips/include/asm/mach-au1x00/gpio.h         |    4 +
 arch/mips/kernel/cpu-probe.c                     |   18 +
 drivers/i2c/busses/Kconfig                       |    2 +-
 drivers/spi/Kconfig                              |    2 +-
 drivers/video/Kconfig                            |   10 +-
 17 files changed, 987 insertions(+), 26 deletions(-)
 create mode 100644 arch/mips/alchemy/common/gpioint.c
 create mode 100644 arch/mips/alchemy/common/gpiolib-au1300.c
 create mode 100644 arch/mips/include/asm/mach-au1x00/gpio-au1300.h

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 22f4ff5..478699e 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -1,5 +1,9 @@
-# au1000-style gpio
-config ALCHEMY_GPIO_AU1000
+# au1000-style GPIO and interrupt controller
+config ALCHEMY_GPIOINT_AU1000
+	bool
+
+# au1300-style GPIO/INT controller
+config ALCHEMY_GPIOINT_AU1300
 	bool
 
 # select this in your board config if you don't want to use the gpio
@@ -133,27 +137,32 @@ endchoice
 config SOC_AU1000
 	bool
 	select SOC_AU1X00
-	select ALCHEMY_GPIO_AU1000
+	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1100
 	bool
 	select SOC_AU1X00
-	select ALCHEMY_GPIO_AU1000
+	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1500
 	bool
 	select SOC_AU1X00
-	select ALCHEMY_GPIO_AU1000
+	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1550
 	bool
 	select SOC_AU1X00
-	select ALCHEMY_GPIO_AU1000
+	select ALCHEMY_GPIOINT_AU1000
 
 config SOC_AU1200
 	bool
 	select SOC_AU1X00
-	select ALCHEMY_GPIO_AU1000
+	select ALCHEMY_GPIOINT_AU1000
+
+config SOC_AU1300
+	bool
+	select SOC_AU1X00
+	select ALCHEMY_GPIOINT_AU1300
 
 config SOC_AU1X00
 	bool
diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index abf0eb1..fd983c0 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -5,14 +5,17 @@
 # Makefile for the Alchemy Au1xx0 CPUs, generic files.
 #
 
-obj-y += prom.o irq.o time.o reset.o \
-	clocks.o platform.o power.o setup.o \
+obj-y += prom.o time.o reset.o clocks.o platform.o power.o setup.o \
 	sleeper.o dma.o dbdma.o
 
+obj-$(CONFIG_ALCHEMY_GPIOINT_AU1000) += irq.o
+obj-$(CONFIG_ALCHEMY_GPIOINT_AU1300) += gpioint.o
+
 # optional gpiolib support
 ifeq ($(CONFIG_ALCHEMY_GPIO_INDIRECT),)
  ifeq ($(CONFIG_GPIOLIB),y)
-  obj-$(CONFIG_ALCHEMY_GPIO_AU1000) += gpiolib-au1000.o
+  obj-$(CONFIG_ALCHEMY_GPIOINT_AU1000) += gpiolib-au1000.o
+  obj-$(CONFIG_ALCHEMY_GPIOINT_AU1300) += gpiolib-au1300.o
  endif
 endif
 
diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 4cab5a6..2e2787a 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -39,8 +39,6 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
-
 /*
  * The Descriptor Based DMA supports up to 16 channels.
  *
@@ -150,6 +148,47 @@ static dbdev_tab_t dbdev_tab[] = {
 
 #endif /* CONFIG_SOC_AU1200 */
 
+#ifdef CONFIG_SOC_AU1300
+	{ DSCR_CMD0_UART0_TX, DEV_FLAGS_OUT, 0, 8,  0x10100004, 0, 0 },
+	{ DSCR_CMD0_UART0_RX, DEV_FLAGS_IN,  0, 8,  0x10100000, 0, 0 },
+	{ DSCR_CMD0_UART1_TX, DEV_FLAGS_OUT, 0, 8,  0x01011004, 0, 0 },
+	{ DSCR_CMD0_UART1_RX, DEV_FLAGS_IN,  0, 8,  0x10101000, 0, 0 },
+	{ DSCR_CMD0_UART2_TX, DEV_FLAGS_OUT, 0, 8,  0x01012004, 0, 0 },
+	{ DSCR_CMD0_UART2_RX, DEV_FLAGS_IN,  0, 8,  0x10102000, 0, 0 },
+	{ DSCR_CMD0_UART3_TX, DEV_FLAGS_OUT, 0, 8,  0x01013004, 0, 0 },
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
 
@@ -1040,6 +1079,9 @@ static int __init au1xxx_dbdma_init(void)
 	case ALCHEMY_CPU_AU1200:
 		irq_nr = AU1200_DDMA_INT;
 		break;
+	case ALCHEMY_CPU_AU1300:
+		irq_nr = AU1300_DDMA_INT;
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -1056,5 +1098,3 @@ static int __init au1xxx_dbdma_init(void)
 	return ret;
 }
 subsys_initcall(au1xxx_dbdma_init);
-
-#endif /* defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200) */
diff --git a/arch/mips/alchemy/common/gpioint.c b/arch/mips/alchemy/common/gpioint.c
new file mode 100644
index 0000000..98f3b1b
--- /dev/null
+++ b/arch/mips/alchemy/common/gpioint.c
@@ -0,0 +1,374 @@
+/*
+ * gpioint.c - Au1300 GPIO+Interrupt controller support.
+ *
+ * Copyright (c) 2009 Manuel Lauss <manuel.lauss@gmail.com>
+ *
+ * licensed under the GPLv2.
+ */
+
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/gpio-au1300.h>
+
+#if 1
+#define DBG(x...)	printk(KERN_INFO "GPIC " x)
+#else
+#define DBG(x...)
+#endif
+
+static int au1300_gpic_settype(unsigned int irq, unsigned int type);
+
+/* setup for known onchip sources */
+static struct gpic_devint_data {
+	int irq;	/* linux IRQ number */
+	int type; 	/* IRQ_TYPE_ */
+	int prio;	/* irq priority, 0 highest, 3 lowest */
+	int setdev;	/* assign to device function? */
+} au1300_devints[] __initdata = {
+	/* multifunction pins */
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
+
+	/* au1300 internal device ints */
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
+
+	{ -1, },	/* terminator */
+};
+
+
+/**
+ * au1300_gpic_modcfg - change PIN configuration.
+ * @pin:	pin to change (0-based GPIO number from datasheet).
+ * @clr:	clear all bits set in 'clr'.
+ * @set:	set these bits.
+ *
+ * modifies a pins' configuration register, bits set in @clr will
+ * be cleared in the register, and bits in @set will be set in the reg.
+ */
+void au1300_gpic_modcfg(int pin, unsigned long clr, unsigned long set)
+{
+	unsigned long l;
+	void __iomem *r;
+
+	r = AU1300_GPIC_ADDR + (pin * 4);
+
+	l = __raw_readl(r + AU1300_GPIC_PINCFG);
+	l &= ~clr;
+	l |= set;
+	__raw_writel(l, r + AU1300_GPIC_PINCFG);
+	wmb();
+
+	DBG("MODCFG(%03d) %08lx %08lx -> %08lx\n", pin, clr, set, l);
+}
+EXPORT_SYMBOL_GPL(au1300_gpic_modcfg);	/* used by GPIO code too */
+
+/**
+ * au1300_irq_set_idlewake - allow irq to wake CPU from 'wait' state.
+ * @irq:	irq to change permission of.
+ * @allow:	set 1 to allow @irq to wake CPU from 'wait'.
+ *
+ * Allow/Disallow an IRQ line to wake the CPU from 'wait' states.  By
+ * default all unmasked IRQs are allowed to wake the CPU, this function
+ * should be used to override this if required.
+ */
+void au1300_irq_set_idlewake(int irq, int allow)
+{
+	irq -= AU1300_FIRST_INT;
+	au1300_gpic_modcfg(irq, GPIC_CFG_IDLEWAKE,
+			   allow ? GPIC_CFG_IDLEWAKE : 0);
+
+	DBG("SETIDLEWAKE(%03d) %d\n", irq, allow);
+}
+EXPORT_SYMBOL_GPL(au1300_irq_set_idlewake);
+
+/**
+ * au1300_pinfunc_to_gpio - assign a pin as GPIO input (GPIO ctrl).
+ * @pin:	pin (0-based GPIO number from datasheet).
+ *
+ * Assigns a GPIO pin to the GPIO controller, so its level can either
+ * be read or set through the generic GPIO functions.
+ * If you need a GPOUT, use au1300_gpio_set_value(pin, 0/1).
+ */
+void au1300_pinfunc_to_gpio(enum au1300_multifunc_pins pin)
+{
+	/* switch to GPIN.  Usually pin==gpio */
+	au1300_gpio_direction_input(pin + AU1300_GPIO_BASE);
+
+	DBG("PIN2GPIN(%03d)\n", (int)pin);
+}
+EXPORT_SYMBOL_GPL(au1300_pinfunc_to_gpio);
+
+/**
+ * au1300_pinfunc_to_dev - assign a pin to the device function.
+ * @pin:	pin (0-based GPIO number from datasheet).
+ *
+ * Assigns a GPIO pin to its associated device function; the pin will be
+ * driven by the device and not through GPIO functions.
+ */
+void au1300_pinfunc_to_dev(enum au1300_multifunc_pins pin)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long bit;
+
+	r += AU1300_GPIO_TO_BANK(pin) * 4;
+	bit = 1 << AU1300_GPIO_TO_BIT(pin);
+	__raw_writel(bit, r + AU1300_GPIC_DEVSEL);
+	wmb();
+
+	DBG("PIN2DEV(%03d)\n", (int)pin);
+}
+EXPORT_SYMBOL_GPL(au1300_pinfunc_to_dev);
+
+/**
+ * au1300_set_irq_priority -  set internal priority of IRQ.
+ * @irq:	irq to set priority.
+ * @p:		priority (0 = highest, 3 = lowest).
+ */
+void au1300_set_irq_priority(unsigned int irq, int p)
+{
+	irq -= AU1300_FIRST_INT;
+	au1300_gpic_modcfg(irq, GPIC_CFG_IL_MASK, GPIC_CFG_IL_SET(p));
+}
+EXPORT_SYMBOL_GPL(au1300_set_irq_priority);
+
+/**
+ * au1300_set_dbdma_gpio - assign a gpio to one of the DBDMA triggers.
+ * @dchan:	dbdma trigger select (0, 1).
+ * @pin:	pin to assign as trigger.
+ *
+ * DBDMA controller has 2 external trigger sources; this function
+ * assigns a GPIO to the selected trigger.
+ */
+void au1300_set_dbdma_gpio(int dchan, unsigned int pin)
+{
+	unsigned long r;
+
+	if ((dchan >= 0) && (dchan <= 1)) {
+		r = __raw_readl(AU1300_GPIC_ADDR + AU1300_GPIC_DMASEL);
+		r &= ~(0xff << (8 * dchan));
+		r |= (pin & 0x7f) << (8 * dchan);
+		__raw_writel(r, AU1300_GPIC_ADDR + AU1300_GPIC_DMASEL);
+		wmb();
+	}
+}
+
+/**********************************************************************/
+
+static void au1300_gpic_mask(unsigned int irq)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long bit;
+
+	irq -= AU1300_FIRST_INT;
+	r += AU1300_GPIO_TO_BANK(irq) * 4;
+	bit = 1 << AU1300_GPIO_TO_BIT(irq);
+	__raw_writel(bit, r + AU1300_GPIC_IDIS);
+	wmb();
+}
+
+static void au1300_gpic_unmask(unsigned int irq)
+{
+	void __iomem *r = AU1300_GPIC_ADDR;
+	unsigned long bit;
+
+	irq -= AU1300_FIRST_INT;
+	r += AU1300_GPIO_TO_BANK(irq) * 4;
+	bit = 1 << AU1300_GPIO_TO_BIT(irq);
+	__raw_writel(bit, r + AU1300_GPIC_IEN);
+	wmb();
+}
+
+static void au1300_gpic_maskack(unsigned int irq)
+{
+	unsigned long bit;
+	void __iomem *r;
+
+	irq -= AU1300_FIRST_INT;
+	r = AU1300_GPIC_ADDR + (AU1300_GPIO_TO_BANK(irq) * 4);
+	bit = 1 << AU1300_GPIO_TO_BIT(irq);
+	__raw_writel(bit, r + AU1300_GPIC_IPEND);	/* ack */
+	__raw_writel(bit, r + AU1300_GPIC_IDIS);
+	wmb();
+}
+
+static void au1300_gpic_ack(unsigned int irq)
+{
+	unsigned long bit;
+	void __iomem *r;
+
+	irq -= AU1300_FIRST_INT;
+	r = AU1300_GPIC_ADDR + (AU1300_GPIO_TO_BANK(irq) * 4);
+	bit = 1 << AU1300_GPIO_TO_BIT(irq);
+	__raw_writel(bit, r + AU1300_GPIC_IPEND);	/* ack */
+	wmb();
+}
+
+static unsigned int au1300_gpic_startup(unsigned int irq)
+{
+	au1300_gpic_modcfg(irq - AU1300_FIRST_INT, 0, GPIC_CFG_IDLEWAKE);
+	au1300_gpic_unmask(irq);
+	return 0;
+}
+
+static void au1300_gpic_shutdown(unsigned int irq)
+{
+	au1300_gpic_maskack(irq);
+	au1300_gpic_modcfg(irq - AU1300_FIRST_INT, GPIC_CFG_IDLEWAKE, 0);
+}
+
+static struct irq_chip au1300_gpic = {
+	.name		= "Au1300-GPIOINT",
+	.startup	= au1300_gpic_startup,
+	.shutdown	= au1300_gpic_shutdown,
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
+	int ret;
+
+	ret = 0;
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		s = GPIC_CFG_IC_LEVEL_HIGH;
+		SICHN(irq, handle_level_irq, "hilevel");
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		s = GPIC_CFG_IC_LEVEL_LOW;
+		SICHN(irq, handle_level_irq, "lolevel");
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
+	au1300_gpic_modcfg(irq - AU1300_FIRST_INT, GPIC_CFG_IC_MASK, s);
+
+	return ret;
+}
+
+void __init arch_init_irq(void)
+{
+	int i;
+	void __iomem *bank_phys;
+	struct gpic_devint_data *dints;
+
+	DBG("INIT START\n");
+
+	mips_cpu_irq_init();
+
+	/* disable & ack all possible on-chip sources */
+	for (i = 0; i < 4; i++) {
+		bank_phys = AU1300_GPIC_ADDR + (i * 4);
+		__raw_writel(~0UL, bank_phys + AU1300_GPIC_IPEND);
+		__raw_writel(~0UL, bank_phys + AU1300_GPIC_IDIS);
+		wmb();
+	}
+
+	/* register all possible irq sources, with 2nd highest priority */
+	for (i = AU1300_FIRST_INT; i <= AU1300_LAST_INT; i++) {
+		au1300_set_irq_priority(i, 1);
+		au1300_gpic_settype(i, IRQ_TYPE_NONE);
+	}
+
+	/* setup known on-chip sources */
+	dints = &au1300_devints[0];
+	while (dints->irq != -1) {
+		i = dints->irq;
+		au1300_gpic_settype(i, dints->type);
+		au1300_set_irq_priority(i, dints->prio);
+
+		/* assign to device function immediately? */
+		if (dints->setdev)
+			au1300_pinfunc_to_dev(au1300_irq_to_gpio(i));
+
+		dints++;
+	}
+
+	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
+
+	DBG("INIT DONE\n");
+}
+
+void plat_irq_dispatch(void)
+{
+	unsigned long c = read_c0_cause() & read_c0_status();
+	int d;
+
+/*	DBG("INT CnM  %08lx\n", c); */
+
+	if (c & CAUSEF_IP7)		/* c0 timer */
+		d = MIPS_CPU_IRQ_BASE + 7;
+	else if (c & (CAUSEF_IP2 | CAUSEF_IP3 | CAUSEF_IP4 | CAUSEF_IP5)) {
+		d = __raw_readl(AU1300_GPIC_ADDR + AU1300_GPIC_PRIENC);
+/* XXX: HACK */
+		if ((d != 87) && (d != 25))
+			DBG("INT GPIC %d\n", d);
+/* XXX */
+		d += AU1300_FIRST_INT;
+	} else
+		goto spurious;
+
+	do_IRQ(d);
+	return;
+spurious:
+	DBG("SPURIOUS\n");
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
index e47b035..6716570 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -69,6 +69,11 @@ static struct plat_serial8250_port au1x00_uart_data[] = {
 #elif defined(CONFIG_SOC_AU1200)
 	PORT(UART0_PHYS_ADDR, AU1200_UART0_INT),
 	PORT(UART1_PHYS_ADDR, AU1200_UART1_INT),
+#elif defined(CONFIG_SOC_AU1300)
+	PORT(AU1300_UART0_PHYS_ADDR, AU1300_UART0_INT),
+	PORT(AU1300_UART1_PHYS_ADDR, AU1300_UART1_INT),
+	PORT(AU1300_UART2_PHYS_ADDR, AU1300_UART2_INT),
+	PORT(AU1300_UART3_PHYS_ADDR, AU1300_UART3_INT),
 #endif
 #endif	/* CONFIG_SERIAL_8250_AU1X00 */
 	{ },
@@ -82,6 +87,7 @@ static struct platform_device au1xx0_uart_device = {
 	},
 };
 
+#ifdef FOR_PLATFORM_C_USB_HOST_INT
 /* OHCI (USB full speed host controller) */
 static struct resource au1xxx_usb_ohci_resources[] = {
 	[0] = {
@@ -109,6 +115,7 @@ static struct platform_device au1xxx_usb_ohci_device = {
 	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
 	.resource	= au1xxx_usb_ohci_resources,
 };
+#endif
 
 /*** AU1100 LCD controller ***/
 
@@ -345,7 +352,9 @@ static struct platform_device pbdb_smbus_device = {
 
 static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&au1xx0_uart_device,
+#ifdef FOR_PLATFORM_C_USB_HOST_INT
 	&au1xxx_usb_ohci_device,
+#endif
 #ifdef CONFIG_FB_AU1100
 	&au1100_lcd_device,
 #endif
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index cf37e27..334e6f2 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -36,7 +36,8 @@
 
 #include <asm/uaccess.h>
 #include <asm/mach-au1x00/au1000.h>
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200) || \
+    defined(CONFIG_SOC_AU1300)
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #endif
 
@@ -52,7 +53,9 @@
  * We only have to save/restore registers that aren't otherwise
  * done as part of a driver pm_* function.
  */
+#ifndef CONFIG_SOC_AU1300
 static unsigned int sleep_usb[2];
+#endif
 static unsigned int sleep_sys_clocks[5];
 static unsigned int sleep_sys_pinfunc;
 static unsigned int sleep_static_memctlr[4][3];
@@ -61,7 +64,8 @@ static unsigned int sleep_static_memctlr[4][3];
 static void save_core_regs(void)
 {
 #ifndef CONFIG_SOC_AU1200
-	/* Shutdown USB host/device. */
+#ifndef CONFIG_SOC_AU1300
+/* Shutdown USB host/device. */
 	sleep_usb[0] = au_readl(USB_HOST_CONFIG);
 
 	/* There appears to be some undocumented reset register.... */
@@ -73,7 +77,7 @@ static void save_core_regs(void)
 	sleep_usb[1] = au_readl(USBD_ENABLE);
 	au_writel(0, USBD_ENABLE);
 	au_sync();
-
+#endif /* au1300 */
 #else	/* AU1200 */
 
 	/* enable access to OTG mmio so we can save OTG CAP/MUX.
@@ -112,7 +116,8 @@ static void save_core_regs(void)
 	sleep_static_memctlr[3][1] = au_readl(MEM_STTIME3);
 	sleep_static_memctlr[3][2] = au_readl(MEM_STADDR3);
 
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200) || \
+    defined(CONFIG_SOC_AU1300)
 	au1xxx_dbdma_suspend();
 #endif
 }
@@ -136,9 +141,11 @@ static void restore_core_regs(void)
 	au_sync();
 
 #ifndef CONFIG_SOC_AU1200
+#ifndef CONFIG_SOC_AU1300
 	au_writel(sleep_usb[0], USB_HOST_CONFIG);
 	au_writel(sleep_usb[1], USBD_ENABLE);
 	au_sync();
+#endif
 #else
 	/* enable accces to OTG memory */
 	au_writel(au_readl(USB_MSR_BASE + 4) | (1 << 6), USB_MSR_BASE + 4);
@@ -167,7 +174,8 @@ static void restore_core_regs(void)
 
 	restore_au1xxx_intctl();
 
-#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200) || \
+    defined(CONFIG_AOC_AU1300)
 	au1xxx_dbdma_resume();
 #endif
 }
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
index 4b96d1a..cd883c8 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -33,6 +33,7 @@
 #define PRID_COMP_TOSHIBA	0x070000
 #define PRID_COMP_LSI		0x080000
 #define PRID_COMP_LEXRA		0x0b0000
+#define PRID_COMP_RMI		0x0c0000
 #define PRID_COMP_CAVIUM	0x0d0000
 
 
@@ -121,6 +122,13 @@
 #define PRID_REV_BCM6368	0x0030
 
 /*
+ * These are the PRID's for when 23:16 == PRID_COMP_RMI
+ */
+
+#define PRID_IMP_AU13XX	 	0x8000
+
+
+/*
  * These are the PRID's for when 23:16 == PRID_COMP_CAVIUM
  */
 
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index e049d15..17373f9 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -136,6 +136,7 @@ static inline int au1xxx_cpu_needs_config_od(void)
 #define ALCHEMY_CPU_AU1100	2
 #define ALCHEMY_CPU_AU1550	3
 #define ALCHEMY_CPU_AU1200	4
+#define ALCHEMY_CPU_AU1300	5
 
 static inline int alchemy_get_cputype(void)
 {
@@ -155,6 +156,9 @@ static inline int alchemy_get_cputype(void)
 	case 0x04030000:
 		return ALCHEMY_CPU_AU1200;
 		break;
+	case 0x800c0000:
+		return ALCHEMY_CPU_AU1300;
+		break;
 	}
 
 	return ALCHEMY_CPU_UNKNOWN;
@@ -179,6 +183,71 @@ static inline void alchemy_uart_putchar(u32 uart_phys, u8 c)
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
+/* arch/mips/alchemy/common/gpioint.c */
+extern void au1300_gpic_modcfg(int gpio, unsigned long clr,
+			       unsigned long set);
+extern void au1300_irq_set_idlewake(int irq, int allow);
+extern void au1300_pinfunc_to_gpio(enum au1300_multifunc_pins pin);
+extern void au1300_pinfunc_to_dev(enum au1300_multifunc_pins pin);
+extern void au1300_set_irq_priority(unsigned int irq, int p);
+extern void au1300_set_dbdma_gpio(int dchan, unsigned int gpio);
+
 /* arch/mips/au1000/common/clocks.c */
 extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
@@ -521,6 +590,44 @@ enum soc_au1200_ints {
 
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
+/* Au1300 peripheral interrupt numbers */
+#define AU1300_FIRST_INT	(MIPS_CPU_IRQ_BASE + 8)
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
+#define AU1300_LAST_INT		AU1300_CIM_INT
+
+/**********************************************************************/
+
 /*
  * SDRAM register offsets
  */
@@ -808,6 +915,43 @@ enum soc_au1200_ints {
 #define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
 #endif
 
+/**********************************************************************/
+
+#ifdef CONFIG_SOC_AU1300
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
+#define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
+#define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
+#define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
+#endif
+
 /* Static Bus Controller */
 #define MEM_STCFG0		0xB4001000
 #define MEM_STTIME0		0xB4001004
@@ -910,6 +1054,50 @@ enum soc_au1200_ints {
 
 #define IC1_TESTBIT		0xB1800080
 
+/*
+ * Au1300 GPIO+INT controller (GPIC) register offsets and bits
+ */
+#define AU1300_GPIC_PINVAL	0x0000
+#define AU1300_GPIC_PINVALCLR	0x0010
+#define AU1300_GPIC_IPEND	0x0020
+#define AU1300_GPIC_PRIENC	0x0030
+#define AU1300_GPIC_IEN		0x0040
+#define AU1300_GPIC_IDIS	0x0050
+#define AU1300_GPIC_DMASEL	0x0060
+#define AU1300_GPIC_DEVSEL	0x0080
+#define AU1300_GPIC_DEVCLR	0x0090
+/* pin configuration space. one 32bit register for each gpio starting here */
+#define AU1300_GPIC_PINCFG	0x1000
+
+#define AU1300_GPIO_TO_BIT(gpio)	\
+	((gpio) & 0x1f)
+
+#define AU1300_GPIO_TO_BANK(gpio)	\
+	((gpio) >> 5)
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
@@ -1008,6 +1196,7 @@ enum soc_au1200_ints {
 
 #endif /* CONFIG_SOC_AU1200 */
 
+
 /* Programmable Counters 0 and 1 */
 #define SYS_BASE		0xB1900000
 #define SYS_COUNTER_CNTRL	(SYS_BASE + 0x14)
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
index c098b45..5662aa7 100644
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
index 0000000..76e2ff1
--- /dev/null
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
@@ -0,0 +1,211 @@
+/*
+ * gpio-au1300.h -- inlinable GPIO control for Au1300
+ *
+ * Copyright (c) 2009 Manuel Lauss <manuel.lauss@gmail.com>
+ */
+
+#ifndef _GPIO_AU1300_H_
+#define _GPIO_AU1300_H_
+
+#include <asm/addrspace.h>
+#include <asm/io.h>
+#include <asm/mach-au1x00/au1000.h>
+
+/* 75 GPIOs in one block, yay! */
+#define AU1300_GPIO_BASE	0
+#define AU1300_GPIO_NUM		75
+#define AU1300_GPIO_MAX		(AU1300_GPIO_BASE + AU1300_GPIO_NUM - 1)
+
+#define AU1300_GPIC_ADDR	\
+	(void __iomem *)KSEG1ADDR(AU1300_GPIC_PHYS_ADDR)
+
+static inline int au1300_gpio_get_value(int gpio)
+{
+	void __iomem *roff;
+	int bit;
+
+	gpio -= AU1300_GPIO_BASE;
+
+	bit = 1 << AU1300_GPIO_TO_BIT(gpio);
+	roff = AU1300_GPIC_ADDR;
+	roff += (AU1300_GPIO_TO_BANK(gpio) * 4);
+	return __raw_readl(roff + AU1300_GPIC_PINVAL) & bit;
+}
+
+static inline int au1300_gpio_direction_input(int gpio)
+{
+	unsigned long bit;
+	void __iomem *roff;
+
+	gpio -= AU1300_GPIO_BASE;
+
+	roff = AU1300_GPIC_ADDR;
+	roff += AU1300_GPIO_TO_BANK(gpio) * 4;
+	bit = 1 << AU1300_GPIO_TO_BIT(gpio);
+	__raw_writel(bit, roff + AU1300_GPIC_DEVCLR);
+	wmb();
+
+	return 0;
+}
+
+static inline int au1300_gpio_set_value(int gpio, int v)
+{
+	unsigned long bit;
+	void __iomem *roff;
+
+	gpio -= AU1300_GPIO_BASE;
+
+	/* bah das ist viel zu kompliziert.  Wie waers mit einem
+	 * registersatz in den ich einfach die nummer des pins, den
+	 * ich manipulieren moechte, hineinschreibe?  Oder noch
+	 * besser, neue cpu opcodes fuer gpio:
+	 *   agsol a0 ("alchemy set gpio output low" a0 = gpio pin nummer)
+	 *   agsoh a0 ( ditto fuer set high )
+	 *   agso  a0, a1  (set gpio output, a1 = level)
+	 *   agg   a0 ( get gpio )
+	 *   agsi  a0 ( set gpio to input )
+	 *   keinen MIPS CPx dafuer, gleicher schmarrn.
+	 */
+	roff = AU1300_GPIC_ADDR;
+	roff += AU1300_GPIO_TO_BANK(gpio) * 4;
+	roff += (v) ? AU1300_GPIC_PINVAL : AU1300_GPIC_PINVALCLR;
+	bit = 1 << AU1300_GPIO_TO_BIT(gpio);
+	__raw_writel(bit, roff);
+	wmb();
+
+	return 0;
+}
+
+static inline int au1300_gpio_direction_output(int gpio, int v)
+{
+	/* hw switches to output automatically */
+	return au1300_gpio_set_value(gpio, v);
+}
+
+static inline int au1300_gpio_to_irq(int gpio)
+{
+	return AU1300_FIRST_INT + (gpio - AU1300_GPIO_BASE);
+}
+
+static inline int au1300_irq_to_gpio(int irq)
+{
+	return (irq - AU1300_FIRST_INT) + AU1300_GPIO_BASE;
+}
+
+static inline int au1300_gpio_is_valid(int gpio)
+{
+	return ((gpio >= AU1300_GPIO_BASE) && (gpio <= AU1300_GPIO_MAX));
+}
+
+static inline int au1300_gpio_cansleep(int gpio)
+{
+	return 0;
+}
+
+static inline void alchemy_gpio1_input_enable(void)
+{}
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
+static inline int gpio_direction_input(int gpio)
+{
+	return au1300_gpio_direction_input(gpio);
+}
+
+static inline int gpio_direction_output(int gpio, int v)
+{
+	return au1300_gpio_direction_output(gpio, v);
+}
+
+static inline int gpio_get_value(int gpio)
+{
+	return au1300_gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value(int gpio, int v)
+{
+	au1300_gpio_set_value(gpio, v);
+}
+
+static inline int gpio_is_valid(int gpio)
+{
+	return au1300_gpio_is_valid(gpio);
+}
+
+static inline int gpio_cansleep(int gpio)
+{
+	return au1300_gpio_cansleep(gpio);
+}
+
+static inline int gpio_to_irq(int gpio)
+{
+	return au1300_gpio_to_irq(gpio);
+}
+
+static inline int irq_to_gpio(int irq)
+{
+	return au1300_irq_to_gpio(irq);
+}
+
+static inline int gpio_request(unsigned gpio, const char *label)
+{
+	return 0;
+}
+
+static inline void gpio_free(unsigned gpio)
+{
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
index f9b7d41..8bd5de8 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio.h
@@ -5,6 +5,10 @@
 
 #include <asm/mach-au1x00/gpio-au1000.h>
 
+#elif defined(CONFIG_SOC_AU1300)
+
+#include <asm/mach-au1x00/gpio-au1300.h>
+
 #endif
 
 #endif	/* _ALCHEMY_GPIO_H_ */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 7a51866..0b2607a 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -802,6 +802,21 @@ static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
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
@@ -936,6 +951,9 @@ __cpuinit void cpu_probe(void)
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
index 737335f..17efcc7 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -294,7 +294,7 @@ config I2C_AT91
 
 config I2C_AU1550
 	tristate "Au1550/Au1200 SMBus interface"
-	depends on SOC_AU1550 || SOC_AU1200
+	depends on SOC_AU1550 || SOC_AU1200 || SOC_AU1300
 	help
 	  If you say yes to this option, support will be included for the
 	  Au1550 and Au1200 SMBus interface.
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4b6f7cb..ed6b082 100644
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
index 9bbb285..df075da 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1662,15 +1662,15 @@ config FB_AU1100
 	  au1100fb:panel=<name>.
 
 config FB_AU1200
-	bool "Au1200 LCD Driver"
-	depends on (FB = y) && MIPS && SOC_AU1200
+	bool "Au1200/Au1300 LCD Driver"
+	depends on (FB = y) && (SOC_AU1200 || SOC_AU1300)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	help
-	  This is the framebuffer driver for the AMD Au1200 SOC.  It can drive
-	  various panels and CRTs by passing in kernel cmd line option
-	  au1200fb:panel=<name>.
+	  This is the framebuffer driver for the AMD Au1200/Au1300 SOCs.
+	  It can drive various panels and CRTs by passing in kernel
+	  cmdline option au1200fb:panel=<name>.
 
 source "drivers/video/geode/Kconfig"
 
-- 
1.6.5.2
