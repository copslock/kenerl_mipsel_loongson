Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 14:10:55 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.230]:25723 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20048447AbXAXOKt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 14:10:49 +0000
Received: by hu-out-0506.google.com with SMTP id 22so152615hug
        for <linux-mips@linux-mips.org>; Wed, 24 Jan 2007 06:09:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=dvh9OjVdbhKG54Cn97ECUsSatMkJOKPzhz6tfnPU/t/8livSkZBdyE83ul3gHPqk1Mgd04oPh+mgFtXXkdoArJTMeVx52NCTwGR+336roFtaZAu/UmzHz6JgcD7UkR+2NOu+hEdmCFfbsixBuPJQ3+DQbGPPfCahLqN/XyRFTnI=
Received: by 10.49.93.13 with SMTP id v13mr2952529nfl.1169647788415;
        Wed, 24 Jan 2007 06:09:48 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id y24sm6535130nfb.2007.01.24.06.09.45;
        Wed, 24 Jan 2007 06:09:46 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 710AB23F770; Wed, 24 Jan 2007 15:12:11 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 3/8] signal: clean up sigframe structure
Date:	Wed, 24 Jan 2007 15:12:06 +0100
Message-Id: <11696479312502-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <11696479312279-git-send-email-fbuihuu@gmail.com>
References: <11696479312279-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch makes 'struct sigframe' declaration avalaible for all signals
code. It allows signal32 to not have its own declaration.

This patch also removes all ICACHE_REFILLS_WORKAROUND_WAR tests in
structure declaration and hopefully make them more readable.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal-common.h |   26 +++++++++++++++++
 arch/mips/kernel/signal.c        |   56 ++++++++++++++-----------------------
 arch/mips/kernel/signal32.c      |   49 ++++++++++++++-------------------
 arch/mips/kernel/signal_n32.c    |   19 +++++++++----
 4 files changed, 81 insertions(+), 69 deletions(-)

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index 03d2b60..6700bde 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -12,6 +12,32 @@
 #define __SIGNAL_COMMON_H
 
 /*
+ * Horribly complicated - with the bloody RM9000 workarounds enabled
+ * the signal trampolines is moving to the end of the structure so we can
+ * increase the alignment without breaking software compatibility.
+ */
+#if ICACHE_REFILLS_WORKAROUND_WAR == 0
+
+struct sigframe {
+	u32 sf_ass[4];		/* argument save space for o32 */
+	u32 sf_code[2];		/* signal trampoline */
+	struct sigcontext sf_sc;
+	sigset_t sf_mask;
+};
+
+#else  /* ICACHE_REFILLS_WORKAROUND_WAR */
+
+struct sigframe {
+	u32 sf_ass[4];			/* argument save space for o32 */
+	u32 sf_pad[2];
+	struct sigcontext sf_sc;	/* hw context */
+	sigset_t sf_mask;
+	u32 sf_code[8] ____cacheline_aligned;	/* signal trampoline */
+};
+
+#endif	/* !ICACHE_REFILLS_WORKAROUND_WAR */
+
+/*
  * handle hardware context
  */
 extern int setup_sigcontext(struct pt_regs *, struct sigcontext __user *);
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 7ec73f2..41033be 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -38,6 +38,27 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
+#if ICACHE_REFILLS_WORKAROUND_WAR == 0
+
+struct rt_sigframe {
+	u32 rs_ass[4];		/* argument save space for o32 */
+	u32 rs_code[2];		/* signal trampoline */
+	struct siginfo rs_info;
+	struct ucontext rs_uc;
+};
+
+#else
+
+struct rt_sigframe {
+	u32 rs_ass[4];			/* argument save space for o32 */
+	u32 rs_pad[2];
+	struct siginfo rs_info;
+	struct ucontext rs_uc;
+	u32 rs_code[8] ____cacheline_aligned;	/* signal trampoline */
+};
+
+#endif
+
 /*
  * Helper routines
  */
@@ -287,41 +308,6 @@ asmlinkage int sys_sigaltstack(nabi_no_regargs struct pt_regs regs)
 	return do_sigaltstack(uss, uoss, usp);
 }
 
