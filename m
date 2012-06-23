Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 02:26:05 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:62388 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903722Ab2FWAYb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jun 2012 02:24:31 +0200
Received: by dadm1 with SMTP id m1so3181026dad.36
        for <linux-mips@linux-mips.org>; Fri, 22 Jun 2012 17:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PXEFkoKLuSa8T1vTEi9s8xy7qOTohG7jKKll3W971QI=;
        b=jTXZ/PPjmieAt3sh4sKiK8OJsZ6pxL/wZoVcs7c4q2Mu/sgyF9mykdALWD7zaQngP5
         E6zQbkk2zEEGX91JTORnbZcN9ai5Xhvhp/qKaZ4pASflRRlYz9yfAUjmxKr8EOf+2tY+
         KA4Hr5OLb0piEmltZK1v1+jqpep+iHl7uOkYOSLbWIXQ0EyutcA22PJRyKTDIuSVMukq
         vBPBjqAYerN5KYUy/dACv7GhFWtSwr+YgD0JlK+CS4TGnQ+CYtP2roJRh/8EmmsiGPPK
         TKfGTeAn/TS0a+l99HMXJlx9xEPasfEoglwM8WVDjmBFRjxWcyj0A7r+FsjjXUVL94Kw
         HQHA==
Received: by 10.68.201.9 with SMTP id jw9mr15592512pbc.28.1340411064726;
        Fri, 22 Jun 2012 17:24:24 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id jp10sm622094pbb.16.2012.06.22.17.24.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 17:24:22 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q5N0OK9S019041;
        Fri, 22 Jun 2012 17:24:20 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q5N0OKGH019040;
        Fri, 22 Jun 2012 17:24:20 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, David Daney <david.daney@cavium.com>
Subject: [PATCH 4/4] netdev/phy: Add driver for Broadcom BCM87XX 10G Ethernet PHYs
Date:   Fri, 22 Jun 2012 17:24:16 -0700
Message-Id: <1340411056-18988-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1340411056-18988-1-git-send-email-ddaney.cavm@gmail.com>
References: <1340411056-18988-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Add a driver for BCM8706 and BCM8727 devices.  These are a 10Gig PHYs
which use MII_ADDR_C45 addressing.  They are always 10G full duplex, so
there is no autonegotiation.  All we do is report link state and send
interrupts when it changes.

If the PHY has a device tree of_node associated with it, the
"broadcom,c45-reg-init" property is used to supply register
initialization values when config_init() is called.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 .../devicetree/bindings/net/broadcom-bcm87xx.txt   |   29 +++
 drivers/net/phy/Kconfig                            |    5 +
 drivers/net/phy/Makefile                           |    1 +
 drivers/net/phy/bcm87xx.c                          |  239 ++++++++++++++++++++
 4 files changed, 274 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/broadcom-bcm87xx.txt
 create mode 100644 drivers/net/phy/bcm87xx.c

diff --git a/Documentation/devicetree/bindings/net/broadcom-bcm87xx.txt b/Documentation/devicetree/bindings/net/broadcom-bcm87xx.txt
new file mode 100644
index 0000000..7c86d5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/broadcom-bcm87xx.txt
@@ -0,0 +1,29 @@
+The Broadcom BCM87XX devices are a family of 10G Ethernet PHYs.  They
+have these bindings in addition to the standard PHY bindings.
+
+Compatible: Should contain "broadcom,bcm8706" or "broadcom,bcm8727" and
+            "ethernet-phy-ieee802.3-c45"
+
+Optional Properties:
+
+- broadcom,c45-reg-init : one of more sets of 4 cells.  The first cell
+  is the MDIO Manageable Device (MMD) address, the second a register
+  address within the MMD, the third cell contains a mask to be ANDed
+  with the existing register value, and the fourth cell is ORed with
+  he result to yield the new register value.  If the third cell has a
+  value of zero, no read of the existing value is performed.
+
+Example:
+
+	ethernet-phy@5 {
+		reg = <5>;
+		compatible = "broadcom,bcm8706", "ethernet-phy-ieee802.3-c45";
+		interrupt-parent = <&gpio>;
+		interrupts = <12 8>; /* Pin 12, active low */
+		/*
+		 * Set PMD Digital Control Register for
+		 * GPIO[1] Tx/Rx
+		 * GPIO[0] R64 Sync Acquired
+		 */
+		broadcom,c45-reg-init = <1 0xc808 0xff8f 0x70>;
+	};
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 944cdfb..3090dc6 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -67,6 +67,11 @@ config BCM63XX_PHY
 	---help---
 	  Currently supports the 6348 and 6358 PHYs.
 
