Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Sep 2014 00:15:39 +0200 (CEST)
Received: from mail-yh0-f49.google.com ([209.85.213.49]:34489 "EHLO
        mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025901AbaIEWOjwwUOk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Sep 2014 00:14:39 +0200
Received: by mail-yh0-f49.google.com with SMTP id z6so7822846yhz.36
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 15:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ly2ged3LV5UtVnaiJ5dRlmi0SXluoTfKNyARUuR+YCg=;
        b=K6+NmUj+s8Uh/cR/ITciEt91Abx+cS5fLkFe1OXY/eTBKpqTtD6iE+HzqXPxPMjk9x
         1N4SGdbJpfTRVg677vQ8Br7Gzpg2dBkFQxj12DrzxOoQJzCvewLMRS173B1DAZOTtFyK
         KjhJhopSCvVOfhYxuEcVRJHwd6IR8qYqqo8sQ+4VMt1IaH6k3A6iCukLuEoGJcgTX1FD
         /QILWgxP9egJ81+hMv7SEGMlnq/Ov795nLwi4CcoU+982UCD6fYbSBsg9cY2XSnGVNGb
         3eFlN4XeXqVAppHTOd81xD/rRWGUhxBFo1p6CiehTw5rDGTknEXTThKmM9SbUnW9HDgP
         sAtw==
X-Gm-Message-State: ALoCoQniQCHBkq2D8IJ+C94u0hY/YCu624jK0KH5s+KrcanCCjaoyxgGyYcuMTWIOdCeKfBiygb6
X-Received: by 10.236.103.170 with SMTP id f30mr18442880yhg.76.1409955274172;
        Fri, 05 Sep 2014 15:14:34 -0700 (PDT)
Received: from localhost ([2602:301:77d8:1800:bd9e:fe09:e642:968])
        by mx.google.com with ESMTPSA id n36sm1276309yhp.49.2014.09.05.15.14.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2014 15:14:33 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-arch@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v5 5/5] x86_64,entry: Use split-phase syscall_trace_enter for 64-bit syscalls
Date:   Fri,  5 Sep 2014 15:13:56 -0700
Message-Id: <a3dbd267ee990110478d349f78cccfdac5497a84.1409954077.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1409954077.git.luto@amacapital.net>
References: <cover.1409954077.git.luto@amacapital.net>
In-Reply-To: <cover.1409954077.git.luto@amacapital.net>
References: <cover.1409954077.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42460
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
index 0bd6d3c28064..df088bb03fb3 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -478,22 +478,6 @@ sysret_signal:
 
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
@@ -510,17 +494,25 @@ sysret_audit:
 
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
