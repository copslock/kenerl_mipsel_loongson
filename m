Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jul 2011 13:11:44 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:42032 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492162Ab1GILHD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Jul 2011 13:07:03 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 247418C6B;
        Sat,  9 Jul 2011 13:07:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kQyv79x88EoB; Sat,  9 Jul 2011 13:06:59 +0200 (CEST)
Received: from localhost.localdomain (dyndsl-095-033-240-133.ewe-ip-backbone.de [95.33.240.133])
        by hauke-m.de (Postfix) with ESMTPSA id C39F38C6C;
        Sat,  9 Jul 2011 13:06:32 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        zajec5@gmail.com, linux-mips@linux-mips.org
Cc:     mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/11] bcm47xx: fix irq assignment for new SoCs.
Date:   Sat,  9 Jul 2011 13:06:03 +0200
Message-Id: <1310209563-6405-12-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1310209563-6405-1-git-send-email-hauke@hauke-m.de>
References: <1310209563-6405-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 30604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6784

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
