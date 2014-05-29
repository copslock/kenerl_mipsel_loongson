Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 12:10:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50364 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821742AbaE2KKanIGv- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 12:10:30 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7E1ECB2E88AC7;
        Thu, 29 May 2014 11:10:20 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 29 May
 2014 11:10:22 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 11:10:22 +0100
Received: from asmith-linux.le.imgtec.org (192.168.154.62) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 11:10:21 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        <devel@driverdev.osuosl.org>
Subject: [PATCH 2/3] staging: octeon-ethernet: Move PHY activation to .ndo_open().
Date:   Thu, 29 May 2014 11:10:02 +0100
Message-ID: <1401358203-60225-3-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401358203-60225-1-git-send-email-alex.smith@imgtec.com>
References: <1401358203-60225-1-git-send-email-alex.smith@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.62]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

This prevents PHY not found types of errors for PHY drivers that are
probed after the Ethernet driver is probed, because the ifconfig UP is
done from userspace after all drivers have been probed.

Also avoid the cvmx-helper-board.c PHY code if a real PHY driver is
present, this allows a bootloader supplied device tree to specify the
PHY information rather than having to modify the code for each
different board.

Tested-by: Alex Smith <alex.smith@imgtec.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Cc: devel@driverdev.osuosl.org
---
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    | 12 ++-
 drivers/staging/octeon/ethernet-mdio.c             | 79 ++++++++++++++------
 drivers/staging/octeon/ethernet-rgmii.c            | 23 ++++--
 drivers/staging/octeon/ethernet-sgmii.c            | 87 +++++++++++++---------
 drivers/staging/octeon/ethernet-xaui.c             | 83 +++++++++++++--------
 drivers/staging/octeon/ethernet.c                  |  2 +-
 drivers/staging/octeon/octeon-ethernet.h           |  4 +
 7 files changed, 189 insertions(+), 101 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index 45f18cc..6f9609e 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -317,10 +317,14 @@ static int __cvmx_helper_sgmii_hardware_init(int interface, int num_ports)
 	for (index = 0; index < num_ports; index++) {
 		int ipd_port = cvmx_helper_get_ipd_port(interface, index);
 		__cvmx_helper_sgmii_hardware_init_one_time(interface, index);
-		__cvmx_helper_sgmii_link_set(ipd_port,
-					     __cvmx_helper_sgmii_link_get
-					     (ipd_port));
-
+		/* Linux kernel driver will call ....link_set with the
+		 * proper link state. In the simulator there is no
+		 * link state polling and hence it is set from
+		 * here.
+		 */
+		if (cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_SIM)
+			__cvmx_helper_sgmii_link_set(ipd_port,
+				       __cvmx_helper_sgmii_link_get(ipd_port));
 	}
 
 	return 0;
diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index 3f067f1..ebfa9c9 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -116,7 +116,34 @@ int cvm_oct_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	return phy_mii_ioctl(priv->phydev, rq, cmd);
 }
 
-static void cvm_oct_adjust_link(struct net_device *dev)
+static void cvm_oct_note_carrier(struct octeon_ethernet *priv,
+				 cvmx_helper_link_info_t li)
+{
+	if (li.s.link_up) {
+		pr_notice_ratelimited("%s: %u Mbps %s duplex, port %d\n",
+				      netdev_name(priv->netdev), li.s.speed,
+				      (li.s.full_duplex) ? "Full" : "Half",
+				      priv->port);
+	} else {
+		pr_notice_ratelimited("%s: Link down\n",
+				      netdev_name(priv->netdev));
+	}
+}
+
+void cvm_oct_set_carrier(struct octeon_ethernet *priv,
+			 cvmx_helper_link_info_t link_info)
+{
+	cvm_oct_note_carrier(priv, link_info);
+	if (link_info.s.link_up) {
+		if (!netif_carrier_ok(priv->netdev))
+			netif_carrier_on(priv->netdev);
+	} else {
+		if (netif_carrier_ok(priv->netdev))
+			netif_carrier_off(priv->netdev);
+	}
+}
+
+void cvm_oct_adjust_link(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
 	cvmx_helper_link_info_t link_info;
@@ -127,28 +154,32 @@ static void cvm_oct_adjust_link(struct net_device *dev)
 		link_info.s.link_up = priv->last_link ? 1 : 0;
 		link_info.s.full_duplex = priv->phydev->duplex ? 1 : 0;
 		link_info.s.speed = priv->phydev->speed;
+
 		cvmx_helper_link_set(priv->port, link_info);
-		if (priv->last_link) {
-			netif_carrier_on(dev);
-			if (priv->queue != -1)
-				printk_ratelimited("%s: %u Mbps %s duplex, "
-					"port %2d, queue %2d\n", dev->name,
-					priv->phydev->speed,
-					priv->phydev->duplex ? "Full" : "Half",
-					priv->port, priv->queue);
-			else
-				printk_ratelimited("%s: %u Mbps %s duplex, "
-					"port %2d, POW\n", dev->name,
-					priv->phydev->speed,
-					priv->phydev->duplex ? "Full" : "Half",
-					priv->port);
-		} else {
-			netif_carrier_off(dev);
-			printk_ratelimited("%s: Link down\n", dev->name);
-		}
+		cvm_oct_note_carrier(priv, link_info);
 	}
 }
 
