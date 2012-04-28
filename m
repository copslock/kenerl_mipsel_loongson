Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 15:15:52 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:4934 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903709Ab2D1NNG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 15:13:06 +0200
Received: from [10.9.200.131] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 28 Apr 2012 06:12:53 -0700
X-Server-Uuid: B730DE51-FC43-4C83-941F-F1F78A914BDD
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Sat, 28 Apr 2012 06:12:48 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id E45B29F9F5; Sat, 28
 Apr 2012 06:12:47 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Sat, 28 Apr 2012 06:12:47 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Ganesan Ramalingam" <ganesanr@netlogicmicro.com>,
        "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 09/12] MIPS: Netlogic: Platform NAND/NOR flash support
Date:   Sat, 28 Apr 2012 18:42:15 +0530
Message-ID: <1335618738-4679-10-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 6385335F3E024591391-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Ganesan Ramalingam <ganesanr@netlogicmicro.com>

Changes to add support for the boot NOR flash on XLR boards and the
boot NAND/NOR flash drivers on the XLS boards.

Signed-off-by: Ganesan Ramalingam <ganesanr@netlogicmicro.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/netlogic/xlr/bridge.h |  104 +++++++++++++
 arch/mips/include/asm/netlogic/xlr/flash.h  |   55 +++++++
 arch/mips/netlogic/xlr/Makefile             |    2 +-
 arch/mips/netlogic/xlr/platform-flash.c     |  220 +++++++++++++++++++++++++++
 4 files changed, 380 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/netlogic/xlr/bridge.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/flash.h
 create mode 100644 arch/mips/netlogic/xlr/platform-flash.c

