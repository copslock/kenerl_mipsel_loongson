From: Kevin D. Kissell <kevink@paralogos.com>
Date: Tue, 9 Sep 2008 21:33:36 +0200
Subject: [PATCH] Fixed holes in SMTC and FPU affinity support.
 Signed-off-by: Kevin D. Kissell <kevink@paralogos.com>
Message-ID: <20080909193336.q3vaMFu54veD3nMJhNeO4Tiiq4aW41xAhPBb9rYOpUU@z>

---
 arch/mips/kernel/process.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 2c09a44..75277c8 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -55,7 +55,7 @@ void __noreturn cpu_idle(void)
 	while (1) {
 		tick_nohz_stop_sched_tick();
 		while (!need_resched()) {
-#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
+#ifdef CONFIG_MIPS_MT_SMTC
 			extern void smtc_idle_loop_hook(void);
 
 			smtc_idle_loop_hook();
@@ -155,14 +155,19 @@ int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
 	clear_tsk_thread_flag(p, TIF_USEDFPU);
 
 #ifdef CONFIG_MIPS_MT_FPAFF
+	clear_tsk_thread_flag(p, TIF_FPUBOUND);
 	/*
-	 * FPU affinity support is cleaner if we track the
-	 * user-visible CPU affinity from the very beginning.
-	 * The generic cpus_allowed mask will already have
-	 * been copied from the parent before copy_thread
-	 * is invoked.
+	 * FPU affinity support requires that we be subtle.
+	 * The basic fork support code will have copied
+	 * the parent's cpus_allowed set, but what the child
+	 * needs to inherit is the "user" version, which
+	 * carries the program/user controlled CPU affinity
+	 * properties that are supposed to be inherited,
+	 * but not the transient, overlayed, hardware
+	 * affinity constraints.
 	 */
-	p->thread.user_cpus_allowed = p->cpus_allowed;
+	p->thread.user_cpus_allowed = current->thread.user_cpus_allowed;
+	p->cpus_allowed = current->thread.user_cpus_allowed;
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
 	if (clone_flags & CLONE_SETTLS)
-- 
1.5.3.3


--------------040406000605030509060700--
