Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2012 19:35:09 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:35828 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903565Ab2BSSdb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Feb 2012 19:33:31 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id CA95A8F63;
        Sun, 19 Feb 2012 19:33:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uqxQ0XaQMfKw; Sun, 19 Feb 2012 19:33:16 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 915AF8F65;
        Sun, 19 Feb 2012 19:32:48 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/11] ssb: add some missing sprom attributes
Date:   Sun, 19 Feb 2012 19:32:19 +0100
Message-Id: <1329676345-15856-6-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch extends the sprom struct to contain all sprom attributes
found in sprom version 1 to 9. This was done accordingly to the open
source part of the Braodcom SDK.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/ssb/ssb.h |   76 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 75 insertions(+), 1 deletions(-)

diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
index 44e486e..992c47a 100644
--- a/include/linux/ssb/ssb.h
+++ b/include/linux/ssb/ssb.h
@@ -32,6 +32,8 @@ struct ssb_sprom {
 	u8 et0mdcport;		/* MDIO for enet0 */
 	u8 et1mdcport;		/* MDIO for enet1 */
 	u16 board_rev;		/* Board revision number from SPROM. */
+	u16 board_num;		/* Board number number from SPROM. */
+	u16 board_type;		/* Board type number from SPROM. */
 	u8 country_code;	/* Country Code */
 	char ccode[2];		/* Country Code as two chars like EU or US */
 	u8 leddc_on_time;	/* LED Powersave Duty Cycle On Count */
@@ -107,7 +109,79 @@ struct ssb_sprom {
 		} ghz5;
 	} fem;
 
-	/* TODO - add any parameters needed from rev 2, 3, 4, 5 or 8 SPROMs */
+	u16 mcs2gpo[8];
+	u16 mcs5gpo[8];
+	u16 mcs5glpo[8];
+	u16 mcs5ghpo[8];
+	u8 opo;
+
+	u8 rxgainerr2ga[3];
+	u8 rxgainerr5gla[3];
+	u8 rxgainerr5gma[3];
+	u8 rxgainerr5gha[3];
+	u8 rxgainerr5gua[3];
+
+	u8 noiselvl2ga[3];
+	u8 noiselvl5gla[3];
+	u8 noiselvl5gma[3];
+	u8 noiselvl5gha[3];
+	u8 noiselvl5gua[3];
+
+	u8 regrev;
+	u8 txchain;
+	u8 rxchain;
+	u8 antswitch;
+	u16 cddpo;
+	u16 stbcpo;
+	u16 bw40po;
+	u16 bwduppo;
+
+	u8 tempthresh;
+	u8 tempoffset;
+	u16 rawtempsense;
+	u8 measpower;
+	u8 tempsense_slope;
+	u8 tempcorrx;
+	u8 tempsense_option;
+	u8 freqoffset_corr;
+	u8 iqcal_swp_dis;
+	u8 hw_iqcal_en;
+	u8 elna2g;
+	u8 elna5g;
+	u8 phycal_tempdelta;
+	u8 temps_period;
+	u8 temps_hysteresis;
+	u8 measpower1;
+	u8 measpower2;
+	u8 pcieingress_war;
+
+	/* power per rate from sromrev 9 */
+	u16 cckbw202gpo;
+	u16 cckbw20ul2gpo;
+	u32 legofdmbw202gpo;
+	u32 legofdmbw20ul2gpo;
+	u32 legofdmbw205glpo;
+	u32 legofdmbw20ul5glpo;
+	u32 legofdmbw205gmpo;
+	u32 legofdmbw20ul5gmpo;
+	u32 legofdmbw205ghpo;
+	u32 legofdmbw20ul5ghpo;
+	u32 mcsbw202gpo;
+	u32 mcsbw20ul2gpo;
+	u32 mcsbw402gpo;
+	u32 mcsbw205glpo;
+	u32 mcsbw20ul5glpo;
+	u32 mcsbw405glpo;
+	u32 mcsbw205gmpo;
+	u32 mcsbw20ul5gmpo;
+	u32 mcsbw405gmpo;
+	u32 mcsbw205ghpo;
+	u32 mcsbw20ul5ghpo;
+	u32 mcsbw405ghpo;
+	u16 mcs32po;
+	u16 legofdm40duppo;
+	u8 sar2g;
+	u8 sar5g;
 };
 
 /* Information about the PCB the circuitry is soldered on. */
-- 
1.7.5.4
