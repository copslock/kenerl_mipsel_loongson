Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:29:39 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35939 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491152Ab1FTT1R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:17 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 627D714021F;
        Mon, 20 Jun 2011 21:27:07 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id E92C8140209;
        Mon, 20 Jun 2011 21:27:06 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 05/13] MIPS: ath79: add AR933X specific glue for ath79_device_reset_{set,clear}
Date:   Mon, 20 Jun 2011 21:26:05 +0200
Message-Id: <1308597973-6037-6-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A1317E14CDF | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16497

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/common.c                       |    4 ++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index 58f60e7..38c2ad7 100644
--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -64,6 +64,8 @@ void ath79_device_reset_set(u32 mask)
 		reg = AR724X_RESET_REG_RESET_MODULE;
 	else if (soc_is_ar913x())
 		reg = AR913X_RESET_REG_RESET_MODULE;
+	else if (soc_is_ar933x())
+		reg = AR933X_RESET_REG_RESET_MODULE;
 	else
 		BUG();
 
@@ -86,6 +88,8 @@ void ath79_device_reset_clear(u32 mask)
 		reg = AR724X_RESET_REG_RESET_MODULE;
 	else if (soc_is_ar913x())
 		reg = AR913X_RESET_REG_RESET_MODULE;
+	else if (soc_is_ar933x())
+		reg = AR933X_RESET_REG_RESET_MODULE;
 	else
 		BUG();
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 418b739..c7159e3 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -173,6 +173,7 @@
 
 #define AR724X_RESET_REG_RESET_MODULE		0x1c
 
+#define AR933X_RESET_REG_RESET_MODULE		0x1c
 #define AR933X_RESET_REG_BOOTSTRAP		0xac
 
 #define MISC_INT_ETHSW			BIT(12)
-- 
1.7.2.1
