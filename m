Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Jun 2011 23:52:40 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:41204 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491020Ab1FSVwB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Jun 2011 23:52:01 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 3AC8E8BAD;
        Sun, 19 Jun 2011 23:52:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xqVIzkNlyMkd; Sun, 19 Jun 2011 23:51:43 +0200 (CEST)
Received: from localhost.localdomain (dyndsl-095-033-241-142.ewe-ip-backbone.de [95.33.241.142])
        by hauke-m.de (Postfix) with ESMTPSA id 9C0AA8BB5;
        Sun, 19 Jun 2011 23:51:07 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-wireless@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org
Cc:     mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC v2 02/12] bcma: move initializing of struct bcma_bus to own function.
Date:   Sun, 19 Jun 2011 23:49:59 +0200
Message-Id: <1308520209-668-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1308520209-668-1-git-send-email-hauke@hauke-m.de>
References: <1308520209-668-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 30438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15686

This makes it possible to use this code in some other method.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/scan.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index 4012d8d..7970553 100644
--- a/drivers/bcma/scan.c
+++ b/drivers/bcma/scan.c
@@ -312,15 +312,10 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
 	return 0;
 }
 
-int bcma_bus_scan(struct bcma_bus *bus)
+static void bcma_init_bus(struct bcma_bus *bus)
 {
-	u32 erombase;
-	u32 __iomem *eromptr, *eromend;
-
 	s32 tmp;
 
-	int err;
-
 	INIT_LIST_HEAD(&bus->cores);
 	bus->nr_cores = 0;
 
@@ -330,6 +325,16 @@ int bcma_bus_scan(struct bcma_bus *bus)
 	bus->chipinfo.id = (tmp & BCMA_CC_ID_ID) >> BCMA_CC_ID_ID_SHIFT;
 	bus->chipinfo.rev = (tmp & BCMA_CC_ID_REV) >> BCMA_CC_ID_REV_SHIFT;
 	bus->chipinfo.pkg = (tmp & BCMA_CC_ID_PKG) >> BCMA_CC_ID_PKG_SHIFT;
+}
+
+int bcma_bus_scan(struct bcma_bus *bus)
+{
+	u32 erombase;
+	u32 __iomem *eromptr, *eromend;
+
+	int err;
+
+	bcma_init_bus(bus);
 
 	erombase = bcma_scan_read32(bus, 0, BCMA_CC_EROM);
 	eromptr = bus->mmio;
-- 
1.7.4.1
