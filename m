Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2011 19:01:03 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:50948 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491809Ab1GPQ4i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jul 2011 18:56:38 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B17F08C63;
        Sat, 16 Jul 2011 18:56:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cnMGvYfJsC+Z; Sat, 16 Jul 2011 18:56:33 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-255-051.ewe-ip-backbone.de [91.97.255.51])
        by hauke-m.de (Postfix) with ESMTPSA id 47A678C6D;
        Sat, 16 Jul 2011 18:56:10 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        zajec5@gmail.com, linux-mips@linux-mips.org
Cc:     jonas.gorski@gmail.com, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, arnd@arndb.de,
        julian.calaby@gmail.com, sshtylyov@mvista.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 11/11] bcm47xx: fix irq assignment for new SoCs.
Date:   Sat, 16 Jul 2011 18:55:42 +0200
Message-Id: <1310835342-18877-12-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
References: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 30642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11713

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/irq.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm47xx/irq.c b/arch/mips/bcm47xx/irq.c
index 325757a..70bdcf0 100644
--- a/arch/mips/bcm47xx/irq.c
+++ b/arch/mips/bcm47xx/irq.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <asm/irq_cpu.h>
+#include <bcm47xx.h>
 
 void plat_irq_dispatch(void)
 {
@@ -51,5 +52,16 @@ void plat_irq_dispatch(void)
 
 void __init arch_init_irq(void)
 {
+#ifdef CONFIG_BCM47XX_BCMA
+	if (bcm47xx_active_bus_type == BCM47XX_BUS_TYPE_BCMA) {
+		bcma_write32(bcm47xx_bus.bcma.bus.drv_mips.core,
+			     BCMA_MIPS_MIPS74K_INTMASK(5), 1 << 31);
+		/*
+		 * the kernel reads the timer irq from some register and thinks
+		 * it's #5, but we offset it by 2 and route to #7
+		 */
+		cp0_compare_irq = 7;
+	}
+#endif
 	mips_cpu_irq_init();
 }
-- 
1.7.4.1
