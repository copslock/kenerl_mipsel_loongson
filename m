Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f62F5sr17429
	for linux-mips-outgoing; Mon, 2 Jul 2001 08:05:54 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f62F5oV17426
	for <linux-mips@oss.sgi.com>; Mon, 2 Jul 2001 08:05:50 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA12148;
	Mon, 2 Jul 2001 17:06:44 +0200 (MET DST)
Date: Mon, 2 Jul 2001 17:06:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
   Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: linux 2.4.5: A DECstation HALT interrupt handler
Message-ID: <Pine.GSO.3.96.1010702163112.5606E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 Following is a minimal implementation of a HALT interrupt handler for
DECstations.  The handler resets a system (invokes a warm restart) after
the HALT button or, in case of the MAXINE, the HALT sequence of keys is
pressed.  The patch should be OK to apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.5-20010627-halt-basic-0
diff -up --recursive --new-file linux-mips-2.4.5-20010627.macro/arch/mips/dec/int-handler.S linux-mips-2.4.5-20010627/arch/mips/dec/int-handler.S
--- linux-mips-2.4.5-20010627.macro/arch/mips/dec/int-handler.S	Thu Jun 14 04:26:19 2001
+++ linux-mips-2.4.5-20010627/arch/mips/dec/int-handler.S	Sun Jul  1 00:24:21 2001
@@ -230,14 +230,6 @@ spurious:
 dec_intr_fpu:	PANIC("Unimplemented FPU interrupt handler")
 
 /*
- * Halt interrupt
- */
-		EXPORT(intr_halt)
-intr_halt:	la	k0,0xbc000000
-		jr	k0
-		 nop
-
-/*
  * Generic unimplemented interrupt routines - ivec_tbl is initialised to
  * point all interrupts here.  The table is then filled in by machine-specific
  * initialisation in dec_setup().
diff -up --recursive --new-file linux-mips-2.4.5-20010627.macro/arch/mips/dec/reset.c linux-mips-2.4.5-20010627/arch/mips/dec/reset.c
--- linux-mips-2.4.5-20010627.macro/arch/mips/dec/reset.c	Tue Mar 28 04:26:06 2000
+++ linux-mips-2.4.5-20010627/arch/mips/dec/reset.c	Sun Jul  1 00:27:53 2001
@@ -23,3 +23,7 @@ void dec_machine_power_off(void)
 	back_to_prom();
 }
 
+void dec_intr_halt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	dec_machine_halt();
+}
diff -up --recursive --new-file linux-mips-2.4.5-20010627.macro/arch/mips/dec/setup.c linux-mips-2.4.5-20010627/arch/mips/dec/setup.c
--- linux-mips-2.4.5-20010627.macro/arch/mips/dec/setup.c	Tue Jun  5 04:26:20 2001
+++ linux-mips-2.4.5-20010627/arch/mips/dec/setup.c	Sun Jul  1 00:32:55 2001
@@ -45,17 +45,18 @@ volatile unsigned int *imr = 0L;	/* addr
 extern void dec_machine_restart(char *command);
 extern void dec_machine_halt(void);
 extern void dec_machine_power_off(void);
+extern void dec_intr_halt(int irq, void *dev_id, struct pt_regs *regs);
 
 extern void wbflush_setup(void);
 
 extern struct rtc_ops dec_rtc_ops;
 
-extern void intr_halt(void);
-
 extern int setup_dec_irq(int, struct irqaction *);
 
 void (*board_time_init) (struct irqaction * irq);
 
+static struct irqaction irq10 = {dec_intr_halt, 0, 0, "halt", NULL, NULL};
+
 /*
  * enable the periodic interrupts
  */
@@ -74,6 +75,14 @@ static void __init dec_time_init(struct 
     setup_dec_irq(CLOCK, irq);
 }
 
+/*
+ * Enable the halt interrupt.
+ */
+static void __init dec_halt_init(struct irqaction *irq)
+{
+    setup_dec_irq(HALT, irq);
+}
+
 void __init decstation_setup(void)
 {
     board_time_init = dec_time_init;
@@ -311,6 +320,7 @@ void __init dec_init_kn02ba(void)
     cpu_mask_tbl[5] = IE_IRQ5;
     cpu_irq_nr[5] = FPU;
 
+    dec_halt_init(&irq10);
 }				/* dec_init_kn02ba */
 
 /*
@@ -387,6 +397,7 @@ void __init dec_init_kn02ca(void)
     cpu_mask_tbl[4] = IE_IRQ5;
     cpu_irq_nr[4] = FPU;
 
+    dec_halt_init(&irq10);
 }				/* dec_init_kn02ca */
 
 /*
@@ -468,4 +479,5 @@ void __init dec_init_kn03(void)
     cpu_mask_tbl[4] = IE_IRQ5;
     cpu_irq_nr[4] = FPU;
 
+    dec_halt_init(&irq10);
 }				/* dec_init_kn03 */
diff -up --recursive --new-file linux-mips-2.4.5-20010627.macro/include/asm-mips/dec/interrupts.h linux-mips-2.4.5-20010627/include/asm-mips/dec/interrupts.h
--- linux-mips-2.4.5-20010627.macro/include/asm-mips/dec/interrupts.h	Sat Aug 26 04:26:45 2000
+++ linux-mips-2.4.5-20010627/include/asm-mips/dec/interrupts.h	Sat Jun  2 22:09:53 2001
@@ -77,8 +77,6 @@ extern void	kn02_io_int(void);
 extern void	kn02xa_io_int(void);
 extern void	kn03_io_int(void);
 
-extern void	intr_halt(void);
-
 extern void	asic_intr_unimplemented(void);
 
 #endif
