Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2012 18:25:23 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:46099 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903394Ab2INQZQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2012 18:25:16 +0200
Received: by wibhq4 with SMTP id hq4so19033wib.6
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2012 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wzZw1N3vqswxXuaGugxfYyIIUEr5FEKJFmQL8e30IHE=;
        b=jlanGWmKY5v5cOjZ64TfxiACxKogDjbNk+OTmUVkOwiYAh/HBZHqw8wpawSda5mAsB
         4CmMK36E9zgwzBM54LlZDNEPNlTn8YpALtJM+YWt+QgdtYXTNoMvFXGeDLPrgTJOHald
         2VcLh/RQiVRG9drSFA6yKUZ7D6r4e62mkcURuOYXoc9o2EW3y6dxQdtvcyyklH3MxCq8
         ZGW0kQrJlxqkB+X0f3IvkFJ7LrA/zYWvBe0vVL+XPsBOJsB5MNkmcuYYryc4xCLEmBA9
         Qg9lxifb2Q6rvOmpmBs2C3blDEL2kiIx8Y9xvXckI+E7/f15YAC+T8rr9f+1jueFEBtN
         hXLg==
Received: by 10.216.245.135 with SMTP id o7mr1715231wer.40.1347639911432;
        Fri, 14 Sep 2012 09:25:11 -0700 (PDT)
Received: from flagship.roarinelk.net (188-22-1-39.adsl.highway.telekom.at. [188.22.1.39])
        by mx.google.com with ESMTPS id el6sm19572631wib.8.2012.09.14.09.25.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 09:25:10 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: merge PB1100/1500 support into DB1000 code.
Date:   Fri, 14 Sep 2012 18:25:00 +0200
Message-Id: <1347639900-3734-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.12
X-archive-position: 34502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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
X-Status: A

The PB1100/1500 are similar to their DB-cousins but with a few
more devices on the bus.

This patch adds PB1100/1500 support to the existing DB1100/1500
code.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Tested only on DB1100 and DB1500 as I don't have any PB1xxx boards.
I didn't copy the custom board config from the PB1x sources since
newer versions of YAMON already take care of it.  I figure the code
was added since the original developers only had very early yamon
code on their boards.

Applies on top of the pb1550 merge patch.

 arch/mips/alchemy/Kconfig                |  19 +--
 arch/mips/alchemy/devboards/Makefile     |   2 -
 arch/mips/alchemy/devboards/db1000.c     | 120 ++++++++++++++-----
 arch/mips/alchemy/devboards/pb1100.c     | 167 --------------------------
 arch/mips/alchemy/devboards/pb1500.c     | 198 -------------------------------
 arch/mips/configs/pb1100_defconfig       | 124 -------------------
 arch/mips/configs/pb1500_defconfig       | 141 ----------------------
 arch/mips/include/asm/mach-db1x00/bcsr.h |   2 +
 8 files changed, 95 insertions(+), 678 deletions(-)
 delete mode 100644 arch/mips/alchemy/devboards/pb1100.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1500.c
 delete mode 100644 arch/mips/configs/pb1100_defconfig
 delete mode 100644 arch/mips/configs/pb1500_defconfig

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 6eb66a9..c8862bd 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -27,7 +27,7 @@ config MIPS_MTX1
 	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_DB1000
-	bool "Alchemy DB1000/DB1500/DB1100 boards"
+	bool "Alchemy DB1000/DB1500/DB1100 PB1500/1100 boards"
 	select ALCHEMY_GPIOINT_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
@@ -45,23 +45,6 @@ config MIPS_DB1235
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
-config MIPS_PB1100
-	bool "Alchemy PB1100 board"
-	select ALCHEMY_GPIOINT_AU1000
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select SWAP_IO_SPACE
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_HAS_EARLY_PRINTK
-
-config MIPS_PB1500
-	bool "Alchemy PB1500 board"
-	select ALCHEMY_GPIOINT_AU1000
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_HAS_EARLY_PRINTK
-
 config MIPS_XXS1500
 	bool "MyCable XXS1500 board"
 	select DMA_NONCOHERENT
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index fad8a99..15bf730 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -4,7 +4,5 @@
 
 obj-y += bcsr.o platform.o
 obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_MIPS_PB1100)	+= pb1100.o
