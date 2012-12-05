Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2012 18:46:51 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:37744 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831673Ab2LERqtsJo56 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Dec 2012 18:46:49 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 45CB18F6C;
        Wed,  5 Dec 2012 18:46:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VqkC42Nwgzho; Wed,  5 Dec 2012 18:46:23 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id F2A468F61;
        Wed,  5 Dec 2012 18:46:21 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com, wim@iguana.be
Cc:     linux-wireless@vger.kernel.org, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        zajec5@gmail.com, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 01/11] ssb/bcma: add common header for watchdog
Date:   Wed,  5 Dec 2012 18:45:58 +0100
Message-Id: <1354729568-19993-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1354729568-19993-1-git-send-email-hauke@hauke-m.de>
References: <1354729568-19993-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35184
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

This adds a common header for watchdog functions, so a watchdog driver
just needs to use this and could provide watchdog functionality for ssb
and bcma based SoCs. Patches for a watchdog driver using this interface
will be send later.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/bcm47xx_wdt.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 include/linux/bcm47xx_wdt.h

diff --git a/include/linux/bcm47xx_wdt.h b/include/linux/bcm47xx_wdt.h
new file mode 100644
index 0000000..e5dfc25
--- /dev/null
+++ b/include/linux/bcm47xx_wdt.h
@@ -0,0 +1,19 @@
+#ifndef LINUX_BCM47XX_WDT_H_
+#define LINUX_BCM47XX_WDT_H_
+
+#include <linux/types.h>
+
+
+struct bcm47xx_wdt {
+	u32 (*timer_set)(struct bcm47xx_wdt *, u32);
+	u32 (*timer_set_ms)(struct bcm47xx_wdt *, u32);
+	u32 max_timer_ms;
+
+	void *driver_data;
+};
+
+static inline void *bcm47xx_wdt_get_drvdata(struct bcm47xx_wdt *wdt)
+{
+	return wdt->driver_data;
+}
+#endif /* LINUX_BCM47XX_WDT_H_ */
-- 
1.7.10.4
