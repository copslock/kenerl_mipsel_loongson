Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 14:29:53 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.224]:8615 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037605AbXBEO0k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 14:26:40 +0000
Received: by hu-out-0506.google.com with SMTP id 22so786025hug
        for <linux-mips@linux-mips.org>; Mon, 05 Feb 2007 06:25:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=jIq2TAMsdfHmM1lpYmgWk258HVDsXNMXRjEQUg1yV3w2d7j0gSi9q/AGuRG/IL5JJv5Dc+W6fO+eu8pNGzDrK1LL9ZNR1qRTi9xMKnB/DidobRytdyJS/Su9LLp1OBbcQiGPYx7bhmWGrsPiA894JN6U3qyQypnUh0H9egg0VIU=
Received: by 10.49.43.2 with SMTP id v2mr2275053nfj.1170685533163;
        Mon, 05 Feb 2007 06:25:33 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id k9sm27259806nfc.2007.02.05.06.25.30;
        Mon, 05 Feb 2007 06:25:32 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 0C4B623F778; Mon,  5 Feb 2007 15:24:30 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 9/10] signal: do not use save_static_function() anymore
Date:	Mon,  5 Feb 2007 15:24:27 +0100
Message-Id: <11706854703880-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <11706854683935-git-send-email-fbuihuu@gmail.com>
References: <11706854683935-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This macro was used to save static registers before calling
sys_sigsuspend() and sys_sigreturn().

For the sys_sigreturn() case, there's no point to save them
since they have been already saved by setup_sigcontext()
before calling the signal handler.

For the sys_sigsuspend() case, I don't see any reasons...

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal.c     |   16 ++++------------
 arch/mips/kernel/signal32.c   |   16 ++++------------
 arch/mips/kernel/signal_n32.c |    8 ++------
 3 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index d3f6b0a..32d4022 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -201,9 +201,7 @@ int install_sigtramp(unsigned int __user *tramp, unsigned int syscall)
  */
 
 #ifdef CONFIG_TRAD_SIGNALS
-save_static_function(sys_sigsuspend);
-__attribute_used__ noinline static int
-_sys_sigsuspend(nabi_no_regargs struct pt_regs regs)
+asmlinkage int sys_sigsuspend(nabi_no_regargs struct pt_regs regs)
 {
 	sigset_t newset;
 	sigset_t __user *uset;
@@ -226,9 +224,7 @@ _sys_sigsuspend(nabi_no_regargs struct pt_regs regs)
 }
 #endif
 
-save_static_function(sys_rt_sigsuspend);
-__attribute_used__ noinline static int
-_sys_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
+asmlinkage int sys_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
 {
 	sigset_t newset;
 	sigset_t __user *unewset;
@@ -307,9 +303,7 @@ asmlinkage int sys_sigaltstack(nabi_no_regargs struct pt_regs regs)
 }
 
 #ifdef CONFIG_TRAD_SIGNALS
-save_static_function(sys_sigreturn);
-__attribute_used__ noinline static void
-_sys_sigreturn(nabi_no_regargs struct pt_regs regs)
+asmlinkage void sys_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct sigframe __user *frame;
 	sigset_t blocked;
@@ -344,9 +338,7 @@ badframe:
 }
 #endif /* CONFIG_TRAD_SIGNALS */
 
-save_static_function(sys_rt_sigreturn);
-__attribute_used__ noinline static void
-_sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
+asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct rt_sigframe __user *frame;
 	sigset_t set;
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 0994d6e..183fc7e 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -308,9 +308,7 @@ static inline int get_sigset(sigset_t *kbuf, const compat_sigset_t __user *ubuf)
  * Atomically swap in the new signal mask, and wait for a signal.
  */
 
-save_static_function(sys32_sigsuspend);
-__attribute_used__ noinline static int
-_sys32_sigsuspend(nabi_no_regargs struct pt_regs regs)
+asmlinkage int sys32_sigsuspend(nabi_no_regargs struct pt_regs regs)
 {
 	compat_sigset_t __user *uset;
 	sigset_t newset;
@@ -332,9 +330,7 @@ _sys32_sigsuspend(nabi_no_regargs struct pt_regs regs)
 	return -ERESTARTNOHAND;
 }
 
-save_static_function(sys32_rt_sigsuspend);
-__attribute_used__ noinline static int
-_sys32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
+asmlinkage int sys32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
 {
 	compat_sigset_t __user *uset;
 	sigset_t newset;
@@ -495,9 +491,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
 	return err;
 }
 
-save_static_function(sys32_sigreturn);
-__attribute_used__ noinline static void
-_sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
+asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct sigframe __user *frame;
 	sigset_t blocked;
@@ -531,9 +525,7 @@ badframe:
 	force_sig(SIGSEGV, current);
 }
 
-save_static_function(sys32_rt_sigreturn);
-__attribute_used__ noinline static void
-_sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
+asmlinkage void sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct rt_sigframe32 __user *frame;
 	mm_segment_t old_fs;
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index a6c1e67..35bfbc7 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -87,9 +87,7 @@ struct rt_sigframe_n32 {
 
 extern void sigset_from_compat (sigset_t *set, compat_sigset_t *compat);
 
-save_static_function(sysn32_rt_sigsuspend);
-__attribute_used__ noinline static int
-_sysn32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
+asmlinkage int sysn32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
 {
 	compat_sigset_t __user *unewset;
 	compat_sigset_t uset;
@@ -119,9 +117,7 @@ _sysn32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
 	return -ERESTARTNOHAND;
 }
 
-save_static_function(sysn32_rt_sigreturn);
-__attribute_used__ noinline static void
-_sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
+asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct rt_sigframe_n32 __user *frame;
 	sigset_t set;
-- 
1.4.4.3.ge6d4
