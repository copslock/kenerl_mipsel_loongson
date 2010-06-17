Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 13:36:10 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:40005 "EHLO
        tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490962Ab0FQLgH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 13:36:07 +0200
Received: from mailgate3.nec.co.jp ([10.7.69.160])
        by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o5HBa4BC022504
        for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 20:36:04 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
        id o5HBa4J02111 for linux-mips@linux-mips.org; Thu, 17 Jun 2010 20:36:04 +0900 (JST)
Received: from relay61.aps.necel.com ([10.29.19.64]) by vgate01.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
        id o5HBa3420063 for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 20:36:03 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.36] [10.29.19.36]) by relay61.aps.necel.com with ESMTP; Thu, 17 Jun 2010 20:36:03 +0900
Received: from [10.114.180.181] ([10.114.180.181] [10.114.180.181]) by mbox02.aps.necel.com with ESMTP; Thu, 17 Jun 2010 20:36:03 +0900
Message-ID: <4C1A089E.4050703@renesas.com>
Date:   Thu, 17 Jun 2010 20:35:58 +0900
From:   Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.9) Gecko/20100317 Lightning/1.0b1 Thunderbird/3.0.4
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: [PATCH 1/4] MIPS: EMMA2RH: Remove useless CPU_IRQ_BASE
References: <4C1A0801.60405@renesas.com>
In-Reply-To: <4C1A0801.60405@renesas.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi.px@renesas.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11955

For historical reasons, we used to put MIPS CPU IRQs behind SoC-specific
IRQs in the queue, and have been using CPU_IRQ_BASE as MIPS_CPU_IRQ_BASE.
In recent years, however, we've brought it back to normal order, and now
CPU_IRQ_BASE just redefines the generic MIPS_CPU_IRQ_BASE.

At the same time, NUM_CPU_IRQ is also removed as useless.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 arch/mips/emma/markeins/irq.c        |    8 ++++----
 arch/mips/include/asm/emma/emma2rh.h |    4 +---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
index 9504b7e..1d1c806 100644
--- a/arch/mips/emma/markeins/irq.c
+++ b/arch/mips/emma/markeins/irq.c
@@ -301,7 +301,7 @@ void __init arch_init_irq(void)
 	/* setup cascade interrupts */
 	setup_irq(EMMA2RH_IRQ_BASE + EMMA2RH_SW_CASCADE, &irq_cascade);
 	setup_irq(EMMA2RH_IRQ_BASE + EMMA2RH_GPIO_CASCADE, &irq_cascade);
-	setup_irq(CPU_IRQ_BASE + CPU_EMMA2RH_CASCADE, &irq_cascade);
+	setup_irq(MIPS_CPU_IRQ_BASE + CPU_EMMA2RH_CASCADE, &irq_cascade);
 }
 
 asmlinkage void plat_irq_dispatch(void)
@@ -309,13 +309,13 @@ asmlinkage void plat_irq_dispatch(void)
         unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
 
 	if (pending & STATUSF_IP7)
-		do_IRQ(CPU_IRQ_BASE + 7);
+		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
 	else if (pending & STATUSF_IP2)
 		emma2rh_irq_dispatch();
 	else if (pending & STATUSF_IP1)
-		do_IRQ(CPU_IRQ_BASE + 1);
+		do_IRQ(MIPS_CPU_IRQ_BASE + 1);
 	else if (pending & STATUSF_IP0)
-		do_IRQ(CPU_IRQ_BASE + 0);
+		do_IRQ(MIPS_CPU_IRQ_BASE + 0);
 	else
 		spurious_interrupt();
 }
diff --git a/arch/mips/include/asm/emma/emma2rh.h b/arch/mips/include/asm/emma/emma2rh.h
index 2afb2fe..fcc0064 100644
--- a/arch/mips/include/asm/emma/emma2rh.h
+++ b/arch/mips/include/asm/emma/emma2rh.h
@@ -99,12 +99,10 @@
 #define EMMA2RH_PCI_CONFIG_BASE	EMMA2RH_PCI_IO_BASE
 #define EMMA2RH_PCI_CONFIG_SIZE	EMMA2RH_PCI_IO_SIZE
 
-#define NUM_CPU_IRQ		8
 #define NUM_EMMA2RH_IRQ		96
 
 #define CPU_EMMA2RH_CASCADE	2
-#define CPU_IRQ_BASE		MIPS_CPU_IRQ_BASE
-#define EMMA2RH_IRQ_BASE	(CPU_IRQ_BASE + NUM_CPU_IRQ)
+#define EMMA2RH_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 8)
 
 /*
  * emma2rh irq defs
-- 
1.7.1
