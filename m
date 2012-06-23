Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 02:25:19 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:54747 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903720Ab2FWAYa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jun 2012 02:24:30 +0200
Received: by pbbrq13 with SMTP id rq13so4499343pbb.36
        for <linux-mips@linux-mips.org>; Fri, 22 Jun 2012 17:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3+YpELTNibueQjxMQyg1ycmQMMcJKbBjQw0C7GfWCqU=;
        b=kwbNu35JLPHzPiDWH/FFiZGPY4Qoaj7lgXH+xA+89mGiVHIQ4i2lfa+x6dq8WC+k8m
         lC1KlzuGKHT9JCWrWmx7QswoG9Z5UbVjRrExtsjT/d+fB3rJLC4KAzO4Hix2NSWpHxtQ
         zMcfCrMRk0961fXygX6ysR0v8yzhbJRMODuteWryRaDauEBArci8Fo+DE2e4i3ibORzY
         VK9XaqmogqLPoCwhXXx/LDzggf6Ybn4qBs85cd2WHV4gHj+aY64nT8WDOH1sAo0Lavli
         DT50e/GEuuID8WEjyMKLhzRGREAXKg1sP8lFu8FZTvHazT1jH3d1eA9qjX2BYNDnXJUE
         sgBg==
Received: by 10.68.222.38 with SMTP id qj6mr15696283pbc.6.1340411064174;
        Fri, 22 Jun 2012 17:24:24 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pg3sm625967pbc.2.2012.06.22.17.24.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 17:24:22 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q5N0OKaC019037;
        Fri, 22 Jun 2012 17:24:20 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q5N0OKkX019036;
        Fri, 22 Jun 2012 17:24:20 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, David Daney <david.daney@cavium.com>
Subject: [PATCH 3/4] netdev/phy/of: Add more methods for binding PHY devices to drivers.
Date:   Fri, 22 Jun 2012 17:24:15 -0700
Message-Id: <1340411056-18988-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1340411056-18988-1-git-send-email-ddaney.cavm@gmail.com>
References: <1340411056-18988-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33785
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

Allow PHY drivers to supply their own device matching function
(match_phy_device()), or to be matched OF compatible properties.

PHYs following IEEE802.3 clause 45 have more than one device
identifier constants, which breaks the default device matching code.
Other 10G PHYs don't follow the standard manufacturer/device
identifier register layout standards, but they do use the standard
MDIO bus protocols for register access.  Both of these require
adjustments to the PHY driver to device matching code.

If the there is an of_node associated with such a PHY, we can match it
to its driver using the "compatible" properties, just as we do with
certain platform devices.  If the "compatible" property match fails,
first check if there is a driver supplied matching function, and if
not fall back to the existing identifier matching rules.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/phy/mdio_bus.c |    7 +++++++
 include/linux/phy.h        |    7 +++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 31470b0..9a283b4 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/of_device.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
@@ -308,6 +309,12 @@ static int mdio_bus_match(struct device *dev, struct device_driver *drv)
 	struct phy_device *phydev = to_phy_device(dev);
 	struct phy_driver *phydrv = to_phy_driver(drv);
 
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	if (phydrv->match_phy_device)
+		return phydrv->match_phy_device(phydev);
+
 	return ((phydrv->phy_id & phydrv->phy_id_mask) ==
 		(phydev->phy_id & phydrv->phy_id_mask));
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 92d53ee..bbd9e7f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -434,6 +434,13 @@ struct phy_driver {
 	/* Handles ethtool queries for hardware time stamping. */
 	int (*ts_info)(struct phy_device *phydev, struct ethtool_ts_info *ti);
 
+	/*
+	 * Returns true if this is a suitable driver for the given
+	 * phydev.  If NULL, matching is based on phy_id and
+	 * phy_id_mask.
+	 */
+	int (*match_phy_device)(struct phy_device *phydev);
+
 	/* Handles SIOCSHWTSTAMP ioctl for hardware time stamping. */
 	int  (*hwtstamp)(struct phy_device *phydev, struct ifreq *ifr);
 
-- 
1.7.2.3
