Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fANJwN304884
	for linux-mips-outgoing; Fri, 23 Nov 2001 11:58:23 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fANJueo04869
	for <linux-mips@oss.sgi.com>; Fri, 23 Nov 2001 11:56:42 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA17000;
	Fri, 23 Nov 2001 19:46:44 +0100 (MET)
Date: Fri, 23 Nov 2001 19:46:42 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, Harald Koerfgen <hkoerfg@web.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux: R3k DECstation FPU support
Message-ID: <Pine.GSO.3.96.1011123173156.10184B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 Here is an implementation of an FPU interrupt handler for R3k DECstations
(R4k ones are fine with the dedicated exception).  At first I thought only
interrupt to do_fpe() glue is missing but to my surprise I discovered no
R3k-class CPU is currently assumed to feature an FPU.  As making use of an
FPU is usually advantageous if one exists, I implemented an FPU detection
function following guidelines given by my MIPS manual (I can't test an
FPU-less system).

 I believe the code is stable as is.  It does not provide any additional
functionality beyond what is currently available to systems using the
dedicated FPU exception.  To verify an FPU is detected properly (the
kernel does not report it in any way now) and FPU exceptions are delivered
successfully the following program can be used. 

fdiv.c:

#include <stddef.h>
#include <stdio.h>

#include <fpu_control.h>

int main(void)
{
	double x, y, z;
	int r;
	fpu_control_t fpcw;
	unsigned int fpir;

	setvbuf(stdout, NULL, _IONBF, 0);

	_FPU_GETCW(fpcw);

	fpcw &= _FPU_RESERVED;
	fpcw |= _FPU_IEEE;

	_FPU_SETCW(fpcw);

	__asm__("cfc1 %0, $0"
		: "=r" (fpir)
		:
		: "memory");
	
	_FPU_GETCW(fpcw);

	printf("FPCW: %08x\n", fpcw);
	printf("FPIR: %08x\n", fpir);

	__asm__(".set push\n\t"
		".set reorder\n\t"
		"mtc1 %z4, %1\n\t"
		"mtc1 %z5, %2\n\t"
		"cvt.d.w %1, %1\n\t"
		"cvt.d.w %2, %2\n\t"
		".set noreorder\n\t"
		"b 0f\n\t"
		" div.d %3, %1, %2\n\t"
		".set reorder\n\t"
		"nop\n"
		"0:\n\t"
		"cvt.w.d %3, %3\n\t"
		"mfc1 %0, %3\n\t"
		".set pop"
		: "=r" (r), "=f" (x), "=f" (y), "=f" (z)
		: "Jr" (0), "Jr" (0));

	return r;
}

You should receive an output similar to one of the following ones:

FPCW: 00000f80
FPIR: 00000340
Floating point exception

for an R3k-class FPU,

FPCW: 00000f80
FPIR: 00000500
Floating point exception

for an R4k-class FPU,

FPCW: 00000f80
FPIR: 00000000
Floating point exception

for the FPU emulation (the Implementation and Revision register is zero). 
If you don't get an exception then there is a problem with FPU interrupt
delivery -- please report it to me, especially if it happens for a
DECstation. 

 The patch includes a few minor clean-ups of nearby code as well.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.14-20011123-dec-fpu-9
diff -up --recursive --new-file linux-mips-2.4.14-20011123-dist/arch/mips/dec/int-handler.S linux-mips-2.4.14-20011123-dec-fpu/arch/mips/dec/int-handler.S
--- linux-mips-2.4.14-20011123-dist/arch/mips/dec/int-handler.S	Tue Jul  3 04:27:16 2001
+++ linux-mips-2.4.14-20011123-dec-fpu/arch/mips/dec/int-handler.S	Fri Nov 23 16:35:53 2001
@@ -2,7 +2,7 @@
  * arch/mips/dec/int-handler.S
  *
  * Copyright (C) 1995, 1996, 1997 Paul M. Antoine and Harald Koerfgen
- * Copyright (C) 2000  Maciej W. Rozycki
+ * Copyright (C) 2000, 2001  Maciej W. Rozycki
  *
  * Written by Ralf Baechle and Andreas Busse, modified for DECStation
  * support by Paul Antoine and Harald Koerfgen.
