Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 17:04:29 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:34518 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038576AbWLFRE0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2006 17:04:26 +0000
Received: from localhost (p6066-ipad209funabasi.chiba.ocn.ne.jp [58.88.117.66])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3F921B9D5; Thu,  7 Dec 2006 02:04:18 +0900 (JST)
Date:	Thu, 07 Dec 2006 02:04:17 +0900 (JST)
Message-Id: <20061207.020417.126141622.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Import updates from i386's i8259.c (take #3)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Import many updates from i386's i8259.c, especially genirq
transitions.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/i8259.c |  162 +++++++++++++++++++++++----------------------
 include/asm-mips/i8259.h |   37 ++++++++--
 2 files changed, 115 insertions(+), 84 deletions(-)

diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index 2526c0c..b59a676 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -19,9 +19,6 @@ #include <linux/sysdev.h>
 #include <asm/i8259.h>
 #include <asm/io.h>
 
-void enable_8259A_irq(unsigned int irq);
-void disable_8259A_irq(unsigned int irq);
-
 /*
  * This is the 'legacy' 8259A Programmable Interrupt Controller,
  * present in the majority of PC/AT boxes.
@@ -31,23 +28,16 @@ void disable_8259A_irq(unsigned int irq)
  * moves to arch independent land
  */
 
+static int i8259A_auto_eoi;
 DEFINE_SPINLOCK(i8259A_lock);
-
-static void end_8259A_irq (unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)) &&
-	    irq_desc[irq].action)
-		enable_8259A_irq(irq);
-}
-
+/* some platforms call this... */
 void mask_and_ack_8259A(unsigned int);
 
