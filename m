Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:03:46 +0200 (CEST)
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34639 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041399AbcFIVCdLRz9E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:02:33 +0200
Received: by mail-pf0-f177.google.com with SMTP id 62so16361397pfd.1
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 14:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HxyjAmQOE5qeZ7EhwE669HPBzRp/2ElYQ397JoX8rz8=;
        b=Vvl41tl3QAu6SsK87BdulFghpvNhcHpaB3ZvlNgX2UjSYlnLzouS5HKKUaofrwjXfy
         RkD2R4UZEZElhIlDAJIPGAnlDDaaec426LxMa4YSxwovb0KSJz90i6V0oq0QUROy2XKw
         EmrsmPZhgBAxDvP2w1ir3JDca/+ppySEyfjo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HxyjAmQOE5qeZ7EhwE669HPBzRp/2ElYQ397JoX8rz8=;
        b=Jago/lGAE5nyynBhBfJSZQpp0Dd2p4Lj8oqLklIqleV3gXONNJ1dNgvSUF8DJeX9J5
         J3UhlY1gEuHmRDHqz9KxYuLGbHxv66opIDi38oEWSTJt09bWfc7UZlxeV/yTcVKLUpp5
         Mws3FTggB0Td+OKUmCPybfuVAl2s38nbAL9fjlKT7fHlCKFhbG5fskoXJ3ygOnUVaFF7
         KAOLbczU34o+WC2Xqs8/vzka0lrPLGWy1NidglO11wx4h5Vn5tyPEKrycpSX+zY+sNIj
         5FnhcXT0oyh+aFV468x1mXd7y+EpD0/3anKzbmmeuePQ3Kjm5SMWbjBDL2BXdpUBWmxX
         Enhg==
X-Gm-Message-State: ALyK8tJmtLixsGtbsU72hQrAwCx8Hdr5JHEM7wyKlb1RmiMAt8XdF7u0Op+dZwuHpY/p5wuM
X-Received: by 10.98.216.199 with SMTP id e190mr6655711pfg.76.1465506147310;
        Thu, 09 Jun 2016 14:02:27 -0700 (PDT)
Received: from www.outflux.net ([2002:ada4:7085:0:ae16:2dff:fe07:4fb6])
        by smtp.gmail.com with ESMTPSA id lg17sm12123457pab.36.2016.06.09.14.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 14:02:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        user-mode-linux-devel@lists.sourceforge.net,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: [PATCH 03/14] x86/entry: Get rid of two-phase syscall entry work
Date:   Thu,  9 Jun 2016 14:01:53 -0700
Message-Id: <1465506124-21866-4-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

From: Andy Lutomirski <luto@kernel.org>

I added two-phase syscall entry work back when the entry slow path
was very slow.  Nowadays, the entry slow path is fast and two-phase
entry work serves no purpose.  Remove it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/common.c       | 84 +++++--------------------------------------
 arch/x86/include/asm/ptrace.h |  6 ----
 2 files changed, 8 insertions(+), 82 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index ec138e538c44..df56ca394877 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -64,20 +64,13 @@ static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
 }
 
 /*
- * We can return 0 to resume the syscall or anything else to go to phase
- * 2.  If we resume the syscall, we need to put something appropriate in
- * regs->orig_ax.
- *
- * NB: We don't have full pt_regs here, but regs->orig_ax and regs->ax
- * are fully functional.
- *
- * For phase 2's benefit, our return value is:
- * 0:			resume the syscall
- * 1:			go to phase 2; no seccomp phase 2 needed
- * anything else:	go to phase 2; pass return value to seccomp
+ * Returns the syscall nr to run (which should match regs->orig_ax) or -1
+ * to skip the syscall.
  */
-unsigned long syscall_trace_enter_phase1(struct pt_regs *regs, u32 arch)
+static long syscall_trace_enter(struct pt_regs *regs)
 {
+	u32 arch = in_ia32_syscall() ? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
+
 	struct thread_info *ti = pt_regs_to_thread_info(regs);
 	unsigned long ret = 0;
 	u32 work;
@@ -118,59 +111,9 @@ unsigned long syscall_trace_enter_phase1(struct pt_regs *regs, u32 arch)
 			sd.args[5] = regs->bp;
 		}
 
-		BUILD_BUG_ON(SECCOMP_PHASE1_OK != 0);
-		BUILD_BUG_ON(SECCOMP_PHASE1_SKIP != 1);
-
-		ret = seccomp_phase1(&sd);
-		if (ret == SECCOMP_PHASE1_SKIP) {
-			regs->orig_ax = -1;
-			ret = 0;
-		} else if (ret != SECCOMP_PHASE1_OK) {
-			return ret;  /* Go directly to phase 2 */
-		}
-
-		work &= ~_TIF_SECCOMP;
-	}
-#endif
-
-	/* Do our best to finish without phase 2. */
-	if (work == 0)
-		return ret;  /* seccomp and/or nohz only (ret == 0 here) */
-
-#ifdef CONFIG_AUDITSYSCALL
-	if (work == _TIF_SYSCALL_AUDIT) {
-		/*
-		 * If there is no more work to be done except auditing,
-		 * then audit in phase 1.  Phase 2 always audits, so, if
-		 * we audit here, then we can't go on to phase 2.
-		 */
-		do_audit_syscall_entry(regs, arch);
-		return 0;
-	}
-#endif
-
-	return 1;  /* Something is enabled that we can't handle in phase 1 */
-}
-
-/* Returns the syscall nr to run (which should match regs->orig_ax). */
-long syscall_trace_enter_phase2(struct pt_regs *regs, u32 arch,
-				unsigned long phase1_result)
-{
-	struct thread_info *ti = pt_regs_to_thread_info(regs);
-	long ret = 0;
-	u32 work = ACCESS_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
-
-	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
-		BUG_ON(regs != task_pt_regs(current));
-
-#ifdef CONFIG_SECCOMP
-	/*
-	 * Call seccomp_phase2 before running the other hooks so that
-	 * they can see any changes made by a seccomp tracer.
-	 */
-	if (phase1_result > 1 && seccomp_phase2(phase1_result)) {
-		/* seccomp failures shouldn't expose any additional code. */
-		return -1;
+		ret = __secure_computing(&sd);
+		if (ret == -1)
+			return ret;
 	}
 #endif
 
@@ -189,17 +132,6 @@ long syscall_trace_enter_phase2(struct pt_regs *regs, u32 arch,
 	return ret ?: regs->orig_ax;
 }
 
-long syscall_trace_enter(struct pt_regs *regs)
-{
-	u32 arch = in_ia32_syscall() ? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
-	unsigned long phase1_result = syscall_trace_enter_phase1(regs, arch);
-
-	if (phase1_result == 0)
-		return regs->orig_ax;
-	else
-		return syscall_trace_enter_phase2(regs, arch, phase1_result);
-}
-
 #define EXIT_TO_USERMODE_LOOP_FLAGS				\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
 	 _TIF_NEED_RESCHED | _TIF_USER_RETURN_NOTIFY)
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6271281f947d..2b5d686ea9f3 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -83,12 +83,6 @@ extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
 			 int error_code, int si_code);
 
 
-extern unsigned long syscall_trace_enter_phase1(struct pt_regs *, u32 arch);
-extern long syscall_trace_enter_phase2(struct pt_regs *, u32 arch,
-				       unsigned long phase1_result);
-
-extern long syscall_trace_enter(struct pt_regs *);
-
 static inline unsigned long regs_return_value(struct pt_regs *regs)
 {
 	return regs->ax;
-- 
2.7.4
