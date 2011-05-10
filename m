Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2011 23:32:48 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45930 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491043Ab1EJVcU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2011 23:32:20 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 486338ACF;
        Tue, 10 May 2011 23:32:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JQssoBsPSWN3; Tue, 10 May 2011 23:32:17 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-255-123.ewe-ip-backbone.de [91.97.255.123])
        by hauke-m.de (Postfix) with ESMTPSA id B347587E4;
        Tue, 10 May 2011 23:32:16 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] MIPS: BCM47xx: extend bcm47xx_fill_sprom with prefix.
Date:   Tue, 10 May 2011 23:31:31 +0200
Message-Id: <1305063094-26656-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1305063094-26656-1-git-send-email-hauke@hauke-m.de>
References: <1305063094-26656-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

When an other ssb based device without an own sprom is attached, using
the PCI bus to the main ssb based device, the data normally found in
the sprom will be stored in the nvram on modern devices. The keys, to
load the data from the nvram, are all using some sort of prefix like
pci/1/1/, pci/1/3/ or sb/1/ before the actual key. This patch extends
bcm47xx_fill_sprom() to make it possible to read out these values when
some prefix was used.
The keys for the sprom data used on the main chip does not have a
prefix.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index c95f90b..bbfcf9b 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -57,10 +57,23 @@ static void bcm47xx_machine_halt(void)
 }
 
 #define READ_FROM_NVRAM(_outvar, name, buf) \
-	if (nvram_getenv(name, buf, sizeof(buf)) >= 0)\
+	if (nvram_getprefix(prefix, name, buf, sizeof(buf)) >= 0)\
 		sprom->_outvar = simple_strtoul(buf, NULL, 0);
 
-static void bcm47xx_fill_sprom(struct ssb_sprom *sprom)
+static inline int nvram_getprefix(const char *prefix, char *name,
+				  char *buf, int len)
+{
+	if (prefix) {
+		char key[100];
+
+		snprintf(key, sizeof(key), "%s%s", prefix, name);
+		return nvram_getenv(key, buf, len);
+	}
+
+	return nvram_getenv(name, buf, len);
+}
+
+static void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
 {
 	char buf[100];
 	u32 boardflags;
@@ -69,11 +82,11 @@ static void bcm47xx_fill_sprom(struct ssb_sprom *sprom)
 
 	sprom->revision = 1; /* Fallback: Old hardware does not define this. */
 	READ_FROM_NVRAM(revision, "sromrev", buf);
-	if (nvram_getenv("il0macaddr", buf, sizeof(buf)) >= 0)
+	if (nvram_getprefix(prefix, "il0macaddr", buf, sizeof(buf)) >= 0)
 		nvram_parse_macaddr(buf, sprom->il0mac);
-	if (nvram_getenv("et0macaddr", buf, sizeof(buf)) >= 0)
+	if (nvram_getprefix(prefix, "et0macaddr", buf, sizeof(buf)) >= 0)
 		nvram_parse_macaddr(buf, sprom->et0mac);
-	if (nvram_getenv("et1macaddr", buf, sizeof(buf)) >= 0)
+	if (nvram_getprefix(prefix, "et1macaddr", buf, sizeof(buf)) >= 0)
 		nvram_parse_macaddr(buf, sprom->et1mac);
 	READ_FROM_NVRAM(et0phyaddr, "et0phyaddr", buf);
 	READ_FROM_NVRAM(et1phyaddr, "et1phyaddr", buf);
@@ -125,14 +138,14 @@ static void bcm47xx_fill_sprom(struct ssb_sprom *sprom)
 	READ_FROM_NVRAM(ofdm5gpo, "ofdm5gpo", buf);
 	READ_FROM_NVRAM(ofdm5ghpo, "ofdm5ghpo", buf);
 
-	if (nvram_getenv("boardflags", buf, sizeof(buf)) >= 0) {
+	if (nvram_getprefix(prefix, "boardflags", buf, sizeof(buf)) >= 0) {
 		boardflags = simple_strtoul(buf, NULL, 0);
 		if (boardflags) {
 			sprom->boardflags_lo = (boardflags & 0x0000FFFFU);
 			sprom->boardflags_hi = (boardflags & 0xFFFF0000U) >> 16;
 		}
 	}
-	if (nvram_getenv("boardflags2", buf, sizeof(buf)) >= 0) {
+	if (nvram_getprefix(prefix, "boardflags2", buf, sizeof(buf)) >= 0) {
 		boardflags = simple_strtoul(buf, NULL, 0);
 		if (boardflags) {
 			sprom->boardflags2_lo = (boardflags & 0x0000FFFFU);
@@ -158,7 +171,7 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 	if (nvram_getenv("boardrev", buf, sizeof(buf)) >= 0)
 		iv->boardinfo.rev = (u16)simple_strtoul(buf, NULL, 0);
 
-	bcm47xx_fill_sprom(&iv->sprom);
+	bcm47xx_fill_sprom(&iv->sprom, NULL);
 
 	if (nvram_getenv("cardbus", buf, sizeof(buf)) >= 0)
 		iv->has_cardbus_slot = !!simple_strtoul(buf, NULL, 10);
-- 
1.7.4.1
