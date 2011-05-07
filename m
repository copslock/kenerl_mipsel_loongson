Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2011 14:29:49 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45564 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491132Ab1EGM2N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 May 2011 14:28:13 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 17ADC8ACA;
        Sat,  7 May 2011 14:28:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WLIc8fAmeV2E; Sat,  7 May 2011 14:28:08 +0200 (CEST)
Received: from localhost.localdomain (dyndsl-085-016-167-129.ewe-ip-backbone.de [85.16.167.129])
        by hauke-m.de (Postfix) with ESMTPSA id 74BE58ACC;
        Sat,  7 May 2011 14:28:05 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] MIPS: BCM47xx: extend the filling of sprom from nvram
Date:   Sat,  7 May 2011 14:27:42 +0200
Message-Id: <1304771263-10937-5-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1304771263-10937-1-git-send-email-hauke@hauke-m.de>
References: <1304771263-10937-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

Some members of the struct ssb_sprom where not filled with data
available in the nvram. Some attribute names in the nvram changed from
sprom version 3 to version 4. This patch was done by analyzing the the
pci sprom parser in the ssb code and some open source parts of the
braodcom wireless driver used on embedded devices.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c |   81 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 258ffcf..73b529b 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -61,6 +61,11 @@ static void bcm47xx_machine_halt(void)
 	if (nvram_getprefix(prefix, name, buf, sizeof(buf)) >= 0)\
 		sprom->_outvar = simple_strtoul(buf, NULL, 0);
 
