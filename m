Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2014 13:30:28 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:36357 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009630AbaLWMaRXY07t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Dec 2014 13:30:17 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 23 Dec
 2014 15:30:11 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 3/3] MIPS: OCTEON: Use device tree to probe for flash chips.
Date:   Tue, 23 Dec 2014 15:27:01 +0300
Message-ID: <1419337623-16101-4-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1419337623-16101-1-git-send-email-aleksey.makarov@auriga.com>
References: <1419337623-16101-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

From: David Daney <david.daney@cavium.com>

Don't assume they are there, the device tree will tell us.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/cavium-octeon/flash_setup.c | 42 ++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/mips/cavium-octeon/flash_setup.c b/arch/mips/cavium-octeon/flash_setup.c
index 39e26df..8eb81e2 100644
--- a/arch/mips/cavium-octeon/flash_setup.c
+++ b/arch/mips/cavium-octeon/flash_setup.c
@@ -8,10 +8,11 @@
  * Copyright (C) 2007, 2008 Cavium Networks
  */
 #include <linux/kernel.h>
-#include <linux/export.h>
+#include <linux/module.h>
 #include <linux/semaphore.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
+#include <linux/of_platform.h>
 #include <linux/mtd/partitions.h>
 
 #include <asm/octeon/octeon.h>
@@ -66,14 +67,22 @@ static void octeon_flash_map_copy_to(struct map_info *map, unsigned long to,
  *
  * Returns Zero on success
  */
-static int __init flash_init(void)
+static int octeon_flash_probe(struct platform_device *pdev)
 {
+	union cvmx_mio_boot_reg_cfgx region_cfg;
+	u32 cs;
+	int r;
+	struct device_node *np = pdev->dev.of_node;
+
+	r = of_property_read_u32(np, "reg", &cs);
+	if (r)
+		return r;
+
 	/*
 	 * Read the bootbus region 0 setup to determine the base
 	 * address of the flash.
 	 */
-	union cvmx_mio_boot_reg_cfgx region_cfg;
-	region_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(0));
+	region_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(cs));
 	if (region_cfg.s.en) {
 		/*
 		 * The bootloader always takes the flash and sets its
@@ -109,4 +118,27 @@ static int __init flash_init(void)
 	return 0;
 }
 
-late_initcall(flash_init);
+static struct of_device_id of_flash_match[] = {
+	{
+		.compatible	= "cfi-flash",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_flash_match);
+
+static struct platform_driver of_flash_driver = {
+	.driver = {
+		.name = "octeon-of-flash",
+		.owner = THIS_MODULE,
+		.of_match_table = of_flash_match,
+	},
+	.probe		= octeon_flash_probe,
+};
+
+static int octeon_flash_init(void)
+{
+	return platform_driver_register(&of_flash_driver);
+}
+late_initcall(octeon_flash_init);
+
+MODULE_LICENSE("GPL");
-- 
2.1.3