diff --git a/arch/mips/include/asm/netlogic/xlr/bridge.h b/arch/mips/include/asm/netlogic/xlr/bridge.h
new file mode 100644
index 0000000..2d02428
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlr/bridge.h
@@ -0,0 +1,104 @@
+/*
+ * Copyright (c) 2003-2012 Broadcom Corporation
+ * All Rights Reserved
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the Broadcom
+ * license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+#ifndef _ASM_NLM_BRIDGE_H_
+#define _ASM_NLM_BRIDGE_H_
+
+#define BRIDGE_DRAM_0_BAR		0
+#define BRIDGE_DRAM_1_BAR		1
+#define BRIDGE_DRAM_2_BAR		2
+#define BRIDGE_DRAM_3_BAR		3
+#define BRIDGE_DRAM_4_BAR		4
+#define BRIDGE_DRAM_5_BAR		5
+#define BRIDGE_DRAM_6_BAR		6
+#define BRIDGE_DRAM_7_BAR		7
+#define BRIDGE_DRAM_CHN_0_MTR_0_BAR	8
+#define BRIDGE_DRAM_CHN_0_MTR_1_BAR	9
+#define BRIDGE_DRAM_CHN_0_MTR_2_BAR	10
+#define BRIDGE_DRAM_CHN_0_MTR_3_BAR	11
+#define BRIDGE_DRAM_CHN_0_MTR_4_BAR	12
+#define BRIDGE_DRAM_CHN_0_MTR_5_BAR	13
+#define BRIDGE_DRAM_CHN_0_MTR_6_BAR	14
+#define BRIDGE_DRAM_CHN_0_MTR_7_BAR	15
+#define BRIDGE_DRAM_CHN_1_MTR_0_BAR	16
+#define BRIDGE_DRAM_CHN_1_MTR_1_BAR	17
+#define BRIDGE_DRAM_CHN_1_MTR_2_BAR	18
+#define BRIDGE_DRAM_CHN_1_MTR_3_BAR	19
+#define BRIDGE_DRAM_CHN_1_MTR_4_BAR	20
+#define BRIDGE_DRAM_CHN_1_MTR_5_BAR	21
+#define BRIDGE_DRAM_CHN_1_MTR_6_BAR	22
+#define BRIDGE_DRAM_CHN_1_MTR_7_BAR	23
+#define BRIDGE_CFG_BAR			24
+#define BRIDGE_PHNX_IO_BAR		25
+#define BRIDGE_FLASH_BAR		26
+#define BRIDGE_SRAM_BAR			27
+#define BRIDGE_HTMEM_BAR		28
+#define BRIDGE_HTINT_BAR		29
+#define BRIDGE_HTPIC_BAR		30
+#define BRIDGE_HTSM_BAR			31
+#define BRIDGE_HTIO_BAR			32
+#define BRIDGE_HTCFG_BAR		33
+#define BRIDGE_PCIXCFG_BAR		34
+#define BRIDGE_PCIXMEM_BAR		35
+#define BRIDGE_PCIXIO_BAR		36
+#define BRIDGE_DEVICE_MASK		37
+#define BRIDGE_AERR_INTR_LOG1		38
+#define BRIDGE_AERR_INTR_LOG2		39
+#define BRIDGE_AERR_INTR_LOG3		40
+#define BRIDGE_AERR_DEV_STAT		41
+#define BRIDGE_AERR1_LOG1		42
+#define BRIDGE_AERR1_LOG2		43
+#define BRIDGE_AERR1_LOG3		44
+#define BRIDGE_AERR1_DEV_STAT		45
+#define BRIDGE_AERR_INTR_EN		46
+#define BRIDGE_AERR_UPG			47
+#define BRIDGE_AERR_CLEAR		48
+#define BRIDGE_AERR1_CLEAR		49
+#define BRIDGE_SBE_COUNTS		50
+#define BRIDGE_DBE_COUNTS		51
+#define BRIDGE_BITERR_INT_EN		52
+
+#define BRIDGE_SYS2IO_CREDITS		53
+#define BRIDGE_EVNT_CNT_CTRL1		54
+#define BRIDGE_EVNT_COUNTER1		55
+#define BRIDGE_EVNT_CNT_CTRL2		56
+#define BRIDGE_EVNT_COUNTER2		57
+#define BRIDGE_RESERVED1		58
+
+#define BRIDGE_DEFEATURE		59
+#define BRIDGE_SCRATCH0			60
+#define BRIDGE_SCRATCH1			61
+#define BRIDGE_SCRATCH2			62
+#define BRIDGE_SCRATCH3			63
+
+#endif
diff --git a/arch/mips/include/asm/netlogic/xlr/flash.h b/arch/mips/include/asm/netlogic/xlr/flash.h
new file mode 100644
index 0000000..f8aca54
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlr/flash.h
@@ -0,0 +1,55 @@
+/*
+ * Copyright (c) 2003-2012 Broadcom Corporation
+ * All Rights Reserved
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the Broadcom
+ * license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+#ifndef _ASM_NLM_FLASH_H_
+#define _ASM_NLM_FLASH_H_
+
+#define FLASH_CSBASE_ADDR(cs)		(cs)
+#define FLASH_CSADDR_MASK(cs)		(0x10 + (cs))
+#define FLASH_CSDEV_PARM(cs)		(0x20 + (cs))
+#define FLASH_CSTIME_PARMA(cs)		(0x30 + (cs))
+#define FLASH_CSTIME_PARMB(cs)		(0x40 + (cs))
+
+#define FLASH_INT_MASK			0x50
+#define FLASH_INT_STATUS		0x60
+#define FLASH_ERROR_STATUS		0x70
+#define FLASH_ERROR_ADDR		0x80
+
+#define FLASH_NAND_CLE(cs)		(0x90 + (cs))
+#define FLASH_NAND_ALE(cs)		(0xa0 + (cs))
+
+#define FLASH_NAND_CSDEV_PARAM		0x000041e6
+#define FLASH_NAND_CSTIME_PARAMA	0x4f400e22
+#define FLASH_NAND_CSTIME_PARAMB	0x000083cf
+
+#endif
diff --git a/arch/mips/netlogic/xlr/Makefile b/arch/mips/netlogic/xlr/Makefile
index f01e4d7..c287dea 100644
--- a/arch/mips/netlogic/xlr/Makefile
+++ b/arch/mips/netlogic/xlr/Makefile
@@ -1,2 +1,2 @@
-obj-y				+= setup.o platform.o
+obj-y				+= setup.o platform.o platform-flash.o
 obj-$(CONFIG_SMP)		+= wakeup.o
diff --git a/arch/mips/netlogic/xlr/platform-flash.c b/arch/mips/netlogic/xlr/platform-flash.c
new file mode 100644
index 0000000..340ab16
--- /dev/null
+++ b/arch/mips/netlogic/xlr/platform-flash.c
@@ -0,0 +1,220 @@
+/*
+ * Copyright 2011, Netlogic Microsystems.
+ * Copyright 2004, Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/resource.h>
+#include <linux/spi/flash.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/xlr/iomap.h>
+#include <asm/netlogic/xlr/flash.h>
+#include <asm/netlogic/xlr/bridge.h>
+#include <asm/netlogic/xlr/gpio.h>
+#include <asm/netlogic/xlr/xlr.h>
+
+/*
+ * Default NOR partition layout
+ */
+static struct mtd_partition xlr_nor_parts[] = {
+	{
+		.name = "User FS",
+		.offset = 0x800000,
+		.size   = MTDPART_SIZ_FULL,
+	}
+};
+
+/*
+ * Default NAND partition layout
+ */
+static struct mtd_partition xlr_nand_parts[] = {
+	{
+		.name	= "Root Filesystem",
+		.offset	= 64 * 64 * 2048,
+		.size	= 432 * 64 * 2048,
+	},
+	{
+		.name	= "Home Filesystem",
+		.offset	= MTDPART_OFS_APPEND,
+		.size   = MTDPART_SIZ_FULL,
+	},
+};
+
+/* Use PHYSMAP flash for NOR */
+struct physmap_flash_data xlr_nor_data = {
+	.width		= 2,
+	.parts		= xlr_nor_parts,
+	.nr_parts	= ARRAY_SIZE(xlr_nor_parts),
+};
+
+static struct resource xlr_nor_res[] = {
+	{
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device xlr_nor_dev = {
+	.name	= "physmap-flash",
+	.dev	= {
+		.platform_data	= &xlr_nor_data,
+	},
+	.num_resources  = ARRAY_SIZE(xlr_nor_res),
+	.resource       = xlr_nor_res,
+};
+
+const char *xlr_part_probes[] = { "cmdlinepart", NULL };
+
+/*
+ * Use "gen_nand" driver for NAND flash
+ *
+ * There seems to be no way to store a private pointer containing
+ * platform specific info in gen_nand drivier. We will use a global
+ * struct for now, since we currently have only one NAND chip per board.
+ */
+struct xlr_nand_flash_priv {
+	int cs;
+	uint64_t flash_mmio;
+};
+
+static struct xlr_nand_flash_priv nand_priv;
+
+static void xlr_nand_ctrl(struct mtd_info *mtd, int cmd,
+		unsigned int ctrl)
+{
+	if (ctrl & NAND_CLE)
+		nlm_write_reg(nand_priv.flash_mmio,
+			FLASH_NAND_CLE(nand_priv.cs), cmd);
+	else if (ctrl & NAND_ALE)
+		nlm_write_reg(nand_priv.flash_mmio,
+			FLASH_NAND_ALE(nand_priv.cs), cmd);
+}
+
+struct platform_nand_data xlr_nand_data = {
+	.chip = {
+		.nr_chips	= 1,
+		.nr_partitions	= ARRAY_SIZE(xlr_nand_parts),
+		.chip_delay	= 50,
+		.partitions	= xlr_nand_parts,
+		.part_probe_types = xlr_part_probes,
+	},
+	.ctrl = {
+		.cmd_ctrl	= xlr_nand_ctrl,
+	},
+};
+
+static struct resource xlr_nand_res[] = {
+	{
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device xlr_nand_dev = {
+	.name		= "gen_nand",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(xlr_nand_res),
+	.resource	= xlr_nand_res,
+	.dev		= {
+		.platform_data	= &xlr_nand_data,
+	}
+};
+
+/*
+ * XLR/XLS supports upto 8 devices on its FLASH interface. The value in
+ * FLASH_BAR (on the MEM/IO bridge) gives the base for mapping all the
+ * flash devices.
+ * Under this, each flash device has an offset and size given by the
+ * CSBASE_ADDR and CSBASE_MASK registers for the device.
+ *
+ * The CSBASE_ registers are expected to be setup by the bootloader.
+ */
+static void setup_flash_resource(uint64_t flash_mmio,
+	uint64_t flash_map_base, int cs, struct resource *res)
+{
+	u32 base, mask;
+
+	base = nlm_read_reg(flash_mmio, FLASH_CSBASE_ADDR(cs));
+	mask = nlm_read_reg(flash_mmio, FLASH_CSADDR_MASK(cs));
+
+	res->start = flash_map_base + ((unsigned long)base << 16);
+	res->end = res->start + (mask + 1) * 64 * 1024;
+}
+
+static int __init xlr_flash_init(void)
+{
+	uint64_t gpio_mmio, flash_mmio, flash_map_base;
+	u32 gpio_resetcfg, flash_bar;
+	int cs, boot_nand, boot_nor;
+
+	/* Flash address bits 39:24 is in bridge flash BAR */
+	flash_bar = nlm_read_reg(nlm_io_base, BRIDGE_FLASH_BAR);
+	flash_map_base = (flash_bar & 0xffff0000) << 8;
+
+	gpio_mmio = nlm_mmio_base(NETLOGIC_IO_GPIO_OFFSET);
+	flash_mmio = nlm_mmio_base(NETLOGIC_IO_FLASH_OFFSET);
+
+	/* Get the chip reset config */
+	gpio_resetcfg = nlm_read_reg(gpio_mmio, GPIO_PWRON_RESET_CFG_REG);
+
+	/* Check for boot flash type */
+	boot_nor = boot_nand = 0;
+	if (nlm_chip_is_xls()) {
+		/* On XLS, check boot from NAND bit (GPIO reset reg bit 16) */
+		if (gpio_resetcfg & (1 << 16))
+			boot_nand = 1;
+
+		/* check boot from PCMCIA, (GPIO reset reg bit 15 */
+		if ((gpio_resetcfg & (1 << 15)) == 0)
+			boot_nor = 1;	/* not set, booted from NOR */
+	} else { /* XLR */
+		/* check boot from PCMCIA (bit 16 in GPIO reset on XLR) */
+		if ((gpio_resetcfg & (1 << 16)) == 0)
+			boot_nor = 1;	/* not set, booted from NOR */
+	}
+
+	/* boot flash at chip select 0 */
+	cs = 0;
+
+	if (boot_nand) {
+		nand_priv.cs = cs;
+		nand_priv.flash_mmio = flash_mmio;
+		setup_flash_resource(flash_mmio, flash_map_base, cs,
+			 xlr_nand_res);
+
+		/* Initialize NAND flash at CS 0 */
+		nlm_write_reg(flash_mmio, FLASH_CSDEV_PARM(cs),
+				FLASH_NAND_CSDEV_PARAM);
+		nlm_write_reg(flash_mmio, FLASH_CSTIME_PARMA(cs),
+				FLASH_NAND_CSTIME_PARAMA);
+		nlm_write_reg(flash_mmio, FLASH_CSTIME_PARMB(cs),
+				FLASH_NAND_CSTIME_PARAMB);
+
+		pr_info("ChipSelect %d: NAND Flash %pR\n", cs, xlr_nand_res);
+		return platform_device_register(&xlr_nand_dev);
+	}
+
+	if (boot_nor) {
+		setup_flash_resource(flash_mmio, flash_map_base, cs,
+			xlr_nor_res);
+		pr_info("ChipSelect %d: NOR Flash %pR\n", cs, xlr_nor_res);
+		return platform_device_register(&xlr_nor_dev);
+	}
+	return 0;
+}
+
+arch_initcall(xlr_flash_init);
-- 
1.7.9.5
