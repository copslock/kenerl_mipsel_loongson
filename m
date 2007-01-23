Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 14:18:51 +0000 (GMT)
Received: from an-out-0708.google.com ([209.85.132.251]:34836 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20044414AbXAWOQK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 14:16:10 +0000
Received: by an-out-0708.google.com with SMTP id c8so651520ana
        for <linux-mips@linux-mips.org>; Tue, 23 Jan 2007 06:16:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=HVEe69aZ8En9LiRiN9i5VVb9brN4/5jym3t8hulLvzaDBf9LWkDKFf5KDpmXm2Y429KDb8QC6cSxSsMXTixWgeYei1d+ZoEWqblPfFjgWsYfiM5jHziq1i9s7fT8dbKspI7iapzoijzK8gQunSbIDBxO9VdihnY9MPw5Nm7qyFw=
Received: by 10.49.12.4 with SMTP id p4mr1116543nfi.1169561763627;
        Tue, 23 Jan 2007 06:16:03 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id z73sm2704375nfb.2007.01.23.06.15.58;
        Tue, 23 Jan 2007 06:16:03 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id A551C23F770; Tue, 23 Jan 2007 15:18:23 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 3/7] signal: clean up sigframe structure
Date:	Tue, 23 Jan 2007 15:18:19 +0100
Message-Id: <11695619031474-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <1169561903878-git-send-email-fbuihuu@gmail.com>
References: <1169561903878-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13753
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
index 03d2b60..5838f6d 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -12,6 +12,32 @@
 #define __SIGNAL_COMMON_H
 
 /*
+ * Horribly complicated - with the bloody RM9000 workarounds enabled
+ * the signal trampolines is moving to the end of the structure so we can
+ * increase the alignment without breaking software compatibility.
+ */
+#ifndef ICACHE_REFILLS_WORKAROUND_WAR
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
index 50b9191..468c74d 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -38,6 +38,27 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
+#ifndef ICACHE_REFILLS_WORKAROUND_WAR
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
@@ -290,41 +311,6 @@ asmlinkage int sys_sigaltstack(nabi_no_regargs struct pt_regs regs)
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
index c86a5dd..e5125ad 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -139,6 +139,27 @@ struct ucontext32 {
 	sigset_t32          uc_sigmask;   /* mask last for extensibility */
 };
 
+#ifndef ICACHE_REFILLS_WORKAROUND_WAR
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
index a67c185..3830757 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -66,20 +66,27 @@ struct ucontextn32 {
 	sigset_t            uc_sigmask;   /* mask last for extensibility */
 };
 
+#ifndef ICACHE_REFILLS_WORKAROUND_WAR
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
