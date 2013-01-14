Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 17:12:40 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4185 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831955Ab3ANQMiGwC-c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Jan 2013 17:12:38 +0100
Received: from [10.9.208.53] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Jan 2013 08:07:16 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 irvexchcas06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server id 14.1.355.2; Mon, 14 Jan 2013 08:09:30 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 3024640FE4; Mon, 14
 Jan 2013 08:09:28 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 02/10] MIPS: Netlogic: Optimize EIMR/EIRR accesses in
 32-bit
Date:   Mon, 14 Jan 2013 21:41:54 +0530
Message-ID: <1358179922-26663-3-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
References: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7CEAF2BE3Q42012102-05-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Provide functions ack_c0_eirr(), set_c0_eimr(), clear_c0_eimr()
and read_c0_eirr_and_eimr() that do the EIMR and EIRR operations
and update the interrupt handling code to use these functions.
Also, use the EIMR register functions to mask interrupts in the
irq code.

The 64-bit interrupt request and mask registers (EIRR and EIMR) are
accessed when the interrupts are off, and the common operations are
to set or clear a bit in these registers. Using the 64-bit c0 access
functions for these operations is not optimal in 32-bit, because it
will disable/restore interrupts and split/join the 64-bit value during
each register access.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/mips-extns.h |   79 +++++++++++++++++++++++++++
 arch/mips/netlogic/common/irq.c             |   39 +++++--------
 arch/mips/netlogic/common/smp.c             |    8 ++-
 3 files changed, 98 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/mips-extns.h b/arch/mips/include/asm/netlogic/mips-extns.h
index 32ba6d9..cc42965 100644
--- a/arch/mips/include/asm/netlogic/mips-extns.h
+++ b/arch/mips/include/asm/netlogic/mips-extns.h
@@ -68,6 +68,85 @@ do {									\
 		__write_64bit_c0_register($9, 7, (val));		\
 } while (0)
 
