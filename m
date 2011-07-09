Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jul 2011 13:07:48 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:41917 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491152Ab1GILGd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Jul 2011 13:06:33 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 583568C6D;
        Sat,  9 Jul 2011 13:06:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gz4Hrk-JRXgX; Sat,  9 Jul 2011 13:06:27 +0200 (CEST)
Received: from localhost.localdomain (dyndsl-095-033-240-133.ewe-ip-backbone.de [95.33.240.133])
        by hauke-m.de (Postfix) with ESMTPSA id 3C15B8C63;
        Sat,  9 Jul 2011 13:06:24 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        zajec5@gmail.com, linux-mips@linux-mips.org
Cc:     mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/11] bcma: move initializing of struct bcma_bus to own function.
Date:   Sat,  9 Jul 2011 13:05:54 +0200
Message-Id: <1310209563-6405-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1310209563-6405-1-git-send-email-hauke@hauke-m.de>
References: <1310209563-6405-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 30595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6775

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
