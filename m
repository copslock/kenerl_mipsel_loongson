Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2011 18:56:46 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:50814 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491028Ab1GPQ4F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jul 2011 18:56:05 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 0027F8C66;
        Sat, 16 Jul 2011 18:56:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 71n9X2sViqCg; Sat, 16 Jul 2011 18:56:00 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-255-051.ewe-ip-backbone.de [91.97.255.51])
        by hauke-m.de (Postfix) with ESMTPSA id 734258C62;
        Sat, 16 Jul 2011 18:55:59 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        zajec5@gmail.com, linux-mips@linux-mips.org
Cc:     jonas.gorski@gmail.com, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, arnd@arndb.de,
        julian.calaby@gmail.com, sshtylyov@mvista.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 01/11] bcma: move parsing of EEPROM into own function.
Date:   Sat, 16 Jul 2011 18:55:32 +0200
Message-Id: <1310835342-18877-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
References: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 30632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11703

Move the parsing of the EEPROM data in scan function for one core into
an own function. Now we are able to use it in some other scan function
as well.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/scan.c |  230 ++++++++++++++++++++++++++-------------------------
 1 files changed, 118 insertions(+), 112 deletions(-)

diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index 40d7dcc..4012d8d 100644
--- a/drivers/bcma/scan.c
+++ b/drivers/bcma/scan.c
@@ -200,16 +200,124 @@ static s32 bcma_erom_get_addr_desc(struct bcma_bus *bus, u32 **eromptr,
 	return addrl;
 }
 
