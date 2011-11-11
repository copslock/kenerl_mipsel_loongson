Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 03:25:16 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:64298 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904271Ab1KKCWZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 03:22:25 +0100
Received: by ywp31 with SMTP id 31so2040774ywp.36
        for <multiple recipients>; Thu, 10 Nov 2011 18:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Z/lIxt6lcxmxQDAqAk0geAdqVYJkeSt6GxxbzaRpMCE=;
        b=R2wxpV5CqjoOZVbShKszjrzrsVLUQ96wXbQ41QeNfAy3xb01vR/FERd3JTbYBgG0Qp
         S9TYDHOnwpOFc5i6u4njaH0hPu6l0K17M/dOeHFm09t88etvbDHyl34D31FPq64kq8wX
         UJ2Be0jULEwazpO+CkMEh7qnmAh2M6S9WD1sU=
Received: by 10.101.160.5 with SMTP id m5mr4684653ano.3.1320978139517;
        Thu, 10 Nov 2011 18:22:19 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id 4sm29489569ano.9.2011.11.10.18.22.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 18:22:17 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAB2MDML013106;
        Thu, 10 Nov 2011 18:22:13 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAB2MD5U013105;
        Thu, 10 Nov 2011 18:22:13 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 6/8] netdev: mdio-octeon.c: Convert to use device tree.
Date:   Thu, 10 Nov 2011 18:22:02 -0800
Message-Id: <1320978124-13042-7-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1320978124-13042-1-git-send-email-ddaney.cavm@gmail.com>
References: <1320978124-13042-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9977

From: David Daney <david.daney@cavium.com>

Get the MDIO bus controller addresses from the device tree.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-platform.c |   30 ----------
 drivers/net/phy/mdio-octeon.c             |   89 +++++++++++++++++++----------
 2 files changed, 58 insertions(+), 61 deletions(-)

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
index bd12ba9..b18b8c5 100644
--- a/drivers/net/phy/mdio-octeon.c
+++ b/drivers/net/phy/mdio-octeon.c
@@ -3,14 +3,17 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2009 Cavium Networks
+ * Copyright (C) 2009, 2010, 2011 Cavium Networks
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
@@ -88,8 +99,8 @@ static int octeon_mdiobus_write(struct mii_bus *bus, int phy_id,
 static int __devinit octeon_mdiobus_probe(struct platform_device *pdev)
 {
 	struct octeon_mdiobus *bus;
+	struct resource *res_mem;
 	union cvmx_smix_en smi_en;
-	int i;
 	int err = -ENOENT;
 
 	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
@@ -97,28 +108,37 @@ static int __devinit octeon_mdiobus_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* The platform_device id is our unit number.  */
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
+	cvmx_write_csr(bus->register_base + SMI_EN, smi_en.u64);
 
-	/*
-	 * Standard Octeon evaluation boards don't support phy
-	 * interrupts, we need to poll.
-	 */
-	for (i = 0; i < PHY_MAX_ADDR; i++)
-		bus->phy_irq[i] = PHY_POLL;
 
 	bus->mii_bus->priv = bus;
 	bus->mii_bus->irq = bus->phy_irq;
 	bus->mii_bus->name = "mdio-octeon";
-	snprintf(bus->mii_bus->id, MII_BUS_ID_SIZE, "%x", bus->unit);
+	snprintf(bus->mii_bus->id, MII_BUS_ID_SIZE, "%llx", bus->register_base);
 	bus->mii_bus->parent = &pdev->dev;
 
 	bus->mii_bus->read = octeon_mdiobus_read;
@@ -126,20 +146,18 @@ static int __devinit octeon_mdiobus_probe(struct platform_device *pdev)
 
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
 
@@ -153,14 +171,23 @@ static int __devexit octeon_mdiobus_remove(struct platform_device *pdev)
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
