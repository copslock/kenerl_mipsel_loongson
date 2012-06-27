Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2012 19:34:20 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:56994 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903535Ab2F0Rdx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jun 2012 19:33:53 +0200
Received: by pbbrq13 with SMTP id rq13so2007107pbb.36
        for <linux-mips@linux-mips.org>; Wed, 27 Jun 2012 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DUWniNWFVY2E8hrPFhTE7j9lX2LRjrXCbtpqlgVDkt0=;
        b=YhdD2A5oN7zO1Q6nCmbnWhAINieiwnAOttFnHyIxXJtk/GVKviJ7qh9MDoS+4jcUrV
         6+9dGeeqSzoyQg3OWM2yxkyJXwmziVgEMXbMVQ6GyXJnx8rqhsMkI4y4c8XRPQEiXpL3
         dGwBwq5u1jbfWfc4Q1CmIQumkXYG7uNbUNcwVtJY28V6DLJ1MM6DXdBrXt+Q6VtensGR
         HhfjVkpro4d1Cc/OwXU6zprulikj3RQdV9sod/sdbQPS5QZrjGmCVYhnYbkO/ZWDeMt4
         H3hT+2BoUPCMWsl5QC7wjwLsZ26kH3A9CUHkyseItxHC9WKuZ228bVVqBQtya4PlyePb
         MgVQ==
Received: by 10.68.213.7 with SMTP id no7mr66571160pbc.3.1340818426523;
        Wed, 27 Jun 2012 10:33:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id op10sm15732314pbc.75.2012.06.27.10.33.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 10:33:45 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q5RHXhMU010425;
        Wed, 27 Jun 2012 10:33:43 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q5RHXhjH010424;
        Wed, 27 Jun 2012 10:33:43 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 2/4] netdev/phy/of: Handle IEEE802.3 clause 45 Ethernet PHYs in of_mdiobus_register()
Date:   Wed, 27 Jun 2012 10:33:36 -0700
Message-Id: <1340818418-10382-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1340818418-10382-1-git-send-email-ddaney.cavm@gmail.com>
References: <1340818418-10382-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33856
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
 drivers/of/of_mdio.c                          |   16 ++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

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
index 6c24cad..8e6c25f 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -57,6 +57,7 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 		const __be32 *paddr;
 		u32 addr;
 		int len;
+		bool is_c45;
 
 		/* A PHY must have a reg property in the range [0-31] */
 		paddr = of_get_property(child, "reg", &len);
@@ -79,11 +80,18 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 				mdio->irq[addr] = PHY_POLL;
 		}
 
-		phy = get_phy_device(mdio, addr, false);
+		is_c45 = of_device_is_compatible(child,
+						 "ethernet-phy-ieee802.3-c45");
+		phy = get_phy_device(mdio, addr, is_c45);
+
 		if (!phy || IS_ERR(phy)) {
-			dev_err(&mdio->dev, "error probing PHY at address %i\n",
-				addr);
-			continue;
+			phy = phy_device_create(mdio, addr, 0, false, NULL);
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
