Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2011 01:21:52 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:59021 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491814Ab1GVXUi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jul 2011 01:20:38 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 21F698C9C;
        Sat, 23 Jul 2011 01:20:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4DRUeLgEexGn; Sat, 23 Jul 2011 01:20:32 +0200 (CEST)
Received: from localhost.localdomain (dyndsl-085-016-164-032.ewe-ip-backbone.de [85.16.164.32])
        by hauke-m.de (Postfix) with ESMTPSA id 34DBA8C92;
        Sat, 23 Jul 2011 01:20:27 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org
Cc:     jonas.gorski@gmail.com, ralf@linux-mips.org, zajec5@gmail.com,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/11] bcma: add functions to scan cores needed on SoCs
Date:   Sat, 23 Jul 2011 01:20:07 +0200
Message-Id: <1311376815-15755-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1311376815-15755-1-git-send-email-hauke@hauke-m.de>
References: <1311376815-15755-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 30681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16555

The chip common and mips core have to be setup early in the boot
process to get the cpu clock.
bcma_bus_early_register() gets pointers to some space to store the core
data and searches for the chip common and mips core and initializes
chip common. After that was done and the kernel is out of early boot we
just have to run bcma_bus_register() and it will search for the other
cores, initialize and register them.
The cores are getting the same numbers as before.

Acked-by: Rafał Miłecki <zajec5@gmail.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/bcma_private.h                 |    7 ++
 drivers/bcma/driver_chipcommon.c            |    5 ++
 drivers/bcma/driver_pci.c                   |    5 ++
 drivers/bcma/main.c                         |   46 +++++++++++++
 drivers/bcma/scan.c                         |   95 +++++++++++++++++++++++++--
 include/linux/bcma/bcma.h                   |    1 +
 include/linux/bcma/bcma_driver_chipcommon.h |    1 +
 7 files changed, 154 insertions(+), 6 deletions(-)

diff --git a/drivers/bcma/bcma_private.h b/drivers/bcma/bcma_private.h
index e02ff21..b97633d 100644
--- a/drivers/bcma/bcma_private.h
+++ b/drivers/bcma/bcma_private.h
@@ -15,9 +15,16 @@ struct bcma_bus;
 /* main.c */
 int bcma_bus_register(struct bcma_bus *bus);
 void bcma_bus_unregister(struct bcma_bus *bus);
+int __init bcma_bus_early_register(struct bcma_bus *bus,
+				   struct bcma_device *core_cc,
+				   struct bcma_device *core_mips);
 
 /* scan.c */
 int bcma_bus_scan(struct bcma_bus *bus);
+int __init bcma_bus_scan_early(struct bcma_bus *bus,
+			       struct bcma_device_id *match,
+			       struct bcma_device *core);
+void bcma_init_bus(struct bcma_bus *bus);
 
 /* sprom.c */
 int bcma_sprom_get(struct bcma_bus *bus);
diff --git a/drivers/bcma/driver_chipcommon.c b/drivers/bcma/driver_chipcommon.c
index fb54302..75f1ad7 100644
--- a/drivers/bcma/driver_chipcommon.c
+++ b/drivers/bcma/driver_chipcommon.c
@@ -26,6 +26,9 @@ void bcma_core_chipcommon_init(struct bcma_drv_cc *cc)
 	u32 leddc_on = 10;
 	u32 leddc_off = 90;
 
+	if (cc->setup_done)
+		return;
+
 	if (cc->core->id.rev >= 11)
 		cc->status = bcma_cc_read32(cc, BCMA_CC_CHIPSTAT);
 	cc->capabilities = bcma_cc_read32(cc, BCMA_CC_CAP);
@@ -52,6 +55,8 @@ void bcma_core_chipcommon_init(struct bcma_drv_cc *cc)
 			((leddc_on << BCMA_CC_GPIOTIMER_ONTIME_SHIFT) |
 			 (leddc_off << BCMA_CC_GPIOTIMER_OFFTIME_SHIFT)));
 	}
+
+	cc->setup_done = true;
 }
 
 /* Set chip watchdog reset timer to fire in 'ticks' backplane cycles */
