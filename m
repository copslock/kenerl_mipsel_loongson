Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 15:15:26 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:17874 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225202AbTDOOPZ>; Tue, 15 Apr 2003 15:15:25 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA15901;
	Tue, 15 Apr 2003 16:15:48 +0200 (MET DST)
Date: Tue, 15 Apr 2003 16:15:47 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: [patch] do_IRQ() and init_i8259_irqs() declarations
Message-ID: <Pine.GSO.3.96.1030415160755.13254G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Ralf,

 There is a number of private declarations of do_IRQ() and
init_i8259_irqs() scattered through the code.  These for do_IRQ() often
have a different "opinion" on how the function is interfaced... 

 The following patch puts public declarations in appropriate headers and
converts users of these functions to get the prototypes from there
instead.  It also removes various related unused declarations. 

 OK?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-pre4-20030414-do_irq-8259A-0
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/au1000/common/irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/au1000/common/irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/au1000/common/irq.c	2003-03-30 02:56:22.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/au1000/common/irq.c	2003-04-13 18:00:27.000000000 +0000
@@ -28,6 +28,7 @@
  */
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/signal.h>
@@ -96,7 +97,6 @@ static inline void mask_and_ack_fall_edg
 inline void local_enable_irq(unsigned int irq_nr);
 inline void local_disable_irq(unsigned int irq_nr);
 
-extern unsigned int do_IRQ(int irq, struct pt_regs *regs);
 extern void __init init_generic_irq(void);
 
 #ifdef CONFIG_PM
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/cobalt/irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/cobalt/irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/cobalt/irq.c	2002-12-04 03:56:24.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/cobalt/irq.c	2002-12-18 00:50:36.000000000 +0000
@@ -17,6 +17,7 @@
 #include <linux/ioport.h>
 
 #include <asm/bootinfo.h>
+#include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/mipsregs.h>
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/cobalt/via.c linux-mips-2.4.21-pre4-20030414/arch/mips/cobalt/via.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/cobalt/via.c	2003-03-10 03:56:27.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/cobalt/via.c	2003-04-13 18:01:57.000000000 +0000
@@ -10,6 +10,7 @@
  *
  */
 
+#include <linux/irq.h>
 #include <linux/kernel.h>
 
 #include <asm/gt64120.h>
@@ -18,8 +19,6 @@
 
 #include <asm/cobalt/cobalt.h>
 
