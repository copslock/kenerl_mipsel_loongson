Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 19:30:25 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:46118 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903776Ab1LWS0T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Dec 2011 19:26:19 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 482AF23C008B;
        Fri, 23 Dec 2011 19:26:18 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 10/16] MIPS: ath79: add WMAC registration code for AR934X
Date:   Fri, 23 Dec 2011 19:25:36 +0100
Message-Id: <1324664742-3648-11-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
References: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19098

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
 arch/mips/ath79/Kconfig                        |    2 +-
 arch/mips/ath79/dev-wmac.c                     |   30 ++++++++++++++++++++++-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 ++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 7db8e89..5fa3d7b 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -86,7 +86,7 @@ config ATH79_DEV_USB
 	def_bool n
 
 config ATH79_DEV_WMAC
-	depends on (SOC_AR913X || SOC_AR933X)
+	depends on (SOC_AR913X || SOC_AR933X || SOC_AR934X)
 	def_bool n
 
 endif
diff --git a/arch/mips/ath79/dev-wmac.c b/arch/mips/ath79/dev-wmac.c
index e215070..0a431af 100644
--- a/arch/mips/ath79/dev-wmac.c
+++ b/arch/mips/ath79/dev-wmac.c
@@ -1,9 +1,12 @@
 /*
  *  Atheros AR913X/AR933X SoC built-in WMAC device support
  *
+ *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
  *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
+ *  Parts of this file are based on Atheros 2.6.15/2.6.31 BSP
+ *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
@@ -26,8 +29,7 @@ static struct resource ath79_wmac_resources[] = {
 		/* .start and .end fields are filled dynamically */
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.start	= ATH79_CPU_IRQ_IP2,
-		.end	= ATH79_CPU_IRQ_IP2,
+		/* .start and .end fields are filled dynamically */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -53,6 +55,8 @@ static void __init ar913x_wmac_setup(void)
 
 	ath79_wmac_resources[0].start = AR913X_WMAC_BASE;
 	ath79_wmac_resources[0].end = AR913X_WMAC_BASE + AR913X_WMAC_SIZE - 1;
+	ath79_wmac_resources[1].start = ATH79_CPU_IRQ_IP2;
+	ath79_wmac_resources[1].end = ATH79_CPU_IRQ_IP2;
 }
 
 
@@ -79,6 +83,8 @@ static void __init ar933x_wmac_setup(void)
 
 	ath79_wmac_resources[0].start = AR933X_WMAC_BASE;
 	ath79_wmac_resources[0].end = AR933X_WMAC_BASE + AR933X_WMAC_SIZE - 1;
+	ath79_wmac_resources[1].start = ATH79_CPU_IRQ_IP2;
+	ath79_wmac_resources[1].end = ATH79_CPU_IRQ_IP2;
 
 	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
 	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
@@ -92,12 +98,32 @@ static void __init ar933x_wmac_setup(void)
 	ath79_wmac_data.external_reset = ar933x_wmac_reset;
 }
 
+static void ar934x_wmac_setup(void)
+{
+	u32 t;
+
+	ath79_wmac_device.name = "ar934x_wmac";
+
+	ath79_wmac_resources[0].start = AR934X_WMAC_BASE;
+	ath79_wmac_resources[0].end = AR934X_WMAC_BASE + AR934X_WMAC_SIZE - 1;
+	ath79_wmac_resources[1].start = ATH79_IP2_IRQ(1);
+	ath79_wmac_resources[1].start = ATH79_IP2_IRQ(1);
+
+	t = ath79_reset_rr(AR934X_RESET_REG_BOOTSTRAP);
+	if (t & AR934X_BOOTSTRAP_REF_CLK_40)
+		ath79_wmac_data.is_clk_25mhz = false;
+	else
+		ath79_wmac_data.is_clk_25mhz = true;
+}
+
 void __init ath79_register_wmac(u8 *cal_data)
 {
 	if (soc_is_ar913x())
 		ar913x_wmac_setup();
 	else if (soc_is_ar933x())
 		ar933x_wmac_setup();
+	else if (soc_is_ar934x())
+		ar934x_wmac_setup();
 	else
 		BUG();
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 32abbf9..1caa78a 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -61,6 +61,9 @@
 #define AR933X_EHCI_BASE	0x1b000000
 #define AR933X_EHCI_SIZE	0x1000
 
+#define AR934X_WMAC_BASE	(AR71XX_APB_BASE + 0x00100000)
+#define AR934X_WMAC_SIZE	0x20000
+
 /*
  * DDR_CTRL block
  */
-- 
1.7.2.1
