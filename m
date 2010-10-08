Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 23:49:30 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6303 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491767Ab0JHVsJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 23:48:09 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4caf91ba0000>; Fri, 08 Oct 2010 14:48:42 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 8 Oct 2010 14:48:17 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 8 Oct 2010 14:48:17 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o98Lm3qU023146;
        Fri, 8 Oct 2010 14:48:03 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o98Lm2bS023145;
        Fri, 8 Oct 2010 14:48:02 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org, gregkh@suse.de,
        dbrownell@users.sourceforge.net
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/3] MIPS: Add platform device and Kconfig for Octeon USB EHCI/OHCI
Date:   Fri,  8 Oct 2010 14:47:53 -0700
Message-Id: <1286574473-23098-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286574473-23098-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286574473-23098-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 08 Oct 2010 21:48:17.0494 (UTC) FILETIME=[843F0760:01CB6732]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Declare that OCTEON reference boards have both OHCI and EHCI.

Add platform devices for the corresponding hardware.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig                         |    2 +
 arch/mips/cavium-octeon/octeon-platform.c |  105 ++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e68b89f..fbaf08e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -696,6 +696,8 @@ config CAVIUM_OCTEON_REFERENCE_BOARD
 	select HW_HAS_PCI
 	select ARCH_SUPPORTS_MSI
 	select ZONE_DMA32
+	select USB_ARCH_HAS_OHCI
+	select USB_ARCH_HAS_EHCI
 	help
 	  This option supports all of the Octeon reference boards from Cavium
 	  Networks. It builds a kernel that dynamically determines the Octeon
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 49c3320..cecaf62 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -3,13 +3,14 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2009 Cavium Networks
+ * Copyright (C) 2004-2010 Cavium Networks
  * Copyright (C) 2008 Wind River Systems
  */
 
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/i2c.h>
+#include <linux/usb.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -337,6 +338,108 @@ out:
 }
 device_initcall(octeon_mgmt_device_init);
 
+#ifdef CONFIG_USB
+
+static int __init octeon_ehci_device_init(void)
+{
+	struct platform_device *pd;
+	int ret = 0;
+
+	struct resource usb_resources[] = {
+		{
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.flags	= IORESOURCE_IRQ,
+		}
+	};
+
+	/* Only Octeon2 has ehci/ohci */
+	if (!OCTEON_IS_MODEL(OCTEON_CN63XX))
+		return 0;
+
+	if (octeon_is_simulation() || usb_disabled())
+		return 0; /* No USB in the simulator. */
+
+	pd = platform_device_alloc("octeon-ehci", 0);
+	if (!pd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	usb_resources[0].start = 0x00016F0000000000ULL;
+	usb_resources[0].end = usb_resources[0].start + 0x100;
+
+	usb_resources[1].start = OCTEON_IRQ_USB0;
+	usb_resources[1].end = OCTEON_IRQ_USB0;
+
+	ret = platform_device_add_resources(pd, usb_resources,
+					    ARRAY_SIZE(usb_resources));
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
+device_initcall(octeon_ehci_device_init);
+
+static int __init octeon_ohci_device_init(void)
+{
+	struct platform_device *pd;
+	int ret = 0;
+
+	struct resource usb_resources[] = {
+		{
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.flags	= IORESOURCE_IRQ,
+		}
+	};
+
+	/* Only Octeon2 has ehci/ohci */
+	if (!OCTEON_IS_MODEL(OCTEON_CN63XX))
+		return 0;
+
+	if (octeon_is_simulation() || usb_disabled())
+		return 0; /* No USB in the simulator. */
+
+	pd = platform_device_alloc("octeon-ohci", 0);
+	if (!pd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	usb_resources[0].start = 0x00016F0000000400ULL;
+	usb_resources[0].end = usb_resources[0].start + 0x100;
+
+	usb_resources[1].start = OCTEON_IRQ_USB0;
+	usb_resources[1].end = OCTEON_IRQ_USB0;
+
+	ret = platform_device_add_resources(pd, usb_resources,
+					    ARRAY_SIZE(usb_resources));
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
+device_initcall(octeon_ohci_device_init);
+
+#endif /* CONFIG_USB */
+
 MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Platform driver for Octeon SOC");
-- 
1.7.2.3
