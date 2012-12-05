Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2012 18:49:23 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:37839 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831686Ab2LERsOCPJMn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Dec 2012 18:48:14 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B6D108F64;
        Wed,  5 Dec 2012 18:48:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bSFQhcyoQakZ; Wed,  5 Dec 2012 18:48:09 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 1C3458F69;
        Wed,  5 Dec 2012 18:46:37 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com, wim@iguana.be
Cc:     linux-wireless@vger.kernel.org, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        zajec5@gmail.com, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 09/11] ssb: extif: add check for max value before setting watchdog register
Date:   Wed,  5 Dec 2012 18:46:06 +0100
Message-Id: <1354729568-19993-10-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1354729568-19993-1-git-send-email-hauke@hauke-m.de>
References: <1354729568-19993-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35192
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

Prevent the watchdog register on the extif core to be set to a too
high value.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/ssb/driver_extif.c           |    5 +++--
 include/linux/ssb/ssb_driver_extif.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ssb/driver_extif.c b/drivers/ssb/driver_extif.c
index dc47f30..0aa4c2a 100644
--- a/drivers/ssb/driver_extif.c
+++ b/drivers/ssb/driver_extif.c
@@ -112,9 +112,10 @@ void ssb_extif_get_clockcontrol(struct ssb_extif *extif,
 	*m = extif_read32(extif, SSB_EXTIF_CLOCK_SB);
 }
 
-void ssb_extif_watchdog_timer_set(struct ssb_extif *extif,
-				  u32 ticks)
+void ssb_extif_watchdog_timer_set(struct ssb_extif *extif, u32 ticks)
 {
+	if (ticks > SSB_EXTIF_WATCHDOG_MAX_TIMER)
+		ticks = SSB_EXTIF_WATCHDOG_MAX_TIMER;
 	extif_write32(extif, SSB_EXTIF_WATCHDOG, ticks);
 }
 
diff --git a/include/linux/ssb/ssb_driver_extif.h b/include/linux/ssb/ssb_driver_extif.h
index 2604efa..b618188 100644
--- a/include/linux/ssb/ssb_driver_extif.h
+++ b/include/linux/ssb/ssb_driver_extif.h
@@ -152,6 +152,7 @@
 /* watchdog */
 #define SSB_EXTIF_WATCHDOG_CLK		48000000	/* Hz */
 
+#define SSB_EXTIF_WATCHDOG_MAX_TIMER	((1 << 28) - 1)
 
 
 #ifdef CONFIG_SSB_DRIVER_EXTIF
-- 
1.7.10.4
