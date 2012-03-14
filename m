Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:43:23 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34432 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903736Ab2CNJkV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:40:21 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 90DA523C00DA;
        Wed, 14 Mar 2012 10:09:31 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, juhosg@openwrt.org
Subject: [PATCH v2 08/13] MIPS: ath79: add AR934X specific glue to ath79_device_reset_{clear,set}
Date:   Wed, 14 Mar 2012 11:45:26 +0100
Message-Id: <1331721931-4334-9-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
References: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
v2: - no changes

 arch/mips/ath79/common.c                       |    9 ++++++++-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    1 +
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index f0fda98..5a4adfc 100644
--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -1,9 +1,12 @@
 /*
  *  Atheros AR71XX/AR724X/AR913X common routines
  *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
+ *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
+ *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
@@ -67,6 +70,8 @@ void ath79_device_reset_set(u32 mask)
 		reg = AR913X_RESET_REG_RESET_MODULE;
 	else if (soc_is_ar933x())
 		reg = AR933X_RESET_REG_RESET_MODULE;
+	else if (soc_is_ar934x())
+		reg = AR934X_RESET_REG_RESET_MODULE;
 	else
 		BUG();
 
@@ -91,6 +96,8 @@ void ath79_device_reset_clear(u32 mask)
 		reg = AR913X_RESET_REG_RESET_MODULE;
 	else if (soc_is_ar933x())
 		reg = AR933X_RESET_REG_RESET_MODULE;
+	else if (soc_is_ar934x())
+		reg = AR934X_RESET_REG_RESET_MODULE;
 	else
 		BUG();
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index d6af4eb..32abbf9 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -227,6 +227,7 @@
 #define AR933X_RESET_REG_RESET_MODULE		0x1c
 #define AR933X_RESET_REG_BOOTSTRAP		0xac
 
+#define AR934X_RESET_REG_RESET_MODULE		0x1c
 #define AR934X_RESET_REG_BOOTSTRAP		0xb0
 #define AR934X_RESET_REG_PCIE_WMAC_INT_STATUS	0xac
 
-- 
1.7.2.1
