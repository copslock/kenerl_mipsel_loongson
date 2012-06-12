Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2012 10:25:50 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:50801 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903628Ab2FLIYg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2012 10:24:36 +0200
Received: by bkwj4 with SMTP id j4so5334465bkw.36
        for <multiple recipients>; Tue, 12 Jun 2012 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zBIccyE69e+ociGWzUgmv4LjBXudJW6x9lFy0JdM9AQ=;
        b=EbfTTyI4Ur0pkpwz7UpM+PsRwEuI3RppB9y3LB219HnwErqDh/CnFpK4nRQFCNHSfq
         rNj32b3gCLw5rxC8gVIDssIG/tYerFBXg69ou/Bed073C/fLaHXqw7VIiO9hLyzIAdQD
         PMEnnb6z73Q6//NU7hVEHfx7S6cnLIGKxkKgJAL8+kBrBvIdwOx3Uw+8Kedft6GM4OEE
         5qf6IQfw1M276NLxsYMsQw0dCUHUMRLK4N59z+Bos7HCD5G0zuSNUDYbPdip0BqvM8kw
         tstP2TvFEb47rsCwoVMuOfegQadaHW0sohy2ud5jD44gZnMDI+VKzHWg8EWILqSESYfS
         KWvg==
Received: by 10.204.145.78 with SMTP id c14mr11231615bkv.43.1339489471045;
        Tue, 12 Jun 2012 01:24:31 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-055-195.pools.arcor-ip.net. [88.73.55.195])
        by mx.google.com with ESMTPS id h18sm19177912bkh.8.2012.06.12.01.24.29
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 01:24:30 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/8] MIPS: BCM63XX: move flash registration out of board_bcm963xx.c
Date:   Tue, 12 Jun 2012 10:23:38 +0200
Message-Id: <1339489425-19037-2-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 33612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

board_bcm963xx.c is already large enough.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/Makefile                         |    4 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |   49 +-------------
 arch/mips/bcm63xx/dev-flash.c                      |   69 ++++++++++++++++++++
 .../include/asm/mach-bcm63xx/bcm63xx_dev_flash.h   |    6 ++
 4 files changed, 79 insertions(+), 49 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-flash.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index 349b206..833af72 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,6 +1,6 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o setup.o timer.o \
-		   dev-dsp.o dev-enet.o dev-pcmcia.o dev-rng.o dev-spi.o \
-		   dev-uart.o dev-wdt.o
+		   dev-dsp.o dev-enet.o dev-flash.o dev-pcmcia.o dev-rng.o \
+		   dev-spi.o dev-uart.o dev-wdt.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index ea65c0f..bdfbdf9 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -11,9 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/physmap.h>
 #include <linux/ssb/ssb.h>
 #include <asm/addrspace.h>
 #include <bcm63xx_board.h>
@@ -24,6 +21,7 @@
 #include <bcm63xx_dev_pci.h>
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_dsp.h>
+#include <bcm63xx_dev_flash.h>
 #include <bcm63xx_dev_pcmcia.h>
 #include <bcm63xx_dev_spi.h>
 #include <board_bcm963xx.h>
@@ -809,40 +807,6 @@ void __init board_setup(void)
 		panic("unexpected CPU for bcm963xx board");
 }
 
-static struct mtd_partition mtd_partitions[] = {
-	{
-		.name		= "cfe",
-		.offset		= 0x0,
-		.size		= 0x40000,
-	}
-};
-
-static const char *bcm63xx_part_types[] = { "bcm63xxpart", NULL };
-
-static struct physmap_flash_data flash_data = {
-	.width			= 2,
-	.nr_parts		= ARRAY_SIZE(mtd_partitions),
-	.parts			= mtd_partitions,
-	.part_probe_types	= bcm63xx_part_types,
-};
-
-static struct resource mtd_resources[] = {
-	{
-		.start		= 0,	/* filled at runtime */
-		.end		= 0,	/* filled at runtime */
-		.flags		= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device mtd_dev = {
-	.name			= "physmap-flash",
-	.resource		= mtd_resources,
-	.num_resources		= ARRAY_SIZE(mtd_resources),
-	.dev			= {
-		.platform_data	= &flash_data,
-	},
-};
-
 static struct gpio_led_platform_data bcm63xx_led_data;
 
 static struct platform_device bcm63xx_gpio_leds = {
@@ -856,8 +820,6 @@ static struct platform_device bcm63xx_gpio_leds = {
  */
 int __init board_register_devices(void)
 {
-	u32 val;
-
 	if (board.has_uart0)
 		bcm63xx_uart_register(0);
 
@@ -893,14 +855,7 @@ int __init board_register_devices(void)
 
 	bcm63xx_spi_register();
 
-	/* read base address of boot chip select (0) */
-	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
-	val &= MPI_CSBASE_BASE_MASK;
-
-	mtd_resources[0].start = val;
-	mtd_resources[0].end = 0x1FFFFFFF;
-
-	platform_device_register(&mtd_dev);
+	bcm63xx_flash_register();
 
 	bcm63xx_led_data.num_leds = ARRAY_SIZE(board.leds);
 	bcm63xx_led_data.leds = board.leds;
diff --git a/arch/mips/bcm63xx/dev-flash.c b/arch/mips/bcm63xx/dev-flash.c
new file mode 100644
index 0000000..af52738
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-flash.c
@@ -0,0 +1,69 @@
+/*
+ * Broadcom BCM63xx flash registration
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_dev_flash.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_io.h>
+
+static struct mtd_partition mtd_partitions[] = {
+	{
+		.name		= "cfe",
+		.offset		= 0x0,
+		.size		= 0x40000,
+	}
+};
+
+static const char *bcm63xx_part_types[] = { "bcm63xxpart", NULL };
+
+static struct physmap_flash_data flash_data = {
+	.width			= 2,
+	.parts			= mtd_partitions,
+	.part_probe_types	= bcm63xx_part_types,
+};
+
+static struct resource mtd_resources[] = {
+	{
+		.start		= 0,	/* filled at runtime */
+		.end		= 0,	/* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device mtd_dev = {
+	.name			= "physmap-flash",
+	.resource		= mtd_resources,
+	.num_resources		= ARRAY_SIZE(mtd_resources),
+	.dev			= {
+		.platform_data	= &flash_data,
+	},
+};
+
+int __init bcm63xx_flash_register(void)
+{
+	u32 val;
+
+	/* read base address of boot chip select (0) */
+	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
+	val &= MPI_CSBASE_BASE_MASK;
+
+	mtd_resources[0].start = val;
+	mtd_resources[0].end = 0x1FFFFFFF;
+
+	return platform_device_register(&mtd_dev);
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h
new file mode 100644
index 0000000..8dcb541
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h
@@ -0,0 +1,6 @@
+#ifndef __BCM63XX_FLASH_H
+#define __BCM63XX_FLASH_H
+
+int __init bcm63xx_flash_register(void);
+
+#endif /* __BCM63XX_FLASH_H */
-- 
1.7.2.5
