Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2012 01:28:30 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:33045 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823707Ab2K0A0TuR7Ic (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2012 01:26:19 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 6FF448F66;
        Tue, 27 Nov 2012 01:26:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QP9AFKGVIL71; Tue, 27 Nov 2012 01:26:15 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 2694B8F67;
        Tue, 27 Nov 2012 01:25:45 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com, wim@iguana.be
Cc:     linux-wireless@vger.kernel.org, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        zajec5@gmail.com, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 07/15] bcma: set the pmu watchdog if available
Date:   Tue, 27 Nov 2012 01:25:17 +0100
Message-Id: <1353975925-32056-8-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1353975925-32056-1-git-send-email-hauke@hauke-m.de>
References: <1353975925-32056-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35140
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

Mostly all bcma based devices have a PMU and the PMU watchdog should be
used and not the old one in chip common. This patch also calculates the
maximal number the watchdog could be set to.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/driver_chipcommon.c |   42 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/bcma/driver_chipcommon.c b/drivers/bcma/driver_chipcommon.c
index ef68553..7c132e5 100644
--- a/drivers/bcma/driver_chipcommon.c
+++ b/drivers/bcma/driver_chipcommon.c
@@ -31,6 +31,28 @@ static u32 bcma_chipco_alp_clock(struct bcma_drv_cc *cc)
 	return 20000000;
 }
 
+static u32 bcma_chipco_watchdog_get_max_timer(struct bcma_drv_cc *cc)
+{
+	struct bcma_bus *bus = cc->core->bus;
+	u32 nb;
+
+	if (cc->capabilities & BCMA_CC_CAP_PMU) {
+		if (bus->chipinfo.id == BCMA_CHIP_ID_BCM4706)
+			nb = 32;
+		else if (cc->core->id.rev < 26)
+			nb = 16;
+		else
+			nb = (cc->core->id.rev >= 37) ? 32 : 24;
+	} else {
+		nb = 28;
+	}
+	if (nb == 32)
+		return 0xffffffff;
+	else
+		return (1 << nb) - 1;
+}
+
+
 void bcma_core_chipcommon_early_init(struct bcma_drv_cc *cc)
 {
 	if (cc->early_setup_done)
@@ -85,8 +107,24 @@ void bcma_core_chipcommon_init(struct bcma_drv_cc *cc)
 /* Set chip watchdog reset timer to fire in 'ticks' backplane cycles */
 void bcma_chipco_watchdog_timer_set(struct bcma_drv_cc *cc, u32 ticks)
 {
-	/* instant NMI */
-	bcma_cc_write32(cc, BCMA_CC_WATCHDOG, ticks);
+	u32 maxt;
+	enum bcma_clkmode clkmode;
+
+	maxt = bcma_chipco_watchdog_get_max_timer(cc);
+	if (cc->capabilities & BCMA_CC_CAP_PMU) {
+		if (ticks == 1)
+			ticks = 2;
+		else if (ticks > maxt)
+			ticks = maxt;
+		bcma_cc_write32(cc, BCMA_CC_PMU_WATCHDOG, ticks);
+	} else {
+		clkmode = ticks ? BCMA_CLKMODE_FAST : BCMA_CLKMODE_DYNAMIC;
+		bcma_core_set_clockmode(cc->core, clkmode);
+		if (ticks > maxt)
+			ticks = maxt;
+		/* instant NMI */
+		bcma_cc_write32(cc, BCMA_CC_WATCHDOG, ticks);
+	}
 }
 
 void bcma_chipco_irq_mask(struct bcma_drv_cc *cc, u32 mask, u32 value)
-- 
1.7.10.4
