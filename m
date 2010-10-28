Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Oct 2010 03:04:04 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4410 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490978Ab0J1BEB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Oct 2010 03:04:01 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cc8cc240000>; Wed, 27 Oct 2010 18:04:36 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 27 Oct 2010 18:04:27 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 27 Oct 2010 18:04:27 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o9S13qrj005480;
        Wed, 27 Oct 2010 18:03:52 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o9S13oYp005479;
        Wed, 27 Oct 2010 18:03:50 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Jeremy Kerr <jeremy.kerr@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dan Carpenter <error27@gmail.com>,
        Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] of: of_mdio: Fix some endianness problems.
Date:   Wed, 27 Oct 2010 18:03:47 -0700
Message-Id: <1288227827-5447-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 28 Oct 2010 01:04:27.0075 (UTC) FILETIME=[114FD130:01CB763C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

In of_mdiobus_register(), the __be32 *addr variable is dereferenced.
This will not work on little-endian targets.  Also since it is
unsigned, checking for less than zero is redundant.

Fix these two issues.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dan Carpenter <error27@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/of/of_mdio.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 1fce00e..b370306 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -52,27 +52,32 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 
 	/* Loop over the child nodes and register a phy_device for each one */
 	for_each_child_of_node(np, child) {
-		const __be32 *addr;
+		const __be32 *paddr;
+		u32 addr;
 		int len;
 
 		/* A PHY must have a reg property in the range [0-31] */
-		addr = of_get_property(child, "reg", &len);
-		if (!addr || len < sizeof(*addr) || *addr >= 32 || *addr < 0) {
+		paddr = of_get_property(child, "reg", &len);
+		if (!paddr || len < sizeof(*paddr)) {
+addr_err:
 			dev_err(&mdio->dev, "%s has invalid PHY address\n",
 				child->full_name);
 			continue;
 		}
+		addr = be32_to_cpup(paddr);
+		if (addr >= 32)
+			goto addr_err;
 
 		if (mdio->irq) {
-			mdio->irq[*addr] = irq_of_parse_and_map(child, 0);
-			if (!mdio->irq[*addr])
-				mdio->irq[*addr] = PHY_POLL;
+			mdio->irq[addr] = irq_of_parse_and_map(child, 0);
+			if (!mdio->irq[addr])
+				mdio->irq[addr] = PHY_POLL;
 		}
 
-		phy = get_phy_device(mdio, be32_to_cpup(addr));
+		phy = get_phy_device(mdio, addr);
 		if (!phy || IS_ERR(phy)) {
 			dev_err(&mdio->dev, "error probing PHY at address %i\n",
-				*addr);
+				addr);
 			continue;
 		}
 		phy_scan_fixups(phy);
@@ -91,7 +96,7 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 		}
 
 		dev_dbg(&mdio->dev, "registered phy %s at address %i\n",
-			child->name, *addr);
+			child->name, addr);
 	}
 
 	return 0;
-- 
1.7.2.3
