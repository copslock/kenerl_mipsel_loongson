Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2018 18:00:50 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:53026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994077AbeFDQAmo9MK9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jun 2018 18:00:42 +0200
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 373B520896;
        Mon,  4 Jun 2018 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528128035;
        bh=Skw+vfNX9UDufWMrsUKrERy5mfihDE+gO2yjwAeKPL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7cUFzCWdy6zAgBTZQHKZf/jbio4DQBazj2f7yyvWQOV3ZhQ7z1kHGKinKW6OPtTF
         D9uqsBcAPv1ERcbcZuM9SmJNl101vGEklcwcbK1bWktn8oBI4OkI6Un8ZuZ1R4+UJy
         ibgMCUS/cmkv+TWAh7UemdrNU0lxG9eo/qW+wW0w=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [RFC PATCH -tip v5 24/27] bpf: error-inject: kprobes: Clear current_kprobe and enable preempt in kprobe
Date:   Tue,  5 Jun 2018 01:00:08 +0900
Message-Id: <152812800822.10068.3306094708706993432.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <mhiramat@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhiramat@kernel.org
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

Clear current_kprobe and enable preemption in kprobe
even if pre_handler returns !0.

This simplifies function override using kprobes.

Jprobe used to require to keep the preemption disabled and
keep current_kprobe until it returned to original function
entry. For this reason kprobe_int3_handler() and similar
arch dependent kprobe handers checks pre_handler result
and exit without enabling preemption if the result is !0.

After removing the jprobe, Kprobes does not need to
keep preempt disabled even if user handler returns !0
anymore.

But since the function override handler in error-inject
and bpf is also returns !0 if it overrides a function,
to balancing the preempt count, it enables preemption
and reset current kprobe by itself.

That is a bad design that is very buggy. This fixes
such unbalanced preempt-count and current_kprobes setting
in kprobes, bpf and error-inject.

Note: for powerpc and x86, this removes all preempt_disable
from kprobe_ftrace_handler because ftrace callbacks are
called under preempt disabled.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: x86@kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 Changes in v5:
  - Fix kprobe_ftrace_handler in arch/powerpc too.
---
 arch/arc/kernel/kprobes.c            |    5 +++--
 arch/arm/probes/kprobes/core.c       |   10 +++++-----
 arch/arm64/kernel/probes/kprobes.c   |   10 +++++-----
 arch/ia64/kernel/kprobes.c           |   13 ++++---------
 arch/mips/kernel/kprobes.c           |    4 ++--
 arch/powerpc/kernel/kprobes-ftrace.c |   15 ++++++---------
 arch/powerpc/kernel/kprobes.c        |    7 +++++--
 arch/s390/kernel/kprobes.c           |    7 ++++---
 arch/sh/kernel/kprobes.c             |    7 ++++---
 arch/sparc/kernel/kprobes.c          |    7 ++++---
 arch/x86/kernel/kprobes/core.c       |    4 ++++
 arch/x86/kernel/kprobes/ftrace.c     |   15 ++++++++-------
 kernel/fail_function.c               |    3 ---
 kernel/trace/trace_kprobe.c          |   11 +++--------
 14 files changed, 57 insertions(+), 61 deletions(-)

diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 465365696c91..df35d4c0b0b8 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -231,6 +231,9 @@ int __kprobes arc_kprobe_handler(unsigned long addr, struct pt_regs *regs)
 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
 			setup_singlestep(p, regs);
 			kcb->kprobe_status = KPROBE_HIT_SS;
+		} else {
+			reset_current_kprobe();
+			preempt_enable_no_resched();
 		}
 
 		return 1;
@@ -442,9 +445,7 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
 	kretprobe_assert(ri, orig_ret_address, trampoline_address);
 	regs->ret = orig_ret_address;
 
-	reset_current_kprobe();
 	kretprobe_hash_unlock(current, &flags);
-	preempt_enable_no_resched();
 
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 3192350f389d..8d37601fdb20 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -300,10 +300,10 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 
 			/*
 			 * If we have no pre-handler or it returned 0, we
-			 * continue with normal processing.  If we have a
-			 * pre-handler and it returned non-zero, it prepped
-			 * for calling the break_handler below on re-entry,
-			 * so get out doing nothing more here.
+			 * continue with normal processing. If we have a
+			 * pre-handler and it returned non-zero, it will
+			 * modify the execution path and no need to single
+			 * stepping. Let's just reset current kprobe and exit.
 			 */
 			if (!p->pre_handler || !p->pre_handler(p, regs)) {
 				kcb->kprobe_status = KPROBE_HIT_SS;
@@ -312,8 +312,8 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 					kcb->kprobe_status = KPROBE_HIT_SSDONE;
 					p->post_handler(p, regs, 0);
 				}
