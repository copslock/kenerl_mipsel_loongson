Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2012 19:34:36 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:45610 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903724Ab2DQRdP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2012 19:33:15 +0200
Received: by obcni5 with SMTP id ni5so1455733obc.36
        for <linux-mips@linux-mips.org>; Tue, 17 Apr 2012 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=f1XsdDH2buwlYx70tDvzncmiNhdpCE9ME1w9owTEiFs=;
        b=X7yiWpYcOCYNdNjDZ63IfmEn0jj4ZPtjCugDfb1JhtGSf9XPi5nf5CDe9p4TCajlhz
         /NW9XdcHlOpWl9Ic/q5gPnSDgpPzexmdWFLJSC5RU8bcty6bhg6OOqW9mP9816HxYeoL
         FA3/XcGj7furxqzQA0ChD9MJedsioSbE29Rcoc4Gh3Ad8hnjrBGfT9o4jEOlhN9iHJwW
         4E+rf0UYynQKQUW52YwiSlnZs8TY+zUBpsigk9kVCoZ5FaA3Y8c8L+gC2EXIm1qRASDR
         X/6npH/KkhimdkJncP10jedcyECyMzSbsSq8pKoDfDnQi16jw5UrxfLa+U9lwakd3AL/
         Z9tA==
Received: by 10.182.152.72 with SMTP id uw8mr9015419obb.73.1334683989676;
        Tue, 17 Apr 2012 10:33:09 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id k2sm23768476obl.14.2012.04.17.10.33.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 10:33:07 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3HHX15H012151;
        Tue, 17 Apr 2012 10:33:01 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3HHX1VZ012150;
        Tue, 17 Apr 2012 10:33:01 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, galak@kernel.crashing.org,
        David Daney <david.daney@cavium.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 1/3] netdev/of/phy: New function: of_mdio_find_bus().
Date:   Tue, 17 Apr 2012 10:32:44 -0700
Message-Id: <1334683966-12112-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1334683966-12112-1-git-send-email-ddaney.cavm@gmail.com>
References: <1334683966-12112-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32955
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