+/*
+ * Handling the 64 bit EIMR and EIRR registers in 32-bit mode with
+ * standard functions will be very inefficient. This provides
+ * optimized functions for the normal operations on the registers.
+ *
+ * Call with interrupts disabled.
+ */
+static inline void ack_c0_eirr(int irq)
+{
+	__asm__ __volatile__(
+		".set	push\n\t"
+		".set	mips64\n\t"
+		".set	noat\n\t"
+		"li	$1, 1\n\t"
+		"dsllv	$1, $1, %0\n\t"
+		"dmtc0	$1, $9, 6\n\t"
+		".set	pop"
+		: : "r" (irq));
+}
+
+static inline void set_c0_eimr(int irq)
+{
+	__asm__ __volatile__(
+		".set	push\n\t"
+		".set	mips64\n\t"
+		".set	noat\n\t"
+		"li	$1, 1\n\t"
+		"dsllv	%0, $1, %0\n\t"
+		"dmfc0	$1, $9, 7\n\t"
+		"or	$1, %0\n\t"
+		"dmtc0	$1, $9, 7\n\t"
+		".set	pop"
+		: "+r" (irq));
+}
+
+static inline void clear_c0_eimr(int irq)
+{
+	__asm__ __volatile__(
+		".set	push\n\t"
+		".set	mips64\n\t"
+		".set	noat\n\t"
+		"li	$1, 1\n\t"
+		"dsllv	%0, $1, %0\n\t"
+		"dmfc0	$1, $9, 7\n\t"
+		"or	$1, %0\n\t"
+		"xor	$1, %0\n\t"
+		"dmtc0	$1, $9, 7\n\t"
+		".set	pop"
+		: "+r" (irq));
+}
+
+/*
+ * Read c0 eimr and c0 eirr, do AND of the two values, the result is
+ * the interrupts which are raised and are not masked.
+ */
+static inline uint64_t read_c0_eirr_and_eimr(void)
+{
+	uint64_t val;
+
+#ifdef CONFIG_64BIT
+	val = read_c0_eimr() & read_c0_eirr();
+#else
+	__asm__ __volatile__(
+		".set	push\n\t"
+		".set	mips64\n\t"
+		".set	noat\n\t"
+		"dmfc0	%M0, $9, 6\n\t"
+		"dmfc0	%L0, $9, 7\n\t"
+		"and	%M0, %L0\n\t"
+		"dsll	%L0, %M0, 32\n\t"
+		"dsra	%M0, %M0, 32\n\t"
+		"dsra	%L0, %L0, 32\n\t"
+		".set	pop"
+		: "=r" (val));
+#endif
+
+	return val;
+}
+
 static inline int hard_smp_processor_id(void)
 {
 	return __read_32bit_c0_register($15, 1) & 0x3ff;
diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index 00dcc7a..d42cd1a 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -105,21 +105,23 @@ static void xlp_pic_disable(struct irq_data *d)
 static void xlp_pic_mask_ack(struct irq_data *d)
 {
 	struct nlm_pic_irq *pd = irq_data_get_irq_handler_data(d);
-	uint64_t mask = 1ull << pd->picirq;
 
-	write_c0_eirr(mask);            /* ack by writing EIRR */
+	clear_c0_eimr(pd->picirq);
+	ack_c0_eirr(pd->picirq);
 }
 
 static void xlp_pic_unmask(struct irq_data *d)
 {
 	struct nlm_pic_irq *pd = irq_data_get_irq_handler_data(d);
 
-	if (!pd)
-		return;
+	BUG_ON(!pd);
 
 	if (pd->extra_ack)
 		pd->extra_ack(d);
 
+	/* re-enable the intr on this cpu */
+	set_c0_eimr(pd->picirq);
+
 	/* Ack is a single write, no need to lock */
 	nlm_pic_ack(pd->node->picbase, pd->irt);
 }
@@ -134,32 +136,17 @@ static struct irq_chip xlp_pic = {
 
 static void cpuintr_disable(struct irq_data *d)
 {
-	uint64_t eimr;
-	uint64_t mask = 1ull << d->irq;
-
-	eimr = read_c0_eimr();
-	write_c0_eimr(eimr & ~mask);
+	clear_c0_eimr(d->irq);
 }
 
 static void cpuintr_enable(struct irq_data *d)
 {
-	uint64_t eimr;
-	uint64_t mask = 1ull << d->irq;
-
-	eimr = read_c0_eimr();
-	write_c0_eimr(eimr | mask);
+	set_c0_eimr(d->irq);
 }
 
 static void cpuintr_ack(struct irq_data *d)
 {
-	uint64_t mask = 1ull << d->irq;
-
-	write_c0_eirr(mask);
-}
-
-static void cpuintr_nop(struct irq_data *d)
-{
-	WARN(d->irq >= PIC_IRQ_BASE, "Bad irq %d", d->irq);
+	ack_c0_eirr(d->irq);
 }
 
 /*
@@ -170,9 +157,9 @@ struct irq_chip nlm_cpu_intr = {
 	.name		= "XLP-CPU-INTR",
 	.irq_enable	= cpuintr_enable,
 	.irq_disable	= cpuintr_disable,
-	.irq_mask	= cpuintr_nop,
-	.irq_ack	= cpuintr_nop,
-	.irq_eoi	= cpuintr_ack,
+	.irq_mask	= cpuintr_disable,
+	.irq_ack	= cpuintr_ack,
+	.irq_eoi	= cpuintr_enable,
 };
 
 static void __init nlm_init_percpu_irqs(void)
@@ -265,7 +252,7 @@ asmlinkage void plat_irq_dispatch(void)
 	int i, node;
 
 	node = nlm_nodeid();
-	eirr = read_c0_eirr() & read_c0_eimr();
+	eirr = read_c0_eirr_and_eimr();
 
 	i = __ilog2_u64(eirr);
 	if (i == -1)
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index a080d9e..2bb95dc 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -84,15 +84,19 @@ void nlm_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 /* IRQ_IPI_SMP_FUNCTION Handler */
 void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc)
 {
-	write_c0_eirr(1ull << irq);
+	clear_c0_eimr(irq);
+	ack_c0_eirr(irq);
 	smp_call_function_interrupt();
+	set_c0_eimr(irq);
 }
 
 /* IRQ_IPI_SMP_RESCHEDULE  handler */
 void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc)
 {
-	write_c0_eirr(1ull << irq);
+	clear_c0_eimr(irq);
+	ack_c0_eirr(irq);
 	scheduler_ipi();
+	set_c0_eimr(irq);
 }
 
 /*
-- 
1.7.9.5
