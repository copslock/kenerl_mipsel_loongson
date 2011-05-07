Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2011 14:28:30 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45543 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491122Ab1EGM2H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 May 2011 14:28:07 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 530148ACE;
        Sat,  7 May 2011 14:28:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id omqL2Rkf17fe; Sat,  7 May 2011 14:28:02 +0200 (CEST)
Received: from localhost.localdomain (dyndsl-085-016-167-129.ewe-ip-backbone.de [85.16.167.129])
        by hauke-m.de (Postfix) with ESMTPSA id 248F28AC9;
        Sat,  7 May 2011 14:28:02 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Michael Buesch <mb@bu3sch.de>, netdev@vger.kernel.org,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/5] ssb: Change fallback sprom to callback mechanism.
Date:   Sat,  7 May 2011 14:27:39 +0200
Message-Id: <1304771263-10937-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1304771263-10937-1-git-send-email-hauke@hauke-m.de>
References: <1304771263-10937-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

Some embedded devices like the Netgear WNDR3300 have two SSB based
cards without an own sprom on the pci bus. We have to provide two
different fallback sproms for these and this was not possible with the
old solution. In the bcm47xx architecture the sprom data is stored in
the nvram in the main flash storage. The architecture code will be able
to fill the sprom with the stored data based on the bus where the
device was found.

The bcm63xx code should to the same thing as before, just using the new
API.

CC: Michael Buesch <mb@bu3sch.de>
CC: netdev@vger.kernel.org
CC: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c |   16 ++++++++++++++--
 drivers/ssb/pci.c                         |   16 +++++++++++-----
 drivers/ssb/sprom.c                       |   26 +++++++++++++++-----------
 drivers/ssb/ssb_private.h                 |    2 +-
 include/linux/ssb/ssb.h                   |    4 +++-
 5 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 8dba8cf..40b223b 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -643,6 +643,17 @@ static struct ssb_sprom bcm63xx_sprom = {
 	.boardflags_lo		= 0x2848,
 	.boardflags_hi		= 0x0000,
 };
