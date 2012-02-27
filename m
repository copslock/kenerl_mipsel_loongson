Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2012 01:01:22 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:58160 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903789Ab2B0X6X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2012 00:58:23 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id D6B7D8F70;
        Tue, 28 Feb 2012 00:58:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ChsnnePXQ03i; Tue, 28 Feb 2012 00:58:09 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id A78168F6B;
        Tue, 28 Feb 2012 00:57:02 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, ralf@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 11/11] MIPS: BCM47XX: provide sprom to bcma bus
Date:   Tue, 28 Feb 2012 00:56:14 +0100
Message-Id: <1330386974-4056-12-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1330386974-4056-1-git-send-email-hauke@hauke-m.de>
References: <1330386974-4056-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On SoCs the sprom is often stored in nvram in the flashchip. This patch
registers a sprom fallback callback handler in bcma and provides the
sprom needed for this device.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c |   39 +++++++++++++++++++++++++++++++++++----
 1 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 6b0dacd..19780aa 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -3,7 +3,7 @@
  *  Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
  *  Copyright (C) 2006 Michael Buesch <m@bues.ch>
  *  Copyright (C) 2010 Waldemar Brodkorb <wbx@openadk.org>
- *  Copyright (C) 2010-2011 Hauke Mehrtens <hauke@hauke-m.de>
+ *  Copyright (C) 2010-2012 Hauke Mehrtens <hauke@hauke-m.de>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -85,7 +85,7 @@ static void bcm47xx_machine_halt(void)
 }
 
 #ifdef CONFIG_BCM47XX_SSB
-static int bcm47xx_get_sprom(struct ssb_bus *bus, struct ssb_sprom *out)
+static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
 {
 	char prefix[10];
 
@@ -102,7 +102,7 @@ static int bcm47xx_get_sprom(struct ssb_bus *bus, struct ssb_sprom *out)
 }
 
 static int bcm47xx_get_invariants(struct ssb_bus *bus,
-				   struct ssb_init_invariants *iv)
+				  struct ssb_init_invariants *iv)
 {
 	char buf[20];
 
@@ -132,7 +132,7 @@ static void __init bcm47xx_register_ssb(void)
 	char buf[100];
 	struct ssb_mipscore *mcore;
 
-	err = ssb_arch_register_fallback_sprom(&bcm47xx_get_sprom);
+	err = ssb_arch_register_fallback_sprom(&bcm47xx_get_sprom_ssb);
 	if (err)
 		printk(KERN_WARNING "bcm47xx: someone else already registered"
 			" a ssb SPROM callback handler (err %d)\n", err);
@@ -159,10 +159,41 @@ static void __init bcm47xx_register_ssb(void)
 #endif
 
 #ifdef CONFIG_BCM47XX_BCMA
+static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
+{
+	char prefix[10];
+	struct bcma_device *core;
+
+	switch (bus->hosttype) {
+	case BCMA_HOSTTYPE_PCI:
+		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
+			 bus->host_pci->bus->number + 1,
+			 PCI_SLOT(bus->host_pci->devfn));
+		bcm47xx_fill_sprom(out, prefix);
+		return 0;
+	case BCMA_HOSTTYPE_SOC:
+		bcm47xx_fill_sprom_ethernet(out, NULL);
+		core = bcma_find_core(bus, BCMA_CORE_80211);
+		if (core) {
+			snprintf(prefix, sizeof(prefix), "sb/%u/",
+				 core->core_index);
+			bcm47xx_fill_sprom(out, prefix);
+		}
+		return 0;
+	default:
+		pr_warn("bcm47xx: unable to fill SPROM for given bustype.\n");
+		return -EINVAL;
+	}
+}
+
 static void __init bcm47xx_register_bcma(void)
 {
 	int err;
 
+	err = bcma_arch_register_fallback_sprom(&bcm47xx_get_sprom_bcma);
+	if (err)
+		pr_warn("bcm47xx: someone else already registered a bcma SPROM callback handler (err %d)\n", err);
+
 	err = bcma_host_soc_register(&bcm47xx_bus.bcma);
 	if (err)
 		panic("Failed to initialize BCMA bus (err %d)", err);
-- 
1.7.5.4