-static struct irq_chip i8259A_irq_type = {
-	.typename = "XT-PIC",
-	.enable = enable_8259A_irq,
-	.disable = disable_8259A_irq,
-	.ack = mask_and_ack_8259A,
-	.end = end_8259A_irq,
+static struct irq_chip i8259A_chip = {
+	.name		= "XT-PIC",
+	.mask		= disable_8259A_irq,
+	.unmask		= enable_8259A_irq,
+	.mask_ack	= mask_and_ack_8259A,
 };
 
 /*
@@ -59,8 +49,8 @@ static struct irq_chip i8259A_irq_type =
  */
 static unsigned int cached_irq_mask = 0xffff;
 
-#define cached_21	(cached_irq_mask)
-#define cached_A1	(cached_irq_mask >> 8)
+#define cached_master_mask	(cached_irq_mask)
+#define cached_slave_mask	(cached_irq_mask >> 8)
 
 void disable_8259A_irq(unsigned int irq)
 {
@@ -70,9 +60,9 @@ void disable_8259A_irq(unsigned int irq)
 	spin_lock_irqsave(&i8259A_lock, flags);
 	cached_irq_mask |= mask;
 	if (irq & 8)
-		outb(cached_A1,0xA1);
+		outb(cached_slave_mask, PIC_SLAVE_IMR);
 	else
-		outb(cached_21,0x21);
+		outb(cached_master_mask, PIC_MASTER_IMR);
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
@@ -84,9 +74,9 @@ void enable_8259A_irq(unsigned int irq)
 	spin_lock_irqsave(&i8259A_lock, flags);
 	cached_irq_mask &= mask;
 	if (irq & 8)
-		outb(cached_A1,0xA1);
+		outb(cached_slave_mask, PIC_SLAVE_IMR);
 	else
-		outb(cached_21,0x21);
+		outb(cached_master_mask, PIC_MASTER_IMR);
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
@@ -98,9 +88,9 @@ int i8259A_irq_pending(unsigned int irq)
 
 	spin_lock_irqsave(&i8259A_lock, flags);
 	if (irq < 8)
-		ret = inb(0x20) & mask;
+		ret = inb(PIC_MASTER_CMD) & mask;
 	else
-		ret = inb(0xA0) & (mask >> 8);
+		ret = inb(PIC_SLAVE_CMD) & (mask >> 8);
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 
 	return ret;
@@ -109,7 +99,7 @@ int i8259A_irq_pending(unsigned int irq)
 void make_8259A_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-	set_irq_chip(irq, &i8259A_irq_type);
+	set_irq_chip_and_handler(irq, &i8259A_chip, handle_level_irq);
 	enable_irq(irq);
 }
 
@@ -125,14 +115,14 @@ static inline int i8259A_irq_real(unsign
 	int irqmask = 1 << irq;
 
 	if (irq < 8) {
-		outb(0x0B,0x20);		/* ISR register */
-		value = inb(0x20) & irqmask;
-		outb(0x0A,0x20);		/* back to the IRR register */
+		outb(0x0B,PIC_MASTER_CMD);	/* ISR register */
+		value = inb(PIC_MASTER_CMD) & irqmask;
+		outb(0x0A,PIC_MASTER_CMD);	/* back to the IRR register */
 		return value;
 	}
-	outb(0x0B,0xA0);		/* ISR register */
-	value = inb(0xA0) & (irqmask >> 8);
-	outb(0x0A,0xA0);		/* back to the IRR register */
+	outb(0x0B,PIC_SLAVE_CMD);	/* ISR register */
+	value = inb(PIC_SLAVE_CMD) & (irqmask >> 8);
+	outb(0x0A,PIC_SLAVE_CMD);	/* back to the IRR register */
 	return value;
 }
 
@@ -149,17 +139,19 @@ void mask_and_ack_8259A(unsigned int irq
 
 	spin_lock_irqsave(&i8259A_lock, flags);
 	/*
-	 * Lightweight spurious IRQ detection. We do not want to overdo
-	 * spurious IRQ handling - it's usually a sign of hardware problems, so
-	 * we only do the checks we can do without slowing down good hardware
-	 * nnecesserily.
+	 * Lightweight spurious IRQ detection. We do not want
+	 * to overdo spurious IRQ handling - it's usually a sign
+	 * of hardware problems, so we only do the checks we can
+	 * do without slowing down good hardware unnecessarily.
 	 *
-	 * Note that IRQ7 and IRQ15 (the two spurious IRQs usually resulting
-	 * rom the 8259A-1|2 PICs) occur even if the IRQ is masked in the 8259A.
-	 * Thus we can check spurious 8259A IRQs without doing the quite slow
-	 * i8259A_irq_real() call for every IRQ.  This does not cover 100% of
-	 * spurious interrupts, but should be enough to warn the user that
-	 * there is something bad going on ...
+	 * Note that IRQ7 and IRQ15 (the two spurious IRQs
+	 * usually resulting from the 8259A-1|2 PICs) occur
+	 * even if the IRQ is masked in the 8259A. Thus we
+	 * can check spurious 8259A IRQs without doing the
+	 * quite slow i8259A_irq_real() call for every IRQ.
+	 * This does not cover 100% of spurious interrupts,
+	 * but should be enough to warn the user that there
+	 * is something bad going on ...
 	 */
 	if (cached_irq_mask & irqmask)
 		goto spurious_8259A_irq;
@@ -167,14 +159,14 @@ void mask_and_ack_8259A(unsigned int irq
 
 handle_real_irq:
 	if (irq & 8) {
-		inb(0xA1);		/* DUMMY - (do we need this?) */
-		outb(cached_A1,0xA1);
-		outb(0x60+(irq&7),0xA0);/* 'Specific EOI' to slave */
-		outb(0x62,0x20);	/* 'Specific EOI' to master-IRQ2 */
+		inb(PIC_SLAVE_IMR);	/* DUMMY - (do we need this?) */
+		outb(cached_slave_mask, PIC_SLAVE_IMR);
+		outb(0x60+(irq&7),PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
+		outb(0x60+PIC_CASCADE_IR,PIC_MASTER_CMD); /* 'Specific EOI' to master-IRQ2 */
 	} else {
-		inb(0x21);		/* DUMMY - (do we need this?) */
-		outb(cached_21,0x21);
-		outb(0x60+irq,0x20);	/* 'Specific EOI' to master */
+		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
+		outb(cached_master_mask, PIC_MASTER_IMR);
+		outb(0x60+irq,PIC_MASTER_CMD);	/* 'Specific EOI to master */
 	}
 #ifdef CONFIG_MIPS_MT_SMTC
         if (irq_hwmask[irq] & ST0_IM)
@@ -195,7 +187,7 @@ spurious_8259A_irq:
 		goto handle_real_irq;
 
 	{
-		static int spurious_irq_mask = 0;
+		static int spurious_irq_mask;
 		/*
 		 * At this point we can be sure the IRQ is spurious,
 		 * lets ACK and report it. [once per IRQ]
@@ -216,13 +208,25 @@ spurious_8259A_irq:
 
 static int i8259A_resume(struct sys_device *dev)
 {
-	init_8259A(0);
+	init_8259A(i8259A_auto_eoi);
+	return 0;
+}
+
+static int i8259A_shutdown(struct sys_device *dev)
+{
+	/* Put the i8259A into a quiescent state that
+	 * the kernel initialization code can get it
+	 * out of.
+	 */
+	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
+	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-1 */
 	return 0;
 }
 
 static struct sysdev_class i8259_sysdev_class = {
 	set_kset_name("i8259"),
 	.resume = i8259A_resume,
+	.shutdown = i8259A_shutdown,
 };
 
 static struct sys_device device_i8259A = {
@@ -244,41 +248,41 @@ void __init init_8259A(int auto_eoi)
 {
 	unsigned long flags;
 
+	i8259A_auto_eoi = auto_eoi;
+
 	spin_lock_irqsave(&i8259A_lock, flags);
 
-	outb(0xff, 0x21);	/* mask all of 8259A-1 */
-	outb(0xff, 0xA1);	/* mask all of 8259A-2 */
+	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
+	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-2 */
 
 	/*
 	 * outb_p - this has to work on a wide range of PC hardware.
 	 */
-	outb_p(0x11, 0x20);	/* ICW1: select 8259A-1 init */
-	outb_p(0x00, 0x21);	/* ICW2: 8259A-1 IR0-7 mapped to 0x00-0x07 */
-	outb_p(0x04, 0x21);	/* 8259A-1 (the master) has a slave on IR2 */
-	if (auto_eoi)
-		outb_p(0x03, 0x21);	/* master does Auto EOI */
-	else
-		outb_p(0x01, 0x21);	/* master expects normal EOI */
-
-	outb_p(0x11, 0xA0);	/* ICW1: select 8259A-2 init */
-	outb_p(0x08, 0xA1);	/* ICW2: 8259A-2 IR0-7 mapped to 0x08-0x0f */
-	outb_p(0x02, 0xA1);	/* 8259A-2 is a slave on master's IR2 */
-	outb_p(0x01, 0xA1);	/* (slave's support for AEOI in flat mode
-				    is to be investigated) */
-
+	outb_p(0x11, PIC_MASTER_CMD);	/* ICW1: select 8259A-1 init */
+	outb_p(I8259A_IRQ_BASE + 0, PIC_MASTER_IMR);	/* ICW2: 8259A-1 IR0 mapped to I8259A_IRQ_BASE + 0x00 */
+	outb_p(1U << PIC_CASCADE_IR, PIC_MASTER_IMR);	/* 8259A-1 (the master) has a slave on IR2 */
+	if (auto_eoi)	/* master does Auto EOI */
+		outb_p(MASTER_ICW4_DEFAULT | PIC_ICW4_AEOI, PIC_MASTER_IMR);
+	else		/* master expects normal EOI */
+		outb_p(MASTER_ICW4_DEFAULT, PIC_MASTER_IMR);
+
+	outb_p(0x11, PIC_SLAVE_CMD);	/* ICW1: select 8259A-2 init */
+	outb_p(I8259A_IRQ_BASE + 8, PIC_SLAVE_IMR);	/* ICW2: 8259A-2 IR0 mapped to I8259A_IRQ_BASE + 0x08 */
+	outb_p(PIC_CASCADE_IR, PIC_SLAVE_IMR);	/* 8259A-2 is a slave on master's IR2 */
+	outb_p(SLAVE_ICW4_DEFAULT, PIC_SLAVE_IMR); /* (slave's support for AEOI in flat mode is to be investigated) */
 	if (auto_eoi)
 		/*
-		 * in AEOI mode we just have to mask the interrupt
+		 * In AEOI mode we just have to mask the interrupt
 		 * when acking.
 		 */
-		i8259A_irq_type.ack = disable_8259A_irq;
+		i8259A_chip.mask_ack = disable_8259A_irq;
 	else
-		i8259A_irq_type.ack = mask_and_ack_8259A;
+		i8259A_chip.mask_ack = mask_and_ack_8259A;
 
 	udelay(100);		/* wait for 8259A to initialize */
 
-	outb(cached_21, 0x21);	/* restore master IRQ mask */
-	outb(cached_A1, 0xA1);	/* restore slave IRQ mask */
+	outb(cached_master_mask, PIC_MASTER_IMR); /* restore master IRQ mask */
+	outb(cached_slave_mask, PIC_SLAVE_IMR);	  /* restore slave IRQ mask */
 
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 }
@@ -291,11 +295,17 @@ static struct irqaction irq2 = {
 };
 
 static struct resource pic1_io_resource = {
-	.name = "pic1", .start = 0x20, .end = 0x21, .flags = IORESOURCE_BUSY
+	.name = "pic1",
+	.start = PIC_MASTER_CMD,
+	.end = PIC_MASTER_IMR,
+	.flags = IORESOURCE_BUSY
 };
 
 static struct resource pic2_io_resource = {
-	.name = "pic2", .start = 0xa0, .end = 0xa1, .flags = IORESOURCE_BUSY
+	.name = "pic2",
+	.start = PIC_SLAVE_CMD,
+	.end = PIC_SLAVE_IMR,
+	.flags = IORESOURCE_BUSY
 };
 
 /*
@@ -313,7 +323,7 @@ void __init init_i8259_irqs (void)
 	init_8259A(0);
 
 	for (i = 0; i < 16; i++)
-		set_irq_chip(i, &i8259A_irq_type);
+		set_irq_chip_and_handler(i, &i8259A_chip, handle_level_irq);
 
-	setup_irq(2, &irq2);
+	setup_irq(PIC_CASCADE_IR, &irq2);
 }
diff --git a/include/asm-mips/i8259.h b/include/asm-mips/i8259.h
index 0214abe..4df8d8b 100644
--- a/include/asm-mips/i8259.h
+++ b/include/asm-mips/i8259.h
@@ -19,10 +19,31 @@ #include <linux/spinlock.h>
 
 #include <asm/io.h>
 
+/* i8259A PIC registers */
+#define PIC_MASTER_CMD		0x20
+#define PIC_MASTER_IMR		0x21
+#define PIC_MASTER_ISR		PIC_MASTER_CMD
+#define PIC_MASTER_POLL		PIC_MASTER_ISR
+#define PIC_MASTER_OCW3		PIC_MASTER_ISR
+#define PIC_SLAVE_CMD		0xa0
+#define PIC_SLAVE_IMR		0xa1
+
+/* i8259A PIC related value */
+#define PIC_CASCADE_IR		2
+#define MASTER_ICW4_DEFAULT	0x01
+#define SLAVE_ICW4_DEFAULT	0x01
+#define PIC_ICW4_AEOI		2
+
 extern spinlock_t i8259A_lock;
 
+extern void init_8259A(int auto_eoi);
+extern void enable_8259A_irq(unsigned int irq);
+extern void disable_8259A_irq(unsigned int irq);
+
 extern void init_i8259_irqs(void);
 
+#define I8259A_IRQ_BASE	0
+
 /*
  * Do the traditional i8259 interrupt polling thing.  This is for the few
  * cases where no better interrupt acknowledge method is available and we
@@ -35,15 +56,15 @@ static inline int i8259_irq(void)
 	spin_lock(&i8259A_lock);
 
 	/* Perform an interrupt acknowledge cycle on controller 1. */
-	outb(0x0C, 0x20);		/* prepare for poll */
-	irq = inb(0x20) & 7;
-	if (irq == 2) {
+	outb(0x0C, PIC_MASTER_CMD);		/* prepare for poll */
+	irq = inb(PIC_MASTER_CMD) & 7;
+	if (irq == PIC_CASCADE_IR) {
 		/*
 		 * Interrupt is cascaded so perform interrupt
 		 * acknowledge on controller 2.
 		 */
-		outb(0x0C, 0xA0);		/* prepare for poll */
-		irq = (inb(0xA0) & 7) + 8;
+		outb(0x0C, PIC_SLAVE_CMD);		/* prepare for poll */
+		irq = (inb(PIC_SLAVE_CMD) & 7) + 8;
 	}
 
 	if (unlikely(irq == 7)) {
@@ -54,14 +75,14 @@ static inline int i8259_irq(void)
 		 * significant bit is not set then there is no valid
 		 * interrupt.
 		 */
-		outb(0x0B, 0x20);		/* ISR register */
-		if(~inb(0x20) & 0x80)
+		outb(0x0B, PIC_MASTER_ISR);		/* ISR register */
+		if(~inb(PIC_MASTER_ISR) & 0x80)
 			irq = -1;
 	}
 
 	spin_unlock(&i8259A_lock);
 
-	return irq;
+	return likely(irq >= 0) ? irq + I8259A_IRQ_BASE : irq;
 }
 
 #endif /* _ASM_I8259_H */
