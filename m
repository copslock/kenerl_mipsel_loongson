Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2011 22:02:30 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15618 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491882Ab1HaUB4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2011 22:01:56 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e5e93790001>; Wed, 31 Aug 2011 13:03:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 31 Aug 2011 13:01:54 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 31 Aug 2011 13:01:54 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p7VK1qJK014044;
        Wed, 31 Aug 2011 13:01:52 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p7VK1pNe014043;
        Wed, 31 Aug 2011 13:01:51 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 1/3] netdev/of/phy: New function: of_mdio_find_bus().
Date:   Wed, 31 Aug 2011 13:01:44 -0700
Message-Id: <1314820906-14004-2-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1314820906-14004-1-git-send-email-david.daney@cavium.com>
References: <1314820906-14004-1-git-send-email-david.daney@cavium.com>
X-OriginalArrivalTime: 31 Aug 2011 20:01:54.0218 (UTC) FILETIME=[D498A8A0:01CC6818]
X-archive-position: 31022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 23645

Add of_mdio_find_bus() which allows an mii_bus to be located given its
associated the device tree node.

This is needed by the follow-on patch to add a driver for MDIO bus
multiplexers.

The of_mdiobus_register() function is modified so that the device tree
node is recorded in the mii_bus.  Then we can find it again by
iterating over all mdio_bus_class devices.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: "David S. Miller" <davem@davemloft.net>
---
 drivers/net/phy/mdio_bus.c |    3 ++-
 drivers/of/of_mdio.c       |   26 ++++++++++++++++++++++++++
 include/linux/of_mdio.h    |    2 ++
 include/linux/phy.h        |    1 +
 4 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 6c58da2..227a060 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -70,10 +70,11 @@ static void mdiobus_release(struct device *d)
 	kfree(bus);
 }
 
-static struct class mdio_bus_class = {
+struct class mdio_bus_class = {
 	.name		= "mdio_bus",
 	.dev_release	= mdiobus_release,
 };
+EXPORT_SYMBOL(mdio_bus_class);
 
 /**
  * mdiobus_register - bring up all the PHYs on a given bus and attach them to bus
diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index d35e300..7c28e8c 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -45,6 +45,8 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 		for (i=0; i<PHY_MAX_ADDR; i++)
 			mdio->irq[i] = PHY_POLL;
 
+	mdio->dev.of_node = np;
+
 	/* Register the MDIO bus */
 	rc = mdiobus_register(mdio);
 	if (rc)
@@ -189,3 +191,27 @@ struct phy_device *of_phy_connect_fixed_link(struct net_device *dev,
 	return IS_ERR(phy) ? NULL : phy;
 }
 EXPORT_SYMBOL(of_phy_connect_fixed_link);
+
+/**
+ * of_mdio_find_bus - Given an mii_bus node, find the mii_bus.
+ * @mdio_np: Pointer to the mii_bus.
+ *
+ * Returns a pointer to the mii_bus, or NULL if none found.
+ *
+ * Because the association of a device_node and mii_bus is made via
+ * of_mdiobus_register(), the mii_bus cannot be found before it is
+ * registered with of_mdiobus_register().
+ *
+ */
+struct mii_bus *of_mdio_find_bus(struct device_node *mdio_np)
+{
+	struct device *d;
+
+	if (!mdio_np)
+		return NULL;
+
+	d = class_find_device(&mdio_bus_class, NULL,  mdio_np, of_phy_match);
+
+	return d ? to_mii_bus(d) : NULL;
+}
+EXPORT_SYMBOL(of_mdio_find_bus);
diff --git a/include/linux/of_mdio.h b/include/linux/of_mdio.h
index 53b94e0..912c27a 100644
--- a/include/linux/of_mdio.h
+++ b/include/linux/of_mdio.h
@@ -22,4 +22,6 @@ extern struct phy_device *of_phy_connect_fixed_link(struct net_device *dev,
 					 void (*hndlr)(struct net_device *),
 					 phy_interface_t iface);
 
+extern struct mii_bus *of_mdio_find_bus(struct device_node *mdio_np);
+
 #endif /* __LINUX_OF_MDIO_H */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 54fc413..e4c3844 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -528,4 +528,5 @@ int __init mdio_bus_init(void);
 void mdio_bus_exit(void);
 
 extern struct bus_type mdio_bus_type;
+extern struct class mdio_bus_class;
 #endif /* __PHY_H */
-- 
1.7.2.3