@@ -145,6 +145,9 @@
 
 		beqz	t0,spurious
 
+		 andi	t2,t0,DEC_IE_FPU
+		bnez	t2,fpu			# handle FPU immediately
+
 		/*
 		 * Find irq with highest priority
 		 */
@@ -169,7 +172,7 @@
  * Handle "IRQ Controller" Interrupts
  * Masked Interrupts are still visible and have to be masked "by hand".
  */
-		EXPORT(kn02_io_int)
+		FEXPORT(kn02_io_int)
 kn02_io_int:					# 3max
 		lui	t0,KN02_CSR_ADDR>>16	# get interrupt status and mask
 		lw	t0,(t0)
@@ -179,7 +182,7 @@ kn02_io_int:					# 3max
 		b	find_int
 		 and	t0,t3			# mask out allowed ones
 
-		EXPORT(kn03_io_int)
+		FEXPORT(kn03_io_int)
 kn03_io_int:					# 3max+
 		lui	t2,KN03_IOASIC_BASE>>16	# upper part of IOASIC Address
 		lw	t0,SIR(t2)		# get status: IOASIC isr
@@ -188,7 +191,7 @@ kn03_io_int:					# 3max+
 		b	find_int
 		 and	t0,t3			# mask out allowed ones
 
-		EXPORT(kn02xa_io_int)
+		FEXPORT(kn02xa_io_int)
 kn02xa_io_int:					# 3min/maxine
 		lui	t2,KN02XA_IOASIC_BASE>>16		
 						# upper part of IOASIC Address
@@ -219,28 +222,27 @@ handle_it:	jal	do_IRQ
 		j	ret_from_irq
 		 nop
 
+fpu:
+		j	handle_fpe_int
+		 nop
+
 spurious:
 		j	spurious_interrupt
 		 nop
 		END(decstation_handle_int)
-/*
-  * Interrupt routines common to all DECStations first.
- */
-		EXPORT(dec_intr_fpu)
-dec_intr_fpu:	PANIC("Unimplemented FPU interrupt handler")
 
 /*
  * Generic unimplemented interrupt routines - ivec_tbl is initialised to
  * point all interrupts here.  The table is then filled in by machine-specific
  * initialisation in dec_setup().
  */
-		EXPORT(dec_intr_unimplemented)
+		FEXPORT(dec_intr_unimplemented)
 dec_intr_unimplemented:
 		mfc0	a1,CP0_CAUSE		# cheats way of printing an arg!
 		nop				# to be sure...
 		PANIC("Unimplemented cpu interrupt! CP0_CAUSE: 0x%x");
 
-		EXPORT(asic_intr_unimplemented)
+		FEXPORT(asic_intr_unimplemented)
 asic_intr_unimplemented:
 		move	a1,t0			# cheats way of printing an arg!
 		PANIC("Unimplemented asic interrupt! ASIC ISR: 0x%x");
diff -up --recursive --new-file linux-mips-2.4.14-20011123-dist/arch/mips/dec/setup.c linux-mips-2.4.14-20011123-dec-fpu/arch/mips/dec/setup.c
--- linux-mips-2.4.14-20011123-dist/arch/mips/dec/setup.c	Tue Jul  3 04:27:16 2001
+++ linux-mips-2.4.14-20011123-dec-fpu/arch/mips/dec/setup.c	Thu Nov 22 00:20:46 2001
@@ -6,7 +6,7 @@
  * for more details.
  *
  * Copyright (C) 1998 Harald Koerfgen
- * Copyright (C) 2000 Maciej W. Rozycki
+ * Copyright (C) 2000, 2001 Maciej W. Rozycki
  */
 #include <linux/sched.h>
 #include <linux/interrupt.h>
