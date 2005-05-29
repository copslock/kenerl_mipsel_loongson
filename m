Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 May 2005 16:06:24 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:33535 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224812AbVE2PGE>;
	Sun, 29 May 2005 16:06:04 +0100
Received: MO(mo00)id j4TF5wTi005845; Mon, 30 May 2005 00:05:58 +0900 (JST)
Received: MDO(mdo01) id j4TF5vk1011099; Mon, 30 May 2005 00:05:57 +0900 (JST)
Received: from stratos (h042.p502.iij4u.or.jp [210.149.246.42])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id j4TF5uaW007910
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Mon, 30 May 2005 00:05:57 +0900 (JST)
Date:	Mon, 30 May 2005 00:05:46 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: update IRQ handling
Message-Id: <20050530000546.5b7da65d.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch had updated IRQ handling for vr41xx.
o added common IRQ dispatch
o changed IRQ number in int-handler.S
o added resource management to icu.c

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/Makefile a/arch/mips/vr41xx/common/Makefile
--- a-orig/arch/mips/vr41xx/common/Makefile	Fri May 20 07:27:41 2005
+++ a/arch/mips/vr41xx/common/Makefile	Sat May 28 18:30:33 2005
@@ -2,7 +2,7 @@
 # Makefile for common code of the NEC VR4100 series.
 #
 
-obj-y				+= bcu.o cmu.o icu.o init.o int-handler.o pmu.o
+obj-y				+= bcu.o cmu.o icu.o init.o int-handler.o irq.o pmu.o
 obj-$(CONFIG_GPIO_VR41XX)	+= giu.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/giu.c a/arch/mips/vr41xx/common/giu.c
--- a-orig/arch/mips/vr41xx/common/giu.c	Fri Apr 15 00:14:15 2005
+++ a/arch/mips/vr41xx/common/giu.c	Sat May 28 19:03:27 2005
@@ -291,60 +291,7 @@
 
 EXPORT_SYMBOL(vr41xx_set_irq_level);
 
-#ifndef MODULE
-
-#define GIUINT_NR_IRQS		32
-
-enum {
-	GIUINT_NO_CASCADE,
-	GIUINT_CASCADE
-};
-
-struct vr41xx_giuint_cascade {
-	unsigned int flag;
-	int (*get_irq_number)(int irq);
-};
-
-static struct vr41xx_giuint_cascade giuint_cascade[GIUINT_NR_IRQS];
-
-static struct irqaction giu_cascade = {
-	.handler	= no_action,
-	.mask		= CPU_MASK_NONE,
-	.name		= "cascade",
-};
-
-static int no_irq_number(int irq)
-{
-	return -EINVAL;
-}
-
-int vr41xx_cascade_irq(unsigned int irq, int (*get_irq_number)(int irq))
-{
-	unsigned int pin;
-	int retval;
-
-	if (irq < GIU_IRQ(0) || irq > GIU_IRQ(31))
-		return -EINVAL;
-
-	if(!get_irq_number)
-		return -EINVAL;
-
-	pin = GIU_IRQ_TO_PIN(irq);
-	giuint_cascade[pin].flag = GIUINT_CASCADE;
-	giuint_cascade[pin].get_irq_number = get_irq_number;
-
-	retval = setup_irq(irq, &giu_cascade);
-	if (retval != 0) {
-		giuint_cascade[pin].flag = GIUINT_NO_CASCADE;
-		giuint_cascade[pin].get_irq_number = no_irq_number;
-	}
-
-	return retval;
-}
-
-EXPORT_SYMBOL(vr41xx_cascade_irq);
-
-static inline int get_irq_pin_number(void)
+static int giu_get_irq(unsigned int irq, struct pt_regs *regs)
 {
 	uint16_t pendl, pendh, maskl, maskh;
 	int i;
@@ -360,12 +307,12 @@
 	if (maskl) {
 		for (i = 0; i < 16; i++) {
 			if (maskl & ((uint16_t)1 << i))
-				return i;
+				return GIU_IRQ(i);
 		}
 	} else if (maskh) {
 		for (i = 0; i < 16; i++) {
 			if (maskh & ((uint16_t)1 << i))
-				return i + GIUINT_HIGH_OFFSET;
+				return GIU_IRQ(i + GIUINT_HIGH_OFFSET);
 		}
 	}
 
@@ -377,54 +324,7 @@
 	return -1;
 }
 
