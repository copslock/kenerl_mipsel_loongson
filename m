Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2011 14:32:42 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:47001 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491171Ab1DEMcf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Apr 2011 14:32:35 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org
Subject: [PATCH V7] MIPS: lantiq: add NOR flash support
Date:   Tue,  5 Apr 2011 14:33:50 +0200
Message-Id: <1302006830-10345-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds the driver/map for NOR devices attached to the SoC via the
External Bus Unit (EBU).

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
Cc: linux-mips@linux-mips.org
Cc: linux-mtd@lists.infradead.org

---

Changes in V2
* handle the endianess bug inside the map code and not in the generic cfi code
* remove the addr swizzle patch

Changes in V3
* whitespace
* change __iomem void to void __iomem

Changes in V4
* fixes a checkpatch.pl bug, the second is a false positive
* whitespace cleanups
* remove unused typecasts
* cleanup ltq_copy_from and ltq_copy_to

Changes in V6
* cleanup/add comments
* fix line breaks
* properly handle return code of add_mtd_partitions()
* use pr_err instead of printk

Changes in V7
* remove bogus KERN_INFO from pr_err() call

This patch should be merged via the MIPS tree

 drivers/mtd/maps/Kconfig  |    9 ++
 drivers/mtd/maps/Makefile |    1 +
 drivers/mtd/maps/lantiq.c |  187 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/maps/lantiq.c

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 44b1f46..83376d3 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -260,6 +260,15 @@ config MTD_BCM963XX
 	  Support for parsing CFE image tag and creating MTD partitions on
 	  Broadcom BCM63xx boards.
 
+config MTD_LANTIQ
+	bool "Lantiq SoC NOR support"
+	depends on LANTIQ
+	select MTD_PARTITIONS
+	help
+	  Lantiq SoCs have a EBU (External Bus Unit). This IP allows to attach
+	  a number of different peripherals to the SoC. This driver adds
+	  support for NOR chips to be added.
+
 config MTD_DILNETPC
 	tristate "CFI Flash device mapped on DIL/Net PC"
 	depends on X86 && MTD_PARTITIONS && MTD_CFI_INTELEXT && BROKEN
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 08533bd..0db4ba3 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_MTD_VMU)		+= vmu-flash.o
 obj-$(CONFIG_MTD_GPIO_ADDR)	+= gpio-addr-flash.o
 obj-$(CONFIG_MTD_BCM963XX)	+= bcm963xx-flash.o
 obj-$(CONFIG_MTD_LATCH_ADDR)	+= latch-addr-flash.o
