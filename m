Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jul 2015 17:14:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50950 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009989AbbGXPOfBCafG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jul 2015 17:14:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 023614E227A4F
        for <linux-mips@linux-mips.org>; Fri, 24 Jul 2015 16:14:25 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 24 Jul 2015 16:14:28 +0100
Received: from asmith-linux.le.imgtec.org (192.168.154.115) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 24 Jul 2015 16:14:27 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH] MIPS: SMP: Don't increment irq_count multiple times for call function IPIs
Date:   Fri, 24 Jul 2015 16:14:22 +0100
Message-ID: <1437750862-3443-1-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 2.4.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.115]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The majority of SMP platforms handle their IPIs through do_IRQ()
which calls irq_{enter/exit}(). When a call function IPI is received,
smp_call_function_interrupt() is called which also calls
irq_{enter,exit}(), meaning irq_count is raised twice.

When tick broadcasting is used (which is implemented via a call
function IPI), this incorrectly causes all CPU idle time on the core
receiving broadcast ticks to be accounted as time spent servicing
IRQs, as account_process_tick() will account as such if irq_count is
greater than 1. This results in 100% CPU usage being reported on a
core which receives its ticks via broadcast.

This patch removes the SMP smp_call_function_interrupt() wrapper which
calls irq_{enter,exit}(). Platforms which handle their IPIs through
do_IRQ() now call generic_smp_call_function_interrupt() directly to
avoid incrementing irq_count a second time. Platforms which don't
(loongson, sgi-ip27, sibyte) call generic_smp_call_function_interrupt()
wrapped in irq_{enter,exit}().

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
---
 arch/mips/cavium-octeon/smp.c         |  2 +-
 arch/mips/include/asm/smp.h           |  2 --
 arch/mips/kernel/smp-bmips.c          |  4 ++--
 arch/mips/kernel/smp.c                | 10 ----------
 arch/mips/lantiq/irq.c                |  2 +-
 arch/mips/loongson64/loongson-3/smp.c |  7 +++++--
 arch/mips/mti-malta/malta-int.c       |  2 +-
 arch/mips/netlogic/common/smp.c       |  2 +-
 arch/mips/paravirt/paravirt-smp.c     |  2 +-
 arch/mips/pmcs-msp71xx/msp_smp.c      |  2 +-
 arch/mips/sgi-ip27/ip27-irq.c         |  8 ++++++--
 arch/mips/sibyte/bcm1480/smp.c        |  9 +++++----
 arch/mips/sibyte/sb1250/smp.c         |  7 +++++--
 13 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 56f5d080ef9d..b7fa9ae28c36 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -42,7 +42,7 @@ static irqreturn_t mailbox_interrupt(int irq, void *dev_id)
 	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(coreid), action);
 
 	if (action & SMP_CALL_FUNCTION)
-		smp_call_function_interrupt();
+		generic_smp_call_function_interrupt();
 	if (action & SMP_RESCHEDULE_YOURSELF)
 		scheduler_ipi();
 
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 16f1ea9ab191..03722d4326a1 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -83,8 +83,6 @@ static inline void __cpu_die(unsigned int cpu)
 extern void play_dead(void);
 #endif
 
-extern asmlinkage void smp_call_function_interrupt(void);
-
 static inline void arch_send_call_function_single_ipi(int cpu)
 {
 	extern struct plat_smp_ops *mp_ops;	/* private */
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 336708ae5c5b..78cf8c2f1de0 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -284,7 +284,7 @@ static irqreturn_t bmips5000_ipi_interrupt(int irq, void *dev_id)
 	if (action == 0)
 		scheduler_ipi();
 	else
-		smp_call_function_interrupt();
+		generic_smp_call_function_interrupt();
 
 	return IRQ_HANDLED;
 }
@@ -336,7 +336,7 @@ static irqreturn_t bmips43xx_ipi_interrupt(int irq, void *dev_id)
 	if (action & SMP_RESCHEDULE_YOURSELF)
 		scheduler_ipi();
 	if (action & SMP_CALL_FUNCTION)
-		smp_call_function_interrupt();
+		generic_smp_call_function_interrupt();
 
 	return IRQ_HANDLED;
 }
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index d0744cc77ea7..a31896c33716 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -192,16 +192,6 @@ asmlinkage void start_secondary(void)
 	cpu_startup_entry(CPUHP_ONLINE);
 }
 
