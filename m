Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Sep 2012 20:13:37 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:46304 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903299Ab2I2SMc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Sep 2012 20:12:32 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 93E9A87B9;
        Sat, 29 Sep 2012 20:12:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UJkKODY9sq2W; Sat, 29 Sep 2012 20:12:27 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id AC73B8F61;
        Sat, 29 Sep 2012 20:12:18 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, john@phrozen.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] MIPS: BCM47xx: read out full board data
Date:   Sat, 29 Sep 2012 20:12:04 +0200
Message-Id: <1348942326-27195-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348942326-27195-1-git-send-email-hauke@hauke-m.de>
References: <1348942326-27195-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 34561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Read out the full board data independently of the sprom version. Now we
also get the full boardflags and so on if sromrev is not set and our
code would assume a rev 1 device. When a nvram option is not set
because it is not there this is no problem.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/sprom.c |   34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index d3a8897..7fa3da3 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -164,10 +164,6 @@ static void nvram_read_alpha2(const char *prefix, const char *name,
 static void bcm47xx_fill_sprom_r1234589(struct ssb_sprom *sprom,
 					const char *prefix)
 {
-	nvram_read_u16(prefix, NULL, "boardrev", &sprom->board_rev, 0);
-	if (!sprom->board_rev)
-		nvram_read_u16(NULL, NULL, "boardrev", &sprom->board_rev, 0);
-	nvram_read_u16(prefix, NULL, "boardnum", &sprom->board_num, 0);
 	nvram_read_u8(prefix, NULL, "ledbh0", &sprom->gpio0, 0xff);
 	nvram_read_u8(prefix, NULL, "ledbh1", &sprom->gpio1, 0xff);
 	nvram_read_u8(prefix, NULL, "ledbh2", &sprom->gpio2, 0xff);
@@ -214,13 +210,6 @@ static void bcm47xx_fill_sprom_r2389(struct ssb_sprom *sprom,
 	nvram_read_u8(prefix, NULL, "pa1himaxpwr", &sprom->maxpwr_ah, 0);
 }
 
-static void bcm47xx_fill_sprom_r2(struct ssb_sprom *sprom, const char *prefix)
-{
-	nvram_read_u32_2(prefix, "boardflags", &sprom->boardflags_lo,
-			 &sprom->boardflags_hi);
-	nvram_read_u16(prefix, NULL, "boardtype", &sprom->board_type, 0);
-}
-
 static void bcm47xx_fill_sprom_r389(struct ssb_sprom *sprom, const char *prefix)
 {
 	nvram_read_u8(prefix, NULL, "bxa2g", &sprom->bxa2g, 0);
@@ -241,9 +230,6 @@ static void bcm47xx_fill_sprom_r389(struct ssb_sprom *sprom, const char *prefix)
 
 static void bcm47xx_fill_sprom_r3(struct ssb_sprom *sprom, const char *prefix)
 {
-	nvram_read_u32_2(prefix, "boardflags", &sprom->boardflags_lo,
-			 &sprom->boardflags_hi);
-	nvram_read_u16(prefix, NULL, "boardtype", &sprom->board_type, 0);
 	nvram_read_u8(prefix, NULL, "regrev", &sprom->regrev, 0);
 	nvram_read_leddc(prefix, "leddc", &sprom->leddc_on_time,
 			 &sprom->leddc_off_time);
@@ -252,11 +238,6 @@ static void bcm47xx_fill_sprom_r3(struct ssb_sprom *sprom, const char *prefix)
 static void bcm47xx_fill_sprom_r4589(struct ssb_sprom *sprom,
 				     const char *prefix)
 {
-	nvram_read_u32_2(prefix, "boardflags", &sprom->boardflags_lo,
-			 &sprom->boardflags_hi);
-	nvram_read_u32_2(prefix, "boardflags2", &sprom->boardflags2_lo,
-			 &sprom->boardflags2_hi);
-	nvram_read_u16(prefix, NULL, "boardtype", &sprom->board_type, 0);
 	nvram_read_u8(prefix, NULL, "regrev", &sprom->regrev, 0);
 	nvram_read_s8(prefix, NULL, "ag2", &sprom->antenna_gain.a2, 0);
 	nvram_read_s8(prefix, NULL, "ag3", &sprom->antenna_gain.a3, 0);
@@ -555,9 +536,23 @@ void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom, const char *prefix)
 	nvram_read_macaddr(prefix, "il0macaddr", &sprom->il0mac);
 }
 
+static void bcm47xx_fill_board_data(struct ssb_sprom *sprom, const char *prefix)
+{
+	nvram_read_u16(prefix, NULL, "boardrev", &sprom->board_rev, 0);
+	if (!sprom->board_rev)
+		nvram_read_u16(NULL, NULL, "boardrev", &sprom->board_rev, 0);
+	nvram_read_u16(prefix, NULL, "boardnum", &sprom->board_num, 0);
+	nvram_read_u16(prefix, NULL, "boardtype", &sprom->board_type, 0);
+	nvram_read_u32_2(prefix, "boardflags", &sprom->boardflags_lo,
+			 &sprom->boardflags_hi);
+	nvram_read_u32_2(prefix, "boardflags2", &sprom->boardflags2_lo,
+			 &sprom->boardflags2_hi);
+}
+
 void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
 {
 	bcm47xx_fill_sprom_ethernet(sprom, prefix);
+	bcm47xx_fill_board_data(sprom, prefix);
 
 	nvram_read_u8(prefix, NULL, "sromrev", &sprom->revision, 0);
 
@@ -571,7 +566,6 @@ void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix)
 		bcm47xx_fill_sprom_r1234589(sprom, prefix);
 		bcm47xx_fill_sprom_r12389(sprom, prefix);
 		bcm47xx_fill_sprom_r2389(sprom, prefix);
-		bcm47xx_fill_sprom_r2(sprom, prefix);
 		break;
 	case 3:
 		bcm47xx_fill_sprom_r1234589(sprom, prefix);
-- 
1.7.9.5
