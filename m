Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2011 20:50:10 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47454 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491772Ab1FEStn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2011 20:49:43 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id D6F3D1401D3;
        Sun,  5 Jun 2011 20:49:37 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 643E914009A;
        Sun,  5 Jun 2011 20:49:37 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/3] MIPS: ath79: handle more MISC IRQs
Date:   Sun,  5 Jun 2011 20:49:26 +0200
Message-Id: <1307299767-18328-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1307299767-18328-1-git-send-email-juhosg@openwrt.org>
References: <1307299767-18328-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A137B37F3FE | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3594

The AR724X SoCs have more IRQ sources hooked into the MISC IRQ
controller. The patch adds support for them.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/irq.c                          |   12 ++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    4 ++++
 arch/mips/include/asm/mach-ath79/irq.h         |    4 ++++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index ac610d5..0d98114 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -46,6 +46,15 @@ static void ath79_misc_irq_handler(unsigned int irq, struct irq_desc *desc)
 	else if (pending & MISC_INT_TIMER)
 		generic_handle_irq(ATH79_MISC_IRQ_TIMER);
 
+	else if (pending & MISC_INT_TIMER2)
+		generic_handle_irq(ATH79_MISC_IRQ_TIMER2);
+
+	else if (pending & MISC_INT_TIMER3)
+		generic_handle_irq(ATH79_MISC_IRQ_TIMER3);
+
+	else if (pending & MISC_INT_TIMER4)
+		generic_handle_irq(ATH79_MISC_IRQ_TIMER4);
+
 	else if (pending & MISC_INT_OHCI)
 		generic_handle_irq(ATH79_MISC_IRQ_OHCI);
 
@@ -58,6 +67,9 @@ static void ath79_misc_irq_handler(unsigned int irq, struct irq_desc *desc)
 	else if (pending & MISC_INT_WDOG)
 		generic_handle_irq(ATH79_MISC_IRQ_WDOG);
 
+	else if (pending & MISC_INT_ETHSW)
+		generic_handle_irq(ATH79_MISC_IRQ_ETHSW);
+
 	else
 		spurious_interrupt();
 }
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index cda1c80..da0d894 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -130,6 +130,10 @@
 
 #define AR724X_RESET_REG_RESET_MODULE		0x1c
 
+#define MISC_INT_ETHSW			BIT(12)
+#define MISC_INT_TIMER4			BIT(10)
+#define MISC_INT_TIMER3			BIT(9)
+#define MISC_INT_TIMER2			BIT(8)
 #define MISC_INT_DMA			BIT(7)
 #define MISC_INT_OHCI			BIT(6)
 #define MISC_INT_PERFC			BIT(5)
diff --git a/arch/mips/include/asm/mach-ath79/irq.h b/arch/mips/include/asm/mach-ath79/irq.h
index cffbeab..519958f 100644
--- a/arch/mips/include/asm/mach-ath79/irq.h
+++ b/arch/mips/include/asm/mach-ath79/irq.h
@@ -30,6 +30,10 @@
 #define ATH79_MISC_IRQ_PERFC	(ATH79_MISC_IRQ_BASE + 5)
 #define ATH79_MISC_IRQ_OHCI	(ATH79_MISC_IRQ_BASE + 6)
 #define ATH79_MISC_IRQ_DMA	(ATH79_MISC_IRQ_BASE + 7)
+#define ATH79_MISC_IRQ_TIMER2	(ATH79_MISC_IRQ_BASE + 8)
+#define ATH79_MISC_IRQ_TIMER3	(ATH79_MISC_IRQ_BASE + 9)
+#define ATH79_MISC_IRQ_TIMER4	(ATH79_MISC_IRQ_BASE + 10)
+#define ATH79_MISC_IRQ_ETHSW	(ATH79_MISC_IRQ_BASE + 12)
 
 #include_next <irq.h>
 
-- 
1.7.2.1
