Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 17:19:58 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:48956 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493021Ab0LAQTw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Dec 2010 17:19:52 +0100
Received: by fxm19 with SMTP id 19so2318713fxm.36
        for <multiple recipients>; Wed, 01 Dec 2010 08:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=5DRw8B6nqxf8m5smCIzw9gExgDUc7uytuTyURlhD01A=;
        b=nVaBy7ifuZYNCjOmkZjNszTM+wDxtVlOU+MJzudoowC5qZeUnxzfb5qRNRsAG3fVGU
         9S3VIrc0sBhf6V+8To4qqt2ZrQ6aqOgAK0AkP2kHrUpoZ9Z30e7ZtDSpsX1TnpYACY4R
         vEPj0HUB+VdFqCg0Leair/v4ZV2pc+cqI3ais=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=lO1ZFBc1KYDaZoQIGJejHfT2kfJPh3Eg/XJEV45Th9HQbfuaGQu1bpbsyWcofcAZ6R
         kCoywA420kepBjEHaCtYZjbGuRc521rgLaAruWUm+Hbn6JJD47Gkm8WSvdKpPSCk5FJ4
         V83nkSPQ2ZL9we20uwAQiatGTZaiPLn4hai/A=
Received: by 10.223.89.142 with SMTP id e14mr3975489fam.143.1291220386518;
        Wed, 01 Dec 2010 08:19:46 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id 5sm69637fak.23.2010.12.01.08.19.42
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:19:46 -0800 (PST)
Subject: [RFC 2/3] SMP support MSP CIC and PER cascaded interrupt
From:   Anoop P A <anoop.pa@gmail.com>
To:     kevink@paralogos.com, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 01 Dec 2010 21:52:37 +0530
Message-ID: <1291220557.31413.19.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

>From 1288493c35839fca6c05486445a9eecdecd9a60a Mon Sep 17 00:00:00 2001
Message-Id:
<1288493c35839fca6c05486445a9eecdecd9a60a.1291219118.git.anoop.pa@gmail.com>
In-Reply-To: <cover.1291219118.git.anoop.pa@gmail.com>
References: <cover.1291219118.git.anoop.pa@gmail.com>
From: Anoop P A <anoop.pa@gmail.com>
Date: Wed, 1 Dec 2010 21:03:43 +0530
Subject: [RFC 2/3] SMP support MSP CIC and PER cascaded interrupt
subsystem.
Cc: anoop.pa@gmail.com

Following patches will move PER interrupt handles to seperate file ,
Along with changes for SMP support.

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c |  245
+++++++++++++++++++---------
 arch/mips/pmc-sierra/msp71xx/msp_irq_per.c |  175 ++++++++++++++++++++
 2 files changed, 341 insertions(+), 79 deletions(-)
 create mode 100644 arch/mips/pmc-sierra/msp71xx/msp_irq_per.c

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
b/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
index 07e71ff..f800d0c 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
@@ -1,8 +1,7 @@
 /*
- * This file define the irq handler for MSP SLM subsystem interrupts.
+ * Copyright 2010 PMC-Sierra, Inc, derived from irq_cpu.c
  *
- * Copyright 2005-2007 PMC-Sierra, Inc, derived from irq_cpu.c
- * Author: Andrew Hughes, Andrew_Hughes@pmc-sierra.com
+ * This file define the irq handler for MSP CIC subsystem interrupts.
  *
  * This program is free software; you can redistribute  it and/or
modify it
  * under  the terms of  the GNU General  Public License as published by
the
@@ -14,121 +13,209 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
-#include <linux/irq.h>
 
+#include <asm/mipsregs.h>
 #include <asm/system.h>
 
 #include <msp_cic_int.h>
 #include <msp_regs.h>
 
 /*
- * NOTE: We are only enabling support for VPE0 right now.
+ * External API
  */
+extern void msp_per_irq_init(void);
+extern void msp_per_irq_dispatch(void);
 
