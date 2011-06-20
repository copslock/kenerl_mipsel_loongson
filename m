Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:28:13 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35874 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491148Ab1FTT1M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:12 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id D4BE7140219;
        Mon, 20 Jun 2011 21:27:06 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 5D45D140209;
        Mon, 20 Jun 2011 21:27:06 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 02/13] MIPS: ath79: add revision id for the AR933X SoCs
Date:   Mon, 20 Jun 2011 21:26:02 +0200
Message-Id: <1308597973-6037-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A1316B8375A | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16492

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/setup.c                        |   12 ++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    4 ++++
 arch/mips/include/asm/mach-ath79/ath79.h       |    4 +++-
 3 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index dea5af1..4cbd5e0 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -116,6 +116,18 @@ static void __init ath79_detect_sys_type(void)
 		rev = id & AR724X_REV_ID_REVISION_MASK;
 		break;
 
+	case REV_ID_MAJOR_AR9330:
+		ath79_soc = ATH79_SOC_AR9330;
+		chip = "9330";
+		rev = (id & AR933X_REV_ID_REVISION_MASK);
+		break;
+
+	case REV_ID_MAJOR_AR9331:
+		ath79_soc = ATH79_SOC_AR9331;
+		chip = "9331";
+		rev = (id & AR933X_REV_ID_REVISION_MASK);
+		break;
+
 	case REV_ID_MAJOR_AR913X:
 		minor = id & AR913X_REV_ID_MINOR_MASK;
 		rev = id >> AR913X_REV_ID_REVISION_SHIFT;
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 86f0fc8..929be06 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -207,6 +207,8 @@
 #define REV_ID_MAJOR_AR7240		0x00c0
 #define REV_ID_MAJOR_AR7241		0x0100
 #define REV_ID_MAJOR_AR7242		0x1100
+#define REV_ID_MAJOR_AR9330		0x0110
+#define REV_ID_MAJOR_AR9331		0x1110
 
 #define AR71XX_REV_ID_MINOR_MASK	0x3
 #define AR71XX_REV_ID_MINOR_AR7130	0x0
@@ -221,6 +223,8 @@
 #define AR913X_REV_ID_REVISION_MASK	0x3
 #define AR913X_REV_ID_REVISION_SHIFT	2
 
+#define AR933X_REV_ID_REVISION_MASK	0x3
+
 #define AR724X_REV_ID_REVISION_MASK	0x3
 
 /*
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/asm/mach-ath79/ath79.h
index 6a9f168..2dfc94c 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -26,7 +26,9 @@ enum ath79_soc_type {
 	ATH79_SOC_AR7241,
 	ATH79_SOC_AR7242,
 	ATH79_SOC_AR9130,
-	ATH79_SOC_AR9132
+	ATH79_SOC_AR9132,
+	ATH79_SOC_AR9330,
+	ATH79_SOC_AR9331,
 };
 
 extern enum ath79_soc_type ath79_soc;
-- 
1.7.2.1
