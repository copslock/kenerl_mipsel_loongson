Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2013 18:15:44 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45941 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823116Ab3ALROj0OP3G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2013 18:14:39 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 0E6088F61;
        Sat, 12 Jan 2013 18:14:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hGnmqNNzwGHw; Sat, 12 Jan 2013 18:14:32 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id C96488F68;
        Sat, 12 Jan 2013 18:14:18 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     wim@iguana.be
Cc:     linux-watchdog@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v4 4/5] watchdog: bcm47xx_wdt.c: rename wdt_time to timeout
Date:   Sat, 12 Jan 2013 18:14:10 +0100
Message-Id: <1358010851-28077-5-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35410
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

Rename wdt_time to timeout to name it like the other watchdog
driver do it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/watchdog/bcm47xx_wdt.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index ed10762..f188097 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -32,11 +32,11 @@
 #define WDT_DEFAULT_TIME	30	/* seconds */
 #define WDT_SOFTTIMER_MAX	255	/* seconds */
 
-static int wdt_time = WDT_DEFAULT_TIME;
+static int timeout = WDT_DEFAULT_TIME;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
-module_param(wdt_time, int, 0);
-MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog time in seconds. (default="
 				__MODULE_STRING(WDT_DEFAULT_TIME) ")");
 
 module_param(nowayout, bool, 0);
@@ -160,7 +160,7 @@ static int __devinit bcm47xx_wdt_probe(struct platform_device *pdev)
 		goto err_notifier;
 
 	pr_info("BCM47xx Watchdog Timer enabled (%d seconds%s)\n",
-		wdt_time, nowayout ? ", nowayout" : "");
+		timeout, nowayout ? ", nowayout" : "");
 	return 0;
 
 err_notifier:
-- 
1.7.10.4