diff --git a/drivers/bcma/driver_pci.c b/drivers/bcma/driver_pci.c
index dc6f34a..bdd3bc9 100644
--- a/drivers/bcma/driver_pci.c
+++ b/drivers/bcma/driver_pci.c
@@ -187,6 +187,9 @@ static bool bcma_core_pci_is_in_hostmode(struct bcma_drv_pci *pc)
 
 void bcma_core_pci_init(struct bcma_drv_pci *pc)
 {
+	if (pc->setup_done)
+		return;
+
 	if (bcma_core_pci_is_in_hostmode(pc)) {
 #ifdef CONFIG_BCMA_DRIVER_PCI_HOSTMODE
 		bcma_core_pci_hostmode_init(pc);
@@ -196,6 +199,8 @@ void bcma_core_pci_init(struct bcma_drv_pci *pc)
 	} else {
 		bcma_core_pci_clientmode_init(pc);
 	}
+
+	pc->setup_done = true;
 }
 
 int bcma_core_pci_irq_ctl(struct bcma_drv_pci *pc, struct bcma_device *core,
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 873e2e4..360a289 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -169,6 +169,52 @@ void bcma_bus_unregister(struct bcma_bus *bus)
 	bcma_unregister_cores(bus);
 }
 
+int __init bcma_bus_early_register(struct bcma_bus *bus,
+				   struct bcma_device *core_cc,
+				   struct bcma_device *core_mips)
+{
+	int err;
+	struct bcma_device *core;
+	struct bcma_device_id match;
+
+	bcma_init_bus(bus);
+
+	match.manuf = BCMA_MANUF_BCM;
+	match.id = BCMA_CORE_CHIPCOMMON;
+	match.class = BCMA_CL_SIM;
+	match.rev = BCMA_ANY_REV;
+
+	/* Scan for chip common core */
+	err = bcma_bus_scan_early(bus, &match, core_cc);
+	if (err) {
+		pr_err("Failed to scan for common core: %d\n", err);
+		return -1;
+	}
+
+	match.manuf = BCMA_MANUF_MIPS;
+	match.id = BCMA_CORE_MIPS_74K;
+	match.class = BCMA_CL_SIM;
+	match.rev = BCMA_ANY_REV;
+
+	/* Scan for mips core */
+	err = bcma_bus_scan_early(bus, &match, core_mips);
+	if (err) {
+		pr_err("Failed to scan for mips core: %d\n", err);
+		return -1;
+	}
+
+	/* Init CC core */
+	core = bcma_find_core(bus, BCMA_CORE_CHIPCOMMON);
+	if (core) {
+		bus->drv_cc.core = core;
+		bcma_core_chipcommon_init(&bus->drv_cc);
+	}
+
+	pr_info("Early bus registered\n");
+
+	return 0;
+}
+
 int __bcma_driver_register(struct bcma_driver *drv, struct module *owner)
 {
 	drv->drv.name = drv->name;
diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index 7970553..bf9f806 100644
--- a/drivers/bcma/scan.c
+++ b/drivers/bcma/scan.c
@@ -200,7 +200,20 @@ static s32 bcma_erom_get_addr_desc(struct bcma_bus *bus, u32 **eromptr,
 	return addrl;
 }
 
+static struct bcma_device *bcma_find_core_by_index(struct bcma_bus *bus,
+						   u16 index)
+{
+	struct bcma_device *core;
+
+	list_for_each_entry(core, &bus->cores, list) {
+		if (core->core_index == index)
+			return core;
+	}
+	return NULL;
+}
+
 static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
+			      struct bcma_device_id *match, int core_num,
 			      struct bcma_device *core)
 {
 	s32 tmp;
@@ -251,6 +264,21 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
 		return -ENXIO;
 	}
 
+	if (bcma_find_core_by_index(bus, core_num)) {
+		bcma_erom_skip_component(bus, eromptr);
+		return -ENODEV;
+	}
+
+	if (match && ((match->manuf != BCMA_ANY_MANUF &&
+	      match->manuf != core->id.manuf) ||
+	     (match->id != BCMA_ANY_ID && match->id != core->id.id) ||
+	     (match->rev != BCMA_ANY_REV && match->rev != core->id.rev) ||
+	     (match->class != BCMA_ANY_CLASS && match->class != core->id.class)
+	    )) {
+		bcma_erom_skip_component(bus, eromptr);
+		return -ENODEV;
+	}
+
 	/* get & parse master ports */
 	for (i = 0; i < ports[0]; i++) {
 		u32 mst_port_d = bcma_erom_get_mst_port(bus, eromptr);
@@ -312,10 +340,13 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
 	return 0;
 }
 