-obj-$(CONFIG_MIPS_PB1500)	+= pb1500.o
 obj-$(CONFIG_MIPS_DB1000)	+= db1000.o
 obj-$(CONFIG_MIPS_DB1235)	+= db1235.o db1200.o db1300.o db1550.o
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 1b81dbf..8187845 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -1,5 +1,5 @@
 /*
- * DBAu1000/1500/1100 board support
+ * DBAu1000/1500/1100 PBAu1100/1500 board support
  *
  * Copyright 2000, 2008 MontaVista Software Inc.
  * Author: MontaVista Software, Inc. <source@mvista.com>
@@ -52,6 +52,11 @@ static const char *board_type_str(void)
 		return "DB1500";
 	case BCSR_WHOAMI_DB1100:
 		return "DB1100";
+	case BCSR_WHOAMI_PB1500:
+	case BCSR_WHOAMI_PB1500R2:
+		return "PB1500";
+	case BCSR_WHOAMI_PB1100:
+		return "PB1100";
 	default:
 		return "(unknown)";
 	}
@@ -111,7 +116,9 @@ static struct platform_device db1500_pci_host_dev = {
 
 static int __init db1500_pci_init(void)
 {
-	if (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI)) == BCSR_WHOAMI_DB1500)
+	int id = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
+	if ((id == BCSR_WHOAMI_DB1500) || (id == BCSR_WHOAMI_PB1500) ||
+	    (id == BCSR_WHOAMI_PB1500R2))
 		return platform_device_register(&db1500_pci_host_dev);
 	return 0;
 }
@@ -199,27 +206,37 @@ static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
 
 static int db1100_mmc_cd_setup(void *mmc_host, int en)
 {
-	int ret = 0;
+	int ret = 0, irq;
+
+	if (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI)) == BCSR_WHOAMI_DB1100)
+		irq = AU1100_GPIO19_INT;
+	else
+		irq = AU1100_GPIO14_INT;	/* PB1100 SD0 CD# */
 
 	if (en) {
-		irq_set_irq_type(AU1100_GPIO19_INT, IRQ_TYPE_EDGE_BOTH);
-		ret = request_irq(AU1100_GPIO19_INT, db1100_mmc_cd, 0,
+		irq_set_irq_type(irq, IRQ_TYPE_EDGE_BOTH);
+		ret = request_irq(irq, db1100_mmc_cd, 0,
 				  "sd0_cd", mmc_host);
 	} else
-		free_irq(AU1100_GPIO19_INT, mmc_host);
+		free_irq(irq, mmc_host);
 	return ret;
 }
 
 static int db1100_mmc1_cd_setup(void *mmc_host, int en)
 {
-	int ret = 0;
+	int ret = 0, irq;
+
+	if (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI)) == BCSR_WHOAMI_DB1100)
+		irq = AU1100_GPIO20_INT;
+	else
+		irq = AU1100_GPIO15_INT;	/* PB1100 SD1 CD# */
 
 	if (en) {
-		irq_set_irq_type(AU1100_GPIO20_INT, IRQ_TYPE_EDGE_BOTH);
-		ret = request_irq(AU1100_GPIO20_INT, db1100_mmc_cd, 0,
+		irq_set_irq_type(irq, IRQ_TYPE_EDGE_BOTH);
+		ret = request_irq(irq, db1100_mmc_cd, 0,
 				  "sd1_cd", mmc_host);
 	} else
-		free_irq(AU1100_GPIO20_INT, mmc_host);
+		free_irq(irq, mmc_host);
 	return ret;
 }
 
