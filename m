From: Kevin D. Kissell <kevink@paralogos.com>
Date: Tue, 9 Sep 2008 21:35:01 +0200
Subject: [PATCH] Close tiny holes in the SMTC IPI replay system.
 Signed-off-by: Kevin D. Kissell <kevink@paralogos.com>
Message-ID: <20080909193501.qkXV_4L9I1jr2-gSFPfY-10q1THVnlHc9fGtvt__SiI@z>

---
 arch/mips/kernel/entry.S      |   10 +++---
 include/asm-mips/stackframe.h |   72 ++++++++++++++++++++++++++++++++++------
 2 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index e29598a..ffa3310 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -79,11 +79,6 @@ FEXPORT(syscall_exit)
 
 FEXPORT(restore_all)			# restore full frame
 #ifdef CONFIG_MIPS_MT_SMTC
-/* Detect and execute deferred IPI "interrupts" */
-	LONG_L	s0, TI_REGS($28)
-	LONG_S	sp, TI_REGS($28)
-	jal	deferred_smtc_ipi
-	LONG_S	s0, TI_REGS($28)
 #ifdef CONFIG_MIPS_MT_SMTC_IM_BACKSTOP
 /* Re-arm any temporarily masked interrupts not explicitly "acked" */
 	mfc0	v0, CP0_TCSTATUS
@@ -112,6 +107,11 @@ FEXPORT(restore_all)			# restore full frame
 	xor	t0, t0, t3
 	mtc0	t0, CP0_TCCONTEXT
 #endif /* CONFIG_MIPS_MT_SMTC_IM_BACKSTOP */
+/* Detect and execute deferred IPI "interrupts" */
+	LONG_L	s0, TI_REGS($28)
+	LONG_S	sp, TI_REGS($28)
+	jal	deferred_smtc_ipi
+	LONG_S	s0, TI_REGS($28)
 #endif /* CONFIG_MIPS_MT_SMTC */
 	.set	noat
 	RESTORE_TEMP
diff --git a/include/asm-mips/stackframe.h b/include/asm-mips/stackframe.h
index 051e1af..4c37c4e 100644
--- a/include/asm-mips/stackframe.h
+++ b/include/asm-mips/stackframe.h
@@ -297,14 +297,31 @@
 #ifdef CONFIG_MIPS_MT_SMTC
 		.set	mips32r2
 		/*
-		 * This may not really be necessary if ints are already
-		 * inhibited here.
+		 * We need to make sure the read-modify-write
+		 * of Status below isn't perturbed by an interrupt
+		 * or cross-TC access, so we need to do at least a DMT,
+		 * protected by an interrupt-inhibit. But setting IXMT
+		 * also creates a few-cycle window where an IPI could
+		 * be queued and not be detected before potentially
+		 * returning to a WAIT or user-mode loop. It must be
+		 * replayed.
+		 *
+		 * We're in the middle of a context switch, and
+		 * we can't dispatch it directly without trashing
+		 * some registers, so we'll try to detect this unlikely
+		 * case and program a software interrupt in the VPE,
+		 * as would be done for a cross-VPE IPI.  To accomodate
+		 * the handling of that case, we're doing a DVPE instead
+		 * of just a DMT here to protect against other threads.
+		 * This is a lot of cruft to cover a tiny window.
+		 * If you can find a better design, implement it!
+		 *
 		 */
 		mfc0	v0, CP0_TCSTATUS
 		ori	v0, TCSTATUS_IXMT
 		mtc0	v0, CP0_TCSTATUS
 		_ehb
-		DMT	5				# dmt a1
+		DVPE	5				# dvpe a1
 		jal	mips_ihb
 #endif /* CONFIG_MIPS_MT_SMTC */
 		mfc0	a0, CP0_STATUS
@@ -325,17 +342,50 @@
  */
 		LONG_L	v1, PT_TCSTATUS(sp)
 		_ehb
-		mfc0	v0, CP0_TCSTATUS
+		mfc0	a0, CP0_TCSTATUS
 		andi	v1, TCSTATUS_IXMT
-		/* We know that TCStatua.IXMT should be set from above */
-		xori	v0, v0, TCSTATUS_IXMT
-		or	v0, v0, v1
-		mtc0	v0, CP0_TCSTATUS
-		_ehb
-		andi	a1, a1, VPECONTROL_TE
+		bnez	v1, 0f
+
+/*
+ * We'd like to detect any IPIs queued in the tiny window
+ * above and request an software interrupt to service them
+ * when we ERET.
+ *
+ * Computing the offset into the IPIQ array of the executing
+ * TC's IPI queue in-line would be tedious.  We use part of
+ * the TCContext register to hold 16 bits of offset that we
+ * can add in-line to find the queue head.
+ */
+		mfc0	v0, CP0_TCCONTEXT
+		la	a2, IPIQ
+		srl	v0, v0, 16
+		addu	a2, a2, v0
+		LONG_L	v0, 0(a2)
+		beqz	v0, 0f
+/*
+ * If we have a queue, provoke dispatch within the VPE by setting C_SW1
+ */
+		mfc0	v0, CP0_CAUSE
+		ori	v0, v0, C_SW1
+		mtc0	v0, CP0_CAUSE
+0:
+		/*
+		 * This test should really never branch but
+		 * let's be prudent here.  Having atomized
+		 * the shared register modifications, we can
+		 * now EVPE, and must do so before interrupts
+		 * are potentially re-enabled.
+		 */
+		andi	a1, a1, MVPCONTROL_EVP
 		beqz	a1, 1f
-		emt
+		evpe
 1:
+		/* We know that TCStatua.IXMT should be set from above */
+		xori	a0, a0, TCSTATUS_IXMT
+		or	a0, a0, v1
+		mtc0	a0, CP0_TCSTATUS
+		_ehb
+
 		.set	mips0
 #endif /* CONFIG_MIPS_MT_SMTC */
 		LONG_L	v1, PT_EPC(sp)
-- 
1.5.3.3


--------------080009040507040709070608--
