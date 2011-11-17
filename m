Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 23:15:16 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:46692 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904064Ab1KQWOV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 23:14:21 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 032D9140451;
        Thu, 17 Nov 2011 23:14:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 94SjYPzss178; Thu, 17 Nov 2011 23:14:15 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 8FBF814046A;
        Thu, 17 Nov 2011 23:14:14 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Imre Kaloz <kaloz@openwrt.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 3/6] MIPS: ath79: separate AR913x SoC specific WMAC setup code
Date:   Thu, 17 Nov 2011 23:13:44 +0100
Message-Id: <1321568027-32066-4-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
References: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14882

The device registration code can be shared between
the different SoCs, but the required setup code varies
Move AR913x specific setup code into a separate function
in order to make adding support for another SoCs easier.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-ar913x-wmac.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/mips/ath79/dev-ar913x-wmac.c b/arch/mips/ath79/dev-ar913x-wmac.c
index 2c9ba40..21118fb 100644
--- a/arch/mips/ath79/dev-ar913x-wmac.c
+++ b/arch/mips/ath79/dev-ar913x-wmac.c
@@ -23,8 +23,7 @@ static struct ath9k_platform_data ath79_wmac_data;
 
 static struct resource ath79_wmac_resources[] = {
 	{
-		.start	= AR913X_WMAC_BASE,
-		.end	= AR913X_WMAC_BASE + AR913X_WMAC_SIZE - 1,
+		/* .start and .end fields are filled dynamically */
 		.flags	= IORESOURCE_MEM,
 	}, {
 		.start	= ATH79_CPU_IRQ_IP2,
@@ -43,12 +42,8 @@ static struct platform_device ath79_wmac_device = {
 	},
 };
 
-void __init ath79_register_wmac(u8 *cal_data)
+static void __init ar913x_wmac_setup(void)
 {
-	if (cal_data)
-		memcpy(ath79_wmac_data.eeprom_data, cal_data,
-		       sizeof(ath79_wmac_data.eeprom_data));
-
 	/* reset the WMAC */
 	ath79_device_reset_set(AR913X_RESET_AMBA2WMAC);
 	mdelay(10);
@@ -56,5 +51,20 @@ void __init ath79_register_wmac(u8 *cal_data)
 	ath79_device_reset_clear(AR913X_RESET_AMBA2WMAC);
 	mdelay(10);
 
+	ath79_wmac_resources[0].start = AR913X_WMAC_BASE;
+	ath79_wmac_resources[0].end = AR913X_WMAC_BASE + AR913X_WMAC_SIZE - 1;
+}
+
+void __init ath79_register_wmac(u8 *cal_data)
+{
+	if (soc_is_ar913x())
+		ar913x_wmac_setup();
+	else
+		BUG();
+
+	if (cal_data)
+		memcpy(ath79_wmac_data.eeprom_data, cal_data,
+		       sizeof(ath79_wmac_data.eeprom_data));
+
 	platform_device_register(&ath79_wmac_device);
 }
-- 
1.7.2.1
