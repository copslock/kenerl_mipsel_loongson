Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 11:38:12 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:34369 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904606Ab1KXKiE convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Nov 2011 11:38:04 +0100
Received: by vbbfs19 with SMTP id fs19so2626849vbb.36
        for <multiple recipients>; Thu, 24 Nov 2011 02:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QVT7tcUwAhAO4Sh2KiriXpQyha63rX8TeY2LWafdWKI=;
        b=nG6MaJIkXAOhzdLkiwbFx0auNEYe86DXxrnoMblppbUVqHvzjluZSbHcTyliAhr+LD
         7qJNOcCcmxPCx/Xk/pHsWz0ibA3T2sSAyB/HZSzl1+bfRq4+sY1365Gc8XFedTz6ebtQ
         VJMrITKMiY8q2Icy3xRAi6bSYHzV+VIfLchlI=
MIME-Version: 1.0
Received: by 10.182.73.71 with SMTP id j7mr9273266obv.55.1322131077932; Thu,
 24 Nov 2011 02:37:57 -0800 (PST)
Received: by 10.182.36.133 with HTTP; Thu, 24 Nov 2011 02:37:57 -0800 (PST)
In-Reply-To: <4ECD5B06.10204@openwrt.org>
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
        <CAEWqx5-HNNy-9BhYi=nnp3Q=vGQnq1hfH50env5W73ux2UiZXw@mail.gmail.com>
        <4ECCFE72.6090300@openwrt.org>
        <CAEWqx5_hgSH0FoWJPL0JDrVXGTWFCV0-FH9hXPMTxbG3A1pScQ@mail.gmail.com>
        <CAEWqx5_emEPp1HzK=SwOUJnJp5uFhco1asEQjuucdEV4rTQCdg@mail.gmail.com>
        <4ECD5B06.10204@openwrt.org>
Date:   Thu, 24 Nov 2011 11:37:57 +0100
Message-ID: <CAEWqx5-deTQLVu=1S9XjKTeq+=O3OE-EXJsXugZAeKYFFzjo-w@mail.gmail.com>
Subject: Re: [PATCH 00/12] MIPS: ath79: AR724X PCI fixes and AR71XX PCI support
From:   =?UTF-8?Q?Ren=C3=A9_Bolldorf?= <xsecute@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20742

Sorry Gabor for the following patch, but it seems your patchset was
against a other tree? Because of the many failures I rebase'ed
against 09521577ca7718b6c of the linus tree and written anything from scratch.

- The ar724x pci build only then SOC_AR724X and AR724X_PCI is set.
(new symbol AR724X_PCI)
- We have a shared PCI header file for both controllers. (Only AR724x
is included atm)
- We have a default irq map if the board pass no other map with
ar724x_pci_add_data.
- I added the fix for the 7240 controller bug, hopefully right.

Gabor, can you please test the patch?

René

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 4770741..e763661 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -23,6 +23,16 @@ config ATH79_MACH_PB44
 	  Say 'Y' here if you want your kernel to support the
 	  Atheros PB44 reference board.

+config ATH79_MACH_UBNT_XM
+	bool "Ubiquiti Networks XM (rev 1.0) board"
+	select SOC_AR724X
+	select ATH79_DEV_GPIO_BUTTONS
+	select ATH79_DEV_LEDS_GPIO
+	select ATH79_DEV_SPI
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Ubiquiti Networks XM (rev 1.0) board.
+
 endmenu

 config SOC_AR71XX
@@ -33,6 +43,7 @@ config SOC_AR71XX
 config SOC_AR724X
 	select USB_ARCH_HAS_EHCI
 	select USB_ARCH_HAS_OHCI
+	select HW_HAS_PCI
 	def_bool n

 config SOC_AR913X
@@ -52,4 +63,8 @@ config ATH79_DEV_LEDS_GPIO
 config ATH79_DEV_SPI
 	def_bool n

+config AR724X_PCI
+	depends on PCI
+	def_bool y
+
 endif
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index c33d465..ac9f375 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_ATH79_DEV_SPI)		+= dev-spi.o
 #
 obj-$(CONFIG_ATH79_MACH_AP81)		+= mach-ap81.o
 obj-$(CONFIG_ATH79_MACH_PB44)		+= mach-pb44.o
