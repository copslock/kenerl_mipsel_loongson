Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2014 22:07:46 +0200 (CEST)
Received: from test.hauke-m.de ([5.39.93.123]:54815 "EHLO test.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6855164AbaHRUHXh0wqM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Aug 2014 22:07:23 +0200
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by test.hauke-m.de (Postfix) with ESMTPSA id CDDBA20179;
        Mon, 18 Aug 2014 22:01:22 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     jogo@openwrt.org, zajec5@gmail.com, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2] MIPS: BCM47XX: fix reboot problem on BCM4705/BCM4785
Date:   Mon, 18 Aug 2014 22:01:16 +0200
Message-Id: <1408392076-308-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42136
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

This adds some code based on code from the Broadcom GPL tar to fix the
reboot problems on BCM4705/BCM4785. I tried rebooting my device for ~10
times and have never seen a problem. This reverts the changes in the
previous commit and adds the real fix as suggested by Rafał.

Setting bit 22 in Reg 22, sel 4 puts the BIU (Bus Interface Unit) into
async mode.

The previous try was this:
commit 316cad5c1d4daee998cd1f83ccdb437f6f20d45c
Author: Hauke Mehrtens <hauke@hauke-m.de>
Date:   Mon Jul 28 23:53:57 2014 +0200

    MIPS: BCM47XX: make reboot more relaiable

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 2b63e7e..ad439c2 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -59,12 +59,21 @@ static void bcm47xx_machine_restart(char *command)
 	switch (bcm47xx_bus_type) {
 #ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
-		ssb_watchdog_timer_set(&bcm47xx_bus.ssb, 3);
+		if (bcm47xx_bus.ssb.chip_id == 0x4785)
+			write_c0_diag4(1 << 22);
+		ssb_watchdog_timer_set(&bcm47xx_bus.ssb, 1);
+		if (bcm47xx_bus.ssb.chip_id == 0x4785) {
+			__asm__ __volatile__(
+				".set\tmips3\n\t"
+				"sync\n\t"
+				"wait\n\t"
+				".set\tmips0");
+		}
 		break;
 #endif
 #ifdef CONFIG_BCM47XX_BCMA
 	case BCM47XX_BUS_TYPE_BCMA:
-		bcma_chipco_watchdog_timer_set(&bcm47xx_bus.bcma.bus.drv_cc, 3);
+		bcma_chipco_watchdog_timer_set(&bcm47xx_bus.bcma.bus.drv_cc, 1);
 		break;
 #endif
 	}
-- 
1.9.1