+static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
+			      struct bcma_device *core)
+{
+	s32 tmp;
+	u8 i, j;
+	s32 cia, cib;
+	u8 ports[2], wrappers[2];
+
+	/* get CIs */
+	cia = bcma_erom_get_ci(bus, eromptr);
+	if (cia < 0) {
+		bcma_erom_push_ent(eromptr);
+		if (bcma_erom_is_end(bus, eromptr))
+			return -ESPIPE;
+		return -EILSEQ;
+	}
+	cib = bcma_erom_get_ci(bus, eromptr);
+	if (cib < 0)
+		return -EILSEQ;
+
+	/* parse CIs */
+	core->id.class = (cia & SCAN_CIA_CLASS) >> SCAN_CIA_CLASS_SHIFT;
+	core->id.id = (cia & SCAN_CIA_ID) >> SCAN_CIA_ID_SHIFT;
+	core->id.manuf = (cia & SCAN_CIA_MANUF) >> SCAN_CIA_MANUF_SHIFT;
+	ports[0] = (cib & SCAN_CIB_NMP) >> SCAN_CIB_NMP_SHIFT;
+	ports[1] = (cib & SCAN_CIB_NSP) >> SCAN_CIB_NSP_SHIFT;
+	wrappers[0] = (cib & SCAN_CIB_NMW) >> SCAN_CIB_NMW_SHIFT;
+	wrappers[1] = (cib & SCAN_CIB_NSW) >> SCAN_CIB_NSW_SHIFT;
+	core->id.rev = (cib & SCAN_CIB_REV) >> SCAN_CIB_REV_SHIFT;
+
+	if (((core->id.manuf == BCMA_MANUF_ARM) &&
+	     (core->id.id == 0xFFF)) ||
+	    (ports[1] == 0)) {
+		bcma_erom_skip_component(bus, eromptr);
+		return -ENXIO;
+	}
+
+	/* check if component is a core at all */
+	if (wrappers[0] + wrappers[1] == 0) {
+		/* we could save addrl of the router
+		if (cid == BCMA_CORE_OOB_ROUTER)
+		 */
+		bcma_erom_skip_component(bus, eromptr);
+		return -ENXIO;
+	}
+
+	if (bcma_erom_is_bridge(bus, eromptr)) {
+		bcma_erom_skip_component(bus, eromptr);
+		return -ENXIO;
+	}
+
+	/* get & parse master ports */
+	for (i = 0; i < ports[0]; i++) {
+		u32 mst_port_d = bcma_erom_get_mst_port(bus, eromptr);
+		if (mst_port_d < 0)
+			return -EILSEQ;
+	}
+
+	/* get & parse slave ports */
+	for (i = 0; i < ports[1]; i++) {
+		for (j = 0; ; j++) {
+			tmp = bcma_erom_get_addr_desc(bus, eromptr,
+				SCAN_ADDR_TYPE_SLAVE, i);
+			if (tmp < 0) {
+				/* no more entries for port _i_ */
+				/* pr_debug("erom: slave port %d "
+				 * "has %d descriptors\n", i, j); */
+				break;
+			} else {
+				if (i == 0 && j == 0)
+					core->addr = tmp;
+			}
+		}
+	}
+
+	/* get & parse master wrappers */
+	for (i = 0; i < wrappers[0]; i++) {
+		for (j = 0; ; j++) {
+			tmp = bcma_erom_get_addr_desc(bus, eromptr,
+				SCAN_ADDR_TYPE_MWRAP, i);
+			if (tmp < 0) {
+				/* no more entries for port _i_ */
+				/* pr_debug("erom: master wrapper %d "
+				 * "has %d descriptors\n", i, j); */
+				break;
+			} else {
+				if (i == 0 && j == 0)
+					core->wrap = tmp;
+			}
+		}
+	}
+
+	/* get & parse slave wrappers */
+	for (i = 0; i < wrappers[1]; i++) {
+		u8 hack = (ports[1] == 1) ? 0 : 1;
+		for (j = 0; ; j++) {
+			tmp = bcma_erom_get_addr_desc(bus, eromptr,
+				SCAN_ADDR_TYPE_SWRAP, i + hack);
+			if (tmp < 0) {
+				/* no more entries for port _i_ */
+				/* pr_debug("erom: master wrapper %d "
+				 * has %d descriptors\n", i, j); */
+				break;
+			} else {
+				if (wrappers[0] == 0 && !i && !j)
+					core->wrap = tmp;
+			}
+		}
+	}
+	return 0;
+}
+
 int bcma_bus_scan(struct bcma_bus *bus)
 {
 	u32 erombase;
 	u32 __iomem *eromptr, *eromend;
 
-	s32 cia, cib;
-	u8 ports[2], wrappers[2];
-
 	s32 tmp;
-	u8 i, j;
 
 	int err;
 
@@ -236,112 +344,13 @@ int bcma_bus_scan(struct bcma_bus *bus)
 		INIT_LIST_HEAD(&core->list);
 		core->bus = bus;
 
-		/* get CIs */
-		cia = bcma_erom_get_ci(bus, &eromptr);
-		if (cia < 0) {
-			bcma_erom_push_ent(&eromptr);
-			if (bcma_erom_is_end(bus, &eromptr))
-				break;
-			err= -EILSEQ;
-			goto out;
-		}
-		cib = bcma_erom_get_ci(bus, &eromptr);
-		if (cib < 0) {
-			err= -EILSEQ;
-			goto out;
-		}
-
-		/* parse CIs */
-		core->id.class = (cia & SCAN_CIA_CLASS) >> SCAN_CIA_CLASS_SHIFT;
-		core->id.id = (cia & SCAN_CIA_ID) >> SCAN_CIA_ID_SHIFT;
-		core->id.manuf = (cia & SCAN_CIA_MANUF) >> SCAN_CIA_MANUF_SHIFT;
-		ports[0] = (cib & SCAN_CIB_NMP) >> SCAN_CIB_NMP_SHIFT;
-		ports[1] = (cib & SCAN_CIB_NSP) >> SCAN_CIB_NSP_SHIFT;
-		wrappers[0] = (cib & SCAN_CIB_NMW) >> SCAN_CIB_NMW_SHIFT;
-		wrappers[1] = (cib & SCAN_CIB_NSW) >> SCAN_CIB_NSW_SHIFT;
-		core->id.rev = (cib & SCAN_CIB_REV) >> SCAN_CIB_REV_SHIFT;
-
-		if (((core->id.manuf == BCMA_MANUF_ARM) &&
-		     (core->id.id == 0xFFF)) ||
-		    (ports[1] == 0)) {
-			bcma_erom_skip_component(bus, &eromptr);
-			continue;
-		}
-
-		/* check if component is a core at all */
-		if (wrappers[0] + wrappers[1] == 0) {
-			/* we could save addrl of the router
-			if (cid == BCMA_CORE_OOB_ROUTER)
-			 */
-			bcma_erom_skip_component(bus, &eromptr);
-			continue;
-		}
-
-		if (bcma_erom_is_bridge(bus, &eromptr)) {
-			bcma_erom_skip_component(bus, &eromptr);
+		err = bcma_get_next_core(bus, &eromptr, core);
+		if (err == -ENXIO)
 			continue;
-		}
-
-		/* get & parse master ports */
-		for (i = 0; i < ports[0]; i++) {
-			u32 mst_port_d = bcma_erom_get_mst_port(bus, &eromptr);
-			if (mst_port_d < 0) {
-				err= -EILSEQ;
-				goto out;
-			}
-		}
-
-		/* get & parse slave ports */
-		for (i = 0; i < ports[1]; i++) {
-			for (j = 0; ; j++) {
-				tmp = bcma_erom_get_addr_desc(bus, &eromptr,
-					SCAN_ADDR_TYPE_SLAVE, i);
-				if (tmp < 0) {
-					/* no more entries for port _i_ */
-					/* pr_debug("erom: slave port %d "
-					 * "has %d descriptors\n", i, j); */
-					break;
-				} else {
-					if (i == 0 && j == 0)
-						core->addr = tmp;
-				}
-			}
-		}
-
-		/* get & parse master wrappers */
-		for (i = 0; i < wrappers[0]; i++) {
-			for (j = 0; ; j++) {
-				tmp = bcma_erom_get_addr_desc(bus, &eromptr,
-					SCAN_ADDR_TYPE_MWRAP, i);
-				if (tmp < 0) {
-					/* no more entries for port _i_ */
-					/* pr_debug("erom: master wrapper %d "
-					 * "has %d descriptors\n", i, j); */
-					break;
-				} else {
-					if (i == 0 && j == 0)
-						core->wrap = tmp;
-				}
-			}
-		}
-
-		/* get & parse slave wrappers */
-		for (i = 0; i < wrappers[1]; i++) {
-			u8 hack = (ports[1] == 1) ? 0 : 1;
-			for (j = 0; ; j++) {
-				tmp = bcma_erom_get_addr_desc(bus, &eromptr,
-					SCAN_ADDR_TYPE_SWRAP, i + hack);
-				if (tmp < 0) {
-					/* no more entries for port _i_ */
-					/* pr_debug("erom: master wrapper %d "
-					 * has %d descriptors\n", i, j); */
-					break;
-				} else {
-					if (wrappers[0] == 0 && !i && !j)
-						core->wrap = tmp;
-				}
-			}
-		}
+		else if (err == -ESPIPE)
+			break;
+		else if (err < 0)
+			return err;
 
 		pr_info("Core %d found: %s "
 			"(manuf 0x%03X, id 0x%03X, rev 0x%02X, class 0x%X)\n",
@@ -351,9 +360,6 @@ int bcma_bus_scan(struct bcma_bus *bus)
 
 		core->core_index = bus->nr_cores++;
 		list_add(&core->list, &bus->cores);
-		continue;
-out:
-		return err;
 	}
 
 	return 0;
-- 
1.7.4.1
