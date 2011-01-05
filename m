Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2011 20:59:41 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:35756 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490987Ab1AET7M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Jan 2011 20:59:12 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 10/10] MIPS: lantiq: add machtypes for lantiq eval kits
Date:   Wed,  5 Jan 2011 20:56:19 +0100
Message-Id: <1294257379-417-11-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1294257379-417-1-git-send-email-blogic@openwrt.org>
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds mach specific code for the Lantiq EASY50712/50601 evaluation
boards

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lantiq/Kconfig               |    2 +
 arch/mips/lantiq/machtypes.h           |    2 +
 arch/mips/lantiq/xway/Kconfig          |   25 +++++++++++
 arch/mips/lantiq/xway/Makefile         |    3 +
 arch/mips/lantiq/xway/mach-easy50601.c |   70 ++++++++++++++++++++++++++++++++
 arch/mips/lantiq/xway/mach-easy50712.c |   70 ++++++++++++++++++++++++++++++++
 6 files changed, 172 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/lantiq/xway/Kconfig
 create mode 100644 arch/mips/lantiq/xway/mach-easy50601.c
 create mode 100644 arch/mips/lantiq/xway/mach-easy50712.c

diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index 2780461..3fccf21 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -18,4 +18,6 @@ config SOC_XWAY
 	select HW_HAS_PCI
 endchoice
 
+source "arch/mips/lantiq/xway/Kconfig"
+
 endif
diff --git a/arch/mips/lantiq/machtypes.h b/arch/mips/lantiq/machtypes.h
index ffcacfc..7e01b8c 100644
--- a/arch/mips/lantiq/machtypes.h
+++ b/arch/mips/lantiq/machtypes.h
@@ -13,6 +13,8 @@
 
 enum lantiq_mach_type {
 	LTQ_MACH_GENERIC = 0,
+	LTQ_MACH_EASY50712,	/* Danube evaluation board */
+	LTQ_MACH_EASY50601,	/* Amazon SE evaluation board */
 };
 
 #endif
diff --git a/arch/mips/lantiq/xway/Kconfig b/arch/mips/lantiq/xway/Kconfig
new file mode 100644
index 0000000..f6d0bec
--- /dev/null
+++ b/arch/mips/lantiq/xway/Kconfig
@@ -0,0 +1,25 @@
+if SOC_XWAY
+
+menu "Mips Machine"
+
+config LANTIQ_MACH_EASY50712
+	bool "Easy50712 - Danube"
+	default y
+
+endmenu
+
+endif
+
+if SOC_AMAZON_SE
+
+menu "Mips Machine"
+
+config LANTIQ_MACH_EASY50601
+	bool "Easy50601 - Amazon SE"
+	default y
+
+endmenu
+
+endif
+
+
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index 7b36708..570507c 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -2,3 +2,6 @@ obj-y := pmu.o reset.o gpio.o devices.o
 
 obj-$(CONFIG_SOC_XWAY) += clk-xway.o prom-xway.o
 obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o prom-ase.o
+
+obj-$(CONFIG_LANTIQ_MACH_EASY50712) += mach-easy50712.o
+obj-$(CONFIG_LANTIQ_MACH_EASY50601) += mach-easy50601.o
diff --git a/arch/mips/lantiq/xway/mach-easy50601.c b/arch/mips/lantiq/xway/mach-easy50601.c
new file mode 100644
index 0000000..fb591fc
--- /dev/null
+++ b/arch/mips/lantiq/xway/mach-easy50601.c
@@ -0,0 +1,70 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+#include <linux/input.h>
+
+#include <lantiq.h>
+
+#include "../machtypes.h"
+#include "devices.h"
+
+#ifdef CONFIG_MTD_PARTITIONS
+static struct mtd_partition easy50601_partitions[] = {
+	{
+		.name	= "uboot",
+		.offset	= 0x0,
+		.size	= 0x10000,
+	},
+	{
+		.name	= "uboot_env",
+		.offset	= 0x10000,
+		.size	= 0x10000,
+	},
+	{
+		.name	= "linux",
+		.offset	= 0x20000,
+		.size	= 0xE0000,
+	},
+	{
+		.name	= "rootfs",
+		.offset	= 0x100000,
+		.size	= 0x300000,
+	},
+};
+#endif
+
+static struct physmap_flash_data easy50601_flash_data = {
+#ifdef CONFIG_MTD_PARTITIONS
+	.nr_parts	= ARRAY_SIZE(easy50601_partitions),
+	.parts		= easy50601_partitions,
+#endif
+};
+
+static struct ltq_pci_data ltq_pci_data = {
+	.clock      = PCI_CLOCK_INT,
+	.req_mask   = 0xf,
+};
+
+static void __init
+easy50601_init(void)
+{
+	ltq_register_gpio();
+	ltq_register_nor(&easy50601_flash_data);
+	ltq_register_wdt();
+	ltq_register_pci(&ltq_pci_data);
+}
+
+MIPS_MACHINE(LTQ_MACH_EASY50601,
+			"EASY50601",
+			"EASY50601 Eval Board",
+			easy50601_init);
diff --git a/arch/mips/lantiq/xway/mach-easy50712.c b/arch/mips/lantiq/xway/mach-easy50712.c
new file mode 100644
index 0000000..816d1ce
--- /dev/null
+++ b/arch/mips/lantiq/xway/mach-easy50712.c
@@ -0,0 +1,70 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+#include <linux/input.h>
+
+#include <lantiq.h>
+
+#include "../machtypes.h"
+#include "devices.h"
+
+#ifdef CONFIG_MTD_PARTITIONS
+static struct mtd_partition easy50712_partitions[] = {
+	{
+		.name	= "uboot",
+		.offset	= 0x0,
+		.size	= 0x10000,
+	},
+	{
+		.name	= "uboot_env",
+		.offset	= 0x10000,
+		.size	= 0x10000,
+	},
+	{
+		.name	= "linux",
+		.offset	= 0x20000,
+		.size	= 0xE0000,
+	},
+	{
+		.name	= "rootfs",
+		.offset	= 0x100000,
+		.size	= 0x300000,
+	},
+};
+#endif
+
+static struct physmap_flash_data easy50712_flash_data = {
+#ifdef CONFIG_MTD_PARTITIONS
+	.nr_parts	= ARRAY_SIZE(easy50712_partitions),
+	.parts		= easy50712_partitions,
+#endif
+};
+
+static struct ltq_pci_data ltq_pci_data = {
+	.clock      = PCI_CLOCK_INT,
+	.req_mask   = 0xf,
+};
+
+static void __init
+easy50712_init(void)
+{
+	ltq_register_gpio();
+	ltq_register_nor(&easy50712_flash_data);
+	ltq_register_wdt();
+	ltq_register_pci(&ltq_pci_data);
+}
+
+MIPS_MACHINE(LTQ_MACH_EASY50712,
+			"EASY50712",
+			"EASY50712 Eval Board",
+			easy50712_init);
-- 
1.7.2.3