+#define READ_FROM_NVRAM2(_outvar, name1, name2, buf) \
+	if (nvram_getprefix(prefix, name1, buf, sizeof(buf)) >= 0 || \
+	    nvram_getprefix(prefix, name2, buf, sizeof(buf)) >= 0)\
+		sprom->_outvar = simple_strtoul(buf, NULL, 0);
+
 static inline int nvram_getprefix(const char *prefix, char *name,
 				  char *buf, int len)
 {
@@ -74,6 +79,27 @@ static inline int nvram_getprefix(const char *prefix, char *name,
 	return nvram_getenv(name, buf, len);
 }
 
+static u32 nvram_getu32(const char *name, char *buf, int len)
+{
+	int rv;
+	char key[100];
+	u16 var0, var1;
+
+	snprintf(key, sizeof(key), "%s0", name);
+	rv = nvram_getenv(key, buf, len);
+	/* return 0 here so this looks like unset */
+	if (rv < 0)
+		return 0;
+	var0 = simple_strtoul(buf, NULL, 0);
+
+	snprintf(key, sizeof(key), "%s1", name);
+	rv = nvram_getenv(key, buf, len);
+	if (rv < 0)
+		return 0;
+	var1 = simple_strtoul(buf, NULL, 0);
+	return var1 << 16 | var0;
+}
+
 static void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
 {
 	char buf[100];
@@ -83,7 +109,8 @@ static void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
 
 	sprom->revision = 1; /* Fallback: Old hardware does not define this. */
 	READ_FROM_NVRAM(revision, "sromrev", buf);
-	if (nvram_getprefix(prefix, "il0macaddr", buf, sizeof(buf)) >= 0)
+	if (nvram_getprefix(prefix, "il0macaddr", buf, sizeof(buf)) >= 0 ||
+	    nvram_getprefix(prefix, "macaddr", buf, sizeof(buf)) >= 0)
 		nvram_parse_macaddr(buf, sprom->il0mac);
 	if (nvram_getprefix(prefix, "et0macaddr", buf, sizeof(buf)) >= 0)
 		nvram_parse_macaddr(buf, sprom->et0mac);
@@ -109,20 +136,36 @@ static void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
 	READ_FROM_NVRAM(pa1hib0, "pa1hib0", buf);
 	READ_FROM_NVRAM(pa1hib2, "pa1hib1", buf);
 	READ_FROM_NVRAM(pa1hib1, "pa1hib2", buf);
-	READ_FROM_NVRAM(gpio0, "wl0gpio0", buf);
-	READ_FROM_NVRAM(gpio1, "wl0gpio1", buf);
-	READ_FROM_NVRAM(gpio2, "wl0gpio2", buf);
-	READ_FROM_NVRAM(gpio3, "wl0gpio3", buf);
-	READ_FROM_NVRAM(maxpwr_bg, "pa0maxpwr", buf);
-	READ_FROM_NVRAM(maxpwr_al, "pa1lomaxpwr", buf);
-	READ_FROM_NVRAM(maxpwr_a, "pa1maxpwr", buf);
-	READ_FROM_NVRAM(maxpwr_ah, "pa1himaxpwr", buf);
-	READ_FROM_NVRAM(itssi_a, "pa1itssit", buf);
-	READ_FROM_NVRAM(itssi_bg, "pa0itssit", buf);
+	READ_FROM_NVRAM2(gpio0, "ledbh0", "wl0gpio0", buf);
+	READ_FROM_NVRAM2(gpio1, "ledbh1", "wl0gpio1", buf);
+	READ_FROM_NVRAM2(gpio2, "ledbh2", "wl0gpio2", buf);
+	READ_FROM_NVRAM2(gpio3, "ledbh3", "wl0gpio3", buf);
+	READ_FROM_NVRAM2(maxpwr_bg, "maxp2ga0", "pa0maxpwr", buf);
+	READ_FROM_NVRAM2(maxpwr_al, "maxp5gla0", "pa1lomaxpwr", buf);
+	READ_FROM_NVRAM2(maxpwr_a, "maxp5ga0", "pa1maxpwr", buf);
+	READ_FROM_NVRAM2(maxpwr_ah, "maxp5gha0", "pa1himaxpwr", buf);
+	READ_FROM_NVRAM2(itssi_bg, "itt5ga0", "pa0itssit", buf);
+	READ_FROM_NVRAM2(itssi_a, "itt2ga0", "pa1itssit", buf);
 	READ_FROM_NVRAM(tri2g, "tri2g", buf);
 	READ_FROM_NVRAM(tri5gl, "tri5gl", buf);
 	READ_FROM_NVRAM(tri5g, "tri5g", buf);
 	READ_FROM_NVRAM(tri5gh, "tri5gh", buf);
+	READ_FROM_NVRAM(txpid2g[0], "txpid2ga0", buf);
+	READ_FROM_NVRAM(txpid2g[1], "txpid2ga1", buf);
+	READ_FROM_NVRAM(txpid2g[2], "txpid2ga2", buf);
+	READ_FROM_NVRAM(txpid2g[3], "txpid2ga3", buf);
+	READ_FROM_NVRAM(txpid5g[0], "txpid5ga0", buf);
+	READ_FROM_NVRAM(txpid5g[1], "txpid5ga1", buf);
+	READ_FROM_NVRAM(txpid5g[2], "txpid5ga2", buf);
+	READ_FROM_NVRAM(txpid5g[3], "txpid5ga3", buf);
+	READ_FROM_NVRAM(txpid5gl[0], "txpid5gla0", buf);
+	READ_FROM_NVRAM(txpid5gl[1], "txpid5gla1", buf);
+	READ_FROM_NVRAM(txpid5gl[2], "txpid5gla2", buf);
+	READ_FROM_NVRAM(txpid5gl[3], "txpid5gla3", buf);
+	READ_FROM_NVRAM(txpid5gh[0], "txpid5gha0", buf);
+	READ_FROM_NVRAM(txpid5gh[1], "txpid5gha1", buf);
+	READ_FROM_NVRAM(txpid5gh[2], "txpid5gha2", buf);
+	READ_FROM_NVRAM(txpid5gh[3], "txpid5gha3", buf);
 	READ_FROM_NVRAM(rxpo2g, "rxpo2g", buf);
 	READ_FROM_NVRAM(rxpo5g, "rxpo5g", buf);
 	READ_FROM_NVRAM(rssisav2g, "rssisav2g", buf);
@@ -134,10 +177,18 @@ static void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
 	READ_FROM_NVRAM(rssismf5g, "rssismf5g", buf);
 	READ_FROM_NVRAM(bxa5g, "bxa5g", buf);
 	READ_FROM_NVRAM(cck2gpo, "cck2gpo", buf);
-	READ_FROM_NVRAM(ofdm2gpo, "ofdm2gpo", buf);
-	READ_FROM_NVRAM(ofdm5glpo, "ofdm5glpo", buf);
-	READ_FROM_NVRAM(ofdm5gpo, "ofdm5gpo", buf);
-	READ_FROM_NVRAM(ofdm5ghpo, "ofdm5ghpo", buf);
+
+	sprom->ofdm2gpo = nvram_getu32("ofdm2gpo", buf, sizeof(buf));
+	sprom->ofdm5glpo = nvram_getu32("ofdm5glpo", buf, sizeof(buf));
+	sprom->ofdm5gpo = nvram_getu32("ofdm5gpo", buf, sizeof(buf));
+	sprom->ofdm5ghpo = nvram_getu32("ofdm5ghpo", buf, sizeof(buf));
+
+	READ_FROM_NVRAM(antenna_gain.ghz24.a0, "ag0", buf);
+	READ_FROM_NVRAM(antenna_gain.ghz24.a1, "ag1", buf);
+	READ_FROM_NVRAM(antenna_gain.ghz24.a2, "ag2", buf);
+	READ_FROM_NVRAM(antenna_gain.ghz24.a3, "ag3", buf);
+	memcpy(&sprom->antenna_gain.ghz5, &sprom->antenna_gain.ghz24,
+	       sizeof(sprom->antenna_gain.ghz5));
 
 	if (nvram_getprefix(prefix, "boardflags", buf, sizeof(buf)) >= 0) {
 		boardflags = simple_strtoul(buf, NULL, 0);
-- 
1.7.4.1
