Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 02:24:57 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:53586 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903715Ab2FWAYa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jun 2012 02:24:30 +0200
Received: by pbbrq13 with SMTP id rq13so4499338pbb.36
        for <linux-mips@linux-mips.org>; Fri, 22 Jun 2012 17:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RHvqQy/RH49RjiILcFyOG//jPk+Bo2ykTpXQf47yTTk=;
        b=st2jxv54gHB2Na8I0EiaodzsSz9p1u7XJWp4Ev7DrGlvoYuwIR4YxcraPTX1d3CxM1
         lEqPQyomxeEftyLLsKPdeZt1jlmwg+x0mviJeJ6Vaoqn+crB6FCxOZVjgDDxXc5r46YQ
         wKx+vYtRwIy8E8kJeLAsTSCoUtYlmxa/wtIGuu2IFIi2szNy5UghWddJSwxlUo/U7fW3
         aLepABNbjrrvJoCV3K2VD7aaQJyHBmUwcT3ufLAw+/ZwJcKCZ1K0ZyqzybKVS6893zW+
         dhiJIpnu8Y3ORSO5A04aI7Y1kmQyPkoOvt2h/E4+NZysw0eSJuA/vH2XIddOBopXuRaS
         Zq4w==
Received: by 10.68.217.166 with SMTP id oz6mr14912505pbc.136.1340411063849;
        Fri, 22 Jun 2012 17:24:23 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id jw3sm603184pbc.65.2012.06.22.17.24.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 17:24:22 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q5N0OKSJ019033;
        Fri, 22 Jun 2012 17:24:20 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q5N0OKuO019032;
        Fri, 22 Jun 2012 17:24:20 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, David Daney <david.daney@cavium.com>
Subject: [PATCH 2/4] netdev/phy/of: Handle IEEE802.3 clause 45 Ethernet PHYs in of_mdiobus_register()
Date:   Fri, 22 Jun 2012 17:24:14 -0700
Message-Id: <1340411056-18988-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1340411056-18988-1-git-send-email-ddaney.cavm@gmail.com>
References: <1340411056-18988-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33784
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

Define two new "compatible" values for Ethernet
PHYs. "ethernet-phy-ieee802.3-c22" and "ethernet-phy-ieee802.3-c45"
are used to indicate a PHY uses the corresponding protocol.

If a PHY is "compatible" with "ethernet-phy-ieee802.3-c45", we
indicate this so that get_phy_device() can properly probe the device.

If get_phy_device() fails, it was probably due to failing the probe of
the PHY identifier registers.  Since we have the device tree telling
us the PHY exists, go ahead and add it anyhow with a phy_id of zero.
There may be a driver match based on the "compatible" property.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 Documentation/devicetree/bindings/net/phy.txt |   12 +++++++++++-
 drivers/of/of_mdio.c                          |   14 +++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
index bb8c742..7cd18fb 100644
--- a/Documentation/devicetree/bindings/net/phy.txt
+++ b/Documentation/devicetree/bindings/net/phy.txt
@@ -14,10 +14,20 @@ Required properties:
  - linux,phandle :  phandle for this node; likely referenced by an
    ethernet controller node.
 
+Optional Properties:
+
+- compatible: Compatible list, may contain
+  "ethernet-phy-ieee802.3-c22" or "ethernet-phy-ieee802.3-c45" for
+  PHYs that implement IEEE802.3 clause 22 or IEEE802.3 clause 45
+  specifications. If neither of these are specified, the default is to
+  assume clause 22. The compatible list may also contain other
+  elements.
+
 Example:
 
 ethernet-phy@0 {
-	linux,phandle = <2452000>
+	compatible = "ethernet-phy-ieee802.3-c22";
+	linux,phandle = <2452000>;
 	interrupt-parent = <40000>;
 	interrupts = <35 1>;
 	reg = <0>;
diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 2574abd..0f08aaf 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -79,11 +79,19 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 				mdio->irq[addr] = PHY_POLL;
 		}
 
+		if (of_device_is_compatible(child,
+					    "ethernet-phy-ieee802.3-c45"))
+			addr |= MII_ADDR_C45;
+
 		phy = get_phy_device(mdio, addr);
 		if (!phy || IS_ERR(phy)) {
-			dev_err(&mdio->dev, "error probing PHY at address %i\n",
-				addr);
-			continue;
+			phy = phy_device_create(mdio, addr, 0, NULL);
+			if (!phy || IS_ERR(phy)) {
+				dev_err(&mdio->dev,
+					"error creating PHY at address %i\n",
+					addr);
+				continue;
+			}
 		}
 
 		/* Associate the OF node with the device structure so it
-- 
1.7.2.3