-				reset_current_kprobe();
 			}
+			reset_current_kprobe();
 		}
 	} else {
 		/*
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 076c3c0775a6..5daf3d721cb7 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -395,9 +395,9 @@ static void __kprobes kprobe_handler(struct pt_regs *regs)
 			/*
 			 * If we have no pre-handler or it returned 0, we
 			 * continue with normal processing.  If we have a
-			 * pre-handler and it returned non-zero, it prepped
-			 * for calling the break_handler below on re-entry,
-			 * so get out doing nothing more here.
+			 * pre-handler and it returned non-zero, it will
+			 * modify the execution path and no need to single
+			 * stepping. Let's just reset current kprobe and exit.
 			 *
 			 * pre_handler can hit a breakpoint and can step thru
 			 * before return, keep PSTATE D-flag enabled until
@@ -405,8 +405,8 @@ static void __kprobes kprobe_handler(struct pt_regs *regs)
 			 */
 			if (!p->pre_handler || !p->pre_handler(p, regs)) {
 				setup_singlestep(p, regs, kcb, 0);
-				return;
-			}
+			} else
+				reset_current_kprobe();
 		}
 	}
 	/*
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 74c8524e6309..aa41bd5cf9b7 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -478,12 +478,9 @@ int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 			 */
 			break;
 	}
-
 	kretprobe_assert(ri, orig_ret_address, trampoline_address);
 
-	reset_current_kprobe();
 	kretprobe_hash_unlock(current, &flags);
-	preempt_enable_no_resched();
 
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
@@ -851,13 +848,11 @@ static int __kprobes pre_kprobes_handler(struct die_args *args)
 	set_current_kprobe(p, kcb);
 	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 