-static inline void unmask_msp_cic_irq(unsigned int irq)
+
+/*
+ * Convenience Macro.  Should be somewhere generic.
+ */
+#define get_current_vpe()   \
+	((read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) & TCBIND_CURVPE)
+
+#ifdef CONFIG_SMP
+
+#define LOCK_VPE(flags, mtflags) \
+do {				\
+	local_irq_save(flags);	\
+	mtflags = dmt();	\
+} while (0)
+
+#define UNLOCK_VPE(flags, mtflags) \
+do {				\
+	emt(mtflags);		\
+	local_irq_restore(flags);\
+} while (0)
+
+#define LOCK_CORE(flags, mtflags) \
+do {				\
+	local_irq_save(flags);	\
+	mtflags = dvpe();	\
+} while (0)
+
+#define UNLOCK_CORE(flags, mtflags)		\
+do {				\
+	evpe(mtflags);		\
+	local_irq_restore(flags);\
+} while (0)
+
+#else
+
+#define LOCK_VPE(flags, mtflags)
+#define UNLOCK_VPE(flags, mtflags)
+
+#endif
+
+/* ensure writes to cic are completed */
+static inline void cic_wmb(void)
 {
+	const volatile void __iomem *cic_mem = CIC_VPE0_MSK_REG;
+	volatile u32 dummy_read;
 
-	/* check for PER interrupt range */
-	if (irq < MSP_PER_INTBASE)
-		*CIC_VPE0_MSK_REG |= (1 << (irq - MSP_CIC_INTBASE));
-	else
-		*PER_INT_MSK_REG |= (1 << (irq - MSP_PER_INTBASE));
+	wmb();
+	dummy_read = __raw_readl(cic_mem);
+	dummy_read++;
 }
 
-static inline void mask_msp_cic_irq(unsigned int irq)
+
+static inline void unmask_cic_irq(unsigned int irq)
 {
-	/* check for PER interrupt range */
-	if (irq < MSP_PER_INTBASE)
-		*CIC_VPE0_MSK_REG &= ~(1 << (irq - MSP_CIC_INTBASE));
-	else
-		*PER_INT_MSK_REG &= ~(1 << (irq - MSP_PER_INTBASE));
+	volatile u32   *cic_msk_reg = CIC_VPE0_MSK_REG;
+	int vpe;
+#ifdef CONFIG_SMP
+	unsigned int mtflags;
+	unsigned long  flags;
+
+	/*
+	* Make sure we have IRQ affinity.  It may have changed while
+	* we were processing the IRQ.
+	*/
+	if (!cpumask_test_cpu(smp_processor_id(), irq_desc[irq].affinity))
+		return;
+#endif
+
+	vpe = get_current_vpe();
+	LOCK_VPE(flags, mtflags);
+	cic_msk_reg[vpe] |= (1 << (irq - MSP_CIC_INTBASE));
+	UNLOCK_VPE(flags, mtflags);
+	cic_wmb();
 }
 
-/*
- * While we ack the interrupt interrupts are disabled and thus we don't
need
- * to deal with concurrency issues.  Same for msp_cic_irq_end.
- */
-static inline void ack_msp_cic_irq(unsigned int irq)
+static inline void mask_cic_irq(unsigned int irq)
 {
-	mask_msp_cic_irq(irq);
-
+	volatile u32 *cic_msk_reg = CIC_VPE0_MSK_REG;
+	int	vpe = get_current_vpe();
+#ifdef CONFIG_SMP
+	unsigned long flags, mtflags;
+#endif
+	LOCK_VPE(flags, mtflags);
+	cic_msk_reg[vpe] &= ~(1 << (irq - MSP_CIC_INTBASE));
+	UNLOCK_VPE(flags, mtflags);
+	cic_wmb();
+}
+static inline void msp_cic_irq_ack(unsigned int irq)
+{
+	mask_cic_irq(irq);
 	/*
-	 * only really necessary for 18, 16-14 and sometimes 3:0 (since
-	 * these can be edge sensitive) but it doesn't hurt for the others.
-	 */
-
-	/* check for PER interrupt range */
-	if (irq < MSP_PER_INTBASE)
-		*CIC_STS_REG = (1 << (irq - MSP_CIC_INTBASE));
-	else
-		*PER_INT_STS_REG = (1 << (irq - MSP_PER_INTBASE));
+	* Only really necessary for 18, 16-14 and sometimes 3:0
+	* (since these can be edge sensitive) but it doesn't
+	* hurt for the others
+	*/
+	*CIC_STS_REG = (1 << (irq - MSP_CIC_INTBASE));
 }
 
