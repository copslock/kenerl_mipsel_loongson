Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2012 19:35:56 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:35852 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903590Ab2BSSdp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Feb 2012 19:33:45 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 1C2918F70;
        Sun, 19 Feb 2012 19:33:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GHeDeJ3sBJEM; Sun, 19 Feb 2012 19:33:31 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 779EC8F67;
        Sun, 19 Feb 2012 19:32:49 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/11] bcma: add support for sprom not found on the device.
Date:   Sun, 19 Feb 2012 19:32:21 +0100
Message-Id: <1329676345-15856-8-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On SoCs the sprom is stored in the nvram in a special partition on the
flash chip. The nvram contains the sprom for the main bus, but
sometimes also for a pci devices using bcma. This patch makes it
possible for the arch code to register a function to fetch the needed
sprom from the nvram and provide it to the bcma code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/sprom.c      |   75 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/bcma/bcma.h |    6 +++
 2 files changed, 73 insertions(+), 8 deletions(-)

diff --git a/drivers/bcma/sprom.c b/drivers/bcma/sprom.c
index ca77525..73c204d 100644
--- a/drivers/bcma/sprom.c
+++ b/drivers/bcma/sprom.c
@@ -14,6 +14,45 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 
+static int(*get_fallback_sprom)(struct bcma_bus *dev, struct ssb_sprom *out);
+
+/**
+ * bcma_arch_register_fallback_sprom - Registers a method providing a
+ * fallback SPROM if no SPROM is found.
+ *
+ * @sprom_callback: The callback function.
+ *
+ * With this function the architecture implementation may register a
+ * callback handler which fills the SPROM data structure. The fallback is
+ * used for PCI based BCMA devices, where no valid SPROM can be found
+ * in the shadow registers and to provide the SPROM for SoCs where BCMA is
+ * to controll the system bus.
+ *
+ * This function is useful for weird architectures that have a half-assed
+ * BCMA device hardwired to their PCI bus.
+ *
+ * This function is available for architecture code, only. So it is not
+ * exported.
+ */
+int bcma_arch_register_fallback_sprom(int (*sprom_callback)(struct bcma_bus *bus,
+				     struct ssb_sprom *out))
+{
+	if (get_fallback_sprom)
+		return -EEXIST;
+	get_fallback_sprom = sprom_callback;
+
+	return 0;
+}
+
+static int bcma_fill_sprom_with_fallback(struct bcma_bus *bus,
+					 struct ssb_sprom *out)
+{
+	if (!get_fallback_sprom)
+		return -ENOENT;
+
+	return get_fallback_sprom(bus, out);
+}
+
 /**************************************************
  * R/W ops.
  **************************************************/
@@ -246,23 +285,43 @@ static void bcma_sprom_extract_r8(struct bcma_bus *bus, const u16 *sprom)
 	     SSB_SROM8_FEM_ANTSWLUT_SHIFT);
 }
 
+static bool bcma_is_sprom_available(struct bcma_bus *bus)
+{
+	u32 sromctrl;
+
+	if (!(bus->drv_cc.capabilities & BCMA_CC_CAP_SPROM))
+		return false;
+
+	if (bus->drv_cc.core->id.rev >= 32) {
+		sromctrl = bcma_read32(bus->drv_cc.core, BCMA_CC_SROM_CONTROL);
+		return sromctrl & BCMA_CC_SROM_CONTROL_PRESENT;
+	}
+	return true;
+}
+
 int bcma_sprom_get(struct bcma_bus *bus)
 {
 	u16 offset;
 	u16 *sprom;
-	u32 sromctrl;
 	int err = 0;
 
 	if (!bus->drv_cc.core)
 		return -EOPNOTSUPP;
 
-	if (!(bus->drv_cc.capabilities & BCMA_CC_CAP_SPROM))
-		return -ENOENT;
-
-	if (bus->drv_cc.core->id.rev >= 32) {
-		sromctrl = bcma_read32(bus->drv_cc.core, BCMA_CC_SROM_CONTROL);
-		if (!(sromctrl & BCMA_CC_SROM_CONTROL_PRESENT))
-			return -ENOENT;
+	if (!bcma_is_sprom_available(bus)) {
+		/*
+		 * Maybe there is no SPROM on the device?
+		 * Now we ask the arch code if there is some sprom
+		 * available for this device in some other storage.
+		 */
+		err = bcma_fill_sprom_with_fallback(bus, &bus->sprom);
+		if (err) {
+			pr_warn("Using fallback SPROM failed (err %d)\n", err);
+		} else {
+			pr_debug("Using SPROM revision %d provided by"
+				 " platform.\n", bus->sprom.revision);
+			return 0;
+		}
 	}
 
 	sprom = kcalloc(SSB_SPROMSIZE_WORDS_R4, sizeof(u16),
diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
index 46bbd08..5af9a07 100644
--- a/include/linux/bcma/bcma.h
+++ b/include/linux/bcma/bcma.h
@@ -176,6 +176,12 @@ int __bcma_driver_register(struct bcma_driver *drv, struct module *owner);
 
 extern void bcma_driver_unregister(struct bcma_driver *drv);
 
+/* Set a fallback SPROM.
+ * See kdoc at the function definition for complete documentation. */
+extern int bcma_arch_register_fallback_sprom(
+		int (*sprom_callback)(struct bcma_bus *bus,
+		struct ssb_sprom *out));
+
 struct bcma_bus {
 	/* The MMIO area. */
 	void __iomem *mmio;
-- 
1.7.5.4