+obj-$(CONFIG_MTD_LANTIQ)	+= lantiq.o
diff --git a/drivers/mtd/maps/lantiq.c b/drivers/mtd/maps/lantiq.c
new file mode 100644
index 0000000..588e873
--- /dev/null
+++ b/drivers/mtd/maps/lantiq.c
@@ -0,0 +1,187 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2004 Liu Peng Infineon IFAP DC COM CPE
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/cfi.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+
+#include <lantiq_soc.h>
+#include <lantiq_platform.h>
+
+/* 
+ * The NOR flash is connected to the same external bus unit (EBU) as PCI.
+ * To make PCI work we need to enable the endianess swapping for the address
+ * written to the EBU. This endianess swapping works for PCI correctly but
+ * fails for attached NOR devices. To workaround this we need to use a complex
+ * map. The workaround involves swapping all addresses whilste probing the chip.
+ * Once probing is complete we stop swapping the addresses but swizzle the
+ * unlock addresses to ensure that access to the NOR device works correctly.
+ */
+
+static int ltq_mtd_probing;
+
+static map_word
+ltq_read16(struct map_info *map, unsigned long adr)
+{
+	unsigned long flags;
+	map_word temp;
+
+	if (ltq_mtd_probing)
+		adr ^= 2;
+	spin_lock_irqsave(&ebu_lock, flags);
+	temp.x[0] = *((__u16 *)(map->virt + adr));
+	spin_unlock_irqrestore(&ebu_lock, flags);
+	return temp;
+}
+
+static void
+ltq_write16(struct map_info *map, map_word d, unsigned long adr)
+{
+	unsigned long flags;
+
+	if (ltq_mtd_probing)
+		adr ^= 2;
+	spin_lock_irqsave(&ebu_lock, flags);
+	*((__u16 *)(map->virt + adr)) = d.x[0];
+	spin_unlock_irqrestore(&ebu_lock, flags);
+}
+
+/*
+ * The following 2 functions copy data between iomem and a cached memory
+ * section. As memcpy() makes use of pre-fetching we cannot use it here.
+ * The normal alternative of using memcpy_{to,from}io also makes use of
+ * memcpy() on MIPS so it is not applicable either. We are therefore stuck
+ * with having to use our own loop.
+ */
+static void
+ltq_copy_from(struct map_info *map, void *to,
+	unsigned long from, ssize_t len)
+{
+	unsigned char *f = (unsigned char *) (map->virt + from);
+	unsigned char *t = (unsigned char *) to;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ebu_lock, flags);
+	while (len--)
+		*t++ = *f++;
+	spin_unlock_irqrestore(&ebu_lock, flags);
+}
+
+static void
+ltq_copy_to(struct map_info *map, unsigned long to,
+	const void *from, ssize_t len)
+{
+	unsigned char *f = (unsigned char *) from;
+	unsigned char *t = (unsigned char *) (map->virt + to);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ebu_lock, flags);
+	while (len--)
+		*t++ = *f++;
+	spin_unlock_irqrestore(&ebu_lock, flags);
+}
+
+static const char const *part_probe_types[] = { "cmdlinepart", NULL };
+
+static struct map_info ltq_map = {
+	.name = "ltq_nor",
+	.bankwidth = 2,
+	.read = ltq_read16,
+	.write = ltq_write16,
+	.copy_from = ltq_copy_from,
+	.copy_to = ltq_copy_to,
+};
+
+static int __init
+ltq_mtd_probe(struct platform_device *pdev)
+{
+	struct physmap_flash_data *ltq_mtd_data = dev_get_platdata(&pdev->dev);
+	struct mtd_info *ltq_mtd = NULL;
+	struct mtd_partition *parts = NULL;
+	struct resource *res;
+	int nr_parts = 0;
+	struct cfi_private *cfi;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get memory resource");
+		return -ENOENT;
+	}
+	res = devm_request_mem_region(&pdev->dev, res->start,
+		resource_size(res), dev_name(&pdev->dev));
+	if (!res) {
+		dev_err(&pdev->dev, "failed to request mem resource");
+		return -EBUSY;
+	}
+
+	ltq_map.phys = res->start;
+	ltq_map.size = resource_size(res);
+	ltq_map.virt = devm_ioremap_nocache(&pdev->dev, ltq_map.phys,
+					ltq_map.size);
+	if (!ltq_map.virt) {
+		dev_err(&pdev->dev, "failed to ioremap!\n");
+		return -EIO;
+	}
+
+	ltq_mtd_probing = 1;
+	ltq_mtd = do_map_probe("cfi_probe", &ltq_map);
+	ltq_mtd_probing = 0;
+	if (!ltq_mtd) {
+		iounmap(ltq_map.virt);
+		dev_err(&pdev->dev, "probing failed\n");
+		return -ENXIO;
+	}
+	ltq_mtd->owner = THIS_MODULE;
+
+	cfi = ltq_map.fldrv_priv;
+	cfi->addr_unlock1 ^= 1;
+	cfi->addr_unlock2 ^= 1;
+
+	nr_parts = parse_mtd_partitions(ltq_mtd, part_probe_types, &parts, 0);
+	if (nr_parts > 0) {
+		dev_info(&pdev->dev,
+			"using %d partitions from cmdline", nr_parts);
+	} else {
+		nr_parts = ltq_mtd_data->nr_parts;
+		parts = ltq_mtd_data->parts;
+	}
+
+	return add_mtd_partitions(ltq_mtd, parts, nr_parts);
+}
+
+static struct platform_driver ltq_mtd_driver = {
+	.driver = {
+		.name = "ltq_nor",
+		.owner = THIS_MODULE,
+	},
+};
+
+int __init
+init_ltq_mtd(void)
+{
+	int ret = platform_driver_probe(&ltq_mtd_driver, ltq_mtd_probe);
+
+	if (ret)
+		pr_err("ltq_nor: error registering platfom driver");
+	return ret;
+}
+
+module_init(init_ltq_mtd);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_DESCRIPTION("Lantiq SoC NOR");
-- 
1.7.2.3
