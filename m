Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2012 23:25:15 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:46245 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831901Ab2LFWZNoMXdH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Dec 2012 23:25:13 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id EC7998F66;
        Thu,  6 Dec 2012 23:25:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zjkvW2t8vCQ4; Thu,  6 Dec 2012 23:25:07 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 1648F8F63;
        Thu,  6 Dec 2012 23:25:06 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: BCM47XX: use fallback sprom var for board_{rev,type}
Date:   Thu,  6 Dec 2012 23:25:05 +0100
Message-Id: <1354832705-5926-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35201
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

An SoC normally do not define path variables for board_rev and
board_type and the Broadcom SDK also uses the nvram values without a
prefix in such cases. Do the same to fill these sprom attributes from
nvram and do not leave them empty, because brcmsmac do not like this.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/sprom.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 289cc0a..009c1ec 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -652,12 +652,10 @@ static void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom,
 static void bcm47xx_fill_board_data(struct ssb_sprom *sprom, const char *prefix,
 				    bool fallback)
 {
-	nvram_read_u16(prefix, NULL, "boardrev", &sprom->board_rev, 0,
-		       fallback);
+	nvram_read_u16(prefix, NULL, "boardrev", &sprom->board_rev, 0, true);
 	nvram_read_u16(prefix, NULL, "boardnum", &sprom->board_num, 0,
 		       fallback);
-	nvram_read_u16(prefix, NULL, "boardtype", &sprom->board_type, 0,
-		       fallback);
+	nvram_read_u16(prefix, NULL, "boardtype", &sprom->board_type, 0, true);
 	nvram_read_u32_2(prefix, "boardflags", &sprom->boardflags_lo,
 			 &sprom->boardflags_hi, fallback);
 	nvram_read_u32_2(prefix, "boardflags2", &sprom->boardflags2_lo,
-- 
1.7.10.4
