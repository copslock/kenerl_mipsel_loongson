Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 20:46:08 +0100 (CET)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:54363 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013278AbaKKTqGN7Xdh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 20:46:06 +0100
Received: by mail-wg0-f45.google.com with SMTP id x12so12417104wgg.32
        for <multiple recipients>; Tue, 11 Nov 2014 11:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=FNv0BAYGm4diGKViK4L2qxzsczqBJ9ZuXoNLV3rfDzs=;
        b=umfuKD+9jlxxke4OZhV19DcM370x/8cAK4JIU0lhxdFVom7Sp5z487J3LmdvBQbnO6
         rroofDL5LWEexCtCoGEoqlna1xwBvQTX1PtjM0wVe+FL1uxVxSKuG3+qhVbNI4U6HldG
         MWECLAYc3+cwUsY0gtmTu3MFsk1z66iJ7RHtFBkLisLc4Gt9d1VPdVlx3iXyNjstLsBl
         2qUs7Vvp32qpsCCB1ZLzVfweH3D9TPvPoR1heUcs3kwfE9h5kQMGrmZCV7ZuhD6/kVTO
         LZRqHI2UmIm2syMjHPP5wofUGhEJNGn/jbcOHbTmTGSzHd0BMnNmr7IPZFV1TAl36vcn
         nzsg==
X-Received: by 10.194.172.234 with SMTP id bf10mr57410524wjc.81.1415735160956;
        Tue, 11 Nov 2014 11:46:00 -0800 (PST)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id u8sm28580232wjq.1.2014.11.11.11.45.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2014 11:46:00 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Move NVRAM driver to the drivers/misc/
Date:   Tue, 11 Nov 2014 20:45:46 +0100
Message-Id: <1415735146-31552-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

After Broadcom switched from MIPS to ARM for their home routers we need
to have NVRAM driver in some common place (not arch/mips/).
We were thinking about putting it in bus directory, however there are
two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
won't fit there neither.
This is why I would like to move this driver to the drivers/misc/

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/Kconfig                                  |   1 +
 arch/mips/bcm47xx/Makefile                         |   2 +-
 arch/mips/bcm47xx/board.c                          |   2 +-
 arch/mips/bcm47xx/nvram.c                          | 228 --------------------
 arch/mips/bcm47xx/setup.c                          |   1 -
 arch/mips/bcm47xx/sprom.c                          |   1 -
 arch/mips/bcm47xx/time.c                           |   1 -
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h       |   1 +
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h |  21 --
 drivers/bcma/driver_mips.c                         |   2 +-
 drivers/misc/Kconfig                               |   9 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/bcm47xx_nvram.c                       | 230 +++++++++++++++++++++
 drivers/net/ethernet/broadcom/b44.c                |   2 +-
 drivers/net/ethernet/broadcom/bgmac.c              |   2 +-
 drivers/ssb/driver_chipcommon_pmu.c                |   2 +-
 drivers/ssb/driver_mipscore.c                      |   2 +-
 include/linux/bcm47xx_nvram.h                      |  18 ++
 18 files changed, 267 insertions(+), 259 deletions(-)
 delete mode 100644 arch/mips/bcm47xx/nvram.c
 delete mode 100644 arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
 create mode 100644 drivers/misc/bcm47xx_nvram.c
 create mode 100644 include/linux/bcm47xx_nvram.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4a7e0c1..3d647e3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -134,6 +134,7 @@ config BCM47XX
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select GPIOLIB
 	select LEDS_GPIO_REGISTER
+	select BCM47XX_NVRAM
 	help
 	 Support for BCM47XX based boards
 
diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index d58c51b..66bea4e 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -3,5 +3,5 @@
 # under Linux.
 #
 
-obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
+obj-y				+= irq.o prom.o serial.o setup.o time.o sprom.o
 obj-y				+= board.o buttons.o leds.o workarounds.o
diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index b3ae068..6e85130 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -1,8 +1,8 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/string.h>
+#include <bcm47xx.h>
 #include <bcm47xx_board.h>
