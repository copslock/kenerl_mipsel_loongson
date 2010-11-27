Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Nov 2010 17:47:11 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:53695 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492332Ab0K0QqW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Nov 2010 17:46:22 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id E07388799;
        Sat, 27 Nov 2010 17:46:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2rZS2J2QPo+n; Sat, 27 Nov 2010 17:46:18 +0100 (CET)
Received: from localhost.localdomain (host-091-097-248-055.ewe-ip-backbone.de [91.97.248.55])
        by hauke-m.de (Postfix) with ESMTPSA id 7210587AB;
        Sat, 27 Nov 2010 17:46:14 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] MIPS: BCM47xx: Use sscanf for parsing mac address
Date:   Sat, 27 Nov 2010 17:46:00 +0100
Message-Id: <1290876361-4297-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1290876361-4297-1-git-send-email-hauke@hauke-m.de>
References: <1290876361-4297-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

Instead of writing own function for parsing the mac address we now
use sscanf.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c                  |   23 +++--------------------
 arch/mips/include/asm/mach-bcm47xx/nvram.h |    7 +++++++
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 1f61dfd..87a3055 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -56,23 +56,6 @@ static void bcm47xx_machine_halt(void)
 		cpu_relax();
 }
 
-static void str2eaddr(char *str, char *dest)
-{
-	int i = 0;
-
-	if (str == NULL) {
-		memset(dest, 0, 6);
-		return;
-	}
-
-	for (;;) {
-		dest[i++] = (char) simple_strtoul(str, NULL, 16);
-		str += 2;
-		if (!*str++ || i == 6)
-			break;
-	}
-}
-
 #define READ_FROM_NVRAM(_outvar, name, buf) \
 	if (nvram_getenv(name, buf, sizeof(buf)) >= 0)\
 		sprom->_outvar = simple_strtoul(buf, NULL, 0);
@@ -87,11 +70,11 @@ static void bcm47xx_fill_sprom(struct ssb_sprom *sprom)
 	sprom->revision = 1; /* Fallback: Old hardware does not define this. */
 	READ_FROM_NVRAM(revision, "sromrev", buf);
 	if (nvram_getenv("il0macaddr", buf, sizeof(buf)) >= 0)
-		str2eaddr(buf, sprom->il0mac);
+		nvram_parse_macaddr(buf, sprom->il0mac);
 	if (nvram_getenv("et0macaddr", buf, sizeof(buf)) >= 0)
-		str2eaddr(buf, sprom->et0mac);
+		nvram_parse_macaddr(buf, sprom->et0mac);
 	if (nvram_getenv("et1macaddr", buf, sizeof(buf)) >= 0)
-		str2eaddr(buf, sprom->et1mac);
+		nvram_parse_macaddr(buf, sprom->et1mac);
 	READ_FROM_NVRAM(et0phyaddr, "et0phyaddr", buf);
 	READ_FROM_NVRAM(et1phyaddr, "et1phyaddr", buf);
 	READ_FROM_NVRAM(et0mdcport, "et0mdcport", buf);
diff --git a/arch/mips/include/asm/mach-bcm47xx/nvram.h b/arch/mips/include/asm/mach-bcm47xx/nvram.h
index c58ebd8..9759588 100644
--- a/arch/mips/include/asm/mach-bcm47xx/nvram.h
+++ b/arch/mips/include/asm/mach-bcm47xx/nvram.h
@@ -12,6 +12,7 @@
 #define __NVRAM_H
 
 #include <linux/types.h>
+#include <linux/kernel.h>
 
 struct nvram_header {
 	u32 magic;
@@ -36,4 +37,10 @@ struct nvram_header {
 
 extern int nvram_getenv(char *name, char *val, size_t val_len);
 
+static inline void nvram_parse_macaddr(char *buf, u8 *macaddr)
+{
+	sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0], &macaddr[1],
+	       &macaddr[2], &macaddr[3], &macaddr[4], &macaddr[5]);
+}
+
 #endif
-- 
1.7.1