+int cvm_oct_common_stop(struct net_device *dev)
+{
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	cvmx_helper_link_info_t link_info;
+
+	priv->poll = NULL;
+
+	if (priv->phydev)
+		phy_disconnect(priv->phydev);
+	priv->phydev = NULL;
+
+	if (priv->last_link) {
+		link_info.u64 = 0;
+		priv->last_link = 0;
+
+		cvmx_helper_link_set(priv->port, link_info);
+		cvm_oct_note_carrier(priv, link_info);
+	}
+	return 0;
+}
 
 /**
  * cvm_oct_phy_setup_device - setup the PHY
@@ -163,11 +194,11 @@ int cvm_oct_phy_setup_device(struct net_device *dev)
 	struct device_node *phy_node;
 
 	if (!priv->of_node)
-		return 0;
+		goto no_phy;
 
 	phy_node = of_parse_phandle(priv->of_node, "phy-handle", 0);
 	if (!phy_node)
-		return 0;
+		goto no_phy;
 
 	priv->phydev = of_phy_connect(dev, phy_node, cvm_oct_adjust_link, 0,
 				      PHY_INTERFACE_MODE_GMII);
@@ -179,4 +210,10 @@ int cvm_oct_phy_setup_device(struct net_device *dev)
 	phy_start_aneg(priv->phydev);
 
 	return 0;
+no_phy:
+	/* If there is no phy, assume a direct MAC connection and that
+	 * the link is up.
+	 */
+	netif_carrier_on(dev);
+	return 0;
 }
diff --git a/drivers/staging/octeon/ethernet-rgmii.c b/drivers/staging/octeon/ethernet-rgmii.c
index 0ec0da3..651be7e 100644
--- a/drivers/staging/octeon/ethernet-rgmii.c
+++ b/drivers/staging/octeon/ethernet-rgmii.c
@@ -36,6 +36,7 @@
 #include "ethernet-defines.h"
 #include "octeon-ethernet.h"
 #include "ethernet-util.h"
+#include "ethernet-mdio.h"
 
 #include <asm/octeon/cvmx-helper.h>
 
@@ -302,15 +303,28 @@ int cvm_oct_rgmii_open(struct net_device *dev)
 	int interface = INTERFACE(priv->port);
 	int index = INDEX(priv->port);
 	cvmx_helper_link_info_t link_info;
+	int rv;
+
+	rv = cvm_oct_phy_setup_device(dev);
+	if (rv)
+		return rv;
 
 	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
 	gmx_cfg.s.en = 1;
 	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
 
 	if (!octeon_is_simulation()) {
-		link_info = cvmx_helper_link_get(priv->port);
-		if (!link_info.s.link_up)
-			netif_carrier_off(dev);
+		if (priv->phydev) {
+			int r = phy_read_status(priv->phydev);
+			if (r == 0 && priv->phydev->link == 0)
+				netif_carrier_off(dev);
+			cvm_oct_adjust_link(dev);
+		} else {
+			link_info = cvmx_helper_link_get(priv->port);
+			if (!link_info.s.link_up)
+				netif_carrier_off(dev);
+			priv->poll = cvm_oct_rgmii_poll;
+		}
 	}
 
 	return 0;
@@ -326,7 +340,7 @@ int cvm_oct_rgmii_stop(struct net_device *dev)
 	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
 	gmx_cfg.s.en = 0;
 	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
-	return 0;
+	return cvm_oct_common_stop(dev);
 }
 
 static void cvm_oct_rgmii_immediate_poll(struct work_struct *work)
@@ -384,7 +398,6 @@ int cvm_oct_rgmii_init(struct net_device *dev)
 			gmx_rx_int_en.s.phy_spd = 1;
 			cvmx_write_csr(CVMX_GMXX_RXX_INT_EN(index, interface),
 				       gmx_rx_int_en.u64);