@@ -236,11 +253,18 @@ static int db1100_mmc_card_inserted(void *mmc_host)
 
 static void db1100_mmc_set_power(void *mmc_host, int state)
 {
+	int bit;
+
+	if (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI)) == BCSR_WHOAMI_DB1100)
+		bit = BCSR_BOARD_SD0PWR;
+	else
+		bit = BCSR_BOARD_PB1100_SD0PWR;
+
 	if (state) {
-		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD0PWR);
+		bcsr_mod(BCSR_BOARD, 0, bit);
 		msleep(400);	/* stabilization time */
 	} else
-		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD0PWR, 0);
+		bcsr_mod(BCSR_BOARD, bit, 0);
 }
 
 static void db1100_mmcled_set(struct led_classdev *led, enum led_brightness b)
@@ -267,11 +291,18 @@ static int db1100_mmc1_card_inserted(void *mmc_host)
 
 static void db1100_mmc1_set_power(void *mmc_host, int state)
 {
+	int bit;
+
+	if (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI)) == BCSR_WHOAMI_DB1100)
+		bit = BCSR_BOARD_SD1PWR;
+	else
+		bit = BCSR_BOARD_PB1100_SD1PWR;
+
 	if (state) {
-		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD1PWR);
+		bcsr_mod(BCSR_BOARD, 0, bit);
 		msleep(400);	/* stabilization time */
 	} else
-		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD1PWR, 0);
+		bcsr_mod(BCSR_BOARD, bit, 0);
 }
 
 static void db1100_mmc1led_set(struct led_classdev *led, enum led_brightness b)
@@ -480,13 +511,12 @@ static struct platform_device *db1100_devs[] = {
 	&db1100_mmc0_dev,
 	&db1100_mmc1_dev,
 	&db1000_irda_dev,
-	&db1100_spi_dev,
 };
 
 static int __init db1000_dev_init(void)
 {
 	int board = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
-	int c0, c1, d0, d1, s0, s1;
+	int c0, c1, d0, d1, s0, s1, flashsize = 32,  twosocks = 1;
 	unsigned long pfc;
 
 	if (board == BCSR_WHOAMI_DB1500) {
@@ -522,6 +552,7 @@ static int __init db1000_dev_init(void)
 					ARRAY_SIZE(db1100_spi_info));
 
 		platform_add_devices(db1100_devs, ARRAY_SIZE(db1100_devs));
+		platform_device_register(&db1100_spi_dev);
 	} else if (board == BCSR_WHOAMI_DB1000) {
 		c0 = AU1000_GPIO2_INT;
 		c1 = AU1000_GPIO5_INT;
@@ -530,15 +561,42 @@ static int __init db1000_dev_init(void)
 		s0 = AU1000_GPIO1_INT;
 		s1 = AU1000_GPIO4_INT;
 		platform_add_devices(db1000_devs, ARRAY_SIZE(db1000_devs));
+	} else if ((board == BCSR_WHOAMI_PB1500) ||
+		   (board == BCSR_WHOAMI_PB1500R2)) {
+		c0 = AU1500_GPIO203_INT;
+		d0 = AU1500_GPIO201_INT;
+		s0 = AU1500_GPIO202_INT;
+		twosocks = 0;
+		flashsize = 64;
+		/* RTC and daughtercard irqs */
+		irq_set_irq_type(AU1500_GPIO204_INT, IRQ_TYPE_LEVEL_LOW);
+		irq_set_irq_type(AU1500_GPIO205_INT, IRQ_TYPE_LEVEL_LOW);
+		/* EPSON S1D13806 0x1b000000
+		 * SRAM 1MB/2MB   0x1a000000
+		 * DS1693 RTC	  0x0c000000
+		 */
+	} else if (board == BCSR_WHOAMI_PB1100) {
+		c0 = AU1100_GPIO11_INT;
+		d0 = AU1100_GPIO9_INT;
+		s0 = AU1100_GPIO10_INT;
+		twosocks = 0;
+		flashsize = 64;
+		/* pendown, rtc, daughtercard irqs */
+		irq_set_irq_type(AU1100_GPIO8_INT, IRQ_TYPE_LEVEL_LOW);
+		irq_set_irq_type(AU1100_GPIO12_INT, IRQ_TYPE_LEVEL_LOW);
+		irq_set_irq_type(AU1100_GPIO13_INT, IRQ_TYPE_LEVEL_LOW);
+		/* EPSON S1D13806 0x1b000000
+		 * SRAM 1MB/2MB   0x1a000000
+		 * DiskOnChip	  0x0d000000
+		 * DS1693 RTC	  0x0c000000
+		 */
+		platform_add_devices(db1100_devs, ARRAY_SIZE(db1100_devs));
 	} else
 		return 0; /* unknown board, no further dev setup to do */
 
 	irq_set_irq_type(d0, IRQ_TYPE_EDGE_BOTH);
