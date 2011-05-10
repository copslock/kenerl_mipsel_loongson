Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2011 23:33:14 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45933 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491053Ab1EJVcV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2011 23:32:21 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 693998ACF;
        Tue, 10 May 2011 23:32:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4Ye7ETd4pcw3; Tue, 10 May 2011 23:32:17 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-255-123.ewe-ip-backbone.de [91.97.255.123])
        by hauke-m.de (Postfix) with ESMTPSA id 9B4608ACA;
        Tue, 10 May 2011 23:32:17 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] MIPS: BCM47xx: register ssb fallback sprom callback
Date:   Tue, 10 May 2011 23:31:32 +0200
Message-Id: <1305063094-26656-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1305063094-26656-1-git-send-email-hauke@hauke-m.de>
References: <1305063094-26656-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

We are generating the prefix based on the PCI bus address the device is
on. This is done like Broadcom does it in their code expect that the
the bus number is increased by one. In the SB bus implementation used by
Broadcom the SB bus emulates a PCI bus so the kernel sees one PCI bus
more then in our implementation. We do not handle prefixes like sb/1/
yet as they are only used on the new bus which is not implemented yet.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/nvram.c |    3 ++-
 arch/mips/bcm47xx/setup.c |   22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index e5b6615..54db815 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2005 Broadcom Corporation
  * Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
+ * Copyright (C) 2010-2011 Hauke Mehrtens <hauke@hauke-m.de>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -23,7 +24,7 @@
 static char nvram_buf[NVRAM_SPACE];
 
 /* Probe for NVRAM header */
-static void __init early_nvram_init(void)
+static void early_nvram_init(void)
 {
 	struct ssb_mipscore *mcore = &ssb_bcm47xx.mipscore;
 	struct nvram_header *header;
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index bbfcf9b..258ffcf 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -3,6 +3,7 @@
  *  Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
  *  Copyright (C) 2006 Michael Buesch <mb@bu3sch.de>
  *  Copyright (C) 2010 Waldemar Brodkorb <wbx@openadk.org>
+ *  Copyright (C) 2010-2011 Hauke Mehrtens <hauke@hauke-m.de>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -154,6 +155,22 @@ static void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
 	}
 }
 
+int bcm47xx_get_sprom(struct ssb_bus *bus, struct ssb_sprom *out)
+{
+	char prefix[10];
+
+	if (bus->bustype == SSB_BUSTYPE_PCI) {
+		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
+			 bus->host_pci->bus->number + 1,
+			 PCI_SLOT(bus->host_pci->devfn));
+		bcm47xx_fill_sprom(out, prefix);
+		return 0;
+	} else {
+		printk(KERN_WARNING "bcm47xx: unable to fill SPROM for given bustype.\n");
+		return -EINVAL;
+	}
+}
+
 static int bcm47xx_get_invariants(struct ssb_bus *bus,
 				   struct ssb_init_invariants *iv)
 {
@@ -185,6 +202,11 @@ void __init plat_mem_setup(void)
 	char buf[100];
 	struct ssb_mipscore *mcore;
 
+	err = ssb_arch_register_fallback_sprom(&bcm47xx_get_sprom);
+	if (err)
+		printk(KERN_WARNING "bcm47xx: someone else already registered"
+			" a ssb SPROM callback handler (err %d)\n", err);
+
 	err = ssb_bus_ssbbus_register(&ssb_bcm47xx, SSB_ENUM_BASE,
 				      bcm47xx_get_invariants);
 	if (err)
-- 
1.7.4.1