-#include <bcm47xx_nvram.h>
 
 struct bcm47xx_board_type {
 	const enum bcm47xx_board board;
diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
deleted file mode 100644
index c5c381c..0000000
--- a/arch/mips/bcm47xx/nvram.c
+++ /dev/null
@@ -1,228 +0,0 @@
-/*
- * BCM947xx nvram variable access
- *
- * Copyright (C) 2005 Broadcom Corporation
- * Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
- * Copyright (C) 2010-2012 Hauke Mehrtens <hauke@hauke-m.de>
- *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/mtd/mtd.h>
-#include <bcm47xx_nvram.h>
-
-#define NVRAM_MAGIC		0x48534C46	/* 'FLSH' */
-#define NVRAM_SPACE		0x8000
-
-#define FLASH_MIN		0x00020000	/* Minimum flash size */
-
-struct nvram_header {
-	u32 magic;
-	u32 len;
-	u32 crc_ver_init;	/* 0:7 crc, 8:15 ver, 16:31 sdram_init */
-	u32 config_refresh;	/* 0:15 sdram_config, 16:31 sdram_refresh */
-	u32 config_ncdl;	/* ncdl values for memc */
-};
-
-static char nvram_buf[NVRAM_SPACE];
-static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
-
-static u32 find_nvram_size(void __iomem *end)
-{
-	struct nvram_header __iomem *header;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
-		header = (struct nvram_header *)(end - nvram_sizes[i]);
-		if (header->magic == NVRAM_MAGIC)
-			return nvram_sizes[i];
-	}
-
-	return 0;
-}
-
-/* Probe for NVRAM header */
-static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
-{
-	struct nvram_header __iomem *header;
-	int i;
-	u32 off;
-	u32 *src, *dst;
-	u32 size;
-
-	if (nvram_buf[0]) {
-		pr_warn("nvram already initialized\n");
-		return -EEXIST;
-	}
-
-	/* TODO: when nvram is on nand flash check for bad blocks first. */
-	off = FLASH_MIN;
-	while (off <= lim) {
-		/* Windowed flash access */
-		size = find_nvram_size(iobase + off);
-		if (size) {
-			header = (struct nvram_header *)(iobase + off - size);
-			goto found;
-		}
-		off <<= 1;
-	}
-
-	/* Try embedded NVRAM at 4 KB and 1 KB as last resorts */
-	header = (struct nvram_header *)(iobase + 4096);
-	if (header->magic == NVRAM_MAGIC) {
-		size = NVRAM_SPACE;
-		goto found;
-	}
-
-	header = (struct nvram_header *)(iobase + 1024);
-	if (header->magic == NVRAM_MAGIC) {
-		size = NVRAM_SPACE;
-		goto found;
-	}
-
-	pr_err("no nvram found\n");
-	return -ENXIO;
-
-found:
-
-	if (header->len > size)
-		pr_err("The nvram size accoridng to the header seems to be bigger than the partition on flash\n");
-	if (header->len > NVRAM_SPACE)
-		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
-		       header->len, NVRAM_SPACE);
-
-	src = (u32 *) header;
-	dst = (u32 *) nvram_buf;
-	for (i = 0; i < sizeof(struct nvram_header); i += 4)
-		*dst++ = *src++;
-	for (; i < header->len && i < NVRAM_SPACE && i < size; i += 4)
-		*dst++ = le32_to_cpu(*src++);
-	memset(dst, 0x0, NVRAM_SPACE - i);
-
-	return 0;
-}
-
-/*
- * On bcm47xx we need access to the NVRAM very early, so we can't use mtd
- * subsystem to access flash. We can't even use platform device / driver to
- * store memory offset.
- * To handle this we provide following symbol. It's supposed to be called as
- * soon as we get info about flash device, before any NVRAM entry is needed.
- */
-int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
-{
-	void __iomem *iobase;
-	int err;
-
-	iobase = ioremap_nocache(base, lim);
-	if (!iobase)
-		return -ENOMEM;
-
-	err = nvram_find_and_copy(iobase, lim);
-
-	iounmap(iobase);
-
-	return err;
-}
-
-static int nvram_init(void)
-{
-#ifdef CONFIG_MTD
-	struct mtd_info *mtd;
-	struct nvram_header header;
-	size_t bytes_read;
-	int err, i;
-
-	mtd = get_mtd_device_nm("nvram");
-	if (IS_ERR(mtd))
-		return -ENODEV;
-
-	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
-		loff_t from = mtd->size - nvram_sizes[i];
-
-		if (from < 0)
-			continue;
-
-		err = mtd_read(mtd, from, sizeof(header), &bytes_read,
-			       (uint8_t *)&header);
-		if (!err && header.magic == NVRAM_MAGIC) {
-			u8 *dst = (uint8_t *)nvram_buf;
-			size_t len = header.len;
-
-			if (header.len > NVRAM_SPACE) {
-				pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
-				       header.len, NVRAM_SPACE);
-				len = NVRAM_SPACE;
-			}
-
-			err = mtd_read(mtd, from, len, &bytes_read, dst);
-			if (err)
-				return err;
-			memset(dst + bytes_read, 0x0, NVRAM_SPACE - bytes_read);
-
-			return 0;
-		}
-	}
-#endif
-
-	return -ENXIO;
-}
-
-int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
-{
-	char *var, *value, *end, *eq;
-	int err;
-
-	if (!name)
-		return -EINVAL;
-
-	if (!nvram_buf[0]) {
-		err = nvram_init();
-		if (err)
-			return err;
-	}
-
-	/* Look for name=value and return value */
-	var = &nvram_buf[sizeof(struct nvram_header)];
-	end = nvram_buf + sizeof(nvram_buf) - 2;
-	end[0] = end[1] = '\0';
-	for (; *var; var = value + strlen(value) + 1) {
-		eq = strchr(var, '=');
-		if (!eq)
-			break;
-		value = eq + 1;
-		if ((eq - var) == strlen(name) &&
-			strncmp(var, name, (eq - var)) == 0) {
-			return snprintf(val, val_len, "%s", value);
-		}
-	}
-	return -ENOENT;
-}
-EXPORT_SYMBOL(bcm47xx_nvram_getenv);
-
-int bcm47xx_nvram_gpio_pin(const char *name)
-{
-	int i, err;
-	char nvram_var[10];
-	char buf[30];
-
-	for (i = 0; i < 32; i++) {
-		err = snprintf(nvram_var, sizeof(nvram_var), "gpio%i", i);
-		if (err <= 0)
-			continue;
-		err = bcm47xx_nvram_getenv(nvram_var, buf, sizeof(buf));
-		if (err <= 0)
-			continue;
-		if (!strcmp(name, buf))
-			return i;
-	}
-	return -ENOENT;
-}
-EXPORT_SYMBOL(bcm47xx_nvram_gpio_pin);
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index e43b504..b26c9c2 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -42,7 +42,6 @@
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <bcm47xx.h>
-#include <bcm47xx_nvram.h>
 #include <bcm47xx_board.h>
 
 union bcm47xx_bus bcm47xx_bus;
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 2eff7fe..a077ed2 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -27,7 +27,6 @@
  */
 
 #include <bcm47xx.h>
