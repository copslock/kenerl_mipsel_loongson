Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 16:14:14 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:55242 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225329AbSLRQON>; Wed, 18 Dec 2002 16:14:13 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA08747;
	Wed, 18 Dec 2002 17:14:20 +0100 (MET)
Date: Wed, 18 Dec 2002 17:14:19 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
In-Reply-To: <20021217134011.M11575@mvista.com>
Message-ID: <Pine.GSO.3.96.1021217224740.7289I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Dec 2002, Jun Sun wrote:

> > > No MIPS boards are using do_slow_gettimeoffset().  We really should get
> > > rid of it.
> > 
> >  I know none does at the moment.  But are you sure there is no system that
> > would need it and might be supported one day?
> 
> I serisouly don't think so.  Moving forward every CPU will have a CPU counter,
> which can be used for timeoffset purpose.  Even if it does not have one,
> it will surely have some onboard high resolution timer, which can be used
> to intra-jiffy offset purpose.

 Well, I do hope so, too, but you'll never know until you find out. ;-)

> >  Here is an example (untested) code that I would recommend.  It sends
> > explicit ACKs to the i8259As, which has the following advantages:
> > 
> <snip>
> 
> Cool.  This code works for me.

 Excellent.  I worked on the code a bit more and removed the spurious IRQ
stuff.  It's not really necessary -- mask_and_ack_8259A() will deal with
it anyway (a bit less precisely, but we don't care -- they are very rare
and drivers absolutely have to be able to deal with spurious interrupts)
and we want the low-level IRQ handling to be fast as it's performance
critical.  At this point the function became so compact it would be
unreasonable not to make it inline -- the generated code is 24
instructions on my system.  The positive side effect is the code won't be
compiled for systems that don't use it.

 Following is a patch that I consider a candidate for submission.  I
changed the interface a bit to permit greater flexibility.  I renamed the
function to reflect the new semantic.  Unless special handling is needed
you may simply call: 

do_IRQ(poll_8259A_irq(), regs);

> I studied it a little bit and I am convinced it is a better choice.
> It should work for MIPS in general.

 Actually for any system that doesn't send hardware INTAs to i8259A PICs.

> In my original code I did verify that the IRR bit is not cleared,
> which apparently will be a problem in cases.

 The real problem is sources of edge-triggered interrupts need not
deassert their IRQs until they want to trigger another interrupt.  The
i8254 is a notorius example. 

> The only catch with your code is that we don't have iob() macro (which 
> apparently is very useful).  Any suggestions on this?  Otherwise  
> I will probably remove it.

 iob() comes from <asm/system.h> -- do you miss it somehow?  Unfortunately
its drawback is it uses a memory clobber which for this specific example
costs 4 unnecessary instructions (or 20%) to reread mips_io_port_base
twice. 

 The following patch was successfully tested at the run time on a Malta
system (after replacing most of the junk from
mips/mips-boards/malta/malta_int.c with the single-liner shown above).
Apart from adding the function to ACK i8259A IRQs, it cleans up the i8259A
stuff a bit:

- private init_i8259_irqs() declarations scattered over the tree are
removed and files referring to it now include <asm/i8259.h>,

- declarations of obsolete, non-existent i8259A handling functions are
removed.

Note the i8259A_lock is now extern for poll_8259A_irq() but not declared
in <asm/i8259.h> publicly as it shouldn't be used elsewhere. 

 Ralf, is it OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-pre6-20021212-poll-8259A-4
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips/cobalt/irq.c linux-mips-2.4.20-pre6-20021212/arch/mips/cobalt/irq.c
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips/cobalt/irq.c	2002-12-04 03:56:24.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips/cobalt/irq.c	2002-12-18 00:50:36.000000000 +0000
@@ -17,6 +17,7 @@
 #include <linux/ioport.h>
 
 #include <asm/bootinfo.h>
+#include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/mipsregs.h>
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips/ddb5xxx/ddb5074/irq.c linux-mips-2.4.20-pre6-20021212/arch/mips/ddb5xxx/ddb5074/irq.c
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips/ddb5xxx/ddb5074/irq.c	2002-08-06 02:57:07.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips/ddb5xxx/ddb5074/irq.c	2002-12-18 00:54:16.000000000 +0000
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 
+#include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/irq_cpu.h>
@@ -21,13 +22,7 @@
 #include <asm/ddb5xxx/ddb5074.h>
 
 