+config BCM87XX_PHY
+	tristate "Driver for Broadcom BCM8706 and BCM8727 PHYs"
+	help
+	  Currently supports the BCM8706 and BCM8727 10G Ethernet PHYs.
+
 config ICPLUS_PHY
 	tristate "Drivers for ICPlus PHYs"
 	---help---
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index f51af68..6d2dc6c 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SMSC_PHY)		+= smsc.o
 obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
 obj-$(CONFIG_BROADCOM_PHY)	+= broadcom.o
 obj-$(CONFIG_BCM63XX_PHY)	+= bcm63xx.o
+obj-$(CONFIG_BCM87XX_PHY)	+= bcm87xx.o
 obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
 obj-$(CONFIG_REALTEK_PHY)	+= realtek.o
 obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
diff --git a/drivers/net/phy/bcm87xx.c b/drivers/net/phy/bcm87xx.c
new file mode 100644
index 0000000..b2f6a43
--- /dev/null
+++ b/drivers/net/phy/bcm87xx.c
@@ -0,0 +1,239 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 - 2012 Cavium, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/of.h>
+
+#define PHY_ID_BCM8706	0x0143bdc1
+#define PHY_ID_BCM8727	0x0143bff0
+
+#define BCM87XX_PMD_RX_SIGNAL_DETECT	(MII_ADDR_C45 | 0x1000a)
+#define BCM87XX_10GBASER_PCS_STATUS	(MII_ADDR_C45 | 0x30020)
+#define BCM87XX_XGXS_LANE_STATUS	(MII_ADDR_C45 | 0x40018)
+
+#define BCM87XX_LASI_CONTROL (MII_ADDR_C45 | 0x39002)
+#define BCM87XX_LASI_STATUS (MII_ADDR_C45 | 0x39005)
+
+#if IS_ENABLED(CONFIG_OF_MDIO)
+/*
+ * Set and/or override some configuration registers based on the
+ * marvell,reg-init property stored in the of_node for the phydev.
+ *
+ * broadcom,c45-reg-init = <devid reg mask value>,...;
+ *
+ * There may be one or more sets of <devid reg mask value>:
+ *
+ * devid: which sub-device to use.
+ * reg: the register.
+ * mask: if non-zero, ANDed with existing register value.
+ * value: ORed with the masked value and written to the regiser.
+ *
+ */
+static int bcm87xx_of_reg_init(struct phy_device *phydev)
+{
+	const __be32 *paddr;
+	const __be32 *paddr_end;
+	int len, ret;
+
+	if (!phydev->dev.of_node)
+		return 0;
+
+	paddr = of_get_property(phydev->dev.of_node,
+				"broadcom,c45-reg-init", &len);
+	if (!paddr)
+		return 0;
+
+	paddr_end = paddr + (len /= sizeof(*paddr));
+
+	ret = 0;
+
+	while (paddr + 3 < paddr_end) {
+		u16 devid	= be32_to_cpup(paddr++);
+		u16 reg		= be32_to_cpup(paddr++);
+		u16 mask	= be32_to_cpup(paddr++);
+		u16 val_bits	= be32_to_cpup(paddr++);
+		int val;
+		u32 regnum = MII_ADDR_C45 | (devid << 16) | reg;
+		val = 0;
+		if (mask) {
+			val = phy_read(phydev, regnum);
+			if (val < 0) {
+				ret = val;
+				goto err;
+			}
+			val &= mask;
+		}
+		val |= val_bits;
+
+		ret = phy_write(phydev, regnum, val);
+		if (ret < 0)
+			goto err;
+	}
+err:
+	return ret;
+}
+#else
+static int bcm87xx_of_reg_init(struct phy_device *phydev)
+{
+	return 0;
+}
+#endif /* CONFIG_OF_MDIO */
+
+static int bcm87xx_config_init(struct phy_device *phydev)
+{
+	phydev->supported = SUPPORTED_10000baseR_FEC;
+	phydev->advertising = ADVERTISED_10000baseR_FEC;
+	phydev->state = PHY_NOLINK;
+
+	bcm87xx_of_reg_init(phydev);
+
+	return 0;
+}
+
+static int bcm87xx_config_aneg(struct phy_device *phydev)
+{
+	return -EINVAL;
+}
+
+static int bcm87xx_read_status(struct phy_device *phydev)
+{
+	int rx_signal_detect;
+	int pcs_status;
+	int xgxs_lane_status;
+
+	rx_signal_detect = phy_read(phydev, BCM87XX_PMD_RX_SIGNAL_DETECT);
+	if (rx_signal_detect < 0)
+		return rx_signal_detect;
+
+	if ((rx_signal_detect & 1) == 0)
+		goto no_link;
+
+	pcs_status = phy_read(phydev, BCM87XX_10GBASER_PCS_STATUS);
+	if (pcs_status < 0)
+		return pcs_status;
+
+	if ((pcs_status & 1) == 0)
+		goto no_link;
+
+	xgxs_lane_status = phy_read(phydev, BCM87XX_XGXS_LANE_STATUS);
+	if (xgxs_lane_status < 0)
+		return xgxs_lane_status;
+
+	if ((xgxs_lane_status & 0x1000) == 0)
+		goto no_link;
+
+	phydev->speed = 10000;
+	phydev->link = 1;
+	phydev->duplex = 1;
+	return 0;
+
+no_link:
+	phydev->link = 0;
+	return 0;
+}
+
+static int bcm87xx_config_intr(struct phy_device *phydev)
+{
+	int reg, err;
+
+	reg = phy_read(phydev, BCM87XX_LASI_CONTROL);
+
+	if (reg < 0)
+		return reg;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
+		reg |= 1;
+	else
+		reg &= ~1;
+
+	err = phy_write(phydev, BCM87XX_LASI_CONTROL, reg);
+	return err;
+}
+
+static int bcm87xx_did_interrupt(struct phy_device *phydev)
+{
+	int reg;
+
+	reg = phy_read(phydev, BCM87XX_LASI_STATUS);
+
+	if (reg < 0) {
+		dev_err(&phydev->dev,
+			"Error: Read of BCM87XX_LASI_STATUS failed: %d\n", reg);
+		return 0;
+	}
+	return (reg & 1) != 0;
+}
+
+static int bcm87xx_ack_interrupt(struct phy_device *phydev)
+{
+	/* Reading the LASI status clears it. */
+	bcm87xx_did_interrupt(phydev);
+	return 0;
+}
+
+static int bcm8706_match_phy_device(struct phy_device *phydev)
+{
+	return phydev->c45_ids.device_ids[4] == PHY_ID_BCM8706;
+}
+
+static int bcm8727_match_phy_device(struct phy_device *phydev)
+{
+	return phydev->c45_ids.device_ids[4] == PHY_ID_BCM8727;
+}
+
+static struct phy_driver bcm8706_driver = {
+	.phy_id		= PHY_ID_BCM8706,
+	.phy_id_mask	= 0xffffffff,
+	.name		= "Broadcom BCM8706",
+	.flags		= PHY_HAS_INTERRUPT,
+	.config_init	= bcm87xx_config_init,
+	.config_aneg	= bcm87xx_config_aneg,
+	.read_status	= bcm87xx_read_status,
+	.ack_interrupt	= bcm87xx_ack_interrupt,
+	.config_intr	= bcm87xx_config_intr,
+	.did_interrupt	= bcm87xx_did_interrupt,
+	.match_phy_device = bcm8706_match_phy_device,
+	.driver		= { .owner = THIS_MODULE },
+};
+
+static struct phy_driver bcm8727_driver = {
+	.phy_id		= PHY_ID_BCM8727,
+	.phy_id_mask	= 0xffffffff,
+	.name		= "Broadcom BCM8727",
+	.flags		= PHY_HAS_INTERRUPT,
+	.config_init	= bcm87xx_config_init,
+	.config_aneg	= bcm87xx_config_aneg,
+	.read_status	= bcm87xx_read_status,
+	.ack_interrupt	= bcm87xx_ack_interrupt,
+	.config_intr	= bcm87xx_config_intr,
+	.did_interrupt	= bcm87xx_did_interrupt,
+	.match_phy_device = bcm8727_match_phy_device,
+	.driver		= { .owner = THIS_MODULE },
+};
+
+static int __init bcm87xx_init(void)
+{
+	int ret;
+
+	ret = phy_driver_register(&bcm8706_driver);
+	if (ret)
+		goto err;
+
+	ret = phy_driver_register(&bcm8727_driver);
+err:
+	return ret;
+}
+module_init(bcm87xx_init);
+
+static void __exit bcm87xx_exit(void)
+{
+	phy_driver_unregister(&bcm8706_driver);
+	phy_driver_unregister(&bcm8727_driver);
+}
+module_exit(bcm87xx_exit);
-- 
1.7.2.3