-	irq_set_irq_type(d1, IRQ_TYPE_EDGE_BOTH);
 	irq_set_irq_type(c0, IRQ_TYPE_LEVEL_LOW);
-	irq_set_irq_type(c1, IRQ_TYPE_LEVEL_LOW);
 	irq_set_irq_type(s0, IRQ_TYPE_LEVEL_LOW);
-	irq_set_irq_type(s1, IRQ_TYPE_LEVEL_LOW);
 
 	db1x_register_pcmcia_socket(
 		AU1000_PCMCIA_ATTR_PHYS_ADDR,
@@ -549,17 +607,23 @@ static int __init db1000_dev_init(void)
 		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
 		c0, d0,	/*s0*/0, 0, 0);
 
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
-		c1, d1,	/*s1*/0, 0, 1);
+	if (twosocks) {
+		irq_set_irq_type(d1, IRQ_TYPE_EDGE_BOTH);
+		irq_set_irq_type(c1, IRQ_TYPE_LEVEL_LOW);
+		irq_set_irq_type(s1, IRQ_TYPE_LEVEL_LOW);
+
+		db1x_register_pcmcia_socket(
+			AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
+			AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
+			AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
+			AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
+			AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
+			AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
+			c1, d1,	/*s1*/0, 0, 1);
+	}
 
 	platform_add_devices(db1x00_devs, ARRAY_SIZE(db1x00_devs));
