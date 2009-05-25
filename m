Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2009 14:04:15 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:52260 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20023596AbZEYNEJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 May 2009 14:04:09 +0100
Received: from localhost.localdomain (p4108-ipad204funabasi.chiba.ocn.ne.jp [222.146.91.108])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3D441AA89; Mon, 25 May 2009 22:04:02 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TXx9: Add SRAMC support
Date:	Mon, 25 May 2009 22:04:02 +0900
Message-Id: <1243256642-4880-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add a sysdev to access SRAM in TXx9 SoCs via sysfs.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/include/asm/txx9/generic.h  |    1 +
 arch/mips/include/asm/txx9/tx4938.h   |    1 +
 arch/mips/include/asm/txx9/tx4939.h   |    1 +
 arch/mips/txx9/generic/setup.c        |   84 +++++++++++++++++++++++++++++++++
 arch/mips/txx9/generic/setup_tx4938.c |    6 ++
 arch/mips/txx9/generic/setup_tx4939.c |    6 ++
 arch/mips/txx9/rbtx4938/setup.c       |    1 +
 arch/mips/txx9/rbtx4939/setup.c       |    1 +
 8 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/txx9/generic.h b/arch/mips/include/asm/txx9/generic.h
index 8169477..827dc22 100644
--- a/arch/mips/include/asm/txx9/generic.h
+++ b/arch/mips/include/asm/txx9/generic.h
@@ -95,5 +95,6 @@ void __init txx9_aclc_init(unsigned long baseaddr, int irq,
 			   unsigned int dmac_id,
 			   unsigned int dma_chan_out,
 			   unsigned int dma_chan_in);
+void __init txx9_sramc_init(struct resource *r);
 
 #endif /* __ASM_TXX9_GENERIC_H */
