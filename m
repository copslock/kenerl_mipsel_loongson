Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:12:27 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:56392 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903717Ab1KATGC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:06:02 +0100
Received: by faaq17 with SMTP id q17so950252faa.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ADiBL+HIu9+6tlxIZMnrQD4Bax4UWbQXtUwp9HYEWxE=;
        b=HEP0f9xNjPM4HMnd2k//MAemhWlPHurnDYyTOINOg8IAyEQghN+ov8fUK4niScUumE
         DQNpLwUGqAb1RKXdfhwlBwCLV19cxg2uHqIxu4qJhb6CbBppdSZ7o1haehQd+ySROrLW
         1kTP/+ZP9CadFFvrU/CyNPrEH6tZ6uwMXz2DI=
Received: by 10.223.1.137 with SMTP id 9mr2483995faf.19.1320174281019;
        Tue, 01 Nov 2011 12:04:41 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.04.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:04:40 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 10/18] MIPS: Alchemy: Merge PB1200 support into DB1200 code.
Date:   Tue,  1 Nov 2011 20:03:36 +0100
Message-Id: <1320174224-27305-11-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 668

The PB1200 is basically a DB1200 with additional MMC and camera sockets
and different base addresses for external hardware (CPLD, IDE, Net, NAND).

This patch implements the missing PB1200 features in DB1200 support code
and runtime board detection.

Tested on DB1200 only.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/Kconfig                  |   10 +-
 arch/mips/alchemy/Platform                 |    9 +-
 arch/mips/alchemy/devboards/Makefile       |    1 -
 arch/mips/alchemy/devboards/db1200.c       |  245 +++++++++++++-
 arch/mips/alchemy/devboards/pb1200.c       |  471 ----------------------------
 arch/mips/configs/pb1200_defconfig         |  170 ----------
 arch/mips/include/asm/mach-db1x00/db1200.h |   11 +-
 arch/mips/include/asm/mach-pb1x00/pb1200.h |  139 --------
 8 files changed, 238 insertions(+), 818 deletions(-)
 delete mode 100644 arch/mips/alchemy/devboards/pb1200.c
 delete mode 100644 arch/mips/configs/pb1200_defconfig
 delete mode 100644 arch/mips/include/asm/mach-pb1x00/pb1200.h

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index a1b995f..e1b3be7 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -42,7 +42,7 @@ config MIPS_DB1100
 	select SYS_HAS_EARLY_PRINTK
 
 config MIPS_DB1200
-	bool "Alchemy DB1200 board"
+	bool "Alchemy DB1200/PB1200 board"
 	select ALCHEMY_GPIOINT_AU1000
 	select DMA_COHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
@@ -85,14 +85,6 @@ config MIPS_PB1100
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
-config MIPS_PB1200
-	bool "Alchemy PB1200 board"
-	select ALCHEMY_GPIOINT_AU1000
-	select DMA_NONCOHERENT
-	select MIPS_DISABLE_OBSOLETE_IDE
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_HAS_EARLY_PRINTK
-
 config MIPS_PB1500
 	bool "Alchemy PB1500 board"
 	select ALCHEMY_GPIOINT_AU1000
diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
index c032f5b..bbdcc15 100644
--- a/arch/mips/alchemy/Platform
+++ b/arch/mips/alchemy/Platform
@@ -26,13 +26,6 @@ cflags-$(CONFIG_MIPS_PB1550)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
 load-$(CONFIG_MIPS_PB1550)	+= 0xffffffff80100000
 
 #
