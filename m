Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 03:21:32 +0200 (CEST)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:61509 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903685Ab2D0BUm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 03:20:42 +0200
Received: by dakb39 with SMTP id b39so245324dak.35
        for <multiple recipients>; Thu, 26 Apr 2012 18:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5snxreIqKL8Q/czh5qBoVZ0EQrRbZOIyaMHQDQRF8ZI=;
        b=S+LhfO9SIpEgiPNLuD2sVnmsr1lPWaN98TErv7dYlQLAys0WImM6Mjaqzb0jaSKo7G
         MeKky78iKOqHy3tCNBYnLa6JqsN7gurAVyJnn6MfQtqNXK/lzS46dtZbkIELQmHNUKBE
         AA/C/XQLXcB4a3Rf1Ndd2a5vRXIFx0yCgY411Dt6j5RB6YwteRV6AtWV/UIrz6hxQl8g
         O5O3OCchO7WpSe55D6Iuh5sdHdyd0bEY3YVrQSB4Cw5cBSSfWPy90xmeLlzOAdySXKP0
         0ee37EEPPe2KLEOJ5PAT+XNODwrvzgFV2s8D8xCkEgBVaZ0sLIkf8tnLb64BMYgA1pTo
         iNqg==
Received: by 10.68.201.33 with SMTP id jx1mr19595438pbc.111.1335489635625;
        Thu, 26 Apr 2012 18:20:35 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id qk5sm4850454pbc.45.2012.04.26.18.20.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Apr 2012 18:20:34 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3R1KXEs027061;
        Thu, 26 Apr 2012 18:20:33 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3R1KXUm027060;
        Thu, 26 Apr 2012 18:20:33 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 2/5] netdev: mdio-octeon.c: Convert to use device tree.
Date:   Thu, 26 Apr 2012 18:20:27 -0700
Message-Id: <1335489630-27017-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1335489630-27017-1-git-send-email-ddaney.cavm@gmail.com>
References: <1335489630-27017-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Get the MDIO bus controller addresses from the device tree, small
clean up in use of devm_*

Remove, now unused, platform device setup code.

Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: David Daney <david.daney@cavium.com>
Cc: netdev@vger.kernel.org
Cc: David S. Miller <davem@davemloft.net>
---
 arch/mips/cavium-octeon/octeon-platform.c |   30 ---------
 drivers/net/phy/mdio-octeon.c             |   92 ++++++++++++++++++-----------
 2 files changed, 58 insertions(+), 64 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index f62a40f..66cabc2 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -168,36 +168,6 @@ out:
 }
 device_initcall(octeon_rng_device_init);
 
