Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 19:10:31 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
	(ralf@eddie.linux-mips.org)) by ftp.linux-mips.org id S1491877AbZGARHL
	for <"|/home/ecartis/ecartis -s linux-mips">;
	Wed, 1 Jul 2009 19:07:11 +0200
Message-Id: <20090701120940.096077223@linux-mips.org>
User-Agent: quilt/0.47-1
Date:	Wed, 01 Jul 2009 12:29:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Cc:	Maxime Bizon <mbizon@freebox.fr>,
	Florian Fainelli <florian@openwrt.org>
Subject: [patch 10/12] MIPS: BCM63XX: Add integrated ethernet PHY support for phylib.
References: <20090701112926.825088732@linux-mips.org>
Content-Disposition: inline; filename=0010.patch
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-archive-position: 23576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From:	Maxime Bizon <mbizon@freebox.fr>

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/net/phy/Kconfig   |    6 ++
 drivers/net/phy/Makefile  |    1 
 drivers/net/phy/bcm63xx.c |  132 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 drivers/net/phy/bcm63xx.c

--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -56,6 +56,12 @@ config BROADCOM_PHY
 	  Currently supports the BCM5411, BCM5421, BCM5461, BCM5464, BCM5481
 	  and BCM5482 PHYs.
 
+config BCM63XX_PHY
+	tristate "Drivers for Broadcom 63xx SOCs internal PHY"
+	depends on BCM63XX
+	---help---
+	  Currently supports the 6348 and 6358 PHYs.
+
 config ICPLUS_PHY
 	tristate "Drivers for ICPlus PHYs"
 	---help---
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
 obj-$(CONFIG_SMSC_PHY)		+= smsc.o
 obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
 obj-$(CONFIG_BROADCOM_PHY)	+= broadcom.o
+obj-$(CONFIG_BCM63XX_PHY)	+= bcm63xx.o
 obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
 obj-$(CONFIG_REALTEK_PHY)	+= realtek.o
 obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
--- /dev/null
+++ b/drivers/net/phy/bcm63xx.c
@@ -0,0 +1,132 @@
+/*
+ *	Driver for Broadcom 63xx SOCs integrated PHYs
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+#include <linux/module.h>
+#include <linux/phy.h>
+
+#define MII_BCM63XX_IR		0x1a	/* interrupt register */
+#define MII_BCM63XX_IR_EN	0x4000	/* global interrupt enable */
+#define MII_BCM63XX_IR_DUPLEX	0x0800	/* duplex changed */
+#define MII_BCM63XX_IR_SPEED	0x0400	/* speed changed */
+#define MII_BCM63XX_IR_LINK	0x0200	/* link changed */
+#define MII_BCM63XX_IR_GMASK	0x0100	/* global interrupt mask */
+
+MODULE_DESCRIPTION("Broadcom 63xx internal PHY driver");
+MODULE_AUTHOR("Maxime Bizon <mbizon@freebox.fr>");
+MODULE_LICENSE("GPL");
+
+static int bcm63xx_config_init(struct phy_device *phydev)
+{
+	int reg, err;
+
+	reg = phy_read(phydev, MII_BCM63XX_IR);
+	if (reg < 0)
+		return reg;
+
+	/* Mask interrupts globally.  */
+	reg |= MII_BCM63XX_IR_GMASK;
+	err = phy_write(phydev, MII_BCM63XX_IR, reg);
+	if (err < 0)
+		return err;
+
+	/* Unmask events we are interested in  */
+	reg = ~(MII_BCM63XX_IR_DUPLEX |
+		MII_BCM63XX_IR_SPEED |
+		MII_BCM63XX_IR_LINK) |
+		MII_BCM63XX_IR_EN;
+	err = phy_write(phydev, MII_BCM63XX_IR, reg);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static int bcm63xx_ack_interrupt(struct phy_device *phydev)
+{
+	int reg;
+
+	/* Clear pending interrupts.  */
+	reg = phy_read(phydev, MII_BCM63XX_IR);
+	if (reg < 0)
+		return reg;
+
+	return 0;
+}
+
+static int bcm63xx_config_intr(struct phy_device *phydev)
+{
+	int reg, err;
+
+	reg = phy_read(phydev, MII_BCM63XX_IR);
+	if (reg < 0)
+		return reg;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
+		reg &= ~MII_BCM63XX_IR_GMASK;
+	else
+		reg |= MII_BCM63XX_IR_GMASK;
+
+	err = phy_write(phydev, MII_BCM63XX_IR, reg);
+	return err;
+}
+
+static struct phy_driver bcm63xx_1_driver = {
+	.phy_id		= 0x00406000,
+	.phy_id_mask	= 0xfffffc00,
+	.name		= "Broadcom BCM63XX (1)",
+	/* ASYM_PAUSE bit is marked RO in datasheet, so don't cheat */
+	.features	= (PHY_BASIC_FEATURES | SUPPORTED_Pause),
+	.flags		= PHY_HAS_INTERRUPT,
+	.config_init	= bcm63xx_config_init,
+	.config_aneg	= genphy_config_aneg,
+	.read_status	= genphy_read_status,
+	.ack_interrupt	= bcm63xx_ack_interrupt,
+	.config_intr	= bcm63xx_config_intr,
+	.driver		= { .owner = THIS_MODULE },
+};
+
+/* same phy as above, with just a different OUI */
+static struct phy_driver bcm63xx_2_driver = {
+	.phy_id		= 0x002bdc00,
+	.phy_id_mask	= 0xfffffc00,
+	.name		= "Broadcom BCM63XX (2)",
+	.features	= (PHY_BASIC_FEATURES | SUPPORTED_Pause),
+	.flags		= PHY_HAS_INTERRUPT,
+	.config_init	= bcm63xx_config_init,
+	.config_aneg	= genphy_config_aneg,
+	.read_status	= genphy_read_status,
+	.ack_interrupt	= bcm63xx_ack_interrupt,
+	.config_intr	= bcm63xx_config_intr,
+	.driver		= { .owner = THIS_MODULE },
+};
+
+static int __init bcm63xx_phy_init(void)
+{
+	int ret;
+
+	ret = phy_driver_register(&bcm63xx_1_driver);
+	if (ret)
+		goto out_63xx_1;
+	ret = phy_driver_register(&bcm63xx_2_driver);
+	if (ret)
+		goto out_63xx_2;
+	return ret;
+
+out_63xx_2:
+	phy_driver_unregister(&bcm63xx_1_driver);
+out_63xx_1:
+	return ret;
+}
+
+static void __exit bcm63xx_phy_exit(void)
+{
+	phy_driver_unregister(&bcm63xx_1_driver);
+	phy_driver_unregister(&bcm63xx_2_driver);
+}
+
+module_init(bcm63xx_phy_init);
+module_exit(bcm63xx_phy_exit);
