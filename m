Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 14:12:19 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.227]:28283 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20048458AbXAXOKv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 14:10:51 +0000
Received: by hu-out-0506.google.com with SMTP id 22so152630hug
        for <linux-mips@linux-mips.org>; Wed, 24 Jan 2007 06:09:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=C+VifruTBorU/41KB1IaL+1GjQ6icwN88csdklsGLZJcbs8EhHNXcod+H34BhqU1LtYCP+L7vgxztUpTIGVdAUAymgr6FIeiJIEPMg4yByewJVMtKUNRingSzSarl+rumDmE5co0vm6q49A1I3FcwUf3uYAyb08DXBTDV666StM=
Received: by 10.48.48.18 with SMTP id v18mr2917476nfv.1169647788215;
        Wed, 24 Jan 2007 06:09:48 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id r34sm6542980nfc.2007.01.24.06.09.44;
        Wed, 24 Jan 2007 06:09:46 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 9B10423F772; Wed, 24 Jan 2007 15:12:11 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 4/8] signal32: remove code duplication
Date:	Wed, 24 Jan 2007 15:12:07 +0100
Message-Id: <11696479312006-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <11696479312279-git-send-email-fbuihuu@gmail.com>
References: <11696479312279-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

There's no point for signal32.c to redefine get_sigframe().
It should use the one define in signal.c instead.

The same stands for install_sigtramp().

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal32.c |   50 +++---------------------------------------
 1 files changed, 4 insertions(+), 46 deletions(-)

diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index e0a8553..5934f33 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -33,6 +33,8 @@
 #include <asm/fpu.h>
 #include <asm/war.h>
 
+#include "signal-common.h"
+
 #define SI_PAD_SIZE32   ((SI_MAX_SIZE/sizeof(int)) - 3)
 
 typedef struct compat_siginfo {
@@ -604,32 +606,6 @@ out:
 	return err;
 }
 
-/*
- * Determine which stack to use..
- */
-static inline void __user *get_sigframe(struct k_sigaction *ka,
-					struct pt_regs *regs,
-					size_t frame_size)
-{
-	unsigned long sp;
-
-	/* Default to using normal stack */
-	sp = regs->regs[29];
-
-	/*
-	 * FPU emulator may have it's own trampoline active just
-	 * above the user stack, 16-bytes before the next lowest
-	 * 16 byte boundary.  Try to avoid trashing it.
-	 */
-	sp -= 32;
-
-	/* This is the X/Open sanctioned signal stack switching.  */
-	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags (sp) == 0))
-		sp = current->sas_ss_sp + current->sas_ss_size;
-
-	return (void __user *)((sp - frame_size) & ALMASK);
-}
-
 int setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
 	int signr, sigset_t *set)
 {
@@ -640,15 +616,7 @@ int setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	/*
-	 * Set up the return code ...
-	 *
-	 *         li      v0, __NR_O32_sigreturn
-	 *         syscall
-	 */
-	err |= __put_user(0x24020000 + __NR_O32_sigreturn, frame->sf_code + 0);
-	err |= __put_user(0x0000000c                     , frame->sf_code + 1);
-	flush_cache_sigtramp((unsigned long) frame->sf_code);
+	err |= install_sigtramp(frame->sf_code, __NR_O32_sigreturn);
 
 	err |= setup_sigcontext32(regs, &frame->sf_sc);
 	err |= __copy_to_user(&frame->sf_mask, set, sizeof(*set));
@@ -695,17 +663,7 @@ int setup_rt_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	/* Set up to return from userspace.  If provided, use a stub already
-	   in userspace.  */
-	/*
-	 * Set up the return code ...
-	 *
-	 *         li      v0, __NR_O32_rt_sigreturn
-	 *         syscall
-	 */
-	err |= __put_user(0x24020000 + __NR_O32_rt_sigreturn, frame->rs_code + 0);
-	err |= __put_user(0x0000000c                      , frame->rs_code + 1);
-	flush_cache_sigtramp((unsigned long) frame->rs_code);
+	err |= install_sigtramp(frame->rs_code, __NR_O32_rt_sigreturn);
 
 	/* Convert (siginfo_t -> compat_siginfo_t) and copy to user. */
 	err |= copy_siginfo_to_user32(&frame->rs_info, info);
-- 
1.4.4.3.ge6d4
