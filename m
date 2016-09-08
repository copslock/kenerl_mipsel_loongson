Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2016 05:11:24 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:60048 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991859AbcIHDLRNnXAx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Sep 2016 05:11:17 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <steven.hill@cavium.com>)
        id 1bhpba-0007yJ-1F; Wed, 07 Sep 2016 22:02:22 -0500
Subject: [PATCH] usb: dwc3: OCTEON: add support for device tree
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
From:   "Steven J. Hill" <steven.hill@cavium.com>
Message-ID: <eb11c5c9-62c8-ee1b-0030-c8885015e6c3@cavium.com>
Date:   Wed, 7 Sep 2016 22:11:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <steven.hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

This patch adds support to parse probe data for
the dwc3-octeon driver using device tree. The
DWC3 IP core is found on OCTEON III processors.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 drivers/usb/dwc3/Kconfig       | 10 +++++
 drivers/usb/dwc3/Makefile      |  1 +
 drivers/usb/dwc3/dwc3-octeon.c | 96 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-octeon.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index a64ce1c..99db6008 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -105,4 +105,14 @@ config USB_DWC3_ST
 	  inside (i.e. STiH407).
 	  Say 'Y' or 'M' if you have one such device.
 
+config USB_DWC3_OCTEON
+	tristate "Cavium OCTEON III Platforms"
+	depends on CAVIUM_OCTEON_SOC
+	depends on OF
+	default USB_DWC3
+	help
+	  Cavium OCTEON III SoCs with one DesignWare Core USB3 IP
+	  inside (i.e. cn71xx and cn78xx).
+	  Say 'Y' or 'M' if you have one such device.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 22420e1..f1a7a3e 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
 obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
 obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
 obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
+obj-$(CONFIG_USB_DWC3_OCTEON)		+= dwc3-octeon.o
diff --git a/drivers/usb/dwc3/dwc3-octeon.c b/drivers/usb/dwc3/dwc3-octeon.c
new file mode 100644
index 0000000..4339dd6
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-octeon.c
@@ -0,0 +1,96 @@
+/**
+ * dwc3-octeon.c - Cavium OCTEON III DWC3 Specific Glue Layer
+ *
+ * Copyright (C) 2016 Cavium Networks
+ *
+ * Author: Steven J. Hill <steven.hill@cavium.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Inspired by dwc3-exynos.c and dwc3-st.c files.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/dma-mapping.h>
+
+struct dwc3_octeon {
+	struct device		*dev;
+	void __iomem		*usbctl;
+	int			index;
+};
+
+static int dwc3_octeon_probe(struct platform_device *pdev)
+{
+	struct device		*dev = &pdev->dev;
+	struct resource		*res;
+	struct dwc3_octeon	*octeon;
+	int			ret;
+
+	octeon = devm_kzalloc(dev, sizeof(*octeon), GFP_KERNEL);
+	if (!octeon)
+		return - ENOMEM;
+
+	/*
+	 * Right now device-tree probed devices don't get dma_mask set.
+	 * Since shared usb code relies on it, set it here for now.
+	 */
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, octeon);
+	octeon->dev = dev;
+
+	/* Resources for lower level OCTEON USB control. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	octeon->usbctl = devm_ioremap_resource(dev, res);
+	if (IS_ERR(octeon->usbctl))
+		return PTR_ERR(octeon->usbctl);
+
+	/* Controller index. */
+	octeon->index = ((u64)octeon->usbctl >> 24) & 1;
+
+	return 0;
+}
+
+static int dwc3_octeon_remove(struct platform_device *pdev)
+{
+	struct dwc3_octeon *octeon = platform_get_drvdata(pdev);
+
+	octeon->usbctl = NULL;
+	octeon->index = -1;
+
+	return 0;
+}
+
+static const struct of_device_id octeon_dwc3_match[] = {
+	{ .compatible = "cavium,octeon-7130-usb-uctl", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_dwc3_match);
+
+static struct platform_driver dwc3_octeon_driver = {
+	.probe		= dwc3_octeon_probe,
+	.remove		= dwc3_octeon_remove,
+	.driver		= {
+		.name	= "octeon-dwc3",
+		.of_match_table = octeon_dwc3_match,
+		.pm	= NULL,
+	},
+};
+module_platform_driver(dwc3_octeon_driver);
+
+MODULE_ALIAS("platform:octeon-dwc3");
+MODULE_AUTHOR("Steven J. Hill <steven.hill@cavium.com");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("DesignWare USB3 OCTEON Glue Layer");
-- 
1.9.1
