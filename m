Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2014 21:34:50 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:50528 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861102AbaGOTdSZsArf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2014 21:33:18 +0200
Received: by mail-pa0-f43.google.com with SMTP id lf10so7488268pab.30
        for <linux-mips@linux-mips.org>; Tue, 15 Jul 2014 12:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WsEz+wVX24FdHX0v2U9bnH0mRGvfkXkCOlDke/eQC7U=;
        b=a4tvbGW0wawR4mvdYvpzixKScKJpEZU7AKkgzMuenBvmYo00LbNfo9/2a+TIb05W8R
         h3u4TEwQdHDXtlmoXkq+59iLwhWxH1p2p07iX487r5K1oVxr9WfyxwHtaDuvPXn9CzFU
         ZvfYLcPgc8i88bDV1sQTobnpL7KJAUIXGKmZUTx6JKiIuYa5L1YpxTc/CDSn/akZmTVa
         R5jsAx/nb1TYlefJgdmhFxIo6dfF5f22ACDceAIZJx9MB4pL+g6HxUkT0SVgO9+WlP/Y
         Gq1RacYjaPuyCaVpHpzhTst7rWZ8vueXknoBe0iZN6TV8mVdsd3nLFdPCRPYaPOh8Qu7
         Vm0g==
X-Gm-Message-State: ALoCoQlkELcGMxD7yYThUp1rrvgeh5bY6M74B7VdRJj/opTyQkfAImYoPZQK/cUwGuBM3TPS9C79
X-Received: by 10.66.119.169 with SMTP id kv9mr4149107pab.137.1405452792328;
        Tue, 15 Jul 2014 12:33:12 -0700 (PDT)
Received: from localhost ([2001:5a8:4:83c0:b456:e6bb:934a:3ab7])
        by mx.google.com with ESMTPSA id fx5sm14749240pbb.62.2014.07.15.12.33.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jul 2014 12:33:11 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        James Morris <james.l.morris@oracle.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 6/7] x86_64,entry: Treat regs->ax the same in fastpath and slowpath syscalls
Date:   Tue, 15 Jul 2014 12:32:35 -0700
Message-Id: <3bee564fe07150f11d2e5078d457b6aacde43bec.1405452484.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
In-Reply-To: <cover.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41204
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

The purpose of this patch is to prepare for seccomp-based syscall
emulation in the fast path.  This change is just subtle enough that
I'm keeping it separate.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/include/asm/calling.h |  6 +++++-
 arch/x86/kernel/entry_64.S     | 11 +++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

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
index b25ca96..432c190 100644
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
-- 
1.9.3