+obj-$(CONFIG_ATH79_MACH_UBNT_XM)	+= mach-ubnt-xm.o
diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
new file mode 100644
index 0000000..6fadd0b
--- /dev/null
+++ b/arch/mips/ath79/mach-ubnt-xm.c
@@ -0,0 +1,121 @@
+/*
+ *  Ubiquiti Networks XM (rev 1.0) board support
+ *
+ *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
+ *
+ *  Derived from: mach-pb44.c
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#ifdef CONFIG_PCI
+#include <linux/ath9k_platform.h>
+#include <asm/mach-ath79/pci.h>
+#include <asm/mach-ath79/irq.h>
+#endif /* CONFIG_PCI */
+
+#include "machtypes.h"
+#include "dev-gpio-buttons.h"
+#include "dev-leds-gpio.h"
+#include "dev-spi.h"
+
+#define UBNT_XM_GPIO_LED_L1		0
+#define UBNT_XM_GPIO_LED_L2		1
+#define UBNT_XM_GPIO_LED_L3		11
+#define UBNT_XM_GPIO_LED_L4		7
+
+#define UBNT_XM_GPIO_BTN_RESET		12
+
+#define UBNT_XM_KEYS_POLL_INTERVAL	20
+#define UBNT_XM_KEYS_DEBOUNCE_INTERVAL	(3 * UBNT_XM_KEYS_POLL_INTERVAL)
+
+#define UBNT_XM_EEPROM_ADDR		(u8 *) KSEG1ADDR(0x1fff1000)
+
+static struct gpio_led ubnt_xm_leds_gpio[] __initdata = {
+	{
+		.name		= "ubnt-xm:red:link1",
+		.gpio		= UBNT_XM_GPIO_LED_L1,
+		.active_low	= 0,
+	}, {
+		.name		= "ubnt-xm:orange:link2",
+		.gpio		= UBNT_XM_GPIO_LED_L2,
+		.active_low	= 0,
+	}, {
+		.name		= "ubnt-xm:green:link3",
+		.gpio		= UBNT_XM_GPIO_LED_L3,
+		.active_low	= 0,
+	}, {
+		.name		= "ubnt-xm:green:link4",
+		.gpio		= UBNT_XM_GPIO_LED_L4,
+		.active_low	= 0,
+	},
+};
+
+static struct gpio_keys_button ubnt_xm_gpio_keys[] __initdata = {
+	{
+		.desc			= "reset",
+		.type			= EV_KEY,
+		.code			= KEY_RESTART,
+		.debounce_interval	= UBNT_XM_KEYS_DEBOUNCE_INTERVAL,
+		.gpio			= UBNT_XM_GPIO_BTN_RESET,
+		.active_low		= 1,
+	}
+};
+
+static struct spi_board_info ubnt_xm_spi_info[] = {
+	{
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.max_speed_hz	= 25000000,
+		.modalias	= "mx25l6405d",
+	}
+};
+
+static struct ath79_spi_platform_data ubnt_xm_spi_data = {
+	.bus_num		= 0,
+	.num_chipselect		= 1,
+};
+
+#ifdef CONFIG_PCI
+static struct ath9k_platform_data ubnt_xm_eeprom_data;
+
+static struct ath79_pci_data ubnt_xm_pci_data[] = {
+	{
+		.slot	= 0,
+		.pin	= 1,
+		.irq	= ATH79_PCI_IRQ(0),
+		.pdata	= &ubnt_xm_eeprom_data,
+	},
+};
+#endif /* CONFIG_PCI */
+
+static void __init ubnt_xm_init(void)
+{
+	ath79_register_leds_gpio(-1, ARRAY_SIZE(ubnt_xm_leds_gpio),
+				 ubnt_xm_leds_gpio);
+
+	ath79_register_gpio_keys_polled(-1, UBNT_XM_KEYS_POLL_INTERVAL,
+					ARRAY_SIZE(ubnt_xm_gpio_keys),
+					ubnt_xm_gpio_keys);
+
+	ath79_register_spi(&ubnt_xm_spi_data, ubnt_xm_spi_info,
+			   ARRAY_SIZE(ubnt_xm_spi_info));
+
+#ifdef CONFIG_PCI
+	memcpy(ubnt_xm_eeprom_data.eeprom_data, UBNT_XM_EEPROM_ADDR,
+	       sizeof(ubnt_xm_eeprom_data.eeprom_data));
+
+	ar724x_pci_add_data(ubnt_xm_pci_data, ARRAY_SIZE(ubnt_xm_pci_data));
+#endif /* CONFIG_PCI */
+
+}
+
+MIPS_MACHINE(ATH79_MACH_UBNT_XM,
+	     "UBNT-XM",
+	     "Ubiquiti Networks XM (rev 1.0) board",
+	     ubnt_xm_init);
diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
index 3940fe4..35d5d5c 100644
--- a/arch/mips/ath79/machtypes.h
+++ b/arch/mips/ath79/machtypes.h
@@ -18,6 +18,7 @@ enum ath79_mach_type {
 	ATH79_MACH_GENERIC = 0,
 	ATH79_MACH_AP81,		/* Atheros AP81 reference board */
 	ATH79_MACH_PB44,		/* Atheros PB44 reference board */
+	ATH79_MACH_UBNT_XM,		/* Ubiquiti Networks XM board rev 1.0 */
 };

 #endif /* _ATH79_MACHTYPE_H */