-static inline void ack_giuint_irq(int pin)
-{
-	if (pin < GIUINT_HIGH_OFFSET) {
-		clear_giuint(GIUINTENL, (uint16_t)1 << pin);
-		write_giuint((uint16_t)1 << pin, GIUINTSTATL);
-	} else {
-		pin -= GIUINT_HIGH_OFFSET;
-		clear_giuint(GIUINTENH, (uint16_t)1 << pin);
-		write_giuint((uint16_t)1 << pin, GIUINTSTATH);
-	}
-}
-
-static inline void end_giuint_irq(int pin)
-{
-	if (pin < GIUINT_HIGH_OFFSET)
-		set_giuint(GIUINTENL, (uint16_t)1 << pin);
-	else
-		set_giuint(GIUINTENH, (uint16_t)1 << (pin - GIUINT_HIGH_OFFSET));
-}
-
-void giuint_irq_dispatch(struct pt_regs *regs)
-{
-	struct vr41xx_giuint_cascade *cascade;
-	unsigned int giuint_irq;
-	int pin;
-
-	pin = get_irq_pin_number();
-	if (pin < 0)
-		return;
-
-	disable_irq(GIUINT_CASCADE_IRQ);
-
-	cascade = &giuint_cascade[pin];
-	giuint_irq = GIU_IRQ(pin);
-	if (cascade->flag == GIUINT_CASCADE) {
-		int irq = cascade->get_irq_number(giuint_irq);
-		ack_giuint_irq(pin);
-		if (irq >= 0)
-			do_IRQ(irq, regs);
-		end_giuint_irq(pin);
-	} else {
-		do_IRQ(giuint_irq, regs);
-	}
-
-	enable_irq(GIUINT_CASCADE_IRQ);
-}
-
-void __init init_vr41xx_giuint_irq(void)
+static int  __init vr41xx_giu_init(void)
 {
 	int i;
 
@@ -440,16 +340,14 @@
 		break;
 	default:
 		printk(KERN_ERR "GIU: Unexpected CPU of NEC VR4100 series\n");
-		return;
+		return -ENODEV;
 	}
 
-	for (i = 0; i < GIUINT_NR_IRQS; i++) {
+	for (i = 0; i < 32; i++) {
 		if (i < GIUINT_HIGH_OFFSET)
 			clear_giuint(GIUINTENL, (uint16_t)1 << i);
 		else
 			clear_giuint(GIUINTENH, (uint16_t)1 << (i - GIUINT_HIGH_OFFSET));
-		giuint_cascade[i].flag = GIUINT_NO_CASCADE;
-		giuint_cascade[i].get_irq_number = no_irq_number;
 	}
 
 	for (i = GIU_IRQ_BASE; i <= GIU_IRQ_LAST; i++) {
@@ -459,7 +357,7 @@
 			irq_desc[i].handler = &giuint_high_irq_type;
 	}
 
-	setup_irq(GIUINT_CASCADE_IRQ, &giu_cascade);
+	return cascade_irq(GIUINT_IRQ, giu_get_irq);
 }
 
-#endif
+postcore_initcall(vr41xx_giu_init);
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/icu.c a/arch/mips/vr41xx/common/icu.c
--- a-orig/arch/mips/vr41xx/common/icu.c	Tue Mar  8 08:10:16 2005
+++ a/arch/mips/vr41xx/common/icu.c	Sat May 28 18:29:11 2005
@@ -28,10 +28,10 @@
  *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *  - Coped with INTASSIGN of NEC VR4133.
  */
