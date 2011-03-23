Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:17:28 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47467 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491924Ab1CWVJK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:10 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIe-0001wS-Ny; Wed, 23 Mar 2011 22:09:05 +0100
Message-Id: <20110323210536.656725718@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:04 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 22/38] mips: smtc: Cleanup the hook mess and use irq_data
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-fixup-hook-mess.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/include/asm/irq.h |   60 ++++++++++++++++++++++----------------------
 arch/mips/kernel/irq.c      |    6 ++--
 arch/mips/kernel/smtc.c     |   12 +++-----
 3 files changed, 39 insertions(+), 39 deletions(-)

Index: linux-mips-next/arch/mips/include/asm/irq.h
===================================================================
--- linux-mips-next.orig/arch/mips/include/asm/irq.h
+++ linux-mips-next/arch/mips/include/asm/irq.h
@@ -57,7 +57,7 @@ static inline void smtc_im_ack_irq(unsig
 
 extern int plat_set_irq_affinity(struct irq_data *d,
 				 const struct cpumask *affinity, bool force);
-extern void smtc_forward_irq(unsigned int irq);
+extern void smtc_forward_irq(struct irq_data *d);
 
 /*
  * IRQ affinity hook invoked at the beginning of interrupt dispatch
@@ -70,51 +70,53 @@ extern void smtc_forward_irq(unsigned in
  * cpumask implementations, this version is optimistically assuming
  * that cpumask.h macro overhead is reasonable during interrupt dispatch.
  */
-#define IRQ_AFFINITY_HOOK(irq)						\
-do {									\
-    if (!cpumask_test_cpu(smp_processor_id(), irq_desc[irq].affinity)) {\
-	smtc_forward_irq(irq);						\
-	irq_exit();							\
-	return;								\
-    }									\
-} while (0)
+static inline int handle_on_other_cpu(unsigned int irq)
+{
+	struct irq_data *d = irq_get_irq_data(irq);
+
+	if (cpumask_test_cpu(smp_processor_id(), d->affinity))
+		return 0;
+	smtc_forward_irq(d);
+	return 1;
+}
 
 #else /* Not doing SMTC affinity */
 
-#define IRQ_AFFINITY_HOOK(irq) do { } while (0)
+static inline int handle_on_other_cpu(unsigned int irq) { return 0; }
 
 #endif /* CONFIG_MIPS_MT_SMTC_IRQAFF */
 
 #ifdef CONFIG_MIPS_MT_SMTC_IM_BACKSTOP
 
+static inline void smtc_im_backstop(unsigned int irq)
+{
+	if (irq_hwmask[irq] & 0x0000ff00)
+		write_c0_tccontext(read_c0_tccontext() &
+				   ~(irq_hwmask[irq] & 0x0000ff00));
+}
+
 /*
  * Clear interrupt mask handling "backstop" if irq_hwmask
  * entry so indicates. This implies that the ack() or end()
  * functions will take over re-enabling the low-level mask.
  * Otherwise it will be done on return from exception.
  */
-#define __DO_IRQ_SMTC_HOOK(irq)						\
-do {									\
-	IRQ_AFFINITY_HOOK(irq);						\
-	if (irq_hwmask[irq] & 0x0000ff00)				\
-		write_c0_tccontext(read_c0_tccontext() &		\
-				   ~(irq_hwmask[irq] & 0x0000ff00));	\
-} while (0)
-
-#define __NO_AFFINITY_IRQ_SMTC_HOOK(irq)				\
-do {									\
-	if (irq_hwmask[irq] & 0x0000ff00)                               \
-		write_c0_tccontext(read_c0_tccontext() &		\
-				   ~(irq_hwmask[irq] & 0x0000ff00));	\
-} while (0)
+static inline int smtc_handle_on_other_cpu(unsigned int irq)
+{
+	int ret = handle_on_other_cpu(irq);
+
+	if (!ret)
+		smtc_im_backstop(irq);
+	return ret;
+}
 
 #else
 
-#define __DO_IRQ_SMTC_HOOK(irq)						\
-do {									\
-	IRQ_AFFINITY_HOOK(irq);						\
-} while (0)
-#define __NO_AFFINITY_IRQ_SMTC_HOOK(irq) do { } while (0)
+static inline void smtc_im_backstop(unsigned int irq) { }
+static inline int smtc_handle_on_other_cpu(unsigned int irq)
+{
+	return handle_on_other_cpu(irq);
+}
 
 #endif
 
Index: linux-mips-next/arch/mips/kernel/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/kernel/irq.c
+++ linux-mips-next/arch/mips/kernel/irq.c
@@ -183,8 +183,8 @@ void __irq_entry do_IRQ(unsigned int irq
 {
 	irq_enter();
 	check_stack_overflow();
-	__DO_IRQ_SMTC_HOOK(irq);
-	generic_handle_irq(irq);
+	if (!smtc_handle_on_other_cpu(irq))
+		generic_handle_irq(irq);
 	irq_exit();
 }
 
@@ -197,7 +197,7 @@ void __irq_entry do_IRQ(unsigned int irq
 void __irq_entry do_IRQ_no_affinity(unsigned int irq)
 {
 	irq_enter();
-	__NO_AFFINITY_IRQ_SMTC_HOOK(irq);
+	smtc_im_backstop(irq);
 	generic_handle_irq(irq);
 	irq_exit();
 }
Index: linux-mips-next/arch/mips/kernel/smtc.c
===================================================================
--- linux-mips-next.orig/arch/mips/kernel/smtc.c
+++ linux-mips-next/arch/mips/kernel/smtc.c
@@ -677,9 +677,9 @@ void smtc_set_irq_affinity(unsigned int 
 	 */
 }
 
-void smtc_forward_irq(unsigned int irq)
+void smtc_forward_irq(struct irq_data *d)
 {
-	struct irq_data *d = irq_get_irq_data(irq);
+	unsigned int irq = d->irq;
 	int target;
 
 	/*
@@ -708,12 +708,10 @@ void smtc_forward_irq(unsigned int irq)
 	 */
 
 	/* If no one is eligible, service locally */
-	if (target >= NR_CPUS) {
+	if (target >= NR_CPUS)
 		do_IRQ_no_affinity(irq);
-		return;
-	}
-
-	smtc_send_ipi(target, IRQ_AFFINITY_IPI, irq);
+	else
+		smtc_send_ipi(target, IRQ_AFFINITY_IPI, irq);
 }
 
 #endif /* CONFIG_MIPS_MT_SMTC_IRQAFF */
