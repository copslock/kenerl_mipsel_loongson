Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 19:26:39 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:46068 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903621Ab1LWS0J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Dec 2011 19:26:09 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 0B3BC23C007C;
        Fri, 23 Dec 2011 19:26:07 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 01/16] MIPS: ath79: add early_printk support for AR934X
Date:   Fri, 23 Dec 2011 19:25:27 +0100
Message-Id: <1324664742-3648-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
References: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19085

The patch allows to see kernel messages on AR934X SoCs in
early boot stage.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
 arch/mips/ath79/early_printk.c                 |    3 +++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    6 +++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ath79/early_printk.c b/arch/mips/ath79/early_printk.c
index 6a51ced..dc938cb 100644
--- a/arch/mips/ath79/early_printk.c
+++ b/arch/mips/ath79/early_printk.c
@@ -71,6 +71,9 @@ static void prom_putchar_init(void)
 	case REV_ID_MAJOR_AR7241:
 	case REV_ID_MAJOR_AR7242:
 	case REV_ID_MAJOR_AR913X:
+	case REV_ID_MAJOR_AR9341:
+	case REV_ID_MAJOR_AR9342:
+	case REV_ID_MAJOR_AR9344:
 		_prom_putchar = prom_putchar_ar71xx;
 		break;
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 2f0becb..b7df674 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -1,10 +1,11 @@
 /*
  *  Atheros AR71XX/AR724X/AR913X SoC register definitions
  *
+ *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
  *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
- *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
@@ -249,6 +250,9 @@
 #define REV_ID_MAJOR_AR7242		0x1100
 #define REV_ID_MAJOR_AR9330		0x0110
 #define REV_ID_MAJOR_AR9331		0x1110
+#define REV_ID_MAJOR_AR9341		0x0120
+#define REV_ID_MAJOR_AR9342		0x1120
+#define REV_ID_MAJOR_AR9344		0x2120
 
 #define AR71XX_REV_ID_MINOR_MASK	0x3
 #define AR71XX_REV_ID_MINOR_AR7130	0x0
-- 
1.7.2.1
