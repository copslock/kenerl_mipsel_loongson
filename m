Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2012 19:33:57 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:57357 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903526Ab2F0Rdx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jun 2012 19:33:53 +0200
Received: by dadm1 with SMTP id m1so1815729dad.36
        for <linux-mips@linux-mips.org>; Wed, 27 Jun 2012 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gn7HDYoGeSbO/9VTUS6sbjRBk/UFKNU1DOtBSZWqaAM=;
        b=XkERzRkbM5VJBNQ4xJQ2G85rlFRIJdbVhRPL8wFRWjRFxAbgBSWYHIt6ZrDapfXjAg
         hs+bdcorC9w9+Cbo+Z0A6FHWsOzzy2g+iE90CraL4U5TF3T7gC/F7O6bqNpxED3XXTP+
         I6G+/M4775O8+w17QV4bLpBLXjhWFdylZAR1rAUdtyNn0XFblpGNvktsR/GYvxCgGaNR
         EiiDO0uJmAl6ULbo106Mk+JyMk+nCbCRJkcnEs8UCXzOqJFwqaEhzCyHnopCogDR/6CV
         Df+YL5VOkZCZ2XOrllcMTDJniTVGt72DGU+HzYWtJfrAFGcr8WhwPU3/jjQbWgQCEHN/
         hcyA==
Received: by 10.68.225.170 with SMTP id rl10mr65916541pbc.13.1340818426674;
        Wed, 27 Jun 2012 10:33:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ql3sm15733466pbc.72.2012.06.27.10.33.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 10:33:45 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q5RHXhSD010429;
        Wed, 27 Jun 2012 10:33:43 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q5RHXh7J010428;
        Wed, 27 Jun 2012 10:33:43 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 3/4] netdev/phy/of: Add more methods for binding PHY devices to drivers.
Date:   Wed, 27 Jun 2012 10:33:37 -0700
Message-Id: <1340818418-10382-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1340818418-10382-1-git-send-email-ddaney.cavm@gmail.com>
References: <1340818418-10382-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33855
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
 include/linux/phy.h        |    6 ++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 2cee6d2..170eb41 100644
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
index 597d05d..7eac80a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -426,6 +426,12 @@ struct phy_driver {
 	/* Clears up any memory if needed */
 	void (*remove)(struct phy_device *phydev);
 
+	/* Returns true if this is a suitable driver for the given
+	 * phydev.  If NULL, matching is based on phy_id and
+	 * phy_id_mask.
+	 */
+	int (*match_phy_device)(struct phy_device *phydev);
+
 	/* Handles ethtool queries for hardware time stamping. */
 	int (*ts_info)(struct phy_device *phydev, struct ethtool_ts_info *ti);
 
-- 
1.7.2.3
