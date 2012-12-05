Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2012 18:50:00 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:37863 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831687Ab2LERsUt7Gfm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Dec 2012 18:48:20 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 79D2C8F74;
        Wed,  5 Dec 2012 18:48:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id plAdivTLXjBQ; Wed,  5 Dec 2012 18:48:13 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id B68C28F6A;
        Wed,  5 Dec 2012 18:46:37 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com, wim@iguana.be
Cc:     linux-wireless@vger.kernel.org, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        zajec5@gmail.com, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 10/11] ssb: extif: add methods for watchdog driver
Date:   Wed,  5 Dec 2012 18:46:07 +0100
Message-Id: <1354729568-19993-11-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1354729568-19993-1-git-send-email-hauke@hauke-m.de>
References: <1354729568-19993-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35194
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
ticks, add a method converting ms to ticks before setting the watchdog
register. Return the ticks or millisecond the timer was set to in case
the provided value was bigger than the max allowed value.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/ssb/driver_extif.c           |   21 ++++++++++++++++++++-
 drivers/ssb/ssb_private.h            |   15 +++++++++++++++
 include/linux/ssb/ssb_driver_extif.h |    9 +++++----
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/ssb/driver_extif.c b/drivers/ssb/driver_extif.c
index 0aa4c2a..553227a 100644
--- a/drivers/ssb/driver_extif.c
+++ b/drivers/ssb/driver_extif.c
@@ -112,11 +112,30 @@ void ssb_extif_get_clockcontrol(struct ssb_extif *extif,
 	*m = extif_read32(extif, SSB_EXTIF_CLOCK_SB);
 }
 
-void ssb_extif_watchdog_timer_set(struct ssb_extif *extif, u32 ticks)
+u32 ssb_extif_watchdog_timer_set_wdt(struct bcm47xx_wdt *wdt, u32 ticks)
+{
+	struct ssb_extif *extif = bcm47xx_wdt_get_drvdata(wdt);
+
+	return ssb_extif_watchdog_timer_set(extif, ticks);
+}
+
+u32 ssb_extif_watchdog_timer_set_ms(struct bcm47xx_wdt *wdt, u32 ms)
+{
+	struct ssb_extif *extif = bcm47xx_wdt_get_drvdata(wdt);
+	u32 ticks = (SSB_EXTIF_WATCHDOG_CLK / 1000) * ms;
+
+	ticks = ssb_extif_watchdog_timer_set(extif, ticks);
+
+	return (ticks * 1000) / SSB_EXTIF_WATCHDOG_CLK;
+}
+
+u32 ssb_extif_watchdog_timer_set(struct ssb_extif *extif, u32 ticks)
 {
 	if (ticks > SSB_EXTIF_WATCHDOG_MAX_TIMER)
 		ticks = SSB_EXTIF_WATCHDOG_MAX_TIMER;
 	extif_write32(extif, SSB_EXTIF_WATCHDOG, ticks);
+
+	return ticks;
 }
 
 u32 ssb_extif_gpio_in(struct ssb_extif *extif, u32 mask)
diff --git a/drivers/ssb/ssb_private.h b/drivers/ssb/ssb_private.h
index 03cc40a..50ea028 100644
--- a/drivers/ssb/ssb_private.h
+++ b/drivers/ssb/ssb_private.h
@@ -217,4 +217,19 @@ extern u32 ssb_chipco_watchdog_timer_set_wdt(struct bcm47xx_wdt *wdt,
 					     u32 ticks);
 extern u32 ssb_chipco_watchdog_timer_set_ms(struct bcm47xx_wdt *wdt, u32 ms);
 
+#ifdef CONFIG_SSB_DRIVER_EXTIF
+extern u32 ssb_extif_watchdog_timer_set_wdt(struct bcm47xx_wdt *wdt, u32 ticks);
+extern u32 ssb_extif_watchdog_timer_set_ms(struct bcm47xx_wdt *wdt, u32 ms);
+#else
+static inline u32 ssb_extif_watchdog_timer_set_wdt(struct bcm47xx_wdt *wdt,
+						   u32 ticks)
+{
+	return 0;
+}
+static inline u32 ssb_extif_watchdog_timer_set_ms(struct bcm47xx_wdt *wdt,
+						  u32 ms)
+{
+	return 0;
+}
+#endif
 #endif /* LINUX_SSB_PRIVATE_H_ */
diff --git a/include/linux/ssb/ssb_driver_extif.h b/include/linux/ssb/ssb_driver_extif.h
index b618188..99511d0 100644
--- a/include/linux/ssb/ssb_driver_extif.h
+++ b/include/linux/ssb/ssb_driver_extif.h
@@ -153,6 +153,8 @@
 #define SSB_EXTIF_WATCHDOG_CLK		48000000	/* Hz */
 
 #define SSB_EXTIF_WATCHDOG_MAX_TIMER	((1 << 28) - 1)
+#define SSB_EXTIF_WATCHDOG_MAX_TIMER_MS	(SSB_EXTIF_WATCHDOG_MAX_TIMER \
+					 / (SSB_EXTIF_WATCHDOG_CLK / 1000))
 
 
 #ifdef CONFIG_SSB_DRIVER_EXTIF
@@ -172,8 +174,7 @@ extern void ssb_extif_get_clockcontrol(struct ssb_extif *extif,
 extern void ssb_extif_timing_init(struct ssb_extif *extif,
 				  unsigned long ns);
 
-extern void ssb_extif_watchdog_timer_set(struct ssb_extif *extif,
-					 u32 ticks);
+extern u32 ssb_extif_watchdog_timer_set(struct ssb_extif *extif, u32 ticks);
 
 /* Extif GPIO pin access */
 u32 ssb_extif_gpio_in(struct ssb_extif *extif, u32 mask);
@@ -211,9 +212,9 @@ void ssb_extif_timing_init(struct ssb_extif *extif, unsigned long ns)
 }
 
 static inline
-void ssb_extif_watchdog_timer_set(struct ssb_extif *extif,
-				  u32 ticks)
+u32 ssb_extif_watchdog_timer_set(struct ssb_extif *extif, u32 ticks)
 {
+	return 0;
 }
 
 static inline u32 ssb_extif_gpio_in(struct ssb_extif *extif, u32 mask)
-- 
1.7.10.4