+static void msp_cic_irq_end(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		unmask_cic_irq(irq);
+}
+
+#ifdef CONFIG_SMP
+static inline int msp_cic_irq_set_affinity(unsigned int irq,
+					const struct cpumask *cpumask)
+{
+	int cpu;
+	unsigned long flags;
+	unsigned int  mtflags;
+	unsigned long imask = (1 << (irq - MSP_CIC_INTBASE));
+	volatile u32 *cic_mask = (volatile u32 *)CIC_VPE0_MSK_REG;
+
+	/* timer balancing should be disabled in kernel code */
+	BUG_ON(irq == MSP_INT_VPE0_TIMER || irq == MSP_INT_VPE1_TIMER);
+
+	LOCK_CORE(flags, mtflags);
+	/* enable if any of each VPE's TCs require this IRQ */
+	for_each_online_cpu(cpu) {
+		if (cpumask_test_cpu(cpu, cpumask))
+			cic_mask[cpu] |= imask;
+		else
+			cic_mask[cpu] &= ~imask;
+
+	}
+
+	UNLOCK_CORE(flags, mtflags);
+	return 0;
+
+}
+#endif
+
 static struct irq_chip msp_cic_irq_controller = {
 	.name = "MSP_CIC",
-	.ack = ack_msp_cic_irq,
-	.mask = ack_msp_cic_irq,
-	.mask_ack = ack_msp_cic_irq,
-	.unmask = unmask_msp_cic_irq,
+	.mask = msp_cic_irq_ack,
+	.mask_ack = msp_cic_irq_ack,
+	.unmask = unmask_cic_irq,
+	.ack = msp_cic_irq_ack,
+	.end = msp_cic_irq_end,
+#ifdef CONFIG_SMP
+	.set_affinity = msp_cic_irq_set_affinity,
+#endif
 };
 
-
 void __init msp_cic_irq_init(void)
 {
 	int i;
-
 	/* Mask/clear interrupts. */
 	*CIC_VPE0_MSK_REG = 0x00000000;
-	*PER_INT_MSK_REG  = 0x00000000;
+	*CIC_VPE1_MSK_REG = 0x00000000;
 	*CIC_STS_REG      = 0xFFFFFFFF;
-	*PER_INT_STS_REG  = 0xFFFFFFFF;
-
-#if defined(CONFIG_PMC_MSP7120_GW) || \
-    defined(CONFIG_PMC_MSP7120_EVAL)
 	/*
-	 * The MSP7120 RG and EVBD boards use IRQ[6:4] for PCI.
-	 * These inputs map to EXT_INT_POL[6:4] inside the CIC.
-	 * They are to be active low, level sensitive.
-	 */
+	* The MSP7120 RG and EVBD boards use IRQ[6:4] for PCI.
+	* These inputs map to EXT_INT_POL[6:4] inside the CIC.
+	* They are to be active low, level sensitive.
+	*/
 	*CIC_EXT_CFG_REG &= 0xFFFF8F8F;
-#endif
 
 	/* initialize all the IRQ descriptors */
-	for (i = MSP_CIC_INTBASE; i < MSP_PER_INTBASE + 32; i++)
+	for (i = MSP_CIC_INTBASE ; i < MSP_CIC_INTBASE + 32 ; i++) {
 		set_irq_chip_and_handler(i, &msp_cic_irq_controller,
 					 handle_level_irq);
+	}
+
+	/* Initialize the PER interrupt sub-system */
+	 msp_per_irq_init();
 }
 
