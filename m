Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Nov 2010 19:26:49 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:43793 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492046Ab0K0S0q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Nov 2010 19:26:46 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B692E87AB;
        Sat, 27 Nov 2010 19:26:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mTOsKGyhSTMi; Sat, 27 Nov 2010 19:26:42 +0100 (CET)
Received: from localhost.localdomain (host-091-097-248-055.ewe-ip-backbone.de [91.97.248.55])
        by hauke-m.de (Postfix) with ESMTPSA id 097A087AA;
        Sat, 27 Nov 2010 19:26:41 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     mb@bu3sch.de, netdev@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH RESEND] ssb: fix nvram_get on bcm47xx platform
Date:   Sat, 27 Nov 2010 19:26:32 +0100
Message-Id: <1290882392-28327-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.1
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

The nvram_get function was never in the mainline kernel, it only
existed in an external OpenWrt patch. Use nvram_getenv function, which
is in mainline and use an include instead of an extra function
declaration.
et0macaddr contains the mac address in text from like
00:11:22:33:44:55. We have to parse it before adding it into macaddr.

nvram_parse_macaddr will be merged into asm/mach-bcm47xx/nvram.h though
the MIPS git tree and will be available soon. It will not build now
without nvram_parse_macaddr, but it haven't done before.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/ssb/ssb_driver_gige.h |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/ssb/ssb_driver_gige.h b/include/linux/ssb/ssb_driver_gige.h
index 942e387..eba52a1 100644
--- a/include/linux/ssb/ssb_driver_gige.h
+++ b/include/linux/ssb/ssb_driver_gige.h
@@ -96,16 +96,21 @@ static inline bool ssb_gige_must_flush_posted_writes(struct pci_dev *pdev)
 	return 0;
 }
 
-extern char * nvram_get(const char *name);
+#ifdef CONFIG_BCM47XX
+#include <asm/mach-bcm47xx/nvram.h>
 /* Get the device MAC address */
 static inline void ssb_gige_get_macaddr(struct pci_dev *pdev, u8 *macaddr)
 {
-#ifdef CONFIG_BCM47XX
-	char *res = nvram_get("et0macaddr");
-	if (res)
-		memcpy(macaddr, res, 6);
-#endif
+	char buf[20];
+	if (nvram_getenv("et0macaddr", buf, sizeof(buf)) < 0)
+		return;
+	nvram_parse_macaddr(buf, macaddr);
 }
+#else
+static inline void ssb_gige_get_macaddr(struct pci_dev *pdev, u8 *macaddr)
+{
+}
+#endif
 
 extern int ssb_gige_pcibios_plat_dev_init(struct ssb_device *sdev,
 					  struct pci_dev *pdev);
-- 
1.7.1
