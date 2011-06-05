Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2011 23:39:28 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47313 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491099Ab1FEVjA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2011 23:39:00 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id B733E1401D5;
        Sun,  5 Jun 2011 23:38:54 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 55C901400FF;
        Sun,  5 Jun 2011 23:38:54 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2 1/3] MIPS: ath79: modify number of available IRQs
Date:   Sun,  5 Jun 2011 23:38:44 +0200
Message-Id: <1307309926-2486-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
X-VBMS: A1232C712E7 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3675

The status register of the miscellaneous interrupt controller
is 32 bits wide, but the actual value of NR_IRQS covers only 8
of them. Modify NR_IRQS in order to make all of those interrupt
lines usable.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Changes since v1:
- change the subject line

 arch/mips/include/asm/mach-ath79/irq.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-ath79/irq.h b/arch/mips/include/asm/mach-ath79/irq.h
index 189bc6e..cffbeab 100644
--- a/arch/mips/include/asm/mach-ath79/irq.h
+++ b/arch/mips/include/asm/mach-ath79/irq.h
@@ -10,10 +10,10 @@
 #define __ASM_MACH_ATH79_IRQ_H
 
 #define MIPS_CPU_IRQ_BASE	0
-#define NR_IRQS			16
+#define NR_IRQS			40
 
 #define ATH79_MISC_IRQ_BASE	8
-#define ATH79_MISC_IRQ_COUNT	8
+#define ATH79_MISC_IRQ_COUNT	32
 
 #define ATH79_CPU_IRQ_IP2	(MIPS_CPU_IRQ_BASE + 2)
 #define ATH79_CPU_IRQ_USB	(MIPS_CPU_IRQ_BASE + 3)
-- 
1.7.2.1
