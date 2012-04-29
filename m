Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Apr 2012 02:07:00 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:40577 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903710Ab2D2AFW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Apr 2012 02:05:22 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id EEBEB8F63;
        Sun, 29 Apr 2012 02:05:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OLIXd3SgeJY9; Sun, 29 Apr 2012 02:05:18 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 018A38F64;
        Sun, 29 Apr 2012 02:05:11 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, ralf@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] MIPS: bcm47xx: read baordrev without prefix from sprom
Date:   Sun, 29 Apr 2012 02:04:09 +0200
Message-Id: <1335657853-23925-5-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335657853-23925-1-git-send-email-hauke@hauke-m.de>
References: <1335657853-23925-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 33073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

When the boardrev with a prefix is not available, try to read it
without a prefix. This is based on code from the Broadcom SDK.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/sprom.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index a29d207..17282e0 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -165,6 +165,8 @@ static void bcm47xx_fill_sprom_r1234589(struct ssb_sprom *sprom,
 					const char *prefix)
 {
 	nvram_read_u16(prefix, NULL, "boardrev", &sprom->board_rev, 0);
+	if (!sprom->board_rev)
+		nvram_read_u16(NULL, NULL, "boardrev", &sprom->board_rev, 0);
 	nvram_read_u16(prefix, NULL, "boardnum", &sprom->board_num, 0);
 	nvram_read_u8(prefix, NULL, "ledbh0", &sprom->gpio0, 0xff);
 	nvram_read_u8(prefix, NULL, "ledbh1", &sprom->gpio1, 0xff);
-- 
1.7.9.5