-/* Octeon SMI/MDIO interface.  */
-static int __init octeon_mdiobus_device_init(void)
-{
-	struct platform_device *pd;
-	int ret = 0;
-
-	if (octeon_is_simulation())
-		return 0; /* No mdio in the simulator. */
-
-	/* The bus number is the platform_device id.  */
-	pd = platform_device_alloc("mdio-octeon", 0);
-	if (!pd) {
-		ret = -ENOMEM;
-		goto out;
-	}
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
-
-}
-device_initcall(octeon_mdiobus_device_init);
-
 /* Octeon mgmt port Ethernet interface.  */
 static int __init octeon_mgmt_device_init(void)
 {
diff --git a/drivers/net/phy/mdio-octeon.c b/drivers/net/phy/mdio-octeon.c
index 826d961..d4015aa 100644
--- a/drivers/net/phy/mdio-octeon.c
+++ b/drivers/net/phy/mdio-octeon.c
@@ -3,14 +3,17 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2009 Cavium Networks
+ * Copyright (C) 2009,2011 Cavium, Inc.
  */
 
-#include <linux/gfp.h>
-#include <linux/init.h>
-#include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of_mdio.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/gfp.h>
 #include <linux/phy.h>
+#include <linux/io.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-smix-defs.h>
@@ -18,9 +21,17 @@
 #define DRV_VERSION "1.0"
 #define DRV_DESCRIPTION "Cavium Networks Octeon SMI/MDIO driver"
 
+#define SMI_CMD		0x0
+#define SMI_WR_DAT	0x8
+#define SMI_RD_DAT	0x10
+#define SMI_CLK		0x18
+#define SMI_EN		0x20
+
 struct octeon_mdiobus {
 	struct mii_bus *mii_bus;
-	int unit;
+	u64 register_base;
+	resource_size_t mdio_phys;
+	resource_size_t regsize;
 	int phy_irq[PHY_MAX_ADDR];
 };
 
@@ -35,15 +46,15 @@ static int octeon_mdiobus_read(struct mii_bus *bus, int phy_id, int regnum)
 	smi_cmd.s.phy_op = 1; /* MDIO_CLAUSE_22_READ */
 	smi_cmd.s.phy_adr = phy_id;
 	smi_cmd.s.reg_adr = regnum;
-	cvmx_write_csr(CVMX_SMIX_CMD(p->unit), smi_cmd.u64);
+	cvmx_write_csr(p->register_base + SMI_CMD, smi_cmd.u64);
 
 	do {
 		/*
 		 * Wait 1000 clocks so we don't saturate the RSL bus
 		 * doing reads.
 		 */
-		cvmx_wait(1000);
-		smi_rd.u64 = cvmx_read_csr(CVMX_SMIX_RD_DAT(p->unit));
+		__delay(1000);
+		smi_rd.u64 = cvmx_read_csr(p->register_base + SMI_RD_DAT);
 	} while (smi_rd.s.pending && --timeout);
 
 	if (smi_rd.s.val)
@@ -62,21 +73,21 @@ static int octeon_mdiobus_write(struct mii_bus *bus, int phy_id,
 
 	smi_wr.u64 = 0;
 	smi_wr.s.dat = val;
-	cvmx_write_csr(CVMX_SMIX_WR_DAT(p->unit), smi_wr.u64);
+	cvmx_write_csr(p->register_base + SMI_WR_DAT, smi_wr.u64);
 
 	smi_cmd.u64 = 0;
 	smi_cmd.s.phy_op = 0; /* MDIO_CLAUSE_22_WRITE */
 	smi_cmd.s.phy_adr = phy_id;
 	smi_cmd.s.reg_adr = regnum;
-	cvmx_write_csr(CVMX_SMIX_CMD(p->unit), smi_cmd.u64);
+	cvmx_write_csr(p->register_base + SMI_CMD, smi_cmd.u64);
 
 	do {
 		/*
 		 * Wait 1000 clocks so we don't saturate the RSL bus
 		 * doing reads.
 		 */
-		cvmx_wait(1000);
-		smi_wr.u64 = cvmx_read_csr(CVMX_SMIX_WR_DAT(p->unit));
+		__delay(1000);
+		smi_wr.u64 = cvmx_read_csr(p->register_base + SMI_WR_DAT);
 	} while (smi_wr.s.pending && --timeout);
 
 	if (timeout <= 0)
@@ -88,38 +99,44 @@ static int octeon_mdiobus_write(struct mii_bus *bus, int phy_id,
 static int __devinit octeon_mdiobus_probe(struct platform_device *pdev)
 {
 	struct octeon_mdiobus *bus;
+	struct resource *res_mem;
 	union cvmx_smix_en smi_en;
-	int i;
 	int err = -ENOENT;
 
 	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
 	if (!bus)
 		return -ENOMEM;
 
-	/* The platform_device id is our unit number.  */
-	bus->unit = pdev->id;
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (res_mem == NULL) {
+		dev_err(&pdev->dev, "found no memory resource\n");
+		err = -ENXIO;
+		goto fail;
+	}
+	bus->mdio_phys = res_mem->start;
+	bus->regsize = resource_size(res_mem);
+	if (!devm_request_mem_region(&pdev->dev, bus->mdio_phys, bus->regsize,
+				     res_mem->name)) {
+		dev_err(&pdev->dev, "request_mem_region failed\n");
+		goto fail;
+	}
+	bus->register_base =
+		(u64)devm_ioremap(&pdev->dev, bus->mdio_phys, bus->regsize);
 
 	bus->mii_bus = mdiobus_alloc();
 
 	if (!bus->mii_bus)
-		goto err;
+		goto fail;
 
 	smi_en.u64 = 0;
 	smi_en.s.en = 1;
-	cvmx_write_csr(CVMX_SMIX_EN(bus->unit), smi_en.u64);
-
-	/*
-	 * Standard Octeon evaluation boards don't support phy
-	 * interrupts, we need to poll.
-	 */
-	for (i = 0; i < PHY_MAX_ADDR; i++)
-		bus->phy_irq[i] = PHY_POLL;
+	cvmx_write_csr(bus->register_base + SMI_EN, smi_en.u64);
 
 	bus->mii_bus->priv = bus;
 	bus->mii_bus->irq = bus->phy_irq;
 	bus->mii_bus->name = "mdio-octeon";
-	snprintf(bus->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
-		bus->mii_bus->name, bus->unit);
+	snprintf(bus->mii_bus->id, MII_BUS_ID_SIZE, "%llx", bus->register_base);
 	bus->mii_bus->parent = &pdev->dev;
 
 	bus->mii_bus->read = octeon_mdiobus_read;
@@ -127,20 +144,18 @@ static int __devinit octeon_mdiobus_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, bus);
 
-	err = mdiobus_register(bus->mii_bus);
+	err = of_mdiobus_register(bus->mii_bus, pdev->dev.of_node);
 	if (err)
-		goto err_register;
+		goto fail_register;
 
 	dev_info(&pdev->dev, "Version " DRV_VERSION "\n");
 
 	return 0;
-err_register:
+fail_register:
 	mdiobus_free(bus->mii_bus);
-
-err:
-	devm_kfree(&pdev->dev, bus);
+fail:
 	smi_en.u64 = 0;
-	cvmx_write_csr(CVMX_SMIX_EN(bus->unit), smi_en.u64);
+	cvmx_write_csr(bus->register_base + SMI_EN, smi_en.u64);
 	return err;
 }
 
@@ -154,14 +169,23 @@ static int __devexit octeon_mdiobus_remove(struct platform_device *pdev)
 	mdiobus_unregister(bus->mii_bus);
 	mdiobus_free(bus->mii_bus);
 	smi_en.u64 = 0;
-	cvmx_write_csr(CVMX_SMIX_EN(bus->unit), smi_en.u64);
+	cvmx_write_csr(bus->register_base + SMI_EN, smi_en.u64);
 	return 0;
 }
 
+static struct of_device_id octeon_mdiobus_match[] = {
+	{
+		.compatible = "cavium,octeon-3860-mdio",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_mdiobus_match);
+
 static struct platform_driver octeon_mdiobus_driver = {
 	.driver = {
 		.name		= "mdio-octeon",
 		.owner		= THIS_MODULE,
+		.of_match_table = octeon_mdiobus_match,
 	},
 	.probe		= octeon_mdiobus_probe,
 	.remove		= __devexit_p(octeon_mdiobus_remove),
-- 
1.7.2.3