-extern void do_IRQ(int irq, struct pt_regs * regs);
-
 asmlinkage void via_irq(struct pt_regs *regs)
 {
 	char mstat, sstat;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/ddb5xxx/ddb5074/irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/ddb5xxx/ddb5074/irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/ddb5xxx/ddb5074/irq.c	2003-02-27 03:56:30.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/ddb5xxx/ddb5074/irq.c	2003-04-13 18:00:29.000000000 +0000
@@ -6,14 +6,15 @@
  */
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 
+#include <asm/i8259.h>
 #include <asm/io.h>
-#include <asm/irq.h>
 #include <asm/irq_cpu.h>
 #include <asm/ptrace.h>
 #include <asm/nile4.h>
@@ -21,14 +22,7 @@
 #include <asm/ddb5xxx/ddb5074.h>
 
 
-extern void __init i8259_init(void);
-extern void init_i8259_irqs (void);
-extern void i8259_disable_irq(unsigned int irq_nr);
-extern void i8259_enable_irq(unsigned int irq_nr);
-
 extern asmlinkage void ddbIRQ(void);
-extern asmlinkage void i8259_do_irq(int irq, struct pt_regs *regs);
-extern asmlinkage void do_IRQ(int irq, struct pt_regs *regs);
 
 static struct irqaction irq_cascade = { no_action, 0, 0, "cascade", NULL, NULL };
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/ddb5xxx/ddb5476/irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/ddb5xxx/ddb5476/irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/ddb5xxx/ddb5476/irq.c	2002-08-06 02:57:07.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/ddb5xxx/ddb5476/irq.c	2002-12-18 00:55:01.000000000 +0000
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 
+#include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/ptrace.h>
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/ddb5xxx/ddb5476/vrc5476_irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/ddb5xxx/ddb5476/vrc5476_irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/ddb5xxx/ddb5476/vrc5476_irq.c	2002-08-06 02:57:07.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/ddb5xxx/ddb5476/vrc5476_irq.c	2002-12-19 17:49:53.000000000 +0000
@@ -12,6 +12,7 @@
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
 
@@ -81,7 +82,6 @@ vrc5476_irq_init(u32 base)
 asmlinkage void
 vrc5476_irq_dispatch(struct pt_regs *regs)
 {
-	extern unsigned int do_IRQ(int irq, struct pt_regs *regs);
 	extern void spurious_interrupt(void);
 
 	u32 mask;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/ddb5xxx/ddb5477/irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/ddb5xxx/ddb5477/irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/ddb5xxx/ddb5477/irq.c	2003-02-27 03:56:31.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/ddb5xxx/ddb5477/irq.c	2003-04-13 18:00:29.000000000 +0000
@@ -13,9 +13,11 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
 
+#include <asm/i8259.h>
 #include <asm/system.h>
 #include <asm/mipsregs.h>
 #include <asm/debug.h>
@@ -71,7 +73,6 @@ set_pci_int_attr(u32 pci, u32 intn, u32 
 	ddb_out32(pci, reg_value);
 }
 
-extern void init_i8259_irqs (void);
 extern void vrc5477_irq_init(u32 base);
 extern void mips_cpu_irq_init(u32 base);
 extern asmlinkage void ddb5477_handle_int(void);
@@ -164,8 +165,6 @@ u8 i8259_interrupt_ack(void)
 asmlinkage void
 vrc5477_irq_dispatch(struct pt_regs *regs)
 {
-	extern unsigned int do_IRQ(int irq, struct pt_regs *regs);
-
 	u32 intStatus;
 	u32 bitmask;
 	u32 i;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/galileo-boards/ev96100/irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/galileo-boards/ev96100/irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/galileo-boards/ev96100/irq.c	2002-12-04 03:56:25.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/galileo-boards/ev96100/irq.c	2002-12-19 17:55:31.000000000 +0000
@@ -32,6 +32,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -45,13 +46,10 @@
 #include <asm/bitops.h>
 #include <asm/bootinfo.h>
 #include <asm/io.h>
-#include <asm/irq.h>
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 #include <asm/galileo-boards/ev96100int.h>
 
-extern asmlinkage unsigned int do_IRQ(int irq, struct pt_regs *regs);
-
 extern void mips_timer_interrupt(int irq, struct pt_regs *regs);
 extern asmlinkage void ev96100IRQ(void);
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/ite-boards/generic/irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/ite-boards/generic/irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/ite-boards/generic/irq.c	2003-02-27 03:56:31.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/ite-boards/generic/irq.c	2003-04-13 18:00:29.000000000 +0000
@@ -36,6 +36,7 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/signal.h>
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/ite-boards/generic/time.c linux-mips-2.4.21-pre4-20030414/arch/mips/ite-boards/generic/time.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/ite-boards/generic/time.c	2003-03-26 03:56:34.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/ite-boards/generic/time.c	2003-04-13 18:00:29.000000000 +0000
@@ -37,7 +37,6 @@
 static unsigned long r4k_offset; /* Amount to increment compare reg each time */
 static unsigned long r4k_cur;    /* What counter should be at next timer irq */
 extern unsigned int mips_counter_frequency;
-extern asmlinkage unsigned int do_IRQ(int irq, struct pt_regs *regs);
 
 /*
  * Figure out the r4k offset, the amount to increment the compare
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/jazz/irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/jazz/irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/jazz/irq.c	2001-12-18 05:27:34.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/jazz/irq.c	2002-12-18 00:56:22.000000000 +0000
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 
+#include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/jazz.h>
 
@@ -19,7 +20,7 @@ extern asmlinkage void jazz_handle_int(v
 
 /*
  * On systems with i8259-style interrupt controllers we assume for
- * driver compatibility reasons interrupts 0 - 15 to be the i8295
+ * driver compatibility reasons interrupts 0 - 15 to be the i8259
  * interrupts even if the hardware uses a different interrupt numbering.
  */
 void __init init_IRQ (void)
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/jmr3927/rbhma3100/irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/jmr3927/rbhma3100/irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/jmr3927/rbhma3100/irq.c	2003-02-27 03:56:32.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/jmr3927/rbhma3100/irq.c	2003-04-13 18:00:29.000000000 +0000
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 
 #include <linux/errno.h>
+#include <linux/irq.h>
 #include <linux/kernel_stat.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -47,7 +48,6 @@
 
 #include <asm/bitops.h>
 #include <asm/io.h>
-#include <asm/irq.h>
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 
@@ -287,7 +287,6 @@ void jmr3927_spurious(struct pt_regs *re
 	       regs->cp0_cause, regs->cp0_epc, regs->regs[31]);
 }
 
-extern asmlinkage void do_IRQ(int irq, struct pt_regs *regs);
 void jmr3927_irc_irqdispatch(struct pt_regs *regs)
 {
 	int irq;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/kernel/i8259.c linux-mips-2.4.21-pre4-20030414/arch/mips/kernel/i8259.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/kernel/i8259.c	2002-08-06 02:57:16.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/kernel/i8259.c	2003-04-14 21:45:14.000000000 +0000
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 
+#include <asm/i8259.h>
 #include <asm/io.h>
 
 void enable_8259A_irq(unsigned int irq);
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/lasat/interrupt.c linux-mips-2.4.21-pre4-20030414/arch/mips/lasat/interrupt.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/lasat/interrupt.c	2003-02-25 03:56:37.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/lasat/interrupt.c	2003-04-13 18:00:29.000000000 +0000
@@ -40,7 +40,6 @@ static volatile int *lasat_int_mask = NU
 static volatile int lasat_int_mask_shift;
 
 extern asmlinkage void mipsIRQ(void);
-extern void do_IRQ(int irq, struct pt_regs *regs);
 
 #if 0
 #define DEBUG_INT(x...) printk(x)
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/mips-boards/atlas/atlas_int.c linux-mips-2.4.21-pre4-20030414/arch/mips/mips-boards/atlas/atlas_int.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/mips-boards/atlas/atlas_int.c	2003-02-27 03:56:32.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/mips-boards/atlas/atlas_int.c	2003-04-13 18:00:29.000000000 +0000
@@ -40,7 +40,6 @@ struct atlas_ictrl_regs *atlas_hw0_icreg
 	= (struct atlas_ictrl_regs *)ATLAS_ICTRL_REGS_BASE;
 
 extern asmlinkage void mipsIRQ(void);
-extern void do_IRQ(int irq, struct pt_regs *regs);
 
 #if 0
 #define DEBUG_INT(x...) printk(x)
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/mips-boards/malta/malta_int.c linux-mips-2.4.21-pre4-20030414/arch/mips/mips-boards/malta/malta_int.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/mips-boards/malta/malta_int.c	2003-02-27 03:56:32.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/mips-boards/malta/malta_int.c	2003-04-13 18:00:29.000000000 +0000
@@ -23,13 +23,14 @@
  */
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/random.h>
 
-#include <asm/irq.h>
+#include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/mips-boards/malta.h>
 #include <asm/mips-boards/maltaint.h>
@@ -39,8 +40,6 @@
 #include <asm/mips-boards/msc01_pci.h>
 
 extern asmlinkage void mipsIRQ(void);
-extern asmlinkage void do_IRQ(int irq, struct pt_regs *regs);
-extern void init_i8259_irqs (void);
 extern int mips_pcibios_iack(void);
 
 #ifdef CONFIG_KGDB
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/mips-boards/sead/sead_int.c linux-mips-2.4.21-pre4-20030414/arch/mips/mips-boards/sead/sead_int.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/mips-boards/sead/sead_int.c	2002-12-04 03:56:36.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/mips-boards/sead/sead_int.c	2002-12-19 17:58:58.000000000 +0000
@@ -25,17 +25,16 @@
  */
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 
-#include <asm/irq.h>
 #include <asm/mips-boards/sead.h>
 #include <asm/mips-boards/seadint.h>
 
 extern asmlinkage void mipsIRQ(void);
-extern void do_IRQ(int irq, struct pt_regs *regs);
 
 void disable_sead_irq(unsigned int irq_nr)
 {
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/momentum/ocelot_c/cpci-irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/momentum/ocelot_c/cpci-irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/momentum/ocelot_c/cpci-irq.c	2002-11-11 23:05:46.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/momentum/ocelot_c/cpci-irq.c	2002-12-19 17:59:28.000000000 +0000
@@ -19,17 +19,15 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <asm/ptrace.h>
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <asm/io.h>
-#include <asm/irq.h>
 #include "ocelot_c_fpga.h"
 
-extern unsigned int do_IRQ(int irq, struct pt_regs *regs);
-
 #define CPCI_IRQ_BASE	8
 
 static inline int ls1bit8(unsigned int x)
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/momentum/ocelot_c/mv-irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/momentum/ocelot_c/mv-irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/momentum/ocelot_c/mv-irq.c	2002-11-11 23:05:46.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/momentum/ocelot_c/mv-irq.c	2002-12-19 17:59:55.000000000 +0000
@@ -14,17 +14,15 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <asm/ptrace.h>
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <asm/io.h>
-#include <asm/irq.h>
 #include <asm/mv64340.h>
 
-extern unsigned int do_IRQ(int irq, struct pt_regs *regs);
-
 #define MV64340_IRQ_BASE	16
 
 static inline int ls1bit32(unsigned int x)
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/momentum/ocelot_c/uart-irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/momentum/ocelot_c/uart-irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/momentum/ocelot_c/uart-irq.c	2002-11-11 23:05:46.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/momentum/ocelot_c/uart-irq.c	2002-12-19 18:00:27.000000000 +0000
@@ -14,6 +14,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <asm/ptrace.h>
 #include <linux/config.h>
@@ -23,8 +24,6 @@
 #include <asm/irq.h>
 #include "ocelot_c_fpga.h"
 
-extern unsigned int do_IRQ(int irq, struct pt_regs *regs);
-
 static inline int ls1bit8(unsigned int x)
 {
         int b = 7, s;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/philips/nino/irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/philips/nino/irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/philips/nino/irq.c	2003-02-27 03:56:43.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/philips/nino/irq.c	2003-04-13 18:00:29.000000000 +0000
@@ -11,6 +11,7 @@
  */
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <asm/io.h>
@@ -19,8 +20,6 @@
 
 #define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
 
-extern asmlinkage void do_IRQ(int irq, struct pt_regs *regs);
-
 static void enable_irq6(unsigned int irq)
 {
 	if(irq == 0) {
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/sgi-ip22/ip22-eisa.c linux-mips-2.4.21-pre4-20030414/arch/mips/sgi-ip22/ip22-eisa.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/sgi-ip22/ip22-eisa.c	2003-03-20 03:56:31.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/sgi-ip22/ip22-eisa.c	2003-04-13 18:02:59.000000000 +0000
@@ -22,6 +22,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/kernel_stat.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -35,8 +36,6 @@
 #include <asm/sgi/mc.h>
 #include <asm/sgi/ip22.h>
 
-extern void do_IRQ(int irq, struct pt_regs *regs);
-
 #define EISA_MAX_SLOTS		  4
 #define EISA_MAX_IRQ             16
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/sgi-ip22/ip22-int.c linux-mips-2.4.21-pre4-20030414/arch/mips/sgi-ip22/ip22-int.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/sgi-ip22/ip22-int.c	2003-03-25 03:56:42.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/sgi-ip22/ip22-int.c	2003-04-13 18:03:28.000000000 +0000
@@ -36,7 +36,6 @@ static char lc2msk_to_irqnr[256];
 static char lc3msk_to_irqnr[256];
 
 extern asmlinkage void indyIRQ(void);
-extern void do_IRQ(int irq, struct pt_regs *regs);
 extern int ip22_eisa_init(void);
 
 static void enable_local0_irq(unsigned int irq)
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/sgi-ip27/ip27-irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/sgi-ip27/ip27-irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/sgi-ip27/ip27-irq.c	2002-08-06 02:57:33.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/sgi-ip27/ip27-irq.c	2002-12-19 18:02:29.000000000 +0000
@@ -7,6 +7,7 @@
  */
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -25,7 +26,6 @@
 #include <asm/io.h>
 #include <asm/mipsregs.h>
 #include <asm/system.h>
-#include <asm/irq.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -68,7 +68,6 @@ unsigned char num_bridges;	/* number of 
  */
 
 extern asmlinkage void ip27_irq(void);
-extern void do_IRQ(int irq, struct pt_regs *regs);
 
 extern int irq_to_bus[], irq_to_slot[], bus_to_cpu[];
 int intr_connect_level(int cpu, int bit);
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/sgi-ip32/ip32-irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/sgi-ip32/ip32-irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/sgi-ip32/ip32-irq.c	2002-12-04 03:56:38.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/sgi-ip32/ip32-irq.c	2002-12-19 18:04:05.000000000 +0000
@@ -12,6 +12,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -115,7 +116,6 @@ struct irqaction cpuerr_irq = { crime_cp
 			       NULL };
 
 extern void ip32_handle_int (void);
-asmlinkage unsigned int do_IRQ(int irq, struct pt_regs *regs);
 
 /*
  * For interrupts wired from a single device to the CPU.  Only the clock
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/sni/irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/sni/irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/sni/irq.c	2001-12-18 05:27:36.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/sni/irq.c	2002-12-19 18:04:24.000000000 +0000
@@ -9,16 +9,17 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 
+#include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/sni.h>
 
 spinlock_t pciasic_lock = SPIN_LOCK_UNLOCKED;
 
 extern asmlinkage void sni_rm200_pci_handle_int(void);
-extern void do_IRQ(int irq, struct pt_regs *regs);
 
 static void enable_pciasic_irq(unsigned int irq);
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c linux-mips-2.4.21-pre4-20030414/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2003-04-11 17:26:20.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2003-04-14 21:46:58.000000000 +0000
@@ -670,7 +670,6 @@ static void toshiba_rbtx4927_irq_isa_end
 void __init init_IRQ(void)
 {
 	extern void tx4927_irq_init(void);
-	extern void init_i8259_irqs(void);
 
 	cli();
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/vr41xx/common/giu.c linux-mips-2.4.21-pre4-20030414/arch/mips/vr41xx/common/giu.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/vr41xx/common/giu.c	2003-04-07 02:56:30.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/vr41xx/common/giu.c	2003-04-13 18:00:30.000000000 +0000
@@ -211,8 +211,6 @@ int vr41xx_cascade_irq(unsigned int irq,
 	return retval;
 }
 
-extern unsigned int do_IRQ(int irq, struct pt_regs *regs);
-
 unsigned int giuint_do_IRQ(int pin, struct pt_regs *regs)
 {
 	struct vr41xx_giuint_cascade *cascade;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/vr41xx/common/icu.c linux-mips-2.4.21-pre4-20030414/arch/mips/vr41xx/common/icu.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/vr41xx/common/icu.c	2003-04-07 02:56:30.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/vr41xx/common/icu.c	2003-04-13 18:00:30.000000000 +0000
@@ -58,7 +58,6 @@ extern asmlinkage void vr41xx_handle_int
 
 extern void __init init_generic_irq(void);
 extern void mips_cpu_irq_init(u32 irq_base);
-extern unsigned int do_IRQ(int irq, struct pt_regs *regs);
 
 extern void vr41xx_giuint_init(void);
 extern unsigned int giuint_do_IRQ(int pin, struct pt_regs *regs);
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips64/kernel/i8259.c linux-mips-2.4.21-pre4-20030414/arch/mips64/kernel/i8259.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips64/kernel/i8259.c	2002-08-06 02:57:35.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips64/kernel/i8259.c	2003-04-14 21:45:24.000000000 +0000
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 
+#include <asm/i8259.h>
 #include <asm/io.h>
 
 void enable_8259A_irq(unsigned int irq);
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/include/asm-mips/i8259.h linux-mips-2.4.21-pre4-20030414/include/asm-mips/i8259.h
--- linux-mips-2.4.21-pre4-20030414.macro/include/asm-mips/i8259.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/include/asm-mips/i8259.h	2002-12-21 11:17:35.000000000 +0000
@@ -0,0 +1,23 @@
+/*
+ *	include/asm-mips/i8259.h
+ *
+ *	i8259A interrupt definitions.
+ *
+ *	Copyright (C) 2003  Maciej W. Rozycki
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+#ifndef __ASM_MIPS_I8259_H
+#define __ASM_MIPS_I8259_H
+
+#include <linux/spinlock.h>
+
+#include <asm/io.h>
+#include <asm/system.h>
+
+extern void init_i8259_irqs(void);
+
+#endif /* __ASM_MIPS_I8259_H */
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/include/asm-mips/irq.h linux-mips-2.4.21-pre4-20030414/include/asm-mips/irq.h
--- linux-mips-2.4.21-pre4-20030414.macro/include/asm-mips/irq.h	2002-12-16 04:19:56.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/include/asm-mips/irq.h	2002-12-21 11:16:52.000000000 +0000
@@ -12,6 +12,7 @@
 #define _ASM_IRQ_H
 
 #include <linux/config.h>
+#include <linux/linkage.h>
 
 #define NR_IRQS 128		/* Largest number of ints of all machines.  */
 
@@ -24,13 +25,13 @@ static inline int irq_cannonicalize(int 
 #define irq_cannonicalize(irq) (irq)	/* Sane hardware, sane code ... */
 #endif
 
-struct irqaction;
-extern int i8259_setup_irq(int irq, struct irqaction * new);
-
 extern void disable_irq(unsigned int);
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
 
+struct pt_regs;
+extern asmlinkage unsigned int do_IRQ(int irq, struct pt_regs *regs);
+
 /* Machine specific interrupt initialization  */
 extern void (*irq_setup)(void);
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/include/asm-mips64/i8259.h linux-mips-2.4.21-pre4-20030414/include/asm-mips64/i8259.h
--- linux-mips-2.4.21-pre4-20030414.macro/include/asm-mips64/i8259.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/include/asm-mips64/i8259.h	2002-12-21 11:17:43.000000000 +0000
@@ -0,0 +1,23 @@
+/*
+ *	include/asm-mips/i8259.h
+ *
+ *	i8259A interrupt definitions.
+ *
+ *	Copyright (C) 2003  Maciej W. Rozycki
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+#ifndef __ASM_MIPS64_I8259_H
+#define __ASM_MIPS64_I8259_H
+
+#include <linux/spinlock.h>
+
+#include <asm/io.h>
+#include <asm/system.h>
+
+extern void init_i8259_irqs(void);
+
+#endif /* __ASM_MIPS64_I8259_H */
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/include/asm-mips64/irq.h linux-mips-2.4.21-pre4-20030414/include/asm-mips64/irq.h
--- linux-mips-2.4.21-pre4-20030414.macro/include/asm-mips64/irq.h	2003-01-27 00:04:58.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/include/asm-mips64/irq.h	2003-04-13 18:00:30.000000000 +0000
@@ -12,6 +12,7 @@
 #define _ASM_IRQ_H
 
 #include <linux/config.h>
+#include <linux/linkage.h>
 #include <asm/sn/arch.h>
 
 #define NR_IRQS 256
@@ -42,13 +43,13 @@ static inline int irq_cannonicalize(int 
 #define irq_cannonicalize(irq) (irq)	/* Sane hardware, sane code ... */
 #endif
 
-struct irqaction;
-extern int i8259_setup_irq(int irq, struct irqaction * new);
-
 extern void disable_irq(unsigned int);
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
 
+struct pt_regs;
+extern asmlinkage unsigned int do_IRQ(int irq, struct pt_regs *regs);
+
 /* Machine specific interrupt initialization  */
 extern void (*irq_setup)(void);
 