@@ -55,7 +55,7 @@ extern int setup_dec_irq(int, struct irq
 
 void (*board_time_init) (struct irqaction * irq);
 
-static struct irqaction irq10 = {dec_intr_halt, 0, 0, "halt", NULL, NULL};
+static struct irqaction haltirq = {dec_intr_halt, 0, 0, "halt", NULL, NULL};
 
 /*
  * enable the periodic interrupts
@@ -139,10 +139,10 @@ void __init dec_init_kn01(void)
     cpu_mask_tbl[4] = IE_IRQ4;
     cpu_irq_nr[4] = MEMORY;
 
-    dec_interrupt[FPU].cpu_mask = IE_IRQ5;
-    dec_interrupt[FPU].iemask = 0;
-    cpu_mask_tbl[5] = IE_IRQ5;
-    cpu_irq_nr[5] = FPU;
+    /*
+     * Enable board interrupts: FPU.
+     */
+    set_cp0_status(DEC_IE_FPU);
 }				/* dec_init_kn01 */
 
 /*
@@ -165,10 +165,10 @@ void __init dec_init_kn230(void)
     cpu_mask_tbl[0] = IE_IRQ2;
     cpu_irq_nr[0] = CLOCK;
 
-    dec_interrupt[FPU].cpu_mask = IE_IRQ5;
-    dec_interrupt[FPU].iemask = 0;
-    cpu_mask_tbl[5] = IE_IRQ5;
-    cpu_irq_nr[5] = FPU;
+    /*
+     * Enable board interrupts: FPU.
+     */
+    set_cp0_status(DEC_IE_FPU);
 }				/* dec_init_kn230 */
 
 /*
@@ -176,6 +176,8 @@ void __init dec_init_kn230(void)
  */
 void __init dec_init_kn02(void)
 {
+    int dec_ie_io;
+
     /*
      * Setup some memory addresses. FIXME: probably incomplete!
      */
@@ -184,10 +186,11 @@ void __init dec_init_kn02(void)
     imr = (void *) KN02_CSR_ADDR;
 
     /*
-     * Setup IOASIC interrupt
+     * Setup I/O interrupt
      */
+    dec_ie_io = IE_IRQ0;
     cpu_ivec_tbl[1] = kn02_io_int;
-    cpu_mask_tbl[1] = IE_IRQ0;
+    cpu_mask_tbl[1] = dec_ie_io;
     cpu_irq_nr[1] = -1;
     *imr = *imr & 0xff00ff00;
 
@@ -234,11 +237,10 @@ void __init dec_init_kn02(void)
     cpu_mask_tbl[2] = IE_IRQ3;
     cpu_irq_nr[2] = MEMORY;
 
-    dec_interrupt[FPU].cpu_mask = IE_IRQ5;
-    dec_interrupt[FPU].iemask = 0;
-    cpu_mask_tbl[3] = IE_IRQ5;
-    cpu_irq_nr[3] = FPU;
-
+    /*
+     * Enable board interrupts: FPU, I/O.
+     */
+    set_cp0_status(DEC_IE_FPU | dec_ie_io);
 }				/* dec_init_kn02 */
 
 /*
@@ -246,6 +248,8 @@ void __init dec_init_kn02(void)
  */
 void __init dec_init_kn02ba(void)
 {
+    int dec_ie_ioasic;
+
     /*
      * Setup some memory addresses.
      */
@@ -257,9 +261,10 @@ void __init dec_init_kn02ba(void)
     /*
      * Setup IOASIC interrupt
      */
-    cpu_mask_tbl[0] = IE_IRQ3;
-    cpu_irq_nr[0] = -1;
+    dec_ie_ioasic = IE_IRQ3;
     cpu_ivec_tbl[0] = kn02xa_io_int;
+    cpu_mask_tbl[0] = dec_ie_ioasic;
+    cpu_irq_nr[0] = -1;
     *imr = 0;
 
     /*
@@ -315,12 +320,12 @@ void __init dec_init_kn02ba(void)
     cpu_mask_tbl[4] = IE_IRQ4;
     cpu_irq_nr[4] = HALT;
 
-    dec_interrupt[FPU].cpu_mask = IE_IRQ5;
-    dec_interrupt[FPU].iemask = 0;
-    cpu_mask_tbl[5] = IE_IRQ5;
-    cpu_irq_nr[5] = FPU;
+    /*
+     * Enable board interrupts: FPU, I/O ASIC.
+     */
+    set_cp0_status(DEC_IE_FPU | dec_ie_ioasic);
 
-    dec_halt_init(&irq10);
+    dec_halt_init(&haltirq);
 }				/* dec_init_kn02ba */
 
 /*
@@ -328,6 +333,8 @@ void __init dec_init_kn02ba(void)
  */
 void __init dec_init_kn02ca(void)
 {
+    int dec_ie_ioasic;
+
     /*
      * Setup some memory addresses. FIXME: probably incomplete!
      */
@@ -339,9 +346,10 @@ void __init dec_init_kn02ca(void)
     /*
      * Setup IOASIC interrupt
      */
+    dec_ie_ioasic = IE_IRQ3;
     cpu_ivec_tbl[1] = kn02xa_io_int;
+    cpu_mask_tbl[1] = dec_ie_ioasic;
     cpu_irq_nr[1] = -1;
-    cpu_mask_tbl[1] = IE_IRQ3;
     *imr = 0;
 
     /*
@@ -392,12 +400,12 @@ void __init dec_init_kn02ca(void)
     cpu_mask_tbl[3] = IE_IRQ4;
     cpu_irq_nr[3] = HALT;
 
-    dec_interrupt[FPU].cpu_mask = IE_IRQ5;
-    dec_interrupt[FPU].iemask = 0;
-    cpu_mask_tbl[4] = IE_IRQ5;
-    cpu_irq_nr[4] = FPU;
+    /*
+     * Enable board interrupts: FPU, I/O ASIC.
+     */
+    set_cp0_status(DEC_IE_FPU | dec_ie_ioasic);
 
-    dec_halt_init(&irq10);
+    dec_halt_init(&haltirq);
 }				/* dec_init_kn02ca */
 
 /*
@@ -405,6 +413,8 @@ void __init dec_init_kn02ca(void)
  */
 void __init dec_init_kn03(void)
 {
+    int dec_ie_ioasic;
+
     /*
      * Setup some memory addresses. FIXME: probably incomplete!
      */
@@ -416,8 +426,9 @@ void __init dec_init_kn03(void)
     /*
      * Setup IOASIC interrupt
      */
+    dec_ie_ioasic = IE_IRQ0;
     cpu_ivec_tbl[1] = kn03_io_int;
-    cpu_mask_tbl[1] = IE_IRQ0;
+    cpu_mask_tbl[1] = dec_ie_ioasic;
     cpu_irq_nr[1] = -1;
     *imr = 0;
 
@@ -474,10 +485,10 @@ void __init dec_init_kn03(void)
     cpu_mask_tbl[3] = IE_IRQ4;
     cpu_irq_nr[3] = HALT;
 
-    dec_interrupt[FPU].cpu_mask = IE_IRQ5;
-    dec_interrupt[FPU].iemask = 0;
-    cpu_mask_tbl[4] = IE_IRQ5;
-    cpu_irq_nr[4] = FPU;
+    /*
+     * Enable board interrupts: FPU, I/O ASIC.
+     */
+    set_cp0_status(DEC_IE_FPU | dec_ie_ioasic);
 
-    dec_halt_init(&irq10);
+    dec_halt_init(&haltirq);
 }				/* dec_init_kn03 */