-extern void __init i8259_init(void);
-extern void init_i8259_irqs (void);
-extern void i8259_disable_irq(unsigned int irq_nr);
-extern void i8259_enable_irq(unsigned int irq_nr);
-
 extern asmlinkage void ddbIRQ(void);
-extern asmlinkage void i8259_do_irq(int irq, struct pt_regs *regs);
 extern asmlinkage void do_IRQ(int irq, struct pt_regs *regs);
 
 static struct irqaction irq_cascade = { no_action, 0, 0, "cascade", NULL, NULL };
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips/ddb5xxx/ddb5476/irq.c linux-mips-2.4.20-pre6-20021212/arch/mips/ddb5xxx/ddb5476/irq.c
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips/ddb5xxx/ddb5476/irq.c	2002-08-06 02:57:07.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips/ddb5xxx/ddb5476/irq.c	2002-12-18 00:55:01.000000000 +0000
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 
+#include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/ptrace.h>
 
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips/ddb5xxx/ddb5477/irq.c linux-mips-2.4.20-pre6-20021212/arch/mips/ddb5xxx/ddb5477/irq.c
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips/ddb5xxx/ddb5477/irq.c	2002-12-04 03:56:25.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips/ddb5xxx/ddb5477/irq.c	2002-12-18 00:55:53.000000000 +0000
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/ptrace.h>
 
+#include <asm/i8259.h>
 #include <asm/system.h>
 #include <asm/mipsregs.h>
 #include <asm/debug.h>
@@ -71,7 +72,6 @@ set_pci_int_attr(u32 pci, u32 intn, u32 
 	ddb_out32(pci, reg_value);
 }
 
-extern void init_i8259_irqs (void);
 extern void vrc5477_irq_init(u32 base);
 extern void mips_cpu_irq_init(u32 base);
 extern asmlinkage void ddb5477_handle_int(void);
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips/jazz/irq.c linux-mips-2.4.20-pre6-20021212/arch/mips/jazz/irq.c
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips/jazz/irq.c	2001-12-18 05:27:34.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips/jazz/irq.c	2002-12-18 00:56:22.000000000 +0000
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
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips/kernel/i8259.c linux-mips-2.4.20-pre6-20021212/arch/mips/kernel/i8259.c
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips/kernel/i8259.c	2002-08-06 02:57:16.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips/kernel/i8259.c	2002-12-17 23:18:16.000000000 +0000
@@ -29,7 +29,7 @@ void disable_8259A_irq(unsigned int irq)
  * moves to arch independent land
  */
 
