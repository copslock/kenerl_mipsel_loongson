Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 11:35:22 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:44694 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993081AbeICJd7OedeW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Sep 2018 11:33:59 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 90E7D22A54; Mon,  3 Sep 2018 11:33:54 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5868D22A48;
        Mon,  3 Sep 2018 11:33:27 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v2 11/11] net: mscc: ocelot: make use of SerDes PHYs for handling their configuration
Date:   Mon,  3 Sep 2018 11:33:08 +0200
Message-Id: <20180903093308.24366-12-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903093308.24366-1-quentin.schulz@bootlin.com>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quentin.schulz@bootlin.com
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

Previously, the SerDes muxing was hardcoded to a given mode in the MAC
controller driver. Now, the SerDes muxing is configured within the
Device Tree and is enforced in the MAC controller driver so we can have
a lot of different SerDes configurations.

Make use of the SerDes PHYs in the MAC controller to set up the SerDes
according to the SerDes<->switch port mapping and the communication mode
with the Ethernet PHY.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/ethernet/mscc/Kconfig        |  2 +
 drivers/net/ethernet/mscc/ocelot.c       | 16 +++++++-
 drivers/net/ethernet/mscc/ocelot.h       |  5 +++
 drivers/net/ethernet/mscc/ocelot_board.c | 50 +++++++++++++++++++-----
 4 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mscc/Kconfig b/drivers/net/ethernet/mscc/Kconfig
index 36c84625d54e..bcec0587cf61 100644
--- a/drivers/net/ethernet/mscc/Kconfig
+++ b/drivers/net/ethernet/mscc/Kconfig
@@ -23,6 +23,8 @@ config MSCC_OCELOT_SWITCH
 config MSCC_OCELOT_SWITCH_OCELOT
 	tristate "Ocelot switch driver on Ocelot"
 	depends on MSCC_OCELOT_SWITCH
+	depends on GENERIC_PHY
+	depends on OF_NET
 	help
 	  This driver supports the Ocelot network switch device as present on
 	  the Ocelot SoCs.
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 1a4f2bb48ead..8f11fdba8d0e 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -472,6 +472,7 @@ static int ocelot_port_open(struct net_device *dev)
 {
 	struct ocelot_port *port = netdev_priv(dev);
 	struct ocelot *ocelot = port->ocelot;
+	enum phy_mode phy_mode;
 	int err;
 
 	/* Enable receiving frames on the port, and activate auto-learning of
@@ -482,8 +483,21 @@ static int ocelot_port_open(struct net_device *dev)
 			 ANA_PORT_PORT_CFG_PORTID_VAL(port->chip_port),
 			 ANA_PORT_PORT_CFG, port->chip_port);
 
+	if (port->serdes) {
+		if (port->phy_mode == PHY_INTERFACE_MODE_SGMII)
+			phy_mode = PHY_MODE_SGMII;
+		else
+			phy_mode = PHY_MODE_QSGMII;
+
+		err = phy_set_mode(port->serdes, phy_mode);
+		if (err) {
+			netdev_err(dev, "Could not set mode of SerDes\n");
+			return err;
+		}
+	}
+
 	err = phy_connect_direct(dev, port->phy, &ocelot_port_adjust_link,
-				 PHY_INTERFACE_MODE_NA);
+				 port->phy_mode);
 	if (err) {
 		netdev_err(dev, "Could not attach to PHY\n");
 		return err;
diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index 3720e519cdd7..62c7c8eb00d9 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -11,6 +11,8 @@
 #include <linux/bitops.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
@@ -453,6 +455,9 @@ struct ocelot_port {
 	u8 vlan_aware;
 
 	u64 *stats;
+
+	phy_interface_t phy_mode;
+	struct phy *serdes;
 };
 
 u32 __ocelot_read_ix(struct ocelot *ocelot, u32 reg, u32 offset);
diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index b7d755b90117..a26a06e20770 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -6,6 +6,7 @@
  */
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of_net.h>
 #include <linux/netdevice.h>
 #include <linux/of_mdio.h>
 #include <linux/of_platform.h>
@@ -247,18 +248,12 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&ocelot->multicast);
 	ocelot_init(ocelot);
 
-	ocelot_rmw(ocelot, HSIO_HW_CFG_DEV1G_4_MODE |
-		     HSIO_HW_CFG_DEV1G_6_MODE |
-		     HSIO_HW_CFG_DEV1G_9_MODE,
-		     HSIO_HW_CFG_DEV1G_4_MODE |
-		     HSIO_HW_CFG_DEV1G_6_MODE |
-		     HSIO_HW_CFG_DEV1G_9_MODE,
-		     HSIO_HW_CFG);
-
 	for_each_available_child_of_node(ports, portnp) {
 		struct device_node *phy_node;
 		struct phy_device *phy;
 		struct resource *res;
+		struct phy *serdes;
+		enum phy_mode phy_mode;
 		void __iomem *regs;
 		char res_name[8];
 		u32 port;
@@ -283,10 +278,45 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 			continue;
 
 		err = ocelot_probe_port(ocelot, port, regs, phy);
-		if (err) {
-			dev_err(&pdev->dev, "failed to probe ports\n");
+		if (err)
+			return err;
+
+		err = of_get_phy_mode(portnp);
+		if (err < 0)
+			ocelot->ports[port]->phy_mode = PHY_INTERFACE_MODE_NA;
+		else
+			ocelot->ports[port]->phy_mode = err;
+
+		switch (ocelot->ports[port]->phy_mode) {
+		case PHY_INTERFACE_MODE_NA:
+			continue;
+		case PHY_INTERFACE_MODE_SGMII:
+			phy_mode = PHY_MODE_SGMII;
+			break;
+		case PHY_INTERFACE_MODE_QSGMII:
+			phy_mode = PHY_MODE_QSGMII;
+			break;
+		default:
+			dev_err(ocelot->dev,
+				"invalid phy mode for port%d, (Q)SGMII only\n",
+				port);
+			return -EINVAL;
+		}
+
+		serdes = devm_of_phy_get(ocelot->dev, portnp, NULL);
+		if (IS_ERR(serdes)) {
+			err = PTR_ERR(serdes);
+			if (err == -EPROBE_DEFER) {
+				dev_dbg(ocelot->dev, "deferring probe\n");
+				goto err_probe_ports;
+			}
+
+			dev_err(ocelot->dev, "missing SerDes phys for port%d\n",
+				port);
 			goto err_probe_ports;
 		}
+
+		ocelot->ports[port]->serdes = serdes;
 	}
 
 	register_netdevice_notifier(&ocelot_netdevice_nb);
-- 
2.17.1