diff -up --recursive --new-file linux-mips-2.4.14-20011123-dist/arch/mips/kernel/entry.S linux-mips-2.4.14-20011123-dec-fpu/arch/mips/kernel/entry.S
--- linux-mips-2.4.14-20011123-dist/arch/mips/kernel/entry.S	Tue Nov 20 05:26:20 2001
+++ linux-mips-2.4.14-20011123-dec-fpu/arch/mips/kernel/entry.S	Fri Nov 23 14:50:11 2001
@@ -106,16 +106,16 @@ LEAF(spurious_interrupt)
 
 		__INIT
 
-		/*
-		 * General exception vector.  Used for all CPUs except R4000
-		 * and R4400 SC and MC versions.
-		 */
 		.set	reorder
 
 		NESTED(except_vec1_generic, 0, sp)
 		PANIC("Exception vector 1 called")
 		END(except_vec1_generic)
 
+		/*
+		 * General exception vector.  Used for all CPUs except R4000
+		 * and R4400 SC and MC versions.
+		 */
 		NESTED(except_vec3_generic, 0, sp)
 		mfc0	k1, CP0_CAUSE
 		la	k0, exception_handlers
@@ -225,6 +225,7 @@ EXPORT(exception_count_##exception);    
 		NESTED(handle_##exception, PT_SIZE, sp);                \
 		.set	noat;                                           \
 		SAVE_ALL;                                               \
+		FEXPORT(handle_##exception##_int);			\
 		__BUILD_clear_##clear(exception);                       \
 		.set	at;                                             \
 		__BUILD_##verbose(exception);                           \
diff -up --recursive --new-file linux-mips-2.4.14-20011123-dist/arch/mips/kernel/setup.c linux-mips-2.4.14-20011123-dec-fpu/arch/mips/kernel/setup.c
--- linux-mips-2.4.14-20011123-dist/arch/mips/kernel/setup.c	Tue Nov 20 05:26:20 2001
+++ linux-mips-2.4.14-20011123-dec-fpu/arch/mips/kernel/setup.c	Fri Nov 23 14:50:11 2001
@@ -7,7 +7,7 @@
  * Copyright (C) 1995  Waldorf Electronics
  * Copyright (C) 1995, 1996, 1997, 1998, 1999, 2000, 2001  Ralf Baechle
  * Copyright (C) 1996  Stoned Elipot
- * Copyright (C) 2000  Maciej W. Rozycki
+ * Copyright (C) 2000, 2001  Maciej W. Rozycki
  */
 #include <linux/config.h>
 #include <linux/errno.h>
@@ -182,6 +182,28 @@ static inline int cpu_has_confreg(void)
 #endif
 }
 
+/*
+ * Get the FPU Implementation/Revision.
+ */
+static inline unsigned long cpu_get_fpu_id(void)
+{
+	unsigned long tmp, fpu_id;
+
+	tmp = read_32bit_cp0_register(CP0_STATUS);
+	write_32bit_cp0_register(CP0_STATUS, tmp | ST0_CU1);
+	fpu_id = read_32bit_cp1_register(CP1_REVISION);
+	write_32bit_cp0_register(CP0_STATUS, tmp);
+	return fpu_id;
+}
+
+/*
+ * Check the CPU has an FPU the official way.
+ */
+static inline int cpu_has_fpu(void)
+{
+	return ((cpu_get_fpu_id() & 0xff00) != FPIR_IMP_NONE);
+}
+
 /* declaration of the global struct */
 struct mips_cpu mips_cpu = {PRID_IMP_UNKNOWN, CPU_UNKNOWN, 0, 0, 0,
 			    {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}};
@@ -206,6 +228,8 @@ static inline void cpu_probe(void)
 			mips_cpu.cputype = CPU_R2000;
 			mips_cpu.isa_level = MIPS_CPU_ISA_I;
 			mips_cpu.options = MIPS_CPU_TLB;
+			if (cpu_has_fpu())
+				mips_cpu.options |= MIPS_CPU_FPU;
 			mips_cpu.tlbsize = 64;
 			break;
 		case PRID_IMP_R3000:
@@ -218,6 +242,8 @@ static inline void cpu_probe(void)
 				mips_cpu.cputype = CPU_R3000;
 			mips_cpu.isa_level = MIPS_CPU_ISA_I;
 			mips_cpu.options = MIPS_CPU_TLB;
+			if (cpu_has_fpu())
+				mips_cpu.options |= MIPS_CPU_FPU;
 			mips_cpu.tlbsize = 64;
 			break;
 		case PRID_IMP_R4000:
diff -up --recursive --new-file linux-mips-2.4.14-20011123-dist/arch/mips/kernel/traps.c linux-mips-2.4.14-20011123-dec-fpu/arch/mips/kernel/traps.c
--- linux-mips-2.4.14-20011123-dist/arch/mips/kernel/traps.c	Wed Nov 21 05:26:46 2001
+++ linux-mips-2.4.14-20011123-dec-fpu/arch/mips/kernel/traps.c	Fri Nov 23 14:50:11 2001
@@ -501,7 +501,6 @@ asmlinkage void do_fpe(struct pt_regs *r
 		return;
 
 	force_sig(SIGFPE, current);
-	printk(KERN_DEBUG "Sent send SIGFPE to %s\n", current->comm);
 }
 
 static inline int get_insn_opcode(struct pt_regs *regs, unsigned int *opcode)
diff -up --recursive --new-file linux-mips-2.4.14-20011123-dist/include/asm-mips/cpu.h linux-mips-2.4.14-20011123-dec-fpu/include/asm-mips/cpu.h
--- linux-mips-2.4.14-20011123-dist/include/asm-mips/cpu.h	Fri Nov 23 14:46:34 2001
+++ linux-mips-2.4.14-20011123-dec-fpu/include/asm-mips/cpu.h	Fri Nov 23 15:08:18 2001
@@ -90,6 +90,17 @@
 #define PRID_REV_TX3927C 	0x0042
 #define PRID_REV_TX39H3TEG 	0x0050
 
+/*
+ * FPU implementation/revision register (CP1 control register 0).
+ *
+ * +---------------------------------+----------------+----------------+
+ * | 0                               | Implementation | Revision       |
+ * +---------------------------------+----------------+----------------+
+ *  31                             16 15             8 7              0
+ */
+
+#define FPIR_IMP_NONE		0x0000
+
 #ifndef  _LANGUAGE_ASSEMBLY
 /*
  * Capability and feature descriptor structure for MIPS CPU
diff -up --recursive --new-file linux-mips-2.4.14-20011123-dist/include/asm-mips/dec/interrupts.h linux-mips-2.4.14-20011123-dec-fpu/include/asm-mips/dec/interrupts.h
--- linux-mips-2.4.14-20011123-dist/include/asm-mips/dec/interrupts.h	Tue Jul  3 04:27:22 2001
+++ linux-mips-2.4.14-20011123-dec-fpu/include/asm-mips/dec/interrupts.h	Wed Nov 21 23:57:52 2001
@@ -13,6 +13,8 @@
 #ifndef __ASM_DEC_INTERRUPTS_H 
 #define __ASM_DEC_INTERRUPTS_H 
 
+#include <asm/mipsregs.h>
+
 /*
  * DECstation Interrupts
  */
@@ -22,7 +24,7 @@
  * Exception: on kmins we have to handle Memory Error 
  * Interrupts before the TC Interrupts.
  */
-#define CLOCK 	0
+#define CLOCK	 	0
 #define SCSI_DMA_INT 	1
 #define SCSI_INT	2
 #define ETHER		3
@@ -31,10 +33,17 @@
 #define TC1		6
 #define TC2		7
 #define MEMORY		8
-#define FPU		9
-#define HALT		10
+#define HALT		9
+
+#define NR_INTS		10
 
-#define NR_INTS	11
+/*
+ * The FPU is special.  It must always be handled first.
+ * Since it bypasses the regular IRQ handler we define
+ * the line it uses here.  All DECstations use the same
+ * one.
+ */
+#define DEC_IE_FPU	IE_IRQ5
 
 #ifndef __ASSEMBLY__
 /*
@@ -70,8 +79,6 @@ extern long asic_mask_tbl[32];
  * Common interrupt routine prototypes for all DECStations
  */
 extern void	dec_intr_unimplemented(void);
-extern void	dec_intr_fpu(void);
-extern void	dec_intr_rtc(void);
 
 extern void	kn02_io_int(void);
 extern void	kn02xa_io_int(void);
diff -up --recursive --new-file linux-mips-2.4.14-20011123-dist/include/asm-mips/mipsregs.h linux-mips-2.4.14-20011123-dec-fpu/include/asm-mips/mipsregs.h
--- linux-mips-2.4.14-20011123-dist/include/asm-mips/mipsregs.h	Tue Nov 20 05:27:07 2001
+++ linux-mips-2.4.14-20011123-dec-fpu/include/asm-mips/mipsregs.h	Fri Nov 23 14:55:27 2001
@@ -508,6 +508,19 @@
 	:"=r" (__res));                                         \
         __res;})
 
+/*
+ * Macros to access the floating point coprocessor control registers
+ */
+#define read_32bit_cp1_register(source)                         \
+({ int __res;                                                   \
+        __asm__ __volatile__(                                   \
+	".set\tpush\n\t"					\
+	".set\treorder\n\t"					\
+        "cfc1\t%0,"STR(source)"\n\t"                            \
+	".set\tpop"						\
+        : "=r" (__res));                                        \
+        __res;})
+
 /* TLB operations. */
 static inline void tlb_probe(void)
 {