-			priv->poll = cvm_oct_rgmii_poll;
 		}
 	}
 
diff --git a/drivers/staging/octeon/ethernet-sgmii.c b/drivers/staging/octeon/ethernet-sgmii.c
index d3e8243..e187844 100644
--- a/drivers/staging/octeon/ethernet-sgmii.c
+++ b/drivers/staging/octeon/ethernet-sgmii.c
@@ -24,6 +24,7 @@
  * This file may also be available under a different license from Cavium.
  * Contact Cavium Networks for more information
 **********************************************************************/
+#include <linux/phy.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/ratelimit.h>
@@ -34,45 +35,12 @@
 #include "ethernet-defines.h"
 #include "octeon-ethernet.h"
 #include "ethernet-util.h"
+#include "ethernet-mdio.h"
 
 #include <asm/octeon/cvmx-helper.h>
 
 #include <asm/octeon/cvmx-gmxx-defs.h>
 
-int cvm_oct_sgmii_open(struct net_device *dev)
-{
-	union cvmx_gmxx_prtx_cfg gmx_cfg;
-	struct octeon_ethernet *priv = netdev_priv(dev);
-	int interface = INTERFACE(priv->port);
-	int index = INDEX(priv->port);
-	cvmx_helper_link_info_t link_info;
-
-	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
-	gmx_cfg.s.en = 1;
-	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
-
-	if (!octeon_is_simulation()) {
-		link_info = cvmx_helper_link_get(priv->port);
-		if (!link_info.s.link_up)
-			netif_carrier_off(dev);
-	}
-
-	return 0;
-}
-
-int cvm_oct_sgmii_stop(struct net_device *dev)
-{
-	union cvmx_gmxx_prtx_cfg gmx_cfg;
-	struct octeon_ethernet *priv = netdev_priv(dev);
-	int interface = INTERFACE(priv->port);
-	int index = INDEX(priv->port);
-
-	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
-	gmx_cfg.s.en = 0;
-	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
-	return 0;
-}
-
 static void cvm_oct_sgmii_poll(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
@@ -109,13 +77,58 @@ static void cvm_oct_sgmii_poll(struct net_device *dev)
 	}
 }
 
-int cvm_oct_sgmii_init(struct net_device *dev)
+int cvm_oct_sgmii_open(struct net_device *dev)
 {
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
 	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+	cvmx_helper_link_info_t link_info;
+	int rv;
+
+	rv = cvm_oct_phy_setup_device(dev);
+	if (rv)
+		return rv;
+
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	gmx_cfg.s.en = 1;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+
+	if (octeon_is_simulation())
+		return 0;
+
+	if (priv->phydev) {
+		int r = phy_read_status(priv->phydev);
+		if (r == 0 && priv->phydev->link == 0)
+			netif_carrier_off(dev);
+		cvm_oct_adjust_link(dev);
+	} else {
+		link_info = cvmx_helper_link_get(priv->port);
+		if (!link_info.s.link_up)
+			netif_carrier_off(dev);
+		priv->poll = cvm_oct_sgmii_poll;
+		cvm_oct_sgmii_poll(dev);
+	}
+	return 0;
+}
+
+int cvm_oct_sgmii_stop(struct net_device *dev)
+{
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	gmx_cfg.s.en = 0;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+	return cvm_oct_common_stop(dev);
+}
+
+int cvm_oct_sgmii_init(struct net_device *dev)
+{
 	cvm_oct_common_init(dev);
 	dev->netdev_ops->ndo_stop(dev);
-	if (!octeon_is_simulation() && priv->phydev == NULL)
-		priv->poll = cvm_oct_sgmii_poll;
 
 	/* FIXME: Need autoneg logic */
 	return 0;
diff --git a/drivers/staging/octeon/ethernet-xaui.c b/drivers/staging/octeon/ethernet-xaui.c
index 419f8c3..20b3533 100644
--- a/drivers/staging/octeon/ethernet-xaui.c
+++ b/drivers/staging/octeon/ethernet-xaui.c
@@ -24,6 +24,7 @@
  * This file may also be available under a different license from Cavium.
  * Contact Cavium Networks for more information
 **********************************************************************/
+#include <linux/phy.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/ratelimit.h>
@@ -34,44 +35,12 @@
 #include "ethernet-defines.h"
 #include "octeon-ethernet.h"
 #include "ethernet-util.h"
+#include "ethernet-mdio.h"
 
 #include <asm/octeon/cvmx-helper.h>
 
 #include <asm/octeon/cvmx-gmxx-defs.h>
 
-int cvm_oct_xaui_open(struct net_device *dev)
-{
-	union cvmx_gmxx_prtx_cfg gmx_cfg;
-	struct octeon_ethernet *priv = netdev_priv(dev);
-	int interface = INTERFACE(priv->port);
-	int index = INDEX(priv->port);
-	cvmx_helper_link_info_t link_info;
-
-	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
-	gmx_cfg.s.en = 1;
-	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
-
-	if (!octeon_is_simulation()) {
-		link_info = cvmx_helper_link_get(priv->port);
-		if (!link_info.s.link_up)
-			netif_carrier_off(dev);
-	}
-	return 0;
-}
-
-int cvm_oct_xaui_stop(struct net_device *dev)
-{
-	union cvmx_gmxx_prtx_cfg gmx_cfg;
-	struct octeon_ethernet *priv = netdev_priv(dev);
-	int interface = INTERFACE(priv->port);
-	int index = INDEX(priv->port);
-
-	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
-	gmx_cfg.s.en = 0;
-	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
-	return 0;
-}
-
 static void cvm_oct_xaui_poll(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
@@ -108,6 +77,54 @@ static void cvm_oct_xaui_poll(struct net_device *dev)
 	}
 }
 
