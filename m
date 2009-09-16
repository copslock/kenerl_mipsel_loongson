Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Sep 2009 23:54:37 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17291 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493385AbZIPVya (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Sep 2009 23:54:30 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ab15e890000>; Wed, 16 Sep 2009 14:54:17 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Sep 2009 14:54:22 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Sep 2009 14:54:21 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n8GLsJKU022045;
	Wed, 16 Sep 2009 14:54:19 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n8GLsI1R022043;
	Wed, 16 Sep 2009 14:54:18 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon:  Move some platform device registration to its own file.
Date:	Wed, 16 Sep 2009 14:54:18 -0700
Message-Id: <1253138058-22018-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 16 Sep 2009 21:54:21.0945 (UTC) FILETIME=[3F9C9690:01CA3718]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

There is a bunch of platform device registration in
arch/mips/cavium-octeon/setup.c.  We move it to its own file in
preparation for adding more platform devices.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/Makefile          |    4 +-
 arch/mips/cavium-octeon/octeon-platform.c |  164 +++++++++++++++++++++++++++++
 arch/mips/cavium-octeon/setup.c           |  146 -------------------------
 3 files changed, 166 insertions(+), 148 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/octeon-platform.c

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index e59a80a..6d13c78 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -6,10 +6,10 @@
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
 #
-# Copyright (C) 2005-2008 Cavium Networks
+# Copyright (C) 2005-2009 Cavium Networks
 #
 
-obj-y := setup.o serial.o octeon-irq.o csrc-octeon.o
+obj-y := setup.o serial.o octeon-platform.o octeon-irq.o csrc-octeon.o
 obj-y += dma-octeon.o flash_setup.o
 obj-y += octeon-memcpy.o
 
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
new file mode 100644
index 0000000..be711dd
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -0,0 +1,164 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2009 Cavium Networks
+ * Copyright (C) 2008 Wind River Systems
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-rnm-defs.h>
+
+static struct octeon_cf_data octeon_cf_data;
+
+static int __init octeon_cf_device_init(void)
+{
+	union cvmx_mio_boot_reg_cfgx mio_boot_reg_cfg;
+	unsigned long base_ptr, region_base, region_size;
+	struct platform_device *pd;
+	struct resource cf_resources[3];
+	unsigned int num_resources;
+	int i;
+	int ret = 0;
+
+	/* Setup octeon-cf platform device if present. */
+	base_ptr = 0;
+	if (octeon_bootinfo->major_version == 1
+		&& octeon_bootinfo->minor_version >= 1) {
+		if (octeon_bootinfo->compact_flash_common_base_addr)
+			base_ptr =
+				octeon_bootinfo->compact_flash_common_base_addr;
+	} else {
+		base_ptr = 0x1d000800;
+	}
+
+	if (!base_ptr)
+		return ret;
+
+	/* Find CS0 region. */
+	for (i = 0; i < 8; i++) {
+		mio_boot_reg_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(i));
+		region_base = mio_boot_reg_cfg.s.base << 16;
+		region_size = (mio_boot_reg_cfg.s.size + 1) << 16;
+		if (mio_boot_reg_cfg.s.en && base_ptr >= region_base
+		    && base_ptr < region_base + region_size)
+			break;
+	}
+	if (i >= 7) {
+		/* i and i + 1 are CS0 and CS1, both must be less than 8. */
+		goto out;
+	}
+	octeon_cf_data.base_region = i;
+	octeon_cf_data.is16bit = mio_boot_reg_cfg.s.width;
+	octeon_cf_data.base_region_bias = base_ptr - region_base;
+	memset(cf_resources, 0, sizeof(cf_resources));
+	num_resources = 0;
+	cf_resources[num_resources].flags	= IORESOURCE_MEM;
+	cf_resources[num_resources].start	= region_base;
+	cf_resources[num_resources].end	= region_base + region_size - 1;
+	num_resources++;
+
+
+	if (!(base_ptr & 0xfffful)) {
+		/*
+		 * Boot loader signals availability of DMA (true_ide
+		 * mode) by setting low order bits of base_ptr to
+		 * zero.
+		 */
+
+		/* Asume that CS1 immediately follows. */
+		mio_boot_reg_cfg.u64 =
+			cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(i + 1));
+		region_base = mio_boot_reg_cfg.s.base << 16;
+		region_size = (mio_boot_reg_cfg.s.size + 1) << 16;
+		if (!mio_boot_reg_cfg.s.en)
+			goto out;
+
+		cf_resources[num_resources].flags	= IORESOURCE_MEM;
+		cf_resources[num_resources].start	= region_base;
+		cf_resources[num_resources].end	= region_base + region_size - 1;
+		num_resources++;
+
+		octeon_cf_data.dma_engine = 0;
+		cf_resources[num_resources].flags	= IORESOURCE_IRQ;
+		cf_resources[num_resources].start	= OCTEON_IRQ_BOOTDMA;
+		cf_resources[num_resources].end	= OCTEON_IRQ_BOOTDMA;
+		num_resources++;
+	} else {
+		octeon_cf_data.dma_engine = -1;
+	}
+
+	pd = platform_device_alloc("pata_octeon_cf", -1);
+	if (!pd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	pd->dev.platform_data = &octeon_cf_data;
+
+	ret = platform_device_add_resources(pd, cf_resources, num_resources);
+	if (ret)
+		goto fail;
+
+	ret = platform_device_add(pd);
+	if (ret)
+		goto fail;
+
+	return ret;
+fail:
+	platform_device_put(pd);
+out:
+	return ret;
+}
+device_initcall(octeon_cf_device_init);
+
+/* Octeon Random Number Generator.  */
+static int __init octeon_rng_device_init(void)
+{
+	struct platform_device *pd;
+	int ret = 0;
+
+	struct resource rng_resources[] = {
+		{
+			.flags	= IORESOURCE_MEM,
+			.start	= XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS),
+			.end	= XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS) + 0xf
+		}, {
+			.flags	= IORESOURCE_MEM,
+			.start	= cvmx_build_io_address(8, 0),
+			.end	= cvmx_build_io_address(8, 0) + 0x7
+		}
+	};
+
+	pd = platform_device_alloc("octeon_rng", -1);
+	if (!pd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = platform_device_add_resources(pd, rng_resources,
+					    ARRAY_SIZE(rng_resources));
+	if (ret)
+		goto fail;
+
+	ret = platform_device_add(pd);
+	if (ret)
+		goto fail;
+
+	return ret;
+fail:
+	platform_device_put(pd);
+
+out:
+	return ret;
+}
+device_initcall(octeon_rng_device_init);
+
+MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Platform driver for Octeon SOC");
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index d8cf674..f58eed6 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -11,7 +11,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/serial.h>
 #include <linux/smp.h>
 #include <linux/types.h>
