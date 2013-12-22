Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Dec 2013 14:36:53 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:41098 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816384Ab3LVNguFVTa8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Dec 2013 14:36:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 6E2408F61;
        Sun, 22 Dec 2013 14:36:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WmgVTLs3QXQu; Sun, 22 Dec 2013 14:36:43 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id A63DC857F;
        Sun, 22 Dec 2013 14:36:43 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] MIPS: BCM47XX: do not use cpu_wait instruction on BCM4706
Date:   Sun, 22 Dec 2013 14:36:30 +0100
Message-Id: <1387719392-17565-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38796
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

The BCM4706 has a problem with the CPU wait instruction. When r4k_wait
or r4k_wait_irqoff is used will just hang and not return from a
msleep(). Removing the cpu_wait functionality is a workaround for this
problem. The BCM4716 does not have this problem.

The BCM4706 SoC uses a MIPS 74K V4.9 CPU.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 2ecb6ee..111be0b 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -34,6 +34,7 @@
 #include <linux/ssb/ssb_embedded.h>
 #include <linux/bcma/bcma_soc.h>
 #include <asm/bootinfo.h>
+#include <asm/idle.h>
 #include <asm/prom.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
@@ -201,6 +202,15 @@ static void __init bcm47xx_register_bcma(void)
 		panic("Failed to initialize BCMA bus (err %d)", err);
 
 	bcm47xx_fill_bcma_boardinfo(&bcm47xx_bus.bcma.bus.boardinfo, NULL);
+
+	/* The BCM4706 has a problem with the CPU wait instruction.
+	 * When r4k_wait or r4k_wait_irqoff is used will just hang and 
+	 * not return from a msleep(). Removing the cpu_wait 
+	 * functionality is a workaround for this problem. The BCM4716 
+	 * does not have this problem.
+	 */
+	if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
+		cpu_wait = NULL;
 }
 #endif
 
-- 
1.7.10.4
