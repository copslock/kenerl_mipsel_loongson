Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Apr 2012 02:06:11 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:40546 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903707Ab2D2AFS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Apr 2012 02:05:18 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 5E6538F61;
        Sun, 29 Apr 2012 02:05:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N7REbOj0oPAD; Sun, 29 Apr 2012 02:05:14 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 4D8B88F62;
        Sun, 29 Apr 2012 02:05:11 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, ralf@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/8] MIPS: bcm47xx: refactor fetching board data
Date:   Sun, 29 Apr 2012 02:04:07 +0200
Message-Id: <1335657853-23925-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335657853-23925-1-git-send-email-hauke@hauke-m.de>
References: <1335657853-23925-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 33071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Now the fetching of board data also uses nvram_read_u16 and not
simple_strtoul any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c                    |    7 +------
 arch/mips/bcm47xx/sprom.c                    |   12 ++++++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    5 +++++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index d9278a8..53cdb72 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -109,12 +109,7 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 	/* Fill boardinfo structure */
 	memset(&(iv->boardinfo), 0 , sizeof(struct ssb_boardinfo));
 
-	if (nvram_getenv("boardvendor", buf, sizeof(buf)) >= 0)
-		iv->boardinfo.vendor = (u16)simple_strtoul(buf, NULL, 0);
-	else
-		iv->boardinfo.vendor = SSB_BOARDVENDOR_BCM;
-	if (nvram_getenv("boardtype", buf, sizeof(buf)) >= 0)
-		iv->boardinfo.type = (u16)simple_strtoul(buf, NULL, 0);
+	bcm47xx_fill_ssb_boardinfo(&iv->boardinfo, NULL);
 
 	bcm47xx_fill_sprom(&iv->sprom, NULL);
 
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 5c8dcd2..279991a 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -618,3 +618,15 @@ void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
 		bcm47xx_fill_sprom_r1(sprom, prefix);
 	}
 }
+
+#ifdef CONFIG_BCM47XX_SSB
+void bcm47xx_fill_ssb_boardinfo(struct ssb_boardinfo *boardinfo,
+				const char *prefix)
+{
+	nvram_read_u16(prefix, NULL, "boardvendor", &boardinfo->vendor, 0);
+	if (!boardinfo->vendor)
+		boardinfo->vendor = SSB_BOARDVENDOR_BCM;
+
+	nvram_read_u16(prefix, NULL, "boardtype", &boardinfo->type, 0);
+}
+#endif
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
index 5ecaf47..42887c6 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
@@ -47,4 +47,9 @@ extern enum bcm47xx_bus_type bcm47xx_bus_type;
 void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix);
 void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom, const char *prefix);
 
+#ifdef CONFIG_BCM47XX_SSB
+void bcm47xx_fill_ssb_boardinfo(struct ssb_boardinfo *boardinfo,
+				const char *prefix);
+#endif
+
 #endif /* __ASM_BCM47XX_H */
-- 
1.7.9.5
