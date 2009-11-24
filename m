Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 20:35:28 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41284 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1493540AbZKXTfY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 20:35:24 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAOJZfgR008768
	for <linux-mips@linux-mips.org>; Tue, 24 Nov 2009 19:35:41 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAOJZfB4008766
	for linux-mips@linux-mips.org; Tue, 24 Nov 2009 19:35:41 GMT
Date:	Tue, 24 Nov 2009 19:35:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Cleanup signal code initialization
Message-ID: <20091124193541.GA32216@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Looking at the COP2 handling in traps.c I was reminded of the other
uglyness in there.  This is once patch to clean it up.

 arch/mips/include/asm/fpu.h |    8 ----
 arch/mips/kernel/signal.c   |   46 ++++++++++++++++++++++++++
 arch/mips/kernel/signal32.c |   24 +++++++++++++
 arch/mips/kernel/traps.c    |   76 -------------------------------------------
 4 files changed, 70 insertions(+), 84 deletions(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 8a3ef24..7fcef8e 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -28,15 +28,7 @@
 struct sigcontext;
 struct sigcontext32;
 
-extern asmlinkage int (*save_fp_context)(struct sigcontext __user *sc);
-extern asmlinkage int (*restore_fp_context)(struct sigcontext __user *sc);
-
-extern asmlinkage int (*save_fp_context32)(struct sigcontext32 __user *sc);
-extern asmlinkage int (*restore_fp_context32)(struct sigcontext32 __user *sc);
-
 extern void fpu_emulator_init_fpu(void);
-extern int fpu_emulator_save_context(struct sigcontext __user *sc);
-extern int fpu_emulator_restore_context(struct sigcontext __user *sc);
 extern void _init_fpu(void);
 extern void _save_fp(struct task_struct *);
 extern void _restore_fp(struct task_struct *);
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 6254041..d0c68b5 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -35,6 +35,15 @@
 
 #include "signal-common.h"
 
+static int (*save_fp_context)(struct sigcontext __user *sc);
+static int (*restore_fp_context)(struct sigcontext __user *sc);
+
+extern asmlinkage int _save_fp_context(struct sigcontext __user *sc);
+extern asmlinkage int _restore_fp_context(struct sigcontext __user *sc);
+
+extern asmlinkage int fpu_emulator_save_context(struct sigcontext __user *sc);
+extern asmlinkage int fpu_emulator_restore_context(struct sigcontext __user *sc);
+
 /*
  * Horribly complicated - with the bloody RM9000 workarounds enabled
  * the signal trampolines is moving to the end of the structure so we can
@@ -709,3 +718,40 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 			key_replace_session_keyring();
 	}
 }
+
+#ifdef CONFIG_SMP
+static int smp_save_fp_context(struct sigcontext __user *sc)
+{
+	return raw_cpu_has_fpu
+	       ? _save_fp_context(sc)
+	       : fpu_emulator_save_context(sc);
+}
+
+static int smp_restore_fp_context(struct sigcontext __user *sc)
+{
+	return raw_cpu_has_fpu
+	       ? _restore_fp_context(sc)
+	       : fpu_emulator_restore_context(sc);
+}
+#endif
+
+static int signal_setup(void)
+{
+#ifdef CONFIG_SMP
+	/* For now just do the cpu_has_fpu check when the functions are invoked */
+	save_fp_context = smp_save_fp_context;
+	restore_fp_context = smp_restore_fp_context;
+#else
+	if (cpu_has_fpu) {
+		save_fp_context = _save_fp_context;
+		restore_fp_context = _restore_fp_context;
+	} else {
+		save_fp_context = fpu_emulator_save_context;
+		restore_fp_context = fpu_emulator_restore_context;
+	}
+#endif
+
+	return 0;
+}
+
+arch_initcall(signal_setup);
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 2e74075..03abaf0 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -35,6 +35,15 @@
 
 #include "signal-common.h"
 
+static int (*save_fp_context32)(struct sigcontext32 __user *sc);
+static int (*restore_fp_context32)(struct sigcontext32 __user *sc);
+
+extern asmlinkage int _save_fp_context32(struct sigcontext32 __user *sc);
+extern asmlinkage int _restore_fp_context32(struct sigcontext32 __user *sc);
+
+extern asmlinkage int fpu_emulator_save_context32(struct sigcontext32 __user *sc);
+extern asmlinkage int fpu_emulator_restore_context32(struct sigcontext32 __user *sc);
+
 /*
  * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
  */
