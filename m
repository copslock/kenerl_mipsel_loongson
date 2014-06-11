Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 22:25:05 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:55984 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859997AbaFKUXZH-FG1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2014 22:23:25 +0200
Received: by mail-pa0-f53.google.com with SMTP id kx10so179452pab.26
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2014 13:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NKdbJ3dFZM3wg40mbCrz2wUZdOFrFGE81jyr2LzqHVY=;
        b=dpFYRcVKT/iuSJzA/QVIAdR0kZN4Hoa8nvS5SbQRhzzk0pnxP5ciNrzsp7X38Vn4FD
         AtDnqbBgmrsfHnSMpzK/tP+n+McaXX22NRZ6YmunGPH3swQKY3up40MIhgL5yLe0Dq41
         LJ7/Gy/xD9Qqk66idxpucsGf3PmCdNp2aij6lhj3FQz+JaXpfwqlKkPGXXZ1Qmc2JuBF
         nHYV3gL1jxf5ubkoUkPvt2I7UylMRYVgbC+P7U/cf1ChBYHxqOGZmr6Ca9h7QkxUKRYx
         dPx8LVrF3TgTxZnz7upEmnsiKJOnH23k15SDydqwH9mJ9z/0hw/aNkfhnB4osVEABXL5
         +2gg==
X-Gm-Message-State: ALoCoQmaZ58HdgCWY+kA99W6s+xZppkv9Y3+Cdiy59Ok0EerZ+RqHt0XcMVYI0/h0zsiyBTQv6V6
X-Received: by 10.66.148.98 with SMTP id tr2mr16378991pab.33.1402518199050;
        Wed, 11 Jun 2014 13:23:19 -0700 (PDT)
Received: from localhost (50-76-60-73-ip-static.hfc.comcastbusiness.net. [50.76.60.73])
        by mx.google.com with ESMTPSA id cz3sm76588045pbc.9.2014.06.11.13.23.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jun 2014 13:23:18 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: [RFC 5/5] x86,seccomp: Add a seccomp fastpath
Date:   Wed, 11 Jun 2014 13:23:02 -0700
Message-Id: <9e11cd988a0f120606e37b5e275019754e2774da.1402517933.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1402517933.git.luto@amacapital.net>
References: <cover.1402517933.git.luto@amacapital.net>
In-Reply-To: <cover.1402517933.git.luto@amacapital.net>
References: <cover.1402517933.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40494
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

On my VM, getpid takes about 70ns.  Before this patch, adding a
single-instruction always-accept seccomp filter added about 134ns of
overhead to getpid.  With this patch, the overhead is down to about
13ns.

I'm not really thrilled by this patch.  It has two main issues:

1. Calling into code in kernel/seccomp.c from assembly feels ugly.

2. The x86 64-bit syscall entry now has four separate code paths:
fast, seccomp only, audit only, and slow.  This kind of sucks.
Would it be worth trying to rewrite the whole thing in C with a
two-phase slow path approach like I'm using here for seccomp?

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/kernel/entry_64.S | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/seccomp.h    |  4 ++--
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index f9e713a..feb32b2 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -683,6 +683,45 @@ sysret_signal:
 	FIXUP_TOP_OF_STACK %r11, -ARGOFFSET
 	jmp int_check_syscall_exit_work
 
+#ifdef CONFIG_SECCOMP
+	/*
+	 * Fast path for seccomp without any other slow path triggers.
+	 */
+seccomp_fastpath:
+	/* Build seccomp_data */
+	pushq %r9				/* args[5] */
+	pushq %r8				/* args[4] */
+	pushq %r10				/* args[3] */
+	pushq %rdx				/* args[2] */
+	pushq %rsi				/* args[1] */
+	pushq %rdi				/* args[0] */
+	pushq RIP-ARGOFFSET+6*8(%rsp)		/* rip */
+	pushq %rax 				/* nr and junk */
+	movl $AUDIT_ARCH_X86_64, 4(%rsp)	/* arch */
+	movq %rsp, %rdi
+	call seccomp_phase1
+	addq $8*8, %rsp
+	cmpq $1, %rax
+	ja seccomp_invoke_phase2
+	LOAD_ARGS 0  /* restore clobbered regs */
+	jb system_call_fastpath
+	jmp ret_from_sys_call
+
+seccomp_invoke_phase2:
+	SAVE_REST
+	FIXUP_TOP_OF_STACK %rdi
+	movq %rax,%rdi
+	call seccomp_phase2
+
+	/* if seccomp says to skip, then set orig_ax to -1 and skip */
+	test %eax,%eax
+	jz 1f
+	movq $-1, ORIG_RAX(%rsp)
+1:
+	mov ORIG_RAX(%rsp), %rax		/* reload rax */
+	jmp system_call_post_trace		/* and maybe do the syscall */
+#endif
+
 #ifdef CONFIG_AUDITSYSCALL
 	/*
 	 * Fast path for syscall audit without full syscall trace.
@@ -717,6 +756,10 @@ sysret_audit:
 
 	/* Do syscall tracing */
 tracesys:
+#ifdef CONFIG_SECCOMP
+	testl $(_TIF_WORK_SYSCALL_ENTRY & ~_TIF_SECCOMP),TI_flags+THREAD_INFO(%rsp,RIP-ARGOFFSET)
+	jz seccomp_fastpath
+#endif
 #ifdef CONFIG_AUDITSYSCALL
 	testl $(_TIF_WORK_SYSCALL_ENTRY & ~_TIF_SYSCALL_AUDIT),TI_flags+THREAD_INFO(%rsp,RIP-ARGOFFSET)
 	jz auditsys
@@ -725,6 +768,8 @@ tracesys:
 	FIXUP_TOP_OF_STACK %rdi
 	movq %rsp,%rdi
 	call syscall_trace_enter
+
+system_call_post_trace:
 	/*
 	 * Reload arg registers from stack in case ptrace changed them.
 	 * We don't reload %rax because syscall_trace_enter() returned
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 4fc7a84..d3d4c52 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -37,8 +37,8 @@ static inline int secure_computing(void)
 #define SECCOMP_PHASE1_OK	0
 #define SECCOMP_PHASE1_SKIP	1
 
-extern u32 seccomp_phase1(struct seccomp_data *sd);
-int seccomp_phase2(u32 phase1_result);
+asmlinkage __visible extern u32 seccomp_phase1(struct seccomp_data *sd);
+asmlinkage __visible int seccomp_phase2(u32 phase1_result);
 #else
 extern void secure_computing_strict(int this_syscall);
 #endif
-- 
1.9.3
