Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 18:49:53 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:35006 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123907AbSJAQtw>; Tue, 1 Oct 2002 18:49:52 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA19557;
	Tue, 1 Oct 2002 18:50:17 +0200 (MET DST)
Date: Tue, 1 Oct 2002 18:50:17 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: [resend] The R4k generic exception vector for MIPS64
Message-ID: <Pine.GSO.3.96.1021001184524.13606N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Ralf,

 The following patch is needed for the whole except_vec3_r4000 handler to
be copied to its ultimate destination.  It also fixes a number of obvious
bugs within the handler (most notably the BadVaddr truncation).  Plus
minor consistency fixes.  Updated to take your recent trap setup changes
into account.  OK to apply? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-pre6-20021001-mips64-vec3_r4000-8
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021001.macro/arch/mips64/kernel/r4k_genex.S linux-mips-2.4.20-pre6-20021001/arch/mips64/kernel/r4k_genex.S
--- linux-mips-2.4.20-pre6-20021001.macro/arch/mips64/kernel/r4k_genex.S	2002-10-01 02:56:55.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021001/arch/mips64/kernel/r4k_genex.S	2002-10-01 16:18:17.000000000 +0000
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 1994 - 1999 by Ralf Baechle
  * Copyright (C) 1999 Silicon Graphics
+ * Copyright (C) 2002  Maciej W. Rozycki
  *
  * Low level exception handling
  */
@@ -31,25 +32,28 @@
 	BUILD_HANDLER mcheck mcheck cli verbose		/* #24 */
 	BUILD_HANDLER reserved reserved sti verbose	/* others */
 
+
 	__INIT
 
 /* General exception handler for CPUs with virtual coherency exception.
  *
- * Be careful when changing this, it has to be at most 128 bytes to fit
- * into space reserved for the exception handler.
+ * Be careful when changing this, it has to be at most 256 (as a special
+ * exception) bytes to fit into space reserved for the exception handler.
  */
-	NESTED(except_vec3_r4000, 0, sp)
+	.set	push
 	.set	noat
-#if defined(R5432_CP0_INTERRUPT_WAR)
-	mfc0    k0, CP0_INDEX
-#endif
+NESTED(except_vec3_r4000, 0, sp)
 	mfc0	k1, CP0_CAUSE
-	andi	k1, k1, 0x7c
 	li	k0, 31<<2
+	andi	k1, k1, 0x7c
+	.set	push
+	.set	noreorder
+	.set	nomacro
 	beq	k1, k0, handle_vced
 	 li	k0, 14<<2
 	beq	k1, k0, handle_vcei
 	 dsll	k1, k1, 1
+	.set	pop
 	ld	k0, exception_handlers(k1)
 	jr	k0
 
@@ -60,51 +64,61 @@
  * store will be re-executed.
  */
 handle_vced:
-	mfc0	k0, CP0_BADVADDR
+	dmfc0	k0, CP0_BADVADDR
 	li	k1, -4					# Is this ...
 	and	k0, k1					# ... really needed?
 	mtc0	zero, CP0_TAGLO
 	cache	Index_Store_Tag_D,(k0)
 	cache	Hit_Writeback_Inv_SD,(k0)
-	lui	k0, %hi(vced_count)
-	lw	k1, %lo(vced_count)(k0)
+	dla	k0, vced_count
+	lw	k1, (k0)
 	addiu	k1, 1
-	sw	k1, %lo(vced_count)(k0)
+	sw	k1, (k0)
 	eret
 
 handle_vcei:
-	mfc0	k0, CP0_BADVADDR
+	dmfc0	k0, CP0_BADVADDR
 	cache	Hit_Writeback_Inv_SD,(k0)		# also cleans pi
-	lui	k0, %hi(vcei_count)
-	lw	k1, %lo(vcei_count)(k0)
+	dla	k0, vcei_count
+	lw	k1, (k0)
 	addiu	k1, 1
-	sw	k1, %lo(vcei_count)(k0)
+	sw	k1, (k0)
 	eret
+END(except_vec3_r4000)
+	.set	pop
 
-	END(except_vec3_r4000)
-	.set	at
 