-	db1x_register_norflash(32 << 20, 4 /* 32bit */, F_SWAPPED);
+	db1x_register_norflash(flashsize << 20, 4 /* 32bit */, F_SWAPPED);
 	return 0;
 }
 device_initcall(db1000_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1100.c b/arch/mips/alchemy/devboards/pb1100.c
deleted file mode 100644
index 78c77a4..0000000
--- a/arch/mips/alchemy/devboards/pb1100.c
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * Pb1100 board platform device registration
- *
- * Copyright (C) 2009 Manuel Lauss
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-db1x00/bcsr.h>
-#include <prom.h>
-#include "platform.h"
-
-const char *get_system_type(void)
-{
-	return "PB1100";
-}
-
-void __init board_setup(void)
-{
-	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
-
-	bcsr_init(DB1000_BCSR_PHYS_ADDR,
-		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
-
-	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
-	au_writel(8, SYS_AUXPLL);
-	alchemy_gpio1_input_enable();
-	udelay(100);
-
-#if IS_ENABLED(CONFIG_USB_OHCI_HCD)
-	{
-		u32 pin_func, sys_freqctrl, sys_clksrc;
-
-		/* Configure pins GPIO[14:9] as GPIO */
-		pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
-
-		/* Zero and disable FREQ2 */
-		sys_freqctrl = au_readl(SYS_FREQCTRL0);
-		sys_freqctrl &= ~0xFFF00000;
-		au_writel(sys_freqctrl, SYS_FREQCTRL0);
-
-		/* Zero and disable USBH/USBD/IrDA clock */
-		sys_clksrc = au_readl(SYS_CLKSRC);
-		sys_clksrc &= ~(SYS_CS_CIR | SYS_CS_DIR | SYS_CS_MIR_MASK);
-		au_writel(sys_clksrc, SYS_CLKSRC);
-
-		sys_freqctrl = au_readl(SYS_FREQCTRL0);
-		sys_freqctrl &= ~0xFFF00000;
-
-		sys_clksrc = au_readl(SYS_CLKSRC);
-		sys_clksrc &= ~(SYS_CS_CIR | SYS_CS_DIR | SYS_CS_MIR_MASK);
-
-		/* FREQ2 = aux / 2 = 48 MHz */
-		sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) |
-				SYS_FC_FE2 | SYS_FC_FS2;
-		au_writel(sys_freqctrl, SYS_FREQCTRL0);
-
-		/*
-		 * Route 48 MHz FREQ2 into USBH/USBD/IrDA
-		 */
-		sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MIR_BIT;
-		au_writel(sys_clksrc, SYS_CLKSRC);
-
-		/* Setup the static bus controller */
-		au_writel(0x00000002, MEM_STCFG3);  /* type = PCMCIA */
-		au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
-		au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
-
-		/*
-		 * Get USB Functionality pin state (device vs host drive pins).
-		 */
-		pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_USB;
-		/* 2nd USB port is USB host. */
-		pin_func |= SYS_PF_USB;
-		au_writel(pin_func, SYS_PINFUNC);
-	}
-#endif /* IS_ENABLED(CONFIG_USB_OHCI_HCD) */
-
-	/* Enable sys bus clock divider when IDLE state or no bus activity. */
-	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
-
-	/* Enable the RTC if not already enabled. */
-	if (!(readb(base + 0x28) & 0x20)) {
-		writeb(readb(base + 0x28) | 0x20, base + 0x28);
-		au_sync();
-	}
-	/* Put the clock in BCD mode. */
-	if (readb(base + 0x2C) & 0x4) { /* reg B */
-		writeb(readb(base + 0x2c) & ~0x4, base + 0x2c);
-		au_sync();
-	}
-}
-
-/******************************************************************************/
-
-static struct resource au1100_lcd_resources[] = {
-	[0] = {
-		.start	= AU1100_LCD_PHYS_ADDR,
-		.end	= AU1100_LCD_PHYS_ADDR + 0x800 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1100_LCD_INT,
-		.end	= AU1100_LCD_INT,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static u64 au1100_lcd_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device au1100_lcd_device = {
-	.name		= "au1100-lcd",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &au1100_lcd_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(au1100_lcd_resources),
-	.resource	= au1100_lcd_resources,
-};
-
-static int __init pb1100_dev_init(void)
-{
-	int swapped;
-
-	irq_set_irq_type(AU1100_GPIO9_INT, IRQF_TRIGGER_LOW); /* PCCD# */
-	irq_set_irq_type(AU1100_GPIO10_INT, IRQF_TRIGGER_LOW); /* PCSTSCHG# */
-	irq_set_irq_type(AU1100_GPIO11_INT, IRQF_TRIGGER_LOW); /* PCCard# */
-	irq_set_irq_type(AU1100_GPIO13_INT, IRQF_TRIGGER_LOW); /* DC_IRQ# */
-
-	/* PCMCIA. single socket, identical to Pb1500 */
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		AU1100_GPIO11_INT, AU1100_GPIO9_INT,	 /* card / insert */
-		/*AU1100_GPIO10_INT*/0, 0, 0); /* stschg / eject / id */
-
-	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
-	db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
-	platform_device_register(&au1100_lcd_device);
-
-	return 0;
-}
-device_initcall(pb1100_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1500.c b/arch/mips/alchemy/devboards/pb1500.c
deleted file mode 100644
index 232fee9..0000000
--- a/arch/mips/alchemy/devboards/pb1500.c
+++ /dev/null
@@ -1,198 +0,0 @@
-/*
- * Pb1500 board support.
- *
- * Copyright (C) 2009 Manuel Lauss
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/delay.h>
-#include <linux/dma-mapping.h>
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-db1x00/bcsr.h>
-#include <prom.h>
-#include "platform.h"
-
-const char *get_system_type(void)
-{
-	return "PB1500";
-}
-
-void __init board_setup(void)
-{
-	u32 pin_func;
-	u32 sys_freqctrl, sys_clksrc;
-
-	bcsr_init(DB1000_BCSR_PHYS_ADDR,
-		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
-
-	sys_clksrc = sys_freqctrl = pin_func = 0;
-	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
-	au_writel(8, SYS_AUXPLL);
-	alchemy_gpio1_input_enable();
-	udelay(100);
-
-	/* GPIO201 is input for PCMCIA card detect */
-	/* GPIO203 is input for PCMCIA interrupt request */
-	alchemy_gpio_direction_input(201);
-	alchemy_gpio_direction_input(203);
-
-#if IS_ENABLED(CONFIG_USB_OHCI_HCD)
-
-	/* Zero and disable FREQ2 */
-	sys_freqctrl = au_readl(SYS_FREQCTRL0);
-	sys_freqctrl &= ~0xFFF00000;
-	au_writel(sys_freqctrl, SYS_FREQCTRL0);
-
-	/* zero and disable USBH/USBD clocks */
-	sys_clksrc = au_readl(SYS_CLKSRC);
-	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
-			SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
-	au_writel(sys_clksrc, SYS_CLKSRC);
-
-	sys_freqctrl = au_readl(SYS_FREQCTRL0);
-	sys_freqctrl &= ~0xFFF00000;
-
-	sys_clksrc = au_readl(SYS_CLKSRC);
-	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
-			SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
-
-	/* FREQ2 = aux/2 = 48 MHz */
-	sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) | SYS_FC_FE2 | SYS_FC_FS2;
-	au_writel(sys_freqctrl, SYS_FREQCTRL0);
-
-	/*
-	 * Route 48MHz FREQ2 into USB Host and/or Device
-	 */
-	sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MUH_BIT;
-	au_writel(sys_clksrc, SYS_CLKSRC);
-
-	pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_USB;
-	/* 2nd USB port is USB host */
-	pin_func |= SYS_PF_USB;
-	au_writel(pin_func, SYS_PINFUNC);
-#endif /* IS_ENABLED(CONFIG_USB_OHCI_HCD) */
-
-#ifdef CONFIG_PCI
-	{
-		void __iomem *base =
-				(void __iomem *)KSEG1ADDR(AU1500_PCI_PHYS_ADDR);
-		/* Setup PCI bus controller */
-		__raw_writel(0x00003fff, base + PCI_REG_CMEM);
-		__raw_writel(0xf0000000, base + PCI_REG_MWMASK_DEV);
-		__raw_writel(0, base + PCI_REG_MWBASE_REV_CCL);
-		__raw_writel(0x02a00356, base + PCI_REG_STATCMD);
-		__raw_writel(0x00003c04, base + PCI_REG_PARAM);
-		__raw_writel(0x00000008, base + PCI_REG_MBAR);
-		wmb();
-	}
-#endif
-
-	/* Enable sys bus clock divider when IDLE state or no bus activity. */
-	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
-
-	/* Enable the RTC if not already enabled */
-	if (!(au_readl(0xac000028) & 0x20)) {
-		printk(KERN_INFO "enabling clock ...\n");
-		au_writel((au_readl(0xac000028) | 0x20), 0xac000028);
-	}
-	/* Put the clock in BCD mode */
-	if (au_readl(0xac00002c) & 0x4) { /* reg B */
-		au_writel(au_readl(0xac00002c) & ~0x4, 0xac00002c);
-		au_sync();
-	}
-}
-
-/******************************************************************************/
-
-static int pb1500_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
-{
-	if ((slot < 12) || (slot > 13) || pin == 0)
-		return -1;
-	if (slot == 12)
-		return (pin == 1) ? AU1500_PCI_INTA : 0xff;
-	if (slot == 13) {
-		switch (pin) {
-		case 1: return AU1500_PCI_INTA;
-		case 2: return AU1500_PCI_INTB;
-		case 3: return AU1500_PCI_INTC;
-		case 4: return AU1500_PCI_INTD;
-		}
-	}
-	return -1;
-}
-
-static struct resource alchemy_pci_host_res[] = {
-	[0] = {
-		.start	= AU1500_PCI_PHYS_ADDR,
-		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct alchemy_pci_platdata pb1500_pci_pd = {
-	.board_map_irq	= pb1500_map_pci_irq,
-	.pci_cfg_set	= PCI_CONFIG_AEN | PCI_CONFIG_R2H | PCI_CONFIG_R1H |
-			  PCI_CONFIG_CH |
-#if defined(__MIPSEB__)
-			  PCI_CONFIG_SIC_HWA_DAT | PCI_CONFIG_SM,
-#else
-			  0,
-#endif
-};
-
-static struct platform_device pb1500_pci_host = {
-	.dev.platform_data = &pb1500_pci_pd,
-	.name		= "alchemy-pci",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
-	.resource	= alchemy_pci_host_res,
-};
-
-static int __init pb1500_dev_init(void)
-{
-	int swapped;
-
-	irq_set_irq_type(AU1500_GPIO9_INT,   IRQF_TRIGGER_LOW);   /* CD0# */
-	irq_set_irq_type(AU1500_GPIO10_INT,  IRQF_TRIGGER_LOW);  /* CARD0 */
-	irq_set_irq_type(AU1500_GPIO11_INT,  IRQF_TRIGGER_LOW);  /* STSCHG0# */
-	irq_set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
-	irq_set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
-
-	/* PCMCIA. single socket, identical to Pb1100 */
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		AU1500_GPIO11_INT, AU1500_GPIO9_INT,	 /* card / insert */
-		/*AU1500_GPIO10_INT*/0, 0, 0); /* stschg / eject / id */
-
-	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
-	db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
-	platform_device_register(&pb1500_pci_host);
-
-	return 0;
-}
-arch_initcall(pb1500_dev_init);
diff --git a/arch/mips/configs/pb1100_defconfig b/arch/mips/configs/pb1100_defconfig
deleted file mode 100644
index 75eb1b1..0000000
--- a/arch/mips/configs/pb1100_defconfig
+++ /dev/null
@@ -1,124 +0,0 @@
-CONFIG_MIPS_ALCHEMY=y
-CONFIG_MIPS_PB1100=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
-CONFIG_LOCALVERSION="-pb1100"
-CONFIG_KERNEL_LZMA=y
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_TINY_RCU=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-# CONFIG_SYSCTL_SYSCALL is not set
-# CONFIG_KALLSYMS is not set
-# CONFIG_PCSPKR_PLATFORM is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_LBDAF is not set
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
-CONFIG_PM=y
-CONFIG_PM_RUNTIME=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_UB=y
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECS=y
-CONFIG_IDE_TASK_IOCTL=y
-# CONFIG_IDE_PROC_FS is not set
-CONFIG_NETDEVICES=y
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_QSEMI_PHY=y
-CONFIG_LXT_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_SMSC_PHY=y
-CONFIG_BROADCOM_PHY=y
-CONFIG_ICPLUS_PHY=y
-CONFIG_REALTEK_PHY=y
-CONFIG_NATIONAL_PHY=y
-CONFIG_STE10XP=y
-CONFIG_LSI_ET1011C_PHY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_MIPS_AU1X00_ENET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_HIDRAW=y
-CONFIG_USB_HIDDEV=y
-CONFIG_USB=y
-# CONFIG_USB_DEVICE_CLASS is not set
-CONFIG_USB_DYNAMIC_MINORS=y
-CONFIG_USB_SUSPEND=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_AU1XXX=y
-CONFIG_EXT2_FS=y
-# CONFIG_PROC_PAGE_MONITOR is not set
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_SUMMARY=y
-CONFIG_JFFS2_FS_XATTR=y
-# CONFIG_JFFS2_FS_POSIX_ACL is not set
-# CONFIG_JFFS2_FS_SECURITY is not set
-CONFIG_JFFS2_COMPRESSION_OPTIONS=y
-CONFIG_JFFS2_LZO=y
-CONFIG_JFFS2_RUBIN=y
-CONFIG_SQUASHFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_ROOT_NFS=y
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_ZBOOT=y
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
-CONFIG_SECURITYFS=y
diff --git a/arch/mips/configs/pb1500_defconfig b/arch/mips/configs/pb1500_defconfig
deleted file mode 100644
index fa00487..0000000
--- a/arch/mips/configs/pb1500_defconfig
+++ /dev/null
@@ -1,141 +0,0 @@
-CONFIG_MIPS_ALCHEMY=y
-CONFIG_MIPS_PB1500=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
-CONFIG_LOCALVERSION="-pb1500"
-CONFIG_KERNEL_LZMA=y
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_TINY_RCU=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-# CONFIG_SYSCTL_SYSCALL is not set
-# CONFIG_KALLSYMS is not set
-# CONFIG_PCSPKR_PLATFORM is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_PCI=y
-CONFIG_PCCARD=y
-# CONFIG_CARDBUS is not set
-CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
-CONFIG_PM=y
-CONFIG_PM_RUNTIME=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_UB=y
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECS=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_IDE_TASK_IOCTL=y
-# CONFIG_IDEPCI_PCIBUS_ORDER is not set
-CONFIG_BLK_DEV_HPT366=y
-CONFIG_NETDEVICES=y
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_QSEMI_PHY=y
-CONFIG_LXT_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_SMSC_PHY=y
-CONFIG_BROADCOM_PHY=y
-CONFIG_ICPLUS_PHY=y
-CONFIG_REALTEK_PHY=y
-CONFIG_NATIONAL_PHY=y
-CONFIG_STE10XP=y
-CONFIG_LSI_ET1011C_PHY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_MIPS_AU1X00_ENET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_SERIAL_8250_PCI is not set
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_VGA_ARB is not set
-CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
-CONFIG_FB_MODE_HELPERS=y
-CONFIG_FB_TILEBLITTING=y
-CONFIG_FB_S1D13XXX=y
-CONFIG_USB_HIDDEV=y
-CONFIG_USB=y
-# CONFIG_USB_DEVICE_CLASS is not set
-CONFIG_USB_DYNAMIC_MINORS=y
-CONFIG_USB_OTG_WHITELIST=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_AU1XXX=y
-CONFIG_EXT2_FS=y
-CONFIG_ISO9660_FS=y
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_UDF_FS=y
-CONFIG_VFAT_FS=y
-# CONFIG_PROC_PAGE_MONITOR is not set
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_SUMMARY=y
-CONFIG_JFFS2_COMPRESSION_OPTIONS=y
-CONFIG_JFFS2_LZO=y
-CONFIG_JFFS2_RUBIN=y
-CONFIG_SQUASHFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_850=y
-CONFIG_NLS_CODEPAGE_852=y
-CONFIG_NLS_CODEPAGE_1250=y
-CONFIG_NLS_ASCII=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_ISO8859_15=y
-CONFIG_NLS_UTF8=y
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_ZBOOT=y
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
-CONFIG_SECURITYFS=y
diff --git a/arch/mips/include/asm/mach-db1x00/bcsr.h b/arch/mips/include/asm/mach-db1x00/bcsr.h
index bb9fc23..16f1cf5 100644
--- a/arch/mips/include/asm/mach-db1x00/bcsr.h
+++ b/arch/mips/include/asm/mach-db1x00/bcsr.h
@@ -162,6 +162,8 @@ enum bcsr_whoami_boards {
 #define BCSR_BOARD_PCIEXTARB		0x0200
 #define BCSR_BOARD_GPIO200RST		0x0400
 #define BCSR_BOARD_PCICLKOUT		0x0800
+#define BCSR_BOARD_PB1100_SD0PWR	0x0400
+#define BCSR_BOARD_PB1100_SD1PWR	0x0800
 #define BCSR_BOARD_PCICFG		0x1000
 #define BCSR_BOARD_SPISEL		0x2000	/* PB/DB1550 */
 #define BCSR_BOARD_SD0WP		0x4000	/* DB1100 */
-- 
1.7.12
