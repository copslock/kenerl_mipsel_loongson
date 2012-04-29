Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Apr 2012 02:07:50 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:40594 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903717Ab2D2AFZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Apr 2012 02:05:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 961A88F65;
        Sun, 29 Apr 2012 02:05:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qckSHxSP9Xy2; Sun, 29 Apr 2012 02:05:22 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 9FFB58F66;
        Sun, 29 Apr 2012 02:05:12 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, ralf@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/8] ssb: fill board_rev attribute from sprom
Date:   Sun, 29 Apr 2012 02:04:11 +0200
Message-Id: <1335657853-23925-7-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335657853-23925-1-git-send-email-hauke@hauke-m.de>
References: <1335657853-23925-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 33075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This attribute is now used in b43 driver and should be filled for all
sprom versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/ssb/pci.c            |    2 ++
 include/linux/ssb/ssb_regs.h |    1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/ssb/pci.c b/drivers/ssb/pci.c
index 82589d4..2cb604d 100644
--- a/drivers/ssb/pci.c
+++ b/drivers/ssb/pci.c
@@ -458,6 +458,7 @@ static void sprom_extract_r45(struct ssb_sprom *out, const u16 *in)
 	SPEX(et0phyaddr, SSB_SPROM4_ETHPHY, SSB_SPROM4_ETHPHY_ET0A, 0);
 	SPEX(et1phyaddr, SSB_SPROM4_ETHPHY, SSB_SPROM4_ETHPHY_ET1A,
 	     SSB_SPROM4_ETHPHY_ET1A_SHIFT);
+	SPEX(board_rev, SSB_SPROM4_BOARDREV, 0xFFFF, 0);
 	if (out->revision == 4) {
 		SPEX(alpha2[0], SSB_SPROM4_CCODE, 0xff00, 8);
 		SPEX(alpha2[1], SSB_SPROM4_CCODE, 0x00ff, 0);
@@ -530,6 +531,7 @@ static void sprom_extract_r8(struct ssb_sprom *out, const u16 *in)
 		v = in[SPOFF(SSB_SPROM8_IL0MAC) + i];
 		*(((__be16 *)out->il0mac) + i) = cpu_to_be16(v);
 	}
+	SPEX(board_rev, SSB_SPROM8_BOARDREV, 0xFFFF, 0);
 	SPEX(alpha2[0], SSB_SPROM8_CCODE, 0xff00, 8);
 	SPEX(alpha2[1], SSB_SPROM8_CCODE, 0x00ff, 0);
 	SPEX(boardflags_lo, SSB_SPROM8_BFLLO, 0xFFFF, 0);
diff --git a/include/linux/ssb/ssb_regs.h b/include/linux/ssb/ssb_regs.h
index d33bd8f..543795f 100644
--- a/include/linux/ssb/ssb_regs.h
+++ b/include/linux/ssb/ssb_regs.h
@@ -268,6 +268,7 @@
 #define  SSB_SPROM3_OFDMGPO		0x107A	/* G-PHY OFDM Power Offset (4 bytes, BigEndian) */
 
 /* SPROM Revision 4 */
+#define SSB_SPROM4_BOARDREV		0x0042	/* Board revision */
 #define SSB_SPROM4_BFLLO		0x0044	/* Boardflags (low 16 bits) */
 #define SSB_SPROM4_BFLHI		0x0046  /* Board Flags Hi */
 #define SSB_SPROM4_BFL2LO		0x0048	/* Board flags 2 (low 16 bits) */
-- 
1.7.9.5
