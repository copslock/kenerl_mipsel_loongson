Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2012 02:30:11 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:59826 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903664Ab2C0A2Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2012 02:28:16 +0200
Received: by obbup16 with SMTP id up16so7096740obb.36
        for <multiple recipients>; Mon, 26 Mar 2012 17:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tLR0KW2smBeSYvHQAUhYoAt0OBzGjH+pn6MgNHD42I4=;
        b=SZzsJFj7NB1QTZM+IaShN3rVrqoZUlAt2Izy6KqDqTBTvMDz0kC3Tc/UvLZ9Vtsf+A
         OozUVjFAZUc8GAogd5O6dFfCc4/G35EOKDrOILfbDfWasvQrN0qMvRKeJ3DNWL65HOYw
         2hKAMisZMROYtgCqkLStEz2nEBQ/Sj7Px54XQGofZbIDA5T6br0t20AyHGywONkDZkfc
         rtgC+UNqR7RXCyMSKAWYUgjn7yxD+KFYQ7J4z7hceuv431a233MRdaYLRNM9Wrer30/7
         S9VuX8KX2eLgNuEf+SRVzKygfauUWv7RPyVdU2aGr1HoiZj8LSJoMSBES3kc2/yezuka
         9KBA==
Received: by 10.60.18.197 with SMTP id y5mr29539205oed.58.1332808090326;
        Mon, 26 Mar 2012 17:28:10 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id yw3sm17984054obb.7.2012.03.26.17.28.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 17:28:08 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q2R0S7CY008385;
        Mon, 26 Mar 2012 17:28:07 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q2R0S7jS008384;
        Mon, 26 Mar 2012 17:28:07 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/5] staging: octeon_ethernet: Convert to use device tree.
Date:   Mon, 26 Mar 2012 17:27:54 -0700
Message-Id: <1332808075-8333-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1332808075-8333-1-git-send-email-ddaney.cavm@gmail.com>
References: <1332808075-8333-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Get MAC address and PHY connection from the device tree.  The driver
is converted to a platform driver.

Cc: netdev@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Daney <david.daney@cavium.com>
---

Should probably go via Ralf's linux-mips.org tree.

 drivers/staging/octeon/ethernet-mdio.c   |   28 +++---
 drivers/staging/octeon/ethernet.c        |  153 +++++++++++++++++++-----------
 drivers/staging/octeon/octeon-ethernet.h |    3 +
 3 files changed, 117 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index e31949c..f15b31b 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -28,6 +28,7 @@
 #include <linux/ethtool.h>
 #include <linux/phy.h>
 #include <linux/ratelimit.h>
+#include <linux/of_mdio.h>
 
 #include <net/dst.h>
 
@@ -161,22 +162,23 @@ static void cvm_oct_adjust_link(struct net_device *dev)
 int cvm_oct_phy_setup_device(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
+	struct device_node *phy_node;
 
-	int phy_addr = cvmx_helper_board_get_mii_address(priv->port);
-	if (phy_addr != -1) {
-		char phy_id[MII_BUS_ID_SIZE + 3];
+	if (!priv->of_node)
+		return 0;
 
-		snprintf(phy_id, sizeof(phy_id), PHY_ID_FMT, "mdio-octeon-0", phy_addr);
+	phy_node = of_parse_phandle(priv->of_node, "phy-handle", 0);
+	if (!phy_node)
+		return 0;
 
-		priv->phydev = phy_connect(dev, phy_id, cvm_oct_adjust_link, 0,
-					PHY_INTERFACE_MODE_GMII);
+	priv->phydev = of_phy_connect(dev, phy_node, cvm_oct_adjust_link, 0,
+				      PHY_INTERFACE_MODE_GMII);
+
+	if (priv->phydev == NULL)
+		return -ENODEV;
+
+	priv->last_link = 0;
+	phy_start_aneg(priv->phydev);
 
-		if (IS_ERR(priv->phydev)) {
-			priv->phydev = NULL;
-			return -1;
-		}
-		priv->last_link = 0;
-		phy_start_aneg(priv->phydev);
-	}
 	return 0;
 }
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9112cd8..7df97fc 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -24,6 +24,7 @@
  * This file may also be available under a different license from Cavium.
  * Contact Cavium Networks for more information
 **********************************************************************/
