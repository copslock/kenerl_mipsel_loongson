Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Nov 2012 23:26:06 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:55081 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825655Ab2KXWZIUqy2Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Nov 2012 23:25:08 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id E56CF8F74;
        Sat, 24 Nov 2012 23:25:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HJHUaxsyNDsV; Sat, 24 Nov 2012 23:24:59 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 4FF468F64;
        Sat, 24 Nov 2012 23:24:32 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     linux-wireless@vger.kernel.org, wim@iguana.be,
        linux-watchdog@vger.kernel.org, castet.matthieu@free.fr,
        biblbroks@sezampro.rs, m@bues.ch, zajec5@gmail.com,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/15] watchdog: bcm47xx_wdt.c: rename wdt_timeout to timeout
Date:   Sat, 24 Nov 2012 23:24:04 +0100
Message-Id: <1353795855-22236-5-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1353795855-22236-1-git-send-email-hauke@hauke-m.de>
References: <1353795855-22236-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35111
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

Rename rename wdt_timeout to timeout to name it like the other watchdog
driver do it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/watchdog/bcm47xx_wdt.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index 66f2d2b..b6a8c49 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -30,13 +30,13 @@
 #define DRV_NAME		"bcm47xx_wdt"
 
 #define WDT_DEFAULT_TIME	30	/* seconds */
-#define WDT_MAX_TIME		255	/* seconds */
+#define WDT_SOFTTIMER_MAX	3600	/* seconds */
 
-static int wdt_time = WDT_DEFAULT_TIME;
+static int timeout = WDT_DEFAULT_TIME;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
-module_param(wdt_time, int, 0);
-MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog time in seconds. (default="
 				__MODULE_STRING(WDT_DEFAULT_TIME) ")");
 
 module_param(nowayout, bool, 0);
@@ -94,9 +94,9 @@ static int bcm47xx_wdt_soft_stop(struct watchdog_device *wdd)
 static int bcm47xx_wdt_soft_set_timeout(struct watchdog_device *wdd,
 					unsigned int new_time)
 {
-	if (new_time < 1 || new_time > WDT_MAX_TIME) {
+	if (new_time < 1 || new_time > WDT_SOFTTIMER_MAX) {
 		pr_warn("timeout value must be 1<=x<=%d, using %d\n",
-			WDT_MAX_TIME, new_time);
+			WDT_SOFTTIMER_MAX, new_time);
 		return -EINVAL;
 	}
 
@@ -160,7 +160,7 @@ static int __devinit bcm47xx_wdt_probe(struct platform_device *pdev)
 		goto err_notifier;
 
 	pr_info("BCM47xx Watchdog Timer enabled (%d seconds%s)\n",
-		wdt_time, nowayout ? ", nowayout" : "");
+		timeout, nowayout ? ", nowayout" : "");
 	return 0;
 
 err_notifier:
-- 
1.7.10.4
