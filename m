Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2008 16:55:21 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:6821 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20177191AbYD1PzT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Apr 2008 16:55:19 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 1FFF58815; Mon, 28 Apr 2008 20:55:16 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Pb1200/DBAu1200: move platform code to its proper place (take 3)
Date:	Mon, 28 Apr 2008 19:54:38 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200804281954.38256.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Since both the IDE interface and SMC 91C111 Ethernet chip are on-board devices,
not SOC devices, move the platform device registration form the common to the
board specific code.

While at it, remove semicolon (which didn't break compilation only by chance)
from the AU1XXX_ATA_DDMA_REQ macro and do some renaming:

- change 'au1200_ide0_' variable name prefix to the mere 'ide_';

- change 'smc91x_' variable name prefix to 'smc91c111_' since that's the name
  of the chip used on the boards;

- drop 'AU1XXX_' prefix from the names of macros describing IDE and Ethernet
  on-board devices;

- change 'SMC91111_' to 'SMC91C111_', change 'IRQ' to 'INT' in the names of the
  macros describing the Ethernet chip for consistency with the IDE macros;

- change 'ATA_' to 'IDE_' and 'OFFSET' to 'SHIFT' (since this value is indeed
  a shift count) in the names of the macros describing the IDE interface.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Fixed the patch to apply atop of the recent IDE updates and fixed/completed the
patch description. The patch has only been compile tested...

 arch/mips/au1000/common/platform.c    |   54 ---------------------
 arch/mips/au1000/pb1200/Makefile      |    1 
 arch/mips/au1000/pb1200/platform.c    |   84 ++++++++++++++++++++++++++++++++++
 drivers/ide/mips/au1xxx-ide.c         |    8 +--
 include/asm-mips/mach-db1x00/db1200.h |   16 +++---
 include/asm-mips/mach-pb1x00/pb1200.h |   16 +++---
 6 files changed, 105 insertions(+), 74 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/platform.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/platform.c
+++ linux-2.6/arch/mips/au1000/common/platform.c
@@ -233,19 +233,6 @@ static struct resource au1200_lcd_resour
 	}
 };
 
-static struct resource au1200_ide0_resources[] = {
-	[0] = {
-		.start		= AU1XXX_ATA_PHYS_ADDR,
-		.end 		= AU1XXX_ATA_PHYS_ADDR + AU1XXX_ATA_PHYS_LEN - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1XXX_ATA_INT,
-		.end		= AU1XXX_ATA_INT,
-		.flags		= IORESOURCE_IRQ,
-	}
-};
-
 static u64 au1200_lcd_dmamask = ~(u32)0;
 
 static struct platform_device au1200_lcd_device = {
@@ -259,20 +246,6 @@ static struct platform_device au1200_lcd
 	.resource       = au1200_lcd_resources,
 };
 
-
-static u64 ide0_dmamask = ~(u32)0;
-
-static struct platform_device au1200_ide0_device = {
-	.name		= "au1200-ide",
-	.id		= 0,
-	.dev = {
-		.dma_mask 		= &ide0_dmamask,
-		.coherent_dma_mask	= 0xffffffff,
-	},
-	.num_resources = ARRAY_SIZE(au1200_ide0_resources),
-	.resource	= au1200_ide0_resources,
-};
-
 static u64 au1xxx_mmc_dmamask =  ~(u32)0;
 
 static struct platform_device au1xxx_mmc_device = {
@@ -292,29 +265,6 @@ static struct platform_device au1x00_pcm
 	.id 		= 0,
 };
 
