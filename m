Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 23:21:19 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:44889 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861411AbaGRVTWIH8x6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 23:19:22 +0200
Received: by mail-pa0-f52.google.com with SMTP id bj1so6154814pad.39
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 14:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=j+0zR8m2argK7QT5m5NOEfatbPChOOWJAnplawUTnOI=;
        b=VHjSWUd/exH/gj7sykv7+0INey3ZyknVzRjJex3xQbzHJ2Ef2nxYn7enN3E9igYay5
         T6q7gV0fmUeOy9YZ1GSVJuw5aLy5FV6VJ97F5y0IWxWiWSr8OermQUEKAus4yFVFVQDZ
         Z+bUT/Ot94lwhnPoQLo9OtyO/H3o3/KCIgxpPmXCviOYdSZQXcfS8TKqBbAI5SDY9Cyj
         Rjas33IeTXgo/9qD1c95Ie0NatJnOEMOCra4WXcG81os13szottdDD2wEPWOEHWWAGql
         VdtK+xpPGdpdkkLeyHA/t1upMIs+nIhiuCctHTHFyv4PV5Sh7r8ZeHP95h30WO2nQhWA
         LvnA==
X-Gm-Message-State: ALoCoQkkOSOAFHSzC92BYp9oxOMDzZV3Nd1WRxSpN0WMhN5UvYQzhwFtC3wdbgP5FLEq3ys7NpYP
X-Received: by 10.68.93.101 with SMTP id ct5mr8248378pbb.27.1405718356023;
        Fri, 18 Jul 2014 14:19:16 -0700 (PDT)
Received: from localhost (50-76-60-73-ip-static.hfc.comcastbusiness.net. [50.76.60.73])
        by mx.google.com with ESMTPSA id d3sm1156516pdi.49.2014.07.18.14.19.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jul 2014 14:19:15 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 7/7] x86_64,entry: Use split-phase syscall_trace_enter for 64-bit syscalls
Date:   Fri, 18 Jul 2014 14:18:15 -0700
Message-Id: <8e9ca6cff0bda4b1ec730efbe6dcfeb27db87ed9.1405717901.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1405717901.git.luto@amacapital.net>
References: <cover.1405717901.git.luto@amacapital.net>
In-Reply-To: <cover.1405717901.git.luto@amacapital.net>
References: <cover.1405717901.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41340
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

On KVM on my box, this reduces the overhead from an always-accept
seccomp filter from ~130ns to ~17ns.  Most of that comes from
avoiding IRET on every syscall when seccomp is enabled.

In extremely approximate hacked-up benchmarking, just bypassing IRET
saves about 80ns, so there's another 43ns of savings here from
simplifying the seccomp path.

The diffstat is also rather nice :)

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/kernel/entry_64.S | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 1eb3094..13e0c1d 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -479,22 +479,6 @@ sysret_signal:
 
 #ifdef CONFIG_AUDITSYSCALL
 	/*
-	 * Fast path for syscall audit without full syscall trace.
-	 * We just call __audit_syscall_entry() directly, and then
-	 * jump back to the normal fast path.
-	 */
-auditsys:
-	movq %r10,%r9			/* 6th arg: 4th syscall arg */
-	movq %rdx,%r8			/* 5th arg: 3rd syscall arg */
-	movq %rsi,%rcx			/* 4th arg: 2nd syscall arg */
-	movq %rdi,%rdx			/* 3rd arg: 1st syscall arg */
-	movq %rax,%rsi			/* 2nd arg: syscall number */
-	movl $AUDIT_ARCH_X86_64,%edi	/* 1st arg: audit arch */
-	call __audit_syscall_entry
-	LOAD_ARGS 0		/* reload call-clobbered registers */
-	jmp system_call_fastpath
-
-	/*
 	 * Return fast path for syscall audit.  Call __audit_syscall_exit()
 	 * directly and then jump back to the fast path with TIF_SYSCALL_AUDIT
 	 * masked off.
@@ -511,17 +495,25 @@ sysret_audit:
 
 	/* Do syscall tracing */
 tracesys:
-#ifdef CONFIG_AUDITSYSCALL
-	testl $(_TIF_WORK_SYSCALL_ENTRY & ~_TIF_SYSCALL_AUDIT),TI_flags+THREAD_INFO(%rsp,RIP-ARGOFFSET)
-	jz auditsys
-#endif
+	leaq -REST_SKIP(%rsp), %rdi
+	movq $AUDIT_ARCH_X86_64, %rsi
+	call syscall_trace_enter_phase1
+	test %rax, %rax
+	jnz tracesys_phase2		/* if needed, run the slow path */
+	LOAD_ARGS 0			/* else restore clobbered regs */
+	jmp system_call_fastpath	/*      and return to the fast path */
+
+tracesys_phase2:
 	SAVE_REST
 	FIXUP_TOP_OF_STACK %rdi
-	movq %rsp,%rdi
-	call syscall_trace_enter
+	movq %rsp, %rdi
+	movq $AUDIT_ARCH_X86_64, %rsi
+	movq %rax,%rdx
+	call syscall_trace_enter_phase2
+
 	/*
 	 * Reload arg registers from stack in case ptrace changed them.
-	 * We don't reload %rax because syscall_trace_enter() returned
+	 * We don't reload %rax because syscall_trace_entry_phase2() returned
 	 * the value it wants us to use in the table lookup.
 	 */
 	LOAD_ARGS ARGOFFSET, 1
-- 
1.9.3