@@ -33,7 +32,6 @@
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-rnm-defs.h>
 
 #ifdef CONFIG_CAVIUM_DECODE_RSL
 extern void cvmx_interrupt_rsl_decode(void);
@@ -830,147 +828,3 @@ void prom_free_prom_memory(void)
 	   CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB option is set */
 	octeon_hal_setup_reserved32();
 }
-
-static struct octeon_cf_data octeon_cf_data;
-
-static int __init octeon_cf_device_init(void)
-{
-	union cvmx_mio_boot_reg_cfgx mio_boot_reg_cfg;
-	unsigned long base_ptr, region_base, region_size;
-	struct platform_device *pd;
-	struct resource cf_resources[3];
-	unsigned int num_resources;
-	int i;
-	int ret = 0;
-
-	/* Setup octeon-cf platform device if present. */
-	base_ptr = 0;
-	if (octeon_bootinfo->major_version == 1
-		&& octeon_bootinfo->minor_version >= 1) {
-		if (octeon_bootinfo->compact_flash_common_base_addr)
-			base_ptr =
-				octeon_bootinfo->compact_flash_common_base_addr;
-	} else {
-		base_ptr = 0x1d000800;
-	}
-
-	if (!base_ptr)
-		return ret;
-
-	/* Find CS0 region. */
-	for (i = 0; i < 8; i++) {
-		mio_boot_reg_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(i));
-		region_base = mio_boot_reg_cfg.s.base << 16;
-		region_size = (mio_boot_reg_cfg.s.size + 1) << 16;
-		if (mio_boot_reg_cfg.s.en && base_ptr >= region_base
-		    && base_ptr < region_base + region_size)
-			break;
-	}
-	if (i >= 7) {
-		/* i and i + 1 are CS0 and CS1, both must be less than 8. */
-		goto out;
-	}
-	octeon_cf_data.base_region = i;
-	octeon_cf_data.is16bit = mio_boot_reg_cfg.s.width;
-	octeon_cf_data.base_region_bias = base_ptr - region_base;
-	memset(cf_resources, 0, sizeof(cf_resources));
-	num_resources = 0;
-	cf_resources[num_resources].flags	= IORESOURCE_MEM;
-	cf_resources[num_resources].start	= region_base;
-	cf_resources[num_resources].end	= region_base + region_size - 1;
-	num_resources++;
-
-
-	if (!(base_ptr & 0xfffful)) {
-		/*
-		 * Boot loader signals availability of DMA (true_ide
-		 * mode) by setting low order bits of base_ptr to
-		 * zero.
-		 */
-
-		/* Asume that CS1 immediately follows. */
-		mio_boot_reg_cfg.u64 =
-			cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(i + 1));
-		region_base = mio_boot_reg_cfg.s.base << 16;
-		region_size = (mio_boot_reg_cfg.s.size + 1) << 16;
-		if (!mio_boot_reg_cfg.s.en)
-			goto out;
-
-		cf_resources[num_resources].flags	= IORESOURCE_MEM;
-		cf_resources[num_resources].start	= region_base;
-		cf_resources[num_resources].end	= region_base + region_size - 1;
-		num_resources++;
-
-		octeon_cf_data.dma_engine = 0;
-		cf_resources[num_resources].flags	= IORESOURCE_IRQ;
-		cf_resources[num_resources].start	= OCTEON_IRQ_BOOTDMA;
-		cf_resources[num_resources].end	= OCTEON_IRQ_BOOTDMA;
-		num_resources++;
-	} else {
-		octeon_cf_data.dma_engine = -1;
-	}
-
-	pd = platform_device_alloc("pata_octeon_cf", -1);
-	if (!pd) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	pd->dev.platform_data = &octeon_cf_data;
-
-	ret = platform_device_add_resources(pd, cf_resources, num_resources);
-	if (ret)
-		goto fail;
-
-	ret = platform_device_add(pd);
-	if (ret)
-		goto fail;
-
-	return ret;
-fail:
-	platform_device_put(pd);
-out:
-	return ret;
-}
-device_initcall(octeon_cf_device_init);
-
-/* Octeon Random Number Generator.  */
-static int __init octeon_rng_device_init(void)
-{
-	struct platform_device *pd;
-	int ret = 0;
-
-	struct resource rng_resources[] = {
-		{
-			.flags	= IORESOURCE_MEM,
-			.start	= XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS),
-			.end	= XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS) + 0xf
-		}, {
-			.flags	= IORESOURCE_MEM,
-			.start	= cvmx_build_io_address(8, 0),
-			.end	= cvmx_build_io_address(8, 0) + 0x7
-		}
-	};
-
-	pd = platform_device_alloc("octeon_rng", -1);
-	if (!pd) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ret = platform_device_add_resources(pd, rng_resources,
-					    ARRAY_SIZE(rng_resources));
-	if (ret)
-		goto fail;
-
-	ret = platform_device_add(pd);
-	if (ret)
-		goto fail;
-
-	return ret;
-fail:
-	platform_device_put(pd);
-
-out:
-	return ret;
-}
-device_initcall(octeon_rng_device_init);
-- 
1.6.0.6
