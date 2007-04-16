Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2007 15:32:45 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:6345 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023302AbXDPOck (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2007 15:32:40 +0100
Received: from localhost (p1162-ipad34funabasi.chiba.ocn.ne.jp [124.85.58.162])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 435A0B6D3; Mon, 16 Apr 2007 23:32:36 +0900 (JST)
Date:	Mon, 16 Apr 2007 23:32:35 +0900 (JST)
Message-Id: <20070416.233235.75185596.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Retry {save,restore}_fp_context if failed in atomic
 context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070416.231944.41198415.anemo@mba.ocn.ne.jp>
References: <20070416.231944.41198415.anemo@mba.ocn.ne.jp>
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
X-archive-position: 14869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 16 Apr 2007 23:19:44 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> The save_fp_context()/restore_fp_context() might sleep on accessing
> user stack and therefore might lose FPU ownership in middle of them.
> 
> If these function failed due to "in_atomic" test in do_page_fault,
> touch the sigcontext area in non-atomic context and retry these
> save/restore operation.
> 
> This is a replacement of a (broken) fix which was titled "Allow CpU
> exception in kernel partially".
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

And this is for 2.6.20-stable.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch depends on:
> Subject: Re: [PATCH] Disallow CpU exception in kernel again.
> Message-Id: <20070414.024450.07456615.anemo@mba.ocn.ne.jp>

 arch/mips/kernel/signal-common.h |   59 +++++++++++++++++++++++++++++++-----
 arch/mips/kernel/signal.c        |    2 +-
 arch/mips/kernel/signal32.c      |   61 ++++++++++++++++++++++++++++++++-----
 arch/mips/kernel/signal_n32.c    |    2 +-
 include/asm-mips/fpu.h           |    9 ++++-
 5 files changed, 112 insertions(+), 21 deletions(-)

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index b625e9c..6e479f6 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -9,6 +9,55 @@
  */
 
 
+/* Make sure we will not lose FPU ownership */
+#ifdef CONFIG_PREEMPT
+#define lock_fpu_owner()	preempt_disable()
+#define unlock_fpu_owner()	preempt_enable()
+#else
+#define lock_fpu_owner()	pagefault_disable()
+#define unlock_fpu_owner()	pagefault_enable()
+#endif
+
+static inline int protected_save_fp_context(struct sigcontext __user *sc)
+{
+	int err;
+	while (1) {
+		lock_fpu_owner();
+		own_fpu(1);
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
+static inline int protected_restore_fp_context(struct sigcontext __user *sc)
+{
+	int err, tmp;
+	while (1) {
+		lock_fpu_owner();
+		own_fpu(0);
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
 static inline int
 setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 {
@@ -51,10 +100,7 @@ setup_sigcontext(struct pt_regs *regs, s
 	 * Save FPU state to signal context.  Signal handler will "inherit"
 	 * current FPU state.
 	 */
-	preempt_disable();
-	own_fpu(1);
-	err |= save_fp_context(sc);
-	preempt_enable();
+	err |= protected_save_fp_context(sc);
 
 out:
 	return err;
@@ -71,10 +117,7 @@ check_and_restore_fp_context(struct sigc
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
 
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 60960f7..95d9585 100644
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
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 1a3f541..fee8547 100644
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
@@ -137,6 +137,55 @@ struct ucontext32 {
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
+static int protected_save_fp_context32(struct sigcontext32 __user *sc)
+{
+	int err;
+	while (1) {
+		lock_fpu_owner();
+		own_fpu(1);
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
+		own_fpu(0);
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
 static int
 check_and_restore_fp_context32(struct sigcontext32 __user *sc)
 {
@@ -145,10 +194,7 @@ check_and_restore_fp_context32(struct si
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
 
@@ -614,10 +660,7 @@ static inline int setup_sigcontext32(str
 	 * Save FPU state to signal context.  Signal handler will "inherit"
 	 * current FPU state.
 	 */
-	preempt_disable();
-	own_fpu(1);
-	err |= save_fp_context32(sc);
-	preempt_enable();
+	err |= protected_save_fp_context32(sc);
 
 out:
 	return err;
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 617edd9..2279963 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -28,12 +28,12 @@
 #include <linux/unistd.h>
 #include <linux/compat.h>
 #include <linux/bitops.h>
+#include <linux/uaccess.h>
 
 #include <asm/asm.h>
 #include <asm/cacheflush.h>
 #include <asm/compat-signal.h>
 #include <asm/sim.h>
-#include <asm/uaccess.h>
 #include <asm/ucontext.h>
 #include <asm/system.h>
 #include <asm/fpu.h>
diff --git a/include/asm-mips/fpu.h b/include/asm-mips/fpu.h
index 6b9d1bf..f5cdcaa 100644
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
 
