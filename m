Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 00:45:28 +0200 (CEST)
Received: from test.hauke-m.de ([5.39.93.123]:37888 "EHLO test.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860206AbaG1VzWXUwb- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jul 2014 23:55:22 +0200
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by test.hauke-m.de (Postfix) with ESMTPSA id DED12209CA;
        Mon, 28 Jul 2014 23:54:11 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     zajec5@gmail.com, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: BCM47XX: make reboot more relaiable
Date:   Mon, 28 Jul 2014 23:53:57 +0200
Message-Id: <1406584437-31108-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.9.1
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41725
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

The reboot on the BCM47XX SoCs is done, by setting the watchdog counter
to 1 and let it trigger a reboot, when it reaches 0. Some devices with
a BCM4705/BCM4785 SoC do not reboot when the counter is set to 1 and
decreased to 0 by the hardware. It looks like it works more reliable
when we set it to 3. As far as I understand the hardware, this should
not make any difference, but I do not have access to any documentation
for this SoC.
It is still not 100% reliable.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 8c8e7cd..2b63e7e 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -59,12 +59,12 @@ static void bcm47xx_machine_restart(char *command)
 	switch (bcm47xx_bus_type) {
 #ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
-		ssb_watchdog_timer_set(&bcm47xx_bus.ssb, 1);
+		ssb_watchdog_timer_set(&bcm47xx_bus.ssb, 3);
 		break;
 #endif
 #ifdef CONFIG_BCM47XX_BCMA
 	case BCM47XX_BUS_TYPE_BCMA:
-		bcma_chipco_watchdog_timer_set(&bcm47xx_bus.bcma.bus.drv_cc, 1);
+		bcma_chipco_watchdog_timer_set(&bcm47xx_bus.bcma.bus.drv_cc, 3);
 		break;
 #endif
 	}
-- 
1.9.1
