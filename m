Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 03:04:39 +0200 (CEST)
Received: from test.hauke-m.de ([5.39.93.123]:41407 "EHLO test.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006622AbaHYBDBm4lsW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 03:03:01 +0200
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by test.hauke-m.de (Postfix) with ESMTPSA id 2427F2095D;
        Sun, 24 Aug 2014 23:25:19 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
Cc:     zajec5@gmail.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 2/7] bcm47xx-nvram: add new broadcom nvram driver with dt support
Date:   Sun, 24 Aug 2014 23:24:40 +0200
Message-Id: <1408915485-8078-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This adds a new driver which searches at a given memory range for a
nvram like it is used on the bcm47xx and bcm53xx SoCs with ARM and MIPS
CPUs. This driver provides acces to this nvram to other device in the
device tree. You have to specify the memory ranges where the content of
the flash chip is memory mapped and this driver will search there for
some nvram and parse it. Other drivers can use this driver to access the
device nvram. The nvram is used to store board configurations like the
mac addresses, the switch configuration and the calibration data for
the wifi devices.

This was copied from arch/mips/bcm47xx/nvram.c and modified to interact
with device tree. My plan is to make the MIPS bcm47xx also use this new
driver some time later.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../devicetree/bindings/misc/bcm47xx-nvram.txt     |  19 ++
 arch/mips/bcm47xx/board.c                          |  40 ++--
 arch/mips/bcm47xx/nvram.c                          |   7 +-
 arch/mips/bcm47xx/setup.c                          |   4 +-
 arch/mips/bcm47xx/sprom.c                          |   4 +-
 arch/mips/bcm47xx/time.c                           |   2 +-
 drivers/misc/Kconfig                               |  13 ++
 drivers/misc/Makefile                              |   1 +
 drivers/misc/bcm47xx-nvram.c                       | 215 +++++++++++++++++++++
 drivers/net/ethernet/broadcom/b44.c                |   2 +-
 drivers/net/ethernet/broadcom/bgmac.c              |   5 +-
 drivers/ssb/driver_chipcommon_pmu.c                |   3 +-
 include/linux/bcm47xx_nvram.h                      |  17 +-
 13 files changed, 294 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/bcm47xx-nvram.txt
 create mode 100644 drivers/misc/bcm47xx-nvram.c

diff --git a/Documentation/devicetree/bindings/misc/bcm47xx-nvram.txt b/Documentation/devicetree/bindings/misc/bcm47xx-nvram.txt
new file mode 100644
index 0000000..ed979a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/bcm47xx-nvram.txt
@@ -0,0 +1,19 @@
+Broadcom bcm47xx/bcm53xx nvram access driver
+
+This driver provides access to the nvram for other drivers.
+
+Required properties:
+
+- compatible : brcm,bcm47xx-nvram
+
+- reg : iomem address range
+
+On NorthStar ARM SoCs the NAND flash is available at 0x1c000000 and the
+NOR flash is at 0x1e000000
+
+Example:
+
+nvram0: nvram@0 {
+	compatible = "brcm,bcm47xx-nvram";
+	reg = <0x1c000000 0x01000000>;
+};
diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index ec46fd7..2c98f74 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -218,36 +218,36 @@ static __init const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 	const struct bcm47xx_board_type_list2 *e2;
 	const struct bcm47xx_board_type_list3 *e3;
 
