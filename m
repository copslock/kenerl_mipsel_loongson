Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Dec 2002 23:09:16 +0000 (GMT)
Received: from gateway-1237.mvista.com ([12.44.186.158]:14587 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225290AbSLMXJP>;
	Fri, 13 Dec 2002 23:09:15 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBDN8rR13713;
	Fri, 13 Dec 2002 15:08:53 -0800
Date: Fri, 13 Dec 2002 15:08:53 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] add dispatch_i8259_irq() to i8259.c
Message-ID: <20021213150853.F22731@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


If a machine uses i8259 as part of its interrupt routing subsystem,
it typically has two ways to figure out which i8259 interrupt has 
happened.

1) through PCI interrupt ack cycle to directly read the IRQ number
2) read i8259 interrupt status registers and figure which one has
   happened.

This patch adds support for those sorry boards which only have
option 2) available.

While I am here, I also promoted do_IRQ() declaration to a 
header file, as it is needed by all C-level interrupt dispatching
code.

Any feedbacks? 

Jun

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk

--- ./arch/mips64/kernel/i8259.c.orig	Mon Aug  5 16:53:33 2002
+++ ./arch/mips64/kernel/i8259.c	Fri Dec 13 14:54:09 2002
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
+#include <linux/bitops.h>
 
 #include <asm/io.h>
 
@@ -219,6 +220,26 @@
 	}
 }
 
+asmlinkage void dispatch_i8259_irq(struct pt_regs *regs)
+{
+	int isr, irq=-1;
+
+	isr = ~(int)inb(0x20) | cached_21;
+	if (isr != -1) 
+		irq = ffz (isr);
+	if (irq == 2) {
+		isr = ~(int)inb(0xa0) | cached_A1;
+		if (isr != -1) 
+			irq = 8 + ffz(isr);
+	}
+	if (irq == -1) {
+		printk("We got a spurious i8259 interrupt\n");
+		atomic_inc(&irq_err_count);
+	} else {
+		do_IRQ(irq,regs);
+	}
+}
+
 void __init init_8259A(int auto_eoi)
 {
 	unsigned long flags;
diff -Nru ./include/asm-mips64/irq.h.orig ./include/asm-mips/irq.h
--- ./include/asm-mips64/irq.h.orig	Fri Dec 13 10:51:25 2002
+++ ./include/asm-mips64/irq.h	Fri Dec 13 14:50:46 2002
@@ -12,6 +12,7 @@
 #define _ASM_IRQ_H
 
 #include <linux/config.h>
+#include <linux/linkage.h>
 
 #define NR_IRQS 128		/* Largest number of ints of all machines.  */
 
@@ -36,4 +37,6 @@
 
 extern void init_generic_irq(void);
 
+extern asmlinkage unsigned int do_IRQ(int irq, struct pt_regs *regs);
+
 #endif /* _ASM_IRQ_H */

--qMm9M+Fa2AknHoGS--
