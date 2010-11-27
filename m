Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Nov 2010 17:46:23 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:53682 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492330Ab0K0QqT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Nov 2010 17:46:19 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id E976787AE;
        Sat, 27 Nov 2010 17:46:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5Z0jJkvlfnu6; Sat, 27 Nov 2010 17:46:13 +0100 (CET)
Received: from localhost.localdomain (host-091-097-248-055.ewe-ip-backbone.de [91.97.248.55])
        by hauke-m.de (Postfix) with ESMTPSA id 9A30A8799;
        Sat, 27 Nov 2010 17:46:13 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] MIPS: BCM47xx: Do not read config from CFE
Date:   Sat, 27 Nov 2010 17:45:58 +0100
Message-Id: <1290876361-4297-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.1
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

The config options read out here are not stored in CFE, but only in
NVRAM on the devices. Remove reading from CFE and only access the NVRAM.
Reading out CFE does not harm, but is useless here.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c |   28 +++++++++-------------------
 1 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index b1aee33..2c6bdad 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -32,7 +32,6 @@
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <bcm47xx.h>
-#include <asm/fw/cfe/cfe_api.h>
 #include <asm/mach-bcm47xx/nvram.h>
 
 struct ssb_bus ssb_bcm47xx;
@@ -82,42 +81,33 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 	/* Fill boardinfo structure */
 	memset(&(iv->boardinfo), 0 , sizeof(struct ssb_boardinfo));
 
-	if (cfe_getenv("boardvendor", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("boardvendor", buf, sizeof(buf)) >= 0)
+	if (nvram_getenv("boardvendor", buf, sizeof(buf)) >= 0)
 		iv->boardinfo.type = (u16)simple_strtoul(buf, NULL, 0);
-	if (cfe_getenv("boardtype", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("boardtype", buf, sizeof(buf)) >= 0)
+	if (nvram_getenv("boardtype", buf, sizeof(buf)) >= 0)
 		iv->boardinfo.type = (u16)simple_strtoul(buf, NULL, 0);
-	if (cfe_getenv("boardrev", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("boardrev", buf, sizeof(buf)) >= 0)
+	if (nvram_getenv("boardrev", buf, sizeof(buf)) >= 0)
 		iv->boardinfo.rev = (u16)simple_strtoul(buf, NULL, 0);
 
 	/* Fill sprom structure */
 	memset(&(iv->sprom), 0, sizeof(struct ssb_sprom));
 	iv->sprom.revision = 3;
 
-	if (cfe_getenv("et0macaddr", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("et0macaddr", buf, sizeof(buf)) >= 0)
+	if (nvram_getenv("et0macaddr", buf, sizeof(buf)) >= 0)
 		str2eaddr(buf, iv->sprom.et0mac);
 
-	if (cfe_getenv("et1macaddr", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("et1macaddr", buf, sizeof(buf)) >= 0)
+	if (nvram_getenv("et1macaddr", buf, sizeof(buf)) >= 0)
 		str2eaddr(buf, iv->sprom.et1mac);
 
-	if (cfe_getenv("et0phyaddr", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("et0phyaddr", buf, sizeof(buf)) >= 0)
+	if (nvram_getenv("et0phyaddr", buf, sizeof(buf)) >= 0)
 		iv->sprom.et0phyaddr = simple_strtoul(buf, NULL, 0);
 
-	if (cfe_getenv("et1phyaddr", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("et1phyaddr", buf, sizeof(buf)) >= 0)
+	if (nvram_getenv("et1phyaddr", buf, sizeof(buf)) >= 0)
 		iv->sprom.et1phyaddr = simple_strtoul(buf, NULL, 0);
 
-	if (cfe_getenv("et0mdcport", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("et0mdcport", buf, sizeof(buf)) >= 0)
+	if (nvram_getenv("et0mdcport", buf, sizeof(buf)) >= 0)
 		iv->sprom.et0mdcport = simple_strtoul(buf, NULL, 10);
 
-	if (cfe_getenv("et1mdcport", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("et1mdcport", buf, sizeof(buf)) >= 0)
+	if (nvram_getenv("et1mdcport", buf, sizeof(buf)) >= 0)
 		iv->sprom.et1mdcport = simple_strtoul(buf, NULL, 10);
 
 	return 0;
-- 
1.7.1
