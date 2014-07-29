Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 06:29:59 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:44810 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861993AbaG2DjGOnXqZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 05:39:06 +0200
Received: by mail-pa0-f42.google.com with SMTP id lf10so11747708pab.29
        for <linux-mips@linux-mips.org>; Mon, 28 Jul 2014 20:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=R24X5DTmBYCve1IwdsK+Ivj9CvLPvwCO1JfBJs8kxbI=;
        b=N51LTxAPAiSmJ4WLSLL5V/9xl4pwRT9Pa92VDqdma28jlviamrPm727u34ol4eIpuA
         0dsorbSKfwJ4dZpzNWGl15TIWNNJSimHxGYSM0v2NWIY4jgDlpt3zfTy8OPdU4g0dmII
         v7LMVB3Om++KyGuCPUQ2LbbQlwNKZ/yJhH7Xb6y3YMwWY6t0oiy7Ewwkr6UkC4gX7MSr
         mK5Nq0RqyrDClobj0E9CFwirGGYa2GLTaS3SiAcjlybJiGZFtZyFguEK1EG9/7CYfSJX
         c1hmodh1Iqe9sjHx0mFTrZ7uxfnjz8cnJuJRoVmmIRVk+iOks5fceiH944U29K4+dUqV
         X1wA==
X-Gm-Message-State: ALoCoQleVy8XXas2bthXERWk5j4da/VjA5siNtVveZwKqY2N/7/IaUAR6Xr3J1HiC6kur1zmp4Fd
X-Received: by 10.68.221.161 with SMTP id qf1mr42494366pbc.45.1406605140105;
        Mon, 28 Jul 2014 20:39:00 -0700 (PDT)
Received: from localhost ([2001:5a8:4:83c0:fd15:6cb4:fa7d:1e89])
        by mx.google.com with ESMTPSA id u1sm9842858pdm.82.2014.07.28.20.38.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 20:38:58 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v4 4/5] x86_64,entry: Treat regs->ax the same in fastpath and slowpath syscalls
Date:   Mon, 28 Jul 2014 20:38:31 -0700
Message-Id: <44be7284cbd6304a2efe01b470c8388a2f0848ec.1406604806.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1406604806.git.luto@amacapital.net>
References: <cover.1406604806.git.luto@amacapital.net>
In-Reply-To: <cover.1406604806.git.luto@amacapital.net>
References: <cover.1406604806.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

For slowpath syscalls, we initialize regs->ax to -ENOSYS and stick
the syscall number into regs->orig_ax prior to any possible tracing
and syscall execution.  This is user-visible ABI used by ptrace
syscall emulation and seccomp.

For fastpath syscalls, there's no good reason not to do the same
thing.  It's even slightly simpler than what we're currently doing.
It probably has no measureable performance impact.  It should have
no user-visible effect.

The purpose of this patch is to prepare for two-phase syscall
tracing, in which the first phase might modify the saved RAX without
leaving the fast path.  This change is just subtle enough that I'm
keeping it separate.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/include/asm/calling.h |  6 +++++-
 arch/x86/kernel/entry_64.S     | 13 ++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/calling.h b/arch/x86/include/asm/calling.h
index cb4c73b..76659b6 100644
--- a/arch/x86/include/asm/calling.h
+++ b/arch/x86/include/asm/calling.h
@@ -85,7 +85,7 @@ For 32-bit we have the following conventions - kernel is built with
 #define ARGOFFSET	R11
 #define SWFRAME		ORIG_RAX
 
-	.macro SAVE_ARGS addskip=0, save_rcx=1, save_r891011=1
+	.macro SAVE_ARGS addskip=0, save_rcx=1, save_r891011=1, rax_enosys=0
 	subq  $9*8+\addskip, %rsp
 	CFI_ADJUST_CFA_OFFSET	9*8+\addskip
 	movq_cfi rdi, 8*8
@@ -96,7 +96,11 @@ For 32-bit we have the following conventions - kernel is built with
 	movq_cfi rcx, 5*8
 	.endif
 
+	.if \rax_enosys
+	movq $-ENOSYS, 4*8(%rsp)
+	.else
 	movq_cfi rax, 4*8
+	.endif
 
 	.if \save_r891011
 	movq_cfi r8,  3*8
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index b25ca96..1eb3094 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -405,8 +405,8 @@ GLOBAL(system_call_after_swapgs)
 	 * and short:
 	 */
 	ENABLE_INTERRUPTS(CLBR_NONE)
-	SAVE_ARGS 8,0
-	movq  %rax,ORIG_RAX-ARGOFFSET(%rsp)
+	SAVE_ARGS 8, 0, rax_enosys=1
+	movq_cfi rax,(ORIG_RAX-ARGOFFSET)
 	movq  %rcx,RIP-ARGOFFSET(%rsp)
 	CFI_REL_OFFSET rip,RIP-ARGOFFSET
 	testl $_TIF_WORK_SYSCALL_ENTRY,TI_flags+THREAD_INFO(%rsp,RIP-ARGOFFSET)
@@ -418,7 +418,7 @@ system_call_fastpath:
 	andl $__SYSCALL_MASK,%eax
 	cmpl $__NR_syscall_max,%eax
 #endif
-	ja badsys
+	ja ret_from_sys_call  /* and return regs->ax */
 	movq %r10,%rcx
 	call *sys_call_table(,%rax,8)  # XXX:	 rip relative
 	movq %rax,RAX-ARGOFFSET(%rsp)
@@ -477,10 +477,6 @@ sysret_signal:
 	FIXUP_TOP_OF_STACK %r11, -ARGOFFSET
 	jmp int_check_syscall_exit_work
 
-badsys:
-	movq $-ENOSYS,RAX-ARGOFFSET(%rsp)
-	jmp ret_from_sys_call
-
 #ifdef CONFIG_AUDITSYSCALL
 	/*
 	 * Fast path for syscall audit without full syscall trace.
@@ -520,7 +516,6 @@ tracesys:
 	jz auditsys
 #endif
 	SAVE_REST
-	movq $-ENOSYS,RAX(%rsp) /* ptrace can change this for a bad syscall */
 	FIXUP_TOP_OF_STACK %rdi
 	movq %rsp,%rdi
 	call syscall_trace_enter
@@ -537,7 +532,7 @@ tracesys:
 	andl $__SYSCALL_MASK,%eax
 	cmpl $__NR_syscall_max,%eax
 #endif
-	ja   int_ret_from_sys_call	/* RAX(%rsp) set to -ENOSYS above */
+	ja   int_ret_from_sys_call	/* RAX(%rsp) is already set */
 	movq %r10,%rcx	/* fixup for C */
 	call *sys_call_table(,%rax,8)
 	movq %rax,RAX-ARGOFFSET(%rsp)
-- 
1.9.3