-#if defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200)
-static struct resource smc91x_resources[] = {
-	[0] = {
-		.name	= "smc91x-regs",
-		.start	= AU1XXX_SMC91111_PHYS_ADDR,
-		.end	= AU1XXX_SMC91111_PHYS_ADDR + 0xf,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1XXX_SMC91111_IRQ,
-		.end	= AU1XXX_SMC91111_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device smc91x_device = {
-	.name		= "smc91x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(smc91x_resources),
-	.resource	= smc91x_resources,
-};
-#endif /* defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200) */
-
 /* All Alchemy demoboards with I2C have this #define in their headers */
 #ifdef SMBUS_PSC_BASE
 static struct resource pbdb_smbus_resources[] = {
@@ -345,12 +295,8 @@ static struct platform_device *au1xxx_pl
 	&au1xxx_usb_gdt_device,
 	&au1xxx_usb_otg_device,
 	&au1200_lcd_device,
-	&au1200_ide0_device,
 	&au1xxx_mmc_device,
 #endif
-#if defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200)
-	&smc91x_device,
-#endif
 #ifdef SMBUS_PSC_BASE
 	&pbdb_smbus_device,
 #endif
Index: linux-2.6/arch/mips/au1000/pb1200/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1200/Makefile
+++ linux-2.6/arch/mips/au1000/pb1200/Makefile
@@ -3,5 +3,6 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
+obj-y += platform.o
 
 EXTRA_CFLAGS += -Werror
Index: linux-2.6/arch/mips/au1000/pb1200/platform.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/mips/au1000/pb1200/platform.c
@@ -0,0 +1,84 @@
+/*
+ * Pb1200/DBAu1200 board platform device registration
+ *
+ * Copyright (C) 2008 MontaVista Software Inc. <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-au1x00/au1xxx.h>
+
+static struct resource ide_resources[] = {
+	[0] = {
+		.start	= IDE_PHYS_ADDR,
+		.end 	= IDE_PHYS_ADDR + IDE_PHYS_LEN - 1,
+		.flags	= IORESOURCE_MEM
+	},
+	[1] = {
+		.start	= IDE_INT,
+		.end	= IDE_INT,
+		.flags	= IORESOURCE_IRQ
+	}
+};
+
+static u64 ide_dmamask = ~(u32)0;
+
+static struct platform_device ide_device = {
+	.name		= "au1200-ide",
+	.id		= 0,
+	.dev = {
+		.dma_mask 		= &ide_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(ide_resources),
+	.resource	= ide_resources
+};
+
+static struct resource smc91c111_resources[] = {
+	[0] = {
+		.name	= "smc91x-regs",
+		.start	= SMC91C111_PHYS_ADDR,
+		.end	= SMC91C111_PHYS_ADDR + 0xf,
+		.flags	= IORESOURCE_MEM
+	},
+	[1] = {
+		.start	= SMC91C111_INT,
+		.end	= SMC91C111_INT,
+		.flags	= IORESOURCE_IRQ
+	},
+};
+
+static struct platform_device smc91c111_device = {
+	.name		= "smc91x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(smc91c111_resources),
+	.resource	= smc91c111_resources
+};
+
+static struct platform_device *board_platform_devices[] __initdata = {
+	&ide_device,
+	&smc91c111_device
+};
+
+static int __init board_register_devices(void)
+{
+	return platform_add_devices(board_platform_devices,
+				    ARRAY_SIZE(board_platform_devices));
+}
+
+arch_initcall(board_register_devices);
Index: linux-2.6/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/mips/au1xxx-ide.c
+++ linux-2.6/drivers/ide/mips/au1xxx-ide.c
@@ -359,7 +359,7 @@ static void auide_ddma_rx_callback(int i
 static void auide_init_dbdma_dev(dbdev_tab_t *dev, u32 dev_id, u32 tsize, u32 devwidth, u32 flags)
 {
 	dev->dev_id          = dev_id;
-	dev->dev_physaddr    = (u32)AU1XXX_ATA_PHYS_ADDR;
+	dev->dev_physaddr    = (u32)IDE_PHYS_ADDR;
 	dev->dev_intlevel    = 0;
 	dev->dev_intpolarity = 0;
 	dev->dev_tsize       = tsize;
@@ -397,7 +397,7 @@ static int auide_ddma_init(ide_hwif_t *h
 	dbdev_tab_t source_dev_tab, target_dev_tab;
 	u32 dev_id, tsize, devwidth, flags;
 
-	dev_id   = AU1XXX_ATA_DDMA_REQ;
+	dev_id	 = IDE_DDMA_REQ;
 
 	tsize    =  8; /*  1 */
 	devwidth = 32; /* 16 */
@@ -506,10 +506,10 @@ static void auide_setup_ports(hw_regs_t 
 
 	/* FIXME? */
 	for (i = 0; i < 8; i++)
-		*ata_regs++ = ahwif->regbase + (i << AU1XXX_ATA_REG_OFFSET);
+		*ata_regs++ = ahwif->regbase + (i << IDE_REG_SHIFT);
 
 	/* set the Alternative Status register */
-	*ata_regs = ahwif->regbase + (14 << AU1XXX_ATA_REG_OFFSET);
+	*ata_regs = ahwif->regbase + (14 << IDE_REG_SHIFT);
 }
 
 static const struct ide_port_ops au1xxx_port_ops = {
Index: linux-2.6/include/asm-mips/mach-db1x00/db1200.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-db1x00/db1200.h
+++ linux-2.6/include/asm-mips/mach-db1x00/db1200.h
@@ -169,15 +169,15 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define BCSR_INT_SD0INSERT	0x1000
 #define BCSR_INT_SD0EJECT	0x2000
 
-#define AU1XXX_SMC91111_PHYS_ADDR	(0x19000300)
-#define AU1XXX_SMC91111_IRQ			DB1200_ETH_INT
+#define SMC91C111_PHYS_ADDR	0x19000300
+#define SMC91C111_INT		DB1200_ETH_INT
 
-#define AU1XXX_ATA_PHYS_ADDR		(0x18800000)
-#define AU1XXX_ATA_REG_OFFSET		(5)
-#define AU1XXX_ATA_PHYS_LEN		(16 << AU1XXX_ATA_REG_OFFSET)
-#define AU1XXX_ATA_INT			DB1200_IDE_INT
-#define AU1XXX_ATA_DDMA_REQ		DSCR_CMD0_DMA_REQ1;
-#define AU1XXX_ATA_RQSIZE		128
+#define IDE_PHYS_ADDR		0x18800000
+#define IDE_REG_SHIFT		5
+#define IDE_PHYS_LEN		(16 << IDE_REG_SHIFT)
+#define IDE_INT 		DB1200_IDE_INT
+#define IDE_DDMA_REQ		DSCR_CMD0_DMA_REQ1
+#define IDE_RQSIZE		128
 
 #define NAND_PHYS_ADDR   0x20000000
 
Index: linux-2.6/include/asm-mips/mach-pb1x00/pb1200.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-pb1x00/pb1200.h
+++ linux-2.6/include/asm-mips/mach-pb1x00/pb1200.h
@@ -182,15 +182,15 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define SET_VCC_VPP(VCC, VPP, SLOT)\
 	((((VCC)<<2) | ((VPP)<<0)) << ((SLOT)*8))
 
-#define AU1XXX_SMC91111_PHYS_ADDR	(0x0D000300)
-#define AU1XXX_SMC91111_IRQ			PB1200_ETH_INT
+#define SMC91C111_PHYS_ADDR	0x0D000300
+#define SMC91C111_INT		PB1200_ETH_INT
 
-#define AU1XXX_ATA_PHYS_ADDR		(0x0C800000)
-#define AU1XXX_ATA_REG_OFFSET		(5)
-#define AU1XXX_ATA_PHYS_LEN		(16 << AU1XXX_ATA_REG_OFFSET)
-#define AU1XXX_ATA_INT			PB1200_IDE_INT
-#define AU1XXX_ATA_DDMA_REQ		DSCR_CMD0_DMA_REQ1;
-#define AU1XXX_ATA_RQSIZE		128
+#define IDE_PHYS_ADDR		0x0C800000
+#define IDE_REG_SHIFT		5
+#define IDE_PHYS_LEN		(16 << IDE_REG_SHIFT)
+#define IDE_INT 		PB1200_IDE_INT
+#define IDE_DDMA_REQ		DSCR_CMD0_DMA_REQ1
+#define IDE_RQSIZE		128
 
 #define NAND_PHYS_ADDR   0x1C000000
 
