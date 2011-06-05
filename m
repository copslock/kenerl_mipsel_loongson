Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2011 20:49:48 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47452 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491771Ab1FEStn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2011 20:49:43 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id BC9C01400EE;
        Sun,  5 Jun 2011 20:49:37 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 3CC1B14009A;
        Sun,  5 Jun 2011 20:49:37 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: ***SPAM*** [PATCH 1/3] MIPS: ath79: increase NR_IRQS
Date:   Sun,  5 Jun 2011 20:49:25 +0200
Message-Id: <1307299767-18328-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
X-VBMS: A137B05F250 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3593

The status register of the miscellaneous interrupt controller
is 32 bits wide, but the actual value of NR_IRQS covers only 8
of them. Increase NR_IRQS in order to make all of those interrupt
lines usable.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
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
