Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2004 16:19:35 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:12993 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225343AbUBJQTf>; Tue, 10 Feb 2004 16:19:35 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 740E74C3D6; Tue, 10 Feb 2004 17:19:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 5DDD44C175; Tue, 10 Feb 2004 17:19:33 +0100 (CET)
Date: Tue, 10 Feb 2004 17:19:33 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] irq_cpu.c clean-ups
Message-ID: <Pine.LNX.4.55.0402101716130.6769@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Ralf,

 The two copies of irq_cpu.c should both in theory and in practice be the 
same, but for some reason they are not.  Here's a patch for 2.4 to bring 
them to sync.  The next step would be a trivial update for 2.6 to make 
that version the same as these two as well.

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.24-pre2-20040116-irq_cpu-0
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/irq_cpu.c linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/irq_cpu.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/irq_cpu.c	2003-02-05 03:56:38.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/irq_cpu.c	2004-02-09 22:33:17.000000000 +0000
@@ -2,6 +2,8 @@
  * Copyright 2001 MontaVista Software Inc.
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
  *
+ * Copyright (C) 2001 Ralf Baechle
+ *
  * This file define the irq handler for MIPS CPU interrupts.
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -13,9 +15,12 @@
 /*
  * Almost all MIPS CPUs define 8 interrupt sources.  They are typically
  * level triggered (i.e., cannot be cleared from CPU; must be cleared from
- * device).  The first two are software interrupts.  The last one is
- * usually the CPU timer interrupt if counter register is present or, for
- * CPUs with an external FPU, by convention it's the FPU exception interrupt.
+ * device).  The first two are software interrupts which we don't really
+ * use or support.  The last one is usually the CPU timer interrupt if
+ * counter register is present or, for CPUs with an external FPU, by
+ * convention it's the FPU exception interrupt.
+ *
+ * Don't even think about using this on SMP.  You have been warned.
  *
  * This file exports one global function:
  *	void mips_cpu_irq_init(int irq_base);
@@ -26,18 +31,37 @@
 
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
+#include <asm/system.h>
+
+static int mips_cpu_irq_base;
+
+static inline void unmask_mips_irq(unsigned int irq)
+{
+	clear_c0_cause(0x100 << (irq - mips_cpu_irq_base));
+	set_c0_status(0x100 << (irq - mips_cpu_irq_base));
+}
 
-static int mips_cpu_irq_base = -1;
+static inline void mask_mips_irq(unsigned int irq)
+{
+	clear_c0_status(0x100 << (irq - mips_cpu_irq_base));
+}
 
-static void mips_cpu_irq_enable(unsigned int irq)
+static inline void mips_cpu_irq_enable(unsigned int irq)
 {
-	clear_c0_cause( 1 << (irq - mips_cpu_irq_base + 8));
-	set_c0_status(1 << (irq - mips_cpu_irq_base + 8));
+	unsigned long flags;
+
+	local_irq_save(flags);
+	unmask_mips_irq(irq);
+	local_irq_restore(flags);
 }
 
 static void mips_cpu_irq_disable(unsigned int irq)
 {
-	clear_c0_status(1 << (irq - mips_cpu_irq_base + 8));
+	unsigned long flags;
+
+	local_irq_save(flags);
+	mask_mips_irq(irq);
+	local_irq_restore(flags);
 }
 
 static unsigned int mips_cpu_irq_startup(unsigned int irq)
@@ -49,21 +73,22 @@ static unsigned int mips_cpu_irq_startup
 
 #define	mips_cpu_irq_shutdown	mips_cpu_irq_disable
 
+/*
+ * While we ack the interrupt interrupts are disabled and thus we don't need
+ * to deal with concurrency issues.  Same for mips_cpu_irq_end.
+ */
 static void mips_cpu_irq_ack(unsigned int irq)
 {
-	/* although we attempt to clear the IP bit in cause register, I think
-	 * usually it is cleared by device (irq source)
-	 */
-	clear_c0_cause(1 << (irq - mips_cpu_irq_base + 8));
+	/* Only necessary for soft interrupts */
+	clear_c0_cause(0x100 << (irq - mips_cpu_irq_base));
 
-	/* disable this interrupt - so that we safe proceed to the handler */
-	mips_cpu_irq_disable(irq);
+	mask_mips_irq(irq);
 }
 
 static void mips_cpu_irq_end(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		mips_cpu_irq_enable(irq);
+		unmask_mips_irq(irq);
 }
 
 static hw_irq_controller mips_cpu_irq_controller = {
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/irq_cpu.c linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/irq_cpu.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/irq_cpu.c	2002-12-04 03:56:39.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/irq_cpu.c	2004-02-09 22:33:36.000000000 +0000
@@ -16,18 +16,20 @@
  * Almost all MIPS CPUs define 8 interrupt sources.  They are typically
  * level triggered (i.e., cannot be cleared from CPU; must be cleared from
  * device).  The first two are software interrupts which we don't really
- * use or support.  The last one is usually cpu timer interrupt if a counter
- * register is present.
+ * use or support.  The last one is usually the CPU timer interrupt if
+ * counter register is present or, for CPUs with an external FPU, by
+ * convention it's the FPU exception interrupt.
  *
  * Don't even think about using this on SMP.  You have been warned.
  *
  * This file exports one global function:
- *	mips_cpu_irq_init(u32 irq_base);
+ *	void mips_cpu_irq_init(int irq_base);
  */
+#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/types.h>
 #include <linux/kernel.h>
 
+#include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 
@@ -78,7 +80,7 @@ static unsigned int mips_cpu_irq_startup
 static void mips_cpu_irq_ack(unsigned int irq)
 {
 	/* Only necessary for soft interrupts */
-	clear_c0_cause(1 << (irq - mips_cpu_irq_base + 8));
+	clear_c0_cause(0x100 << (irq - mips_cpu_irq_base));
 
 	mask_mips_irq(irq);
 }
@@ -90,7 +92,7 @@ static void mips_cpu_irq_end(unsigned in
 }
 
 static hw_irq_controller mips_cpu_irq_controller = {
-	"CPU_irq",
+	"MIPS",
 	mips_cpu_irq_startup,
 	mips_cpu_irq_shutdown,
 	mips_cpu_irq_enable,
@@ -101,9 +103,9 @@ static hw_irq_controller mips_cpu_irq_co
 };
 
 
-void mips_cpu_irq_init(u32 irq_base)
+void __init mips_cpu_irq_init(int irq_base)
 {
-	u32 i;
+	int i;
 
 	for (i = irq_base; i < irq_base + 8; i++) {
 		irq_desc[i].status = IRQ_DISABLED;
