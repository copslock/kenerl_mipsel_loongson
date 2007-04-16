Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2007 15:21:08 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:34271 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023257AbXDPOVG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2007 15:21:06 +0100
Received: from localhost (p1162-ipad34funabasi.chiba.ocn.ne.jp [124.85.58.162])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C9EDEA5DE; Mon, 16 Apr 2007 23:19:44 +0900 (JST)
Date:	Mon, 16 Apr 2007 23:19:44 +0900 (JST)
Message-Id: <20070416.231944.41198415.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Retry {save,restore}_fp_context if failed in atomic
 context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The save_fp_context()/restore_fp_context() might sleep on accessing
user stack and therefore might lose FPU ownership in middle of them.

If these function failed due to "in_atomic" test in do_page_fault,
touch the sigcontext area in non-atomic context and retry these
save/restore operation.

This is a replacement of a (broken) fix which was titled "Allow CpU
exception in kernel partially".

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch depends on:
> Subject: Re: [PATCH] Disallow CpU exception in kernel again.
> Message-Id: <20070414.023726.128617751.anemo@mba.ocn.ne.jp>

 arch/mips/kernel/signal-common.h |    9 ++++++
 arch/mips/kernel/signal.c        |   52 +++++++++++++++++++++++++++++++------
 arch/mips/kernel/signal32.c      |   52 +++++++++++++++++++++++++++++++------
 include/asm-mips/fpu.h           |    9 +++++-
 4 files changed, 102 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index 297dfcb..c0faabd 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -34,4 +34,13 @@ extern int install_sigtramp(unsigned int
 /* Check and clear pending FPU exceptions in saved CSR */
 extern int fpcsr_pending(unsigned int __user *fpcsr);
 
+/* Make sure we will not lose FPU ownership */
+#ifdef CONFIG_PREEMPT
+#define lock_fpu_owner()	preempt_disable()
+#define unlock_fpu_owner()	preempt_enable()
+#else
+#define lock_fpu_owner()	pagefault_disable()
+#define unlock_fpu_owner()	pagefault_enable()
+#endif
+
 #endif	/* __SIGNAL_COMMON_H */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index fa58119..07d6730 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -20,6 +20,7 @@
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/compiler.h>
+#include <linux/uaccess.h>
 
 #include <asm/abi.h>
 #include <asm/asm.h>
@@ -27,7 +28,6 @@
 #include <asm/cacheflush.h>
 #include <asm/fpu.h>
 #include <asm/sim.h>
-#include <asm/uaccess.h>
 #include <asm/ucontext.h>
 #include <asm/cpu-features.h>
 #include <asm/war.h>
@@ -78,6 +78,46 @@ struct rt_sigframe {
 /*
  * Helper routines
  */
+static int protected_save_fp_context(struct sigcontext __user *sc)
+{
+	int err;
+	while (1) {
+		lock_fpu_owner();
+		own_fpu_inatomic(1);
+		err = save_fp_context(sc); /* this might fail */
+		unlock_fpu_owner();
+		if (likely(!err))
+			break;
+		/* touch the sigcontext and try again */
+		err = __put_user(0, &sc->sc_fpregs[0]) |
+			__put_user(0, &sc->sc_fpregs[31]) |
+			__put_user(0, &sc->sc_fpc_csr);
+		if (err)
+			break;	/* really bad sigcontext */
+	}
+	return err;
+}
+
+static int protected_restore_fp_context(struct sigcontext __user *sc)
+{
+	int err, tmp;
+	while (1) {
+		lock_fpu_owner();
+		own_fpu_inatomic(0);
+		err = restore_fp_context(sc); /* this might fail */
+		unlock_fpu_owner();
+		if (likely(!err))
+			break;
+		/* touch the sigcontext and try again */
+		err = __get_user(tmp, &sc->sc_fpregs[0]) |
+			__get_user(tmp, &sc->sc_fpregs[31]) |
+			__get_user(tmp, &sc->sc_fpc_csr);
+		if (err)
+			break;	/* really bad sigcontext */
+	}
+	return err;
+}
+
 int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 {
 	int err = 0;
@@ -113,10 +153,7 @@ int setup_sigcontext(struct pt_regs *reg
 		 * Save FPU state to signal context. Signal handler
 		 * will "inherit" current FPU state.
 		 */
-		preempt_disable();
-		own_fpu(1);
-		err |= save_fp_context(sc);
-		preempt_enable();
+		err |= protected_save_fp_context(sc);
 	}
 	return err;
 }
@@ -148,10 +185,7 @@ check_and_restore_fp_context(struct sigc
 	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
 	if (err > 0)
 		err = 0;
-	preempt_disable();
-	own_fpu(0);
-	err |= restore_fp_context(sc);
-	preempt_enable();
+	err |= protected_restore_fp_context(sc);
 	return err ?: sig;
 }
 
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 53a337c..b9a0144 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -22,6 +22,7 @@
 #include <linux/compat.h>
 #include <linux/suspend.h>
 #include <linux/compiler.h>
+#include <linux/uaccess.h>
 
 #include <asm/abi.h>
 #include <asm/asm.h>
@@ -29,7 +30,6 @@
 #include <linux/bitops.h>
 #include <asm/cacheflush.h>
 #include <asm/sim.h>
-#include <asm/uaccess.h>
 #include <asm/ucontext.h>
 #include <asm/system.h>
 #include <asm/fpu.h>
@@ -176,6 +176,46 @@ struct rt_sigframe32 {
 /*
  * sigcontext handlers
  */
+static int protected_save_fp_context32(struct sigcontext32 __user *sc)
+{
+	int err;
+	while (1) {
+		lock_fpu_owner();
+		own_fpu_inatomic(1);
+		err = save_fp_context32(sc); /* this might fail */
+		unlock_fpu_owner();
+		if (likely(!err))
+			break;
+		/* touch the sigcontext and try again */
+		err = __put_user(0, &sc->sc_fpregs[0]) |
+			__put_user(0, &sc->sc_fpregs[31]) |
+			__put_user(0, &sc->sc_fpc_csr);
+		if (err)
+			break;	/* really bad sigcontext */
+	}
+	return err;
+}
+
+static int protected_restore_fp_context32(struct sigcontext32 __user *sc)
+{
+	int err, tmp;
+	while (1) {
+		lock_fpu_owner();
+		own_fpu_inatomic(0);
+		err = restore_fp_context32(sc); /* this might fail */
+		unlock_fpu_owner();
+		if (likely(!err))
+			break;
+		/* touch the sigcontext and try again */
+		err = __get_user(tmp, &sc->sc_fpregs[0]) |
+			__get_user(tmp, &sc->sc_fpregs[31]) |
+			__get_user(tmp, &sc->sc_fpc_csr);
+		if (err)
+			break;	/* really bad sigcontext */
+	}
+	return err;
+}
+
 static int setup_sigcontext32(struct pt_regs *regs,
 			      struct sigcontext32 __user *sc)
 {
@@ -209,10 +249,7 @@ static int setup_sigcontext32(struct pt_
 		 * Save FPU state to signal context.  Signal handler
 		 * will "inherit" current FPU state.
 		 */
-		preempt_disable();
-		own_fpu(1);
-		err |= save_fp_context32(sc);
-		preempt_enable();
+		err |= protected_save_fp_context32(sc);
 	}
 	return err;
 }
@@ -225,10 +262,7 @@ check_and_restore_fp_context32(struct si
 	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
 	if (err > 0)
 		err = 0;
-	preempt_disable();
-	own_fpu(0);
-	err |= restore_fp_context32(sc);
-	preempt_enable();
+	err |= protected_restore_fp_context32(sc);
 	return err ?: sig;
 }
 
diff --git a/include/asm-mips/fpu.h b/include/asm-mips/fpu.h
index 71436f9..b414a7d 100644
--- a/include/asm-mips/fpu.h
+++ b/include/asm-mips/fpu.h
@@ -100,14 +100,19 @@ static inline void __own_fpu(void)
 	set_thread_flag(TIF_USEDFPU);
 }
 
-static inline void own_fpu(int restore)
+static inline void own_fpu_inatomic(int restore)
 {
-	preempt_disable();
 	if (cpu_has_fpu && !__is_fpu_owner()) {
 		__own_fpu();
 		if (restore)
 			_restore_fp(current);
 	}
+}
+
+static inline void own_fpu(int restore)
+{
+	preempt_disable();
+	own_fpu_inatomic(restore);
 	preempt_enable();
 }
 