-	if (p->pre_handler && p->pre_handler(p, regs))
-		/*
-		 * Our pre-handler is specifically requesting that we just
-		 * do a return.  This is used for both the jprobe pre-handler
-		 * and the kretprobe trampoline
-		 */
+	if (p->pre_handler && p->pre_handler(p, regs)) {
+		reset_current_kprobe();
+		preempt_enable_no_resched();
 		return 1;
+	}
 
 #if !defined(CONFIG_PREEMPT)
 	if (p->ainsn.inst_flag == INST_FLAG_BOOSTABLE && !p->post_handler) {
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index 7fd277bc59b9..54cd675c5d1d 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -358,6 +358,8 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 
 	if (p->pre_handler && p->pre_handler(p, regs)) {
 		/* handler has already set things up, so skip ss setup */
+		reset_current_kprobe();
+		preempt_enable_no_resched();
 		return 1;
 	}
 
@@ -543,9 +545,7 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
 	kretprobe_assert(ri, orig_ret_address, trampoline_address);
 	instruction_pointer(regs) = orig_ret_address;
 
-	reset_current_kprobe();
 	kretprobe_hash_unlock(current, &flags);
-	preempt_enable_no_resched();
 
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 3869b0e5d5c7..c80c35d1e26e 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -51,11 +51,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 	struct kprobe *p;
 	struct kprobe_ctlblk *kcb;
 
-	preempt_disable();
-
 	p = get_kprobe((kprobe_opcode_t *)nip);
 	if (unlikely(!p) || kprobe_disabled(p))
-		goto end;
+		return;
 
 	kcb = get_kprobe_ctlblk();
 	if (kprobe_running()) {
@@ -75,15 +73,14 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 			skip_singlestep(p, regs, kcb, orig_nip);
 		else {
 			/*
-			 * If pre_handler returns !0, it sets regs->nip and
-			 * resets current kprobe. In this case, we should not
-			 * re-enable preemption.
+			 * If pre_handler returns !0, this handler
+			 * modifies regs->ip and goes back to there
+			 * directly without single stepping.
+			 * So let's just clear current kprobe.
 			 */
-			return;
+			__this_cpu_write(current_kprobe, NULL);
 		}
 	}
-end:
-	preempt_enable_no_resched();
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
 
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index f06747e2e70d..5c60bb0f927f 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -358,9 +358,12 @@ int kprobe_handler(struct pt_regs *regs)
 
 	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 	set_current_kprobe(p, regs, kcb);
-	if (p->pre_handler && p->pre_handler(p, regs))
-		/* handler has already set things up, so skip ss setup */
+	if (p->pre_handler && p->pre_handler(p, regs)) {
+		/* handler changed execution path, so skip ss setup */
+		reset_current_kprobe();
+		preempt_enable_no_resched();
 		return 1;
+	}
 
 	if (p->ainsn.boostable >= 0) {
 		ret = try_to_emulate(p, regs);
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 3e34018960b5..7c0a095e9c5f 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -326,8 +326,11 @@ static int kprobe_handler(struct pt_regs *regs)
 			 */
 			push_kprobe(kcb, p);
 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
-			if (p->pre_handler && p->pre_handler(p, regs))
+			if (p->pre_handler && p->pre_handler(p, regs)) {
+				pop_kprobe(kcb);
+				preempt_enable_no_resched();
 				return 1;
+			}
 			kcb->kprobe_status = KPROBE_HIT_SS;
 		}
 		enable_singlestep(kcb, regs, (unsigned long) p->ainsn.insn);
@@ -431,9 +434,7 @@ static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 
 	regs->psw.addr = orig_ret_address;
 
-	pop_kprobe(get_kprobe_ctlblk());
 	kretprobe_hash_unlock(current, &flags);
-	preempt_enable_no_resched();
 
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 4fafe0cd12c6..241e903dd3ee 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -272,9 +272,12 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 	set_current_kprobe(p, regs, kcb);
 	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 
-	if (p->pre_handler && p->pre_handler(p, regs))
+	if (p->pre_handler && p->pre_handler(p, regs)) {
 		/* handler has already set things up, so skip ss setup */
+		reset_current_kprobe();
+		preempt_enable_no_resched();
 		return 1;
+	}
 
 	prepare_singlestep(p, regs);
 	kcb->kprobe_status = KPROBE_HIT_SS;
@@ -352,8 +355,6 @@ int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 	regs->pc = orig_ret_address;
 	kretprobe_hash_unlock(current, &flags);
 
-	preempt_enable_no_resched();
-
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
 		kfree(ri);
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index c684c96ef2e9..dfbca2470536 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -175,8 +175,11 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 
 	set_current_kprobe(p, regs, kcb);
 	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
-	if (p->pre_handler && p->pre_handler(p, regs))
+	if (p->pre_handler && p->pre_handler(p, regs)) {
+		reset_current_kprobe();
+		preempt_enable_no_resched();
 		return 1;
+	}
 
 	prepare_singlestep(p, regs, kcb);
 	kcb->kprobe_status = KPROBE_HIT_SS;
@@ -508,9 +511,7 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
 	regs->tpc = orig_ret_address;
 	regs->tnpc = orig_ret_address + 4;
 
-	reset_current_kprobe();
 	kretprobe_hash_unlock(current, &flags);
-	preempt_enable_no_resched();
 
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 0ac16a0d93e5..814e26b7c8a2 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -694,6 +694,10 @@ int kprobe_int3_handler(struct pt_regs *regs)
 			 */
 			if (!p->pre_handler || !p->pre_handler(p, regs))
 				setup_singlestep(p, regs, kcb, 0);
+			else {
+				reset_current_kprobe();
+				preempt_enable_no_resched();
+			}
 			return 1;
 		}
 	} else if (*addr != BREAKPOINT_INSTRUCTION) {
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index c8696f2a583f..310ef737b9d4 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -63,18 +63,19 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		/* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
 		regs->ip = ip + sizeof(kprobe_opcode_t);
 
-		/* To emulate trap based kprobes, preempt_disable here */
-		preempt_disable();
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
 			skip_singlestep(p, regs, kcb, orig_ip);
-			preempt_enable_no_resched();
+		} else {
+			/*
+			 * If pre_handler returns !0, this handler
+			 * modifies regs->ip and goes back to there
+			 * directly without single stepping.
+			 * So let's just clear current kprobe.
+			 */
+			__this_cpu_write(current_kprobe, NULL);
 		}
-		/*
-		 * If pre_handler returns !0, it sets regs->ip and
-		 * resets current kprobe, and keep preempt count +1.
-		 */
 	}
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 1d5632d8bbcc..b090688df94f 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -184,9 +184,6 @@ static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
 	if (should_fail(&fei_fault_attr, 1)) {
 		regs_set_return_value(regs, attr->retval);
 		override_function_with_return(regs);
-		/* Kprobe specific fixup */
-		reset_current_kprobe();
-		preempt_enable_no_resched();
 		return 1;
 	}
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 02aed76e0978..b65cd6834450 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1217,16 +1217,11 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 
 		/*
 		 * We need to check and see if we modified the pc of the
-		 * pt_regs, and if so clear the kprobe and return 1 so that we
-		 * don't do the single stepping.
-		 * The ftrace kprobe handler leaves it up to us to re-enable
-		 * preemption here before returning if we've modified the ip.
+		 * pt_regs, and if so return 1 so that we don't do the
+		 * single stepping.
 		 */
-		if (orig_ip != instruction_pointer(regs)) {
-			reset_current_kprobe();
-			preempt_enable_no_resched();
+		if (orig_ip != instruction_pointer(regs))
 			return 1;
-		}
 		if (!ret)
 			return 0;
 	}
