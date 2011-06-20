Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:33:00 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35940 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491153Ab1FTT1R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:17 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 7CDAE140217;
        Mon, 20 Jun 2011 21:27:07 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 18089140209;
        Mon, 20 Jun 2011 21:27:07 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 06/13] MIPS: ath79: add AR933X specific IRQ initialization
Date:   Mon, 20 Jun 2011 21:26:06 +0200
Message-Id: <1308597973-6037-7-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A1318335D8F | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16506

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/irq.c                          |    5 ++++-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    5 +++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 0d98114..1b073de 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -129,7 +129,7 @@ static void __init ath79_misc_irq_init(void)
 
 	if (soc_is_ar71xx() || soc_is_ar913x())
 		ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
-	else if (soc_is_ar724x())
+	else if (soc_is_ar724x() || soc_is_ar933x())
 		ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
 	else
 		BUG();
@@ -186,6 +186,9 @@ void __init arch_init_irq(void)
 	} else if (soc_is_ar913x()) {
 		ath79_ip2_flush_reg = AR913X_DDR_REG_FLUSH_WMAC;
 		ath79_ip3_flush_reg = AR913X_DDR_REG_FLUSH_USB;
+	} else if (soc_is_ar933x()) {
+		ath79_ip2_flush_reg = AR933X_DDR_REG_FLUSH_WMAC;
+		ath79_ip3_flush_reg = AR933X_DDR_REG_FLUSH_USB;
 	} else
 		BUG();
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index c7159e3..9c76185 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -82,6 +82,11 @@
 #define AR913X_DDR_REG_FLUSH_USB	0x84
 #define AR913X_DDR_REG_FLUSH_WMAC	0x88
 
+#define AR933X_DDR_REG_FLUSH_GE0	0x7c
+#define AR933X_DDR_REG_FLUSH_GE1	0x80
+#define AR933X_DDR_REG_FLUSH_USB	0x84
+#define AR933X_DDR_REG_FLUSH_WMAC	0x88
+
 /*
  * PLL block
  */
-- 
1.7.2.1
