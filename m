Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 16:51:07 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:42945 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226033AbUEZPum>;
	Wed, 26 May 2004 16:50:42 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA14244;
	Thu, 27 May 2004 00:50:38 +0900 (JST)
Received: 4UMDO00 id i4QFocQ29762; Thu, 27 May 2004 00:50:38 +0900 (JST)
Received: 4UMRO00 id i4QFobV28700; Thu, 27 May 2004 00:50:37 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 27 May 2004 00:50:35 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2/14] vr41xx: GIUINT routines renewal
Message-Id: <20040527005035.4ded334f.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

The GIUINT routine and ICU routines was renewed.

Please apply to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/giu.c linux/arch/mips/vr41xx/common/giu.c
--- linux-orig/arch/mips/vr41xx/common/giu.c	Thu Feb 26 07:05:00 2004
+++ linux/arch/mips/vr41xx/common/giu.c	Wed May 26 23:12:23 2004
@@ -28,10 +28,12 @@
  *  - Added support for NEC VR4133.
  *  - Removed board_irq_init.
  */
+#include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
@@ -64,6 +66,8 @@
 #define read_giuint(offset)		readw(giu_base + (offset))
 #define write_giuint(val, offset)	writew((val), giu_base + (offset))
 
+#define GIUINT_HIGH_OFFSET	16
+
 static inline uint16_t set_giuint(uint8_t offset, uint16_t set)
 {
 	uint16_t res;
@@ -86,35 +90,123 @@
 	return res;
 }
 
-void vr41xx_enable_giuint(int pin)
+static unsigned int startup_giuint_low_irq(unsigned int irq)
 {
-	if (pin < 16)
-		set_giuint(GIUINTENL, (uint16_t)1 << pin);
-	else
-		set_giuint(GIUINTENH, (uint16_t)1 << (pin - 16));
+	unsigned int pin;
+
+	pin = GIU_IRQ_TO_PIN(irq);
+	write_giuint((uint16_t)1 << pin, GIUINTSTATL);
+	set_giuint(GIUINTENL, (uint16_t)1 << pin);
+
+	return 0;
 }
 
-void vr41xx_disable_giuint(int pin)
+static void shutdown_giuint_low_irq(unsigned int irq)
 {
-	if (pin < 16)
-		clear_giuint(GIUINTENL, (uint16_t)1 << pin);
-	else
-		clear_giuint(GIUINTENH, (uint16_t)1 << (pin - 16));
+	clear_giuint(GIUINTENL, (uint16_t)1 << GIU_IRQ_TO_PIN(irq));
 }
 