-	/* General exception vector for all other CPUs. */
-	NESTED(except_vec3_generic, 0, sp)
+/* General exception vector for all other CPUs.
+ *
+ * Be careful when changing this, it has to be at most 128 bytes
+ * to fit into space reserved for the exception handler.
+ */
+	.set	push
 	.set	noat
+NESTED(except_vec3_generic, 0, sp)
+#if defined(R5432_CP0_INTERRUPT_WAR)
+	mfc0    k0, CP0_INDEX
+#endif
 	mfc0	k1, CP0_CAUSE
 	andi	k1, k1, 0x7c
 	dsll	k1, k1, 1
 	ld	k0, exception_handlers(k1)
 	jr	k0
-	 nop
-	END(except_vec3_generic)
-	.set	at
+END(except_vec3_generic)
+	.set	pop
+
 
 /*
- * Special interrupt vector for embedded MIPS.  This is a dedicated interrupt
- * vector which reduces interrupt processing overhead.  The jump instruction
- * will be inserted here at initialization time.  This handler may only be 8
- * bytes in size!
+ * Special interrupt vector for MIPS64 ISA & embedded MIPS processors.
+ * This is a dedicated interrupt exception vector which reduces the
+ * interrupt processing overhead.  The jump instruction will be replaced
+ * at the initialization time.
+ *
+ * Be careful when changing this, it has to be at most 128 bytes
+ * to fit into space reserved for the exception handler.
  */
 NESTED(except_vec4, 0, sp)
 1:	j	1b			/* Dummy, will be replaced */
-	 nop
-	END(except_vec4)
+END(except_vec4)
 
 	__FINIT
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021001.macro/arch/mips64/kernel/traps.c linux-mips-2.4.20-pre6-20021001/arch/mips64/kernel/traps.c
--- linux-mips-2.4.20-pre6-20021001.macro/arch/mips64/kernel/traps.c	2002-10-01 02:56:55.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021001/arch/mips64/kernel/traps.c	2002-10-01 16:20:50.000000000 +0000
@@ -625,8 +625,8 @@ asmlinkage void do_watch(struct pt_regs 
 	 * We use the watch exception where available to detect stack
 	 * overflows.
 	 */
-	dump_tlb_all();
 	show_regs(regs);
+	dump_tlb_all();
 	panic("Caught WATCH exception - probably caused by stack overflow.");
 }
 
@@ -657,8 +657,8 @@ asmlinkage void do_reserved(struct pt_re
 static inline void watch_init(void)
 {
 	if (mips_cpu.options & MIPS_CPU_WATCH) {
-	set_except_vector(23, handle_watch);
-	watch_available = 1;
+		set_except_vector(23, handle_watch);
+		watch_available = 1;
 	}
 }
 
@@ -742,7 +742,7 @@ void __init trap_init(void)
 	 * interrupt processing overhead.  Use it where available.
 	 */
 	if (mips_cpu.options & MIPS_CPU_DIVEC) {
-		memcpy((void *)(KSEG0 + 0x200), &except_vec4, 8);
+		memcpy((void *)(KSEG0 + 0x200), &except_vec4, 0x80);
 		set_cp0_cause(CAUSEF_IV);
 	}
 
@@ -776,9 +776,12 @@ void __init trap_init(void)
 	if (mips_cpu.options & MIPS_CPU_MCHECK)
 		set_except_vector(24, handle_mcheck);
 
-	if (mips_cpu.options & MIPS_CPU_VCE)
+	if (mips_cpu.options & MIPS_CPU_VCE) {
+		/* VCE and DIVEC are mutually exclusive. */
+		if (mips_cpu.options & MIPS_CPU_DIVEC)
+			BUG();
 		memcpy((void *)(KSEG0 + 0x180), &except_vec3_r4000, 0x80);
-	else if (mips_cpu.options & MIPS_CPU_4KEX)
+	} else if (mips_cpu.options & MIPS_CPU_4KEX)
 		memcpy((void *)(KSEG0 + 0x180), &except_vec3_generic, 0x80);
 	else
 		memcpy((void *)(KSEG0 + 0x080), &except_vec3_generic, 0x80);
