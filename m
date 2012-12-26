Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 21:52:57 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52641 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823426Ab2LZUwFm47-l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Dec 2012 21:52:05 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 703708E1C;
        Wed, 26 Dec 2012 21:52:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4jjnkXFVY9Pe; Wed, 26 Dec 2012 21:52:00 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id D33218F63;
        Wed, 26 Dec 2012 21:51:44 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/6] MIPS: BCM47XX: nvram add nand flash support
Date:   Wed, 26 Dec 2012 21:51:11 +0100
Message-Id: <1356555074-1230-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
References: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35327
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


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/nvram.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 80e352e..42e5271 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -30,6 +30,7 @@ static int nvram_find_and_copy(u32 base, u32 lim)
 	u32 off;
 	u32 *src, *dst;
 
+	/* TODO: when nvram is on nand flash check for bad blocks first. */
 	off = FLASH_MIN;
 	while (off <= lim) {
 		/* Windowed flash access */
@@ -88,6 +89,12 @@ static int nvram_init_bcma(void)
 	u32 base;
 	u32 lim;
 
+#ifdef CONFIG_BCMA_NFLASH
+	if (cc->nflash.boot) {
+		base = BCMA_SOC_FLASH1;
+		lim = BCMA_SOC_FLASH1_SZ;
+	} else
+#endif
 	if (cc->pflash.present) {
 		base = cc->pflash.window;
 		lim = cc->pflash.window_size;
-- 
1.7.10.4
