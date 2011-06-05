Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 00:12:33 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:60382 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491834Ab1FEWIl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 00:08:41 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 6922D8B15;
        Mon,  6 Jun 2011 00:08:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id e0Y+uUEypNX7; Mon,  6 Jun 2011 00:08:37 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-251-075.ewe-ip-backbone.de [91.97.251.75])
        by hauke-m.de (Postfix) with ESMTPSA id 35FE28B0E;
        Mon,  6 Jun 2011 00:08:16 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org
Cc:     zajec5@gmail.com, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC][PATCH 10/10] bcm47xx: fix irq assignment for new SoCs.
Date:   Mon,  6 Jun 2011 00:07:38 +0200
Message-Id: <1307311658-15853-11-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 30232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3693

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/irq.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm47xx/irq.c b/arch/mips/bcm47xx/irq.c
index 325757a..3642cee 100644
--- a/arch/mips/bcm47xx/irq.c
+++ b/arch/mips/bcm47xx/irq.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <asm/irq_cpu.h>
+#include <bcm47xx.h>
 
 void plat_irq_dispatch(void)
 {
@@ -51,5 +52,12 @@ void plat_irq_dispatch(void)
 
 void __init arch_init_irq(void)
 {
+	if (bcm47xx_active_bus_type == BCM47XX_BUS_TYPE_BCMA) {
+		bcma_write32(bcm47xx_bus.bcma.drv_mips.core,
+			     BCMA_MIPS_MIPS74K_INTMASK(5), 1 << 31);
+		/* the kernel reads the timer irq from some register and thinks
+		 * it's #5, but we offset it by 2 and route to #7 */
+		cp0_compare_irq = 7;
+	}
 	mips_cpu_irq_init();
 }
-- 
1.7.4.1
