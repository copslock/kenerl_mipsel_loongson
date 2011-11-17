Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 23:15:43 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:46694 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904065Ab1KQWOV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 23:14:21 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id AD94214046A;
        Thu, 17 Nov 2011 23:14:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C4Z0iAGUxg8f; Thu, 17 Nov 2011 23:14:16 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id E72C914047E;
        Thu, 17 Nov 2011 23:14:14 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Imre Kaloz <kaloz@openwrt.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 4/6] MIPS: ath79: add AR933x specific WMAC setup code
Date:   Thu, 17 Nov 2011 23:13:45 +0100
Message-Id: <1321568027-32066-5-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
References: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14883

The wireless MAC of the AR933x SoCs uses different
base address, and requires different setup code.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-ar913x-wmac.c              |   43 ++++++++++++++++++++++-
 arch/mips/ath79/dev-ar913x-wmac.h              |    4 +-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    4 ++-
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/arch/mips/ath79/dev-ar913x-wmac.c b/arch/mips/ath79/dev-ar913x-wmac.c
index 21118fb..c424e9a 100644
--- a/arch/mips/ath79/dev-ar913x-wmac.c
+++ b/arch/mips/ath79/dev-ar913x-wmac.c
@@ -1,7 +1,7 @@
 /*
- *  Atheros AR913X SoC built-in WMAC device support
+ *  Atheros AR913X/AR933X SoC built-in WMAC device support
  *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
  *  This program is free software; you can redistribute it and/or modify it
@@ -55,10 +55,49 @@ static void __init ar913x_wmac_setup(void)
 	ath79_wmac_resources[0].end = AR913X_WMAC_BASE + AR913X_WMAC_SIZE - 1;
 }
 
+
+static int ar933x_wmac_reset(void)
+{
+	ath79_device_reset_clear(AR933X_RESET_WMAC);
+	ath79_device_reset_set(AR933X_RESET_WMAC);
+
+	return 0;
+}
+
+static int ar933x_r1_get_wmac_revision(void)
+{
+	return ath79_soc_rev;
+}
+
+static void __init ar933x_wmac_setup(void)
+{
+	u32 t;
+
+	ar933x_wmac_reset();
+
+	ath79_wmac_device.name = "ar933x_wmac";
+
+	ath79_wmac_resources[0].start = AR933X_WMAC_BASE;
+	ath79_wmac_resources[0].end = AR933X_WMAC_BASE + AR933X_WMAC_SIZE - 1;
+
+	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
+	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
+		ath79_wmac_data.is_clk_25mhz = false;
+	else
+		ath79_wmac_data.is_clk_25mhz = true;
+
+	if (ath79_soc_rev == 1)
+		ath79_wmac_data.get_mac_revision = ar933x_r1_get_wmac_revision;
+
+	ath79_wmac_data.external_reset = ar933x_wmac_reset;
+}
+
 void __init ath79_register_wmac(u8 *cal_data)
 {
 	if (soc_is_ar913x())
 		ar913x_wmac_setup();
+	if (soc_is_ar933x())
+		ar933x_wmac_setup();
 	else
 		BUG();
 
diff --git a/arch/mips/ath79/dev-ar913x-wmac.h b/arch/mips/ath79/dev-ar913x-wmac.h
index de1d784..c9cd870 100644
--- a/arch/mips/ath79/dev-ar913x-wmac.h
+++ b/arch/mips/ath79/dev-ar913x-wmac.h
@@ -1,7 +1,7 @@
 /*
- *  Atheros AR913X SoC built-in WMAC device support
+ *  Atheros AR913X/AR933X SoC built-in WMAC device support
  *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
  *  This program is free software; you can redistribute it and/or modify it
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 733baca..2f0becb 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -55,7 +55,8 @@
 
 #define AR933X_UART_BASE	(AR71XX_APB_BASE + 0x00020000)
 #define AR933X_UART_SIZE	0x14
-
+#define AR933X_WMAC_BASE	(AR71XX_APB_BASE + 0x00100000)
+#define AR933X_WMAC_SIZE	0x20000
 #define AR933X_EHCI_BASE	0x1b000000
 #define AR933X_EHCI_SIZE	0x1000
 
@@ -233,6 +234,7 @@
 #define AR913X_RESET_USB_HOST		BIT(5)
 #define AR913X_RESET_USB_PHY		BIT(4)
 
+#define AR933X_RESET_WMAC		BIT(11)
 #define AR933X_RESET_USB_HOST		BIT(5)
 #define AR933X_RESET_USB_PHY		BIT(4)
 #define AR933X_RESET_USBSUS_OVERRIDE	BIT(3)
-- 
1.7.2.1
