Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2013 18:15:08 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45924 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6820505Ab3ALROc5sBly (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2013 18:14:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 9BDE48F61;
        Sat, 12 Jan 2013 18:14:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KpMZiZr3JRpo; Sat, 12 Jan 2013 18:14:27 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 7C9798F67;
        Sat, 12 Jan 2013 18:14:18 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     wim@iguana.be
Cc:     linux-watchdog@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v4 3/5] watchdog: bcm47xx_wdt.c: rename ops methods
Date:   Sat, 12 Jan 2013 18:14:09 +0100
Message-Id: <1358010851-28077-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35408
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

Rename the methods registered to struct watchdog_ops bcm47xx_wdt_ops in
order to add an other struct watchdog_ops using different ops in the
next patch.
Also rename WDT_MAX_TIME to WDT_SOFTTIMER_MAX.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/watchdog/bcm47xx_wdt.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index cf1191b..ed10762 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -30,7 +30,7 @@
 #define DRV_NAME		"bcm47xx_wdt"
 
 #define WDT_DEFAULT_TIME	30	/* seconds */
-#define WDT_MAX_TIME		255	/* seconds */
+#define WDT_SOFTTIMER_MAX	255	/* seconds */
 
 static int wdt_time = WDT_DEFAULT_TIME;
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -49,7 +49,7 @@ static inline struct bcm47xx_wdt *bcm47xx_wdt_get(struct watchdog_device *wdd)
 	return container_of(wdd, struct bcm47xx_wdt, wdd);
 }
 
-static void bcm47xx_timer_tick(unsigned long data)
+static void bcm47xx_wdt_soft_timer_tick(unsigned long data)
 {
 	struct bcm47xx_wdt *wdt = (struct bcm47xx_wdt *)data;
 	u32 next_tick = min(wdt->wdd.timeout * 1000, wdt->max_timer_ms);
@@ -62,7 +62,7 @@ static void bcm47xx_timer_tick(unsigned long data)
 	}
 }
 
-static int bcm47xx_wdt_keepalive(struct watchdog_device *wdd)
+static int bcm47xx_wdt_soft_keepalive(struct watchdog_device *wdd)
 {
 	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
 
@@ -71,17 +71,17 @@ static int bcm47xx_wdt_keepalive(struct watchdog_device *wdd)
 	return 0;
 }
 
-static int bcm47xx_wdt_start(struct watchdog_device *wdd)
+static int bcm47xx_wdt_soft_start(struct watchdog_device *wdd)
 {
 	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
 
-	bcm47xx_wdt_keepalive(wdd);
-	bcm47xx_timer_tick((unsigned long)wdt);
+	bcm47xx_wdt_soft_keepalive(wdd);
+	bcm47xx_wdt_soft_timer_tick((unsigned long)wdt);
 
 	return 0;
 }
 
-static int bcm47xx_wdt_stop(struct watchdog_device *wdd)
+static int bcm47xx_wdt_soft_stop(struct watchdog_device *wdd)
 {
 	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
 
@@ -91,12 +91,12 @@ static int bcm47xx_wdt_stop(struct watchdog_device *wdd)
 	return 0;
 }
 
-static int bcm47xx_wdt_set_timeout(struct watchdog_device *wdd,
-				   unsigned int new_time)
+static int bcm47xx_wdt_soft_set_timeout(struct watchdog_device *wdd,
+					unsigned int new_time)
 {
-	if (new_time < 1 || new_time > WDT_MAX_TIME) {
+	if (new_time < 1 || new_time > WDT_SOFTTIMER_MAX) {
 		pr_warn("timeout value must be 1<=x<=%d, using %d\n",
-			WDT_MAX_TIME, new_time);
+			WDT_SOFTTIMER_MAX, new_time);
 		return -EINVAL;
 	}
 
@@ -122,12 +122,12 @@ static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
-static struct watchdog_ops bcm47xx_wdt_ops = {
+static struct watchdog_ops bcm47xx_wdt_soft_ops = {
 	.owner		= THIS_MODULE,
-	.start		= bcm47xx_wdt_start,
-	.stop		= bcm47xx_wdt_stop,
-	.ping		= bcm47xx_wdt_keepalive,
-	.set_timeout	= bcm47xx_wdt_set_timeout,
+	.start		= bcm47xx_wdt_soft_start,
+	.stop		= bcm47xx_wdt_soft_stop,
+	.ping		= bcm47xx_wdt_soft_keepalive,
+	.set_timeout	= bcm47xx_wdt_soft_set_timeout,
 };
 
 static int __devinit bcm47xx_wdt_probe(struct platform_device *pdev)
@@ -138,10 +138,10 @@ static int __devinit bcm47xx_wdt_probe(struct platform_device *pdev)
 	if (!wdt)
 		return -ENXIO;
 
-	setup_timer(&wdt->soft_timer, bcm47xx_timer_tick,
+	setup_timer(&wdt->soft_timer, bcm47xx_wdt_soft_timer_tick,
 		    (long unsigned int)wdt);
 
-	wdt->wdd.ops = &bcm47xx_wdt_ops;
+	wdt->wdd.ops = &bcm47xx_wdt_soft_ops;
 	wdt->wdd.info = &bcm47xx_wdt_info;
 	wdt->wdd.timeout = WDT_DEFAULT_TIME;
 	ret = wdt->wdd.ops->set_timeout(&wdt->wdd, timeout);
-- 
1.7.10.4
