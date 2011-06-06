Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 23:43:24 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:3060 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491783Ab1FFVnS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 23:43:18 +0200
X-TM-IMSS-Message-ID: <ccf2e5e400085af2@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id ccf2e5e400085af2 ; Mon, 6 Jun 2011 14:42:25 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 6 Jun 2011 14:44:16 -0700
Date:   Tue, 7 Jun 2011 03:14:12 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Netlogic: SMP fixes for XLR/XLS platform code.
Message-ID: <20110606214406.GA17399@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 06 Jun 2011 21:44:16.0307 (UTC) FILETIME=[E20A9030:01CC2492]
X-archive-position: 30269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4923

Fix few issues in the Netlogic code:
- Use handle_percpu_irq to handle per-cpu interrupts
- Remove unused function nlm_common_ipi_handler()
- Call scheduler_ipi() on SMP_RESCHEDULE_YOURSELF
- Enable interrupts in nlm_smp_finish()

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/xlr/irq.c |    2 +-
 arch/mips/netlogic/xlr/smp.c |   13 ++-----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/mips/netlogic/xlr/irq.c b/arch/mips/netlogic/xlr/irq.c
index 1446d58..521bb73 100644
--- a/arch/mips/netlogic/xlr/irq.c
+++ b/arch/mips/netlogic/xlr/irq.c
@@ -209,7 +209,7 @@ void __init init_xlr_irqs(void)
 			irq_set_chip_and_handler(i, &xlr_pic, handle_level_irq);
 		else
 			irq_set_chip_and_handler(i, &nlm_cpu_intr,
-						handle_level_irq);
+						handle_percpu_irq);
 	}
 #ifdef CONFIG_SMP
 	irq_set_chip_and_handler(IRQ_IPI_SMP_FUNCTION, &nlm_cpu_intr,
diff --git a/arch/mips/netlogic/xlr/smp.c b/arch/mips/netlogic/xlr/smp.c
index b495a7f..d842bce 100644
--- a/arch/mips/netlogic/xlr/smp.c
+++ b/arch/mips/netlogic/xlr/smp.c
@@ -87,17 +87,7 @@ void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc)
 /* IRQ_IPI_SMP_RESCHEDULE  handler */
 void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc)
 {
-	set_need_resched();
-}
-
-void nlm_common_ipi_handler(int irq, struct pt_regs *regs)
-{
-	if (irq == IRQ_IPI_SMP_FUNCTION) {
-		smp_call_function_interrupt();
-	} else {
-		/* Announce that we are for reschduling */
-		set_need_resched();
-	}
+	scheduler_ipi();
 }
 
 /*
@@ -122,6 +112,7 @@ void nlm_smp_finish(void)
 #ifdef notyet
 	nlm_common_msgring_cpu_init();
 #endif
+	local_irq_enable();
 }
 
 void nlm_cpus_done(void)
-- 
1.7.4.1