-#include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/smp.h>
@@ -43,32 +43,22 @@
 #include <asm/irq_cpu.h>
 #include <asm/vr41xx/vr41xx.h>
 
-extern asmlinkage void vr41xx_handle_interrupt(void);
-
-#ifdef CONFIG_GPIO_VR41XX
-extern void init_vr41xx_giuint_irq(void);
-extern void giuint_irq_dispatch(struct pt_regs *regs);
-#endif
-
-static uint32_t icu1_base;
-static uint32_t icu2_base;
-
-static struct irqaction icu_cascade = {
-	.handler	= no_action,
-	.mask		= CPU_MASK_NONE,
-	.name		= "cascade",
-};
+static void __iomem *icu1_base;
+static void __iomem *icu2_base;
 
 static unsigned char sysint1_assign[16] = {
 	0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 static unsigned char sysint2_assign[16] = {
-	2, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+	2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+
+#define ICU1_TYPE1_BASE	0x0b000080UL
+#define ICU2_TYPE1_BASE	0x0b000200UL
 
-#define SYSINT1REG_TYPE1	KSEG1ADDR(0x0b000080)
-#define SYSINT2REG_TYPE1	KSEG1ADDR(0x0b000200)
+#define ICU1_TYPE2_BASE	0x0f000080UL
+#define ICU2_TYPE2_BASE	0x0f0000a0UL
 
-#define SYSINT1REG_TYPE2	KSEG1ADDR(0x0f000080)
-#define SYSINT2REG_TYPE2	KSEG1ADDR(0x0f0000a0)
+#define ICU1_SIZE	0x20
+#define ICU2_SIZE	0x1c
 
 #define SYSINT1REG	0x00
 #define PIUINTREG	0x02
@@ -108,61 +98,61 @@
 #define SYSINT1_IRQ_TO_PIN(x)	((x) - SYSINT1_IRQ_BASE)	/* Pin 0-15 */
 #define SYSINT2_IRQ_TO_PIN(x)	((x) - SYSINT2_IRQ_BASE)	/* Pin 0-15 */
 
-#define read_icu1(offset)	readw(icu1_base + (offset))
-#define write_icu1(val, offset)	writew((val), icu1_base + (offset))
+#define INT_TO_IRQ(x)		((x) + 2)	/* Int0-4 -> IRQ2-6 */
 
-#define read_icu2(offset)	readw(icu2_base + (offset))
-#define write_icu2(val, offset)	writew((val), icu2_base + (offset))
+#define icu1_read(offset)		readw(icu1_base + (offset))
+#define icu1_write(offset, value)	writew((value), icu1_base + (offset))
+
+#define icu2_read(offset)		readw(icu2_base + (offset))
+#define icu2_write(offset, value)	writew((value), icu2_base + (offset))
 
 #define INTASSIGN_MAX	4
 #define INTASSIGN_MASK	0x0007
 
-static inline uint16_t set_icu1(uint8_t offset, uint16_t set)
+static inline uint16_t icu1_set(uint8_t offset, uint16_t set)
 {
-	uint16_t res;
+	uint16_t data;
 
-	res = read_icu1(offset);
-	res |= set;
-	write_icu1(res, offset);
+	data = icu1_read(offset);
+	data |= set;
+	icu1_write(offset, data);
 
-	return res;
+	return data;
 }
 
-static inline uint16_t clear_icu1(uint8_t offset, uint16_t clear)
+static inline uint16_t icu1_clear(uint8_t offset, uint16_t clear)
 {
-	uint16_t res;
+	uint16_t data;
 
-	res = read_icu1(offset);
-	res &= ~clear;
-	write_icu1(res, offset);
+	data = icu1_read(offset);
+	data &= ~clear;
+	icu1_write(offset, data);
 
-	return res;
+	return data;
 }
 
-static inline uint16_t set_icu2(uint8_t offset, uint16_t set)
+static inline uint16_t icu2_set(uint8_t offset, uint16_t set)
 {
-	uint16_t res;
+	uint16_t data;
 
-	res = read_icu2(offset);
-	res |= set;
-	write_icu2(res, offset);
+	data = icu2_read(offset);
+	data |= set;
+	icu2_write(offset, data);
 
-	return res;
+	return data;
 }
 
-static inline uint16_t clear_icu2(uint8_t offset, uint16_t clear)
+static inline uint16_t icu2_clear(uint8_t offset, uint16_t clear)
 {
-	uint16_t res;
+	uint16_t data;
 
-	res = read_icu2(offset);
-	res &= ~clear;
-	write_icu2(res, offset);
+	data = icu2_read(offset);
+	data &= ~clear;
+	icu2_write(offset, data);
 
-	return res;
+	return data;
 }
 
-/*=======================================================================*/
-
 void vr41xx_enable_piuint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + PIU_IRQ;
@@ -171,7 +161,7 @@
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121) {
 		spin_lock_irqsave(&desc->lock, flags);
-		set_icu1(MPIUINTREG, mask);
+		icu1_set(MPIUINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -186,7 +176,7 @@
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121) {
 		spin_lock_irqsave(&desc->lock, flags);
-		clear_icu1(MPIUINTREG, mask);
+		icu1_clear(MPIUINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -201,7 +191,7 @@
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121) {
 		spin_lock_irqsave(&desc->lock, flags);
-		set_icu1(MAIUINTREG, mask);
+		icu1_set(MAIUINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -216,7 +206,7 @@
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121) {
 		spin_lock_irqsave(&desc->lock, flags);
-		clear_icu1(MAIUINTREG, mask);
+		icu1_clear(MAIUINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -231,7 +221,7 @@
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121) {
 		spin_lock_irqsave(&desc->lock, flags);
-		set_icu1(MKIUINTREG, mask);
+		icu1_set(MKIUINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -246,7 +236,7 @@
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121) {
 		spin_lock_irqsave(&desc->lock, flags);
-		clear_icu1(MKIUINTREG, mask);
+		icu1_clear(MKIUINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -259,7 +249,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	set_icu1(MDSIUINTREG, mask);
+	icu1_set(MDSIUINTREG, mask);
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
@@ -271,7 +261,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	clear_icu1(MDSIUINTREG, mask);
+	icu1_clear(MDSIUINTREG, mask);
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
@@ -283,7 +273,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	set_icu2(MFIRINTREG, mask);
+	icu2_set(MFIRINTREG, mask);
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
@@ -295,7 +285,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	clear_icu2(MFIRINTREG, mask);
+	icu2_clear(MFIRINTREG, mask);
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
@@ -310,7 +300,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		write_icu2(PCIINT0, MPCIINTREG);
+		icu2_write(MPCIINTREG, PCIINT0);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -326,7 +316,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		write_icu2(0, MPCIINTREG);
+		icu2_write(MPCIINTREG, 0);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -342,7 +332,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		write_icu2(SCUINT0, MSCUINTREG);
+		icu2_write(MSCUINTREG, SCUINT0);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -358,7 +348,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		write_icu2(0, MSCUINTREG);
+		icu2_write(MSCUINTREG, 0);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -374,7 +364,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		set_icu2(MCSIINTREG, mask);
+		icu2_set(MCSIINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -390,7 +380,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		clear_icu2(MCSIINTREG, mask);
+		icu2_clear(MCSIINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -406,7 +396,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		write_icu2(BCUINTR, MBCUINTREG);
+		icu2_write(MBCUINTREG, BCUINTR);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -422,30 +412,28 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		write_icu2(0, MBCUINTREG);
+		icu2_write(MBCUINTREG, 0);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
 
 EXPORT_SYMBOL(vr41xx_disable_bcuint);
 
-/*=======================================================================*/
-
 static unsigned int startup_sysint1_irq(unsigned int irq)
 {
-	set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+	icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
 
 	return 0; /* never anything pending */
 }
 
 static void shutdown_sysint1_irq(unsigned int irq)
 {
-	clear_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+	icu1_clear(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
 static void enable_sysint1_irq(unsigned int irq)
 {
-	set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+	icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
 #define disable_sysint1_irq	shutdown_sysint1_irq
@@ -454,7 +442,7 @@
 static void end_sysint1_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+		icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
 static struct hw_interrupt_type sysint1_irq_type = {
@@ -467,23 +455,21 @@
 	.end		= end_sysint1_irq,
 };
 
-/*=======================================================================*/
-
 static unsigned int startup_sysint2_irq(unsigned int irq)
 {
-	set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+	icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
 
 	return 0; /* never anything pending */
 }
 
 static void shutdown_sysint2_irq(unsigned int irq)
 {
-	clear_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+	icu2_clear(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
 static void enable_sysint2_irq(unsigned int irq)
 {
-	set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+	icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
 #define disable_sysint2_irq	shutdown_sysint2_irq
@@ -492,7 +478,7 @@
 static void end_sysint2_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+		icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
 static struct hw_interrupt_type sysint2_irq_type = {
@@ -505,8 +491,6 @@
 	.end		= end_sysint2_irq,
 };
 
-/*=======================================================================*/
-
 static inline int set_sysint1_assign(unsigned int irq, unsigned char assign)
 {
 	irq_desc_t *desc = irq_desc + irq;
@@ -517,8 +501,8 @@
 
 	spin_lock_irq(&desc->lock);
 
-	intassign0 = read_icu1(INTASSIGN0);
-	intassign1 = read_icu1(INTASSIGN1);
+	intassign0 = icu1_read(INTASSIGN0);
+	intassign1 = icu1_read(INTASSIGN1);
 
 	switch (pin) {
 	case 0:
@@ -558,8 +542,8 @@
 	}
 
 	sysint1_assign[pin] = assign;
-	write_icu1(intassign0, INTASSIGN0);
-	write_icu1(intassign1, INTASSIGN1);
+	icu1_write(INTASSIGN0, intassign0);
+	icu1_write(INTASSIGN1, intassign1);
 
 	spin_unlock_irq(&desc->lock);
 
@@ -576,8 +560,8 @@
 
 	spin_lock_irq(&desc->lock);
 
-	intassign2 = read_icu1(INTASSIGN2);
-	intassign3 = read_icu1(INTASSIGN3);
+	intassign2 = icu1_read(INTASSIGN2);
+	intassign3 = icu1_read(INTASSIGN3);
 
 	switch (pin) {
 	case 0:
@@ -625,8 +609,8 @@
 	}
 
 	sysint2_assign[pin] = assign;
-	write_icu1(intassign2, INTASSIGN2);
-	write_icu1(intassign3, INTASSIGN3);
+	icu1_write(INTASSIGN2, intassign2);
+	icu1_write(INTASSIGN3, intassign3);
 
 	spin_unlock_irq(&desc->lock);
 
@@ -653,81 +637,92 @@
 
 EXPORT_SYMBOL(vr41xx_set_intassign);
 
-/*=======================================================================*/
-
-asmlinkage void irq_dispatch(unsigned char intnum, struct pt_regs *regs)
+static int icu_get_irq(unsigned int irq, struct pt_regs *regs)
 {
 	uint16_t pend1, pend2;
 	uint16_t mask1, mask2;
 	int i;
 
-	pend1 = read_icu1(SYSINT1REG);
-	mask1 = read_icu1(MSYSINT1REG);
+	pend1 = icu1_read(SYSINT1REG);
+	mask1 = icu1_read(MSYSINT1REG);
 
-	pend2 = read_icu2(SYSINT2REG);
-	mask2 = read_icu2(MSYSINT2REG);
+	pend2 = icu2_read(SYSINT2REG);
+	mask2 = icu2_read(MSYSINT2REG);
 
 	mask1 &= pend1;
 	mask2 &= pend2;
 
 	if (mask1) {
 		for (i = 0; i < 16; i++) {
-			if (intnum == sysint1_assign[i] &&
-			    (mask1 & ((uint16_t)1 << i))) {
-#ifdef CONFIG_GPIO_VR41XX
-				if (i == 8)
-					giuint_irq_dispatch(regs);
-				else
-#endif
-					do_IRQ(SYSINT1_IRQ(i), regs);
-				return;
-			}
+			if (irq == INT_TO_IRQ(sysint1_assign[i]) && (mask1 & (1 << i)))
+				return SYSINT1_IRQ(i);
 		}
 	}
 
 	if (mask2) {
 		for (i = 0; i < 16; i++) {
-			if (intnum == sysint2_assign[i] &&
-			    (mask2 & ((uint16_t)1 << i))) {
-				do_IRQ(SYSINT2_IRQ(i), regs);
-				return;
-			}
+			if (irq == INT_TO_IRQ(sysint2_assign[i]) && (mask2 & (1 << i)))
+				return SYSINT2_IRQ(i);
 		}
 	}
 
 	printk(KERN_ERR "spurious ICU interrupt: %04x,%04x\n", pend1, pend2);
 
 	atomic_inc(&irq_err_count);
-}
 
-/*=======================================================================*/
+	return -1;
+}
 
-static inline void init_vr41xx_icu_irq(void)
+static int __init vr41xx_icu_init(void)
 {
+	unsigned long icu1_start, icu2_start;
 	int i;
 
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		icu1_base = SYSINT1REG_TYPE1;
-		icu2_base = SYSINT2REG_TYPE1;
+		icu1_start = ICU1_TYPE1_BASE;
+		icu2_start = ICU2_TYPE1_BASE;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		icu1_base = SYSINT1REG_TYPE2;
-		icu2_base = SYSINT2REG_TYPE2;
+		icu1_start = ICU1_TYPE2_BASE;
+		icu2_start = ICU2_TYPE2_BASE;
 		break;
 	default:
 		printk(KERN_ERR "ICU: Unexpected CPU of NEC VR4100 series\n");
-		return -EINVAL;
+		return -ENODEV;
+	}
+
+	if (request_mem_region(icu1_start, ICU1_SIZE, "ICU") == NULL)
+		return -EBUSY;
+
+	if (request_mem_region(icu2_start, ICU2_SIZE, "ICU") == NULL) {
+		release_mem_region(icu1_start, ICU1_SIZE);
+		return -EBUSY;
+	}
+
+	icu1_base = ioremap(icu1_start, ICU1_SIZE);
+	if (icu1_base == NULL) {
+		release_mem_region(icu1_start, ICU1_SIZE);
+		release_mem_region(icu2_start, ICU2_SIZE);
+		return -ENOMEM;
+	}
+
+	icu2_base = ioremap(icu2_start, ICU2_SIZE);
+	if (icu2_base == NULL) {
+		iounmap(icu1_base);
+		release_mem_region(icu1_start, ICU1_SIZE);
+		release_mem_region(icu2_start, ICU2_SIZE);
+		return -ENOMEM;
 	}
 
-	write_icu1(0, MSYSINT1REG);
-	write_icu1(0xffff, MGIUINTLREG);
+	icu1_write(MSYSINT1REG, 0);
+	icu1_write(MGIUINTLREG, 0xffff);
 
-	write_icu2(0, MSYSINT2REG);
-	write_icu2(0xffff, MGIUINTHREG);
+	icu2_write(MSYSINT2REG, 0);
+	icu2_write(MGIUINTHREG, 0xffff);
 
 	for (i = SYSINT1_IRQ_BASE; i <= SYSINT1_IRQ_LAST; i++)
 		irq_desc[i].handler = &sysint1_irq_type;
@@ -735,20 +730,13 @@
 	for (i = SYSINT2_IRQ_BASE; i <= SYSINT2_IRQ_LAST; i++)
 		irq_desc[i].handler = &sysint2_irq_type;
 
-	setup_irq(INT0_CASCADE_IRQ, &icu_cascade);
-	setup_irq(INT1_CASCADE_IRQ, &icu_cascade);
-	setup_irq(INT2_CASCADE_IRQ, &icu_cascade);
-	setup_irq(INT3_CASCADE_IRQ, &icu_cascade);
-	setup_irq(INT4_CASCADE_IRQ, &icu_cascade);
-}
-
-void __init arch_init_irq(void)
-{
-	mips_cpu_irq_init(MIPS_CPU_IRQ_BASE);
-	init_vr41xx_icu_irq();
-#ifdef CONFIG_GPIO_VR41XX
-	init_vr41xx_giuint_irq();
-#endif
+	cascade_irq(INT0_IRQ, icu_get_irq);
+	cascade_irq(INT1_IRQ, icu_get_irq);
+	cascade_irq(INT2_IRQ, icu_get_irq);
+	cascade_irq(INT3_IRQ, icu_get_irq);
+	cascade_irq(INT4_IRQ, icu_get_irq);
 
-	set_except_vector(0, vr41xx_handle_interrupt);
+	return 0;
 }
+
+core_initcall(vr41xx_icu_init);
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/int-handler.S a/arch/mips/vr41xx/common/int-handler.S
--- a-orig/arch/mips/vr41xx/common/int-handler.S	Thu Dec 18 01:02:24 2003
+++ a/arch/mips/vr41xx/common/int-handler.S	Sat May 28 18:29:30 2005
@@ -71,24 +71,24 @@
 
 		andi	t1, t0, CAUSEF_IP3	# check for Int1
 		bnez	t1, handle_int
-		li	a0, 1
+		li	a0, 3
 
 		andi	t1, t0, CAUSEF_IP4	# check for Int2
 		bnez	t1, handle_int
-		li	a0, 2
+		li	a0, 4
 
 		andi	t1, t0, CAUSEF_IP5	# check for Int3
 		bnez	t1, handle_int
-		li	a0, 3
+		li	a0, 5
 
 		andi	t1, t0, CAUSEF_IP6	# check for Int4
 		bnez	t1, handle_int
-		li	a0, 4
+		li	a0, 6
 
 1:
 		andi	t1, t0, CAUSEF_IP2	# check for Int0
 		bnez	t1, handle_int
-		li	a0, 0
+		li	a0, 2
 
 		andi	t1, t0, CAUSEF_IP0	# check for IP0
 		bnez	t1, handle_irq
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/irq.c a/arch/mips/vr41xx/common/irq.c
--- a-orig/arch/mips/vr41xx/common/irq.c	Thu Jan  1 09:00:00 1970
+++ a/arch/mips/vr41xx/common/irq.c	Sat May 28 18:29:22 2005
@@ -0,0 +1,86 @@
+/*
+ *  Interrupt handing routines for NEC VR4100 series.
+ *
+ *  Copyright (C) 2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/interrupt.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/system.h>
+#include <asm/vr41xx/vr41xx.h>
+
+typedef struct irq_cascade {
+	int (*get_irq)(unsigned int, struct pt_regs *);
+} irq_cascade_t;
+
+static irq_cascade_t irq_cascade[NR_IRQS] __cacheline_aligned;
+
+static struct irqaction cascade_irqaction = {
+	.handler	= no_action,
+	.mask		= CPU_MASK_NONE,
+	.name		= "cascade",
+};
+
+int cascade_irq(unsigned int irq, int (*get_irq)(unsigned int, struct pt_regs *))
+{
+	int retval = 0;
+
+	if (irq >= NR_IRQS)
+		return -EINVAL;
+
+	if (irq_cascade[irq].get_irq != NULL)
+		free_irq(irq, NULL);
+
+	irq_cascade[irq].get_irq = get_irq;
+
+	if (get_irq != NULL) {
+		retval = setup_irq(irq, &cascade_irqaction);
+		if (retval < 0)
+			irq_cascade[irq].get_irq = NULL;
+	}
+
+	return retval;
+}
+
+asmlinkage void irq_dispatch(unsigned int irq, struct pt_regs *regs)
+{
+	irq_cascade_t *cascade;
+
+	if (irq >= NR_IRQS) {
+		atomic_inc(&irq_err_count);
+		return;
+	}
+
+	cascade = irq_cascade + irq;
+	if (cascade->get_irq != NULL) {
+		irq = cascade->get_irq(irq, regs);
+		if (irq < 0)
+			atomic_inc(&irq_err_count);
+		else
+			irq_dispatch(irq, regs);
+	} else
+		do_IRQ(irq, regs);
+}
+
+extern asmlinkage void vr41xx_handle_interrupt(void);
+
+void __init arch_init_irq(void)
+{
+	mips_cpu_irq_init(MIPS_CPU_IRQ_BASE);
+
+	set_except_vector(0, vr41xx_handle_interrupt);
+}
diff -urN -X dontdiff a-orig/include/asm-mips/vr41xx/vr41xx.h a/include/asm-mips/vr41xx/vr41xx.h
--- a-orig/include/asm-mips/vr41xx/vr41xx.h	Fri May 20 07:27:42 2005
+++ a/include/asm-mips/vr41xx/vr41xx.h	Sat May 28 18:42:26 2005
@@ -79,11 +79,11 @@
 #define MIPS_CPU_IRQ(x)		(MIPS_CPU_IRQ_BASE + (x))
 #define MIPS_SOFTINT0_IRQ	MIPS_CPU_IRQ(0)
 #define MIPS_SOFTINT1_IRQ	MIPS_CPU_IRQ(1)
-#define INT0_CASCADE_IRQ	MIPS_CPU_IRQ(2)
-#define INT1_CASCADE_IRQ	MIPS_CPU_IRQ(3)
-#define INT2_CASCADE_IRQ	MIPS_CPU_IRQ(4)
-#define INT3_CASCADE_IRQ	MIPS_CPU_IRQ(5)
-#define INT4_CASCADE_IRQ	MIPS_CPU_IRQ(6)
+#define INT0_IRQ		MIPS_CPU_IRQ(2)
+#define INT1_IRQ		MIPS_CPU_IRQ(3)
+#define INT2_IRQ		MIPS_CPU_IRQ(4)
+#define INT3_IRQ		MIPS_CPU_IRQ(5)
+#define INT4_IRQ		MIPS_CPU_IRQ(6)
 #define TIMER_IRQ		MIPS_CPU_IRQ(7)
 
 /* SYINT1 Interrupt Numbers */
@@ -97,7 +97,7 @@
 #define PIU_IRQ			SYSINT1_IRQ(5)
 #define AIU_IRQ			SYSINT1_IRQ(6)
 #define KIU_IRQ			SYSINT1_IRQ(7)
-#define GIUINT_CASCADE_IRQ	SYSINT1_IRQ(8)
+#define GIUINT_IRQ		SYSINT1_IRQ(8)
 #define SIU_IRQ			SYSINT1_IRQ(9)
 #define BUSERR_IRQ		SYSINT1_IRQ(10)
 #define SOFTINT_IRQ		SYSINT1_IRQ(11)
@@ -129,7 +129,7 @@
 #define GIU_IRQ_TO_PIN(x)	((x) - GIU_IRQ_BASE)	/* Pin 0-31 */
 
 extern int vr41xx_set_intassign(unsigned int irq, unsigned char intassign);
-extern int vr41xx_cascade_irq(unsigned int irq, int (*get_irq_number)(int irq));
+extern int cascade_irq(unsigned int irq, int (*get_irq)(unsigned int, struct pt_regs *));
 
 #define PIUINT_COMMAND		0x0040
 #define PIUINT_DATA		0x0020