+#include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -31,6 +32,7 @@
 #include <linux/etherdevice.h>
 #include <linux/phy.h>
 #include <linux/slab.h>
+#include <linux/of_net.h>
 
 #include <net/dst.h>
 
@@ -112,15 +114,6 @@ int rx_napi_weight = 32;
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
@@ -175,7 +168,7 @@ static void cvm_oct_periodic_worker(struct work_struct *work)
 		queue_delayed_work(cvm_oct_poll_queue, &priv->port_periodic_work, HZ);
  }
 
-static __init void cvm_oct_configure_common_hw(void)
+static __devinit void cvm_oct_configure_common_hw(void)
 {
 	/* Setup the FPA */
 	cvmx_fpa_enable();
@@ -395,23 +388,21 @@ static void cvm_oct_common_set_multicast_list(struct net_device *dev)
 
  * Returns Zero on success
  */
-static int cvm_oct_common_set_mac_address(struct net_device *dev, void *addr)
+static int cvm_oct_set_mac_filter(struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
 	union cvmx_gmxx_prtx_cfg gmx_cfg;
 	int interface = INTERFACE(priv->port);
 	int index = INDEX(priv->port);
 
-	memcpy(dev->dev_addr, addr + 2, 6);
-
 	if ((interface < 2)
 	    && (cvmx_helper_interface_get_mode(interface) !=
 		CVMX_HELPER_INTERFACE_MODE_SPI)) {
 		int i;
-		uint8_t *ptr = addr;
+		uint8_t *ptr = dev->dev_addr;
 		uint64_t mac = 0;
 		for (i = 0; i < 6; i++)
-			mac = (mac << 8) | (uint64_t) (ptr[i + 2]);
+			mac = (mac << 8) | (uint64_t)ptr[i];
 
 		gmx_cfg.u64 =
 		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(index, interface));
@@ -420,17 +411,17 @@ static int cvm_oct_common_set_mac_address(struct net_device *dev, void *addr)
 
 		cvmx_write_csr(CVMX_GMXX_SMACX(index, interface), mac);
 		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM0(index, interface),
-			       ptr[2]);
+			       ptr[0]);
 		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM1(index, interface),
-			       ptr[3]);
+			       ptr[1]);
 		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM2(index, interface),
-			       ptr[4]);
+			       ptr[2]);
 		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM3(index, interface),
-			       ptr[5]);
+			       ptr[3]);
 		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM4(index, interface),
-			       ptr[6]);
+			       ptr[4]);
 		cvmx_write_csr(CVMX_GMXX_RXX_ADR_CAM5(index, interface),
-			       ptr[7]);
+			       ptr[5]);
 		cvm_oct_common_set_multicast_list(dev);
 		cvmx_write_csr(CVMX_GMXX_PRTX_CFG(index, interface),
 			       gmx_cfg.u64);
@@ -438,6 +429,15 @@ static int cvm_oct_common_set_mac_address(struct net_device *dev, void *addr)
 	return 0;
 }
 