-#include <bcm47xx_nvram.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
 
diff --git a/arch/mips/bcm47xx/time.c b/arch/mips/bcm47xx/time.c
index 2c85d92..5b46510 100644
--- a/arch/mips/bcm47xx/time.c
+++ b/arch/mips/bcm47xx/time.c
@@ -27,7 +27,6 @@
 #include <linux/ssb/ssb.h>
 #include <asm/time.h>
 #include <bcm47xx.h>
-#include <bcm47xx_nvram.h>
 #include <bcm47xx_board.h>
 
 void __init plat_time_init(void)
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
index 7527c1d..8ed77f6 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
@@ -22,6 +22,7 @@
 #include <linux/ssb/ssb.h>
 #include <linux/bcma/bcma.h>
 #include <linux/bcma/bcma_soc.h>
+#include <linux/bcm47xx_nvram.h>
 
 enum bcm47xx_bus_type {
 #ifdef CONFIG_BCM47XX_SSB
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
deleted file mode 100644
index ee59ffe..0000000
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  Copyright (C) 2005, Broadcom Corporation
- *  Copyright (C) 2006, Felix Fietkau <nbd@openwrt.org>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#ifndef __BCM47XX_NVRAM_H
-#define __BCM47XX_NVRAM_H
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-
-int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
-int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
-int bcm47xx_nvram_gpio_pin(const char *name);
-
-#endif /* __BCM47XX_NVRAM_H */
diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
index 8a653dc..15e278f 100644
--- a/drivers/bcma/driver_mips.c
+++ b/drivers/bcma/driver_mips.c
@@ -21,7 +21,7 @@
 #include <linux/serial_reg.h>
 #include <linux/time.h>
 #ifdef CONFIG_BCM47XX
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 #endif
 
 enum bcma_boot_dev {
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index bbeb451..e8af594 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -84,6 +84,15 @@ config ATMEL_TCB_CLKSRC_BLOCK
 	  TC can be used for other purposes, such as PWM generation and
 	  interval timing.
 
+config BCM47XX_NVRAM
+	bool "Broadcom NVRAM driver"
+	depends on BCM47XX || ARCH_BCM_5301X
+	help
+	  Broadcom home routers contain flash partition called "nvram" with all
+	  important hardware configuration as well as some minor user setup.
+	  It contains a text-like data representing name=value pairs.
+	  This driver provides an easy way to get value of requested parameter.
+
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	default n
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 7d5c4cd..611cb7a 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_AD525X_DPOT_SPI)	+= ad525x_dpot-spi.o
 obj-$(CONFIG_INTEL_MID_PTI)	+= pti.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
+obj-$(CONFIG_BCM47XX_NVRAM)	+= bcm47xx_nvram.o
 obj-$(CONFIG_BMP085)		+= bmp085.o
 obj-$(CONFIG_BMP085_I2C)	+= bmp085-i2c.o
 obj-$(CONFIG_BMP085_SPI)	+= bmp085-spi.o
diff --git a/drivers/misc/bcm47xx_nvram.c b/drivers/misc/bcm47xx_nvram.c
new file mode 100644
index 0000000..a4083d7
--- /dev/null
+++ b/drivers/misc/bcm47xx_nvram.c
@@ -0,0 +1,230 @@
+/*
+ * BCM947xx nvram variable access
+ *
+ * Copyright (C) 2005 Broadcom Corporation
+ * Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
+ * Copyright (C) 2010-2012 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/mtd/mtd.h>
+#include <linux/bcm47xx_nvram.h>
+
+#define NVRAM_MAGIC		0x48534C46	/* 'FLSH' */
+#define NVRAM_SPACE		0x8000
+
+#define FLASH_MIN		0x00020000	/* Minimum flash size */
+
+struct nvram_header {
+	u32 magic;
+	u32 len;
+	u32 crc_ver_init;	/* 0:7 crc, 8:15 ver, 16:31 sdram_init */
+	u32 config_refresh;	/* 0:15 sdram_config, 16:31 sdram_refresh */
+	u32 config_ncdl;	/* ncdl values for memc */
+};
+
+static char nvram_buf[NVRAM_SPACE];
+static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
+
+static u32 find_nvram_size(void __iomem *end)
+{
+	struct nvram_header __iomem *header;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
+		header = (struct nvram_header *)(end - nvram_sizes[i]);
+		if (header->magic == NVRAM_MAGIC)
+			return nvram_sizes[i];
+	}
+
+	return 0;
+}
+
+/* Probe for NVRAM header */
+static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
+{
+	struct nvram_header __iomem *header;
+	int i;
+	u32 off;
+	u32 *src, *dst;
+	u32 size;
+
+	if (nvram_buf[0]) {
+		pr_warn("nvram already initialized\n");
+		return -EEXIST;
+	}
+
+	/* TODO: when nvram is on nand flash check for bad blocks first. */
+	off = FLASH_MIN;
+	while (off <= lim) {
+		/* Windowed flash access */
+		size = find_nvram_size(iobase + off);
+		if (size) {
+			header = (struct nvram_header *)(iobase + off - size);
+			goto found;
+		}
+		off <<= 1;
+	}
+
+	/* Try embedded NVRAM at 4 KB and 1 KB as last resorts */
+	header = (struct nvram_header *)(iobase + 4096);
+	if (header->magic == NVRAM_MAGIC) {
+		size = NVRAM_SPACE;
+		goto found;
+	}
+
+	header = (struct nvram_header *)(iobase + 1024);
+	if (header->magic == NVRAM_MAGIC) {
+		size = NVRAM_SPACE;
+		goto found;
+	}
+
+	pr_err("no nvram found\n");
+	return -ENXIO;
+
+found:
+
+	if (header->len > size)
+		pr_err("The nvram size accoridng to the header seems to be bigger than the partition on flash\n");
+	if (header->len > NVRAM_SPACE)
+		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
+		       header->len, NVRAM_SPACE);
+
+	src = (u32 *) header;
+	dst = (u32 *) nvram_buf;
+	for (i = 0; i < sizeof(struct nvram_header); i += 4)
+		*dst++ = *src++;
+	for (; i < header->len && i < NVRAM_SPACE && i < size; i += 4)
+		*dst++ = le32_to_cpu(*src++);
+	memset(dst, 0x0, NVRAM_SPACE - i);
+
+	return 0;
+}
+
+/*
+ * On bcm47xx we need access to the NVRAM very early, so we can't use mtd
+ * subsystem to access flash. We can't even use platform device / driver to
+ * store memory offset.
+ * To handle this we provide following symbol. It's supposed to be called as
+ * soon as we get info about flash device, before any NVRAM entry is needed.
+ */
+int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
+{
+	void __iomem *iobase;
+	int err;
+
+	iobase = ioremap_nocache(base, lim);
+	if (!iobase)
+		return -ENOMEM;
+
+	err = nvram_find_and_copy(iobase, lim);
+
+	iounmap(iobase);
+
+	return err;
+}
+
+static int nvram_init(void)
+{
+#ifdef CONFIG_MTD
+	struct mtd_info *mtd;
+	struct nvram_header header;
+	size_t bytes_read;
+	int err, i;
+
+	mtd = get_mtd_device_nm("nvram");
+	if (IS_ERR(mtd))
+		return -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
+		loff_t from = mtd->size - nvram_sizes[i];
+
+		if (from < 0)
+			continue;
+
+		err = mtd_read(mtd, from, sizeof(header), &bytes_read,
+			       (uint8_t *)&header);
+		if (!err && header.magic == NVRAM_MAGIC) {
+			u8 *dst = (uint8_t *)nvram_buf;
+			size_t len = header.len;
+
+			if (header.len > NVRAM_SPACE) {
+				pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
+				       header.len, NVRAM_SPACE);
+				len = NVRAM_SPACE;
+			}
+
+			err = mtd_read(mtd, from, len, &bytes_read, dst);
+			if (err)
+				return err;
+			memset(dst + bytes_read, 0x0, NVRAM_SPACE - bytes_read);
+
+			return 0;
+		}
+	}
+#endif
+
+	return -ENXIO;
+}
+
+int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
+{
+	char *var, *value, *end, *eq;
+	int err;
+
+	if (!name)
+		return -EINVAL;
+
+	if (!nvram_buf[0]) {
+		err = nvram_init();
+		if (err)
+			return err;
+	}
+
+	/* Look for name=value and return value */
+	var = &nvram_buf[sizeof(struct nvram_header)];
+	end = nvram_buf + sizeof(nvram_buf) - 2;
+	end[0] = end[1] = '\0';
+	for (; *var; var = value + strlen(value) + 1) {
+		eq = strchr(var, '=');
+		if (!eq)
+			break;
+		value = eq + 1;
+		if ((eq - var) == strlen(name) &&
+			strncmp(var, name, (eq - var)) == 0) {
+			return snprintf(val, val_len, "%s", value);
+		}
+	}
+	return -ENOENT;
+}
+EXPORT_SYMBOL(bcm47xx_nvram_getenv);
+
+int bcm47xx_nvram_gpio_pin(const char *name)
+{
+	int i, err;
+	char nvram_var[10];
+	char buf[30];
+
+	for (i = 0; i < 32; i++) {
+		err = snprintf(nvram_var, sizeof(nvram_var), "gpio%i", i);
+		if (err <= 0)
+			continue;
+		err = bcm47xx_nvram_getenv(nvram_var, buf, sizeof(buf));
+		if (err <= 0)
+			continue;
+		if (!strcmp(name, buf))
+			return i;
+	}
+	return -ENOENT;
+}
+EXPORT_SYMBOL(bcm47xx_nvram_gpio_pin);
+
+MODULE_LICENSE("GPLv2");
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 416620f..2095062 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -400,7 +400,7 @@ static void b44_set_flow_ctrl(struct b44 *bp, u32 local, u32 remote)
 }
 
 #ifdef CONFIG_BCM47XX
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 static void b44_wap54g10_workaround(struct b44 *bp)
 {
 	char buf[20];
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 05c6af6..bdda57b 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -16,7 +16,7 @@
 #include <linux/phy.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 
 static const struct bcma_device_id bgmac_bcma_tbl[] = {
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_4706_MAC_GBIT, BCMA_ANY_REV, BCMA_ANY_CLASS),
diff --git a/drivers/ssb/driver_chipcommon_pmu.c b/drivers/ssb/driver_chipcommon_pmu.c
index 1173a09..0942841 100644
--- a/drivers/ssb/driver_chipcommon_pmu.c
+++ b/drivers/ssb/driver_chipcommon_pmu.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #ifdef CONFIG_BCM47XX
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 #endif
 
 #include "ssb_private.h"
diff --git a/drivers/ssb/driver_mipscore.c b/drivers/ssb/driver_mipscore.c
index 7b986f9..f87efef 100644
--- a/drivers/ssb/driver_mipscore.c
+++ b/drivers/ssb/driver_mipscore.c
@@ -16,7 +16,7 @@
 #include <linux/serial_reg.h>
 #include <linux/time.h>
 #ifdef CONFIG_BCM47XX
-#include <bcm47xx_nvram.h>
+#include <linux/bcm47xx_nvram.h>
 #endif
 
 #include "ssb_private.h"
diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
new file mode 100644
index 0000000..5ed6917
--- /dev/null
+++ b/include/linux/bcm47xx_nvram.h
@@ -0,0 +1,18 @@
+/*
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef __BCM47XX_NVRAM_H
+#define __BCM47XX_NVRAM_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
+int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
+int bcm47xx_nvram_gpio_pin(const char *name);
+
+#endif /* __BCM47XX_NVRAM_H */
-- 
1.8.4.5
