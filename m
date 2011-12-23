Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 19:27:34 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:46079 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903627Ab1LWS0L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Dec 2011 19:26:11 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 62EB923C008D;
        Fri, 23 Dec 2011 19:26:10 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 03/16] MIPS: ath79: add SoC detection code for AR934X
Date:   Fri, 23 Dec 2011 19:25:29 +0100
Message-Id: <1324664742-3648-4-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
References: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19089

Also add 'soc_is_ar934[124x]' helper functions and a Kconfig
symbol for the AR934X SoCs.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
 arch/mips/ath79/Kconfig                        |    4 ++++
 arch/mips/ath79/setup.c                        |   21 ++++++++++++++++++++-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    2 ++
 arch/mips/include/asm/mach-ath79/ath79.h       |   23 +++++++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index bc6edad..7db8e89 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -69,6 +69,10 @@ config SOC_AR933X
 	select USB_ARCH_HAS_EHCI
 	def_bool n
 
+config SOC_AR934X
+	select USB_ARCH_HAS_EHCI
+	def_bool n
+
 config ATH79_DEV_GPIO_BUTTONS
 	def_bool n
 
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 24dfedf..60d212e 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -1,10 +1,11 @@
 /*
  *  Atheros AR71XX/AR724X/AR913X specific setup
  *
+ *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
  *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
- *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
@@ -145,6 +146,24 @@ static void __init ath79_detect_sys_type(void)
 		rev = id & AR933X_REV_ID_REVISION_MASK;
 		break;
 
+	case REV_ID_MAJOR_AR9341:
+		ath79_soc = ATH79_SOC_AR9341;
+		chip = "9341";
+		rev = id & AR934X_REV_ID_REVISION_MASK;
+		break;
+
+	case REV_ID_MAJOR_AR9342:
+		ath79_soc = ATH79_SOC_AR9342;
+		chip = "9342";
+		rev = id & AR934X_REV_ID_REVISION_MASK;
+		break;
+
+	case REV_ID_MAJOR_AR9344:
+		ath79_soc = ATH79_SOC_AR9344;
+		chip = "9344";
+		rev = id & AR934X_REV_ID_REVISION_MASK;
+		break;
+
 	default:
 		panic("ath79: unknown SoC, id:0x%08x", id);
 	}
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index b7df674..4e3c55d 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -271,6 +271,8 @@
 
 #define AR724X_REV_ID_REVISION_MASK	0x3
 
+#define AR934X_REV_ID_REVISION_MASK     0xf
+
 /*
  * SPI block
  */
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/asm/mach-ath79/ath79.h
index 6d0c6c9..4f248c3 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -29,6 +29,9 @@ enum ath79_soc_type {
 	ATH79_SOC_AR9132,
 	ATH79_SOC_AR9330,
 	ATH79_SOC_AR9331,
+	ATH79_SOC_AR9341,
+	ATH79_SOC_AR9342,
+	ATH79_SOC_AR9344,
 };
 
 extern enum ath79_soc_type ath79_soc;
@@ -75,6 +78,26 @@ static inline int soc_is_ar933x(void)
 		ath79_soc == ATH79_SOC_AR9331);
 }
 
+static inline int soc_is_ar9341(void)
+{
+	return (ath79_soc == ATH79_SOC_AR9341);
+}
+
+static inline int soc_is_ar9342(void)
+{
+	return (ath79_soc == ATH79_SOC_AR9342);
+}
+
+static inline int soc_is_ar9344(void)
+{
+	return (ath79_soc == ATH79_SOC_AR9344);
+}
+
+static inline int soc_is_ar934x(void)
+{
+	return soc_is_ar9341() || soc_is_ar9342() || soc_is_ar9344();
+}
+
 extern void __iomem *ath79_ddr_base;
 extern void __iomem *ath79_pll_base;
 extern void __iomem *ath79_reset_base;
-- 
1.7.2.1