-static spinlock_t i8259A_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t i8259A_lock = SPIN_LOCK_UNLOCKED;
 
 static void end_8259A_irq (unsigned int irq)
 {
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips/mips-boards/malta/malta_int.c linux-mips-2.4.20-pre6-20021212/arch/mips/mips-boards/malta/malta_int.c
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips/mips-boards/malta/malta_int.c	2002-12-12 03:56:34.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips/mips-boards/malta/malta_int.c	2002-12-18 00:57:12.000000000 +0000
@@ -29,6 +29,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/random.h>
 
+#include <asm/i8259.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/mips-boards/malta.h>
@@ -40,7 +41,6 @@
 
 extern asmlinkage void mipsIRQ(void);
 extern asmlinkage void do_IRQ(int irq, struct pt_regs *regs);
-extern void init_i8259_irqs (void);
 extern int mips_pcibios_iack(void);
 
 static spinlock_t mips_irq_lock = SPIN_LOCK_UNLOCKED;
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips/sni/irq.c linux-mips-2.4.20-pre6-20021212/arch/mips/sni/irq.c
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips/sni/irq.c	2001-12-18 05:27:36.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips/sni/irq.c	2002-12-18 00:58:13.000000000 +0000
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 
+#include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/sni.h>
 
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips64/kernel/i8259.c linux-mips-2.4.20-pre6-20021212/arch/mips64/kernel/i8259.c
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips64/kernel/i8259.c	2002-08-06 02:57:35.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips64/kernel/i8259.c	2002-12-18 01:03:29.000000000 +0000
@@ -29,7 +29,7 @@ void disable_8259A_irq(unsigned int irq)
  * moves to arch independent land
  */
 
-static spinlock_t i8259A_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t i8259A_lock = SPIN_LOCK_UNLOCKED;
 
 static void end_8259A_irq (unsigned int irq)
 {
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/include/asm-mips/i8259.h linux-mips-2.4.20-pre6-20021212/include/asm-mips/i8259.h
--- linux-mips-2.4.20-pre6-20021212.macro/include/asm-mips/i8259.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/include/asm-mips/i8259.h	2002-12-18 00:31:40.000000000 +0000
@@ -0,0 +1,54 @@
+/*
+ *	include/asm-mips/i8259.h
+ *
+ *	i8259A interrupt definitions.
+ *
+ *	Copyright (C) 2002  Maciej W. Rozycki
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
+/*
+ * Ack an i8259A IRQ for systems that don't use hardware INTA cycles.
+ *
+ * Note we intentionally ignore the "I" (valid) bit reported by the
+ * controllers and pass spurious IRQs as real ones, since they are
+ * rare so the overhead is small and they will be handled later by 
+ * mask_and_ack_8259A() anyway.
+ */
+static inline int poll_8259A_irq(void)
+{
+	extern spinlock_t i8259A_lock;
+	int irq;
+
+	spin_lock(&i8259A_lock);
+
+	outb(0x0c, 0x20);
+	iob();
+	/* Ack the IRQ in the master. */
+	irq = inb(0x20) & 7;
+	if (irq == 2) {
+		outb(0x0c, 0xa0);
+		iob();
+		/* Ditto for the slave. */
+		irq = (inb(0xa0) & 7) + 8;
+	}
+
+	spin_unlock(&i8259A_lock);
+
+	return irq;
+}
+
+#endif /* __ASM_MIPS_I8259_H */
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/include/asm-mips/irq.h linux-mips-2.4.20-pre6-20021212/include/asm-mips/irq.h
--- linux-mips-2.4.20-pre6-20021212.macro/include/asm-mips/irq.h	2002-12-16 17:16:46.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/include/asm-mips/irq.h	2002-12-18 15:58:52.000000000 +0000
@@ -24,9 +24,6 @@ static inline int irq_cannonicalize(int 
 #define irq_cannonicalize(irq) (irq)	/* Sane hardware, sane code ... */
 #endif
 
-struct irqaction;
-extern int i8259_setup_irq(int irq, struct irqaction * new);
-
 extern void disable_irq(unsigned int);
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/include/asm-mips64/i8259.h linux-mips-2.4.20-pre6-20021212/include/asm-mips64/i8259.h
--- linux-mips-2.4.20-pre6-20021212.macro/include/asm-mips64/i8259.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/include/asm-mips64/i8259.h	2002-12-18 00:32:19.000000000 +0000
@@ -0,0 +1,54 @@
+/*
+ *	include/asm-mips/i8259.h
+ *
+ *	i8259A interrupt definitions.
+ *
+ *	Copyright (C) 2002  Maciej W. Rozycki
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
+/*
+ * Ack an i8259A IRQ for systems that don't use hardware INTA cycles.
+ *
+ * Note we intentionally ignore the "I" (valid) bit reported by the
+ * controllers and pass spurious IRQs as real ones, since they are
+ * rare so the overhead is small and they will be handled later by 
+ * mask_and_ack_8259A() anyway.
+ */
+static inline int poll_8259A_irq(void)
+{
+	extern spinlock_t i8259A_lock;
+	int irq;
+
+	spin_lock(&i8259A_lock);
+
+	outb(0x0c, 0x20);
+	iob();
+	/* Ack the IRQ in the master. */
+	irq = inb(0x20) & 7;
+	if (irq == 2) {
+		outb(0x0c, 0xa0);
+		iob();
+		/* Ditto for the slave. */
+		irq = (inb(0xa0) & 7) + 8;
+	}
+
+	spin_unlock(&i8259A_lock);
+
+	return irq;
+}
+
+#endif /* __ASM_MIPS64_I8259_H */
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/include/asm-mips64/irq.h linux-mips-2.4.20-pre6-20021212/include/asm-mips64/irq.h
--- linux-mips-2.4.20-pre6-20021212.macro/include/asm-mips64/irq.h	2002-12-16 16:56:09.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/include/asm-mips64/irq.h	2002-12-18 16:03:00.000000000 +0000
@@ -42,9 +42,6 @@ static inline int irq_cannonicalize(int 
 #define irq_cannonicalize(irq) (irq)	/* Sane hardware, sane code ... */
 #endif
 
-struct irqaction;
-extern int i8259_setup_irq(int irq, struct irqaction * new);
-
 extern void disable_irq(unsigned int);
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
