Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2012 21:46:58 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47520 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904057Ab2AKUos (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jan 2012 21:44:48 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH RESEND 06/17] MIPS: lantiq: add support for the EASY98000 evaluation board
Date:   Wed, 11 Jan 2012 21:44:23 +0100
Message-Id: <1326314674-9899-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
References: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch adds the machine code for the EASY9800 evaluation board.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/falcon/Kconfig          |   11 +++
 arch/mips/lantiq/falcon/Makefile         |    1 +
 arch/mips/lantiq/falcon/mach-easy98000.c |  110 ++++++++++++++++++++++++++++++
 arch/mips/lantiq/machtypes.h             |    5 ++
 4 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/lantiq/falcon/Kconfig
 create mode 100644 arch/mips/lantiq/falcon/mach-easy98000.c

diff --git a/arch/mips/lantiq/falcon/Kconfig b/arch/mips/lantiq/falcon/Kconfig
new file mode 100644
index 0000000..03e999d
--- /dev/null
+++ b/arch/mips/lantiq/falcon/Kconfig
@@ -0,0 +1,11 @@
+if SOC_FALCON
+
+menu "MIPS Machine"
+
+config LANTIQ_MACH_EASY98000
+	bool "Easy98000"
+	default y
+
+endmenu
+
+endif
diff --git a/arch/mips/lantiq/falcon/Makefile b/arch/mips/lantiq/falcon/Makefile
index de72209..56b22eb 100644
--- a/arch/mips/lantiq/falcon/Makefile
+++ b/arch/mips/lantiq/falcon/Makefile
@@ -1 +1,2 @@
 obj-y := clk.o prom.o reset.o sysctrl.o devices.o gpio.o
+obj-$(CONFIG_LANTIQ_MACH_EASY98000) += mach-easy98000.o
diff --git a/arch/mips/lantiq/falcon/mach-easy98000.c b/arch/mips/lantiq/falcon/mach-easy98000.c
new file mode 100644
index 0000000..361b8f0
--- /dev/null
+++ b/arch/mips/lantiq/falcon/mach-easy98000.c
@@ -0,0 +1,110 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2011 Thomas Langer <thomas.langer@lantiq.com>
+ *  Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/mtd/partitions.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_gpio.h>
+#include <linux/spi/eeprom.h>
+
+#include "../machtypes.h"
+
+#include "devices.h"
+
+static struct mtd_partition easy98000_nor_partitions[] = {
+	{
+		.name	= "uboot",
+		.offset	= 0x0,
+		.size	= 0x40000,
+	},
+	{
+		.name	= "uboot_env",
+		.offset	= 0x40000,
+		.size	= 0x40000,	/* 2 sectors for redundant env. */
+	},
+	{
+		.name	= "linux",
+		.offset	= 0x80000,
+		.size	= 0xF80000,	/* map only 16 MiB */
+	},
+};
+
+struct physmap_flash_data easy98000_nor_flash_data = {
+	.nr_parts	= ARRAY_SIZE(easy98000_nor_partitions),
+	.parts		= easy98000_nor_partitions,
+};
+
+/* setup gpio based spi bus/device for access to the eeprom on the board */
+#define SPI_GPIO_MRST		102
+#define SPI_GPIO_MTSR		103
+#define SPI_GPIO_CLK		104
+#define SPI_GPIO_CS0		105
+#define SPI_GPIO_CS1		106
+#define SPI_GPIO_BUS_NUM	1
+
+static struct spi_gpio_platform_data easy98000_spi_gpio_data = {
+	.sck		= SPI_GPIO_CLK,
+	.mosi		= SPI_GPIO_MTSR,
+	.miso		= SPI_GPIO_MRST,
+	.num_chipselect	= 2,
+};
+
+static struct platform_device easy98000_spi_gpio_device = {
+	.name			= "spi_gpio",
+	.id			= SPI_GPIO_BUS_NUM,
+	.dev.platform_data	= &easy98000_spi_gpio_data,
+};
+
+static struct spi_eeprom at25160n = {
+	.byte_len	= 16 * 1024 / 8,
+	.name		= "at25160n",
+	.page_size	= 32,
+	.flags		= EE_ADDR2,
+};
+
+static struct spi_board_info easy98000_spi_gpio_devices __initdata = {
+	.modalias		= "at25",
+	.bus_num		= SPI_GPIO_BUS_NUM,
+	.max_speed_hz		= 1000 * 1000,
+	.mode			= SPI_MODE_3,
+	.chip_select		= 1,
+	.controller_data	= (void *) SPI_GPIO_CS1,
+	.platform_data		= &at25160n,
+};
+
+static void __init
+easy98000_init_common(void)
+{
+	spi_register_board_info(&easy98000_spi_gpio_devices, 1);
+	platform_device_register(&easy98000_spi_gpio_device);
+}
+
+static void __init
+easy98000_init(void)
+{
+	easy98000_init_common();
+	ltq_register_nor(&easy98000_nor_flash_data);
+}
+
+static void __init
+easy98000nand_init(void)
+{
+	easy98000_init_common();
+	falcon_register_nand();
+}
+
+MIPS_MACHINE(LANTIQ_MACH_EASY98000,
+			"EASY98000",
+			"EASY98000 Eval Board",
+			easy98000_init);
+
+MIPS_MACHINE(LANTIQ_MACH_EASY98000NAND,
+			"EASY98000NAND",
+			"EASY98000 Eval Board (NAND Flash)",
+			easy98000nand_init);
diff --git a/arch/mips/lantiq/machtypes.h b/arch/mips/lantiq/machtypes.h
index 7e01b8c..dfc6af7 100644
--- a/arch/mips/lantiq/machtypes.h
+++ b/arch/mips/lantiq/machtypes.h
@@ -15,6 +15,11 @@ enum lantiq_mach_type {
 	LTQ_MACH_GENERIC = 0,
 	LTQ_MACH_EASY50712,	/* Danube evaluation board */
 	LTQ_MACH_EASY50601,	/* Amazon SE evaluation board */
+
+	/* FALCON */
+	LANTIQ_MACH_EASY98000,		/* Falcon Eval Board, NOR Flash */
+	LANTIQ_MACH_EASY98000SF,	/* Falcon Eval Board, Serial Flash */
+	LANTIQ_MACH_EASY98000NAND,	/* Falcon Eval Board, NAND Flash */
 };
 
 #endif
-- 
1.7.7.1