+/* CIC masked by CIC vector processing before dispatch called */
 void msp_cic_irq_dispatch(void)
 {
-	u32 pending;
-	int intbase;
-
-	intbase = MSP_CIC_INTBASE;
-	pending = *CIC_STS_REG & *CIC_VPE0_MSK_REG;
-
-	/* check for PER interrupt */
-	if (pending == (1 << (MSP_INT_PER - MSP_CIC_INTBASE))) {
-		intbase = MSP_PER_INTBASE;
-		pending = *PER_INT_STS_REG & *PER_INT_MSK_REG;
-	}
-
-	/* check for spurious interrupt */
-	if (pending == 0x00000000) {
-		printk(KERN_ERR
-			"Spurious %s interrupt? status %08x, mask %08x\n",
-			(intbase == MSP_CIC_INTBASE) ? "CIC" : "PER",
-			(intbase == MSP_CIC_INTBASE) ?
-				*CIC_STS_REG : *PER_INT_STS_REG,
-			(intbase == MSP_CIC_INTBASE) ?
-				*CIC_VPE0_MSK_REG : *PER_INT_MSK_REG);
-		return;
-	}
-
-	/* check for the timer and dispatch it first */
-	if ((intbase == MSP_CIC_INTBASE) &&
-	    (pending & (1 << (MSP_INT_VPE0_TIMER - MSP_CIC_INTBASE))))
+	volatile u32	*cic_msk_reg = (volatile u32 *)CIC_VPE0_MSK_REG;
+	u32	cic_mask;
+	u32	 pending;
+	int	cic_status = *CIC_STS_REG;
+	cic_mask = cic_msk_reg[get_current_vpe()];
+	pending = cic_status & cic_mask;
+
+	if (pending & (1 << (MSP_INT_VPE0_TIMER - MSP_CIC_INTBASE))) {
 		do_IRQ(MSP_INT_VPE0_TIMER);
-	else
-		do_IRQ(ffs(pending) + intbase - 1);
+	} else if (pending & (1 << (MSP_INT_VPE1_TIMER - MSP_CIC_INTBASE))) {
+		do_IRQ(MSP_INT_VPE1_TIMER);
+	} else if (pending & (1 << (MSP_INT_PER - MSP_CIC_INTBASE))) {
+		msp_per_irq_dispatch();
+	} else if (pending) {
+		do_IRQ(ffs(pending) + MSP_CIC_INTBASE - 1);
+	} else{
+		spurious_interrupt();
+		/* Re-enable the CIC cascaded interrupt. */
+		irq_desc[MSP_INT_CIC].chip->end(MSP_INT_CIC);
+	}
 }
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_per.c
b/arch/mips/pmc-sierra/msp71xx/msp_irq_per.c
new file mode 100644
index 0000000..c7f4d95
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_irq_per.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright 2010 PMC-Sierra, Inc, derived from irq_cpu.c
+ *
+ * This file define the irq handler for MSP PER subsystem interrupts.
+ *
+ * This program is free software; you can redistribute  it and/or
modify it
+ * under  the terms of  the GNU General  Public License as published by
the
+ * Free Software Foundation;  either version 2 of the  License, or (at
your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/bitops.h>
+
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+
+#include <msp_cic_int.h>
+#include <msp_regs.h>
+
+
+/*
+ * Convenience Macro.  Should be somewhere generic.
+ */
+#define get_current_vpe()	\
+	((read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) & TCBIND_CURVPE)
+
+#ifdef CONFIG_SMP
+/*
+ * The PER registers must be protected from concurrent access.
+ */
+
+static DEFINE_SPINLOCK(per_lock);
+#endif
+
+/* ensure writes to per are completed */
+
+static inline void per_wmb(void)
+{
+	const volatile void __iomem *per_mem = PER_INT_MSK_REG;
+	volatile u32 dummy_read;
+
+	wmb();
+	dummy_read = __raw_readl(per_mem);
+	dummy_read++;
+}
+
+static inline void unmask_per_irq(unsigned int irq)
+{
+#ifdef CONFIG_SMP
+	unsigned long flags;
+	spin_lock_irqsave(&per_lock, flags);
+	*PER_INT_MSK_REG |= (1 << (irq - MSP_PER_INTBASE));
+	spin_unlock_irqrestore(&per_lock, flags);
+#else
+	*PER_INT_MSK_REG |= (1 << (irq - MSP_PER_INTBASE));
+#endif
+	per_wmb();
+}
+
+static inline void mask_per_irq(unsigned int irq)
+{
+#ifdef CONFIG_SMP
+	unsigned long flags;
+	spin_lock_irqsave(&per_lock, flags);
+	*PER_INT_MSK_REG &= ~(1 << (irq - MSP_PER_INTBASE));
+	spin_unlock_irqrestore(&per_lock, flags);
+#else
+	*PER_INT_MSK_REG &= ~(1 << (irq - MSP_PER_INTBASE));
+#endif
+	per_wmb();
+}
+
+static inline void msp_per_irq_enable(unsigned int irq)
+{
+	unmask_per_irq(irq);
+}
+
+static inline void msp_per_irq_disable(unsigned int irq)
+{
+	 mask_per_irq(irq);
+}
+
+static unsigned int msp_per_irq_startup(unsigned int irq)
+{
+	msp_per_irq_enable(irq);
+	return 0;
+}
+
+#define    msp_per_irq_shutdown    msp_per_irq_disable
+
+static inline void msp_per_irq_ack(unsigned int irq)
+{
+	mask_per_irq(irq);
+	/*
+	 * In the PER interrupt controller, only bits 11 and 10
+	 * are write-to-clear, (SPI TX complete, SPI RX complete).
+	 * It does nothing for any others.
+	 */
+
+	*PER_INT_STS_REG = (1 << (irq - MSP_PER_INTBASE));
+
+	/* Re-enable the CIC cascaded interrupt and return */
+	irq_desc[MSP_INT_CIC].chip->end(MSP_INT_CIC);
+}
+
+static void msp_per_irq_end(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+	unmask_per_irq(irq);
+}
+
+#ifdef CONFIG_SMP
+static inline int msp_per_irq_set_affinity(unsigned int irq, const
struct cpumask *affinity)
+{
+	unsigned long flags;
+	/*
+	 * Calls to ack, end, startup, enable are spinlocked in setup_irq and
+	 * __do_IRQ.Callers of this function do not spinlock,so we need to do
so
+	 * ourselves.
+	 */
+	raw_spin_lock_irqsave(&irq_desc[irq].lock, flags);
+	msp_per_irq_enable(irq);
+	raw_spin_unlock_irqrestore(&irq_desc[irq].lock, flags);
+	return 0;
+
+}
+#endif
+
+static struct irq_chip msp_per_irq_controller = {
+	.name = "MSP_PER",
+	.startup = msp_per_irq_startup,
+	.shutdown = msp_per_irq_shutdown,
+	.enable = msp_per_irq_enable,
+	.disable = msp_per_irq_disable,
+#ifdef CONFIG_SMP
+	.set_affinity = msp_per_irq_set_affinity,
+#endif
+	.ack = msp_per_irq_ack,
+	.end = msp_per_irq_end,
+};
+
+void __init msp_per_irq_init(void)
+{
+	int i;
+	/* Mask/clear interrupts. */
+	*PER_INT_MSK_REG  = 0x00000000;
+	*PER_INT_STS_REG  = 0xFFFFFFFF;
+	/* initialize all the IRQ descriptors */
+	for (i = MSP_PER_INTBASE; i < MSP_PER_INTBASE + 32; i++) {
+	irq_desc[i].status = IRQ_DISABLED;
+	irq_desc[i].action = NULL;
+	irq_desc[i].depth = 1;
+	irq_desc[i].chip = &msp_per_irq_controller;
+	}
+}
+
+void msp_per_irq_dispatch(void)
+{
+	u32	per_mask = *PER_INT_MSK_REG;
+	u32	per_status = *PER_INT_STS_REG;
+	u32	pending;
+
+	pending = per_status & per_mask;
+	if (pending) {
+		do_IRQ(ffs(pending) + MSP_PER_INTBASE - 1);
+	} else {
+		spurious_interrupt();
+	/* Re-enable the CIC cascaded interrupt and return */
+	irq_desc[MSP_INT_CIC].chip->end(MSP_INT_CIC);
+	}
+}
-- 
1.7.0.4
