Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2013 18:16:02 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45945 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823910Ab3ALROnu1JBl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2013 18:14:43 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 76C938F61;
        Sat, 12 Jan 2013 18:14:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gLrO6aO8GJAW; Sat, 12 Jan 2013 18:14:34 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 23A678F69;
        Sat, 12 Jan 2013 18:14:19 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     wim@iguana.be
Cc:     linux-watchdog@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v4 5/5] watchdog: bcm47xx_wdt.c: add hard timer
Date:   Sat, 12 Jan 2013 18:14:11 +0100
Message-Id: <1358010851-28077-6-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35411
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

The more recent devices have a watchdog timer which could be configured
for over 2 hours and not just 2 seconds like the first generation
devices. For those devices do not use the extra software timer, but
directly program the time into the register. This will automatically be
used if the timer supports more than a minute.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/watchdog/bcm47xx_wdt.c |   69 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index f188097..9cb69ad 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -31,6 +31,7 @@
 
 #define WDT_DEFAULT_TIME	30	/* seconds */
 #define WDT_SOFTTIMER_MAX	255	/* seconds */
+#define WDT_SOFTTIMER_THRESHOLD	60	/* seconds */
 
 static int timeout = WDT_DEFAULT_TIME;
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -49,6 +50,53 @@ static inline struct bcm47xx_wdt *bcm47xx_wdt_get(struct watchdog_device *wdd)
 	return container_of(wdd, struct bcm47xx_wdt, wdd);
 }
 
+static int bcm47xx_wdt_hard_keepalive(struct watchdog_device *wdd)
+{
+	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
+
+	wdt->timer_set_ms(wdt, wdd->timeout * 1000);
+
+	return 0;
+}
+
+static int bcm47xx_wdt_hard_start(struct watchdog_device *wdd)
+{
+	return 0;
+}
+
+static int bcm47xx_wdt_hard_stop(struct watchdog_device *wdd)
+{
+	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
+
+	wdt->timer_set(wdt, 0);
+
+	return 0;
+}
+
+static int bcm47xx_wdt_hard_set_timeout(struct watchdog_device *wdd,
+					unsigned int new_time)
+{
+	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
+	u32 max_timer = wdt->max_timer_ms;
+
+	if (new_time < 1 || new_time > max_timer / 1000) {
+		pr_warn("timeout value must be 1<=x<=%d, using %d\n",
+			max_timer / 1000, new_time);
+		return -EINVAL;
+	}
+
+	wdd->timeout = new_time;
+	return 0;
+}
+
+static struct watchdog_ops bcm47xx_wdt_hard_ops = {
+	.owner		= THIS_MODULE,
+	.start		= bcm47xx_wdt_hard_start,
+	.stop		= bcm47xx_wdt_hard_stop,
+	.ping		= bcm47xx_wdt_hard_keepalive,
+	.set_timeout	= bcm47xx_wdt_hard_set_timeout,
+};
+
 static void bcm47xx_wdt_soft_timer_tick(unsigned long data)
 {
 	struct bcm47xx_wdt *wdt = (struct bcm47xx_wdt *)data;
@@ -133,15 +181,22 @@ static struct watchdog_ops bcm47xx_wdt_soft_ops = {
 static int __devinit bcm47xx_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
+	bool soft;
 	struct bcm47xx_wdt *wdt = dev_get_platdata(&pdev->dev);
 
 	if (!wdt)
 		return -ENXIO;
 
-	setup_timer(&wdt->soft_timer, bcm47xx_wdt_soft_timer_tick,
-		    (long unsigned int)wdt);
+	soft = wdt->max_timer_ms < WDT_SOFTTIMER_THRESHOLD * 1000;
+
+	if (soft) {
+		wdt->wdd.ops = &bcm47xx_wdt_soft_ops;
+		setup_timer(&wdt->soft_timer, bcm47xx_wdt_soft_timer_tick,
+			    (long unsigned int)wdt);
+	} else {
+		wdt->wdd.ops = &bcm47xx_wdt_hard_ops;
+	}
 
-	wdt->wdd.ops = &bcm47xx_wdt_soft_ops;
 	wdt->wdd.info = &bcm47xx_wdt_info;
 	wdt->wdd.timeout = WDT_DEFAULT_TIME;
 	ret = wdt->wdd.ops->set_timeout(&wdt->wdd, timeout);
@@ -159,14 +214,16 @@ static int __devinit bcm47xx_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_notifier;
 
-	pr_info("BCM47xx Watchdog Timer enabled (%d seconds%s)\n",
-		timeout, nowayout ? ", nowayout" : "");
+	dev_info(&pdev->dev, "BCM47xx Watchdog Timer enabled (%d seconds%s%s)\n",
+		timeout, nowayout ? ", nowayout" : "",
+		soft ? ", Software Timer" : "");
 	return 0;
 
 err_notifier:
 	unregister_reboot_notifier(&wdt->notifier);
 err_timer:
-	del_timer_sync(&wdt->soft_timer);
+	if (soft)
+		del_timer_sync(&wdt->soft_timer);
 
 	return ret;
 }
-- 
1.7.10.4