-	if (bcm47xx_nvram_getenv("model_name", buf1, sizeof(buf1)) >= 0) {
+	if (bcm47xx_nvram_getenv(NULL, "model_name", buf1, sizeof(buf1)) >= 0) {
 		for (e1 = bcm47xx_board_list_model_name; e1->value1; e1++) {
 			if (!strcmp(buf1, e1->value1))
 				return &e1->board;
 		}
 	}
 
-	if (bcm47xx_nvram_getenv("model_no", buf1, sizeof(buf1)) >= 0) {
+	if (bcm47xx_nvram_getenv(NULL, "model_no", buf1, sizeof(buf1)) >= 0) {
 		for (e1 = bcm47xx_board_list_model_no; e1->value1; e1++) {
 			if (strstarts(buf1, e1->value1))
 				return &e1->board;
 		}
 	}
 
-	if (bcm47xx_nvram_getenv("machine_name", buf1, sizeof(buf1)) >= 0) {
+	if (bcm47xx_nvram_getenv(NULL, "machine_name", buf1, sizeof(buf1)) >= 0) {
 		for (e1 = bcm47xx_board_list_machine_name; e1->value1; e1++) {
 			if (strstarts(buf1, e1->value1))
 				return &e1->board;
 		}
 	}
 
-	if (bcm47xx_nvram_getenv("hardware_version", buf1, sizeof(buf1)) >= 0) {
+	if (bcm47xx_nvram_getenv(NULL, "hardware_version", buf1, sizeof(buf1)) >= 0) {
 		for (e1 = bcm47xx_board_list_hardware_version; e1->value1; e1++) {
 			if (strstarts(buf1, e1->value1))
 				return &e1->board;
 		}
 	}
 
-	if (bcm47xx_nvram_getenv("hardware_version", buf1, sizeof(buf1)) >= 0 &&
-	    bcm47xx_nvram_getenv("boardtype", buf2, sizeof(buf2)) >= 0) {
+	if (bcm47xx_nvram_getenv(NULL, "hardware_version", buf1, sizeof(buf1)) >= 0 &&
+	    bcm47xx_nvram_getenv(NULL, "boardtype", buf2, sizeof(buf2)) >= 0) {
 		for (e2 = bcm47xx_board_list_boot_hw; e2->value1; e2++) {
 			if (!strstarts(buf1, e2->value1) &&
 			    !strcmp(buf2, e2->value2))
@@ -255,22 +255,22 @@ static __init const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 		}
 	}
 
-	if (bcm47xx_nvram_getenv("productid", buf1, sizeof(buf1)) >= 0) {
+	if (bcm47xx_nvram_getenv(NULL, "productid", buf1, sizeof(buf1)) >= 0) {
 		for (e1 = bcm47xx_board_list_productid; e1->value1; e1++) {
 			if (!strcmp(buf1, e1->value1))
 				return &e1->board;
 		}
 	}
 
-	if (bcm47xx_nvram_getenv("ModelId", buf1, sizeof(buf1)) >= 0) {
+	if (bcm47xx_nvram_getenv(NULL, "ModelId", buf1, sizeof(buf1)) >= 0) {
 		for (e1 = bcm47xx_board_list_ModelId; e1->value1; e1++) {
 			if (!strcmp(buf1, e1->value1))
 				return &e1->board;
 		}
 	}
 
-	if (bcm47xx_nvram_getenv("melco_id", buf1, sizeof(buf1)) >= 0 ||
-	    bcm47xx_nvram_getenv("buf1falo_id", buf1, sizeof(buf1)) >= 0) {
+	if (bcm47xx_nvram_getenv(NULL, "melco_id", buf1, sizeof(buf1)) >= 0 ||
+	    bcm47xx_nvram_getenv(NULL, "buf1falo_id", buf1, sizeof(buf1)) >= 0) {
 		/* buffalo hardware, check id for specific hardware matches */
 		for (e1 = bcm47xx_board_list_melco_id; e1->value1; e1++) {
 			if (!strcmp(buf1, e1->value1))
@@ -278,8 +278,8 @@ static __init const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 		}
 	}
 
-	if (bcm47xx_nvram_getenv("boot_hw_model", buf1, sizeof(buf1)) >= 0 &&
-	    bcm47xx_nvram_getenv("boot_hw_ver", buf2, sizeof(buf2)) >= 0) {
+	if (bcm47xx_nvram_getenv(NULL, "boot_hw_model", buf1, sizeof(buf1)) >= 0 &&
+	    bcm47xx_nvram_getenv(NULL, "boot_hw_ver", buf2, sizeof(buf2)) >= 0) {
 		for (e2 = bcm47xx_board_list_boot_hw; e2->value1; e2++) {
 			if (!strcmp(buf1, e2->value1) &&
 			    !strcmp(buf2, e2->value2))
@@ -287,16 +287,16 @@ static __init const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 		}
 	}
 
-	if (bcm47xx_nvram_getenv("board_id", buf1, sizeof(buf1)) >= 0) {
+	if (bcm47xx_nvram_getenv(NULL, "board_id", buf1, sizeof(buf1)) >= 0) {
 		for (e1 = bcm47xx_board_list_board_id; e1->value1; e1++) {
 			if (!strcmp(buf1, e1->value1))
 				return &e1->board;
 		}
 	}
 
-	if (bcm47xx_nvram_getenv("boardtype", buf1, sizeof(buf1)) >= 0 &&
-	    bcm47xx_nvram_getenv("boardnum", buf2, sizeof(buf2)) >= 0 &&
-	    bcm47xx_nvram_getenv("boardrev", buf3, sizeof(buf3)) >= 0) {
+	if (bcm47xx_nvram_getenv(NULL, "boardtype", buf1, sizeof(buf1)) >= 0 &&
+	    bcm47xx_nvram_getenv(NULL, "boardnum", buf2, sizeof(buf2)) >= 0 &&
+	    bcm47xx_nvram_getenv(NULL, "boardrev", buf3, sizeof(buf3)) >= 0) {
 		for (e3 = bcm47xx_board_list_board; e3->value1; e3++) {
 			if (!strcmp(buf1, e3->value1) &&
 			    !strcmp(buf2, e3->value2) &&
@@ -305,9 +305,9 @@ static __init const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 		}
 	}
 
-	if (bcm47xx_nvram_getenv("boardtype", buf1, sizeof(buf1)) >= 0 &&
-	    bcm47xx_nvram_getenv("boardrev", buf2, sizeof(buf2)) >= 0 &&
-	    bcm47xx_nvram_getenv("boardnum", buf3, sizeof(buf3)) ==  -ENOENT) {
+	if (bcm47xx_nvram_getenv(NULL, "boardtype", buf1, sizeof(buf1)) >= 0 &&
+	    bcm47xx_nvram_getenv(NULL, "boardrev", buf2, sizeof(buf2)) >= 0 &&
+	    bcm47xx_nvram_getenv(NULL, "boardnum", buf3, sizeof(buf3)) ==  -ENOENT) {
 		for (e2 = bcm47xx_board_list_board_type_rev; e2->value1; e2++) {
 			if (!strcmp(buf1, e2->value1) &&
 			    !strcmp(buf2, e2->value2))
@@ -327,7 +327,7 @@ void __init bcm47xx_board_detect(void)
 		return;
 
 	/* check if the nvram is available */
-	err = bcm47xx_nvram_getenv("boardtype", buf, sizeof(buf));
+	err = bcm47xx_nvram_getenv(NULL, "boardtype", buf, sizeof(buf));
 
 	/* init of nvram failed, probably too early now */
 	if (err == -ENXIO) {
diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index c47a4a8..b2112c7 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -158,7 +158,8 @@ static int nvram_init(void)
 	return -ENXIO;
 }
 
-int bcm47xx_nvram_getenv(char *name, char *val, size_t val_len)
+int bcm47xx_nvram_getenv(const struct device *dev, const char *name, char *val,
+			 size_t val_len)
 {
 	char *var, *value, *end, *eq;
 	int err;
@@ -190,7 +191,7 @@ int bcm47xx_nvram_getenv(char *name, char *val, size_t val_len)
 }
 EXPORT_SYMBOL(bcm47xx_nvram_getenv);
 
-int bcm47xx_nvram_gpio_pin(const char *name)
+int bcm47xx_nvram_gpio_pin(const struct device *dev, const char *name)
 {
 	int i, err;
 	char nvram_var[10];
@@ -200,7 +201,7 @@ int bcm47xx_nvram_gpio_pin(const char *name)
 		err = snprintf(nvram_var, sizeof(nvram_var), "gpio%i", i);
 		if (err <= 0)
 			continue;
-		err = bcm47xx_nvram_getenv(nvram_var, buf, sizeof(buf));
+		err = bcm47xx_nvram_getenv(dev, nvram_var, buf, sizeof(buf));
 		if (err <= 0)
 			continue;
 		if (!strcmp(name, buf))
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index deadb71..d87709d 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -123,7 +123,7 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 	memset(&iv->sprom, 0, sizeof(struct ssb_sprom));
 	bcm47xx_fill_sprom(&iv->sprom, NULL, false);
 
-	if (bcm47xx_nvram_getenv("cardbus", buf, sizeof(buf)) >= 0)
+	if (bcm47xx_nvram_getenv(NULL, "cardbus", buf, sizeof(buf)) >= 0)
 		iv->has_cardbus_slot = !!simple_strtoul(buf, NULL, 10);
 
 	return 0;
@@ -146,7 +146,7 @@ static void __init bcm47xx_register_ssb(void)
 		panic("Failed to initialize SSB bus (err %d)", err);
 
 	mcore = &bcm47xx_bus.ssb.mipscore;
-	if (bcm47xx_nvram_getenv("kernel_args", buf, sizeof(buf)) >= 0) {
+	if (bcm47xx_nvram_getenv(NULL, "kernel_args", buf, sizeof(buf)) >= 0) {
 		if (strstr(buf, "console=ttyS1")) {
 			struct ssb_serial_port port;
 
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 29ced12..f88f49b 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -52,10 +52,10 @@ static int get_nvram_var(const char *prefix, const char *postfix,
 
 	create_key(prefix, postfix, name, key, sizeof(key));
 
-	err = bcm47xx_nvram_getenv(key, buf, len);
+	err = bcm47xx_nvram_getenv(NULL, key, buf, len);
 	if (fallback && err == -ENOENT && prefix) {
 		create_key(NULL, postfix, name, key, sizeof(key));
-		err = bcm47xx_nvram_getenv(key, buf, len);
+		err = bcm47xx_nvram_getenv(NULL, key, buf, len);
 	}
 	return err;
 }
diff --git a/arch/mips/bcm47xx/time.c b/arch/mips/bcm47xx/time.c
index c57a515..b2c3c7d 100644
--- a/arch/mips/bcm47xx/time.c
+++ b/arch/mips/bcm47xx/time.c
@@ -61,7 +61,7 @@ void __init plat_time_init(void)
 	}
 
 	if (chip_id == 0x5354) {
-		len = bcm47xx_nvram_getenv("clkfreq", buf, sizeof(buf));
+		len = bcm47xx_nvram_getenv(NULL, "clkfreq", buf, sizeof(buf));
 		if (len >= 0 && !strncmp(buf, "200", 4))
 			hz = 100000000;
 	}
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b841180..b306c02 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -515,6 +515,19 @@ config VEXPRESS_SYSCFG
 	  bus. System Configuration interface is one of the possible means
 	  of generating transactions on this bus.
 
+config BCM47XX_NVRAM
+	tristate "BCM47XX nvram driver"
+	depends on OF
+	help
+	  This driver parses the nvram from a given memory range and
+	  provides its values to other drivers.
+
+	  The nvram is a key value store used on bcm47xx/bcm53xx SoC 
+	  with ARM and MIPS CPUs. It contains the board specific 
+	  configuration.
+
+	  If unsure, say N.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 5497d02..2331208 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -55,3 +55,4 @@ obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
+obj-$(CONFIG_BCM47XX_NVRAM)	+= bcm47xx-nvram.o
diff --git a/drivers/misc/bcm47xx-nvram.c b/drivers/misc/bcm47xx-nvram.c
new file mode 100644
index 0000000..6ea715c
--- /dev/null
+++ b/drivers/misc/bcm47xx-nvram.c
@@ -0,0 +1,215 @@
+/*
+ * BCM947xx nvram variable access
+ *
+ * Copyright (C) 2005 Broadcom Corporation
+ * Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
+ * Copyright (C) 2010-2014 Hauke Mehrtens <hauke@hauke-m.de>
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
+#include <linux/of_address.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/bcm47xx_nvram.h>
+
+struct bcm47xx_nvram {
+	size_t nvram_len;
+	char *nvram_buf;
+};
+
+static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
+
+static u32 find_nvram_size(void __iomem *end)
+{
+	struct nvram_header __iomem *header;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
+		header = (struct nvram_header __iomem *)(end - nvram_sizes[i]);
+		if (__raw_readl(&header->magic) == NVRAM_HEADER)
+			return nvram_sizes[i];
+	}
+
+	return 0;
+}
+
+/* Probe for NVRAM header */
+static int nvram_find_and_copy(struct device *dev, void __iomem *base,
+			       size_t len, char **nvram_buf,
+			       size_t *nvram_len)
+{
+	struct nvram_header __iomem *header;
+	int i;
+	u32 off;
+	u32 *dst;
+	__le32 __iomem *src;
+	u32 size;
+
+	/* TODO: when nvram is on nand flash check for bad blocks first. */
+	off = FLASH_MIN;
+	while (off <= len) {
+		/* Windowed flash access */
+		size = find_nvram_size(base + off);
+		if (size) {
+			header = (struct nvram_header __iomem *)
+					(base + off - size);
+			goto found;
+		}
+		off += 0x10000;
+	}
+
+	/* Try embedded NVRAM at 4 KB and 1 KB as last resorts */
+	header = (struct nvram_header __iomem *)(base + 4096);
+	if (__raw_readl(&header->magic) == NVRAM_HEADER) {
+		size = NVRAM_SPACE;
+		goto found;
+	}
+
+	header = (struct nvram_header __iomem *)(base + 1024);
+	if (__raw_readl(&header->magic) == NVRAM_HEADER) {
+		size = NVRAM_SPACE;
+		goto found;
+	}
+
+	*nvram_buf = NULL;
+	*nvram_len = 0;
+	pr_err("no nvram found\n");
+	return -ENXIO;
+
+found:
+	if (readl(&header->len) > size)
+		pr_err("The nvram size accoridng to the header seems to be bigger than the partition on flash\n");
+	*nvram_len = min_t(u32, readl(&header->len), size);
+
+	*nvram_buf = devm_kzalloc(dev, *nvram_len, GFP_KERNEL);
+	if (!*nvram_buf)
+		return -ENOMEM;
+
+	src = (__le32 __iomem *) header;
+	dst = (u32 *) *nvram_buf;
+	for (i = 0; i < sizeof(struct nvram_header); i += 4)
+		*dst++ = __raw_readl(src++);
+	for (; i < *nvram_len; i += 4)
+		*dst++ = readl(src++);
+
+	return 0;
+}
+
+int bcm47xx_nvram_getenv(const struct device *dev, const char *name, char *val,
+			 size_t val_len)
+{
+	char *var, *value, *end, *eq;
+	struct bcm47xx_nvram *nvram;
+
+	if (!dev)
+		return -ENODEV;
+
+	nvram = dev_get_drvdata(dev);
+
+	if (!name || !nvram || !nvram->nvram_len)
+		return -EINVAL;
+
+	/* Look for name=value and return value */
+	var = nvram->nvram_buf + sizeof(struct nvram_header);
+	end = nvram->nvram_buf + nvram->nvram_len - 2;
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
+int bcm47xx_nvram_gpio_pin(const struct device *dev, const char *name)
+{
+	int i, err;
+	char nvram_var[10];
+	char buf[30];
+
+	if (!dev)
+		return -ENODEV;
+
+	for (i = 0; i < 32; i++) {
+		err = snprintf(nvram_var, sizeof(nvram_var), "gpio%i", i);
+		if (err <= 0)
+			continue;
+		err = bcm47xx_nvram_getenv(dev, nvram_var, buf, sizeof(buf));
+		if (err <= 0)
+			continue;
+		if (!strcmp(name, buf))
+			return i;
+	}
+	return -ENOENT;
+}
+EXPORT_SYMBOL(bcm47xx_nvram_gpio_pin);
+
+static int bcm47xx_nvram_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct bcm47xx_nvram *nvram;
+	int err;
+	struct resource flash_mem;
+	void __iomem *mmio;
+
+	/* Alloc */
+	nvram = devm_kzalloc(dev, sizeof(*nvram), GFP_KERNEL);
+	if (!nvram)
+		return -ENOMEM;
+
+	err = of_address_to_resource(np, 0, &flash_mem);
+	if (err)
+		return err;
+
+	mmio = ioremap_nocache(flash_mem.start, resource_size(&flash_mem));
+	if (!mmio)
+		return -ENOMEM;
+
+	err = nvram_find_and_copy(dev, mmio, resource_size(&flash_mem),
+				  &nvram->nvram_buf, &nvram->nvram_len);
+	if (err)
+		goto err_unmap_mmio;
+
+	platform_set_drvdata(pdev, nvram);
+
+err_unmap_mmio:
+	iounmap(mmio);
+	return err;
+}
+
+static const struct of_device_id bcm47xx_nvram_of_match_table[] = {
+	{ .compatible = "brcm,bcm47xx-nvram", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
+
+static struct platform_driver bcm47xx_nvram_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "bcm47xx-nvram",
+		.of_match_table = bcm47xx_nvram_of_match_table,
+		/* driver unloading/unbinding currently not supported */
+		.suppress_bind_attrs = true,
+	},
+	.probe = bcm47xx_nvram_probe,
+};
+module_platform_driver(bcm47xx_nvram_driver);
+
+MODULE_AUTHOR("Hauke Mehrtens <hauke@hauke-m.de>");
+MODULE_LICENSE("GPLv2");
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index d2714a2..8340498 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -411,7 +411,7 @@ static void b44_wap54g10_workaround(struct b44 *bp)
 	 * see https://dev.openwrt.org/ticket/146
 	 * check and reset bit "isolate"
 	 */
-	if (bcm47xx_nvram_getenv("boardnum", buf, sizeof(buf)) < 0)
+	if (bcm47xx_nvram_getenv(NULL, "boardnum", buf, sizeof(buf)) < 0)
 		return;
 	if (simple_strtoul(buf, NULL, 0) == 2) {
 		err = __b44_readphy(bp, 0, MII_BMCR, &val);
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index bdda57b..1df7fb0 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -952,7 +952,8 @@ static void bgmac_chip_reset(struct bgmac *bgmac)
 			     BGMAC_CHIPCTL_1_IF_TYPE_MII;
 		char buf[4];
 
-		if (bcm47xx_nvram_getenv("et_swtype", buf, sizeof(buf)) > 0) {
+		if (bcm47xx_nvram_getenv(NULL, "et_swtype", buf,
+					 sizeof(buf)) > 0) {
 			if (kstrtou8(buf, 0, &et_swtype))
 				bgmac_err(bgmac, "Failed to parse et_swtype (%s)\n",
 					  buf);
@@ -1501,7 +1502,7 @@ static int bgmac_probe(struct bcma_device *core)
 	}
 
 	bgmac->int_mask = BGMAC_IS_ERRMASK | BGMAC_IS_RX | BGMAC_IS_TX_MASK;
-	if (bcm47xx_nvram_getenv("et0_no_txint", NULL, 0) == 0)
+	if (bcm47xx_nvram_getenv(NULL, "et0_no_txint", NULL, 0) == 0)
 		bgmac->int_mask &= ~BGMAC_IS_TX_MASK;
 
 	/* TODO: reset the external phy. Specs are needed */
diff --git a/drivers/ssb/driver_chipcommon_pmu.c b/drivers/ssb/driver_chipcommon_pmu.c
index 8d07d4d..b611ea1 100644
--- a/drivers/ssb/driver_chipcommon_pmu.c
+++ b/drivers/ssb/driver_chipcommon_pmu.c
@@ -319,7 +319,8 @@ static void ssb_pmu_pll_init(struct ssb_chipcommon *cc)
 
 	if (bus->bustype == SSB_BUSTYPE_SSB) {
 		char buf[20];
-		if (bcm47xx_nvram_getenv("xtalfreq", buf, sizeof(buf)) >= 0)
+		if (bcm47xx_nvram_getenv(NULL, "xtalfreq", buf,
+					 sizeof(buf)) >= 0)
 			crystalfreq = simple_strtoul(buf, NULL, 0);
 	}
 
diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
index 333d32c..515fc06 100644
--- a/include/linux/bcm47xx_nvram.h
+++ b/include/linux/bcm47xx_nvram.h
@@ -15,9 +15,11 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 
+struct device;
+
 struct nvram_header {
 	u32 magic;
-	u32 len;
+	__le32 len;
 	u32 crc_ver_init;	/* 0:7 crc, 8:15 ver, 16:31 sdram_init */
 	u32 config_refresh;	/* 0:15 sdram_config, 16:31 sdram_refresh */
 	u32 config_ncdl;	/* ncdl values for memc */
@@ -33,18 +35,21 @@ struct nvram_header {
 #define NVRAM_MAX_VALUE_LEN 255
 #define NVRAM_MAX_PARAM_LEN 64
 
-#ifdef CONFIG_BCM47XX
-int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
+#if defined(CONFIG_BCM47XX) || defined(CONFIG_BCM47XX_NVRAM)
+int bcm47xx_nvram_getenv(const struct device *dev, const char *name, char *val,
+			 size_t val_len);
 
-int bcm47xx_nvram_gpio_pin(const char *name);
+int bcm47xx_nvram_gpio_pin(const struct device *dev, const char *name);
 #else
-static inline int bcm47xx_nvram_getenv(const char *name, char *val,
+static inline int bcm47xx_nvram_getenv(const struct device *dev,
+				       const char *name, char *val,
 				       size_t val_len)
 {
 	return -ENXIO;
 }
 
-static inline int bcm47xx_nvram_gpio_pin(const char *name)
+static inline int bcm47xx_nvram_gpio_pin(const struct device *dev,
+					 const char *name)
 {
 	return -ENXIO;
 }
-- 
1.9.1
