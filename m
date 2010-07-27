Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jul 2010 22:13:50 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:35845 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492706Ab0G0UM7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jul 2010 22:12:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id A6F267E2C;
        Tue, 27 Jul 2010 22:12:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CjzZTLFXlfRh; Tue, 27 Jul 2010 22:12:54 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-249-197.ewe-ip-backbone.de [91.97.249.197])
        by hauke-m.de (Postfix) with ESMTPSA id A4FE185DC;
        Tue, 27 Jul 2010 22:12:53 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] MIPS: BCM47xx: Fill values for b43 into ssb sprom
Date:   Tue, 27 Jul 2010 22:12:44 +0200
Message-Id: <1280261566-8247-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280261566-8247-1-git-send-email-hauke@hauke-m.de>
References: <1280261566-8247-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

Most of the values are stored in the nvram and not in the CFE. At first
the nvram should be read and if there is no value it should look into
the CFE. Now more values are read out because the b43 and b43legacy
drivers needs them.

Some parts of this patch have been in OpenWRT for a long time and were
made by Michael Buesch.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c |  131 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 98 insertions(+), 33 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index b1aee33..516ac89 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -74,6 +74,95 @@ static void str2eaddr(char *str, char *dest)
 	}
 }
 
+#define READ_FROM_NVRAM(_outvar, name, buf) \
+	if (nvram_getenv(name, buf, sizeof(buf)) >= 0 || \
+	    cfe_getenv(name, buf, sizeof(buf)) >= 0) \
+		sprom->_outvar = simple_strtoul(buf, NULL, 0);
+
+static void bcm47xx_fill_sprom(struct ssb_sprom *sprom)
+{
+	char buf[100];
+	u32 boardflags;
+
+	memset(sprom, 0, sizeof(struct ssb_sprom));
+
+	sprom->revision = 1; /* Fallback: Old hardware does not define this. */
+	READ_FROM_NVRAM(revision, "sromrev", buf);
+	if (nvram_getenv("il0macaddr", buf, sizeof(buf)) >= 0 ||
+	    cfe_getenv("il0macaddr", buf, sizeof(buf)) >= 0)
+		str2eaddr(buf, sprom->il0mac);
+	if (nvram_getenv("et0macaddr", buf, sizeof(buf)) >= 0 ||
+	    cfe_getenv("et0macaddr", buf, sizeof(buf)) >= 0)
+		str2eaddr(buf, sprom->et0mac);
+	if (nvram_getenv("et1macaddr", buf, sizeof(buf)) >= 0 ||
+	    cfe_getenv("et1macaddr", buf, sizeof(buf)) >= 0)
+		str2eaddr(buf, sprom->et1mac);
+	READ_FROM_NVRAM(et0phyaddr, "et0phyaddr", buf);
+	READ_FROM_NVRAM(et1phyaddr, "et1phyaddr", buf);
+	READ_FROM_NVRAM(et0mdcport, "et0mdcport", buf);
+	READ_FROM_NVRAM(et1mdcport, "et1mdcport", buf);
+	READ_FROM_NVRAM(board_rev, "boardrev", buf);
+	READ_FROM_NVRAM(country_code, "ccode", buf);
+	READ_FROM_NVRAM(ant_available_a, "aa5g", buf);
+	READ_FROM_NVRAM(ant_available_bg, "aa2g", buf);
+	READ_FROM_NVRAM(pa0b0, "pa0b0", buf);
+	READ_FROM_NVRAM(pa0b1, "pa0b1", buf);
+	READ_FROM_NVRAM(pa0b2, "pa0b2", buf);
+	READ_FROM_NVRAM(pa1b0, "pa1b0", buf);
+	READ_FROM_NVRAM(pa1b1, "pa1b1", buf);
+	READ_FROM_NVRAM(pa1b2, "pa1b2", buf);
+	READ_FROM_NVRAM(pa1lob0, "pa1lob0", buf);
+	READ_FROM_NVRAM(pa1lob2, "pa1lob1", buf);
+	READ_FROM_NVRAM(pa1lob1, "pa1lob2", buf);
+	READ_FROM_NVRAM(pa1hib0, "pa1hib0", buf);
+	READ_FROM_NVRAM(pa1hib2, "pa1hib1", buf);
+	READ_FROM_NVRAM(pa1hib1, "pa1hib2", buf);
+	READ_FROM_NVRAM(gpio0, "wl0gpio0", buf);
+	READ_FROM_NVRAM(gpio1, "wl0gpio1", buf);
+	READ_FROM_NVRAM(gpio2, "wl0gpio2", buf);
+	READ_FROM_NVRAM(gpio3, "wl0gpio3", buf);
+	READ_FROM_NVRAM(maxpwr_bg, "pa0maxpwr", buf);
+	READ_FROM_NVRAM(maxpwr_al, "pa1lomaxpwr", buf);
+	READ_FROM_NVRAM(maxpwr_a, "pa1maxpwr", buf);
+	READ_FROM_NVRAM(maxpwr_ah, "pa1himaxpwr", buf);
+	READ_FROM_NVRAM(itssi_a, "pa1itssit", buf);
+	READ_FROM_NVRAM(itssi_bg, "pa0itssit", buf);
+	READ_FROM_NVRAM(tri2g, "tri2g", buf);
+	READ_FROM_NVRAM(tri5gl, "tri5gl", buf);
+	READ_FROM_NVRAM(tri5g, "tri5g", buf);
+	READ_FROM_NVRAM(tri5gh, "tri5gh", buf);
+	READ_FROM_NVRAM(rxpo2g, "rxpo2g", buf);
+	READ_FROM_NVRAM(rxpo5g, "rxpo5g", buf);
+	READ_FROM_NVRAM(rssisav2g, "rssisav2g", buf);
+	READ_FROM_NVRAM(rssismc2g, "rssismc2g", buf);
+	READ_FROM_NVRAM(rssismf2g, "rssismf2g", buf);
+	READ_FROM_NVRAM(bxa2g, "bxa2g", buf);
+	READ_FROM_NVRAM(rssisav5g, "rssisav5g", buf);
+	READ_FROM_NVRAM(rssismc5g, "rssismc5g", buf);
+	READ_FROM_NVRAM(rssismf5g, "rssismf5g", buf);
+	READ_FROM_NVRAM(bxa5g, "bxa5g", buf);
+	READ_FROM_NVRAM(cck2gpo, "cck2gpo", buf);
+	READ_FROM_NVRAM(ofdm2gpo, "ofdm2gpo", buf);
+	READ_FROM_NVRAM(ofdm5glpo, "ofdm5glpo", buf);
+	READ_FROM_NVRAM(ofdm5gpo, "ofdm5gpo", buf);
+	READ_FROM_NVRAM(ofdm5ghpo, "ofdm5ghpo", buf);
+
+	if (nvram_getenv("boardflags", buf, sizeof(buf)) >= 0 ||
+	    cfe_getenv("boardflags", buf, sizeof(buf)) >= 0)
+		boardflags = simple_strtoul(buf, NULL, 0);
+	if (boardflags) {
+		sprom->boardflags_lo = (boardflags & 0x0000FFFFU);
+		sprom->boardflags_hi = (boardflags & 0xFFFF0000U) >> 16;
+	}
+	if (nvram_getenv("boardflags2", buf, sizeof(buf)) >= 0 ||
+	    cfe_getenv("boardflags2", buf, sizeof(buf)) >= 0)
+		boardflags = simple_strtoul(buf, NULL, 0);
+	if (boardflags) {
+		sprom->boardflags2_lo = (boardflags & 0x0000FFFFU);
+		sprom->boardflags2_hi = (boardflags & 0xFFFF0000U) >> 16;
+	}
+}
+
 static int bcm47xx_get_invariants(struct ssb_bus *bus,
 				   struct ssb_init_invariants *iv)
 {
@@ -82,43 +171,19 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 	/* Fill boardinfo structure */
 	memset(&(iv->boardinfo), 0 , sizeof(struct ssb_boardinfo));
 
-	if (cfe_getenv("boardvendor", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("boardvendor", buf, sizeof(buf)) >= 0)
+	iv->boardinfo.vendor = SSB_BOARDVENDOR_BCM;
+	if (nvram_getenv("boardtype", buf, sizeof(buf)) >= 0 ||
+	    cfe_getenv("boardtype", buf, sizeof(buf)) >= 0)
 		iv->boardinfo.type = (u16)simple_strtoul(buf, NULL, 0);
-	if (cfe_getenv("boardtype", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("boardtype", buf, sizeof(buf)) >= 0)
-		iv->boardinfo.type = (u16)simple_strtoul(buf, NULL, 0);
-	if (cfe_getenv("boardrev", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("boardrev", buf, sizeof(buf)) >= 0)
+	if (nvram_getenv("boardrev", buf, sizeof(buf)) >= 0 ||
+	    cfe_getenv("boardrev", buf, sizeof(buf)) >= 0)
 		iv->boardinfo.rev = (u16)simple_strtoul(buf, NULL, 0);
 
-	/* Fill sprom structure */
-	memset(&(iv->sprom), 0, sizeof(struct ssb_sprom));
-	iv->sprom.revision = 3;
-
-	if (cfe_getenv("et0macaddr", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("et0macaddr", buf, sizeof(buf)) >= 0)
-		str2eaddr(buf, iv->sprom.et0mac);
-
-	if (cfe_getenv("et1macaddr", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("et1macaddr", buf, sizeof(buf)) >= 0)
-		str2eaddr(buf, iv->sprom.et1mac);
-
-	if (cfe_getenv("et0phyaddr", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("et0phyaddr", buf, sizeof(buf)) >= 0)
-		iv->sprom.et0phyaddr = simple_strtoul(buf, NULL, 0);
-
-	if (cfe_getenv("et1phyaddr", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("et1phyaddr", buf, sizeof(buf)) >= 0)
-		iv->sprom.et1phyaddr = simple_strtoul(buf, NULL, 0);
-
-	if (cfe_getenv("et0mdcport", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("et0mdcport", buf, sizeof(buf)) >= 0)
-		iv->sprom.et0mdcport = simple_strtoul(buf, NULL, 10);
+	bcm47xx_fill_sprom(&iv->sprom);
 
-	if (cfe_getenv("et1mdcport", buf, sizeof(buf)) >= 0 ||
-	    nvram_getenv("et1mdcport", buf, sizeof(buf)) >= 0)
-		iv->sprom.et1mdcport = simple_strtoul(buf, NULL, 10);
+	if (nvram_getenv("cardbus", buf, sizeof(buf)) >= 0 ||
+	    cfe_getenv("cardbus", buf, sizeof(buf)) >= 0)
+		iv->has_cardbus_slot = !!simple_strtoul(buf, NULL, 10);
 
 	return 0;
 }
-- 
1.7.0.4
