Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2003 00:12:11 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:28634 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225328AbTLEAMI>;
	Fri, 5 Dec 2003 00:12:08 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id JAA26732;
	Fri, 5 Dec 2003 09:12:02 +0900 (JST)
Received: 4UMDO00 id hB50C1920902; Fri, 5 Dec 2003 09:12:01 +0900 (JST)
Received: 4UMRO00 id hB50Bx621078; Fri, 5 Dec 2003 09:12:00 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Fri, 5 Dec 2003 09:11:56 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: [patch] NEC VR4133 interrupt
Message-Id: <20031205091156.4d387e25.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__5_Dec_2003_09_11_56_+0900_KHJQxu1i.qDXru1p"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart=_Fri__5_Dec_2003_09_11_56_+0900_KHJQxu1i.qDXru1p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

I made these patches for the interrupt function peculiar to NEC VR4133.
All the functions about interrupt of NEC VR4133 can be used.

Please apply these patches.

Thanks,

Yoichi

--Multipart=_Fri__5_Dec_2003_09_11_56_+0900_KHJQxu1i.qDXru1p
Content-Type: text/plain;
 name="01-vr4133_interrupt-v24.diff"
Content-Disposition: attachment;
 filename="01-vr4133_interrupt-v24.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/giu.c linux/arch/mips/vr41xx/common/giu.c
--- linux.orig/arch/mips/vr41xx/common/giu.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/common/giu.c	Fri Dec  5 01:13:07 2003
@@ -44,7 +44,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 
-#include <asm/addrspace.h>
 #include <asm/cpu.h>
 #include <asm/io.h>
 #include <asm/vr41xx/vr41xx.h>
@@ -64,15 +63,19 @@
 #define GIUINTALSELH	0x16
 #define GIUINTHTSELL	0x18
 #define GIUINTHTSELH	0x1a
+#define GIUFEDGEINHL	0x20
+#define GIUFEDGEINHH	0x22
+#define GIUREDGEINHL	0x24
+#define GIUREDGEINHH	0x26
 
-u32 vr41xx_giu_base = 0;
+static uint32_t giu_base;
 
-#define read_giuint(offset)		readw(vr41xx_giu_base + (offset))
-#define write_giuint(val, offset)	writew((val), vr41xx_giu_base + (offset))
+#define read_giuint(offset)		readw(giu_base + (offset))
+#define write_giuint(val, offset)	writew((val), giu_base + (offset))
 
-static inline u16 set_giuint(u16 offset, u16 set)
+static inline uint16_t set_giuint(uint8_t offset, uint16_t set)
 {
-	u16 res;
+	uint16_t res;
 
 	res = read_giuint(offset);
 	res |= set;
@@ -81,9 +84,9 @@
 	return res;
 }
 