-# AMD Alchemy Pb1200 eval board
-#
-platform-$(CONFIG_MIPS_PB1200)	+= alchemy/devboards/
-cflags-$(CONFIG_MIPS_PB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
-load-$(CONFIG_MIPS_PB1200)	+= 0xffffffff80100000
-
-#
 # AMD Alchemy Db1000 eval board
 #
 platform-$(CONFIG_MIPS_DB1000)	+= alchemy/devboards/
@@ -61,7 +54,7 @@ cflags-$(CONFIG_MIPS_DB1550)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
 load-$(CONFIG_MIPS_DB1550)	+= 0xffffffff80100000
 
 #
-# AMD Alchemy Db1200 eval board
+# AMD Alchemy Db1200/Pb1200 eval boards
 #
 platform-$(CONFIG_MIPS_DB1200)	+= alchemy/devboards/
 cflags-$(CONFIG_MIPS_DB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index f562852..2fbf179 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -5,7 +5,6 @@
 obj-y += prom.o bcsr.o platform.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_MIPS_PB1100)	+= pb1100.o
-obj-$(CONFIG_MIPS_PB1200)	+= pb1200.o
 obj-$(CONFIG_MIPS_PB1500)	+= pb1500.o
 obj-$(CONFIG_MIPS_PB1550)	+= pb1550.o
 obj-$(CONFIG_MIPS_DB1000)	+= db1x00.o
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index e2cc5f9..ec481f3 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -1,5 +1,5 @@
 /*
- * DBAu1200 board platform device registration
+ * DBAu1200/PBAu1200 board platform device registration
  *
  * Copyright (C) 2008-2011 Manuel Lauss
  *
@@ -44,10 +44,41 @@
 
 #include "platform.h"
 
+static const char *board_type_str(void)
+{
+	switch (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI))) {
+	case BCSR_WHOAMI_PB1200_DDR1:
+	case BCSR_WHOAMI_PB1200_DDR2:
+		return "PB1200";
+	case BCSR_WHOAMI_DB1200:
+		return "DB1200";
+	default:
+		return "(unknown)";
+	}
+}
 
 const char *get_system_type(void)
 {
-	return "DB1200";
+	return board_type_str();
+}
+
+static int __init detect_board(void)
+{
+	int bid;
+
+	/* try the PB1200 first */
+	bcsr_init(PB1200_BCSR_PHYS_ADDR,
+		  PB1200_BCSR_PHYS_ADDR + PB1200_BCSR_HEXLED_OFS);
+	bid = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
+	if ((bid == BCSR_WHOAMI_PB1200_DDR1) ||
+	    (bid == BCSR_WHOAMI_PB1200_DDR2))
+		return 0;
+
+	/* okay, try the DB1200 then */
+	bcsr_init(DB1200_BCSR_PHYS_ADDR,
+		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
+	bid = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
+	return bid == BCSR_WHOAMI_DB1200 ? 0 : 1;
 }
 
 void __init board_setup(void)
@@ -55,12 +86,14 @@ void __init board_setup(void)
 	unsigned long freq0, clksrc, div, pfc;
 	unsigned short whoami;
 
-	bcsr_init(DB1200_BCSR_PHYS_ADDR,
-		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
+	if (detect_board()) {
+		printk(KERN_ERR "NOT running on a DB1200/PB1200 board!\n");
+		return;
+	}
 
 	whoami = bcsr_read(BCSR_WHOAMI);
-	printk(KERN_INFO "Alchemy/AMD/RMI DB1200 Board, CPLD Rev %d"
-		"  Board-ID %d  Daughtercard ID %d\n",
+	printk(KERN_INFO "Alchemy/AMD/RMI %s Board, CPLD Rev %d"
+		"  Board-ID %d  Daughtercard ID %d\n", board_type_str(),
 		(whoami >> 4) & 0xf, (whoami >> 8) & 0xf, whoami & 0xf);
 
 	/* SMBus/SPI on PSC0, Audio on PSC1 */
@@ -96,7 +129,7 @@ void __init board_setup(void)
 
 static struct mtd_partition db1200_spiflash_parts[] = {
 	{
-		.name	= "DB1200 SPI flash",
+		.name	= "spi_flash",
 		.offset	= 0,
 		.size	= MTDPART_SIZ_FULL,
 	},
@@ -376,12 +409,109 @@ static struct led_classdev db1200_mmc_led = {
 	.brightness_set	= db1200_mmcled_set,
 };
 
-static struct au1xmmc_platform_data db1200mmc_platdata = {
-	.cd_setup	= db1200_mmc_cd_setup,
-	.set_power	= db1200_mmc_set_power,
-	.card_inserted	= db1200_mmc_card_inserted,
-	.card_readonly	= db1200_mmc_card_readonly,
-	.led		= &db1200_mmc_led,
+/* -- */
+
+static irqreturn_t pb1200_mmc1_cd(int irq, void *ptr)
+{
+	void(*mmc_cd)(struct mmc_host *, unsigned long);
+
+	if (irq == PB1200_SD1_INSERT_INT) {
+		disable_irq_nosync(PB1200_SD1_INSERT_INT);
+		enable_irq(PB1200_SD1_EJECT_INT);
+	} else {
+		disable_irq_nosync(PB1200_SD1_EJECT_INT);
+		enable_irq(PB1200_SD1_INSERT_INT);
+	}
+
+	/* link against CONFIG_MMC=m */
+	mmc_cd = symbol_get(mmc_detect_change);
+	if (mmc_cd) {
+		mmc_cd(ptr, msecs_to_jiffies(500));
+		symbol_put(mmc_detect_change);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int pb1200_mmc1_cd_setup(void *mmc_host, int en)
+{
+	int ret;
+
+	if (en) {
+		ret = request_irq(PB1200_SD1_INSERT_INT, pb1200_mmc1_cd, 0,
+				  "sd1_insert", mmc_host);
+		if (ret)
+			goto out;
+
+		ret = request_irq(PB1200_SD1_EJECT_INT, pb1200_mmc1_cd, 0,
+				  "sd1_eject", mmc_host);
+		if (ret) {
+			free_irq(PB1200_SD1_INSERT_INT, mmc_host);
+			goto out;
+		}
+
+		if (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD1INSERT)
+			enable_irq(PB1200_SD1_EJECT_INT);
+		else
+			enable_irq(PB1200_SD1_INSERT_INT);
+
+	} else {
+		free_irq(PB1200_SD1_INSERT_INT, mmc_host);
+		free_irq(PB1200_SD1_EJECT_INT, mmc_host);
+	}
+	ret = 0;
+out:
+	return ret;
+}
+
+static void pb1200_mmc1led_set(struct led_classdev *led,
+			enum led_brightness brightness)
+{
+	if (brightness != LED_OFF)
+			bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED1, 0);
+	else
+			bcsr_mod(BCSR_LEDS, 0, BCSR_LEDS_LED1);
+}
+
+static struct led_classdev pb1200_mmc1_led = {
+	.brightness_set	= pb1200_mmc1led_set,
+};
+
+static void pb1200_mmc1_set_power(void *mmc_host, int state)
+{
+	if (state) {
+		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD1PWR);
+		msleep(400);	/* stabilization time */
+	} else
+		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD1PWR, 0);
+}
+
+static int pb1200_mmc1_card_readonly(void *mmc_host)
+{
+	return (bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD1WP) ? 1 : 0;
+}
+
+static int pb1200_mmc1_card_inserted(void *mmc_host)
+{
+	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD1INSERT) ? 1 : 0;
+}
+
+
+static struct au1xmmc_platform_data db1200_mmc_platdata[2] = {
+	[0] = {
+		.cd_setup	= db1200_mmc_cd_setup,
+		.set_power	= db1200_mmc_set_power,
+		.card_inserted	= db1200_mmc_card_inserted,
+		.card_readonly	= db1200_mmc_card_readonly,
+		.led		= &db1200_mmc_led,
+	},
+	[1] = {
+		.cd_setup	= pb1200_mmc1_cd_setup,
+		.set_power	= pb1200_mmc1_set_power,
+		.card_inserted	= pb1200_mmc1_card_inserted,
+		.card_readonly	= pb1200_mmc1_card_readonly,
+		.led		= &pb1200_mmc1_led,
+	},
 };
 
 static struct resource au1200_mmc0_resources[] = {
@@ -415,12 +545,47 @@ static struct platform_device db1200_mmc0_dev = {
 	.dev = {
 		.dma_mask		= &au1xxx_mmc_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &db1200mmc_platdata,
+		.platform_data		= &db1200_mmc_platdata[0],
 	},
 	.num_resources	= ARRAY_SIZE(au1200_mmc0_resources),
 	.resource	= au1200_mmc0_resources,
 };
 
+static struct resource au1200_mmc1_res[] = {
+	[0] = {
+		.start	= AU1100_SD1_PHYS_ADDR,
+		.end	= AU1100_SD1_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_SD_INT,
+		.end	= AU1200_SD_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_TX1,
+		.end	= AU1200_DSCR_CMD0_SDMS_TX1,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_RX1,
+		.end	= AU1200_DSCR_CMD0_SDMS_RX1,
+		.flags	= IORESOURCE_DMA,
+	}
+};
+
+static struct platform_device pb1200_mmc1_dev = {
+	.name		= "au1xxx-mmc",
+	.id		= 1,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1200_mmc_platdata[1],
+	},
+	.num_resources	= ARRAY_SIZE(au1200_mmc1_res),
+	.resource	= au1200_mmc1_res,
+};
+
 /**********************************************************************/
 
 static int db1200fb_panel_index(void)
@@ -598,14 +763,50 @@ static struct platform_device *db1200_devs[] __initdata = {
 	&db1200_sound_dev,
 };
 
+static struct platform_device *pb1200_devs[] __initdata = {
+	&pb1200_mmc1_dev,
+};
+
+/* Some peripheral base addresses differ on the PB1200 */
+static int __init pb1200_res_fixup(void)
+{
+	/* CPLD Revs earlier than 4 cause problems */
+	if (BCSR_WHOAMI_CPLD(bcsr_read(BCSR_WHOAMI)) <= 3) {
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "PB1200 must be at CPLD rev 4. Please have\n");
+		printk(KERN_ERR "the board updated to latest revisions.\n");
+		printk(KERN_ERR "This software will not work reliably\n");
+		printk(KERN_ERR "on anything older than CPLD rev 4.!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		return 1;
+	}
+
+	db1200_nand_res[0].start = PB1200_NAND_PHYS_ADDR;
+	db1200_nand_res[0].end   = PB1200_NAND_PHYS_ADDR + 0xff;
+	db1200_ide_res[0].start = PB1200_IDE_PHYS_ADDR;
+	db1200_ide_res[0].end   = PB1200_IDE_PHYS_ADDR + DB1200_IDE_PHYS_LEN - 1;
+	db1200_eth_res[0].start = PB1200_ETH_PHYS_ADDR;
+	db1200_eth_res[0].end   = PB1200_ETH_PHYS_ADDR + 0xff;
+	return 0;
+}
+
 static int __init db1200_dev_init(void)
 {
 	unsigned long pfc;
 	unsigned short sw;
-	int swapped;
+	int swapped, bid;
+
+	bid = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
+	if ((bid == BCSR_WHOAMI_PB1200_DDR1) ||
+	    (bid == BCSR_WHOAMI_PB1200_DDR2)) {
+		if (pb1200_res_fixup())
+			return -ENODEV;
+	}
 
 	/* GPIO7 is low-level triggered CPLD cascade */
-	irq_set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1200_GPIO7_INT, IRQ_TYPE_LEVEL_LOW);
 	bcsr_init_irq(DB1200_INT_BEGIN, DB1200_INT_END, AU1200_GPIO7_INT);
 
 	/* insert/eject pairs: one of both is always screaming.  To avoid
@@ -626,6 +827,7 @@ static int __init db1200_dev_init(void)
 
 	/* SWITCHES:	S6.8 I2C/SPI selector  (OFF=I2C  ON=SPI)
 	 *		S6.7 AC97/I2S selector (OFF=AC97 ON=I2S)
+	 *		or S12 on the PB1200.
 	 */
 
 	/* NOTE: GPIO215 controls OTG VBUS supply.  In SPI mode however
@@ -640,7 +842,7 @@ static int __init db1200_dev_init(void)
 	gpio_request(215, "otg-vbus");
 	gpio_direction_output(215, 1);
 
-	printk(KERN_INFO "DB1200 device configuration:\n");
+	printk(KERN_INFO "%s device configuration:\n", board_type_str());
 
 	sw = bcsr_read(BCSR_SWITCHES);
 	if (sw & BCSR_SWITCHES_DIP_8) {
@@ -707,6 +909,13 @@ static int __init db1200_dev_init(void)
 	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1200_SWAPBOOT;
 	db1x_register_norflash(64 << 20, 2, swapped);
 
-	return platform_add_devices(db1200_devs, ARRAY_SIZE(db1200_devs));
+	platform_add_devices(db1200_devs, ARRAY_SIZE(db1200_devs));
+
+	/* PB1200 is a DB1200 with a 2nd MMC and Camera connector */
+	if ((bid == BCSR_WHOAMI_PB1200_DDR1) ||
+	    (bid == BCSR_WHOAMI_PB1200_DDR2))
+		platform_add_devices(pb1200_devs, ARRAY_SIZE(pb1200_devs));
+
+	return 0;
 }
 device_initcall(db1200_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1200.c b/arch/mips/alchemy/devboards/pb1200.c
deleted file mode 100644
index a2676c9..0000000
--- a/arch/mips/alchemy/devboards/pb1200.c
+++ /dev/null
@@ -1,471 +0,0 @@
-/*
- * Pb1200/DBAu1200 board platform device registration
- *
- * Copyright (C) 2008 MontaVista Software Inc. <source@mvista.com>
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
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/leds.h>
-#include <linux/platform_device.h>
-#include <linux/smc91x.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/au1100_mmc.h>
-#include <asm/mach-au1x00/au1200fb.h>
-#include <asm/mach-au1x00/au1xxx_dbdma.h>
-#include <asm/mach-db1x00/bcsr.h>
-#include <asm/mach-pb1x00/pb1200.h>
-#include <prom.h>
-#include "platform.h"
-
-
-const char *get_system_type(void)
-{
-	return "PB1200";
-}
-
-void __init board_setup(void)
-{
-	printk(KERN_INFO "AMD Alchemy Pb1200 Board\n");
-	bcsr_init(PB1200_BCSR_PHYS_ADDR,
-		  PB1200_BCSR_PHYS_ADDR + PB1200_BCSR_HEXLED_OFS);
-
-#if 0
-	{
-		u32 pin_func;
-
-		/*
-		 * Enable PSC1 SYNC for AC97.  Normaly done in audio driver,
-		 * but it is board specific code, so put it here.
-		 */
-		pin_func = au_readl(SYS_PINFUNC);
-		au_sync();
-		pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
-		au_writel(pin_func, SYS_PINFUNC);
-
-		au_writel(0, (u32)bcsr | 0x10); /* turn off PCMCIA power */
-		au_sync();
-	}
-#endif
-
-#if defined(CONFIG_I2C_AU1550)
-	{
-		u32 freq0, clksrc;
-		u32 pin_func;
-
-		/* Select SMBus in CPLD */
-		bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC0MUX, 0);
-
-		pin_func = au_readl(SYS_PINFUNC);
-		au_sync();
-		pin_func &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
-		/* Set GPIOs correctly */
-		pin_func |= 2 << 17;
-		au_writel(pin_func, SYS_PINFUNC);
-		au_sync();
-
-		/* The I2C driver depends on 50 MHz clock */
-		freq0 = au_readl(SYS_FREQCTRL0);
-		au_sync();
-		freq0 &= ~(SYS_FC_FRDIV1_MASK | SYS_FC_FS1 | SYS_FC_FE1);
-		freq0 |= 3 << SYS_FC_FRDIV1_BIT;
-		/* 396 MHz / (3 + 1) * 2 == 49.5 MHz */
-		au_writel(freq0, SYS_FREQCTRL0);
-		au_sync();
-		freq0 |= SYS_FC_FE1;
-		au_writel(freq0, SYS_FREQCTRL0);
-		au_sync();
-
-		clksrc = au_readl(SYS_CLKSRC);
-		au_sync();
-		clksrc &= ~(SYS_CS_CE0 | SYS_CS_DE0 | SYS_CS_ME0_MASK);
-		/* Bit 22 is EXTCLK0 for PSC0 */
-		clksrc |= SYS_CS_MUX_FQ1 << SYS_CS_ME0_BIT;
-		au_writel(clksrc, SYS_CLKSRC);
-		au_sync();
-	}
-#endif
-
-	/*
-	 * The Pb1200 development board uses external MUX for PSC0 to
-	 * support SMB/SPI. bcsr_resets bit 12: 0=SMB 1=SPI
-	 */
-#ifdef CONFIG_I2C_AU1550
-	bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC0MUX, 0);
-#endif
-	au_sync();
-}
-
-/******************************************************************************/
-
-static int mmc_activity;
-
-static void pb1200mmc0_set_power(void *mmc_host, int state)
-{
-	if (state)
-		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD0PWR);
-	else
-		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD0PWR, 0);
-
-	msleep(1);
-}
-
-static int pb1200mmc0_card_readonly(void *mmc_host)
-{
-	return (bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD0WP) ? 1 : 0;
-}
-
-static int pb1200mmc0_card_inserted(void *mmc_host)
-{
-	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD0INSERT) ? 1 : 0;
-}
-
-static void pb1200_mmcled_set(struct led_classdev *led,
-			enum led_brightness brightness)
-{
-	if (brightness != LED_OFF) {
-		if (++mmc_activity == 1)
-			bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED0, 0);
-	} else {
-		if (--mmc_activity == 0)
-			bcsr_mod(BCSR_LEDS, 0, BCSR_LEDS_LED0);
-	}
-}
-
-static struct led_classdev pb1200mmc_led = {
-	.brightness_set	= pb1200_mmcled_set,
-};
-
-static void pb1200mmc1_set_power(void *mmc_host, int state)
-{
-	if (state)
-		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD1PWR);
-	else
-		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD1PWR, 0);
-
-	msleep(1);
-}
-
-static int pb1200mmc1_card_readonly(void *mmc_host)
-{
-	return (bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD1WP) ? 1 : 0;
-}
-
-static int pb1200mmc1_card_inserted(void *mmc_host)
-{
-	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD1INSERT) ? 1 : 0;
-}
-
-static struct au1xmmc_platform_data pb1200mmc_platdata[2] = {
-	[0] = {
-		.set_power	= pb1200mmc0_set_power,
-		.card_inserted	= pb1200mmc0_card_inserted,
-		.card_readonly	= pb1200mmc0_card_readonly,
-		.cd_setup	= NULL,		/* use poll-timer in driver */
-		.led		= &pb1200mmc_led,
-	},
-	[1] = {
-		.set_power	= pb1200mmc1_set_power,
-		.card_inserted	= pb1200mmc1_card_inserted,
-		.card_readonly	= pb1200mmc1_card_readonly,
-		.cd_setup	= NULL,		/* use poll-timer in driver */
-		.led		= &pb1200mmc_led,
-	},
-};
-
-static u64 au1xxx_mmc_dmamask =  DMA_BIT_MASK(32);
-
-static struct resource au1200_mmc0_res[] = {
-	[0] = {
-		.start	= AU1100_SD0_PHYS_ADDR,
-		.end	= AU1100_SD0_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1200_SD_INT,
-		.end	= AU1200_SD_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1200_DSCR_CMD0_SDMS_TX0,
-		.end	= AU1200_DSCR_CMD0_SDMS_TX0,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= AU1200_DSCR_CMD0_SDMS_RX0,
-		.end	= AU1200_DSCR_CMD0_SDMS_RX0,
-		.flags	= IORESOURCE_DMA,
-	}
-};
-
-static struct platform_device pb1200_mmc0_dev = {
-	.name		= "au1xxx-mmc",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &pb1200mmc_platdata[0],
-	},
-	.num_resources	= ARRAY_SIZE(au1200_mmc0_res),
-	.resource	= au1200_mmc0_res,
-};
-
-static struct resource au1200_mmc1_res[] = {
-	[0] = {
-		.start	= AU1100_SD1_PHYS_ADDR,
-		.end	= AU1100_SD1_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1200_SD_INT,
-		.end	= AU1200_SD_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1200_DSCR_CMD0_SDMS_TX1,
-		.end	= AU1200_DSCR_CMD0_SDMS_TX1,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= AU1200_DSCR_CMD0_SDMS_RX1,
-		.end	= AU1200_DSCR_CMD0_SDMS_RX1,
-		.flags	= IORESOURCE_DMA,
-	}
-};
-
-static struct platform_device pb1200_mmc1_dev = {
-	.name		= "au1xxx-mmc",
-	.id		= 1,
-	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &pb1200mmc_platdata[1],
-	},
-	.num_resources	= ARRAY_SIZE(au1200_mmc1_res),
-	.resource	= au1200_mmc1_res,
-};
-
-
-static struct resource ide_resources[] = {
-	[0] = {
-		.start	= IDE_PHYS_ADDR,
-		.end	= IDE_PHYS_ADDR + IDE_PHYS_LEN - 1,
-		.flags	= IORESOURCE_MEM
-	},
-	[1] = {
-		.start	= IDE_INT,
-		.end	= IDE_INT,
-		.flags	= IORESOURCE_IRQ
-	},
-	[2] = {
-		.start	= AU1200_DSCR_CMD0_DMA_REQ1,
-		.end	= AU1200_DSCR_CMD0_DMA_REQ1,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static u64 au1200_ide_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device ide_device = {
-	.name		= "au1200-ide",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &au1200_ide_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(ide_resources),
-	.resource	= ide_resources
-};
-
-static struct smc91x_platdata smc_data = {
-	.flags	= SMC91X_NOWAIT | SMC91X_USE_16BIT,
-	.leda	= RPC_LED_100_10,
-	.ledb	= RPC_LED_TX_RX,
-};
-
-static struct resource smc91c111_resources[] = {
-	[0] = {
-		.name	= "smc91x-regs",
-		.start	= SMC91C111_PHYS_ADDR,
-		.end	= SMC91C111_PHYS_ADDR + 0xf,
-		.flags	= IORESOURCE_MEM
-	},
-	[1] = {
-		.start	= SMC91C111_INT,
-		.end	= SMC91C111_INT,
-		.flags	= IORESOURCE_IRQ
-	},
-};
-
-static struct platform_device smc91c111_device = {
-	.dev	= {
-		.platform_data	= &smc_data,
-	},
-	.name		= "smc91x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(smc91c111_resources),
-	.resource	= smc91c111_resources
-};
-
-static struct resource au1200_psc0_res[] = {
-	[0] = {
-		.start	= AU1550_PSC0_PHYS_ADDR,
-		.end	= AU1550_PSC0_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1200_PSC0_INT,
-		.end	= AU1200_PSC0_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1200_DSCR_CMD0_PSC0_TX,
-		.end	= AU1200_DSCR_CMD0_PSC0_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= AU1200_DSCR_CMD0_PSC0_RX,
-		.end	= AU1200_DSCR_CMD0_PSC0_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct platform_device pb1200_i2c_dev = {
-	.name		= "au1xpsc_smbus",
-	.id		= 0,	/* bus number */
-	.num_resources	= ARRAY_SIZE(au1200_psc0_res),
-	.resource	= au1200_psc0_res,
-};
-
-static int pb1200fb_panel_index(void)
-{
-	return (bcsr_read(BCSR_SWITCHES) >> 8) & 0x0f;
-}
-
-static int pb1200fb_panel_init(void)
-{
-	/* Apply power */
-	bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
-				BCSR_BOARD_LCDBL);
-	return 0;
-}
-
-static int pb1200fb_panel_shutdown(void)
-{
-	/* Remove power */
-	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
-			     BCSR_BOARD_LCDBL, 0);
-	return 0;
-}
-
-static struct au1200fb_platdata pb1200fb_pd = {
-	.panel_index	= pb1200fb_panel_index,
-	.panel_init	= pb1200fb_panel_init,
-	.panel_shutdown	= pb1200fb_panel_shutdown,
-};
-
-static struct resource au1200_lcd_res[] = {
-	[0] = {
-		.start	= AU1200_LCD_PHYS_ADDR,
-		.end	= AU1200_LCD_PHYS_ADDR + 0x800 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1200_LCD_INT,
-		.end	= AU1200_LCD_INT,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static u64 au1200_lcd_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device pb1200_lcd_dev = {
-	.name		= "au1200-lcd",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &au1200_lcd_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &pb1200fb_pd,
-	},
-	.num_resources	= ARRAY_SIZE(au1200_lcd_res),
-	.resource	= au1200_lcd_res,
-};
-
-static struct platform_device *board_platform_devices[] __initdata = {
-	&ide_device,
-	&smc91c111_device,
-	&pb1200_i2c_dev,
-	&pb1200_mmc0_dev,
-	&pb1200_mmc1_dev,
-	&pb1200_lcd_dev,
-};
-
-static int __init board_register_devices(void)
-{
-	int swapped;
-
-	/* We have a problem with CPLD rev 3. */
-	if (BCSR_WHOAMI_CPLD(bcsr_read(BCSR_WHOAMI)) <= 3) {
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "Pb1200 must be at CPLD rev 4. Please have Pb1200\n");
-		printk(KERN_ERR "updated to latest revision. This software will\n");
-		printk(KERN_ERR "not work on anything less than CPLD rev 4.\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		panic("Game over.  Your score is 0.");
-	}
-
-	irq_set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
-	bcsr_init_irq(PB1200_INT_BEGIN, PB1200_INT_END, AU1200_GPIO7_INT);
-
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		PB1200_PC0_INT, PB1200_PC0_INSERT_INT,
-		/*PB1200_PC0_STSCHG_INT*/0, PB1200_PC0_EJECT_INT, 0);
-
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008000000,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
-		PB1200_PC1_INT, PB1200_PC1_INSERT_INT,
-		/*PB1200_PC1_STSCHG_INT*/0, PB1200_PC1_EJECT_INT, 1);
-
-	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1200_SWAPBOOT;
-	db1x_register_norflash(128 * 1024 * 1024, 2, swapped);
-
-	return platform_add_devices(board_platform_devices,
-				    ARRAY_SIZE(board_platform_devices));
-}
-device_initcall(board_register_devices);
diff --git a/arch/mips/configs/pb1200_defconfig b/arch/mips/configs/pb1200_defconfig
deleted file mode 100644
index dcbe270..0000000
--- a/arch/mips/configs/pb1200_defconfig
+++ /dev/null
@@ -1,170 +0,0 @@
-CONFIG_MIPS_ALCHEMY=y
-CONFIG_MIPS_PB1200=y
-CONFIG_KSM=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
-CONFIG_LOCALVERSION="-pb1200"
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
-CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
-CONFIG_BINFMT_MISC=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_PLATFORM=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_UB=y
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECS=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_IDE_TASK_IOCTL=y
-# CONFIG_IDE_PROC_FS is not set
-CONFIG_BLK_DEV_IDE_AU1XXX=y
-CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_SMC91X=y
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
-CONFIG_SERIAL_8250_NR_UARTS=2
-CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-# CONFIG_I2C_COMPAT is not set
-CONFIG_I2C_CHARDEV=y
-# CONFIG_I2C_HELPER_AUTO is not set
-CONFIG_I2C_AU1550=y
-CONFIG_SPI=y
-CONFIG_SPI_AU1550=y
-CONFIG_GPIOLIB=y
-CONFIG_GPIO_SYSFS=y
-CONFIG_SENSORS_ADM1025=y
-CONFIG_SENSORS_LM70=y
-CONFIG_FB=y
-CONFIG_FB_AU1200=y
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x16=y
-CONFIG_SOUND=y
-CONFIG_SND=y
-CONFIG_SND_DYNAMIC_MINORS=y
-# CONFIG_SND_SUPPORT_OLD_API is not set
-# CONFIG_SND_VERBOSE_PROCFS is not set
-# CONFIG_SND_DRIVERS is not set
-# CONFIG_SND_SPI is not set
-# CONFIG_SND_MIPS is not set
-# CONFIG_SND_USB is not set
-# CONFIG_SND_PCMCIA is not set
-CONFIG_SND_SOC=y
-CONFIG_SND_SOC_AU1XPSC=y
-CONFIG_SND_SOC_DB1200=y
-CONFIG_HIDRAW=y
-CONFIG_USB_HIDDEV=y
-CONFIG_USB=y
-CONFIG_USB_DEBUG=y
-CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-# CONFIG_USB_DEVICE_CLASS is not set
-CONFIG_USB_DYNAMIC_MINORS=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_ROOT_HUB_TT=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
-CONFIG_MMC_AU1X=y
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_TRIGGERS=y
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
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_EFI_PARTITION=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_850=y
-CONFIG_NLS_CODEPAGE_852=y
-CONFIG_NLS_CODEPAGE_1250=y
-CONFIG_NLS_ASCII=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_ISO8859_2=y
-CONFIG_NLS_ISO8859_15=y
-CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,115200"
-CONFIG_DEBUG_ZBOOT=y
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
-CONFIG_SECURITYFS=y
diff --git a/arch/mips/include/asm/mach-db1x00/db1200.h b/arch/mips/include/asm/mach-db1x00/db1200.h
index 7a39657..b2a8319 100644
--- a/arch/mips/include/asm/mach-db1x00/db1200.h
+++ b/arch/mips/include/asm/mach-db1x00/db1200.h
@@ -43,15 +43,20 @@
 #define BCSR_INT_PC1EJECT	0x0800
 #define BCSR_INT_SD0INSERT	0x1000
 #define BCSR_INT_SD0EJECT	0x2000
+#define BCSR_INT_SD1INSERT	0x4000
+#define BCSR_INT_SD1EJECT	0x8000
 
-#define IDE_PHYS_ADDR		0x18800000
 #define IDE_REG_SHIFT		5
 
-#define DB1200_IDE_PHYS_ADDR	IDE_PHYS_ADDR
+#define DB1200_IDE_PHYS_ADDR	0x18800000
 #define DB1200_IDE_PHYS_LEN	(16 << IDE_REG_SHIFT)
 #define DB1200_ETH_PHYS_ADDR	0x19000300
 #define DB1200_NAND_PHYS_ADDR	0x20000000
 
+#define PB1200_IDE_PHYS_ADDR	0x0C800000
+#define PB1200_ETH_PHYS_ADDR	0x0D000300
+#define PB1200_NAND_PHYS_ADDR	0x1C000000
+
 /*
  * External Interrupts for DBAu1200 as of 8/6/2004.
  * Bit positions in the CPLD registers can be calculated by taking
@@ -77,6 +82,8 @@ enum external_db1200_ints {
 	DB1200_PC1_EJECT_INT,
 	DB1200_SD0_INSERT_INT,
 	DB1200_SD0_EJECT_INT,
+	PB1200_SD1_INSERT_INT,
+	PB1200_SD1_EJECT_INT,
 
 	DB1200_INT_END		= DB1200_INT_BEGIN + 15,
 };
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1200.h b/arch/mips/include/asm/mach-pb1x00/pb1200.h
deleted file mode 100644
index 374416a..0000000
--- a/arch/mips/include/asm/mach-pb1x00/pb1200.h
+++ /dev/null
@@ -1,139 +0,0 @@
-/*
- * AMD Alchemy Pb1200 Reference Board
- * Board Registers defines.
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- *
- */
-#ifndef __ASM_PB1200_H
-#define __ASM_PB1200_H
-
-#include <linux/types.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/au1xxx_psc.h>
-
-#define DBDMA_AC97_TX_CHAN	AU1200_DSCR_CMD0_PSC1_TX
-#define DBDMA_AC97_RX_CHAN	AU1200_DSCR_CMD0_PSC1_RX
-#define DBDMA_I2S_TX_CHAN	AU1200_DSCR_CMD0_PSC1_TX
-#define DBDMA_I2S_RX_CHAN	AU1200_DSCR_CMD0_PSC1_RX
-
-/*
- * SPI and SMB are muxed on the Pb1200 board.
- * Refer to board documentation.
- */
-#define SPI_PSC_BASE		AU1550_PSC0_PHYS_ADDR
-#define SMBUS_PSC_BASE		AU1550_PSC0_PHYS_ADDR
-/*
- * AC97 and I2S are muxed on the Pb1200 board.
- * Refer to board documentation.
- */
-#define AC97_PSC_BASE       AU1550_PSC1_PHYS_ADDR
-#define I2S_PSC_BASE	AU1550_PSC1_PHYS_ADDR
-
-
-#define BCSR_SYSTEM_VDDI	0x001F
-#define BCSR_SYSTEM_POWEROFF	0x4000
-#define BCSR_SYSTEM_RESET	0x8000
-
-/* Bit positions for the different interrupt sources */
-#define BCSR_INT_IDE		0x0001
-#define BCSR_INT_ETH		0x0002
-#define BCSR_INT_PC0		0x0004
-#define BCSR_INT_PC0STSCHG	0x0008
-#define BCSR_INT_PC1		0x0010
-#define BCSR_INT_PC1STSCHG	0x0020
-#define BCSR_INT_DC		0x0040
-#define BCSR_INT_FLASHBUSY	0x0080
-#define BCSR_INT_PC0INSERT	0x0100
-#define BCSR_INT_PC0EJECT	0x0200
-#define BCSR_INT_PC1INSERT	0x0400
-#define BCSR_INT_PC1EJECT	0x0800
-#define BCSR_INT_SD0INSERT	0x1000
-#define BCSR_INT_SD0EJECT	0x2000
-#define BCSR_INT_SD1INSERT	0x4000
-#define BCSR_INT_SD1EJECT	0x8000
-
-#define SMC91C111_PHYS_ADDR	0x0D000300
-#define SMC91C111_INT		PB1200_ETH_INT
-
-#define IDE_PHYS_ADDR		0x0C800000
-#define IDE_REG_SHIFT		5
-#define IDE_PHYS_LEN		(16 << IDE_REG_SHIFT)
-#define IDE_INT 		PB1200_IDE_INT
-
-#define NAND_PHYS_ADDR 	0x1C000000
-
-/*
- * Timing values as described in databook, * ns value stripped of
- * lower 2 bits.
- * These defines are here rather than an Au1200 generic file because
- * the parts chosen on another board may be different and may require
- * different timings.
- */
-#define NAND_T_H		(18 >> 2)
-#define NAND_T_PUL		(30 >> 2)
-#define NAND_T_SU		(30 >> 2)
-#define NAND_T_WH		(30 >> 2)
-
-/* Bitfield shift amounts */
-#define NAND_T_H_SHIFT		0
-#define NAND_T_PUL_SHIFT	4
-#define NAND_T_SU_SHIFT		8
-#define NAND_T_WH_SHIFT		12
-
-#define NAND_TIMING	(((NAND_T_H   & 0xF) << NAND_T_H_SHIFT)   | \
-			 ((NAND_T_PUL & 0xF) << NAND_T_PUL_SHIFT) | \
-			 ((NAND_T_SU  & 0xF) << NAND_T_SU_SHIFT)  | \
-			 ((NAND_T_WH  & 0xF) << NAND_T_WH_SHIFT))
-
-/*
- * External Interrupts for Pb1200 as of 8/6/2004.
- * Bit positions in the CPLD registers can be calculated by taking
- * the interrupt define and subtracting the PB1200_INT_BEGIN value.
- *
- *   Example: IDE bis pos is  = 64 - 64
- *            ETH bit pos is  = 65 - 64
- */
-enum external_pb1200_ints {
-	PB1200_INT_BEGIN	= AU1000_MAX_INTR + 1,
-
-	PB1200_IDE_INT		= PB1200_INT_BEGIN,
-	PB1200_ETH_INT,
-	PB1200_PC0_INT,
-	PB1200_PC0_STSCHG_INT,
-	PB1200_PC1_INT,
-	PB1200_PC1_STSCHG_INT,
-	PB1200_DC_INT,
-	PB1200_FLASHBUSY_INT,
-	PB1200_PC0_INSERT_INT,
-	PB1200_PC0_EJECT_INT,
-	PB1200_PC1_INSERT_INT,
-	PB1200_PC1_EJECT_INT,
-	PB1200_SD0_INSERT_INT,
-	PB1200_SD0_EJECT_INT,
-	PB1200_SD1_INSERT_INT,
-	PB1200_SD1_EJECT_INT,
-
-	PB1200_INT_END		= PB1200_INT_BEGIN + 15
-};
-
-/* NAND chip select */
-#define NAND_CS 1
-
-#endif /* __ASM_PB1200_H */
-- 
1.7.7.1
