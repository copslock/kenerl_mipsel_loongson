Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:33:16 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44714 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827297AbaA0UYfsPcb0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:24:35 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 38/58] MIPS: kernel: signal: Prevent save/restore FPU context in user memory
Date:   Mon, 27 Jan 2014 20:19:25 +0000
Message-ID: <1390853985-14246-39-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_24_30
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

EVA does not have FPU specific instructions for reading or writing
FPU registers from userspace memory.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/signal.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 5199563..6f4937b 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -6,6 +6,7 @@
  * Copyright (C) 1991, 1992  Linus Torvalds
  * Copyright (C) 1994 - 2000  Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2014, Imagination Technologies Ltd.
  */
 #include <linux/cache.h>
 #include <linux/context_tracking.h>
@@ -69,6 +70,7 @@ struct rt_sigframe {
 static int protected_save_fp_context(struct sigcontext __user *sc)
 {
 	int err;
+#ifndef CONFIG_EVA
 	while (1) {
 		lock_fpu_owner();
 		err = own_fpu_inatomic(1);
@@ -84,12 +86,21 @@ static int protected_save_fp_context(struct sigcontext __user *sc)
 		if (err)
 			break;	/* really bad sigcontext */
 	}
+#else
+	/*
+	 * EVA does not have FPU EVA instructions so saving fpu context directly
+	 * does not work.
+	 */
+	lose_fpu(1);
+	err = save_fp_context(sc); /* this might fail */
+#endif
 	return err;
 }
 
 static int protected_restore_fp_context(struct sigcontext __user *sc)
 {
 	int err, tmp __maybe_unused;
+#ifndef CONFIG_EVA
 	while (1) {
 		lock_fpu_owner();
 		err = own_fpu_inatomic(0);
@@ -105,6 +116,14 @@ static int protected_restore_fp_context(struct sigcontext __user *sc)
 		if (err)
 			break;	/* really bad sigcontext */
 	}
+#else
+	/*
+	 * EVA does not have FPU EVA instructions so restoring fpu context
+	 * directly does not work.
+	 */
+	lose_fpu(0);
+	err = restore_fp_context(sc); /* this might fail */
+#endif
 	return err;
 }
 
@@ -591,6 +610,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 }
 
 #ifdef CONFIG_SMP
+#ifndef CONFIG_EVA
 static int smp_save_fp_context(struct sigcontext __user *sc)
 {
 	return raw_cpu_has_fpu
@@ -604,10 +624,12 @@ static int smp_restore_fp_context(struct sigcontext __user *sc)
 	       ? _restore_fp_context(sc)
 	       : fpu_emulator_restore_context(sc);
 }
+#endif /* CONFIG_EVA */
 #endif
 
 static int signal_setup(void)
 {
+#ifndef CONFIG_EVA
 #ifdef CONFIG_SMP
 	/* For now just do the cpu_has_fpu check when the functions are invoked */
 	save_fp_context = smp_save_fp_context;
@@ -620,6 +642,10 @@ static int signal_setup(void)
 		save_fp_context = fpu_emulator_save_context;
 		restore_fp_context = fpu_emulator_restore_context;
 	}
+#endif /* CONFIG_SMP */
+#else
+	save_fp_context = fpu_emulator_save_context;
+	restore_fp_context = fpu_emulator_restore_context;
 #endif
 
 	return 0;
-- 
1.8.5.3