+int cvm_oct_xaui_open(struct net_device *dev)
+{
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+	cvmx_helper_link_info_t link_info;
+	int rv;
+
+	rv = cvm_oct_phy_setup_device(dev);
+	if (rv)
+		return rv;
+
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	gmx_cfg.s.en = 1;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+
+	if (octeon_is_simulation())
+		return 0;
+
+	if (priv->phydev) {
+		int r = phy_read_status(priv->phydev);
+		if (r == 0 && priv->phydev->link == 0)
+			netif_carrier_off(dev);
+		cvm_oct_adjust_link(dev);
+	} else {
+		link_info = cvmx_helper_link_get(priv->port);
+		if (!link_info.s.link_up)
+			netif_carrier_off(dev);
+		priv->poll = cvm_oct_xaui_poll;
+		cvm_oct_xaui_poll(dev);
+	}
+	return 0;
+}
+
+int cvm_oct_xaui_stop(struct net_device *dev)
+{
+	union cvmx_gmxx_prtx_cfg gmx_cfg;
+	struct octeon_ethernet *priv = netdev_priv(dev);
+	int interface = INTERFACE(priv->port);
+	int index = INDEX(priv->port);
+
+	gmx_cfg.u64 = cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
+	gmx_cfg.s.en = 0;
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface), gmx_cfg.u64);
+	return cvm_oct_common_stop(dev);
+}
+
 int cvm_oct_xaui_init(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index da9dd6b..2aa7235 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -471,7 +471,6 @@ int cvm_oct_common_init(struct net_device *dev)
 	dev->features |= NETIF_F_LLTX;
 	dev->ethtool_ops = &cvm_oct_ethtool_ops;
 
-	cvm_oct_phy_setup_device(dev);
 	cvm_oct_set_mac_filter(dev);
 	dev->netdev_ops->ndo_change_mtu(dev, dev->mtu);
 
@@ -722,6 +721,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 
 			/* Initialize the device private structure. */
 			priv = netdev_priv(dev);
+			priv->netdev = dev;
 			priv->of_node = cvm_oct_node_for_port(pip, interface,
 								port_index);
 
diff --git a/drivers/staging/octeon/octeon-ethernet.h b/drivers/staging/octeon/octeon-ethernet.h
index 4cf3884..d0e3211 100644
--- a/drivers/staging/octeon/octeon-ethernet.h
+++ b/drivers/staging/octeon/octeon-ethernet.h
@@ -44,6 +44,8 @@ struct octeon_ethernet {
 	int queue;
 	/* Hardware fetch and add to count outstanding tx buffers */
 	int fau;
+	/* My netdev. */
+	struct net_device *netdev;
 	/*
 	 * Type of port. This is one of the enums in
 	 * cvmx_helper_interface_mode_t
@@ -85,6 +87,8 @@ extern int cvm_oct_xaui_stop(struct net_device *dev);
 
 extern int cvm_oct_common_init(struct net_device *dev);
 extern void cvm_oct_common_uninit(struct net_device *dev);
+void cvm_oct_adjust_link(struct net_device *dev);
+int cvm_oct_common_stop(struct net_device *dev);
 
 extern int always_use_pow;
 extern int pow_send_group;
-- 
1.9.3
