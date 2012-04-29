Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Apr 2012 02:07:25 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:40587 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903711Ab2D2AFY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Apr 2012 02:05:24 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id D3F968F64;
        Sun, 29 Apr 2012 02:05:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bmwIYmwr77db; Sun, 29 Apr 2012 02:05:20 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 51A5D8F65;
        Sun, 29 Apr 2012 02:05:12 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, ralf@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] ssb/bcma: fill attribute alpha2 from sprom
Date:   Sun, 29 Apr 2012 02:04:10 +0200
Message-Id: <1335657853-23925-6-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335657853-23925-1-git-send-email-hauke@hauke-m.de>
References: <1335657853-23925-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 33074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The attribute country_code and alpha2 are two different attributes in
the sprom. country_code contains some code in an 8 bit coding and
alpha2 contains two chars with the country code. The attributes where
read out wrongly in the past and country_code is only available on
sprom version 1.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/sprom.c         |    3 ++-
 drivers/ssb/pci.c            |   16 +++++++++++-----
 include/linux/ssb/ssb_regs.h |    1 +
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/bcma/sprom.c b/drivers/bcma/sprom.c
index 3e2a600..1799372 100644
--- a/drivers/bcma/sprom.c
+++ b/drivers/bcma/sprom.c
@@ -243,7 +243,8 @@ static void bcma_sprom_extract_r8(struct bcma_bus *bus, const u16 *sprom)
 	SPEX(boardflags2_lo, SSB_SPROM8_BFL2LO, ~0, 0);
 	SPEX(boardflags2_hi, SSB_SPROM8_BFL2HI, ~0, 0);
 
-	SPEX(country_code, SSB_SPROM8_CCODE, ~0, 0);
+	SPEX(alpha2[0], SSB_SPROM8_CCODE, 0xff00, 8);
+	SPEX(alpha2[1], SSB_SPROM8_CCODE, 0x00ff, 0);
 
 	/* Extract cores power info info */
 	for (i = 0; i < ARRAY_SIZE(pwr_info_offset); i++) {
diff --git a/drivers/ssb/pci.c b/drivers/ssb/pci.c
index 113208e..82589d4 100644
--- a/drivers/ssb/pci.c
+++ b/drivers/ssb/pci.c
@@ -360,8 +360,9 @@ static void sprom_extract_r123(struct ssb_sprom *out, const u16 *in)
 	SPEX(et0mdcport, SSB_SPROM1_ETHPHY, SSB_SPROM1_ETHPHY_ET0M, 14);
 	SPEX(et1mdcport, SSB_SPROM1_ETHPHY, SSB_SPROM1_ETHPHY_ET1M, 15);
 	SPEX(board_rev, SSB_SPROM1_BINF, SSB_SPROM1_BINF_BREV, 0);
-	SPEX(country_code, SSB_SPROM1_BINF, SSB_SPROM1_BINF_CCODE,
-	     SSB_SPROM1_BINF_CCODE_SHIFT);
+	if (out->revision == 1)
+		SPEX(country_code, SSB_SPROM1_BINF, SSB_SPROM1_BINF_CCODE,
+		     SSB_SPROM1_BINF_CCODE_SHIFT);
 	SPEX(ant_available_a, SSB_SPROM1_BINF, SSB_SPROM1_BINF_ANTA,
 	     SSB_SPROM1_BINF_ANTA_SHIFT);
 	SPEX(ant_available_bg, SSB_SPROM1_BINF, SSB_SPROM1_BINF_ANTBG,
@@ -387,6 +388,8 @@ static void sprom_extract_r123(struct ssb_sprom *out, const u16 *in)
 	SPEX(boardflags_lo, SSB_SPROM1_BFLLO, 0xFFFF, 0);
 	if (out->revision >= 2)
 		SPEX(boardflags_hi, SSB_SPROM2_BFLHI, 0xFFFF, 0);
+	SPEX(alpha2[0], SSB_SPROM1_CCODE, 0xff00, 8);
+	SPEX(alpha2[1], SSB_SPROM1_CCODE, 0x00ff, 0);
 
 	/* Extract the antenna gain values. */
 	out->antenna_gain.a0 = r123_extract_antgain(out->revision, in,
@@ -456,13 +459,15 @@ static void sprom_extract_r45(struct ssb_sprom *out, const u16 *in)
 	SPEX(et1phyaddr, SSB_SPROM4_ETHPHY, SSB_SPROM4_ETHPHY_ET1A,
 	     SSB_SPROM4_ETHPHY_ET1A_SHIFT);
 	if (out->revision == 4) {
-		SPEX(country_code, SSB_SPROM4_CCODE, 0xFFFF, 0);
+		SPEX(alpha2[0], SSB_SPROM4_CCODE, 0xff00, 8);
+		SPEX(alpha2[1], SSB_SPROM4_CCODE, 0x00ff, 0);
 		SPEX(boardflags_lo, SSB_SPROM4_BFLLO, 0xFFFF, 0);
 		SPEX(boardflags_hi, SSB_SPROM4_BFLHI, 0xFFFF, 0);
 		SPEX(boardflags2_lo, SSB_SPROM4_BFL2LO, 0xFFFF, 0);
 		SPEX(boardflags2_hi, SSB_SPROM4_BFL2HI, 0xFFFF, 0);
 	} else {
-		SPEX(country_code, SSB_SPROM5_CCODE, 0xFFFF, 0);
+		SPEX(alpha2[0], SSB_SPROM5_CCODE, 0xff00, 8);
+		SPEX(alpha2[1], SSB_SPROM5_CCODE, 0x00ff, 0);
 		SPEX(boardflags_lo, SSB_SPROM5_BFLLO, 0xFFFF, 0);
 		SPEX(boardflags_hi, SSB_SPROM5_BFLHI, 0xFFFF, 0);
 		SPEX(boardflags2_lo, SSB_SPROM5_BFL2LO, 0xFFFF, 0);
@@ -525,7 +530,8 @@ static void sprom_extract_r8(struct ssb_sprom *out, const u16 *in)
 		v = in[SPOFF(SSB_SPROM8_IL0MAC) + i];
 		*(((__be16 *)out->il0mac) + i) = cpu_to_be16(v);
 	}
-	SPEX(country_code, SSB_SPROM8_CCODE, 0xFFFF, 0);
+	SPEX(alpha2[0], SSB_SPROM8_CCODE, 0xff00, 8);
+	SPEX(alpha2[1], SSB_SPROM8_CCODE, 0x00ff, 0);
 	SPEX(boardflags_lo, SSB_SPROM8_BFLLO, 0xFFFF, 0);
 	SPEX(boardflags_hi, SSB_SPROM8_BFLHI, 0xFFFF, 0);
 	SPEX(boardflags2_lo, SSB_SPROM8_BFL2LO, 0xFFFF, 0);
diff --git a/include/linux/ssb/ssb_regs.h b/include/linux/ssb/ssb_regs.h
index 40b1ef8..d33bd8f 100644
--- a/include/linux/ssb/ssb_regs.h
+++ b/include/linux/ssb/ssb_regs.h
@@ -228,6 +228,7 @@
 #define  SSB_SPROM1_AGAIN_BG_SHIFT	0
 #define  SSB_SPROM1_AGAIN_A		0xFF00	/* A-PHY */
 #define  SSB_SPROM1_AGAIN_A_SHIFT	8
+#define SSB_SPROM1_CCODE		0x0076
 
 /* SPROM Revision 2 (inherits from rev 1) */
 #define SSB_SPROM2_BFLHI		0x0038	/* Boardflags (high 16 bits) */
-- 
1.7.9.5
