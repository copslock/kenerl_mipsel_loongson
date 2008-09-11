From: Kevin D. Kissell <kevink@paralogos.com>
Date: Thu, 11 Sep 2008 15:42:19 +0200
Subject: [PATCH] Fix some holes in the automated FPU affinity logic for SMTC and SMVP.
 Signed-off-by: Kevin D. Kissell <kevink@paralogos.com>
Message-ID: <20080911134219.JNO6LOSam2hvvkJETmL_IC-YqUDjUt4yx2-e_5W8rZE@z>


diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index df4d3f2..dc9eb72 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -159,7 +159,7 @@ __setup("fpaff=", fpaff_thresh);
 /*
  * FPU Use Factor empirically derived from experiments on 34K
  */
-#define FPUSEFACTOR 333
+#define FPUSEFACTOR 2000
 
 static __init int mt_fp_affinity_init(void)
 {
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 75277c8..8dd44ea 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -152,22 +152,18 @@ int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
 	 */
 	p->thread.cp0_status = read_c0_status() & ~(ST0_CU2|ST0_CU1);
 	childregs->cp0_status &= ~(ST0_CU2|ST0_CU1);
+#ifdef CONFIG_MIPS_MT_SMTC
+	/*
+	 * SMTC restores TCStatus after Status, and the CU bits
+	 * are aliased there.
+	 */
+	childregs->cp0_tcstatus &= ~(ST0_CU2|ST0_CU1);
+#endif
+
 	clear_tsk_thread_flag(p, TIF_USEDFPU);
 
 #ifdef CONFIG_MIPS_MT_FPAFF
 	clear_tsk_thread_flag(p, TIF_FPUBOUND);
-	/*
-	 * FPU affinity support requires that we be subtle.
-	 * The basic fork support code will have copied
-	 * the parent's cpus_allowed set, but what the child
-	 * needs to inherit is the "user" version, which
-	 * carries the program/user controlled CPU affinity
-	 * properties that are supposed to be inherited,
-	 * but not the transient, overlayed, hardware
-	 * affinity constraints.
-	 */
-	p->thread.user_cpus_allowed = current->thread.user_cpus_allowed;
-	p->cpus_allowed = current->thread.user_cpus_allowed;
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
 	if (clone_flags & CLONE_SETTLS)
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index f9165d1..0d1329e 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -807,8 +807,10 @@ static void mt_ase_fp_affinity(void)
 		if (cpus_intersects(current->cpus_allowed, mt_fpu_cpumask)) {
 			cpumask_t tmask;
 
-			cpus_and(tmask, current->thread.user_cpus_allowed,
-			         mt_fpu_cpumask);
+			current->thread.user_cpus_allowed
+				= current->cpus_allowed;
+			cpus_and(tmask, current->cpus_allowed,
+				mt_fpu_cpumask);
 			set_cpus_allowed(current, tmask);
 			set_thread_flag(TIF_FPUBOUND);
 		}
-- 
1.5.3.3


--------------080409070604030702060502--
