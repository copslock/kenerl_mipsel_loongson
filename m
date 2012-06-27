Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2012 19:34:44 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:39900 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903538Ab2F0Rdx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jun 2012 19:33:53 +0200
Received: by pbbrq13 with SMTP id rq13so2007114pbb.36
        for <linux-mips@linux-mips.org>; Wed, 27 Jun 2012 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vDa35CzVm5XoNgAU/xcejOgqchvbna6O5gzY9xU+F98=;
        b=z04NGPLWowqPJ4gXCqujapo4WJqIG1xNt3NNnsfzDg9LTf4WqLiFzaajkn2neX6WEx
         PIJ2Fuy/KFUMctrekfjnSvxv/jj3YXi4ewdELpzdFBNg67WCWWwKCq2uA5tDayJ5iyDy
         +NkqLdf4M0FSXtHK1ATj7cs8En2TLE+EotR3j63Hj/KmehHGd2gvZV9RaHN4GwTuEpyO
         APPhg/7iD5FaXWZYzf/x7n0bB7Zj1OPj4pA69X1JpqgmsF4K3g8402oUu3o7Zx+i0uYP
         0gq9npmcueLCexWV4dZEOZWORKchp1ZCAPX2LiHvT0apsXT9rbCcaUV6tGUxusd4SOR6
         SNpA==
Received: by 10.68.218.101 with SMTP id pf5mr65223457pbc.152.1340818427024;
        Wed, 27 Jun 2012 10:33:47 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id hw6sm15733873pbc.73.2012.06.27.10.33.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 10:33:45 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q5RHXhCP010433;
        Wed, 27 Jun 2012 10:33:43 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q5RHXhiF010432;
        Wed, 27 Jun 2012 10:33:43 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 4/4] netdev/phy: Add driver for Broadcom BCM87XX 10G Ethernet PHYs
Date:   Wed, 27 Jun 2012 10:33:38 -0700
Message-Id: <1340818418-10382-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1340818418-10382-1-git-send-email-ddaney.cavm@gmail.com>
References: <1340818418-10382-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33857
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
 drivers/net/phy/bcm87xx.c                          |  238 ++++++++++++++++++++
 4 files changed, 273 insertions(+), 0 deletions(-)
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
index 0000000..f5f0562
--- /dev/null
+++ b/drivers/net/phy/bcm87xx.c
@@ -0,0 +1,238 @@
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
+/* Set and/or override some configuration registers based on the
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
