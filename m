Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2011 22:02:30 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14040 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491766Ab1BVU6b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Feb 2011 21:58:31 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d6423ab0000>; Tue, 22 Feb 2011 12:59:23 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 22 Feb 2011 12:58:30 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 22 Feb 2011 12:58:30 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p1MKwOYh020942;
        Tue, 22 Feb 2011 12:58:25 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p1MKwOHl020941;
        Tue, 22 Feb 2011 12:58:24 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [RFC PATCH 10/10] staging: octeon_ethernet: Convert to use device tree.
Date:   Tue, 22 Feb 2011 12:57:54 -0800
Message-Id: <1298408274-20856-11-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298408274-20856-1-git-send-email-ddaney@caviumnetworks.com>
References: <1298408274-20856-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 22 Feb 2011 20:58:30.0082 (UTC) FILETIME=[4233E220:01CBD2D3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Get MAC address and PHY connection from the device tree.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
---
 drivers/staging/octeon/ethernet-mdio.c   |   27 +++++----
 drivers/staging/octeon/ethernet.c        |  101 +++++++++++++++++++-----------
 drivers/staging/octeon/octeon-ethernet.h |    3 +
 3 files changed, 82 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index 0e5dab7..38a0153 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
+#include <linux/of_mdio.h>
 
 #include <net/dst.h>
 
@@ -162,22 +163,24 @@ static void cvm_oct_adjust_link(struct net_device *dev)
 int cvm_oct_phy_setup_device(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
+	struct device_node *phy_node;
 
-	int phy_addr = cvmx_helper_board_get_mii_address(priv->port);
-	if (phy_addr != -1) {
-		char phy_id[20];
+	if (!priv->of_node)
+		return 0;
 
-		snprintf(phy_id, sizeof(phy_id), PHY_ID_FMT, "0", phy_addr);
+	phy_node = of_parse_phandle(priv->of_node, "phy-handle", 0);
+	if (!phy_node)
+		return 0;
 
-		priv->phydev = phy_connect(dev, phy_id, cvm_oct_adjust_link, 0,
-					PHY_INTERFACE_MODE_GMII);
+	priv->phydev = of_phy_connect(dev, phy_node, cvm_oct_adjust_link, 0,
+				      PHY_INTERFACE_MODE_GMII);
 
-		if (IS_ERR(priv->phydev)) {
-			priv->phydev = NULL;
-			return -1;
-		}
-		priv->last_link = 0;
-		phy_start_aneg(priv->phydev);
+	if (IS_ERR(priv->phydev)) {
+		priv->phydev = NULL;
+		return -1;
 	}
+	priv->last_link = 0;
+	phy_start_aneg(priv->phydev);
+
 	return 0;
 }
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 042adf7..87f8956 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -31,6 +31,7 @@
 #include <linux/etherdevice.h>
 #include <linux/phy.h>
 #include <linux/slab.h>
+#include <linux/of_net.h>
 
 #include <net/dst.h>
 
@@ -112,15 +113,6 @@ int rx_napi_weight = 32;
 module_param(rx_napi_weight, int, 0444);
 MODULE_PARM_DESC(rx_napi_weight, "The NAPI WEIGHT parameter.");
 
-/*
- * The offset from mac_addr_base that should be used for the next port
- * that is configured.  By convention, if any mgmt ports exist on the
- * chip, they get the first mac addresses, The ports controlled by
- * this driver are numbered sequencially following any mgmt addresses
- * that may exist.
- */
-static unsigned int cvm_oct_mac_addr_offset;
-
 /**
  * cvm_oct_poll_queue - Workqueue for polling operations.
  */
@@ -447,26 +439,13 @@ static int cvm_oct_common_set_mac_address(struct net_device *dev, void *addr)
 int cvm_oct_common_init(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
-	struct sockaddr sa;
-	u64 mac = ((u64)(octeon_bootinfo->mac_addr_base[0] & 0xff) << 40) |
-		((u64)(octeon_bootinfo->mac_addr_base[1] & 0xff) << 32) |
-		((u64)(octeon_bootinfo->mac_addr_base[2] & 0xff) << 24) |
-		((u64)(octeon_bootinfo->mac_addr_base[3] & 0xff) << 16) |
-		((u64)(octeon_bootinfo->mac_addr_base[4] & 0xff) << 8) |
-		(u64)(octeon_bootinfo->mac_addr_base[5] & 0xff);
-
-	mac += cvm_oct_mac_addr_offset;
-	sa.sa_data[0] = (mac >> 40) & 0xff;
-	sa.sa_data[1] = (mac >> 32) & 0xff;
-	sa.sa_data[2] = (mac >> 24) & 0xff;
-	sa.sa_data[3] = (mac >> 16) & 0xff;
-	sa.sa_data[4] = (mac >> 8) & 0xff;
-	sa.sa_data[5] = mac & 0xff;
-
-	if (cvm_oct_mac_addr_offset >= octeon_bootinfo->mac_addr_count)
-		printk(KERN_DEBUG "%s: Using MAC outside of the assigned range:"
-			" %pM\n", dev->name, sa.sa_data);
-	cvm_oct_mac_addr_offset++;
+	struct sockaddr sa = {0};
+
+	if (priv->of_node) {
+		const u8 *mac = of_get_mac_address(priv->of_node);
+		if (mac)
+			memcpy(sa.sa_data, mac, 6);
+	}
 
 	/*
 	 * Force the interface to use the POW send if always_use_pow
@@ -594,22 +573,68 @@ static const struct net_device_ops cvm_oct_pow_netdev_ops = {
 
 extern void octeon_mdiobus_force_mod_depencency(void);
 
+static struct device_node * __init cvm_oct_of_get_child(const struct device_node *parent,
+							int reg_val)
+{
+	struct device_node *node = NULL;
+	int size;
+	const __be32 *addr;
+
+	for (;;) {
+		node = of_get_next_child(parent, node);
+		if (!node)
+			break;
+		addr = of_get_property(node, "reg", &size);
+		if (addr && (be32_to_cpu(*addr) == reg_val))
+			break;
+	}
+	return node;
+}
+
+static struct device_node * __init cvm_oct_node_for_port(struct device_node *pip,
+							 int interface, int port)
+{
+	struct device_node *ni, *np;
+
+	ni = cvm_oct_of_get_child(pip, interface);
+	if (!ni)
+		return NULL;
+
+	np = cvm_oct_of_get_child(ni, port);
+	of_node_put(ni);
+
+	return np;
+}
+
 static int __init cvm_oct_init_module(void)
 {
 	int num_interfaces;
 	int interface;
 	int fau = FAU_NUM_PACKET_BUFFERS_TO_FREE;
 	int qos;
+	struct device_node *aliases;
+	const char *node_path;
+	struct device_node *pip;
 
 	octeon_mdiobus_force_mod_depencency();
 	pr_notice("cavium-ethernet %s\n", OCTEON_ETHERNET_VERSION);
 
-	if (OCTEON_IS_MODEL(OCTEON_CN52XX))
-		cvm_oct_mac_addr_offset = 2; /* First two are the mgmt ports. */
-	else if (OCTEON_IS_MODEL(OCTEON_CN56XX))
-		cvm_oct_mac_addr_offset = 1; /* First one is the mgmt port. */
-	else
-		cvm_oct_mac_addr_offset = 0;
+
+	aliases = of_find_node_by_path("/aliases");
+	if (!aliases) {
+		pr_err("Error: No /aliases node in device tree.");
+		return -EINVAL;
+	}
+	node_path = of_get_property(aliases, "pip", NULL);
+	if (!node_path) {
+		pr_err("Error: No /aliases/pip node in device tree.");
+		return -EINVAL;
+	}
+	pip = of_find_node_by_path(node_path);
+	if (!pip) {
+		pr_err("Error: No %s in device tree.", node_path);
+		return -EINVAL;
+	}
 
 	cvm_oct_poll_queue = create_singlethread_workqueue("octeon-ethernet");
 	if (cvm_oct_poll_queue == NULL) {
@@ -688,10 +713,11 @@ static int __init cvm_oct_init_module(void)
 		    cvmx_helper_interface_get_mode(interface);
 		int num_ports = cvmx_helper_ports_on_interface(interface);
 		int port;
+		int port_index;
 
-		for (port = cvmx_helper_get_ipd_port(interface, 0);
+		for (port_index = 0, port = cvmx_helper_get_ipd_port(interface, 0);
 		     port < cvmx_helper_get_ipd_port(interface, num_ports);
-		     port++) {
+		     port_index++, port++) {
 			struct octeon_ethernet *priv;
 			struct net_device *dev =
 			    alloc_etherdev(sizeof(struct octeon_ethernet));
@@ -702,6 +728,7 @@ static int __init cvm_oct_init_module(void)
 
 			/* Initialize the device private structure. */
 			priv = netdev_priv(dev);
+			priv->of_node = cvm_oct_node_for_port(pip, interface, port_index);
 
 			INIT_DELAYED_WORK(&priv->port_periodic_work,
 					  cvm_oct_periodic_worker);
diff --git a/drivers/staging/octeon/octeon-ethernet.h b/drivers/staging/octeon/octeon-ethernet.h
index d581925..9360e22 100644
--- a/drivers/staging/octeon/octeon-ethernet.h
+++ b/drivers/staging/octeon/octeon-ethernet.h
@@ -31,6 +31,8 @@
 #ifndef OCTEON_ETHERNET_H
 #define OCTEON_ETHERNET_H
 
+#include <linux/of.h>
+
 /**
  * This is the definition of the Ethernet driver's private
  * driver state stored in netdev_priv(dev).
@@ -59,6 +61,7 @@ struct octeon_ethernet {
 	void (*poll) (struct net_device *dev);
 	struct delayed_work	port_periodic_work;
 	struct work_struct	port_work;	/* may be unused. */
+	struct device_node	*of_node;
 };
 
 int cvm_oct_free_work(void *work_queue_entry);
-- 
1.7.2.3
