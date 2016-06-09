Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:06:27 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36706 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041427AbcFIVCgPvulE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:02:36 +0200
Received: by mail-pa0-f46.google.com with SMTP id b5so16518626pas.3
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Lch+nmOXeei4KpNKQpy/WFoYPhYHWVDpIemPl8eArQ=;
        b=l5SJyqxUYbGTxMvgH3Br3Yy5XnnfIl3heEOX/wCDHo36Wg19oBDTVaj0Sg0E+C741J
         EDKS0Bu8uzHXxE3sWpZzpTXSnDMWT0ikOnRMju/GdJqiWKgxuBkwQIHMPz1hGne/HxIw
         N2niwNxx6m8t/KoppuFCIZnAhzLmk54iWqKDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Lch+nmOXeei4KpNKQpy/WFoYPhYHWVDpIemPl8eArQ=;
        b=mU9dSeRq1fYQ9K8210PSZwmet6q6NetSgrVw+KQEM6cPsU1MgPCZhgNkQg+p3Qvg2F
         XLFpPlJwblSufpbQK0GGi+ERNOYwwR/7mzJJbxdrBKRJhWbDdblktptW7umOYmWNPuL6
         pxgNTaO2Zg6KrSu2ziRkpQsplD18M5xLGhHquXeyjvnd1sWGCsh4B5dTy0/5AXgdX5jN
         hfvWfYLmrHnL+t0wHTrHpTDDUWwPi/pdq10UpDmkouPqX88to5hZ4p7hACJ+FWAVB8ld
         HRK5xoxEpwHn0b2tdlK2c7qD4R/sws7BMKH0lORhRllBQEr47lWN8mbTUCEQ5a6kos8P
         GTcA==
X-Gm-Message-State: ALyK8tJ8XA3E4l1EzJmZhazaCRY7k3+NPt6Pym8I7fbS7jq48BYlpJTpN9I3B7/L8+EQ1mew
X-Received: by 10.66.132.45 with SMTP id or13mr9202420pab.79.1465506150457;
        Thu, 09 Jun 2016 14:02:30 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d8sm12147380pfg.72.2016.06.09.14.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 14:02:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        user-mode-linux-devel@lists.sourceforge.net,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: [PATCH 12/14] powerpc/ptrace: run seccomp after ptrace
Date:   Thu,  9 Jun 2016 14:02:02 -0700
Message-Id: <1465506124-21866-13-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53976
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

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/ptrace.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index ed799e994773..5dc47ebb3840 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1788,7 +1788,7 @@ static int do_seccomp(struct pt_regs *regs)
 
 	/*
 	 * The syscall was allowed by seccomp, restore the register
-	 * state to what ptrace and audit expect.
+	 * state to what audit expects.
 	 * Note that we use orig_gpr3, which means a seccomp tracer can
 	 * modify the first syscall parameter (in orig_gpr3) and also
 	 * allow the syscall to proceed.
@@ -1822,22 +1822,25 @@ static inline int do_seccomp(struct pt_regs *regs) { return 0; }
  */
 long do_syscall_trace_enter(struct pt_regs *regs)
 {
-	bool abort = false;
-
 	user_exit();
 
+	/*
+	 * The tracer may decide to abort the syscall, if so tracehook
+	 * will return !0. Note that the tracer may also just change
+	 * regs->gpr[0] to an invalid syscall number, that is handled
+	 * below on the exit path.
+	 */
+	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
+	    tracehook_report_syscall_entry(regs))
+		goto skip;
+
+	/* Run seccomp after ptrace; allow it to set gpr[3]. */
 	if (do_seccomp(regs))
 		return -1;
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
-		/*
-		 * The tracer may decide to abort the syscall, if so tracehook
-		 * will return !0. Note that the tracer may also just change
-		 * regs->gpr[0] to an invalid syscall number, that is handled
-		 * below on the exit path.
-		 */
-		abort = tracehook_report_syscall_entry(regs) != 0;
-	}
+	/* Avoid trace and audit when syscall is invalid. */
+	if (regs->gpr[0] >= NR_syscalls)
+		goto skip;
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->gpr[0]);
@@ -1854,17 +1857,16 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 				    regs->gpr[5] & 0xffffffff,
 				    regs->gpr[6] & 0xffffffff);
 
-	if (abort || regs->gpr[0] >= NR_syscalls) {
-		/*
-		 * If we are aborting explicitly, or if the syscall number is
-		 * now invalid, set the return value to -ENOSYS.
-		 */
-		regs->gpr[3] = -ENOSYS;
-		return -1;
-	}
-
 	/* Return the possibly modified but valid syscall number */
 	return regs->gpr[0];
+
+skip:
+	/*
+	 * If we are aborting explicitly, or if the syscall number is
+	 * now invalid, set the return value to -ENOSYS.
+	 */
+	regs->gpr[3] = -ENOSYS;
+	return -1;
 }
 
 void do_syscall_trace_leave(struct pt_regs *regs)
-- 
2.7.4