-void vr41xx_clear_giuint(int pin)
+static void enable_giuint_low_irq(unsigned int irq)
 {
-	if (pin < 16)
-		write_giuint((uint16_t)1 << pin, GIUINTSTATL);
-	else
-		write_giuint((uint16_t)1 << (pin - 16), GIUINTSTATH);
+	set_giuint(GIUINTENL, (uint16_t)1 << GIU_IRQ_TO_PIN(irq));
+}
+
+#define disable_giuint_low_irq	shutdown_giuint_low_irq
+
+static void ack_giuint_low_irq(unsigned int irq)
+{
+	unsigned int pin;
+
+	pin = GIU_IRQ_TO_PIN(irq);
+	clear_giuint(GIUINTENL, (uint16_t)1 << pin);
+	write_giuint((uint16_t)1 << pin, GIUINTSTATL);
+}
+
+static void end_giuint_low_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		set_giuint(GIUINTENL, (uint16_t)1 << GIU_IRQ_TO_PIN(irq));
+}
+
+static struct hw_interrupt_type giuint_low_irq_type = {
+	.typename	= "GIUINTL",
+	.startup	= startup_giuint_low_irq,
+	.shutdown	= shutdown_giuint_low_irq,
+	.enable		= enable_giuint_low_irq,
+	.disable	= disable_giuint_low_irq,
+	.ack		= ack_giuint_low_irq,
+	.end		= end_giuint_low_irq,
+};
+
+static unsigned int startup_giuint_high_irq(unsigned int irq)
+{
+	unsigned int pin;
+
+	pin = GIU_IRQ_TO_PIN(irq - GIUINT_HIGH_OFFSET);
+	write_giuint((uint16_t)1 << pin, GIUINTSTATH);
+	set_giuint(GIUINTENH, (uint16_t)1 << pin);
+
+	return 0;
+}
+
+static void shutdown_giuint_high_irq(unsigned int irq)
+{
+	clear_giuint(GIUINTENH, (uint16_t)1 << GIU_IRQ_TO_PIN(irq - GIUINT_HIGH_OFFSET));
+}
+
+static void enable_giuint_high_irq(unsigned int irq)
+{
+	set_giuint(GIUINTENH, (uint16_t)1 << GIU_IRQ_TO_PIN(irq - GIUINT_HIGH_OFFSET));
+}
+
+#define disable_giuint_high_irq	shutdown_giuint_high_irq
+
+static void ack_giuint_high_irq(unsigned int irq)
+{
+	unsigned int pin;
+
+	pin = GIU_IRQ_TO_PIN(irq - GIUINT_HIGH_OFFSET);
+	clear_giuint(GIUINTENH, (uint16_t)1 << pin);
+	write_giuint((uint16_t)1 << pin, GIUINTSTATH);
+}
+
+static void end_giuint_high_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		set_giuint(GIUINTENH, (uint16_t)1 << GIU_IRQ_TO_PIN(irq - GIUINT_HIGH_OFFSET));
+}
+
+static struct hw_interrupt_type giuint_high_irq_type = {
+	.typename	= "GIUINTH",
+	.startup	= startup_giuint_high_irq,
+	.shutdown	= shutdown_giuint_high_irq,
+	.enable		= enable_giuint_high_irq,
+	.disable	= disable_giuint_high_irq,
+	.ack		= ack_giuint_high_irq,
+	.end		= end_giuint_high_irq,
+};
+
+static struct irqaction giu_cascade = {no_action, 0, 0, "cascade", NULL, NULL};
+
+void __init init_vr41xx_giuint_irq(void)
+{
+	int i;
+
+	for (i = GIU_IRQ_BASE; i <= GIU_IRQ_LAST; i++) {
+		if (i < (GIU_IRQ_BASE + GIUINT_HIGH_OFFSET))
+			irq_desc[i].handler = &giuint_low_irq_type;
+		else
+			irq_desc[i].handler = &giuint_high_irq_type;
+	}
+
+	setup_irq(GIUINT_CASCADE_IRQ, &giu_cascade);
 }
 
 void vr41xx_set_irq_trigger(int pin, int trigger, int hold)
 {
 	uint16_t mask;
 
-	if (pin < 16) {
+	if (pin < GIUINT_HIGH_OFFSET) {
 		mask = (uint16_t)1 << pin;
 		if (trigger != TRIGGER_LEVEL) {
         		set_giuint(GIUINTTYPL, mask);
@@ -142,8 +234,9 @@
 			clear_giuint(GIUINTTYPL, mask);
 			clear_giuint(GIUINTHTSELL, mask);
 		}
+		write_giuint(mask, GIUINTSTATL);
 	} else {
-		mask = (uint16_t)1 << (pin - 16);
+		mask = (uint16_t)1 << (pin - GIUINT_HIGH_OFFSET);
 		if (trigger != TRIGGER_LEVEL) {
 			set_giuint(GIUINTTYPH, mask);
 			if (hold == SIGNAL_HOLD)
@@ -170,32 +263,35 @@
 			clear_giuint(GIUINTTYPH, mask);
 			clear_giuint(GIUINTHTSELH, mask);
 		}
+		write_giuint(mask, GIUINTSTATH);
 	}
-
-	vr41xx_clear_giuint(pin);
 }
 
+EXPORT_SYMBOL(vr41xx_set_irq_trigger);
+
 void vr41xx_set_irq_level(int pin, int level)
 {
 	uint16_t mask;
 
-	if (pin < 16) {
+	if (pin < GIUINT_HIGH_OFFSET) {
 		mask = (uint16_t)1 << pin;
 		if (level == LEVEL_HIGH)
 			set_giuint(GIUINTALSELL, mask);
 		else
 			clear_giuint(GIUINTALSELL, mask);
+		write_giuint(mask, GIUINTSTATL);
 	} else {
-		mask = (uint16_t)1 << (pin - 16);
+		mask = (uint16_t)1 << (pin - GIUINT_HIGH_OFFSET);
 		if (level == LEVEL_HIGH)
 			set_giuint(GIUINTALSELH, mask);
 		else
 			clear_giuint(GIUINTALSELH, mask);
+		write_giuint(mask, GIUINTSTATH);
 	}
-
-	vr41xx_clear_giuint(pin);
 }
 
+EXPORT_SYMBOL(vr41xx_set_irq_level);
+
 #define GIUINT_NR_IRQS		32
 
 enum {
@@ -209,7 +305,6 @@
 };
 
 static struct vr41xx_giuint_cascade giuint_cascade[GIUINT_NR_IRQS];
-static struct irqaction giu_cascade = {no_action, 0, 0, "cascade", NULL, NULL};
 
 static int no_irq_number(int irq)
 {
@@ -232,7 +327,7 @@
 	giuint_cascade[pin].get_irq_number = get_irq_number;
 
 	retval = setup_irq(irq, &giu_cascade);
-	if (retval) {
+	if (retval != 0) {
 		giuint_cascade[pin].flag = GIUINT_NO_CASCADE;
 		giuint_cascade[pin].get_irq_number = no_irq_number;
 	}
@@ -240,29 +335,89 @@
 	return retval;
 }
 
-unsigned int giuint_do_IRQ(int pin, struct pt_regs *regs)
+EXPORT_SYMBOL(vr41xx_cascade_irq);
+
+static inline int get_irq_pin_number(void)
+{
+	uint16_t pendl, pendh, maskl, maskh;
+	int i;
+
+	pendl = read_giuint(GIUINTSTATL);
+	pendh = read_giuint(GIUINTSTATH);
+	maskl = read_giuint(GIUINTENL);
+	maskh = read_giuint(GIUINTENH);
+
+	maskl &= pendl;
+	maskh &= pendh;
+
+	if (maskl) {
+		for (i = 0; i < 16; i++) {
+			if (maskl & ((uint16_t)1 << i))
+				return i;
+		}
+	} else if (maskh) {
+		for (i = 0; i < 16; i++) {
+			if (maskh & ((uint16_t)1 << i))
+				return i + GIUINT_HIGH_OFFSET;
+		}
+	}
+
+	printk(KERN_ERR "spurious GIU interrupt: %04x(%04x),%04x(%04x)\n",
+	       maskl, pendl, maskh, pendh);
+
+	atomic_inc(&irq_err_count);
+
+	return -1;
+}
+
+static inline void ack_giuint_irq(int pin)
+{
+	if (pin < GIUINT_HIGH_OFFSET) {
+		clear_giuint(GIUINTENL, (uint16_t)1 << pin);
+		write_giuint((uint16_t)1 << pin, GIUINTSTATL);
+	} else {
+		pin -= GIUINT_HIGH_OFFSET;
+		clear_giuint(GIUINTENH, (uint16_t)1 << pin);
+		write_giuint((uint16_t)1 << pin, GIUINTSTATH);
+	}
+}
+
+static inline void end_giuint_irq(int pin)
+{
+	if (pin < GIUINT_HIGH_OFFSET)
+		set_giuint(GIUINTENL, (uint16_t)1 << pin);
+	else
+		set_giuint(GIUINTENH, (uint16_t)1 << (pin - GIUINT_HIGH_OFFSET));
+}
+
+void giuint_irq_dispatch(struct pt_regs *regs)
 {
 	struct vr41xx_giuint_cascade *cascade;
-	unsigned int retval = 0;
-	int giuint_irq, cascade_irq;
+	unsigned int giuint_irq;
+	int pin;
+
+	pin = get_irq_pin_number();
+	if (pin < 0)
+		return;
 
 	disable_irq(GIUINT_CASCADE_IRQ);
+
 	cascade = &giuint_cascade[pin];
 	giuint_irq = GIU_IRQ(pin);
 	if (cascade->flag == GIUINT_CASCADE) {
-		cascade_irq = cascade->get_irq_number(giuint_irq);
-		disable_irq(giuint_irq);
-		if (cascade_irq > 0)
-			retval = do_IRQ(cascade_irq, regs);
-		enable_irq(giuint_irq);
-	} else
-		retval = do_IRQ(giuint_irq, regs);
-	enable_irq(GIUINT_CASCADE_IRQ);
+		int irq = cascade->get_irq_number(giuint_irq);
+		ack_giuint_irq(pin);
+		if (irq >= 0)
+			do_IRQ(irq, regs);
+		end_giuint_irq(pin);
+	} else {
+		do_IRQ(giuint_irq, regs);
+	}
 
-	return retval;
+	enable_irq(GIUINT_CASCADE_IRQ);
 }
 
-void __init vr41xx_giuint_init(void)
+static int __init vr41xx_giu_init(void)
 {
 	int i;
 
@@ -277,16 +432,20 @@
 		giu_base = GIUIOSELL_TYPE2;
 		break;
 	default:
-		panic("GIU: Unexpected CPU of NEC VR4100 series");
-		break;
+		printk(KERN_ERR "GIU: Unexpected CPU of NEC VR4100 series\n");
+		return -EINVAL;
 	}
 
 	for (i = 0; i < GIUINT_NR_IRQS; i++) {
-                vr41xx_disable_giuint(i);
+		if (i < GIUINT_HIGH_OFFSET)
+			clear_giuint(GIUINTENL, (uint16_t)1 << i);
+		else
+			clear_giuint(GIUINTENH, (uint16_t)1 << (i - GIUINT_HIGH_OFFSET));
 		giuint_cascade[i].flag = GIUINT_NO_CASCADE;
 		giuint_cascade[i].get_irq_number = no_irq_number;
 	}
 
-	if (setup_irq(GIUINT_CASCADE_IRQ, &giu_cascade))
-		printk("GIUINT: Can not cascade IRQ %d.\n", GIUINT_CASCADE_IRQ);
+	return 0;
 }
+
+early_initcall(vr41xx_giu_init);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/icu.c linux/arch/mips/vr41xx/common/icu.c
--- linux-orig/arch/mips/vr41xx/common/icu.c	Thu Apr 29 10:42:48 2004
+++ linux/arch/mips/vr41xx/common/icu.c	Wed May 26 23:12:23 2004
@@ -28,10 +28,12 @@
  *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *  - Coped with INTASSIGN of NEC VR4133.
  */
+#include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
@@ -43,11 +45,8 @@
 
 extern asmlinkage void vr41xx_handle_interrupt(void);
 
-extern void vr41xx_giuint_init(void);
-extern void vr41xx_enable_giuint(int pin);
-extern void vr41xx_disable_giuint(int pin);
-extern void vr41xx_clear_giuint(int pin);
-extern unsigned int giuint_do_IRQ(int pin, struct pt_regs *regs);
+extern void init_vr41xx_giuint_irq(void);
+extern void giuint_irq_dispatch(struct pt_regs *regs);
 
 static uint32_t icu1_base;
 static uint32_t icu2_base;
@@ -64,11 +63,17 @@
 #define SYSINT2REG_TYPE2	KSEG1ADDR(0x0f0000a0)
 
 #define SYSINT1REG	0x00
+#define PIUINTREG	0x02
 #define INTASSIGN0	0x04
 #define INTASSIGN1	0x06
 #define GIUINTLREG	0x08
+#define DSIUINTREG	0x0a
 #define MSYSINT1REG	0x0c
+#define MPIUINTREG	0x0e
+#define MAIUINTREG	0x10
+#define MKIUINTREG	0x12
 #define MGIUINTLREG	0x14
+#define MDSIUINTREG	0x16
 #define NMIREG		0x18
 #define SOFTREG		0x1a
 #define INTASSIGN2	0x1c
@@ -76,11 +81,21 @@
 
 #define SYSINT2REG	0x00
 #define GIUINTHREG	0x02
+#define FIRINTREG	0x04
 #define MSYSINT2REG	0x06
 #define MGIUINTHREG	0x08
-
-#define MDSIUINTREG	KSEG1ADDR(0x0f000096)
- #define INTDSIU	0x0800
+#define MFIRINTREG	0x0a
+#define PCIINTREG	0x0c
+ #define PCIINT0	0x0001
+#define SCUINTREG	0x0e
+ #define SCUINT0	0x0001
+#define CSIINTREG	0x10
+#define MPCIINTREG	0x12
+#define MSCUINTREG	0x14
+#define MCSIINTREG	0x16
+#define BCUINTREG	0x18
+ #define BCUINTR	0x0001
+#define MBCUINTREG	0x1a
 
 #define SYSINT1_IRQ_TO_PIN(x)	((x) - SYSINT1_IRQ_BASE)	/* Pin 0-15 */
 #define SYSINT2_IRQ_TO_PIN(x)	((x) - SYSINT2_IRQ_BASE)	/* Pin 0-15 */
@@ -140,212 +155,298 @@
 
 /*=======================================================================*/
 
-void vr41xx_enable_dsiuint(void)
+void vr41xx_enable_piuint(uint16_t mask)
 {
-	writew(INTDSIU, MDSIUINTREG);
+	irq_desc_t *desc = irq_desc + PIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	val = read_icu1(MPIUINTREG);
+	val |= mask;
+	write_icu1(val, MPIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-void vr41xx_disable_dsiuint(void)
+void vr41xx_disable_piuint(uint16_t mask)
 {
-	writew(0, MDSIUINTREG);
+	irq_desc_t *desc = irq_desc + PIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	val = read_icu1(MPIUINTREG);
+	val &= ~mask;
+	write_icu1(val, MPIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-/*=======================================================================*/
+void vr41xx_enable_aiuint(uint16_t mask)
+{
+	irq_desc_t *desc = irq_desc + AIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
 
-static void enable_sysint1_irq(unsigned int irq)
+	spin_lock_irqsave(&desc->lock, flags);
+	val = read_icu1(MAIUINTREG);
+	val |= mask;
+	write_icu1(val, MAIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+void vr41xx_disable_aiuint(uint16_t mask)
 {
-	set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+	irq_desc_t *desc = irq_desc + AIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	val = read_icu1(MAIUINTREG);
+	val &= ~mask;
+	write_icu1(val, MAIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-static void disable_sysint1_irq(unsigned int irq)
+void vr41xx_enable_kiuint(uint16_t mask)
 {
-	clear_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+	irq_desc_t *desc = irq_desc + KIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	val = read_icu1(MKIUINTREG);
+	val |= mask;
+	write_icu1(val, MKIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-static unsigned int startup_sysint1_irq(unsigned int irq)
+void vr41xx_disable_kiuint(uint16_t mask)
 {
-	set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+	irq_desc_t *desc = irq_desc + KIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
 
-	return 0; /* never anything pending */
+	spin_lock_irqsave(&desc->lock, flags);
+	val = read_icu1(MKIUINTREG);
+	val &= ~mask;
+	write_icu1(val, MKIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-#define shutdown_sysint1_irq	disable_sysint1_irq
-#define ack_sysint1_irq		disable_sysint1_irq
+void vr41xx_enable_dsiuint(uint16_t mask)
+{
+	irq_desc_t *desc = irq_desc + DSIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
 
-static void end_sysint1_irq(unsigned int irq)
+	spin_lock_irqsave(&desc->lock, flags);
+	val = read_icu1(MDSIUINTREG);
+	val |= mask;
+	write_icu1(val, MDSIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+void vr41xx_disable_dsiuint(uint16_t mask)
 {
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+	irq_desc_t *desc = irq_desc + DSIU_IRQ;
+	unsigned long flags;
+	uint16_t val;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	val = read_icu1(MDSIUINTREG);
+	val &= ~mask;
+	write_icu1(val, MDSIUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-static struct hw_interrupt_type sysint1_irq_type = {
-	.typename	= "SYSINT1",
-	.startup	= startup_sysint1_irq,
-	.shutdown	= shutdown_sysint1_irq,
-	.enable		= enable_sysint1_irq,
-	.disable	= disable_sysint1_irq,
-	.ack		= ack_sysint1_irq,
-	.end		= end_sysint1_irq,
-};
+void vr41xx_enable_firint(uint16_t mask)
+{
+	irq_desc_t *desc = irq_desc + FIR_IRQ;
+	unsigned long flags;
+	uint16_t val;
 
-/*=======================================================================*/
+	spin_lock_irqsave(&desc->lock, flags);
+	val = read_icu2(MFIRINTREG);
+	val |= mask;
+	write_icu2(val, MFIRINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
 
-static void enable_sysint2_irq(unsigned int irq)
+void vr41xx_disable_firint(uint16_t mask)
 {
-	set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+	irq_desc_t *desc = irq_desc + FIR_IRQ;
+	unsigned long flags;
+	uint16_t val;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	val = read_icu2(MFIRINTREG);
+	val &= ~mask;
+	write_icu2(val, MFIRINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-static void disable_sysint2_irq(unsigned int irq)
+void vr41xx_enable_pciint(void)
 {
-	clear_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+	irq_desc_t *desc = irq_desc + PCI_IRQ;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	write_icu2(PCIINT0, MPCIINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-static unsigned int startup_sysint2_irq(unsigned int irq)
+void vr41xx_disable_pciint(void)
 {
-	set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+	irq_desc_t *desc = irq_desc + PCI_IRQ;
+	unsigned long flags;
 
-	return 0; /* never anything pending */
+	spin_lock_irqsave(&desc->lock, flags);
+	write_icu2(0, MPCIINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-#define shutdown_sysint2_irq	disable_sysint2_irq
-#define ack_sysint2_irq		disable_sysint2_irq
+void vr41xx_enable_scuint(void)
+{
+	irq_desc_t *desc = irq_desc + SCU_IRQ;
+	unsigned long flags;
 
-static void end_sysint2_irq(unsigned int irq)
+	spin_lock_irqsave(&desc->lock, flags);
+	write_icu2(SCUINT0, MSCUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+void vr41xx_disable_scuint(void)
 {
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+	irq_desc_t *desc = irq_desc + SCU_IRQ;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	write_icu2(0, MSCUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-static struct hw_interrupt_type sysint2_irq_type = {
-	.typename	= "SYSINT2",
-	.startup	= startup_sysint2_irq,
-	.shutdown	= shutdown_sysint2_irq,
-	.enable		= enable_sysint2_irq,
-	.disable	= disable_sysint2_irq,
-	.ack		= ack_sysint2_irq,
-	.end		= end_sysint2_irq,
-};
+void vr41xx_enable_csiint(uint16_t mask)
+{
+	irq_desc_t *desc = irq_desc + CSI_IRQ;
+	unsigned long flags;
+	uint16_t val;
 
-/*=======================================================================*/
+	spin_lock_irqsave(&desc->lock, flags);
+	val = read_icu2(MCSIINTREG);
+	val |= mask;
+	write_icu2(val, MCSIINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
 
-static void enable_giuint_irq(unsigned int irq)
+void vr41xx_disable_csiint(uint16_t mask)
 {
-	int pin;
+	irq_desc_t *desc = irq_desc + CSI_IRQ;
+	unsigned long flags;
+	uint16_t val;
 
-	pin = GIU_IRQ_TO_PIN(irq);
-	if (pin < 16)
-		set_icu1(MGIUINTLREG, (uint16_t)1 << pin);
-	else
-		set_icu2(MGIUINTHREG, (uint16_t)1 << (pin - 16));
-	vr41xx_enable_giuint(pin);
+	spin_lock_irqsave(&desc->lock, flags);
+	val = read_icu2(MCSIINTREG);
+	val &= ~mask;
+	write_icu2(val, MCSIINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-static void disable_giuint_irq(unsigned int irq)
+void vr41xx_enable_bcuint(void)
 {
-	int pin;
+	irq_desc_t *desc = irq_desc + BCU_IRQ;
+	unsigned long flags;
 
-	pin = GIU_IRQ_TO_PIN(irq);
-	vr41xx_disable_giuint(pin);
-	if (pin < 16)
-		clear_icu1(MGIUINTLREG, (uint16_t)1 << pin);
-	else
-		clear_icu2(MGIUINTHREG, (uint16_t)1 << (pin - 16));
+	spin_lock_irqsave(&desc->lock, flags);
+	write_icu2(BCUINTR, MBCUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-static unsigned int startup_giuint_irq(unsigned int irq)
+void vr41xx_disable_bcuint(void)
 {
-	vr41xx_clear_giuint(GIU_IRQ_TO_PIN(irq));
+	irq_desc_t *desc = irq_desc + BCU_IRQ;
+	unsigned long flags;
 
-	enable_giuint_irq(irq);
+	spin_lock_irqsave(&desc->lock, flags);
+	write_icu2(0, MBCUINTREG);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+/*=======================================================================*/
+
+static unsigned int startup_sysint1_irq(unsigned int irq)
+{
+	set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
 
 	return 0; /* never anything pending */
 }
 
-#define shutdown_giuint_irq	disable_giuint_irq
-
-static void ack_giuint_irq(unsigned int irq)
+static void shutdown_sysint1_irq(unsigned int irq)
 {
-	disable_giuint_irq(irq);
+	clear_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+}
 
-	vr41xx_clear_giuint(GIU_IRQ_TO_PIN(irq));
+static void enable_sysint1_irq(unsigned int irq)
+{
+	set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
-static void end_giuint_irq(unsigned int irq)
+#define disable_sysint1_irq	shutdown_sysint1_irq
+#define ack_sysint1_irq		shutdown_sysint1_irq
+
+static void end_sysint1_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		enable_giuint_irq(irq);
+		set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
-static struct hw_interrupt_type giuint_irq_type = {
-	.typename	= "GIUINT",
-	.startup	= startup_giuint_irq,
-	.shutdown	= shutdown_giuint_irq,
-	.enable		= enable_giuint_irq,
-	.disable	= disable_giuint_irq,
-	.ack		= ack_giuint_irq,
-	.end		= end_giuint_irq,
+static struct hw_interrupt_type sysint1_irq_type = {
+	.typename	= "SYSINT1",
+	.startup	= startup_sysint1_irq,
+	.shutdown	= shutdown_sysint1_irq,
+	.enable		= enable_sysint1_irq,
+	.disable	= disable_sysint1_irq,
+	.ack		= ack_sysint1_irq,
+	.end		= end_sysint1_irq,
 };
 
 /*=======================================================================*/
 
-static struct irqaction icu_cascade = {no_action, 0, 0, "cascade", NULL, NULL};
-
-static void __init vr41xx_icu_init(void)
+static unsigned int startup_sysint2_irq(unsigned int irq)
 {
-	int i;
-
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		icu1_base = SYSINT1REG_TYPE1;
-		icu2_base = SYSINT2REG_TYPE1;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		icu1_base = SYSINT1REG_TYPE2;
-		icu2_base = SYSINT2REG_TYPE2;
-		break;
-	default:
-		panic("Unexpected CPU of NEC VR4100 series");
-		break;
-	}
-
-	write_icu1(0, MSYSINT1REG);
-	write_icu1(0, MGIUINTLREG);
-
-	write_icu2(0, MSYSINT2REG);
-	write_icu2(0, MGIUINTHREG);
-
-	for (i = SYSINT1_IRQ_BASE; i <= GIU_IRQ_LAST; i++) {
-		if (i >= SYSINT1_IRQ_BASE && i <= SYSINT1_IRQ_LAST)
-			irq_desc[i].handler = &sysint1_irq_type;
-		else if (i >= SYSINT2_IRQ_BASE && i <= SYSINT2_IRQ_LAST)
-			irq_desc[i].handler = &sysint2_irq_type;
-		else if (i >= GIU_IRQ_BASE && i <= GIU_IRQ_LAST)
-			irq_desc[i].handler = &giuint_irq_type;
-	}
+	set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
 
-	setup_irq(INT0_CASCADE_IRQ, &icu_cascade);
-	setup_irq(INT1_CASCADE_IRQ, &icu_cascade);
-	setup_irq(INT2_CASCADE_IRQ, &icu_cascade);
-	setup_irq(INT3_CASCADE_IRQ, &icu_cascade);
-	setup_irq(INT4_CASCADE_IRQ, &icu_cascade);
+	return 0; /* never anything pending */
 }
 
-void __init init_IRQ(void)
+static void shutdown_sysint2_irq(unsigned int irq)
 {
-	memset(irq_desc, 0, sizeof(irq_desc));
+	clear_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+}
 
-	init_generic_irq();
-	mips_cpu_irq_init(MIPS_CPU_IRQ_BASE);
-	vr41xx_icu_init();
+static void enable_sysint2_irq(unsigned int irq)
+{
+	set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+}
 
-	vr41xx_giuint_init();
+#define disable_sysint2_irq	shutdown_sysint2_irq
+#define ack_sysint2_irq		shutdown_sysint2_irq
 
-	set_except_vector(0, vr41xx_handle_interrupt);
+static void end_sysint2_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
+static struct hw_interrupt_type sysint2_irq_type = {
+	.typename	= "SYSINT2",
+	.startup	= startup_sysint2_irq,
+	.shutdown	= shutdown_sysint2_irq,
+	.enable		= enable_sysint2_irq,
+	.disable	= disable_sysint2_irq,
+	.ack		= ack_sysint2_irq,
+	.end		= end_sysint2_irq,
+};
+
 /*=======================================================================*/
 
 static inline int set_sysint1_assign(unsigned int irq, unsigned char assign)
@@ -492,34 +593,14 @@
 	return retval;
 }
 
-/*=======================================================================*/
+EXPORT_SYMBOL(vr41xx_set_intassign);
 
-static inline void giuint_irq_dispatch(uint16_t pendl, uint16_t pendh,
-                                       struct pt_regs *regs)
-{
-	int i;
-
-	if (pendl) {
-		for (i = 0; i < 16; i++) {
-			if (pendl & ((uint16_t)1 << i)) {
-				giuint_do_IRQ(i, regs);
-				return;
-			}
-		}
-	} else {
-		for (i = 0; i < 16; i++) {
-			if (pendh & ((uint16_t)1 << i)) {
-				giuint_do_IRQ(i + 16, regs);
-				return;
-			}
-		}
-	}
-}
+/*=======================================================================*/
 
 asmlinkage void irq_dispatch(unsigned char intnum, struct pt_regs *regs)
 {
-	uint16_t pend1, pend2, pendl, pendh;
-	uint16_t mask1, mask2, maskl, maskh;
+	uint16_t pend1, pend2;
+	uint16_t mask1, mask2;
 	int i;
 
 	pend1 = read_icu1(SYSINT1REG);
@@ -528,28 +609,18 @@
 	pend2 = read_icu2(SYSINT2REG);
 	mask2 = read_icu2(MSYSINT2REG);
 
-	pendl = read_icu1(GIUINTLREG);
-	maskl = read_icu1(MGIUINTLREG);
-
-	pendh = read_icu2(GIUINTHREG);
-	maskh = read_icu2(MGIUINTHREG);
-
 	mask1 &= pend1;
 	mask2 &= pend2;
-	maskl &= pendl;
-	maskh &= pendh;
 
 	if (mask1) {
 		for (i = 0; i < 16; i++) {
 			if (intnum == sysint1_assign[i] &&
 			    (mask1 & ((uint16_t)1 << i))) {
-				if (i == 8 && (maskl | maskh)) {
-					giuint_irq_dispatch(maskl, maskh, regs);
-					return;
-				} else {
+				if (i == 8)
+					giuint_irq_dispatch(regs);
+				else
 					do_IRQ(SYSINT1_IRQ(i), regs);
-					return;
-				}
+				return;
 			}
 		}
 	}
@@ -564,6 +635,72 @@
 		}
 	}
 
-	printk(KERN_ERR "spurious interrupt: %04x,%04x,%04x,%04x\n", pend1, pend2, pendl, pendh);
+	printk(KERN_ERR "spurious ICU interrupt: %04x,%04x\n", pend1, pend2);
+
 	atomic_inc(&irq_err_count);
+}
+
+/*=======================================================================*/
+
+static int __init vr41xx_icu_init(void)
+{
+	switch (current_cpu_data.cputype) {
+	case CPU_VR4111:
+	case CPU_VR4121:
+		icu1_base = SYSINT1REG_TYPE1;
+		icu2_base = SYSINT2REG_TYPE1;
+		break;
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133:
+		icu1_base = SYSINT1REG_TYPE2;
+		icu2_base = SYSINT2REG_TYPE2;
+		break;
+	default:
+		printk(KERN_ERR "ICU: Unexpected CPU of NEC VR4100 series\n");
+		return -EINVAL;
+	}
+
+	write_icu1(0, MSYSINT1REG);
+	write_icu1(0xffff, MGIUINTLREG);
+
+	write_icu2(0, MSYSINT2REG);
+	write_icu2(0xffff, MGIUINTHREG);
+
+	return 0;
+}
+
+early_initcall(vr41xx_icu_init);
+
+/*=======================================================================*/
+
+static struct irqaction icu_cascade = {no_action, 0, 0, "cascade", NULL, NULL};
+
+static inline void init_vr41xx_icu_irq(void)
+{
+	int i;
+
+	for (i = SYSINT1_IRQ_BASE; i <= SYSINT1_IRQ_LAST; i++)
+		irq_desc[i].handler = &sysint1_irq_type;
+
+	for (i = SYSINT2_IRQ_BASE; i <= SYSINT2_IRQ_LAST; i++)
+		irq_desc[i].handler = &sysint2_irq_type;
+
+	setup_irq(INT0_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT1_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT2_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT3_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT4_CASCADE_IRQ, &icu_cascade);
+}
+
+void __init init_IRQ(void)
+{
+	memset(irq_desc, 0, sizeof(irq_desc));
+
+	init_generic_irq();
+	mips_cpu_irq_init(MIPS_CPU_IRQ_BASE);
+	init_vr41xx_icu_irq();
+	init_vr41xx_giuint_irq();
+
+	set_except_vector(0, vr41xx_handle_interrupt);
 }
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/ksyms.c linux/arch/mips/vr41xx/common/ksyms.c
--- linux-orig/arch/mips/vr41xx/common/ksyms.c	Thu Dec 18 01:02:24 2003
+++ linux/arch/mips/vr41xx/common/ksyms.c	Wed May 26 23:12:23 2004
@@ -25,8 +25,6 @@
 EXPORT_SYMBOL(vr41xx_get_vtclock_frequency);
 EXPORT_SYMBOL(vr41xx_get_tclock_frequency);
 
-EXPORT_SYMBOL(vr41xx_set_intassign);
-
 EXPORT_SYMBOL(vr41xx_set_rtclong1_cycle);
 EXPORT_SYMBOL(vr41xx_read_rtclong1_counter);
 EXPORT_SYMBOL(vr41xx_set_rtclong2_cycle);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/serial.c linux/arch/mips/vr41xx/common/serial.c
--- linux-orig/arch/mips/vr41xx/common/serial.c	Thu Apr 29 10:42:48 2004
+++ linux/arch/mips/vr41xx/common/serial.c	Wed May 26 23:12:23 2004
@@ -168,7 +168,7 @@
 	if (port.membase != NULL) {
 		if (early_serial_setup(&port) == 0) {
 			vr41xx_supply_clock(DSIU_CLOCK);
-			vr41xx_enable_dsiuint();
+			vr41xx_enable_dsiuint(DSIUINT_ALL);
 			vr41xx_serial_ports++;
 			return;
 		}
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	Wed May 26 23:22:41 2004
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Wed May 26 23:12:23 2004
@@ -130,8 +130,71 @@
 extern int vr41xx_set_intassign(unsigned int irq, unsigned char intassign);
 extern int vr41xx_cascade_irq(unsigned int irq, int (*get_irq_number)(int irq));
 
-extern void vr41xx_enable_dsiuint(void);
-extern void vr41xx_disable_dsiuint(void);
+#define PIUINT_COMMAND		0x0040
+#define PIUINT_DATA		0x0020
+#define PIUINT_PAGE1		0x0010
+#define PIUINT_PAGE0		0x0008
+#define PIUINT_DATALOST		0x0004
+#define PIUINT_STATUSCHANGE	0x0001
+
+extern void vr41xx_enable_piuint(uint16_t mask);
+extern void vr41xx_disable_piuint(uint16_t mask);
+
+#define AIUINT_INPUT_DMAEND	0x0800
+#define AIUINT_INPUT_DMAHALT	0x0400
+#define AIUINT_INPUT_DATALOST	0x0200
+#define AIUINT_INPUT_DATA	0x0100
+#define AIUINT_OUTPUT_DMAEND	0x0008
+#define AIUINT_OUTPUT_DMAHALT	0x0004
+#define AIUINT_OUTPUT_NODATA	0x0002
+
+extern void vr41xx_enable_aiuint(uint16_t mask);
+extern void vr41xx_disable_aiuint(uint16_t mask);
+
+#define KIUINT_DATALOST		0x0004
+#define KIUINT_DATAREADY	0x0002
+#define KIUINT_SCAN		0x0001
+
+extern void vr41xx_enable_kiuint(uint16_t mask);
+extern void vr41xx_disable_kiuint(uint16_t mask);
+
+#define DSIUINT_CTS		0x0800
+#define DSIUINT_RXERR		0x0400
+#define DSIUINT_RX		0x0200
+#define DSIUINT_TX		0x0100
+#define DSIUINT_ALL		0x0f00
+
+extern void vr41xx_enable_dsiuint(uint16_t mask);
+extern void vr41xx_disable_dsiuint(uint16_t mask);
+
+#define FIRINT_UNIT		0x0010
+#define FIRINT_RX_DMAEND	0x0008
+#define FIRINT_RX_DMAHALT	0x0004
+#define FIRINT_TX_DMAEND	0x0002
+#define FIRINT_TX_DMAHALT	0x0001
+
+extern void vr41xx_enable_firint(uint16_t mask);
+extern void vr41xx_disable_firint(uint16_t mask);
+
+extern void vr41xx_enable_pciint(void);
+extern void vr41xx_disable_pciint(void);
+
+extern void vr41xx_enable_scuint(void);
+extern void vr41xx_disable_scuint(void);
+
+#define CSIINT_TX_DMAEND	0x0040
+#define CSIINT_TX_DMAHALT	0x0020
+#define CSIINT_TX_DATA		0x0010
+#define CSIINT_TX_FIFOEMPTY	0x0008
+#define CSIINT_RX_DMAEND	0x0004
+#define CSIINT_RX_DMAHALT	0x0002
+#define CSIINT_RX_FIFOEMPTY	0x0001
+
+extern void vr41xx_enable_csiint(uint16_t mask);
+extern void vr41xx_disable_csiint(uint16_t mask);
+
+extern void vr41xx_enable_bcuint(void);
+extern void vr41xx_disable_bcuint(void);
 
 /*
  * Power Management Unit