diff --git a/arch/mips/include/asm/txx9/tx4938.h b/arch/mips/include/asm/txx9/tx4938.h
index 54e4674..8a178f1 100644
--- a/arch/mips/include/asm/txx9/tx4938.h
+++ b/arch/mips/include/asm/txx9/tx4938.h
@@ -307,5 +307,6 @@ struct tx4938ide_platform_info {
 void tx4938_ata_init(unsigned int irq, unsigned int shift, int tune);
 void tx4938_dmac_init(int memcpy_chan0, int memcpy_chan1);
 void tx4938_aclc_init(void);
+void tx4938_sramc_init(void);
 
 #endif
diff --git a/arch/mips/include/asm/txx9/tx4939.h b/arch/mips/include/asm/txx9/tx4939.h
index f13b708..050364d 100644
--- a/arch/mips/include/asm/txx9/tx4939.h
+++ b/arch/mips/include/asm/txx9/tx4939.h
@@ -546,5 +546,6 @@ void tx4939_ndfmc_init(unsigned int hold, unsigned int spw,
 		       unsigned char ch_mask, unsigned char wide_mask);
 void tx4939_dmac_init(int memcpy_chan0, int memcpy_chan1);
 void tx4939_aclc_init(void);
+void tx4939_sramc_init(void);
 
 #endif /* __ASM_TXX9_TX4939_H */
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 7f91012..3b7d77d 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -24,6 +24,7 @@
 #include <linux/serial_core.h>
 #include <linux/mtd/physmap.h>
 #include <linux/leds.h>
+#include <linux/sysdev.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/reboot.h>
@@ -912,3 +913,86 @@ void __init txx9_aclc_init(unsigned long baseaddr, int irq,
 		platform_device_put(pdev);
 #endif
 }
+
+static struct sysdev_class txx9_sramc_sysdev_class;
+
+struct txx9_sramc_sysdev {
+	struct sys_device dev;
+	struct bin_attribute bindata_attr;
+	void __iomem *base;
+};
+
+static ssize_t txx9_sram_read(struct kobject *kobj,
+			      struct bin_attribute *bin_attr,
+			      char *buf, loff_t pos, size_t size)
+{
+	struct txx9_sramc_sysdev *dev = bin_attr->private;
+	size_t ramsize = bin_attr->size;
+
+	if (pos >= ramsize)
+		return 0;
+	if (pos + size > ramsize)
+		size = ramsize - pos;
+	memcpy_fromio(buf, dev->base + pos, size);
+	return size;
+}
+
+static ssize_t txx9_sram_write(struct kobject *kobj,
+			       struct bin_attribute *bin_attr,
+			       char *buf, loff_t pos, size_t size)
+{
+	struct txx9_sramc_sysdev *dev = bin_attr->private;
+	size_t ramsize = bin_attr->size;
+
+	if (pos >= ramsize)
+		return 0;
+	if (pos + size > ramsize)
+		size = ramsize - pos;
+	memcpy_toio(dev->base + pos, buf, size);
+	return size;
+}
+
+void __init txx9_sramc_init(struct resource *r)
+{
+	struct txx9_sramc_sysdev *dev;
+	size_t size;
+	int err;
+
+	if (!txx9_sramc_sysdev_class.name) {
+		txx9_sramc_sysdev_class.name = "txx9_sram";
+		err = sysdev_class_register(&txx9_sramc_sysdev_class);
+		if (err) {
+			txx9_sramc_sysdev_class.name = NULL;
+			return;
+		}
+	}
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return;
+	size = resource_size(r);
+	dev->base = ioremap(r->start, size);
+	if (!dev->base)
+		goto exit;
+	dev->dev.cls = &txx9_sramc_sysdev_class;
+	dev->bindata_attr.attr.name = "bindata";
+	dev->bindata_attr.attr.mode = S_IRUSR | S_IWUSR;
+	dev->bindata_attr.read = txx9_sram_read;
+	dev->bindata_attr.write = txx9_sram_write;
+	dev->bindata_attr.size = size;
+	dev->bindata_attr.private = dev;
+	err = sysdev_register(&dev->dev);
+	if (err)
+		goto exit;
+	err = sysfs_create_bin_file(&dev->dev.kobj, &dev->bindata_attr);
+	if (err) {
+		sysdev_unregister(&dev->dev);
+		goto exit;
+	}
+	return;
+exit:
+	if (dev) {
+		if (dev->base)
+			iounmap(dev->base);
+		kfree(dev);
+	}
+}
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index 4dfdb52..eb20801 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -425,6 +425,12 @@ void __init tx4938_aclc_init(void)
 			       1, 0, 1);
 }
 
+void __init tx4938_sramc_init(void)
+{
+	if (tx4938_sram_resource.start)
+		txx9_sramc_init(&tx4938_sram_resource);
+}
+
 static void __init tx4938_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index 7139686..df13a89 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -494,6 +494,12 @@ void __init tx4939_aclc_init(void)
 			       TXX9_IRQ_BASE + TX4939_IR_ACLC, 1, 0, 1);
 }
 
+void __init tx4939_sramc_init(void)
+{
+	if (tx4939_sram_resource.start)
+		txx9_sramc_init(&tx4939_sram_resource);
+}
+
 static void __init tx4939_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index 8da66e9..d66509b 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -358,6 +358,7 @@ static void __init rbtx4938_device_init(void)
 	tx4938_dmac_init(0, 2);
 	tx4938_aclc_init();
 	platform_device_register_simple("txx9aclc-generic", -1, NULL, 0);
+	tx4938_sramc_init();
 	txx9_iocled_init(RBTX4938_LED_ADDR - IO_BASE, -1, 8, 1, "green", NULL);
 }
 
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index d5ad5ab..b919696 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -501,6 +501,7 @@ static void __init rbtx4939_device_init(void)
 	tx4939_dmac_init(0, 2);
 	tx4939_aclc_init();
 	platform_device_register_simple("txx9aclc-generic", -1, NULL, 0);
+	tx4939_sramc_init();
 }
 
 static void __init rbtx4939_setup(void)
-- 
1.5.6.5
