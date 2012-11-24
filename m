Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Nov 2012 23:27:22 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:55136 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825698Ab2KXWZWDRfW0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Nov 2012 23:25:22 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id A4BE98F7E;
        Sat, 24 Nov 2012 23:25:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KEmmdfa6ZKZF; Sat, 24 Nov 2012 23:25:16 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 8323F8F68;
        Sat, 24 Nov 2012 23:24:37 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     linux-wireless@vger.kernel.org, wim@iguana.be,
        linux-watchdog@vger.kernel.org, castet.matthieu@free.fr,
        biblbroks@sezampro.rs, m@bues.ch, zajec5@gmail.com,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/15] bcma: add methods for watchdog driver
Date:   Sat, 24 Nov 2012 23:24:08 +0100
Message-Id: <1353795855-22236-9-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1353795855-22236-1-git-send-email-hauke@hauke-m.de>
References: <1353795855-22236-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35115
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

The watchdog driver wants to set the watchdog timeout in ms and not in
ticks, which is depending on the SoC type and the clock.
Calculate the number of ticks per millisecond and provide two functions
for the watchdog driver. Also return the ticks or millisecond the timer
was set to in case the provided value was bigger than the max allowed
value.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/driver_chipcommon.c            |   38 ++++++++++++++++++++++++++-
 include/linux/bcma/bcma_driver_chipcommon.h |    4 +--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/bcma/driver_chipcommon.c b/drivers/bcma/driver_chipcommon.c
index 7c132e5..1172226 100644
--- a/drivers/bcma/driver_chipcommon.c
+++ b/drivers/bcma/driver_chipcommon.c
@@ -10,6 +10,7 @@
  */
 
 #include "bcma_private.h"
+#include <linux/bcm47xx_wdt.h>
 #include <linux/export.h>
 #include <linux/bcma/bcma.h>
 
@@ -52,6 +53,39 @@ static u32 bcma_chipco_watchdog_get_max_timer(struct bcma_drv_cc *cc)
 		return (1 << nb) - 1;
 }
 
+static u32 bcma_chipco_watchdog_timer_set_wdt(struct bcm47xx_wdt *wdt,
+					      u32 ticks)
+{
+	struct bcma_drv_cc *cc = bcm47xx_wdt_get_drvdata(wdt);
+
+	return bcma_chipco_watchdog_timer_set(cc, ticks);
+}
+
+static u32 bcma_chipco_watchdog_timer_set_ms_wdt(struct bcm47xx_wdt *wdt,
+						 u32 ms)
+{
+	struct bcma_drv_cc *cc = bcm47xx_wdt_get_drvdata(wdt);
+	u32 ticks;
+
+	ticks = bcma_chipco_watchdog_timer_set(cc, cc->ticks_per_ms * ms);
+	return ticks / cc->ticks_per_ms;
+}
+
+static int bcma_chipco_watchdog_ticks_per_ms(struct bcma_drv_cc *cc)
+{
+	struct bcma_bus *bus = cc->core->bus;
+
+	if (cc->capabilities & BCMA_CC_CAP_PMU) {
+		if (bus->chipinfo.id == BCMA_CHIP_ID_BCM4706)
+			/* 4706 CC and PMU watchdogs are clocked at 1/4 of ALP clock */
+			return bcma_chipco_alp_clock(cc) / 4000;
+		else
+			/* based on 32KHz ILP clock */
+			return 32;
+	} else {
+		return bcma_chipco_alp_clock(cc) / 1000;
+	}
+}
 
 void bcma_core_chipcommon_early_init(struct bcma_drv_cc *cc)
 {
@@ -100,12 +134,13 @@ void bcma_core_chipcommon_init(struct bcma_drv_cc *cc)
 			((leddc_on << BCMA_CC_GPIOTIMER_ONTIME_SHIFT) |
 			 (leddc_off << BCMA_CC_GPIOTIMER_OFFTIME_SHIFT)));
 	}
+	cc->ticks_per_ms = bcma_chipco_watchdog_ticks_per_ms(cc);
 
 	cc->setup_done = true;
 }
 
 /* Set chip watchdog reset timer to fire in 'ticks' backplane cycles */
-void bcma_chipco_watchdog_timer_set(struct bcma_drv_cc *cc, u32 ticks)
+u32 bcma_chipco_watchdog_timer_set(struct bcma_drv_cc *cc, u32 ticks)
 {
 	u32 maxt;
 	enum bcma_clkmode clkmode;
@@ -125,6 +160,7 @@ void bcma_chipco_watchdog_timer_set(struct bcma_drv_cc *cc, u32 ticks)
 		/* instant NMI */
 		bcma_cc_write32(cc, BCMA_CC_WATCHDOG, ticks);
 	}
+	return ticks;
 }
 
 void bcma_chipco_irq_mask(struct bcma_drv_cc *cc, u32 mask, u32 value)
diff --git a/include/linux/bcma/bcma_driver_chipcommon.h b/include/linux/bcma/bcma_driver_chipcommon.h
index 145f3c5..2f9b014 100644
--- a/include/linux/bcma/bcma_driver_chipcommon.h
+++ b/include/linux/bcma/bcma_driver_chipcommon.h
@@ -570,6 +570,7 @@ struct bcma_drv_cc {
 	int nr_serial_ports;
 	struct bcma_serial_port serial_ports[4];
 #endif /* CONFIG_BCMA_DRIVER_MIPS */
+	u32 ticks_per_ms;
 };
 
 /* Register access */
@@ -593,8 +594,7 @@ extern void bcma_chipco_resume(struct bcma_drv_cc *cc);
 
 void bcma_chipco_bcm4331_ext_pa_lines_ctl(struct bcma_drv_cc *cc, bool enable);
 
-extern void bcma_chipco_watchdog_timer_set(struct bcma_drv_cc *cc,
-					  u32 ticks);
+extern u32 bcma_chipco_watchdog_timer_set(struct bcma_drv_cc *cc, u32 ticks);
 
 void bcma_chipco_irq_mask(struct bcma_drv_cc *cc, u32 mask, u32 value);
 
-- 
1.7.10.4