diff --git a/arch/mips/include/asm/mach-ath79/irq.h
b/arch/mips/include/asm/mach-ath79/irq.h
index 189bc6e..eb68e79 100644
--- a/arch/mips/include/asm/mach-ath79/irq.h
+++ b/arch/mips/include/asm/mach-ath79/irq.h
@@ -10,11 +10,15 @@
 #define __ASM_MACH_ATH79_IRQ_H

 #define MIPS_CPU_IRQ_BASE	0
-#define NR_IRQS			16
+#define NR_IRQS			22

 #define ATH79_MISC_IRQ_BASE	8
 #define ATH79_MISC_IRQ_COUNT	8

+#define ATH79_PCI_IRQ_BASE	(ATH79_MISC_IRQ_BASE + ATH79_MISC_IRQ_COUNT)
+#define ATH79_PCI_IRQ_COUNT	6
+#define ATH79_PCI_IRQ(_x)	(ATH79_PCI_IRQ_BASE + (_x))
+
 #define ATH79_CPU_IRQ_IP2	(MIPS_CPU_IRQ_BASE + 2)
 #define ATH79_CPU_IRQ_USB	(MIPS_CPU_IRQ_BASE + 3)
 #define ATH79_CPU_IRQ_GE0	(MIPS_CPU_IRQ_BASE + 4)
diff --git a/arch/mips/include/asm/mach-ath79/pci.h
b/arch/mips/include/asm/mach-ath79/pci.h
new file mode 100644
index 0000000..f671174
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/pci.h
@@ -0,0 +1,24 @@
+/*
+ *  Atheros 71xx/724x PCI support
+ *
+ *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
+ *  Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_ATH79_PCI_H
+#define __ASM_MACH_ATH79_PCI_H
+
+struct ath79_pci_data {
+	uint8_t slot;
+	uint8_t pin;
+	int irq;
+	void *pdata;
+};
+
+void ar724x_pci_add_data(struct ath79_pci_data *data, int size);
+
+#endif /* __ASM_MACH_ATH79_PCI_H */
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index bb82cbd..6603594 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
 obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
 					ops-bcm63xx.o
 obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
