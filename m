Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jan 2007 14:41:55 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:21975 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20050755AbXANOlt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Jan 2007 14:41:49 +0000
Received: from localhost (p1114-ipad202funabasi.chiba.ocn.ne.jp [222.146.72.114])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8644DA8FC; Sun, 14 Jan 2007 23:41:42 +0900 (JST)
Date:	Sun, 14 Jan 2007 23:41:42 +0900 (JST)
Message-Id: <20070114.234142.41198466.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Make I8259A_IRQ_BASE customizable
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
X-archive-position: 13597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Move I8259A_IRQ_BASE from asm/i8259.h to asm/mach-generic/irq.h and
make it really customizable.  And remove I8259_IRQ_BASE declared on
some platforms.  Currently only NEC_CMBVR4133 is using custom
I8259A_IRQ_BASE value.

Testing this patch on those platforms is greatly appreciated.  Thank
you.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch depends on "Define MIPS_CPU_IRQ_BASE in generic header"
patch which is in linux-queue tree.

 arch/mips/ddb5xxx/ddb5477/irq.c      |    5 +-
 arch/mips/kernel/i8259.c             |   20 +++++++---
 arch/mips/pci/fixup-vr4133.c         |   13 +-----
 arch/mips/vr41xx/nec-cmbvr4133/irq.c |   53 +--------------------------
 include/asm-mips/ddb5xxx/ddb5477.h   |   36 ++++++++----------
 include/asm-mips/i8259.h             |    3 -
 include/asm-mips/irq.h               |    2 -
 include/asm-mips/mach-generic/irq.h  |    6 +++
 include/asm-mips/mach-vr41xx/irq.h   |    3 +
 include/asm-mips/vr41xx/cmbvr4133.h  |    5 +-
 10 files changed, 49 insertions(+), 97 deletions(-)

diff --git a/arch/mips/ddb5xxx/ddb5477/irq.c b/arch/mips/ddb5xxx/ddb5477/irq.c
index bd7cd7c..2b23234 100644
--- a/arch/mips/ddb5xxx/ddb5477/irq.c
+++ b/arch/mips/ddb5xxx/ddb5477/irq.c
@@ -146,8 +146,7 @@ u8 i8259_interrupt_ack(void)
 	irq = *(volatile u8 *) KSEG1ADDR(DDB_PCI_IACK_BASE);
 	ddb_out32(DDB_PCIINIT10, reg);
 
-	/* i8259.c set the base vector to be 0x0 */
-	return irq + I8259_IRQ_BASE;
+	return irq;
 }
 /*
  * the first level int-handler will jump here if it is a vrc5477 irq
@@ -177,7 +176,7 @@ static void vrc5477_irq_dispatch(void)
 		/* check for i8259 interrupts */
 		if (intStatus & (1 << VRC5477_I8259_CASCADE)) {
 			int i8259_irq = i8259_interrupt_ack();
-			do_IRQ(I8259_IRQ_BASE + i8259_irq);
+			do_IRQ(i8259_irq);
 			return;
 		}
 	}
diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index b59a676..91de422 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -54,9 +54,11 @@ static unsigned int cached_irq_mask = 0x
 
 void disable_8259A_irq(unsigned int irq)
 {
-	unsigned int mask = 1 << irq;
+	unsigned int mask;
 	unsigned long flags;
 
+	irq -= I8259A_IRQ_BASE;
+	mask = 1 << irq;
 	spin_lock_irqsave(&i8259A_lock, flags);
 	cached_irq_mask |= mask;
 	if (irq & 8)
@@ -68,9 +70,11 @@ void disable_8259A_irq(unsigned int irq)
 
 void enable_8259A_irq(unsigned int irq)
 {
-	unsigned int mask = ~(1 << irq);
+	unsigned int mask;
 	unsigned long flags;
 
+	irq -= I8259A_IRQ_BASE;
+	mask = ~(1 << irq);
 	spin_lock_irqsave(&i8259A_lock, flags);
 	cached_irq_mask &= mask;
 	if (irq & 8)
@@ -82,10 +86,12 @@ void enable_8259A_irq(unsigned int irq)
 
 int i8259A_irq_pending(unsigned int irq)
 {
-	unsigned int mask = 1 << irq;
+	unsigned int mask;
 	unsigned long flags;
 	int ret;
 
+	irq -= I8259A_IRQ_BASE;
+	mask = 1 << irq;
 	spin_lock_irqsave(&i8259A_lock, flags);
 	if (irq < 8)
 		ret = inb(PIC_MASTER_CMD) & mask;
@@ -134,9 +140,11 @@ static inline int i8259A_irq_real(unsign
  */
 void mask_and_ack_8259A(unsigned int irq)
 {
-	unsigned int irqmask = 1 << irq;
+	unsigned int irqmask;
 	unsigned long flags;
 
+	irq -= I8259A_IRQ_BASE;
+	irqmask = 1 << irq;
 	spin_lock_irqsave(&i8259A_lock, flags);
 	/*
 	 * Lightweight spurious IRQ detection. We do not want
@@ -322,8 +330,8 @@ void __init init_i8259_irqs (void)
 
 	init_8259A(0);
 
-	for (i = 0; i < 16; i++)
+	for (i = I8259A_IRQ_BASE; i < I8259A_IRQ_BASE + 16; i++)
 		set_irq_chip_and_handler(i, &i8259A_chip, handle_level_irq);
 
-	setup_irq(PIC_CASCADE_IR, &irq2);
+	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
 }
diff --git a/arch/mips/pci/fixup-vr4133.c b/arch/mips/pci/fixup-vr4133.c
index 597b897..b1a5b31 100644
--- a/arch/mips/pci/fixup-vr4133.c
+++ b/arch/mips/pci/fixup-vr4133.c
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 
 #include <asm/io.h>
+#include <asm/i8259.h>
 #include <asm/vr41xx/cmbvr4133.h>
 
 extern int vr4133_rockhopper;
@@ -160,17 +161,7 @@ int rockhopper_get_irq(struct pci_dev *d
 #ifdef CONFIG_ROCKHOPPER
 void i8259_init(void)
 {
-	outb(0x11, 0x20);		/* Master ICW1 */
-	outb(I8259_IRQ_BASE, 0x21);	/* Master ICW2 */
-	outb(0x04, 0x21);		/* Master ICW3 */
-	outb(0x01, 0x21);		/* Master ICW4 */
-	outb(0xff, 0x21);		/* Master IMW */
-
-	outb(0x11, 0xa0);		/* Slave ICW1 */
-	outb(I8259_IRQ_BASE + 8, 0xa1);	/* Slave ICW2 */
-	outb(0x02, 0xa1);		/* Slave ICW3 */
-	outb(0x01, 0xa1);		/* Slave ICW4 */
-	outb(0xff, 0xa1);		/* Slave IMW */
+	init_i8259_irqs();
 
 	outb(0x00, 0x4d0);
 	outb(0x02, 0x4d1);	/* USB IRQ9 is level */
diff --git a/arch/mips/vr41xx/nec-cmbvr4133/irq.c b/arch/mips/vr41xx/nec-cmbvr4133/irq.c
index 128ed8d..7d2d076 100644
--- a/arch/mips/vr41xx/nec-cmbvr4133/irq.c
+++ b/arch/mips/vr41xx/nec-cmbvr4133/irq.c
@@ -21,60 +21,16 @@
 #include <linux/interrupt.h>
 
 #include <asm/io.h>
+#include <asm/i8259.h>
 #include <asm/vr41xx/cmbvr4133.h>
 
-extern void enable_8259A_irq(unsigned int irq);
-extern void disable_8259A_irq(unsigned int irq);
-extern void mask_and_ack_8259A(unsigned int irq);
-extern void init_8259A(int hoge);
-
 extern int vr4133_rockhopper;
 
-static void enable_i8259_irq(unsigned int irq)
-{
-	enable_8259A_irq(irq - I8259_IRQ_BASE);
-}
-
-static void disable_i8259_irq(unsigned int irq)
-{
-	disable_8259A_irq(irq - I8259_IRQ_BASE);
-}
-
-static void ack_i8259_irq(unsigned int irq)
-{
-	mask_and_ack_8259A(irq - I8259_IRQ_BASE);
-}
-
-static struct irq_chip i8259_irq_type = {
-	.typename       = "XT-PIC",
-	.ack            = ack_i8259_irq,
-	.mask		= disable_i8259_irq,
-	.mask_ack	= ack_i8259_irq,
-	.unmask		= enable_i8259_irq,
-};
-
 static int i8259_get_irq_number(int irq)
 {
-	unsigned long isr;
-
-	isr = inb(0x20);
-	irq = ffz(~isr);
-	if (irq == 2) {
-		isr = inb(0xa0);
-		irq = 8 + ffz(~isr);
-	}
-
-	if (irq < 0 || irq > 15)
-		return -EINVAL;
-
-	return I8259_IRQ_BASE + irq;
+	return i8259_irq();
 }
 
-static struct irqaction i8259_slave_cascade = {
-	.handler        = &no_action,
-	.name           = "cascade",
-};
-
 void __init rockhopper_init_irq(void)
 {
 	int i;
@@ -84,11 +40,6 @@ void __init rockhopper_init_irq(void)
 		return;
 	}
 
-	for (i = I8259_IRQ_BASE; i <= I8259_IRQ_LAST; i++)
-		set_irq_chip_and_handler(i, &i8259_irq_type, handle_level_irq);
-
-	setup_irq(I8259_SLAVE_IRQ, &i8259_slave_cascade);
-
 	vr41xx_set_irq_trigger(CMBVR41XX_INTC_PIN, TRIGGER_LEVEL, SIGNAL_THROUGH);
 	vr41xx_set_irq_level(CMBVR41XX_INTC_PIN, LEVEL_HIGH);
 	vr41xx_cascade_irq(CMBVR41XX_INTC_IRQ, i8259_get_irq_number);
diff --git a/include/asm-mips/ddb5xxx/ddb5477.h b/include/asm-mips/ddb5xxx/ddb5477.h
index 27655db..6cf177c 100644
--- a/include/asm-mips/ddb5xxx/ddb5477.h
+++ b/include/asm-mips/ddb5xxx/ddb5477.h
@@ -252,12 +252,8 @@ extern void ll_vrc5477_irq_disable(int v
  */
 
 #define	NUM_CPU_IRQ		8
-#define	NUM_I8259_IRQ		16
 #define	NUM_VRC5477_IRQ		32
 
-#define	DDB_IRQ_BASE		0
-
-#define	I8259_IRQ_BASE		DDB_IRQ_BASE
 #define	CPU_IRQ_BASE		MIPS_CPU_IRQ_BASE
 #define	VRC5477_IRQ_BASE	(CPU_IRQ_BASE + NUM_CPU_IRQ)
 
@@ -301,22 +297,22 @@ extern void ll_vrc5477_irq_disable(int v
 /*
  * i2859 irq assignment
  */
-#define I8259_IRQ_RESERVED_0	(0 + I8259_IRQ_BASE)
-#define I8259_IRQ_KEYBOARD	(1 + I8259_IRQ_BASE)	/* M1543 default */
-#define I8259_IRQ_CASCADE	(2 + I8259_IRQ_BASE)
-#define I8259_IRQ_UART_B	(3 + I8259_IRQ_BASE)	/* M1543 default, may conflict with RTC according to schematic diagram  */
-#define I8259_IRQ_UART_A	(4 + I8259_IRQ_BASE)	/* M1543 default */
-#define I8259_IRQ_PARALLEL	(5 + I8259_IRQ_BASE)	/* M1543 default */
-#define I8259_IRQ_RESERVED_6	(6 + I8259_IRQ_BASE)
-#define I8259_IRQ_RESERVED_7	(7 + I8259_IRQ_BASE)
-#define I8259_IRQ_RTC		(8 + I8259_IRQ_BASE)	/* who set this? */
-#define I8259_IRQ_USB		(9 + I8259_IRQ_BASE)	/* ddb_setup */
-#define I8259_IRQ_PMU		(10 + I8259_IRQ_BASE)	/* ddb_setup */
-#define I8259_IRQ_RESERVED_11	(11 + I8259_IRQ_BASE)
-#define I8259_IRQ_RESERVED_12	(12 + I8259_IRQ_BASE)	/* m1543_irq_setup */
-#define I8259_IRQ_RESERVED_13	(13 + I8259_IRQ_BASE)
-#define I8259_IRQ_HDC1		(14 + I8259_IRQ_BASE)	/* default and ddb_setup */
-#define I8259_IRQ_HDC2		(15 + I8259_IRQ_BASE)	/* default */
+#define I8259_IRQ_RESERVED_0	(0 + I8259A_IRQ_BASE)
+#define I8259_IRQ_KEYBOARD	(1 + I8259A_IRQ_BASE)	/* M1543 default */
+#define I8259_IRQ_CASCADE	(2 + I8259A_IRQ_BASE)
+#define I8259_IRQ_UART_B	(3 + I8259A_IRQ_BASE)	/* M1543 default, may conflict with RTC according to schematic diagram  */
+#define I8259_IRQ_UART_A	(4 + I8259A_IRQ_BASE)	/* M1543 default */
+#define I8259_IRQ_PARALLEL	(5 + I8259A_IRQ_BASE)	/* M1543 default */
+#define I8259_IRQ_RESERVED_6	(6 + I8259A_IRQ_BASE)
+#define I8259_IRQ_RESERVED_7	(7 + I8259A_IRQ_BASE)
+#define I8259_IRQ_RTC		(8 + I8259A_IRQ_BASE)	/* who set this? */
+#define I8259_IRQ_USB		(9 + I8259A_IRQ_BASE)	/* ddb_setup */
+#define I8259_IRQ_PMU		(10 + I8259A_IRQ_BASE)	/* ddb_setup */
+#define I8259_IRQ_RESERVED_11	(11 + I8259A_IRQ_BASE)
+#define I8259_IRQ_RESERVED_12	(12 + I8259A_IRQ_BASE)	/* m1543_irq_setup */
+#define I8259_IRQ_RESERVED_13	(13 + I8259A_IRQ_BASE)
+#define I8259_IRQ_HDC1		(14 + I8259A_IRQ_BASE)	/* default and ddb_setup */
+#define I8259_IRQ_HDC2		(15 + I8259A_IRQ_BASE)	/* default */
 
 
 /*
diff --git a/include/asm-mips/i8259.h b/include/asm-mips/i8259.h
index 4df8d8b..e88a016 100644
--- a/include/asm-mips/i8259.h
+++ b/include/asm-mips/i8259.h
@@ -18,6 +18,7 @@
 #include <linux/spinlock.h>
 
 #include <asm/io.h>
+#include <irq.h>
 
 /* i8259A PIC registers */
 #define PIC_MASTER_CMD		0x20
@@ -42,8 +43,6 @@ extern void disable_8259A_irq(unsigned i
 
 extern void init_i8259_irqs(void);
 
-#define I8259A_IRQ_BASE	0
-
 /*
  * Do the traditional i8259 interrupt polling thing.  This is for the few
  * cases where no better interrupt acknowledge method is available and we
diff --git a/include/asm-mips/irq.h b/include/asm-mips/irq.h
index 386da82..91803ba 100644
--- a/include/asm-mips/irq.h
+++ b/include/asm-mips/irq.h
@@ -18,7 +18,7 @@
 #ifdef CONFIG_I8259
 static inline int irq_canonicalize(int irq)
 {
-	return ((irq == 2) ? 9 : irq);
+	return ((irq == I8259A_IRQ_BASE + 2) ? I8259A_IRQ_BASE + 9 : irq);
 }
 #else
 #define irq_canonicalize(irq) (irq)	/* Sane hardware, sane code ... */
diff --git a/include/asm-mips/mach-generic/irq.h b/include/asm-mips/mach-generic/irq.h
index 91e6778..70d9a25 100644
--- a/include/asm-mips/mach-generic/irq.h
+++ b/include/asm-mips/mach-generic/irq.h
@@ -12,6 +12,12 @@
 #define NR_IRQS	128
 #endif
 
+#ifdef CONFIG_I8259
+#ifndef I8259A_IRQ_BASE
+#define I8259A_IRQ_BASE	0
+#endif
+#endif
+
 #ifdef CONFIG_IRQ_CPU
 
 #ifndef MIPS_CPU_IRQ_BASE
diff --git a/include/asm-mips/mach-vr41xx/irq.h b/include/asm-mips/mach-vr41xx/irq.h
index 862058d..8488122 100644
--- a/include/asm-mips/mach-vr41xx/irq.h
+++ b/include/asm-mips/mach-vr41xx/irq.h
@@ -2,6 +2,9 @@
 #define __ASM_MACH_VR41XX_IRQ_H
 
 #include <asm/vr41xx/irq.h> /* for MIPS_CPU_IRQ_BASE */
+#ifdef CONFIG_NEC_CMBVR4133
+#include <asm/vr41xx/cmbvr4133.h> /* for I8259A_IRQ_BASE */
+#endif
 
 #include_next <irq.h>
 
diff --git a/include/asm-mips/vr41xx/cmbvr4133.h b/include/asm-mips/vr41xx/cmbvr4133.h
index 9490ade..4230003 100644
--- a/include/asm-mips/vr41xx/cmbvr4133.h
+++ b/include/asm-mips/vr41xx/cmbvr4133.h
@@ -35,8 +35,8 @@
 #define CMBVR41XX_INTD_IRQ		GIU_IRQ(CMBVR41XX_INTD_PIN)
 #define CMBVR41XX_INTE_IRQ		GIU_IRQ(CMBVR41XX_INTE_PIN)
 
-#define I8259_IRQ_BASE			72
-#define I8259_IRQ(x)			(I8259_IRQ_BASE + (x))
+#define I8259A_IRQ_BASE			72
+#define I8259_IRQ(x)			(I8259A_IRQ_BASE + (x))
 #define TIMER_IRQ			I8259_IRQ(0)
 #define KEYBOARD_IRQ			I8259_IRQ(1)
 #define I8259_SLAVE_IRQ			I8259_IRQ(2)
@@ -52,6 +52,5 @@
 #define AUX_IRQ				I8259_IRQ(12)
 #define IDE_PRIMARY_IRQ			I8259_IRQ(14)
 #define IDE_SECONDARY_IRQ		I8259_IRQ(15)
-#define I8259_IRQ_LAST			IDE_SECONDARY_IRQ
 
 #endif /* __NEC_CMBVR4133_H */