+
+int bcm63xx_get_fallback_sprom(struct ssb_bus *bus, struct ssb_sprom *out)
+{
+	if (bus->bustype == SSB_BUSTYPE_PCI) {
+		memcpy(out, &bcm63xx_sprom, sizeof(struct ssb_sprom));
+		return 0;
+	} else {
+		printk(KERN_ERR PFX "unable to fill SPROM for given bustype.\n");
+		return -EINVAL;
+	}
+}
 #endif
 
 /*
@@ -793,8 +804,9 @@ void __init board_prom_init(void)
 	if (!board_get_mac_address(bcm63xx_sprom.il0mac)) {
 		memcpy(bcm63xx_sprom.et0mac, bcm63xx_sprom.il0mac, ETH_ALEN);
 		memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
-		if (ssb_arch_set_fallback_sprom(&bcm63xx_sprom) < 0)
-			printk(KERN_ERR "failed to register fallback SPROM\n");
+		if (ssb_arch_register_fallback_sprom(
+				&bcm63xx_get_fallback_sprom) < 0)
+			printk(KERN_ERR PFX "failed to register fallback SPROM\n");
 	}
 #endif
 }
diff --git a/drivers/ssb/pci.c b/drivers/ssb/pci.c
index 6f34963..34955d1 100644
--- a/drivers/ssb/pci.c
+++ b/drivers/ssb/pci.c
@@ -662,7 +662,6 @@ static int sprom_extract(struct ssb_bus *bus, struct ssb_sprom *out,
 static int ssb_pci_sprom_get(struct ssb_bus *bus,
 			     struct ssb_sprom *sprom)
 {
-	const struct ssb_sprom *fallback;
 	int err;
 	u16 *buf;
 
@@ -707,10 +706,17 @@ static int ssb_pci_sprom_get(struct ssb_bus *bus,
 		if (err) {
 			/* All CRC attempts failed.
 			 * Maybe there is no SPROM on the device?
-			 * If we have a fallback, use that. */
-			fallback = ssb_get_fallback_sprom();
-			if (fallback) {
-				memcpy(sprom, fallback, sizeof(*sprom));
+			 * Now we ask the arch code if there is some sprom
+			 * avaliable for this device in some other storage */
+			err = ssb_fill_sprom_with_fallback(bus, sprom);
+			if (err) {
+				ssb_printk(KERN_WARNING PFX "WARNING: Using"
+					   " fallback SPROM failed (err %d)\n",
+					   err);
+			} else {
+				ssb_dprintk(KERN_DEBUG PFX "Using SPROM"
+					    " revision %d provided by"
+					    " platform.\n", sprom->revision);
 				err = 0;
 				goto out_free;
 			}
diff --git a/drivers/ssb/sprom.c b/drivers/ssb/sprom.c
index 5f34d7a..20cd139 100644
--- a/drivers/ssb/sprom.c
+++ b/drivers/ssb/sprom.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 
 
-static const struct ssb_sprom *fallback_sprom;
+static int(*get_fallback_sprom)(struct ssb_bus *dev, struct ssb_sprom *out);
 
 
 static int sprom2hex(const u16 *sprom, char *buf, size_t buf_len,
@@ -145,13 +145,14 @@ out:
 }
 
 /**
- * ssb_arch_set_fallback_sprom - Set a fallback SPROM for use if no SPROM is found.
+ * ssb_arch_register_fallback_sprom - Registers a method providing a fallback
+ * SPROM if no SPROM is found.
  *
- * @sprom: The SPROM data structure to register.
+ * @sprom_callback: The callbcak function.
  *
- * With this function the architecture implementation may register a fallback
- * SPROM data structure. The fallback is only used for PCI based SSB devices,
- * where no valid SPROM can be found in the shadow registers.
+ * With this function the architecture implementation may register a callback
+ * handler which wills the SPROM data structure. The fallback is only used for
+ * PCI based SSB devices, where no valid SPROM can be found in the shadow registers.
  *
  * This function is useful for weird architectures that have a half-assed SSB device
  * hardwired to their PCI bus.
@@ -163,18 +164,21 @@ out:
  *
  * This function is available for architecture code, only. So it is not exported.
  */
-int ssb_arch_set_fallback_sprom(const struct ssb_sprom *sprom)
+int ssb_arch_register_fallback_sprom(int (*sprom_callback)(struct ssb_bus *bus, struct ssb_sprom *out))
 {
-	if (fallback_sprom)
+	if (get_fallback_sprom)
 		return -EEXIST;
-	fallback_sprom = sprom;
+	get_fallback_sprom = sprom_callback;
 
 	return 0;
 }
 
-const struct ssb_sprom *ssb_get_fallback_sprom(void)
+int ssb_fill_sprom_with_fallback(struct ssb_bus *bus, struct ssb_sprom *out)
 {
-	return fallback_sprom;
+	if (!get_fallback_sprom)
+		return -ENOENT;
+
+	return get_fallback_sprom(bus, out);
 }
 
 /* http://bcm-v4.sipsolutions.net/802.11/IsSpromAvailable */
diff --git a/drivers/ssb/ssb_private.h b/drivers/ssb/ssb_private.h
index 0331139..1a32f58 100644
--- a/drivers/ssb/ssb_private.h
+++ b/drivers/ssb/ssb_private.h
@@ -171,7 +171,7 @@ ssize_t ssb_attr_sprom_store(struct ssb_bus *bus,
 			     const char *buf, size_t count,
 			     int (*sprom_check_crc)(const u16 *sprom, size_t size),
 			     int (*sprom_write)(struct ssb_bus *bus, const u16 *sprom));
-extern const struct ssb_sprom *ssb_get_fallback_sprom(void);
+extern int ssb_fill_sprom_with_fallback(struct ssb_bus *bus, struct ssb_sprom *out);
 
 
 /* core.c */
diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
index 9659eff..045f72a 100644
--- a/include/linux/ssb/ssb.h
+++ b/include/linux/ssb/ssb.h
@@ -404,7 +404,9 @@ extern bool ssb_is_sprom_available(struct ssb_bus *bus);
 
 /* Set a fallback SPROM.
  * See kdoc at the function definition for complete documentation. */
-extern int ssb_arch_set_fallback_sprom(const struct ssb_sprom *sprom);
+extern int ssb_arch_register_fallback_sprom(
+		int (*sprom_callback)(struct ssb_bus *bus,
+		struct ssb_sprom *out));
 
 /* Suspend a SSB bus.
  * Call this from the parent bus suspend routine. */
-- 
1.7.4.1
