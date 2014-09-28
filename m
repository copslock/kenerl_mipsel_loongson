Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 20:34:19 +0200 (CEST)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:37542 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010017AbaI1Sb2Jz5sm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 20:31:28 +0200
Received: by mail-lb0-f182.google.com with SMTP id z11so5084666lbi.27
        for <multiple recipients>; Sun, 28 Sep 2014 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VnLK7DTn4i1pFZwh1Pd/O/YiXD7Z/n0tDqvSp1SBpok=;
        b=OJyNi7pOMRO0aY0r1F9mZ6sR7/f+APdldvV+6HscCsfHphvrm67zTSOUu95zcCriLI
         kFSs8d8Dnn8zEpHPmVIHz3FYStOFiqLAOZaPJfGTWERiqha6sYFdd9lpCiKt6Cq5wxKv
         vpR2fzQ9U9eEetC3pEuDtKqEuODK/KyjOA9jT7aXZGqyhkQt+c9hdEzAC08DPgV9LdmR
         CvhUBZ0f+alOphABRrBaZA2VxHZOydW0adZP6XpH0BXlBlpXhaYHUhp5JOUpRXXzujQr
         5Ggzrpz3WW2gaEgSP9G6Uswprm3Z5VGVnClO3q/xDvSkD/9H83vCVmOHR58NgyN6n84b
         CBzg==
X-Received: by 10.152.203.167 with SMTP id kr7mr34732925lac.9.1411929082407;
        Sun, 28 Sep 2014 11:31:22 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id je9sm581674lbc.3.2014.09.28.11.31.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 11:31:21 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 11/16] mtd: add Atheros AR2315 SPI Flash driver
Date:   Sun, 28 Sep 2014 22:33:10 +0400
Message-Id: <1411929195-23775-12-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Atheros AR2315 SoC have a SPI Flash unit with hybrid flash access: flash
read is performed via memory mapping, on the other hand flash write is
performed by explicitly issued SPI command.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org
---
This driver is not ready for merging since it should be rewrited using
spi-nor framework.

Changes since RFC:
  - move device registration to separate patch

 drivers/mtd/devices/Kconfig           |   5 +
 drivers/mtd/devices/Makefile          |   1 +
 drivers/mtd/devices/ar2315.c          | 459 ++++++++++++++++++++++++++++++++++
 drivers/mtd/devices/ar2315_spiflash.h | 106 ++++++++
 4 files changed, 571 insertions(+)
 create mode 100644 drivers/mtd/devices/ar2315.c
 create mode 100644 drivers/mtd/devices/ar2315_spiflash.h

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index c49d0b1..9533867 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -112,6 +112,11 @@ config MTD_SST25L
 	  Set up your spi devices with the right board-specific platform data,
 	  if you want to specify device partitioning.
 
+config MTD_AR2315
+	tristate "Atheros AR2315+ SPI Flash support"
+	depends on SOC_AR2315
+	default y
+
 config MTD_BCM47XXSFLASH
 	tristate "R/O support for serial flash on BCMA bus"
 	depends on BCMA_SFLASH
diff --git a/drivers/mtd/devices/Makefile b/drivers/mtd/devices/Makefile
index c68868f..eaec8fb 100644
--- a/drivers/mtd/devices/Makefile
+++ b/drivers/mtd/devices/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_MTD_M25P80)	+= m25p80.o
 obj-$(CONFIG_MTD_NAND_OMAP_BCH)	+= elm.o
 obj-$(CONFIG_MTD_SPEAR_SMI)	+= spear_smi.o
 obj-$(CONFIG_MTD_SST25L)	+= sst25l.o
+obj-$(CONFIG_MTD_AR2315)	+= ar2315.o
 obj-$(CONFIG_MTD_BCM47XXSFLASH)	+= bcm47xxsflash.o
 obj-$(CONFIG_MTD_ST_SPI_FSM)    += st_spi_fsm.o
 