-static inline u16 clear_giuint(u16 offset, u16 clear)
+static inline uint16_t clear_giuint(uint8_t offset, uint16_t clear)
 {
-	u16 res;
+	uint16_t res;
 
 	res = read_giuint(offset);
 	res &= ~clear;
@@ -95,51 +98,83 @@
 void vr41xx_enable_giuint(int pin)
 {
 	if (pin < 16)
-		set_giuint(GIUINTENL, (u16)1 << pin);
+		set_giuint(GIUINTENL, (uint16_t)1 << pin);
 	else
-		set_giuint(GIUINTENH, (u16)1 << (pin - 16));
+		set_giuint(GIUINTENH, (uint16_t)1 << (pin - 16));
 }
 
 void vr41xx_disable_giuint(int pin)
 {
 	if (pin < 16)
-		clear_giuint(GIUINTENL, (u16)1 << pin);
+		clear_giuint(GIUINTENL, (uint16_t)1 << pin);
 	else
-		clear_giuint(GIUINTENH, (u16)1 << (pin - 16));
+		clear_giuint(GIUINTENH, (uint16_t)1 << (pin - 16));
 }
 
 void vr41xx_clear_giuint(int pin)
 {
 	if (pin < 16)
-		write_giuint((u16)1 << pin, GIUINTSTATL);
+		write_giuint((uint16_t)1 << pin, GIUINTSTATL);
 	else
-		write_giuint((u16)1 << (pin - 16), GIUINTSTATH);
+		write_giuint((uint16_t)1 << (pin - 16), GIUINTSTATH);
 }
 
 void vr41xx_set_irq_trigger(int pin, int trigger, int hold)
 {
-	u16 mask;
+	uint16_t mask;
 
 	if (pin < 16) {
-		mask = (u16)1 << pin;
-		if (trigger == TRIGGER_EDGE) {
+		mask = (uint16_t)1 << pin;
+		if (trigger != TRIGGER_LEVEL) {
         		set_giuint(GIUINTTYPL, mask);
 			if (hold == SIGNAL_HOLD)
 				set_giuint(GIUINTHTSELL, mask);
 			else
 				clear_giuint(GIUINTHTSELL, mask);
+			if (current_cpu_data.cputype == CPU_VR4133) {
+				switch (trigger) {
+				case TRIGGER_EDGE_FALLING:
+					set_giuint(GIUFEDGEINHL, mask);
+					clear_giuint(GIUREDGEINHL, mask);
+					break;
+				case TRIGGER_EDGE_RISING:
+					clear_giuint(GIUFEDGEINHL, mask);
+					set_giuint(GIUREDGEINHL, mask);
+					break;
+				default:
+					set_giuint(GIUFEDGEINHL, mask);
+					set_giuint(GIUREDGEINHL, mask);
+					break;
+				}
+			}
 		} else {
 			clear_giuint(GIUINTTYPL, mask);
 			clear_giuint(GIUINTHTSELL, mask);
 		}
 	} else {
-		mask = (u16)1 << (pin - 16);
-		if (trigger == TRIGGER_EDGE) {
+		mask = (uint16_t)1 << (pin - 16);
+		if (trigger != TRIGGER_LEVEL) {
 			set_giuint(GIUINTTYPH, mask);
 			if (hold == SIGNAL_HOLD)
 				set_giuint(GIUINTHTSELH, mask);
 			else
 				clear_giuint(GIUINTHTSELH, mask);
+			if (current_cpu_data.cputype == CPU_VR4133) {
+				switch (trigger) {
+				case TRIGGER_EDGE_FALLING:
+					set_giuint(GIUFEDGEINHH, mask);
+					clear_giuint(GIUREDGEINHH, mask);
+					break;
+				case TRIGGER_EDGE_RISING:
+					clear_giuint(GIUFEDGEINHH, mask);
+					set_giuint(GIUREDGEINHH, mask);
+					break;
+				default:
+					set_giuint(GIUFEDGEINHH, mask);
+					set_giuint(GIUREDGEINHH, mask);
+					break;
+				}
+			}
 		} else {
 			clear_giuint(GIUINTTYPH, mask);
 			clear_giuint(GIUINTHTSELH, mask);
@@ -151,16 +186,16 @@
 
 void vr41xx_set_irq_level(int pin, int level)
 {
-	u16 mask;
+	uint16_t mask;
 
 	if (pin < 16) {
-		mask = (u16)1 << pin;
+		mask = (uint16_t)1 << pin;
 		if (level == LEVEL_HIGH)
 			set_giuint(GIUINTALSELL, mask);
 		else
 			clear_giuint(GIUINTALSELL, mask);
 	} else {
-		mask = (u16)1 << (pin - 16);
+		mask = (uint16_t)1 << (pin - 16);
 		if (level == LEVEL_HIGH)
 			set_giuint(GIUINTALSELH, mask);
 		else
@@ -201,7 +236,7 @@
 	if(!get_irq_number)
 		return -EINVAL;
 
-	pin = irq - GIU_IRQ(0);
+	pin = GIU_IRQ_TO_PIN(irq);
 	giuint_cascade[pin].flag = GIUINT_CASCADE;
 	giuint_cascade[pin].get_irq_number = get_irq_number;
 
@@ -222,7 +257,7 @@
 
 	disable_irq(GIUINT_CASCADE_IRQ);
 	cascade = &giuint_cascade[pin];
-	giuint_irq = pin + GIU_IRQ(0);
+	giuint_irq = GIU_IRQ(pin);
 	if (cascade->flag == GIUINT_CASCADE) {
 		cascade_irq = cascade->get_irq_number(giuint_irq);
 		disable_irq(giuint_irq);
@@ -245,12 +280,12 @@
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		vr41xx_giu_base = VR4111_GIUIOSELL;
+		giu_base = VR4111_GIUIOSELL;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		vr41xx_giu_base = VR4122_GIUIOSELL;
+		giu_base = VR4122_GIUIOSELL;
 		break;
 	default:
 		panic("GIU: Unexpected CPU of NEC VR4100 series");
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/icu.c linux/arch/mips/vr41xx/common/icu.c
--- linux.orig/arch/mips/vr41xx/common/icu.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/common/icu.c	Fri Dec  5 01:13:07 2003
@@ -1,9 +1,9 @@
 /*
  * FILE NAME
- *	arch/mips/vr41xx/vr4122/common/icu.c
+ *	arch/mips/vr41xx/common/icu.c
  *
  * BRIEF MODULE DESCRIPTION
- *	Interrupt Control Unit routines for the NEC VR4122 and VR4131.
+ *	Interrupt Control Unit routines for the NEC VR4100 series.
  *
  * Author: Yoichi Yuasa
  *         yyuasa@mvista.com or source@mvista.com
@@ -36,11 +36,8 @@
  *  - New creation, NEC VR4122 and VR4131 are supported.
  *  - Added support for NEC VR4111 and VR4121.
  *
- *  Paul Mundt <lethal@chaoticdreams.org>
- *  - kgdb support.
- *
  *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  - Added support for NEC VR4133.
+ *  - Coped with INTASSIGN of NEC VR4133.
  */
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -48,23 +45,27 @@
 #include <linux/irq.h>
 #include <linux/types.h>
 
-#include <asm/addrspace.h>
 #include <asm/cpu.h>
-#include <asm/gdb-stub.h>
 #include <asm/io.h>
-#include <asm/mipsregs.h>
+#include <asm/irq.h>
+#include <asm/irq_cpu.h>
 #include <asm/vr41xx/vr41xx.h>
 
 extern asmlinkage void vr41xx_handle_interrupt(void);
 
-extern void __init init_generic_irq(void);
-extern void mips_cpu_irq_init(u32 irq_base);
-
 extern void vr41xx_giuint_init(void);
+extern void vr41xx_enable_giuint(int pin);
+extern void vr41xx_disable_giuint(int pin);
+extern void vr41xx_clear_giuint(int pin);
 extern unsigned int giuint_do_IRQ(int pin, struct pt_regs *regs);
 
-static u32 vr41xx_icu1_base = 0;
-static u32 vr41xx_icu2_base = 0;
+static uint32_t icu1_base;
+static uint32_t icu2_base;
+
+static unsigned char sysint1_assign[16] = {
+	0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+static unsigned char sysint2_assign[16] = {
+	2, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 
 #define VR4111_SYSINT1REG	KSEG1ADDR(0x0b000080)
 #define VR4111_SYSINT2REG	KSEG1ADDR(0x0b000200)
@@ -73,26 +74,36 @@
 #define VR4122_SYSINT2REG	KSEG1ADDR(0x0f0000a0)
 
 #define SYSINT1REG	0x00
+#define INTASSIGN0	0x04
+#define INTASSIGN1	0x06
 #define GIUINTLREG	0x08
 #define MSYSINT1REG	0x0c
 #define MGIUINTLREG	0x14
 #define NMIREG		0x18
 #define SOFTREG		0x1a
+#define INTASSIGN2	0x1c
+#define INTASSIGN3	0x1e
 
 #define SYSINT2REG	0x00
 #define GIUINTHREG	0x02
 #define MSYSINT2REG	0x06
 #define MGIUINTHREG	0x08
 
-#define read_icu1(offset)	readw(vr41xx_icu1_base + (offset))
-#define write_icu1(val, offset)	writew((val), vr41xx_icu1_base + (offset))
+#define SYSINT1_IRQ_TO_PIN(x)	((x) - SYSINT1_IRQ_BASE)	/* Pin 0-15 */
+#define SYSINT2_IRQ_TO_PIN(x)	((x) - SYSINT2_IRQ_BASE)	/* Pin 0-15 */
+
+#define read_icu1(offset)	readw(icu1_base + (offset))
+#define write_icu1(val, offset)	writew((val), icu1_base + (offset))
 
-#define read_icu2(offset)	readw(vr41xx_icu2_base + (offset))
-#define write_icu2(val, offset)	writew((val), vr41xx_icu2_base + (offset))
+#define read_icu2(offset)	readw(icu2_base + (offset))
+#define write_icu2(val, offset)	writew((val), icu2_base + (offset))
 
-static inline u16 set_icu1(u16 offset, u16 set)
+#define INTASSIGN_MAX	4
+#define INTASSIGN_MASK	0x0007
+
+static inline uint16_t set_icu1(uint8_t offset, uint16_t set)
 {
-	u16 res;
+	uint16_t res;
 
 	res = read_icu1(offset);
 	res |= set;
@@ -101,9 +112,9 @@
 	return res;
 }
 
-static inline u16 clear_icu1(u16 offset, u16 clear)
+static inline uint16_t clear_icu1(uint8_t offset, uint16_t clear)
 {
-	u16 res;
+	uint16_t res;
 
 	res = read_icu1(offset);
 	res &= ~clear;
@@ -112,9 +123,9 @@
 	return res;
 }
 
-static inline u16 set_icu2(u16 offset, u16 set)
+static inline uint16_t set_icu2(uint8_t offset, uint16_t set)
 {
-	u16 res;
+	uint16_t res;
 
 	res = read_icu2(offset);
 	res |= set;
@@ -123,9 +134,9 @@
 	return res;
 }
 
-static inline u16 clear_icu2(u16 offset, u16 clear)
+static inline uint16_t clear_icu2(uint8_t offset, uint16_t clear)
 {
-	u16 res;
+	uint16_t res;
 
 	res = read_icu2(offset);
 	res &= ~clear;
@@ -138,17 +149,17 @@
 
 static void enable_sysint1_irq(unsigned int irq)
 {
-	set_icu1(MSYSINT1REG, (u16)1 << (irq - SYSINT1_IRQ_BASE));
+	set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
 static void disable_sysint1_irq(unsigned int irq)
 {
-	clear_icu1(MSYSINT1REG, (u16)1 << (irq - SYSINT1_IRQ_BASE));
+	clear_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
 static unsigned int startup_sysint1_irq(unsigned int irq)
 {
-	set_icu1(MSYSINT1REG, (u16)1 << (irq - SYSINT1_IRQ_BASE));
+	set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
 
 	return 0; /* never anything pending */
 }
@@ -159,35 +170,34 @@
 static void end_sysint1_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		set_icu1(MSYSINT1REG, (u16)1 << (irq - SYSINT1_IRQ_BASE));
+		set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
 static struct hw_interrupt_type sysint1_irq_type = {
-	"SYSINT1",
-	startup_sysint1_irq,
-	shutdown_sysint1_irq,
-	enable_sysint1_irq,
-	disable_sysint1_irq,
-	ack_sysint1_irq,
-	end_sysint1_irq,
-	NULL
+	.typename	= "SYSINT1",
+	.startup	= startup_sysint1_irq,
+	.shutdown	= shutdown_sysint1_irq,
+	.enable		= enable_sysint1_irq,
+	.disable	= disable_sysint1_irq,
+	.ack		= ack_sysint1_irq,
+	.end		= end_sysint1_irq,
 };
 
 /*=======================================================================*/
 
 static void enable_sysint2_irq(unsigned int irq)
 {
-	set_icu2(MSYSINT2REG, (u16)1 << (irq - SYSINT2_IRQ_BASE));
+	set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
 static void disable_sysint2_irq(unsigned int irq)
 {
-	clear_icu2(MSYSINT2REG, (u16)1 << (irq - SYSINT2_IRQ_BASE));
+	clear_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
 static unsigned int startup_sysint2_irq(unsigned int irq)
 {
-	set_icu2(MSYSINT2REG, (u16)1 << (irq - SYSINT2_IRQ_BASE));
+	set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
 
 	return 0; /* never anything pending */
 }
@@ -198,18 +208,17 @@
 static void end_sysint2_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		set_icu2(MSYSINT2REG, (u16)1 << (irq - SYSINT2_IRQ_BASE));
+		set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
 static struct hw_interrupt_type sysint2_irq_type = {
-	"SYSINT2",
-	startup_sysint2_irq,
-	shutdown_sysint2_irq,
-	enable_sysint2_irq,
-	disable_sysint2_irq,
-	ack_sysint2_irq,
-	end_sysint2_irq,
-	NULL
+	.typename	= "SYSINT2",
+	.startup	= startup_sysint2_irq,
+	.shutdown	= shutdown_sysint2_irq,
+	.enable		= enable_sysint2_irq,
+	.disable	= disable_sysint2_irq,
+	.ack		= ack_sysint2_irq,
+	.end		= end_sysint2_irq,
 };
 
 /*=======================================================================*/
@@ -218,12 +227,11 @@
 {
 	int pin;
 
-	pin = irq - GIU_IRQ_BASE;
+	pin = GIU_IRQ_TO_PIN(irq);
 	if (pin < 16)
-		set_icu1(MGIUINTLREG, (u16)1 << pin);
+		set_icu1(MGIUINTLREG, (uint16_t)1 << pin);
 	else
-		set_icu2(MGIUINTHREG, (u16)1 << (pin - 16));
-
+		set_icu2(MGIUINTHREG, (uint16_t)1 << (pin - 16));
 	vr41xx_enable_giuint(pin);
 }
 
@@ -231,18 +239,17 @@
 {
 	int pin;
 
-	pin = irq - GIU_IRQ_BASE;
+	pin = GIU_IRQ_TO_PIN(irq);
 	vr41xx_disable_giuint(pin);
-
 	if (pin < 16)
-		clear_icu1(MGIUINTLREG, (u16)1 << pin);
+		clear_icu1(MGIUINTLREG, (uint16_t)1 << pin);
 	else
-		clear_icu2(MGIUINTHREG, (u16)1 << (pin - 16));
+		clear_icu2(MGIUINTHREG, (uint16_t)1 << (pin - 16));
 }
 
 static unsigned int startup_giuint_irq(unsigned int irq)
 {
-	vr41xx_clear_giuint(irq - GIU_IRQ_BASE);
+	vr41xx_clear_giuint(GIU_IRQ_TO_PIN(irq));
 
 	enable_giuint_irq(irq);
 
@@ -255,7 +262,7 @@
 {
 	disable_giuint_irq(irq);
 
-	vr41xx_clear_giuint(irq - GIU_IRQ_BASE);
+	vr41xx_clear_giuint(GIU_IRQ_TO_PIN(irq));
 }
 
 static void end_giuint_irq(unsigned int irq)
@@ -265,14 +272,13 @@
 }
 
 static struct hw_interrupt_type giuint_irq_type = {
-	"GIUINT",
-	startup_giuint_irq,
-	shutdown_giuint_irq,
-	enable_giuint_irq,
-	disable_giuint_irq,
-	ack_giuint_irq,
-	end_giuint_irq,
-	NULL
+	.typename	= "GIUINT",
+	.startup	= startup_giuint_irq,
+	.shutdown	= shutdown_giuint_irq,
+	.enable		= enable_giuint_irq,
+	.disable	= disable_giuint_irq,
+	.ack		= ack_giuint_irq,
+	.end		= end_giuint_irq,
 };
 
 /*=======================================================================*/
@@ -286,14 +292,14 @@
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		vr41xx_icu1_base = VR4111_SYSINT1REG;
-		vr41xx_icu2_base = VR4111_SYSINT2REG;
+		icu1_base = VR4111_SYSINT1REG;
+		icu2_base = VR4111_SYSINT2REG;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		vr41xx_icu1_base = VR4122_SYSINT1REG;
-		vr41xx_icu2_base = VR4122_SYSINT2REG;
+		icu1_base = VR4122_SYSINT1REG;
+		icu2_base = VR4122_SYSINT2REG;
 		break;
 	default:
 		panic("Unexpected CPU of NEC VR4100 series");
@@ -315,7 +321,11 @@
 			irq_desc[i].handler = &giuint_irq_type;
 	}
 
-	setup_irq(ICU_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT0_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT1_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT2_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT3_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT4_CASCADE_IRQ, &icu_cascade);
 }
 
 void __init init_IRQ(void)
@@ -329,31 +339,171 @@
 	vr41xx_giuint_init();
 
 	set_except_vector(0, vr41xx_handle_interrupt);
+}
+
+/*=======================================================================*/
+
+static inline int set_sysint1_assign(unsigned int irq, unsigned char assign)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	uint16_t intassign0, intassign1;
+	unsigned int pin;
+
+	pin = SYSINT1_IRQ_TO_PIN(irq);
+
+	spin_lock_irq(&desc->lock);
+
+	intassign0 = read_icu1(INTASSIGN0);
+	intassign1 = read_icu1(INTASSIGN1);
+
+	switch (pin) {
+	case 0:
+		intassign0 &= ~INTASSIGN_MASK;
+		intassign0 |= (uint16_t)assign;
+		break;
+	case 1:
+		intassign0 &= ~(INTASSIGN_MASK << 3);
+		intassign0 |= (uint16_t)assign << 3;
+		break;
+	case 2:
+		intassign0 &= ~(INTASSIGN_MASK << 6);
+		intassign0 |= (uint16_t)assign << 6;
+		break;
+	case 3:
+		intassign0 &= ~(INTASSIGN_MASK << 9);
+		intassign0 |= (uint16_t)assign << 9;
+		break;
+	case 8:
+		intassign0 &= ~(INTASSIGN_MASK << 12);
+		intassign0 |= (uint16_t)assign << 12;
+		break;
+	case 9:
+		intassign1 &= ~INTASSIGN_MASK;
+		intassign1 |= (uint16_t)assign;
+		break;
+	case 11:
+		intassign1 &= ~(INTASSIGN_MASK << 6);
+		intassign1 |= (uint16_t)assign << 6;
+		break;
+	case 12:
+		intassign1 &= ~(INTASSIGN_MASK << 9);
+		intassign1 |= (uint16_t)assign << 9;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sysint1_assign[pin] = assign;
+	write_icu1(intassign0, INTASSIGN0);
+	write_icu1(intassign1, INTASSIGN1);
+
+	spin_unlock_irq(&desc->lock);
+
+	return 0;
+}
+
+static inline int set_sysint2_assign(unsigned int irq, unsigned char assign)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	uint16_t intassign2, intassign3;
+	unsigned int pin;
 
-#ifdef CONFIG_KGDB
-	printk("Setting debug traps - please connect the remote debugger.\n");
-	set_debug_traps();
-	breakpoint();
-#endif
+	pin = SYSINT2_IRQ_TO_PIN(irq);
+
+	spin_lock_irq(&desc->lock);
+
+	intassign2 = read_icu1(INTASSIGN2);
+	intassign3 = read_icu1(INTASSIGN3);
+
+	switch (pin) {
+	case 0:
+		intassign2 &= ~INTASSIGN_MASK;
+		intassign2 |= (uint16_t)assign;
+		break;
+	case 1:
+		intassign2 &= ~(INTASSIGN_MASK << 3);
+		intassign2 |= (uint16_t)assign << 3;
+		break;
+	case 3:
+		intassign2 &= ~(INTASSIGN_MASK << 6);
+		intassign2 |= (uint16_t)assign << 6;
+		break;
+	case 4:
+		intassign2 &= ~(INTASSIGN_MASK << 9);
+		intassign2 |= (uint16_t)assign << 9;
+		break;
+	case 5:
+		intassign2 &= ~(INTASSIGN_MASK << 12);
+		intassign2 |= (uint16_t)assign << 12;
+		break;
+	case 6:
+		intassign3 &= ~INTASSIGN_MASK;
+		intassign3 |= (uint16_t)assign;
+		break;
+	case 7:
+		intassign3 &= ~(INTASSIGN_MASK << 3);
+		intassign3 |= (uint16_t)assign << 3;
+		break;
+	case 8:
+		intassign3 &= ~(INTASSIGN_MASK << 6);
+		intassign3 |= (uint16_t)assign << 6;
+		break;
+	case 9:
+		intassign3 &= ~(INTASSIGN_MASK << 9);
+		intassign3 |= (uint16_t)assign << 9;
+		break;
+	case 10:
+		intassign3 &= ~(INTASSIGN_MASK << 12);
+		intassign3 |= (uint16_t)assign << 12;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sysint2_assign[pin] = assign;
+	write_icu1(intassign2, INTASSIGN2);
+	write_icu1(intassign3, INTASSIGN3);
+
+	spin_unlock_irq(&desc->lock);
+
+	return 0;
+}
+
+int vr41xx_set_intassign(unsigned int irq, unsigned char intassign)
+{
+	int retval = -EINVAL;
+
+	if (current_cpu_data.cputype != CPU_VR4133)
+		return -EINVAL;
+
+	if (intassign > INTASSIGN_MAX)
+		return -EINVAL;
+
+	if (irq >= SYSINT1_IRQ_BASE && irq <= SYSINT1_IRQ_LAST)
+		retval = set_sysint1_assign(irq, intassign);
+	else if (irq >= SYSINT2_IRQ_BASE && irq <= SYSINT2_IRQ_LAST)
+		retval = set_sysint2_assign(irq, intassign);
+
+	return retval;
 }
 
 /*=======================================================================*/
 
-static inline void giuint_irqdispatch(u16 pendl, u16 pendh, struct pt_regs *regs)
+static inline void giuint_irq_dispatch(uint16_t pendl, uint16_t pendh,
+                                       struct pt_regs *regs)
 {
 	int i;
 
 	if (pendl) {
 		for (i = 0; i < 16; i++) {
-			if (pendl & (0x0001 << i)) {
+			if (pendl & ((uint16_t)1 << i)) {
 				giuint_do_IRQ(i, regs);
 				return;
 			}
 		}
-	}
-	else if (pendh) {
+	} else {
 		for (i = 0; i < 16; i++) {
-			if (pendh & (0x0001 << i)) {
+			if (pendh & ((uint16_t)1 << i)) {
 				giuint_do_IRQ(i + 16, regs);
 				return;
 			}
@@ -361,10 +511,10 @@
 	}
 }
 
-asmlinkage void icu_irqdispatch(struct pt_regs *regs)
+asmlinkage void irq_dispatch(unsigned char intnum, struct pt_regs *regs)
 {
-	u16 pend1, pend2, pendl, pendh;
-	u16 mask1, mask2, maskl, maskh;
+	uint16_t pend1, pend2, pendl, pendh;
+	uint16_t mask1, mask2, maskl, maskh;
 	int i;
 
 	pend1 = read_icu1(SYSINT1REG);
@@ -379,31 +529,36 @@
 	pendh = read_icu2(GIUINTHREG);
 	maskh = read_icu2(MGIUINTHREG);
 
-	pend1 &= mask1;
-	pend2 &= mask2;
-	pendl &= maskl;
-	pendh &= maskh;
-
-	if (pend1) {
-		if ((pend1 & 0x01ff) == 0x0100) {
-			giuint_irqdispatch(pendl, pendh, regs);
-		}
-		else {
-			for (i = 0; i < 16; i++) {
-				if (pend1 & (0x0001 << i)) {
-					do_IRQ(SYSINT1_IRQ_BASE + i, regs);
-					break;
+	mask1 &= pend1;
+	mask2 &= pend2;
+	maskl &= pendl;
+	maskh &= pendh;
+
+	if (mask1) {
+		for (i = 0; i < 16; i++) {
+			if (intnum == sysint1_assign[i] &&
+			    (mask1 & ((uint16_t)1 << i))) {
+				if (i == 8 && (maskl | maskh)) {
+					giuint_irq_dispatch(maskl, maskh, regs);
+					return;
+				} else {
+					do_IRQ(SYSINT1_IRQ(i), regs);
+					return;
 				}
 			}
 		}
-		return;
 	}
-	else if (pend2) {
+
+	if (mask2) {
 		for (i = 0; i < 16; i++) {
-			if (pend2 & (0x0001 << i)) {
-				do_IRQ(SYSINT2_IRQ_BASE + i, regs);
-				break;
+			if (intnum == sysint2_assign[i] &&
+			    (mask2 & ((uint16_t)1 << i))) {
+				do_IRQ(SYSINT2_IRQ(i), regs);
+				return;
 			}
 		}
 	}
+
+	printk(KERN_ERR "spurious interrupt: %04x,%04x,%04x,%04x\n", pend1, pend2, pendl, pendh);
+	atomic_inc(&irq_err_count);
 }
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/int-handler.S linux/arch/mips/vr41xx/common/int-handler.S
--- linux.orig/arch/mips/vr41xx/common/int-handler.S	Mon Jul 15 09:02:56 2002
+++ linux/arch/mips/vr41xx/common/int-handler.S	Fri Dec  5 01:13:07 2003
@@ -34,6 +34,9 @@
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
  *  - New creation, NEC VR4100 series are supported.
+ *
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Coped with INTASSIGN of NEC VR4133.
  */
 #include <asm/asm.h>
 #include <asm/regdef.h>
@@ -59,55 +62,52 @@
 		andi	t0, 0xff00
 		and	t0, t0, t1
 
-		andi	t1, t0, CAUSEF_IP7	# timer interrupt
-		beqz	t1, 1f
+		andi	t1, t0, CAUSEF_IP7	# MIPS timer interrupt
+		bnez	t1, handle_irq
 		li	a0, 7
-		jal	ll_timer_interrupt
-		move	a1, sp
-		j	ret_from_irq
 
-1:
-		andi	t1, t0, 0x7800		# check for IP3-6
-		beqz	t1, 2f
+		andi	t1, t0, 0x7800		# check for Int1-4
+		beqz	t1, 1f
 
-		andi	t1, t0, CAUSEF_IP3	# check for IP3
-		bnez	t1, handle_it
+		andi	t1, t0, CAUSEF_IP3	# check for Int1
+		bnez	t1, handle_int
+		li	a0, 1
+
+		andi	t1, t0, CAUSEF_IP4	# check for Int2
+		bnez	t1, handle_int
+		li	a0, 2
+
+		andi	t1, t0, CAUSEF_IP5	# check for Int3
+		bnez	t1, handle_int
 		li	a0, 3
 
-		andi	t1, t0, CAUSEF_IP4	# check for IP4
-		bnez	t1, handle_it
+		andi	t1, t0, CAUSEF_IP6	# check for Int4
+		bnez	t1, handle_int
 		li	a0, 4
 
-		andi	t1, t0, CAUSEF_IP5	# check for IP5
-		bnez	t1, handle_it
-		li	a0, 5
-
-		andi	t1, t0, CAUSEF_IP6	# check for IP6
-		bnez	t1, handle_it
-		li	a0, 6
-
-2:
-		andi	t1, t0, CAUSEF_IP2	# check for IP2
-		beqz	t1, 3f
-		move	a0, sp
-		jal	icu_irqdispatch
-		nop
-		j	ret_from_irq
-		nop
+1:
+		andi	t1, t0, CAUSEF_IP2	# check for Int0
+		bnez	t1, handle_int
+		li	a0, 0
 
-3:
 		andi	t1, t0, CAUSEF_IP0	# check for IP0
-		bnez	t1, handle_it
+		bnez	t1, handle_irq
 		li	a0, 0
 
 		andi	t1, t0, CAUSEF_IP1	# check for IP1
-		bnez	t1, handle_it
+		bnez	t1, handle_irq
 		li	a0, 1
 
 		j	spurious_interrupt
 		nop
 
-handle_it:
+handle_int:
+		jal	irq_dispatch
+		move	a1, sp
+		j	ret_from_irq
+		nop
+
+handle_irq:
 		jal	do_IRQ
 		move	a1, sp
 		j	ret_from_irq
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/ksyms.c linux/arch/mips/vr41xx/common/ksyms.c
--- linux.orig/arch/mips/vr41xx/common/ksyms.c	Tue Dec  2 04:31:49 2003
+++ linux/arch/mips/vr41xx/common/ksyms.c	Fri Dec  5 01:13:07 2003
@@ -25,6 +25,8 @@
 EXPORT_SYMBOL(vr41xx_get_vtclock_frequency);
 EXPORT_SYMBOL(vr41xx_get_tclock_frequency);
 
+EXPORT_SYMBOL(vr41xx_set_intassign);
+
 EXPORT_SYMBOL(vr41xx_set_rtclong1_cycle);
 EXPORT_SYMBOL(vr41xx_read_rtclong1_counter);
 EXPORT_SYMBOL(vr41xx_set_rtclong2_cycle);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/vrc4173.c linux/arch/mips/vr41xx/common/vrc4173.c
--- linux.orig/arch/mips/vr41xx/common/vrc4173.c	Tue Nov 11 09:07:02 2003
+++ linux/arch/mips/vr41xx/common/vrc4173.c	Fri Dec  5 01:13:07 2003
@@ -195,8 +195,8 @@
 	
 	vrc4173_outw(0, VRC4173_MSYSINT1REG);
 
-	vr41xx_set_irq_trigger(cascade_irq - GIU_IRQ(0), TRIGGER_LEVEL, SIGNAL_THROUGH);
-	vr41xx_set_irq_level(cascade_irq - GIU_IRQ(0), LEVEL_LOW);
+	vr41xx_set_irq_trigger(GIU_IRQ_TO_PIN(cascade_irq), TRIGGER_LEVEL, SIGNAL_THROUGH);
+	vr41xx_set_irq_level(GIU_IRQ_TO_PIN(cascade_irq), LEVEL_LOW);
 
 	for (i = VRC4173_IRQ_BASE; i <= VRC4173_IRQ_LAST; i++)
                 irq_desc[i].handler = &vrc4173_irq_type;
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux.orig/include/asm-mips/vr41xx/vr41xx.h	Wed Dec  3 01:37:12 2003
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Fri Dec  5 08:59:59 2003
@@ -80,49 +80,57 @@
 #define MIPS_CPU_IRQ(x)		(MIPS_CPU_IRQ_BASE + (x))
 #define MIPS_SOFTINT0_IRQ	MIPS_CPU_IRQ(0)
 #define MIPS_SOFTINT1_IRQ	MIPS_CPU_IRQ(1)
-#define ICU_CASCADE_IRQ		MIPS_CPU_IRQ(2)
-#define RTC_LONG1_IRQ		MIPS_CPU_IRQ(3)
-#define RTC_LONG2_IRQ		MIPS_CPU_IRQ(4)
-/* RFU */
-#define BATTERY_IRQ		MIPS_CPU_IRQ(6)
+#define INT0_CASCADE_IRQ	MIPS_CPU_IRQ(2)
+#define INT1_CASCADE_IRQ	MIPS_CPU_IRQ(3)
+#define INT2_CASCADE_IRQ	MIPS_CPU_IRQ(4)
+#define INT3_CASCADE_IRQ	MIPS_CPU_IRQ(5)
+#define INT4_CASCADE_IRQ	MIPS_CPU_IRQ(6)
 #define MIPS_COUNTER_IRQ	MIPS_CPU_IRQ(7)
 
 /* SYINT1 Interrupt Numbers */
 #define SYSINT1_IRQ_BASE	8
 #define SYSINT1_IRQ(x)		(SYSINT1_IRQ_BASE + (x))
-/* RFU */
+#define BATTRY_IRQ		SYSINT1_IRQ(0)
 #define POWER_IRQ		SYSINT1_IRQ(1)
-/* RFU */
+#define RTCLONG1_IRQ		SYSINT1_IRQ(2)
 #define ELAPSEDTIME_IRQ		SYSINT1_IRQ(3)
 /* RFU */
+#define PIU_IRQ			SYSINT1_IRQ(5)
+#define AIU_IRQ			SYSINT1_IRQ(6)
+#define KIU_IRQ			SYSINT1_IRQ(7)
 #define GIUINT_CASCADE_IRQ	SYSINT1_IRQ(8)
 #define SIU_IRQ			SYSINT1_IRQ(9)
-/* RFU */
+#define BUSERR_IRQ		SYSINT1_IRQ(10)
 #define SOFTINT_IRQ		SYSINT1_IRQ(11)
 #define CLKRUN_IRQ		SYSINT1_IRQ(12)
-#define SYSINT1_IRQ_LAST	CLKRUN_IRQ
+#define DOZEPIU_IRQ		SYSINT1_IRQ(13)
+#define SYSINT1_IRQ_LAST	DOZEPIU_IRQ
 
 /* SYSINT2 Interrupt Numbers */
 #define SYSINT2_IRQ_BASE	24
 #define SYSINT2_IRQ(x)		(SYSINT2_IRQ_BASE + (x))
-/* RFU */
+#define RTCLONG2_IRQ		SYSINT2_IRQ(0)
 #define LED_IRQ			SYSINT2_IRQ(1)
-/* RFU */
-#define VTCLOCK_IRQ		SYSINT2_IRQ(3)
+#define HSP_IRQ			SYSINT2_IRQ(2)
+#define TCLOCK_IRQ		SYSINT2_IRQ(3)
 #define FIR_IRQ			SYSINT2_IRQ(4)
+#define CEU_IRQ			SYSINT2_IRQ(4)	/* same number as FIR_IRQ */
 #define DSIU_IRQ		SYSINT2_IRQ(5)
 #define PCI_IRQ			SYSINT2_IRQ(6)
 #define SCU_IRQ			SYSINT2_IRQ(7)
 #define CSI_IRQ			SYSINT2_IRQ(8)
 #define BCU_IRQ			SYSINT2_IRQ(9)
-#define SYSINT2_IRQ_LAST	BCU_IRQ
+#define ETHERNET_IRQ		SYSINT2_IRQ(10)
+#define SYSINT2_IRQ_LAST	ETHERNET_IRQ
 
 /* GIU Interrupt Numbers */
 #define GIU_IRQ_BASE		40
 #define GIU_IRQ(x)		(GIU_IRQ_BASE + (x))	/* IRQ 40-71 */
 #define GIU_IRQ_LAST		GIU_IRQ(31)
+#define GIU_IRQ_TO_PIN(x)	((x) - GIU_IRQ_BASE)	/* Pin 0-31 */
 
 extern void (*board_irq_init)(void);
+extern int vr41xx_set_intassign(unsigned int irq, unsigned char intassign);
 extern int vr41xx_cascade_irq(unsigned int irq, int (*get_irq_number)(int irq));
 
 /*
@@ -140,13 +148,11 @@
 /*
  * General-Purpose I/O Unit
  */
-extern void vr41xx_enable_giuint(int pin);
-extern void vr41xx_disable_giuint(int pin);
-extern void vr41xx_clear_giuint(int pin);
-
 enum {
 	TRIGGER_LEVEL,
-	TRIGGER_EDGE
+	TRIGGER_EDGE,
+	TRIGGER_EDGE_FALLING,
+	TRIGGER_EDGE_RISING
 };
 
 enum {

--Multipart=_Fri__5_Dec_2003_09_11_56_+0900_KHJQxu1i.qDXru1p
Content-Type: text/plain;
 name="01-vr4133_interrupt-v26.diff"
Content-Disposition: attachment;
 filename="01-vr4133_interrupt-v26.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/bcu.c linux/arch/mips/vr41xx/common/bcu.c
--- linux.orig/arch/mips/vr41xx/common/bcu.c	Wed Dec  3 01:39:04 2003
+++ linux/arch/mips/vr41xx/common/bcu.c	Fri Dec  5 08:34:40 2003
@@ -40,7 +40,6 @@
  *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/giu.c linux/arch/mips/vr41xx/common/giu.c
--- linux.orig/arch/mips/vr41xx/common/giu.c	Fri Oct 31 11:30:39 2003
+++ linux/arch/mips/vr41xx/common/giu.c	Fri Dec  5 08:34:40 2003
@@ -44,7 +44,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 
-#include <asm/addrspace.h>
 #include <asm/cpu.h>
 #include <asm/io.h>
 #include <asm/vr41xx/vr41xx.h>
@@ -64,15 +63,19 @@
 #define GIUINTALSELH	0x16
 #define GIUINTHTSELL	0x18
 #define GIUINTHTSELH	0x1a
+#define GIUFEDGEINHL	0x20
+#define GIUFEDGEINHH	0x22
+#define GIUREDGEINHL	0x24
+#define GIUREDGEINHH	0x26
 
-u32 vr41xx_giu_base = 0;
+static uint32_t giu_base;
 
-#define read_giuint(offset)		readw(vr41xx_giu_base + (offset))
-#define write_giuint(val, offset)	writew((val), vr41xx_giu_base + (offset))
+#define read_giuint(offset)		readw(giu_base + (offset))
+#define write_giuint(val, offset)	writew((val), giu_base + (offset))
 
-static inline u16 set_giuint(u16 offset, u16 set)
+static inline uint16_t set_giuint(uint8_t offset, uint16_t set)
 {
-	u16 res;
+	uint16_t res;
 
 	res = read_giuint(offset);
 	res |= set;
@@ -81,9 +84,9 @@
 	return res;
 }
 
-static inline u16 clear_giuint(u16 offset, u16 clear)
+static inline uint16_t clear_giuint(uint8_t offset, uint16_t clear)
 {
-	u16 res;
+	uint16_t res;
 
 	res = read_giuint(offset);
 	res &= ~clear;
@@ -95,51 +98,83 @@
 void vr41xx_enable_giuint(int pin)
 {
 	if (pin < 16)
-		set_giuint(GIUINTENL, (u16)1 << pin);
+		set_giuint(GIUINTENL, (uint16_t)1 << pin);
 	else
-		set_giuint(GIUINTENH, (u16)1 << (pin - 16));
+		set_giuint(GIUINTENH, (uint16_t)1 << (pin - 16));
 }
 
 void vr41xx_disable_giuint(int pin)
 {
 	if (pin < 16)
-		clear_giuint(GIUINTENL, (u16)1 << pin);
+		clear_giuint(GIUINTENL, (uint16_t)1 << pin);
 	else
-		clear_giuint(GIUINTENH, (u16)1 << (pin - 16));
+		clear_giuint(GIUINTENH, (uint16_t)1 << (pin - 16));
 }
 
 void vr41xx_clear_giuint(int pin)
 {
 	if (pin < 16)
-		write_giuint((u16)1 << pin, GIUINTSTATL);
+		write_giuint((uint16_t)1 << pin, GIUINTSTATL);
 	else
-		write_giuint((u16)1 << (pin - 16), GIUINTSTATH);
+		write_giuint((uint16_t)1 << (pin - 16), GIUINTSTATH);
 }
 
 void vr41xx_set_irq_trigger(int pin, int trigger, int hold)
 {
-	u16 mask;
+	uint16_t mask;
 
 	if (pin < 16) {
-		mask = (u16)1 << pin;
-		if (trigger == TRIGGER_EDGE) {
+		mask = (uint16_t)1 << pin;
+		if (trigger != TRIGGER_LEVEL) {
         		set_giuint(GIUINTTYPL, mask);
 			if (hold == SIGNAL_HOLD)
 				set_giuint(GIUINTHTSELL, mask);
 			else
 				clear_giuint(GIUINTHTSELL, mask);
+			if (current_cpu_data.cputype == CPU_VR4133) {
+				switch (trigger) {
+				case TRIGGER_EDGE_FALLING:
+					set_giuint(GIUFEDGEINHL, mask);
+					clear_giuint(GIUREDGEINHL, mask);
+					break;
+				case TRIGGER_EDGE_RISING:
+					clear_giuint(GIUFEDGEINHL, mask);
+					set_giuint(GIUREDGEINHL, mask);
+					break;
+				default:
+					set_giuint(GIUFEDGEINHL, mask);
+					set_giuint(GIUREDGEINHL, mask);
+					break;
+				}
+			}
 		} else {
 			clear_giuint(GIUINTTYPL, mask);
 			clear_giuint(GIUINTHTSELL, mask);
 		}
 	} else {
-		mask = (u16)1 << (pin - 16);
-		if (trigger == TRIGGER_EDGE) {
+		mask = (uint16_t)1 << (pin - 16);
+		if (trigger != TRIGGER_LEVEL) {
 			set_giuint(GIUINTTYPH, mask);
 			if (hold == SIGNAL_HOLD)
 				set_giuint(GIUINTHTSELH, mask);
 			else
 				clear_giuint(GIUINTHTSELH, mask);
+			if (current_cpu_data.cputype == CPU_VR4133) {
+				switch (trigger) {
+				case TRIGGER_EDGE_FALLING:
+					set_giuint(GIUFEDGEINHH, mask);
+					clear_giuint(GIUREDGEINHH, mask);
+					break;
+				case TRIGGER_EDGE_RISING:
+					clear_giuint(GIUFEDGEINHH, mask);
+					set_giuint(GIUREDGEINHH, mask);
+					break;
+				default:
+					set_giuint(GIUFEDGEINHH, mask);
+					set_giuint(GIUREDGEINHH, mask);
+					break;
+				}
+			}
 		} else {
 			clear_giuint(GIUINTTYPH, mask);
 			clear_giuint(GIUINTHTSELH, mask);
@@ -151,16 +186,16 @@
 
 void vr41xx_set_irq_level(int pin, int level)
 {
-	u16 mask;
+	uint16_t mask;
 
 	if (pin < 16) {
-		mask = (u16)1 << pin;
+		mask = (uint16_t)1 << pin;
 		if (level == LEVEL_HIGH)
 			set_giuint(GIUINTALSELL, mask);
 		else
 			clear_giuint(GIUINTALSELL, mask);
 	} else {
-		mask = (u16)1 << (pin - 16);
+		mask = (uint16_t)1 << (pin - 16);
 		if (level == LEVEL_HIGH)
 			set_giuint(GIUINTALSELH, mask);
 		else
@@ -201,7 +236,7 @@
 	if(!get_irq_number)
 		return -EINVAL;
 
-	pin = irq - GIU_IRQ(0);
+	pin = GIU_IRQ_TO_PIN(irq);
 	giuint_cascade[pin].flag = GIUINT_CASCADE;
 	giuint_cascade[pin].get_irq_number = get_irq_number;
 
@@ -222,7 +257,7 @@
 
 	disable_irq(GIUINT_CASCADE_IRQ);
 	cascade = &giuint_cascade[pin];
-	giuint_irq = pin + GIU_IRQ(0);
+	giuint_irq = GIU_IRQ(pin);
 	if (cascade->flag == GIUINT_CASCADE) {
 		cascade_irq = cascade->get_irq_number(giuint_irq);
 		disable_irq(giuint_irq);
@@ -245,12 +280,12 @@
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		vr41xx_giu_base = VR4111_GIUIOSELL;
+		giu_base = VR4111_GIUIOSELL;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		vr41xx_giu_base = VR4122_GIUIOSELL;
+		giu_base = VR4122_GIUIOSELL;
 		break;
 	default:
 		panic("GIU: Unexpected CPU of NEC VR4100 series");
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/icu.c linux/arch/mips/vr41xx/common/icu.c
--- linux.orig/arch/mips/vr41xx/common/icu.c	Tue Nov 18 12:34:22 2003
+++ linux/arch/mips/vr41xx/common/icu.c	Fri Dec  5 08:34:40 2003
@@ -1,9 +1,9 @@
 /*
  * FILE NAME
- *	arch/mips/vr41xx/vr4122/common/icu.c
+ *	arch/mips/vr41xx/common/icu.c
  *
  * BRIEF MODULE DESCRIPTION
- *	Interrupt Control Unit routines for the NEC VR4122 and VR4131.
+ *	Interrupt Control Unit routines for the NEC VR4100 series.
  *
  * Author: Yoichi Yuasa
  *         yyuasa@mvista.com or source@mvista.com
@@ -36,36 +36,36 @@
  *  - New creation, NEC VR4122 and VR4131 are supported.
  *  - Added support for NEC VR4111 and VR4121.
  *
- *  Paul Mundt <lethal@chaoticdreams.org>
- *  - kgdb support.
- *
  *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  - Added support for NEC VR4133.
+ *  - Coped with INTASSIGN of NEC VR4133.
  */
-#include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/types.h>
 
-#include <asm/addrspace.h>
 #include <asm/cpu.h>
-#include <asm/gdb-stub.h>
 #include <asm/io.h>
-#include <asm/mipsregs.h>
+#include <asm/irq.h>
+#include <asm/irq_cpu.h>
 #include <asm/vr41xx/vr41xx.h>
 
 extern asmlinkage void vr41xx_handle_interrupt(void);
 
-extern void __init init_generic_irq(void);
-extern void mips_cpu_irq_init(u32 irq_base);
-
 extern void vr41xx_giuint_init(void);
+extern void vr41xx_enable_giuint(int pin);
+extern void vr41xx_disable_giuint(int pin);
+extern void vr41xx_clear_giuint(int pin);
 extern unsigned int giuint_do_IRQ(int pin, struct pt_regs *regs);
 
-static u32 vr41xx_icu1_base = 0;
-static u32 vr41xx_icu2_base = 0;
+static uint32_t icu1_base;
+static uint32_t icu2_base;
+
+static unsigned char sysint1_assign[16] = {
+	0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+static unsigned char sysint2_assign[16] = {
+	2, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 
 #define VR4111_SYSINT1REG	KSEG1ADDR(0x0b000080)
 #define VR4111_SYSINT2REG	KSEG1ADDR(0x0b000200)
@@ -74,26 +74,36 @@
 #define VR4122_SYSINT2REG	KSEG1ADDR(0x0f0000a0)
 
 #define SYSINT1REG	0x00
+#define INTASSIGN0	0x04
+#define INTASSIGN1	0x06
 #define GIUINTLREG	0x08
 #define MSYSINT1REG	0x0c
 #define MGIUINTLREG	0x14
 #define NMIREG		0x18
 #define SOFTREG		0x1a
+#define INTASSIGN2	0x1c
+#define INTASSIGN3	0x1e
 
 #define SYSINT2REG	0x00
 #define GIUINTHREG	0x02
 #define MSYSINT2REG	0x06
 #define MGIUINTHREG	0x08
 
-#define read_icu1(offset)	readw(vr41xx_icu1_base + (offset))
-#define write_icu1(val, offset)	writew((val), vr41xx_icu1_base + (offset))
+#define SYSINT1_IRQ_TO_PIN(x)	((x) - SYSINT1_IRQ_BASE)	/* Pin 0-15 */
+#define SYSINT2_IRQ_TO_PIN(x)	((x) - SYSINT2_IRQ_BASE)	/* Pin 0-15 */
+
+#define read_icu1(offset)	readw(icu1_base + (offset))
+#define write_icu1(val, offset)	writew((val), icu1_base + (offset))
 
-#define read_icu2(offset)	readw(vr41xx_icu2_base + (offset))
-#define write_icu2(val, offset)	writew((val), vr41xx_icu2_base + (offset))
+#define read_icu2(offset)	readw(icu2_base + (offset))
+#define write_icu2(val, offset)	writew((val), icu2_base + (offset))
 
-static inline u16 set_icu1(u16 offset, u16 set)
+#define INTASSIGN_MAX	4
+#define INTASSIGN_MASK	0x0007
+
+static inline uint16_t set_icu1(uint8_t offset, uint16_t set)
 {
-	u16 res;
+	uint16_t res;
 
 	res = read_icu1(offset);
 	res |= set;
@@ -102,9 +112,9 @@
 	return res;
 }
 
-static inline u16 clear_icu1(u16 offset, u16 clear)
+static inline uint16_t clear_icu1(uint8_t offset, uint16_t clear)
 {
-	u16 res;
+	uint16_t res;
 
 	res = read_icu1(offset);
 	res &= ~clear;
@@ -113,9 +123,9 @@
 	return res;
 }
 
-static inline u16 set_icu2(u16 offset, u16 set)
+static inline uint16_t set_icu2(uint8_t offset, uint16_t set)
 {
-	u16 res;
+	uint16_t res;
 
 	res = read_icu2(offset);
 	res |= set;
@@ -124,9 +134,9 @@
 	return res;
 }
 
-static inline u16 clear_icu2(u16 offset, u16 clear)
+static inline uint16_t clear_icu2(uint8_t offset, uint16_t clear)
 {
-	u16 res;
+	uint16_t res;
 
 	res = read_icu2(offset);
 	res &= ~clear;
@@ -139,17 +149,17 @@
 
 static void enable_sysint1_irq(unsigned int irq)
 {
-	set_icu1(MSYSINT1REG, (u16)1 << (irq - SYSINT1_IRQ_BASE));
+	set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
 static void disable_sysint1_irq(unsigned int irq)
 {
-	clear_icu1(MSYSINT1REG, (u16)1 << (irq - SYSINT1_IRQ_BASE));
+	clear_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
 static unsigned int startup_sysint1_irq(unsigned int irq)
 {
-	set_icu1(MSYSINT1REG, (u16)1 << (irq - SYSINT1_IRQ_BASE));
+	set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
 
 	return 0; /* never anything pending */
 }
@@ -160,35 +170,34 @@
 static void end_sysint1_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		set_icu1(MSYSINT1REG, (u16)1 << (irq - SYSINT1_IRQ_BASE));
+		set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
 static struct hw_interrupt_type sysint1_irq_type = {
-	"SYSINT1",
-	startup_sysint1_irq,
-	shutdown_sysint1_irq,
-	enable_sysint1_irq,
-	disable_sysint1_irq,
-	ack_sysint1_irq,
-	end_sysint1_irq,
-	NULL
+	.typename	= "SYSINT1",
+	.startup	= startup_sysint1_irq,
+	.shutdown	= shutdown_sysint1_irq,
+	.enable		= enable_sysint1_irq,
+	.disable	= disable_sysint1_irq,
+	.ack		= ack_sysint1_irq,
+	.end		= end_sysint1_irq,
 };
 
 /*=======================================================================*/
 
 static void enable_sysint2_irq(unsigned int irq)
 {
-	set_icu2(MSYSINT2REG, (u16)1 << (irq - SYSINT2_IRQ_BASE));
+	set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
 static void disable_sysint2_irq(unsigned int irq)
 {
-	clear_icu2(MSYSINT2REG, (u16)1 << (irq - SYSINT2_IRQ_BASE));
+	clear_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
 static unsigned int startup_sysint2_irq(unsigned int irq)
 {
-	set_icu2(MSYSINT2REG, (u16)1 << (irq - SYSINT2_IRQ_BASE));
+	set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
 
 	return 0; /* never anything pending */
 }
@@ -199,18 +208,17 @@
 static void end_sysint2_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		set_icu2(MSYSINT2REG, (u16)1 << (irq - SYSINT2_IRQ_BASE));
+		set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
 static struct hw_interrupt_type sysint2_irq_type = {
-	"SYSINT2",
-	startup_sysint2_irq,
-	shutdown_sysint2_irq,
-	enable_sysint2_irq,
-	disable_sysint2_irq,
-	ack_sysint2_irq,
-	end_sysint2_irq,
-	NULL
+	.typename	= "SYSINT2",
+	.startup	= startup_sysint2_irq,
+	.shutdown	= shutdown_sysint2_irq,
+	.enable		= enable_sysint2_irq,
+	.disable	= disable_sysint2_irq,
+	.ack		= ack_sysint2_irq,
+	.end		= end_sysint2_irq,
 };
 
 /*=======================================================================*/
@@ -219,12 +227,11 @@
 {
 	int pin;
 
-	pin = irq - GIU_IRQ_BASE;
+	pin = GIU_IRQ_TO_PIN(irq);
 	if (pin < 16)
-		set_icu1(MGIUINTLREG, (u16)1 << pin);
+		set_icu1(MGIUINTLREG, (uint16_t)1 << pin);
 	else
-		set_icu2(MGIUINTHREG, (u16)1 << (pin - 16));
-
+		set_icu2(MGIUINTHREG, (uint16_t)1 << (pin - 16));
 	vr41xx_enable_giuint(pin);
 }
 
@@ -232,18 +239,17 @@
 {
 	int pin;
 
-	pin = irq - GIU_IRQ_BASE;
+	pin = GIU_IRQ_TO_PIN(irq);
 	vr41xx_disable_giuint(pin);
-
 	if (pin < 16)
-		clear_icu1(MGIUINTLREG, (u16)1 << pin);
+		clear_icu1(MGIUINTLREG, (uint16_t)1 << pin);
 	else
-		clear_icu2(MGIUINTHREG, (u16)1 << (pin - 16));
+		clear_icu2(MGIUINTHREG, (uint16_t)1 << (pin - 16));
 }
 
 static unsigned int startup_giuint_irq(unsigned int irq)
 {
-	vr41xx_clear_giuint(irq - GIU_IRQ_BASE);
+	vr41xx_clear_giuint(GIU_IRQ_TO_PIN(irq));
 
 	enable_giuint_irq(irq);
 
@@ -256,7 +262,7 @@
 {
 	disable_giuint_irq(irq);
 
-	vr41xx_clear_giuint(irq - GIU_IRQ_BASE);
+	vr41xx_clear_giuint(GIU_IRQ_TO_PIN(irq));
 }
 
 static void end_giuint_irq(unsigned int irq)
@@ -266,14 +272,13 @@
 }
 
 static struct hw_interrupt_type giuint_irq_type = {
-	"GIUINT",
-	startup_giuint_irq,
-	shutdown_giuint_irq,
-	enable_giuint_irq,
-	disable_giuint_irq,
-	ack_giuint_irq,
-	end_giuint_irq,
-	NULL
+	.typename	= "GIUINT",
+	.startup	= startup_giuint_irq,
+	.shutdown	= shutdown_giuint_irq,
+	.enable		= enable_giuint_irq,
+	.disable	= disable_giuint_irq,
+	.ack		= ack_giuint_irq,
+	.end		= end_giuint_irq,
 };
 
 /*=======================================================================*/
@@ -287,14 +292,14 @@
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		vr41xx_icu1_base = VR4111_SYSINT1REG;
-		vr41xx_icu2_base = VR4111_SYSINT2REG;
+		icu1_base = VR4111_SYSINT1REG;
+		icu2_base = VR4111_SYSINT2REG;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		vr41xx_icu1_base = VR4122_SYSINT1REG;
-		vr41xx_icu2_base = VR4122_SYSINT2REG;
+		icu1_base = VR4122_SYSINT1REG;
+		icu2_base = VR4122_SYSINT2REG;
 		break;
 	default:
 		panic("Unexpected CPU of NEC VR4100 series");
@@ -316,7 +321,11 @@
 			irq_desc[i].handler = &giuint_irq_type;
 	}
 
-	setup_irq(ICU_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT0_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT1_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT2_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT3_CASCADE_IRQ, &icu_cascade);
+	setup_irq(INT4_CASCADE_IRQ, &icu_cascade);
 }
 
 void __init init_IRQ(void)
@@ -330,31 +339,171 @@
 	vr41xx_giuint_init();
 
 	set_except_vector(0, vr41xx_handle_interrupt);
+}
+
+/*=======================================================================*/
+
+static inline int set_sysint1_assign(unsigned int irq, unsigned char assign)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	uint16_t intassign0, intassign1;
+	unsigned int pin;
+
+	pin = SYSINT1_IRQ_TO_PIN(irq);
+
+	spin_lock_irq(&desc->lock);
+
+	intassign0 = read_icu1(INTASSIGN0);
+	intassign1 = read_icu1(INTASSIGN1);
+
+	switch (pin) {
+	case 0:
+		intassign0 &= ~INTASSIGN_MASK;
+		intassign0 |= (uint16_t)assign;
+		break;
+	case 1:
+		intassign0 &= ~(INTASSIGN_MASK << 3);
+		intassign0 |= (uint16_t)assign << 3;
+		break;
+	case 2:
+		intassign0 &= ~(INTASSIGN_MASK << 6);
+		intassign0 |= (uint16_t)assign << 6;
+		break;
+	case 3:
+		intassign0 &= ~(INTASSIGN_MASK << 9);
+		intassign0 |= (uint16_t)assign << 9;
+		break;
+	case 8:
+		intassign0 &= ~(INTASSIGN_MASK << 12);
+		intassign0 |= (uint16_t)assign << 12;
+		break;
+	case 9:
+		intassign1 &= ~INTASSIGN_MASK;
+		intassign1 |= (uint16_t)assign;
+		break;
+	case 11:
+		intassign1 &= ~(INTASSIGN_MASK << 6);
+		intassign1 |= (uint16_t)assign << 6;
+		break;
+	case 12:
+		intassign1 &= ~(INTASSIGN_MASK << 9);
+		intassign1 |= (uint16_t)assign << 9;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sysint1_assign[pin] = assign;
+	write_icu1(intassign0, INTASSIGN0);
+	write_icu1(intassign1, INTASSIGN1);
+
+	spin_unlock_irq(&desc->lock);
+
+	return 0;
+}
+
+static inline int set_sysint2_assign(unsigned int irq, unsigned char assign)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	uint16_t intassign2, intassign3;
+	unsigned int pin;
 
-#ifdef CONFIG_KGDB
-	printk("Setting debug traps - please connect the remote debugger.\n");
-	set_debug_traps();
-	breakpoint();
-#endif
+	pin = SYSINT2_IRQ_TO_PIN(irq);
+
+	spin_lock_irq(&desc->lock);
+
+	intassign2 = read_icu1(INTASSIGN2);
+	intassign3 = read_icu1(INTASSIGN3);
+
+	switch (pin) {
+	case 0:
+		intassign2 &= ~INTASSIGN_MASK;
+		intassign2 |= (uint16_t)assign;
+		break;
+	case 1:
+		intassign2 &= ~(INTASSIGN_MASK << 3);
+		intassign2 |= (uint16_t)assign << 3;
+		break;
+	case 3:
+		intassign2 &= ~(INTASSIGN_MASK << 6);
+		intassign2 |= (uint16_t)assign << 6;
+		break;
+	case 4:
+		intassign2 &= ~(INTASSIGN_MASK << 9);
+		intassign2 |= (uint16_t)assign << 9;
+		break;
+	case 5:
+		intassign2 &= ~(INTASSIGN_MASK << 12);
+		intassign2 |= (uint16_t)assign << 12;
+		break;
+	case 6:
+		intassign3 &= ~INTASSIGN_MASK;
+		intassign3 |= (uint16_t)assign;
+		break;
+	case 7:
+		intassign3 &= ~(INTASSIGN_MASK << 3);
+		intassign3 |= (uint16_t)assign << 3;
+		break;
+	case 8:
+		intassign3 &= ~(INTASSIGN_MASK << 6);
+		intassign3 |= (uint16_t)assign << 6;
+		break;
+	case 9:
+		intassign3 &= ~(INTASSIGN_MASK << 9);
+		intassign3 |= (uint16_t)assign << 9;
+		break;
+	case 10:
+		intassign3 &= ~(INTASSIGN_MASK << 12);
+		intassign3 |= (uint16_t)assign << 12;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sysint2_assign[pin] = assign;
+	write_icu1(intassign2, INTASSIGN2);
+	write_icu1(intassign3, INTASSIGN3);
+
+	spin_unlock_irq(&desc->lock);
+
+	return 0;
+}
+
+int vr41xx_set_intassign(unsigned int irq, unsigned char intassign)
+{
+	int retval = -EINVAL;
+
+	if (current_cpu_data.cputype != CPU_VR4133)
+		return -EINVAL;
+
+	if (intassign > INTASSIGN_MAX)
+		return -EINVAL;
+
+	if (irq >= SYSINT1_IRQ_BASE && irq <= SYSINT1_IRQ_LAST)
+		retval = set_sysint1_assign(irq, intassign);
+	else if (irq >= SYSINT2_IRQ_BASE && irq <= SYSINT2_IRQ_LAST)
+		retval = set_sysint2_assign(irq, intassign);
+
+	return retval;
 }
 
 /*=======================================================================*/
 
-static inline void giuint_irqdispatch(u16 pendl, u16 pendh, struct pt_regs *regs)
+static inline void giuint_irq_dispatch(uint16_t pendl, uint16_t pendh,
+                                       struct pt_regs *regs)
 {
 	int i;
 
 	if (pendl) {
 		for (i = 0; i < 16; i++) {
-			if (pendl & (0x0001 << i)) {
+			if (pendl & ((uint16_t)1 << i)) {
 				giuint_do_IRQ(i, regs);
 				return;
 			}
 		}
-	}
-	else if (pendh) {
+	} else {
 		for (i = 0; i < 16; i++) {
-			if (pendh & (0x0001 << i)) {
+			if (pendh & ((uint16_t)1 << i)) {
 				giuint_do_IRQ(i + 16, regs);
 				return;
 			}
@@ -362,10 +511,10 @@
 	}
 }
 
-asmlinkage void icu_irqdispatch(struct pt_regs *regs)
+asmlinkage void irq_dispatch(unsigned char intnum, struct pt_regs *regs)
 {
-	u16 pend1, pend2, pendl, pendh;
-	u16 mask1, mask2, maskl, maskh;
+	uint16_t pend1, pend2, pendl, pendh;
+	uint16_t mask1, mask2, maskl, maskh;
 	int i;
 
 	pend1 = read_icu1(SYSINT1REG);
@@ -380,31 +529,36 @@
 	pendh = read_icu2(GIUINTHREG);
 	maskh = read_icu2(MGIUINTHREG);
 
-	pend1 &= mask1;
-	pend2 &= mask2;
-	pendl &= maskl;
-	pendh &= maskh;
-
-	if (pend1) {
-		if ((pend1 & 0x01ff) == 0x0100) {
-			giuint_irqdispatch(pendl, pendh, regs);
-		}
-		else {
-			for (i = 0; i < 16; i++) {
-				if (pend1 & (0x0001 << i)) {
-					do_IRQ(SYSINT1_IRQ_BASE + i, regs);
-					break;
+	mask1 &= pend1;
+	mask2 &= pend2;
+	maskl &= pendl;
+	maskh &= pendh;
+
+	if (mask1) {
+		for (i = 0; i < 16; i++) {
+			if (intnum == sysint1_assign[i] &&
+			    (mask1 & ((uint16_t)1 << i))) {
+				if (i == 8 && (maskl | maskh)) {
+					giuint_irq_dispatch(maskl, maskh, regs);
+					return;
+				} else {
+					do_IRQ(SYSINT1_IRQ(i), regs);
+					return;
 				}
 			}
 		}
-		return;
 	}
-	else if (pend2) {
+
+	if (mask2) {
 		for (i = 0; i < 16; i++) {
-			if (pend2 & (0x0001 << i)) {
-				do_IRQ(SYSINT2_IRQ_BASE + i, regs);
-				break;
+			if (intnum == sysint2_assign[i] &&
+			    (mask2 & ((uint16_t)1 << i))) {
+				do_IRQ(SYSINT2_IRQ(i), regs);
+				return;
 			}
 		}
 	}
+
+	printk(KERN_ERR "spurious interrupt: %04x,%04x,%04x,%04x\n", pend1, pend2, pendl, pendh);
+	atomic_inc(&irq_err_count);
 }
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/int-handler.S linux/arch/mips/vr41xx/common/int-handler.S
--- linux.orig/arch/mips/vr41xx/common/int-handler.S	Mon Jul 15 08:47:57 2002
+++ linux/arch/mips/vr41xx/common/int-handler.S	Fri Dec  5 08:34:40 2003
@@ -34,6 +34,9 @@
  * Changes:
  *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
  *  - New creation, NEC VR4100 series are supported.
+ *
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  - Coped with INTASSIGN of NEC VR4133.
  */
 #include <asm/asm.h>
 #include <asm/regdef.h>
@@ -59,55 +62,52 @@
 		andi	t0, 0xff00
 		and	t0, t0, t1
 
-		andi	t1, t0, CAUSEF_IP7	# timer interrupt
-		beqz	t1, 1f
+		andi	t1, t0, CAUSEF_IP7	# MIPS timer interrupt
+		bnez	t1, handle_irq
 		li	a0, 7
-		jal	ll_timer_interrupt
-		move	a1, sp
-		j	ret_from_irq
 
-1:
-		andi	t1, t0, 0x7800		# check for IP3-6
-		beqz	t1, 2f
+		andi	t1, t0, 0x7800		# check for Int1-4
+		beqz	t1, 1f
 
-		andi	t1, t0, CAUSEF_IP3	# check for IP3
-		bnez	t1, handle_it
+		andi	t1, t0, CAUSEF_IP3	# check for Int1
+		bnez	t1, handle_int
+		li	a0, 1
+
+		andi	t1, t0, CAUSEF_IP4	# check for Int2
+		bnez	t1, handle_int
+		li	a0, 2
+
+		andi	t1, t0, CAUSEF_IP5	# check for Int3
+		bnez	t1, handle_int
 		li	a0, 3
 
-		andi	t1, t0, CAUSEF_IP4	# check for IP4
-		bnez	t1, handle_it
+		andi	t1, t0, CAUSEF_IP6	# check for Int4
+		bnez	t1, handle_int
 		li	a0, 4
 
-		andi	t1, t0, CAUSEF_IP5	# check for IP5
-		bnez	t1, handle_it
-		li	a0, 5
-
-		andi	t1, t0, CAUSEF_IP6	# check for IP6
-		bnez	t1, handle_it
-		li	a0, 6
-
-2:
-		andi	t1, t0, CAUSEF_IP2	# check for IP2
-		beqz	t1, 3f
-		move	a0, sp
-		jal	icu_irqdispatch
-		nop
-		j	ret_from_irq
-		nop
+1:
+		andi	t1, t0, CAUSEF_IP2	# check for Int0
+		bnez	t1, handle_int
+		li	a0, 0
 
-3:
 		andi	t1, t0, CAUSEF_IP0	# check for IP0
-		bnez	t1, handle_it
+		bnez	t1, handle_irq
 		li	a0, 0
 
 		andi	t1, t0, CAUSEF_IP1	# check for IP1
-		bnez	t1, handle_it
+		bnez	t1, handle_irq
 		li	a0, 1
 
 		j	spurious_interrupt
 		nop
 
-handle_it:
+handle_int:
+		jal	irq_dispatch
+		move	a1, sp
+		j	ret_from_irq
+		nop
+
+handle_irq:
 		jal	do_IRQ
 		move	a1, sp
 		j	ret_from_irq
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/ksyms.c linux/arch/mips/vr41xx/common/ksyms.c
--- linux.orig/arch/mips/vr41xx/common/ksyms.c	Tue Dec  2 04:32:01 2003
+++ linux/arch/mips/vr41xx/common/ksyms.c	Fri Dec  5 08:34:40 2003
@@ -25,6 +25,8 @@
 EXPORT_SYMBOL(vr41xx_get_vtclock_frequency);
 EXPORT_SYMBOL(vr41xx_get_tclock_frequency);
 
+EXPORT_SYMBOL(vr41xx_set_intassign);
+
 EXPORT_SYMBOL(vr41xx_set_rtclong1_cycle);
 EXPORT_SYMBOL(vr41xx_read_rtclong1_counter);
 EXPORT_SYMBOL(vr41xx_set_rtclong2_cycle);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/vrc4173.c linux/arch/mips/vr41xx/common/vrc4173.c
--- linux.orig/arch/mips/vr41xx/common/vrc4173.c	Tue Nov 18 12:34:22 2003
+++ linux/arch/mips/vr41xx/common/vrc4173.c	Fri Dec  5 08:34:40 2003
@@ -194,8 +194,8 @@
 	
 	vrc4173_outw(0, VRC4173_MSYSINT1REG);
 
-	vr41xx_set_irq_trigger(cascade_irq - GIU_IRQ(0), TRIGGER_LEVEL, SIGNAL_THROUGH);
-	vr41xx_set_irq_level(cascade_irq - GIU_IRQ(0), LEVEL_LOW);
+	vr41xx_set_irq_trigger(GIU_IRQ_TO_PIN(cascade_irq), TRIGGER_LEVEL, SIGNAL_THROUGH);
+	vr41xx_set_irq_level(GIU_IRQ_TO_PIN(cascade_irq), LEVEL_LOW);
 
 	for (i = VRC4173_IRQ_BASE; i <= VRC4173_IRQ_LAST; i++)
                 irq_desc[i].handler = &vrc4173_irq_type;
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux.orig/include/asm-mips/vr41xx/vr41xx.h	Wed Dec  3 01:39:09 2003
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Fri Dec  5 09:00:47 2003
@@ -39,7 +39,7 @@
 #define PRID_VR4131_REV2_1	0x00000c82
 #define PRID_VR4131_REV2_2	0x00000c83
 
-/* VR4131 0x00000c84- */
+/* VR4133 0x00000c84- */
 #define PRID_VR4133		0x00000c84
 
 /*
@@ -80,49 +80,57 @@
 #define MIPS_CPU_IRQ(x)		(MIPS_CPU_IRQ_BASE + (x))
 #define MIPS_SOFTINT0_IRQ	MIPS_CPU_IRQ(0)
 #define MIPS_SOFTINT1_IRQ	MIPS_CPU_IRQ(1)
-#define ICU_CASCADE_IRQ		MIPS_CPU_IRQ(2)
-#define RTC_LONG1_IRQ		MIPS_CPU_IRQ(3)
-#define RTC_LONG2_IRQ		MIPS_CPU_IRQ(4)
-/* RFU */
-#define BATTERY_IRQ		MIPS_CPU_IRQ(6)
+#define INT0_CASCADE_IRQ	MIPS_CPU_IRQ(2)
+#define INT1_CASCADE_IRQ	MIPS_CPU_IRQ(3)
+#define INT2_CASCADE_IRQ	MIPS_CPU_IRQ(4)
+#define INT3_CASCADE_IRQ	MIPS_CPU_IRQ(5)
+#define INT4_CASCADE_IRQ	MIPS_CPU_IRQ(6)
 #define MIPS_COUNTER_IRQ	MIPS_CPU_IRQ(7)
 
 /* SYINT1 Interrupt Numbers */
 #define SYSINT1_IRQ_BASE	8
 #define SYSINT1_IRQ(x)		(SYSINT1_IRQ_BASE + (x))
-/* RFU */
+#define BATTRY_IRQ		SYSINT1_IRQ(0)
 #define POWER_IRQ		SYSINT1_IRQ(1)
-/* RFU */
+#define RTCLONG1_IRQ		SYSINT1_IRQ(2)
 #define ELAPSEDTIME_IRQ		SYSINT1_IRQ(3)
 /* RFU */
+#define PIU_IRQ			SYSINT1_IRQ(5)
+#define AIU_IRQ			SYSINT1_IRQ(6)
+#define KIU_IRQ			SYSINT1_IRQ(7)
 #define GIUINT_CASCADE_IRQ	SYSINT1_IRQ(8)
 #define SIU_IRQ			SYSINT1_IRQ(9)
-/* RFU */
+#define BUSERR_IRQ		SYSINT1_IRQ(10)
 #define SOFTINT_IRQ		SYSINT1_IRQ(11)
 #define CLKRUN_IRQ		SYSINT1_IRQ(12)
-#define SYSINT1_IRQ_LAST	CLKRUN_IRQ
+#define DOZEPIU_IRQ		SYSINT1_IRQ(13)
+#define SYSINT1_IRQ_LAST	DOZEPIU_IRQ
 
 /* SYSINT2 Interrupt Numbers */
 #define SYSINT2_IRQ_BASE	24
 #define SYSINT2_IRQ(x)		(SYSINT2_IRQ_BASE + (x))
-/* RFU */
+#define RTCLONG2_IRQ		SYSINT2_IRQ(0)
 #define LED_IRQ			SYSINT2_IRQ(1)
-/* RFU */
-#define VTCLOCK_IRQ		SYSINT2_IRQ(3)
+#define HSP_IRQ			SYSINT2_IRQ(2)
+#define TCLOCK_IRQ		SYSINT2_IRQ(3)
 #define FIR_IRQ			SYSINT2_IRQ(4)
+#define CEU_IRQ			SYSINT2_IRQ(4)	/* same number as FIR_IRQ */
 #define DSIU_IRQ		SYSINT2_IRQ(5)
 #define PCI_IRQ			SYSINT2_IRQ(6)
 #define SCU_IRQ			SYSINT2_IRQ(7)
 #define CSI_IRQ			SYSINT2_IRQ(8)
 #define BCU_IRQ			SYSINT2_IRQ(9)
-#define SYSINT2_IRQ_LAST	BCU_IRQ
+#define ETHERNET_IRQ		SYSINT2_IRQ(10)
+#define SYSINT2_IRQ_LAST	ETHERNET_IRQ
 
 /* GIU Interrupt Numbers */
 #define GIU_IRQ_BASE		40
 #define GIU_IRQ(x)		(GIU_IRQ_BASE + (x))	/* IRQ 40-71 */
 #define GIU_IRQ_LAST		GIU_IRQ(31)
+#define GIU_IRQ_TO_PIN(x)	((x) - GIU_IRQ_BASE)	/* Pin 0-31 */
 
 extern void (*board_irq_init)(void);
+extern int vr41xx_set_intassign(unsigned int irq, unsigned char intassign);
 extern int vr41xx_cascade_irq(unsigned int irq, int (*get_irq_number)(int irq));
 
 /*
@@ -138,15 +146,13 @@
 extern uint32_t vr41xx_read_tclock_counter(void);
 
 /*
- * Gegeral-Purpose I/O Unit
+ * General-Purpose I/O Unit
  */
-extern void vr41xx_enable_giuint(int pin);
-extern void vr41xx_disable_giuint(int pin);
-extern void vr41xx_clear_giuint(int pin);
-
 enum {
 	TRIGGER_LEVEL,
-	TRIGGER_EDGE
+	TRIGGER_EDGE,
+	TRIGGER_EDGE_FALLING,
+	TRIGGER_EDGE_RISING
 };
 
 enum {

--Multipart=_Fri__5_Dec_2003_09_11_56_+0900_KHJQxu1i.qDXru1p--
