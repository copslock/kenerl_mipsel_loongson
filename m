Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Oct 2011 00:18:40 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19150 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491078Ab1I3WSg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Oct 2011 00:18:36 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e86405f0000>; Fri, 30 Sep 2011 15:19:15 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 30 Sep 2011 15:17:55 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 30 Sep 2011 15:17:54 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p8UMHom9027319;
        Fri, 30 Sep 2011 15:17:50 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p8UMHnsU027318;
        Fri, 30 Sep 2011 15:17:49 -0700
From:   David Daney <david.daney@cavium.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        Greg Dietsche <Gregory.Dietsche@cuw.edu>,
        "Uwe Kleine-Konig" <u.kleine-koenig@pengutronix.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Subject: [PATCH] netdev/phy/icplus: Use mdiobus_write() and mdiobus_read() for proper locking.
Date:   Fri, 30 Sep 2011 15:17:48 -0700
Message-Id: <1317421068-27278-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 30 Sep 2011 22:17:55.0306 (UTC) FILETIME=[CD605CA0:01CC7FBE]
X-archive-position: 31189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10

Usually you have to take the bus lock.  Why not here too?

I saw this when working on something else.  Not even compile tested.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Greg Dietsche <Gregory.Dietsche@cuw.edu>
Cc: "Uwe Kleine-Konig" <u.kleine-koenig@pengutronix.de>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/net/phy/icplus.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/icplus.c b/drivers/net/phy/icplus.c
index d4cbc29..bd4c740 100644
--- a/drivers/net/phy/icplus.c
+++ b/drivers/net/phy/icplus.c
@@ -42,36 +42,36 @@ static int ip175c_config_init(struct phy_device *phydev)
 	if (full_reset_performed == 0) {
 
 		/* master reset */
-		err = phydev->bus->write(phydev->bus, 30, 0, 0x175c);
+		err = mdiobus_write(phydev->bus, 30, 0, 0x175c);
 		if (err < 0)
 			return err;
 
 		/* ensure no bus delays overlap reset period */
-		err = phydev->bus->read(phydev->bus, 30, 0);
+		err = mdiobus_read(phydev->bus, 30, 0);
 
 		/* data sheet specifies reset period is 2 msec */
 		mdelay(2);
 
 		/* enable IP175C mode */
-		err = phydev->bus->write(phydev->bus, 29, 31, 0x175c);
+		err = mdiobus_write(phydev->bus, 29, 31, 0x175c);
 		if (err < 0)
 			return err;
 
 		/* Set MII0 speed and duplex (in PHY mode) */
-		err = phydev->bus->write(phydev->bus, 29, 22, 0x420);
+		err = mdiobus_write(phydev->bus, 29, 22, 0x420);
 		if (err < 0)
 			return err;
 
 		/* reset switch ports */
 		for (i = 0; i < 5; i++) {
-			err = phydev->bus->write(phydev->bus, i,
-						 MII_BMCR, BMCR_RESET);
+			err = mdiobus_write(phydev->bus, i,
+					    MII_BMCR, BMCR_RESET);
 			if (err < 0)
 				return err;
 		}
 
 		for (i = 0; i < 5; i++)
-			err = phydev->bus->read(phydev->bus, i, MII_BMCR);
+			err = mdiobus_read(phydev->bus, i, MII_BMCR);
 
 		mdelay(2);
 
-- 
1.7.2.3