-static void bcma_init_bus(struct bcma_bus *bus)
+void bcma_init_bus(struct bcma_bus *bus)
 {
 	s32 tmp;
 
+	if (bus->init_done)
+		return;
+
 	INIT_LIST_HEAD(&bus->cores);
 	bus->nr_cores = 0;
 
@@ -325,6 +356,7 @@ static void bcma_init_bus(struct bcma_bus *bus)
 	bus->chipinfo.id = (tmp & BCMA_CC_ID_ID) >> BCMA_CC_ID_ID_SHIFT;
 	bus->chipinfo.rev = (tmp & BCMA_CC_ID_REV) >> BCMA_CC_ID_REV_SHIFT;
 	bus->chipinfo.pkg = (tmp & BCMA_CC_ID_PKG) >> BCMA_CC_ID_PKG_SHIFT;
+	bus->init_done = true;
 }
 
 int bcma_bus_scan(struct bcma_bus *bus)
@@ -332,7 +364,7 @@ int bcma_bus_scan(struct bcma_bus *bus)
 	u32 erombase;
 	u32 __iomem *eromptr, *eromend;
 
-	int err;
+	int err, core_num = 0;
 
 	bcma_init_bus(bus);
 
@@ -349,23 +381,74 @@ int bcma_bus_scan(struct bcma_bus *bus)
 		INIT_LIST_HEAD(&core->list);
 		core->bus = bus;
 
-		err = bcma_get_next_core(bus, &eromptr, core);
-		if (err == -ENXIO)
+		err = bcma_get_next_core(bus, &eromptr, NULL, core_num, core);
+		if (err == -ENODEV) {
+			core_num++;
+			continue;
+		} else if (err == -ENXIO)
 			continue;
 		else if (err == -ESPIPE)
 			break;
 		else if (err < 0)
 			return err;
 
+		core->core_index = core_num++;
+		bus->nr_cores++;
+
 		pr_info("Core %d found: %s "
 			"(manuf 0x%03X, id 0x%03X, rev 0x%02X, class 0x%X)\n",
-			bus->nr_cores, bcma_device_name(&core->id),
+			core->core_index, bcma_device_name(&core->id),
 			core->id.manuf, core->id.id, core->id.rev,
 			core->id.class);
 
-		core->core_index = bus->nr_cores++;
 		list_add(&core->list, &bus->cores);
 	}
 
 	return 0;
 }
+
+int __init bcma_bus_scan_early(struct bcma_bus *bus,
+			       struct bcma_device_id *match,
+			       struct bcma_device *core)
+{
+	u32 erombase;
+	u32 __iomem *eromptr, *eromend;
+
+	int err, core_num = 0;
+
+	erombase = bcma_scan_read32(bus, 0, BCMA_CC_EROM);
+	eromptr = bus->mmio;
+	eromend = eromptr + BCMA_CORE_SIZE / sizeof(u32);
+
+	bcma_scan_switch_core(bus, erombase);
+
+	while (eromptr < eromend) {
+		memset(core, 0, sizeof(*core));
+		INIT_LIST_HEAD(&core->list);
+		core->bus = bus;
+
+		err = bcma_get_next_core(bus, &eromptr, match, core_num, core);
+		if (err == -ENODEV) {
+			core_num++;
+			continue;
+		} else if (err == -ENXIO)
+			continue;
+		else if (err == -ESPIPE)
+			break;
+		else if (err < 0)
+			return err;
+
+		core->core_index = core_num++;
+		bus->nr_cores++;
+		pr_info("Core %d found: %s "
+			"(manuf 0x%03X, id 0x%03X, rev 0x%02X, class 0x%X)\n",
+			core->core_index, bcma_device_name(&core->id),
+			core->id.manuf, core->id.id, core->id.rev,
+			core->id.class);
+
+		list_add(&core->list, &bus->cores);
+		return 0;
+	}
+
+	return -ENODEV;
+}
diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
index 8c96654..e31c9b4 100644
--- a/include/linux/bcma/bcma.h
+++ b/include/linux/bcma/bcma.h
@@ -190,6 +190,7 @@ struct bcma_bus {
 	struct bcma_device *mapped_core;
 	struct list_head cores;
 	u8 nr_cores;
+	u8 init_done:1;
 
 	struct bcma_drv_cc drv_cc;
 	struct bcma_drv_pci drv_pci;
diff --git a/include/linux/bcma/bcma_driver_chipcommon.h b/include/linux/bcma/bcma_driver_chipcommon.h
index a0f6846..c8b4cf7 100644
--- a/include/linux/bcma/bcma_driver_chipcommon.h
+++ b/include/linux/bcma/bcma_driver_chipcommon.h
@@ -252,6 +252,7 @@ struct bcma_drv_cc {
 	u32 status;
 	u32 capabilities;
 	u32 capabilities_ext;
+	u8 setup_done:1;
 	/* Fast Powerup Delay constant */
 	u16 fast_pwrup_delay;
 	struct bcma_chipcommon_pmu pmu;
-- 
1.7.4.1