+obj-$(CONFIG_AR724X_PCI)	+= pci-ar724x.o

 #
 # These are still pretty much in the old state, watch, go blind.
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
new file mode 100644
index 0000000..66974fa
--- /dev/null
+++ b/arch/mips/pci/pci-ar724x.c
@@ -0,0 +1,284 @@
+/*
+ *  Atheros 724x PCI support
+ *
+ *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
+ *  Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/pci.h>
+#include <asm/mach-ath79/irq.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+
+#define AR724X_PCI_CFG_BASE	0x14000000
+#define AR724X_PCI_CFG_SIZE	0x1000
+#define AR724X_PCI_CTRL_BASE	(AR71XX_APB_BASE + 0x000f0000)
+#define AR724X_PCI_CTRL_SIZE	0x100
+
+#define AR724X_PCI_MEM_BASE	0x10000000
+#define AR724X_PCI_MEM_SIZE	0x08000000
+
+#define AR724X_PCI_REG_INT_STATUS	0x4c
+#define AR724X_PCI_REG_INT_MASK		0x50
+#define AR724X_PCI_INT_DEV0		BIT(14)
+
+#define AR7240_BAR0_WAR_VALUE	0xffff
+
+static DEFINE_SPINLOCK(ar724x_pci_lock);
+
+static void __iomem *ar724x_pci_devcfg_base;
+static void __iomem *ar724x_pci_ctrl_base;
+
+static struct ath79_pci_data *pci_data;
+static int pci_data_size = -1;
+
+static u32 ar724x_pci_bar0_value;
+static bool ar724x_pci_bar0_is_cached;
+
+static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
+			    int size, uint32_t *value)
+{
+	unsigned long flags;
+	void __iomem *base;
+
+	if (devfn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	base = ar724x_pci_devcfg_base;
+
+	spin_lock_irqsave(&ar724x_pci_lock, flags);
+
+	switch (size) {
+	case 1:
+		*value = (__raw_readl(base + (where & ~3)) & 0xff);
+		break;
+	case 2:
+		*value = (__raw_readl(base + (where & ~3)) & 0xffff);
+		break;
+	case 4:
+		if (soc_is_ar7240() && where == PCI_BASE_ADDRESS_0 &&
+		    ar724x_pci_bar0_is_cached)
+			/* use the cached value */
+			*value = ar724x_pci_bar0_value;
+		else
+			*value = __raw_readl(base + where);
+		break;
+	default:
+		spin_unlock_irqrestore(&ar724x_pci_lock, flags);
+
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	spin_unlock_irqrestore(&ar724x_pci_lock, flags);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
+			     int size, uint32_t value)
+{
+	unsigned long flags;
+	void __iomem *base;
+
+	if (devfn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (soc_is_ar7240() && where == PCI_BASE_ADDRESS_0 && size == 4) {
+		if (value != 0xffffffff) {
+			/*
+			 * WAR for a hw issue. If the BAR0 register of the
+			 * device is set to the proper base address, the
+			 * memory space of the device is not accessible.
+			 *
+			 * Cache the intended value so it can be read back,
+			 * and write a SoC specific constant value to the
+			 * BAR0 register in order to make the device memory
+			 * accessible.
+			 */
+			ar724x_pci_bar0_is_cached = true;
+			ar724x_pci_bar0_value = value;
+			value = AR7240_BAR0_WAR_VALUE;
+		} else {
+			ar724x_pci_bar0_is_cached = false;
+		}
+	}
+
+	base = ar724x_pci_devcfg_base;
+
+	spin_lock_irqsave(&ar724x_pci_lock, flags);
+
+	switch (size) {
+	case 1:
+		value = (__raw_readl(base + (where & ~3)) & 0xff);
+		__raw_writel(value, base + (where & ~3));
+		break;
+	case 2:
+		value = (__raw_readl(base + (where & ~3)) & 0xffff);
+		__raw_writel(value, base + (where & ~3));
+		break;
+	case 4:
+		__raw_writel(value, (base + where));
+		break;
+	default:
+		spin_unlock_irqrestore(&ar724x_pci_lock, flags);
+
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	spin_unlock_irqrestore(&ar724x_pci_lock, flags);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops ar724x_pci_ops = {
+	.read	= ar724x_pci_read,
+	.write	= ar724x_pci_write,
+};
+
+static struct resource ar724x_io_resource = {
+	.name   = "PCI IO space",
+	.start  = 0,
+	.end    = 0,
+	.flags  = IORESOURCE_IO,
+};
+
+static struct resource ar724x_mem_resource = {
+	.name   = "PCI memory space",
+	.start  = AR724X_PCI_MEM_BASE,
+	.end    = AR724X_PCI_MEM_BASE + AR724X_PCI_MEM_SIZE - 1,
+	.flags  = IORESOURCE_MEM,
+};
+
+static struct pci_controller ar724x_pci_controller = {
+	.pci_ops        = &ar724x_pci_ops,
+	.io_resource    = &ar724x_io_resource,
+	.mem_resource	= &ar724x_mem_resource,
+};
+
+static void ar724x_pci_irq_mask(struct irq_data *data)
+{
+	void __iomem *base;
+	u32 t;
+
+	base = ar724x_pci_ctrl_base;
+
+	switch (data->irq) {
+	case ATH79_PCI_IRQ(0):
+		t = __raw_readl(base + AR724X_PCI_REG_INT_MASK);
+		__raw_writel(t & ~AR724X_PCI_INT_DEV0,
+			     base + AR724X_PCI_REG_INT_MASK);
+
+		t = __raw_readl(base + AR724X_PCI_REG_INT_STATUS);
+		__raw_writel(t | AR724X_PCI_INT_DEV0,
+			     base + AR724X_PCI_REG_INT_STATUS);
+	}
+}
+
+static void ar724x_pci_irq_unmask(struct irq_data *data)
+{
+	void __iomem *base;
+	u32 t;
+
+	base = ar724x_pci_ctrl_base;
+
+	switch (data->irq) {
+	case ATH79_PCI_IRQ(0):
+		t = __raw_readl(base + AR724X_PCI_REG_INT_MASK);
+		__raw_writel(t | AR724X_PCI_INT_DEV0,
+			     base + AR724X_PCI_REG_INT_MASK);
+	}
+}
+
+static struct irq_chip ar724x_pci_irq_chip = {
+	.name		= "AR724X PCI",
+	.irq_mask	= ar724x_pci_irq_mask,
+	.irq_unmask	= ar724x_pci_irq_unmask,
+	.irq_mask_ack	= ar724x_pci_irq_mask,
+};
+
+static __initconst struct ath79_pci_data ar724x_default_pci_data[] = {
+	{
+		.slot = 0,
+		.pin  = 1,
+		.irq  = ATH79_PCI_IRQ(0),
+	},
+};
+
+void ar724x_pci_add_data(struct ath79_pci_data *data, int size)
+{
+	pci_data	= data;
+	pci_data_size	= size;
+}
+
+int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot,
uint8_t pin)
+{
+	int irq = -1;
+	int i;
+
+	if (pci_data_size == -1)
+		return irq;
+
+	for (i = 0; i < pci_data_size; i++) {
+		if ((pci_data[i].slot == slot) && (pci_data[i].pin == pin)) {
+			if (pci_data[i].irq != 0)
+				irq = pci_data[i].irq;
+		break;
+		}
+	}
+
+	return irq;
+}
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	int i;
+
+	if (pci_data_size == -1)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	for (i = 0; i < pci_data_size; i++) {
+		if (pci_data[i].slot == PCI_SLOT(dev->devfn)) {
+			if (pci_data[i].pdata != NULL)
+				dev->dev.platform_data = pci_data[i].pdata;
+		break;
+		}
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int __init ar724x_pcibios_init(void)
+{
+	int i;
+
+	ar724x_pci_devcfg_base = ioremap_nocache(AR724X_PCI_CFG_BASE,
+						 AR724X_PCI_CFG_SIZE);
+	if (ar724x_pci_devcfg_base == NULL)
+		return -ENOMEM;
+
+	ar724x_pci_ctrl_base = ioremap_nocache(AR724X_PCI_CTRL_BASE,
+						  AR724X_PCI_CTRL_SIZE);
+	if (ar724x_pci_ctrl_base == NULL)
+		return -ENOMEM;
+
+	if (pci_data == NULL)
+		pci_data = ar724x_default_pci_data;
+		pci_data_size = ARRAY_SIZE(ar724x_default_pci_data);
+
+	for (i = ATH79_PCI_IRQ_BASE;
+	     i < ATH79_PCI_IRQ_BASE + ATH79_PCI_IRQ_COUNT; i++)
+		irq_set_chip_and_handler(i, &ar724x_pci_irq_chip,
+					 handle_level_irq);
+
+	register_pci_controller(&ar724x_pci_controller);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+arch_initcall(ar724x_pcibios_init);

2011/11/23 Gabor Juhos <juhosg@openwrt.org>:
> 2011.11.23. 16:15 keltezéssel, René Bolldorf írta:
>> It seems your board is a older one.
>
> Yes, it uses AR7240.
>
>> Can you remove the heatsink and post the revision from the SoC?
>
> Sorry, I can't remove the heatsink. It is glued onto the SoC, and I don't want
> to brick the board. However the kernel shows this:
>
> SoC: Atheros AR7240 rev 2
> Clocks: CPU:400.000MHz, DDR:400.000MHz, AHB:200.000MHz, Ref:5.000MHz
>
> On the TL-MR3420:
>
> SoC: Atheros AR7241 rev 1
> Clocks: CPU:400.000MHz, DDR:400.000MHz, AHB:200.000MHz, Ref:5.000MHz
>
> -Gabor
>
