Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 May 2012 03:17:30 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:61693 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903781Ab2ECBQy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 May 2012 03:16:54 +0200
Received: by pbbrq13 with SMTP id rq13so1938041pbb.36
        for <multiple recipients>; Wed, 02 May 2012 18:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=f1XsdDH2buwlYx70tDvzncmiNhdpCE9ME1w9owTEiFs=;
        b=PLwU5v2oteyU5VXRyV3epJsDe+lGWHHvc7h0Pdjj9KdcgtgLmyiaSzU7jlvpVjuYl3
         mCckKe1ImxZpn4yRZq1s9NJfYKlVjHrr4ZjEAv6x62nruJGJZP23fnhiNvT7PNteS1oT
         rNgU4bkrJnPltW4AatUHHUS+jsC6+UTotdqnpMcd7IRYDYM3BXizBd7TQTagjsX5AWvg
         t6wDPsnu342pw8uV+0imbDZ5V31OKVl9ZIjz8BCWFGN+SSwIWFPruLaehSPO+gOIUtSW
         dZHFdl6MCS6gKw4bt8h9kogpCaiT5a8VNeSODgecEzpUp4va2fl/EH5teeHZs9q6fhhM
         N3wQ==
Received: by 10.68.219.162 with SMTP id pp2mr2268735pbc.85.1336007807758;
        Wed, 02 May 2012 18:16:47 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id vn10sm3535461pbc.43.2012.05.02.18.16.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 18:16:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q431GidS031056;
        Wed, 2 May 2012 18:16:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q431GiYU031055;
        Wed, 2 May 2012 18:16:44 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, galak@kernel.crashing.org,
        David Daney <david.daney@cavium.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v6 1/3] netdev/of/phy: New function: of_mdio_find_bus().
Date:   Wed,  2 May 2012 18:16:37 -0700
Message-Id: <1336007799-31016-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1336007799-31016-1-git-send-email-ddaney.cavm@gmail.com>
References: <1336007799-31016-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Add of_mdio_find_bus() which allows an mii_bus to be located given its
associated the device tree node.

This is needed by the follow-on patch to add a driver for MDIO bus
multiplexers.

The of_mdiobus_register() function is modified so that the device tree
node is recorded in the mii_bus.  Then we can find it again by
iterating over all mdio_bus_class devices.

Because the OF device tree has now become an integral part of the
kernel, this can live in mdio_bus.c (which contains the needed
mdio_bus_class structure) instead of of_mdio.c.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: "David S. Miller" <davem@davemloft.net>
---
 drivers/net/phy/mdio_bus.c |   32 ++++++++++++++++++++++++++++++++
 drivers/of/of_mdio.c       |    2 ++
 include/linux/of_mdio.h    |    2 ++
 3 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 8985cc6..83d5c9f 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -88,6 +88,38 @@ static struct class mdio_bus_class = {
 	.dev_release	= mdiobus_release,
 };
 
+#ifdef CONFIG_OF_MDIO
+/* Helper function for of_mdio_find_bus */
+static int of_mdio_bus_match(struct device *dev, void *mdio_bus_np)
+{
+	return dev->of_node == mdio_bus_np;
+}
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
+struct mii_bus *of_mdio_find_bus(struct device_node *mdio_bus_np)
+{
+	struct device *d;
+
+	if (!mdio_bus_np)
+		return NULL;
+
+	d = class_find_device(&mdio_bus_class, NULL,  mdio_bus_np,
+			      of_mdio_bus_match);
+
+	return d ? to_mii_bus(d) : NULL;
+}
+EXPORT_SYMBOL(of_mdio_find_bus);
+#endif
+
 /**
  * mdiobus_register - bring up all the PHYs on a given bus and attach them to bus
  * @bus: target mii_bus
diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 483c0ad..2574abd 100644
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
-- 
1.7.2.3