diff --git a/drivers/mtd/devices/ar2315.c b/drivers/mtd/devices/ar2315.c
new file mode 100644
index 0000000..f2a5e28
--- /dev/null
+++ b/drivers/mtd/devices/ar2315.c
@@ -0,0 +1,459 @@
+
+/*
+ * MTD driver for the SPI Flash Memory support on Atheros AR2315
+ *
+ * Copyright (c) 2005-2006 Atheros Communications Inc.
+ * Copyright (C) 2006-2007 FON Technology, SL.
+ * Copyright (C) 2006-2007 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
+ * Copyright (C) 2012 Alexandros C. Couloumbis <alex@ozo.com>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+
+#include "ar2315_spiflash.h"
+
+#define DRIVER_NAME "ar2315-spiflash"
+
+#define busy_wait(_priv, _condition, _wait) do { \
+	while (_condition) { \
+		if (_wait > 1) \
+			msleep(_wait); \
+		else if ((_wait == 1) && need_resched()) \
+			schedule(); \
+		else \
+			udelay(1); \
+	} \
+} while (0)
+
+enum {
+	FLASH_NONE,
+	FLASH_1MB,
+	FLASH_2MB,
+	FLASH_4MB,
+	FLASH_8MB,
+	FLASH_16MB,
+};
+
+/* Flash configuration table */
+struct flashconfig {
+	u32 byte_cnt;
+	u32 sector_cnt;
+	u32 sector_size;
+};
+
+static const struct flashconfig flashconfig_tbl[] = {
+	[FLASH_NONE] = { 0, 0, 0},
+	[FLASH_1MB]  = { STM_1MB_BYTE_COUNT, STM_1MB_SECTOR_COUNT,
+			 STM_1MB_SECTOR_SIZE},
+	[FLASH_2MB]  = { STM_2MB_BYTE_COUNT, STM_2MB_SECTOR_COUNT,
+			 STM_2MB_SECTOR_SIZE},
+	[FLASH_4MB]  = { STM_4MB_BYTE_COUNT, STM_4MB_SECTOR_COUNT,
+			 STM_4MB_SECTOR_SIZE},
+	[FLASH_8MB]  = { STM_8MB_BYTE_COUNT, STM_8MB_SECTOR_COUNT,
+			 STM_8MB_SECTOR_SIZE},
+	[FLASH_16MB] = { STM_16MB_BYTE_COUNT, STM_16MB_SECTOR_COUNT,
+			 STM_16MB_SECTOR_SIZE}
+};
+
+/* Mapping of generic opcodes to STM serial flash opcodes */
+enum {
+	SPI_WRITE_ENABLE,
+	SPI_WRITE_DISABLE,
+	SPI_RD_STATUS,
+	SPI_WR_STATUS,
+	SPI_RD_DATA,
+	SPI_FAST_RD_DATA,
+	SPI_PAGE_PROGRAM,
+	SPI_SECTOR_ERASE,
+	SPI_BULK_ERASE,
+	SPI_DEEP_PWRDOWN,
+	SPI_RD_SIG,
+};
+
+struct opcodes {
+	__u16 code;
+	__s8 tx_cnt;
+	__s8 rx_cnt;
+};
+
+static const struct opcodes stm_opcodes[] = {
+	[SPI_WRITE_ENABLE] = {STM_OP_WR_ENABLE, 1, 0},
+	[SPI_WRITE_DISABLE] = {STM_OP_WR_DISABLE, 1, 0},
+	[SPI_RD_STATUS] = {STM_OP_RD_STATUS, 1, 1},
+	[SPI_WR_STATUS] = {STM_OP_WR_STATUS, 1, 0},
+	[SPI_RD_DATA] = {STM_OP_RD_DATA, 4, 4},
+	[SPI_FAST_RD_DATA] = {STM_OP_FAST_RD_DATA, 5, 0},
+	[SPI_PAGE_PROGRAM] = {STM_OP_PAGE_PGRM, 8, 0},
+	[SPI_SECTOR_ERASE] = {STM_OP_SECTOR_ERASE, 4, 0},
+	[SPI_BULK_ERASE] = {STM_OP_BULK_ERASE, 1, 0},
+	[SPI_DEEP_PWRDOWN] = {STM_OP_DEEP_PWRDOWN, 1, 0},
+	[SPI_RD_SIG] = {STM_OP_RD_SIG, 4, 1},
+};
+
+/* Driver private data structure */
+struct spiflash_priv {
+	struct mtd_info mtd;
+	void __iomem *readaddr; /* memory mapped data for read  */
+	void __iomem *mmraddr;  /* memory mapped register space */
+	struct mutex lock;	/* serialize registers access */
+};
+
+#define to_spiflash(_mtd) container_of(_mtd, struct spiflash_priv, mtd)
+
+enum {
+	FL_READY,
+	FL_READING,
+	FL_ERASING,
+	FL_WRITING
+};
+
+/*****************************************************************************/
+
+static u32
+spiflash_read_reg(struct spiflash_priv *priv, int reg)
+{
+	return ioread32(priv->mmraddr + reg);
+}
+
+static void
+spiflash_write_reg(struct spiflash_priv *priv, int reg, u32 data)
+{
+	iowrite32(data, priv->mmraddr + reg);
+}
+
+static u32
+spiflash_wait_busy(struct spiflash_priv *priv)
+{
+	u32 reg;
+
+	busy_wait(priv, (reg = spiflash_read_reg(priv, SPI_FLASH_CTL)) &
+		SPI_CTL_BUSY, 0);
+	return reg;
+}
+
+static u32
+spiflash_sendcmd(struct spiflash_priv *priv, int opcode, u32 addr)
+{
+	const struct opcodes *op;
+	u32 reg, mask;
+
+	op = &stm_opcodes[opcode];
+	reg = spiflash_wait_busy(priv);
+	spiflash_write_reg(priv, SPI_FLASH_OPCODE,
+			   ((u32)op->code) | (addr << 8));
+
+	reg &= ~SPI_CTL_TX_RX_CNT_MASK;
+	reg |= SPI_CTL_START | op->tx_cnt | (op->rx_cnt << 4);
+
+	spiflash_write_reg(priv, SPI_FLASH_CTL, reg);
+	spiflash_wait_busy(priv);
+
+	if (!op->rx_cnt)
+		return 0;
+
+	reg = spiflash_read_reg(priv, SPI_FLASH_DATA);
+
+	switch (op->rx_cnt) {
+	case 1:
+		mask = 0x000000ff;
+		break;
+	case 2:
+		mask = 0x0000ffff;
+		break;
+	case 3:
+		mask = 0x00ffffff;
+		break;
+	default:
+		mask = 0xffffffff;
+		break;
+	}
+	reg &= mask;
+
+	return reg;
+}
+
+/*
+ * Probe SPI flash device
+ * Function returns 0 for failure.
+ * and flashconfig_tbl array index for success.
+ */
+static int
+spiflash_probe_chip(struct platform_device *pdev, struct spiflash_priv *priv)
+{
+	u32 sig = spiflash_sendcmd(priv, SPI_RD_SIG, 0);
+	int flash_size;
+
+	switch (sig) {
+	case STM_8MBIT_SIGNATURE:
+		flash_size = FLASH_1MB;
+		break;
+	case STM_16MBIT_SIGNATURE:
+		flash_size = FLASH_2MB;
+		break;
+	case STM_32MBIT_SIGNATURE:
+		flash_size = FLASH_4MB;
+		break;
+	case STM_64MBIT_SIGNATURE:
+		flash_size = FLASH_8MB;
+		break;
+	case STM_128MBIT_SIGNATURE:
+		flash_size = FLASH_16MB;
+		break;
+	default:
+		dev_warn(&pdev->dev, "read of flash device signature failed!\n");
+		return 0;
+	}
+
+	return flash_size;
+}
+
+static void
+spiflash_wait_complete(struct spiflash_priv *priv, unsigned int timeout)
+{
+	busy_wait(priv, spiflash_sendcmd(priv, SPI_RD_STATUS, 0) &
+		SPI_STATUS_WIP, timeout);
+}
+
+static int
+spiflash_erase(struct mtd_info *mtd, struct erase_info *instr)
+{
+	struct spiflash_priv *priv = to_spiflash(mtd);
+	const struct opcodes *op;
+	u32 temp, reg;
+
+	if (instr->addr + instr->len > mtd->size)
+		return -EINVAL;
+
+	mutex_lock(&priv->lock);
+
+	spiflash_sendcmd(priv, SPI_WRITE_ENABLE, 0);
+	reg = spiflash_wait_busy(priv);
+
+	op = &stm_opcodes[SPI_SECTOR_ERASE];
+	temp = ((u32)instr->addr << 8) | (u32)(op->code);
+	spiflash_write_reg(priv, SPI_FLASH_OPCODE, temp);
+
+	reg &= ~SPI_CTL_TX_RX_CNT_MASK;
+	reg |= op->tx_cnt | SPI_CTL_START;
+	spiflash_write_reg(priv, SPI_FLASH_CTL, reg);
+
+	spiflash_wait_complete(priv, 20);
+
+	mutex_unlock(&priv->lock);
+
+	instr->state = MTD_ERASE_DONE;
+	mtd_erase_callback(instr);
+
+	return 0;
+}
+
+static int
+spiflash_read(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
+	      u_char *buf)
+{
+	struct spiflash_priv *priv = to_spiflash(mtd);
+
+	if (!len)
+		return 0;
+
+	if (from + len > mtd->size)
+		return -EINVAL;
+
+	*retlen = len;
+
+	mutex_lock(&priv->lock);
+
+	memcpy_fromio(buf, priv->readaddr + from, len);
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int
+spiflash_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
+	       const u8 *buf)
+{
+	struct spiflash_priv *priv = to_spiflash(mtd);
+	u32 opcode, bytes_left;
+
+	*retlen = 0;
+
+	if (!len)
+		return 0;
+
+	if (to + len > mtd->size)
+		return -EINVAL;
+
+	bytes_left = len;
+
+	do {
+		u32 read_len, reg, page_offset, spi_data = 0;
+
+		read_len = min(bytes_left, sizeof(u32));
+
+		/* 32-bit writes cannot span across a page boundary
+		 * (256 bytes). This types of writes require two page
+		 * program operations to handle it correctly. The STM part
+		 * will write the overflow data to the beginning of the
+		 * current page as opposed to the subsequent page.
+		 */
+		page_offset = (to & (STM_PAGE_SIZE - 1)) + read_len;
+
+		if (page_offset > STM_PAGE_SIZE)
+			read_len -= (page_offset - STM_PAGE_SIZE);
+
+		mutex_lock(&priv->lock);
+
+		spiflash_sendcmd(priv, SPI_WRITE_ENABLE, 0);
+		spi_data = 0;
+		switch (read_len) {
+		case 4:
+			spi_data |= buf[3] << 24;
+			/* fall through */
+		case 3:
+			spi_data |= buf[2] << 16;
+			/* fall through */
+		case 2:
+			spi_data |= buf[1] << 8;
+			/* fall through */
+		case 1:
+			spi_data |= buf[0] & 0xff;
+			break;
+		default:
+			break;
+		}
+
+		spiflash_write_reg(priv, SPI_FLASH_DATA, spi_data);
+		opcode = stm_opcodes[SPI_PAGE_PROGRAM].code |
+			(to & 0x00ffffff) << 8;
+		spiflash_write_reg(priv, SPI_FLASH_OPCODE, opcode);
+
+		reg = spiflash_read_reg(priv, SPI_FLASH_CTL);
+		reg &= ~SPI_CTL_TX_RX_CNT_MASK;
+		reg |= (read_len + 4) | SPI_CTL_START;
+		spiflash_write_reg(priv, SPI_FLASH_CTL, reg);
+
+		spiflash_wait_complete(priv, 1);
+
+		mutex_unlock(&priv->lock);
+
+		bytes_left -= read_len;
+		to += read_len;
+		buf += read_len;
+
+		*retlen += read_len;
+	} while (bytes_left != 0);
+
+	return 0;
+}
+
+#if defined CONFIG_MTD_REDBOOT_PARTS || CONFIG_MTD_MYLOADER_PARTS
+static const char * const part_probe_types[] = {
+	"cmdlinepart", "RedBoot", "MyLoader", NULL
+};
+#endif
+
+static int
+spiflash_probe(struct platform_device *pdev)
+{
+	struct spiflash_priv *priv;
+	struct mtd_info *mtd;
+	struct resource *res;
+	int index;
+	int result = 0;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_init(&priv->lock);
+	mtd = &priv->mtd;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	priv->mmraddr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->mmraddr)) {
+		dev_warn(&pdev->dev, "failed to map flash MMR\n");
+		return PTR_ERR(priv->mmraddr);
+	}
+
+	index = spiflash_probe_chip(pdev, priv);
+	if (!index) {
+		dev_warn(&pdev->dev, "found no flash device\n");
+		return -ENODEV;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->readaddr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->readaddr)) {
+		dev_warn(&pdev->dev, "failed to map flash read mem\n");
+		return PTR_ERR(priv->readaddr);
+	}
+
+	platform_set_drvdata(pdev, priv);
+	mtd->name = "spiflash";
+	mtd->type = MTD_NORFLASH;
+	mtd->flags = (MTD_CAP_NORFLASH|MTD_WRITEABLE);
+	mtd->size = flashconfig_tbl[index].byte_cnt;
+	mtd->erasesize = flashconfig_tbl[index].sector_size;
+	mtd->writesize = 1;
+	mtd->numeraseregions = 0;
+	mtd->eraseregions = NULL;
+	mtd->_erase = spiflash_erase;
+	mtd->_read = spiflash_read;
+	mtd->_write = spiflash_write;
+	mtd->owner = THIS_MODULE;
+
+	dev_info(&pdev->dev, "%lld Kbytes flash detected\n", mtd->size >> 10);
+
+#if defined CONFIG_MTD_REDBOOT_PARTS || CONFIG_MTD_MYLOADER_PARTS
+	/* parse redboot partitions */
+
+	result = mtd_device_parse_register(mtd, part_probe_types,
+					   NULL, NULL, 0);
+#endif
+
+	return result;
+}
+
+static int
+spiflash_remove(struct platform_device *pdev)
+{
+	struct spiflash_priv *priv = platform_get_drvdata(pdev);
+
+	mtd_device_unregister(&priv->mtd);
+
+	return 0;
+}
+
+static struct platform_driver spiflash_driver = {
+	.driver.name = DRIVER_NAME,
+	.probe = spiflash_probe,
+	.remove = spiflash_remove,
+};
+
+module_platform_driver(spiflash_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("OpenWrt.org");
+MODULE_AUTHOR("Atheros Communications Inc");
+MODULE_DESCRIPTION("MTD driver for SPI Flash on Atheros AR2315+ SOC");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+
diff --git a/drivers/mtd/devices/ar2315_spiflash.h b/drivers/mtd/devices/ar2315_spiflash.h
new file mode 100644
index 0000000..17b0903
--- /dev/null
+++ b/drivers/mtd/devices/ar2315_spiflash.h
@@ -0,0 +1,106 @@
+/*
+ * Atheros AR2315 SPI Flash Memory support header file.
+ *
+ * Copyright (c) 2005, Atheros Communications Inc.
+ * Copyright (C) 2006 FON Technology, SL.
+ * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef __AR2315_SPIFLASH_H
+#define __AR2315_SPIFLASH_H
+
+#define STM_PAGE_SIZE           256
+
+#define SFI_WRITE_BUFFER_SIZE   4
+#define SFI_FLASH_ADDR_MASK     0x00ffffff
+
+#define STM_8MBIT_SIGNATURE     0x13
+#define STM_M25P80_BYTE_COUNT   1048576
+#define STM_M25P80_SECTOR_COUNT 16
+#define STM_M25P80_SECTOR_SIZE  0x10000
+
+#define STM_16MBIT_SIGNATURE    0x14
+#define STM_M25P16_BYTE_COUNT   2097152
+#define STM_M25P16_SECTOR_COUNT 32
+#define STM_M25P16_SECTOR_SIZE  0x10000
+
+#define STM_32MBIT_SIGNATURE    0x15
+#define STM_M25P32_BYTE_COUNT   4194304
+#define STM_M25P32_SECTOR_COUNT 64
+#define STM_M25P32_SECTOR_SIZE  0x10000
+
+#define STM_64MBIT_SIGNATURE    0x16
+#define STM_M25P64_BYTE_COUNT   8388608
+#define STM_M25P64_SECTOR_COUNT 128
+#define STM_M25P64_SECTOR_SIZE  0x10000
+
+#define STM_128MBIT_SIGNATURE   0x17
+#define STM_M25P128_BYTE_COUNT   16777216
+#define STM_M25P128_SECTOR_COUNT 256
+#define STM_M25P128_SECTOR_SIZE  0x10000
+
+#define STM_1MB_BYTE_COUNT   STM_M25P80_BYTE_COUNT
+#define STM_1MB_SECTOR_COUNT STM_M25P80_SECTOR_COUNT
+#define STM_1MB_SECTOR_SIZE  STM_M25P80_SECTOR_SIZE
+#define STM_2MB_BYTE_COUNT   STM_M25P16_BYTE_COUNT
+#define STM_2MB_SECTOR_COUNT STM_M25P16_SECTOR_COUNT
+#define STM_2MB_SECTOR_SIZE  STM_M25P16_SECTOR_SIZE
+#define STM_4MB_BYTE_COUNT   STM_M25P32_BYTE_COUNT
+#define STM_4MB_SECTOR_COUNT STM_M25P32_SECTOR_COUNT
+#define STM_4MB_SECTOR_SIZE  STM_M25P32_SECTOR_SIZE
+#define STM_8MB_BYTE_COUNT   STM_M25P64_BYTE_COUNT
+#define STM_8MB_SECTOR_COUNT STM_M25P64_SECTOR_COUNT
+#define STM_8MB_SECTOR_SIZE  STM_M25P64_SECTOR_SIZE
+#define STM_16MB_BYTE_COUNT   STM_M25P128_BYTE_COUNT
+#define STM_16MB_SECTOR_COUNT STM_M25P128_SECTOR_COUNT
+#define STM_16MB_SECTOR_SIZE  STM_M25P128_SECTOR_SIZE
+
+/*
+ * ST Microelectronics Opcodes for Serial Flash
+ */
+
+#define STM_OP_WR_ENABLE       0x06     /* Write Enable */
+#define STM_OP_WR_DISABLE      0x04     /* Write Disable */
+#define STM_OP_RD_STATUS       0x05     /* Read Status */
+#define STM_OP_WR_STATUS       0x01     /* Write Status */
+#define STM_OP_RD_DATA         0x03     /* Read Data */
+#define STM_OP_FAST_RD_DATA    0x0b     /* Fast Read Data */
+#define STM_OP_PAGE_PGRM       0x02     /* Page Program */
+#define STM_OP_SECTOR_ERASE    0xd8     /* Sector Erase */
+#define STM_OP_BULK_ERASE      0xc7     /* Bulk Erase */
+#define STM_OP_DEEP_PWRDOWN    0xb9     /* Deep Power-Down Mode */
+#define STM_OP_RD_SIG          0xab     /* Read Electronic Signature */
+
+#define STM_STATUS_WIP       0x01       /* Write-In-Progress */
+#define STM_STATUS_WEL       0x02       /* Write Enable Latch */
+#define STM_STATUS_BP0       0x04       /* Block Protect 0 */
+#define STM_STATUS_BP1       0x08       /* Block Protect 1 */
+#define STM_STATUS_BP2       0x10       /* Block Protect 2 */
+#define STM_STATUS_SRWD      0x80       /* Status Register Write Disable */
+
+/*
+ * SPI Flash Interface Registers
+ */
+
+#define SPI_FLASH_CTL           0x00
+#define SPI_FLASH_OPCODE        0x04
+#define SPI_FLASH_DATA          0x08
+
+#define SPI_CTL_START           0x00000100
+#define SPI_CTL_BUSY            0x00010000
+#define SPI_CTL_TXCNT_MASK      0x0000000f
+#define SPI_CTL_RXCNT_MASK      0x000000f0
+#define SPI_CTL_TX_RX_CNT_MASK  0x000000ff
+#define SPI_CTL_SIZE_MASK       0x00060000
+
+#define SPI_CTL_CLK_SEL_MASK    0x03000000
+#define SPI_OPCODE_MASK         0x000000ff
+
+#define SPI_STATUS_WIP		STM_STATUS_WIP
+
+#endif
-- 
1.8.5.5
