Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2012 18:47:30 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:37769 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831668Ab2LERr3i-2nm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Dec 2012 18:47:29 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 82FCE8F61;
        Wed,  5 Dec 2012 18:47:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vyPF2enVWUjN; Wed,  5 Dec 2012 18:46:52 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 161818F62;
        Wed,  5 Dec 2012 18:46:23 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com, wim@iguana.be
Cc:     linux-wireless@vger.kernel.org, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        zajec5@gmail.com, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 02/11] bcma: add bcma_chipco_alp_clock
Date:   Wed,  5 Dec 2012 18:45:59 +0100
Message-Id: <1354729568-19993-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1354729568-19993-1-git-send-email-hauke@hauke-m.de>
References: <1354729568-19993-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35186
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

For devices without a PMU the alp clock is always 20000000.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/driver_chipcommon.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bcma/driver_chipcommon.c b/drivers/bcma/driver_chipcommon.c
index ffd74e5..ef68553 100644
--- a/drivers/bcma/driver_chipcommon.c
+++ b/drivers/bcma/driver_chipcommon.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2005, Broadcom Corporation
  * Copyright 2006, 2007, Michael Buesch <m@bues.ch>
+ * Copyright 2012, Hauke Mehrtens <hauke@hauke-m.de>
  *
  * Licensed under the GNU/GPL. See COPYING for details.
  */
@@ -22,6 +23,14 @@ static inline u32 bcma_cc_write32_masked(struct bcma_drv_cc *cc, u16 offset,
 	return value;
 }
 
+static u32 bcma_chipco_alp_clock(struct bcma_drv_cc *cc)
+{
+	if (cc->capabilities & BCMA_CC_CAP_PMU)
+		return bcma_pmu_alp_clock(cc);
+
+	return 20000000;
+}
+
 void bcma_core_chipcommon_early_init(struct bcma_drv_cc *cc)
 {
 	if (cc->early_setup_done)
@@ -131,8 +140,7 @@ void bcma_chipco_serial_init(struct bcma_drv_cc *cc)
 	struct bcma_serial_port *ports = cc->serial_ports;
 
 	if (ccrev >= 11 && ccrev != 15) {
-		/* Fixed ALP clock */
-		baud_base = bcma_pmu_alp_clock(cc);
+		baud_base = bcma_chipco_alp_clock(cc);
 		if (ccrev >= 21) {
 			/* Turn off UART clock before switching clocksource. */
 			bcma_cc_write32(cc, BCMA_CC_CORECTL,
-- 
1.7.10.4