-/*
- * Horribly complicated - with the bloody RM9000 workarounds enabled
- * the signal trampolines is moving to the end of the structure so we can
- * increase the alignment without breaking software compatibility.
- */
-#ifdef CONFIG_TRAD_SIGNALS
-struct sigframe {
-	u32 sf_ass[4];			/* argument save space for o32 */
-#if ICACHE_REFILLS_WORKAROUND_WAR
-	u32 sf_pad[2];
-#else
-	u32 sf_code[2];			/* signal trampoline */
-#endif
-	struct sigcontext sf_sc;
-	sigset_t sf_mask;
-#if ICACHE_REFILLS_WORKAROUND_WAR
-	u32 sf_code[8] ____cacheline_aligned;	/* signal trampoline */
-#endif
-};
-#endif
-
-struct rt_sigframe {
-	u32 rs_ass[4];			/* argument save space for o32 */
-#if ICACHE_REFILLS_WORKAROUND_WAR
-	u32 rs_pad[2];
-#else
-	u32 rs_code[2];			/* signal trampoline */
-#endif
-	struct siginfo rs_info;
-	struct ucontext rs_uc;
-#if ICACHE_REFILLS_WORKAROUND_WAR
-	u32 rs_code[8] ____cacheline_aligned;	/* signal trampoline */
-#endif
-};
-
 #ifdef CONFIG_TRAD_SIGNALS
 save_static_function(sys_sigreturn);
 __attribute_used__ noinline static void
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index c86a5dd..e0a8553 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -139,6 +139,27 @@ struct ucontext32 {
 	sigset_t32          uc_sigmask;   /* mask last for extensibility */
 };
 
+#if ICACHE_REFILLS_WORKAROUND_WAR == 0
+
+struct rt_sigframe32 {
+	u32 rs_ass[4];			/* argument save space for o32 */
+	u32 rs_code[2];			/* signal trampoline */
+	compat_siginfo_t rs_info;
+	struct ucontext32 rs_uc;
+};
+
+#else  /* ICACHE_REFILLS_WORKAROUND_WAR */
+
+struct rt_sigframe32 {
+	u32 rs_ass[4];			/* argument save space for o32 */
+	u32 rs_pad[2];
+	compat_siginfo_t rs_info;
+	struct ucontext32 rs_uc;
+	u32 rs_code[8] __attribute__((aligned(32)));	/* signal trampoline */
+};
+
+#endif	/* !ICACHE_REFILLS_WORKAROUND_WAR */
+
 extern void __put_sigset_unknown_nsig(void);
 extern void __get_sigset_unknown_nsig(void);
 
@@ -383,34 +404,6 @@ static int restore_sigcontext32(struct pt_regs *regs, struct sigcontext32 __user
 	return err;
 }
 
-struct sigframe {
-	u32 sf_ass[4];			/* argument save space for o32 */
-#if ICACHE_REFILLS_WORKAROUND_WAR
-	u32 sf_pad[2];
-#else
-	u32 sf_code[2];			/* signal trampoline */
-#endif
-	struct sigcontext32 sf_sc;
-	sigset_t sf_mask;
-#if ICACHE_REFILLS_WORKAROUND_WAR
-	u32 sf_code[8] ____cacheline_aligned;	/* signal trampoline */
-#endif
-};
-
-struct rt_sigframe32 {
-	u32 rs_ass[4];			/* argument save space for o32 */
-#if ICACHE_REFILLS_WORKAROUND_WAR
-	u32 rs_pad[2];
-#else
-	u32 rs_code[2];			/* signal trampoline */
-#endif
-	compat_siginfo_t rs_info;
-	struct ucontext32 rs_uc;
-#if ICACHE_REFILLS_WORKAROUND_WAR
-	u32 rs_code[8] __attribute__((aligned(32)));	/* signal trampoline */
-#endif
-};
-
 int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
 {
 	int err;
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index a67c185..f8e1539 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -66,20 +66,27 @@ struct ucontextn32 {
 	sigset_t            uc_sigmask;   /* mask last for extensibility */
 };
 
+#if ICACHE_REFILLS_WORKAROUND_WAR == 0
+
 struct rt_sigframe_n32 {
 	u32 rs_ass[4];			/* argument save space for o32 */
-#if ICACHE_REFILLS_WORKAROUND_WAR
-	u32 rs_pad[2];
-#else
 	u32 rs_code[2];			/* signal trampoline */
-#endif
 	struct siginfo rs_info;
 	struct ucontextn32 rs_uc;
-#if ICACHE_REFILLS_WORKAROUND_WAR
+};
+
+#else  /* ICACHE_REFILLS_WORKAROUND_WAR */
+
+struct rt_sigframe_n32 {
+	u32 rs_ass[4];			/* argument save space for o32 */
+	u32 rs_pad[2];
+	struct siginfo rs_info;
+	struct ucontextn32 rs_uc;
 	u32 rs_code[8] ____cacheline_aligned;		/* signal trampoline */
-#endif
 };
 
+#endif	/* !ICACHE_REFILLS_WORKAROUND_WAR */
+
 extern void sigset_from_compat (sigset_t *set, compat_sigset_t *compat);
 
 save_static_function(sysn32_rt_sigsuspend);
-- 
1.4.4.3.ge6d4