-/*
- * Call into both interrupt handlers, as we share the IPI for them
- */
-void __irq_entry smp_call_function_interrupt(void)
-{
-	irq_enter();
-	generic_smp_call_function_interrupt();
-	irq_exit();
-}
-
 static void stop_this_cpu(void *dummy)
 {
 	/*
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 6ab10573490d..be18648cb8c8 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -293,7 +293,7 @@ static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
 
 static irqreturn_t ipi_call_interrupt(int irq, void *dev_id)
 {
-	smp_call_function_interrupt();
+	generic_smp_call_function_interrupt();
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 509877c6e9d9..1a4738a8f2d3 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -266,8 +266,11 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
 	if (action & SMP_RESCHEDULE_YOURSELF)
 		scheduler_ipi();
 
-	if (action & SMP_CALL_FUNCTION)
-		smp_call_function_interrupt();
+	if (action & SMP_CALL_FUNCTION) {
+		irq_enter();
+		generic_smp_call_function_interrupt();
+		irq_exit();
+	}
 
 	if (action & SMP_ASK_C0COUNT) {
 		BUG_ON(cpu != 0);
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index d1392f8f5811..fa8f591f3713 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -222,7 +222,7 @@ static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
 
 static irqreturn_t ipi_call_interrupt(int irq, void *dev_id)
 {
-	smp_call_function_interrupt();
+	generic_smp_call_function_interrupt();
 
 	return IRQ_HANDLED;
 }
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index dc3e327fbbac..f5fff228b347 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -86,7 +86,7 @@ void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc)
 {
 	clear_c0_eimr(irq);
 	ack_c0_eirr(irq);
-	smp_call_function_interrupt();
+	generic_smp_call_function_interrupt();
 	set_c0_eimr(irq);
 }
 
diff --git a/arch/mips/paravirt/paravirt-smp.c b/arch/mips/paravirt/paravirt-smp.c
index 42181c7105df..f8d3e081b2eb 100644
--- a/arch/mips/paravirt/paravirt-smp.c
+++ b/arch/mips/paravirt/paravirt-smp.c
@@ -114,7 +114,7 @@ static irqreturn_t paravirt_reched_interrupt(int irq, void *dev_id)
 
 static irqreturn_t paravirt_function_interrupt(int irq, void *dev_id)
 {
-	smp_call_function_interrupt();
+	generic_smp_call_function_interrupt();
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/mips/pmcs-msp71xx/msp_smp.c b/arch/mips/pmcs-msp71xx/msp_smp.c
index 10170580a2de..ffa0f7101a97 100644
--- a/arch/mips/pmcs-msp71xx/msp_smp.c
+++ b/arch/mips/pmcs-msp71xx/msp_smp.c
@@ -44,7 +44,7 @@ static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
 
 static irqreturn_t ipi_call_interrupt(int irq, void *dev_id)
 {
-	smp_call_function_interrupt();
+	generic_smp_call_function_interrupt();
 
 	return IRQ_HANDLED;
 }
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 3fbaef97a1b8..16ec4e12daa3 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -107,10 +107,14 @@ static void ip27_do_irq_mask0(void)
 		scheduler_ipi();
 	} else if (pend0 & (1UL << CPU_CALL_A_IRQ)) {
 		LOCAL_HUB_CLR_INTR(CPU_CALL_A_IRQ);
-		smp_call_function_interrupt();
+		irq_enter();
+		generic_smp_call_function_interrupt();
+		irq_exit();
 	} else if (pend0 & (1UL << CPU_CALL_B_IRQ)) {
 		LOCAL_HUB_CLR_INTR(CPU_CALL_B_IRQ);
-		smp_call_function_interrupt();
+		irq_enter();
+		generic_smp_call_function_interrupt();
+		irq_exit();
 	} else
 #endif
 	{
diff --git a/arch/mips/sibyte/bcm1480/smp.c b/arch/mips/sibyte/bcm1480/smp.c
index af7d44edd9a8..4c71aea25663 100644
--- a/arch/mips/sibyte/bcm1480/smp.c
+++ b/arch/mips/sibyte/bcm1480/smp.c
@@ -29,8 +29,6 @@
 #include <asm/sibyte/bcm1480_regs.h>
 #include <asm/sibyte/bcm1480_int.h>
 
-extern void smp_call_function_interrupt(void);
-
 /*
  * These are routines for dealing with the bcm1480 smp capabilities
  * independent of board/firmware
@@ -184,6 +182,9 @@ void bcm1480_mailbox_interrupt(void)
 	if (action & SMP_RESCHEDULE_YOURSELF)
 		scheduler_ipi();
 
-	if (action & SMP_CALL_FUNCTION)
-		smp_call_function_interrupt();
+	if (action & SMP_CALL_FUNCTION) {
+		irq_enter();
+		generic_smp_call_function_interrupt();
+		irq_exit();
+	}
 }
diff --git a/arch/mips/sibyte/sb1250/smp.c b/arch/mips/sibyte/sb1250/smp.c
index c0c4b3f88a08..1cf66f5ff23d 100644
--- a/arch/mips/sibyte/sb1250/smp.c
+++ b/arch/mips/sibyte/sb1250/smp.c
@@ -172,6 +172,9 @@ void sb1250_mailbox_interrupt(void)
 	if (action & SMP_RESCHEDULE_YOURSELF)
 		scheduler_ipi();
 
-	if (action & SMP_CALL_FUNCTION)
-		smp_call_function_interrupt();
+	if (action & SMP_CALL_FUNCTION) {
+		irq_enter();
+		generic_smp_call_function_interrupt();
+		irq_exit();
+	}
 }
-- 
2.4.6
