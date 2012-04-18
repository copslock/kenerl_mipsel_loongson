Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2012 01:21:22 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34373 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903732Ab2DRXVI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2012 01:21:08 +0200
Received: by obcni5 with SMTP id ni5so3717459obc.36
        for <linux-mips@linux-mips.org>; Wed, 18 Apr 2012 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=f1XsdDH2buwlYx70tDvzncmiNhdpCE9ME1w9owTEiFs=;
        b=wez7V9RmDJU07iJx0fQurPIxsNouCBcHOcqrUxqTxtSUisAVjEf7qUfqPnYPJEgf0G
         hZZ/YBV87BUBTSS19B6SXa24E0stA92BRoMqsOXzwfY9FR7Y8JeHpLkVedU8C5zU4Pes
         OCAntAMeBgT8i8sfnR5mtFKZO8FE3MuaTqoG7RiPvUEwTA9syNusczeK4WYcuNCw2F+z
         I/wV4GHnCDZDFQuRo18v87g0AfFWfcZ2hMpgMSxCxjQifuP618wSSUKmGE6fs5D3DEgh
         3tXd6OM8jdM+Yu0dfU1tlZLCnGN5x8j16inVZTf91QcZlRJXCDqdKAC5oREgViJA64gV
         XRng==
Received: by 10.182.86.200 with SMTP id r8mr5927782obz.20.1334791262270;
        Wed, 18 Apr 2012 16:21:02 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id m3sm442260oem.7.2012.04.18.16.21.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 16:21:00 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3INKxPk016034;
        Wed, 18 Apr 2012 16:20:59 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3INKxdu016033;
        Wed, 18 Apr 2012 16:20:59 -0700
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
Subject: [PATCH v5 1/3] netdev/of/phy: New function: of_mdio_find_bus().
Date:   Wed, 18 Apr 2012 16:20:52 -0700
Message-Id: <1334791254-15987-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1334791254-15987-1-git-send-email-ddaney.cavm@gmail.com>
References: <1334791254-15987-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32966
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
