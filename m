Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2011 23:52:32 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18532 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491078Ab1I3VwU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Sep 2011 23:52:20 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e863a530000>; Fri, 30 Sep 2011 14:53:23 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 30 Sep 2011 14:52:07 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 30 Sep 2011 14:52:06 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p8ULpP9M025691;
        Fri, 30 Sep 2011 14:51:26 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p8ULpNna025690;
        Fri, 30 Sep 2011 14:51:23 -0700
From:   David Daney <david.daney@cavium.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: [PATCH] netdev/phy: Use mdiobus_read() so that proper locks are taken.
Date:   Fri, 30 Sep 2011 14:51:22 -0700
Message-Id: <1317419482-25655-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 30 Sep 2011 21:52:07.0100 (UTC) FILETIME=[3292DFC0:01CC7FBB]
X-archive-position: 31188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19123

Accesses to the mdio busses must be done with the mdio_lock to ensure
proper operation.  Conveniently we have the helper function
mdiobus_read() to do that for us.  Lets use it in get_phy_id() instead
of accessing the bus without the lock held.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/phy/phy_device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index ff109fe..83a5a5a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -213,7 +213,7 @@ int get_phy_id(struct mii_bus *bus, int addr, u32 *phy_id)
 
 	/* Grab the bits from PHYIR1, and put them
 	 * in the upper half */
-	phy_reg = bus->read(bus, addr, MII_PHYSID1);
+	phy_reg = mdiobus_read(bus, addr, MII_PHYSID1);
 
 	if (phy_reg < 0)
 		return -EIO;
@@ -221,7 +221,7 @@ int get_phy_id(struct mii_bus *bus, int addr, u32 *phy_id)
 	*phy_id = (phy_reg & 0xffff) << 16;
 
 	/* Grab the bits from PHYIR2, and put them in the lower half */
-	phy_reg = bus->read(bus, addr, MII_PHYSID2);
+	phy_reg = mdiobus_read(bus, addr, MII_PHYSID2);
 
 	if (phy_reg < 0)
 		return -EIO;
-- 
1.7.2.3