@@ -828,3 +837,18 @@ SYSCALL_DEFINE5(32_waitid, int, which, compat_pid_t, pid,
 	info.si_code |= __SI_CHLD;
 	return copy_siginfo_to_user32(uinfo, &info);
 }
+
+static int signal32_init(void)
+{
+	if (cpu_has_fpu) {
+		save_fp_context32 = _save_fp_context32;
+		restore_fp_context32 = _restore_fp_context32;
+	} else {
+		save_fp_context32 = fpu_emulator_save_context32;
+		restore_fp_context32 = fpu_emulator_restore_context32;
+	}
+
+	return 0;
+}
+
+arch_initcall(signal32_init);
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 2c5c3a2..c3d786d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1395,77 +1395,6 @@ void *set_vi_handler(int n, vi_handler_t addr)
 	return set_vi_srs_handler(n, addr, 0);
 }
 
-/*
- * This is used by native signal handling
- */
-asmlinkage int (*save_fp_context)(struct sigcontext __user *sc);
-asmlinkage int (*restore_fp_context)(struct sigcontext __user *sc);
-
-extern asmlinkage int _save_fp_context(struct sigcontext __user *sc);
-extern asmlinkage int _restore_fp_context(struct sigcontext __user *sc);
-
-extern asmlinkage int fpu_emulator_save_context(struct sigcontext __user *sc);
-extern asmlinkage int fpu_emulator_restore_context(struct sigcontext __user *sc);
-
-#ifdef CONFIG_SMP
-static int smp_save_fp_context(struct sigcontext __user *sc)
-{
-	return raw_cpu_has_fpu
-	       ? _save_fp_context(sc)
-	       : fpu_emulator_save_context(sc);
-}
-
-static int smp_restore_fp_context(struct sigcontext __user *sc)
-{
-	return raw_cpu_has_fpu
-	       ? _restore_fp_context(sc)
-	       : fpu_emulator_restore_context(sc);
-}
-#endif
-
-static inline void signal_init(void)
-{
-#ifdef CONFIG_SMP
-	/* For now just do the cpu_has_fpu check when the functions are invoked */
-	save_fp_context = smp_save_fp_context;
-	restore_fp_context = smp_restore_fp_context;
-#else
-	if (cpu_has_fpu) {
-		save_fp_context = _save_fp_context;
-		restore_fp_context = _restore_fp_context;
-	} else {
-		save_fp_context = fpu_emulator_save_context;
-		restore_fp_context = fpu_emulator_restore_context;
-	}
-#endif
-}
-
-#ifdef CONFIG_MIPS32_COMPAT
-
-/*
- * This is used by 32-bit signal stuff on the 64-bit kernel
- */
-asmlinkage int (*save_fp_context32)(struct sigcontext32 __user *sc);
-asmlinkage int (*restore_fp_context32)(struct sigcontext32 __user *sc);
-
-extern asmlinkage int _save_fp_context32(struct sigcontext32 __user *sc);
-extern asmlinkage int _restore_fp_context32(struct sigcontext32 __user *sc);
-
-extern asmlinkage int fpu_emulator_save_context32(struct sigcontext32 __user *sc);
-extern asmlinkage int fpu_emulator_restore_context32(struct sigcontext32 __user *sc);
-
-static inline void signal32_init(void)
-{
-	if (cpu_has_fpu) {
-		save_fp_context32 = _save_fp_context32;
-		restore_fp_context32 = _restore_fp_context32;
-	} else {
-		save_fp_context32 = fpu_emulator_save_context32;
-		restore_fp_context32 = fpu_emulator_restore_context32;
-	}
-}
-#endif
-
 extern void cpu_cache_init(void);
 extern void tlb_init(void);
 extern void flush_tlb_handlers(void);
@@ -1779,11 +1708,6 @@ void __init trap_init(void)
 	else
 		memcpy((void *)(ebase + 0x080), &except_vec3_generic, 0x80);
 
-	signal_init();
-#ifdef CONFIG_MIPS32_COMPAT
-	signal32_init();
-#endif
-
 	local_flush_icache_range(ebase, ebase + 0x400);
 	flush_tlb_handlers();
 
