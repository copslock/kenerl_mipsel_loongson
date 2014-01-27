Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 16:24:42 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:4430 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824805AbaA0PXqBV4j3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 16:23:46 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 03/15] mips: move & rename fpu_emulator_{save,restore}_context
Date:   Mon, 27 Jan 2014 15:23:02 +0000
Message-ID: <1390836194-26286-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_27_15_23_46
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

These functions aren't directly related to the FPU emulator at all, they
simply copy between a thread's saved context & a sigcontext. Thus move
them to the appropriate signal files & rename them accordingly. This
makes it clearer that the functions don't require the FPU emulator in
any way.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
---
 arch/mips/kernel/signal.c           | 45 ++++++++++++++++++----
 arch/mips/kernel/signal32.c         | 43 ++++++++++++++++++---
 arch/mips/math-emu/kernel_linkage.c | 75 -------------------------------------
 3 files changed, 76 insertions(+), 87 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 5199563..b7e4614 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -46,9 +46,6 @@ static int (*restore_fp_context)(struct sigcontext __user *sc);
 extern asmlinkage int _save_fp_context(struct sigcontext __user *sc);
 extern asmlinkage int _restore_fp_context(struct sigcontext __user *sc);
 
-extern asmlinkage int fpu_emulator_save_context(struct sigcontext __user *sc);
-extern asmlinkage int fpu_emulator_restore_context(struct sigcontext __user *sc);
-
 struct sigframe {
 	u32 sf_ass[4];		/* argument save space for o32 */
 	u32 sf_pad[2];		/* Was: signal trampoline */
@@ -64,6 +61,40 @@ struct rt_sigframe {
 };
 
 /*
+ * Thread saved context copy to/from a signal context presumed to be on the
+ * user stack, and therefore accessed with appropriate macros from uaccess.h.
+ */
+static int copy_fp_to_sigcontext(struct sigcontext __user *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < 32; i++) {
+		err |=
+		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
+			       &sc->sc_fpregs[i]);
+	}
+	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
+
+	return err;
+}
+
+static int copy_fp_from_sigcontext(struct sigcontext __user *sc)
+{
+	int i;
+	int err = 0;
+	u64 fpr_val;
+
+	for (i = 0; i < 32; i++) {
+		err |= __get_user(fpr_val, &sc->sc_fpregs[i]);
+		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
+	}
+	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
+
+	return err;
+}
+
+/*
  * Helper routines
  */
 static int protected_save_fp_context(struct sigcontext __user *sc)
@@ -595,14 +626,14 @@ static int smp_save_fp_context(struct sigcontext __user *sc)
 {
 	return raw_cpu_has_fpu
 	       ? _save_fp_context(sc)
-	       : fpu_emulator_save_context(sc);
+	       : copy_fp_to_sigcontext(sc);
 }
 
 static int smp_restore_fp_context(struct sigcontext __user *sc)
 {
 	return raw_cpu_has_fpu
 	       ? _restore_fp_context(sc)
-	       : fpu_emulator_restore_context(sc);
+	       : copy_fp_from_sigcontext(sc);
 }
 #endif
 
@@ -617,8 +648,8 @@ static int signal_setup(void)
 		save_fp_context = _save_fp_context;
 		restore_fp_context = _restore_fp_context;
 	} else {
-		save_fp_context = fpu_emulator_save_context;
-		restore_fp_context = fpu_emulator_restore_context;
+		save_fp_context = copy_fp_from_sigcontext;
+		restore_fp_context = copy_fp_to_sigcontext;
 	}
 #endif
 
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 3d60f77..dc09206 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -42,9 +42,6 @@ static int (*restore_fp_context32)(struct sigcontext32 __user *sc);
 extern asmlinkage int _save_fp_context32(struct sigcontext32 __user *sc);
 extern asmlinkage int _restore_fp_context32(struct sigcontext32 __user *sc);
 
-extern asmlinkage int fpu_emulator_save_context32(struct sigcontext32 __user *sc);
-extern asmlinkage int fpu_emulator_restore_context32(struct sigcontext32 __user *sc);
-
 /*
  * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
  */
@@ -78,6 +75,42 @@ struct rt_sigframe32 {
 };
 
 /*
+ * Thread saved context copy to/from a signal context presumed to be on the
+ * user stack, and therefore accessed with appropriate macros from uaccess.h.
+ */
+static int copy_fp_to_sigcontext32(struct sigcontext32 __user *sc)
+{
+	int i;
+	int err = 0;
+	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
+
+	for (i = 0; i < 32; i += inc) {
+		err |=
+		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
+			       &sc->sc_fpregs[i]);
+	}
+	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
+
+	return err;
+}
+
+static int copy_fp_from_sigcontext32(struct sigcontext32 __user *sc)
+{
+	int i;
+	int err = 0;
+	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
+	u64 fpr_val;
+
+	for (i = 0; i < 32; i += inc) {
+		err |= __get_user(fpr_val, &sc->sc_fpregs[i]);
+		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
+	}
+	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
+
+	return err;
+}
+
+/*
  * sigcontext handlers
  */
 static int protected_save_fp_context32(struct sigcontext32 __user *sc)
@@ -566,8 +599,8 @@ static int signal32_init(void)
 		save_fp_context32 = _save_fp_context32;
 		restore_fp_context32 = _restore_fp_context32;
 	} else {
-		save_fp_context32 = fpu_emulator_save_context32;
-		restore_fp_context32 = fpu_emulator_restore_context32;
+		save_fp_context32 = copy_fp_to_sigcontext32;
+		restore_fp_context32 = copy_fp_from_sigcontext32;
 	}
 
 	return 0;
diff --git a/arch/mips/math-emu/kernel_linkage.c b/arch/mips/math-emu/kernel_linkage.c
index 9b46213..eb58a85 100644
--- a/arch/mips/math-emu/kernel_linkage.c
+++ b/arch/mips/math-emu/kernel_linkage.c
@@ -43,78 +43,3 @@ void fpu_emulator_init_fpu(void)
 	for (i = 0; i < 32; i++)
 		set_fpr64(&current->thread.fpu.fpr[i], 0, SIGNALLING_NAN);
 }
-
-
-/*
- * Emulator context save/restore to/from a signal context
- * presumed to be on the user stack, and therefore accessed
- * with appropriate macros from uaccess.h
- */
-
-int fpu_emulator_save_context(struct sigcontext __user *sc)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < 32; i++) {
-		err |=
-		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
-			       &sc->sc_fpregs[i]);
-	}
-	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-int fpu_emulator_restore_context(struct sigcontext __user *sc)
-{
-	int i;
-	int err = 0;
-	u64 fpr_val;
-
-	for (i = 0; i < 32; i++) {
-		err |= __get_user(fpr_val, &sc->sc_fpregs[i]);
-		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
-	}
-	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-#ifdef CONFIG_64BIT
-/*
- * This is the o32 version
- */
-
-int fpu_emulator_save_context32(struct sigcontext32 __user *sc)
-{
-	int i;
-	int err = 0;
-	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
-
-	for (i = 0; i < 32; i += inc) {
-		err |=
-		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
-			       &sc->sc_fpregs[i]);
-	}
-	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-int fpu_emulator_restore_context32(struct sigcontext32 __user *sc)
-{
-	int i;
-	int err = 0;
-	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
-	u64 fpr_val;
-
-	for (i = 0; i < 32; i += inc) {
-		err |= __get_user(fpr_val, &sc->sc_fpregs[i]);
-		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
-	}
-	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-#endif
-- 
1.8.5.3