+static int cvm_oct_common_set_mac_address(struct net_device *dev, void *addr)
+{
+	int r = eth_mac_addr(dev, addr);
+
+	if (r)
+		return r;
+	return cvm_oct_set_mac_filter(dev);
+}
+
 /**
  * cvm_oct_common_init - per network device initialization
  * @dev:    Device to initialize
@@ -447,26 +447,17 @@ static int cvm_oct_common_set_mac_address(struct net_device *dev, void *addr)
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
+	const u8 *mac = NULL;
+
+	if (priv->of_node)
+		mac = of_get_mac_address(priv->of_node);
+
+	if (mac && is_valid_ether_addr(mac)) {
+		memcpy(dev->dev_addr, mac, ETH_ALEN);
+		dev->addr_assign_type &= ~NET_ADDR_RANDOM;
+	} else {
+		eth_hw_addr_random(dev);
+	}
 
 	/*
 	 * Force the interface to use the POW send if always_use_pow
@@ -487,7 +478,7 @@ int cvm_oct_common_init(struct net_device *dev)
 	SET_ETHTOOL_OPS(dev, &cvm_oct_ethtool_ops);
 
 	cvm_oct_phy_setup_device(dev);
-	dev->netdev_ops->ndo_set_mac_address(dev, &sa);
+	cvm_oct_set_mac_filter(dev);
 	dev->netdev_ops->ndo_change_mtu(dev, dev->mtu);
 
 	/*
@@ -594,22 +585,55 @@ static const struct net_device_ops cvm_oct_pow_netdev_ops = {
 
 extern void octeon_mdiobus_force_mod_depencency(void);
 
-static int __init cvm_oct_init_module(void)
+static struct device_node * __devinit cvm_oct_of_get_child(const struct device_node *parent,
+							   int reg_val)
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
+static struct device_node * __devinit cvm_oct_node_for_port(struct device_node *pip,
+							    int interface, int port)
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
+static int __devinit cvm_oct_probe(struct platform_device *pdev)
 {
 	int num_interfaces;
 	int interface;
 	int fau = FAU_NUM_PACKET_BUFFERS_TO_FREE;
 	int qos;
+	struct device_node *pip;
 
 	octeon_mdiobus_force_mod_depencency();
 	pr_notice("cavium-ethernet %s\n", OCTEON_ETHERNET_VERSION);
 
-	if (OCTEON_IS_MODEL(OCTEON_CN52XX))
-		cvm_oct_mac_addr_offset = 2; /* First two are the mgmt ports. */
-	else if (OCTEON_IS_MODEL(OCTEON_CN56XX))
-		cvm_oct_mac_addr_offset = 1; /* First one is the mgmt port. */
-	else
-		cvm_oct_mac_addr_offset = 0;
+	pip = pdev->dev.of_node;
+	if (!pip) {
+		pr_err("Error: No 'pip' in /aliases\n");
+		return -EINVAL;
+	}
 
 	cvm_oct_poll_queue = create_singlethread_workqueue("octeon-ethernet");
 	if (cvm_oct_poll_queue == NULL) {
@@ -688,10 +712,11 @@ static int __init cvm_oct_init_module(void)
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
@@ -702,6 +727,7 @@ static int __init cvm_oct_init_module(void)
 
 			/* Initialize the device private structure. */
 			priv = netdev_priv(dev);
+			priv->of_node = cvm_oct_node_for_port(pip, interface, port_index);
 
 			INIT_DELAYED_WORK(&priv->port_periodic_work,
 					  cvm_oct_periodic_worker);
@@ -786,7 +812,7 @@ static int __init cvm_oct_init_module(void)
 	return 0;
 }
 
-static void __exit cvm_oct_cleanup_module(void)
+static int __devexit cvm_oct_remove(struct platform_device *pdev)
 {
 	int port;
 
@@ -834,10 +860,29 @@ static void __exit cvm_oct_cleanup_module(void)
 	if (CVMX_FPA_OUTPUT_BUFFER_POOL != CVMX_FPA_PACKET_POOL)
 		cvm_oct_mem_empty_fpa(CVMX_FPA_OUTPUT_BUFFER_POOL,
 				      CVMX_FPA_OUTPUT_BUFFER_POOL_SIZE, 128);
+	return 0;
 }
 
+static struct of_device_id cvm_oct_match[] = {
+	{
+		.compatible = "cavium,octeon-3860-pip",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, cvm_oct_match);
+
+static struct platform_driver cvm_oct_driver = {
+	.probe		= cvm_oct_probe,
+	.remove		= __devexit_p(cvm_oct_remove),
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= KBUILD_MODNAME,
+		.of_match_table = cvm_oct_match,
+	},
+};
+
+module_platform_driver(cvm_oct_driver);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Cavium Networks <support@caviumnetworks.com>");
 MODULE_DESCRIPTION("Cavium Networks Octeon ethernet driver.");
-module_init(cvm_oct_init_module);
-module_exit(cvm_oct_cleanup_module);
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
