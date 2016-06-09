Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:05:24 +0200 (CEST)
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34645 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041414AbcFIVCe5WkmE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:02:34 +0200
Received: by mail-pf0-f170.google.com with SMTP id 62so16361628pfd.1
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 14:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYG2fs7qhrt3SB3C1gIg78Ki38XUW1yWQYHGxsDi4jM=;
        b=KUhlYh9YOyuXBPOs6E+cskJoTnOLRBiV+xqRaF7vJof5BbOKS/I/J7I0EGGIpssRLt
         Rinq+l7z/VivEQwl7LIe5Za6gqZrJ77MrFPYpAVEqynv/AS69YeUTeVAp3xZ60mmPSud
         4jNx8jFMyKERWgSsWLQdK2JAIhTBb+omFfH0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oYG2fs7qhrt3SB3C1gIg78Ki38XUW1yWQYHGxsDi4jM=;
        b=BoPsKPltmg0yBu45ka4ZeW1vzZDmwyd27V4svrYCIyYdulxGFJqp6mdFZhvLqTfhM0
         DMKnKj7zA366gVEpIWycbpszngbxTD+sSWj2WWC3Q1GbVcVw9sGC4gmB1aHP0DCievF/
         aycKvwD3L3mZVlbO+g7HLT/7QYk9MOrbDa/D7irPrF08VvJC0GEeBkx8yPRoUPlBvVbI
         SeSuLRrT7ZjRAY+I0FjTwnyh7BejjGld5TcytE47cOZ5IydO9s8QoNGf49KtWHaOjEG5
         bPh3fDwc7CPD6QERf8E6xmxsrckbN/yfC1QCzBcDlqqdPGPZ2kP5krkjZYbBGjzQOhku
         et7g==
X-Gm-Message-State: ALyK8tKL/SKoemhAxeIJI4EvS7Hf0moHCpLLo5f/Wb7ZdnqEsILfvN8nGoGLXhbQDP0I564m
X-Received: by 10.98.10.137 with SMTP id 9mr6453218pfk.28.1465506149191;
        Thu, 09 Jun 2016 14:02:29 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s124sm12163691pfb.63.2016.06.09.14.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 14:02:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        user-mode-linux-devel@lists.sourceforge.net,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: [PATCH 10/14] parisc/ptrace: run seccomp after ptrace
Date:   Thu,  9 Jun 2016 14:02:00 -0700
Message-Id: <1465506124-21866-11-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53973
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
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
---
 arch/parisc/kernel/ptrace.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 8edc47c0b98e..e02d7b4d2b69 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -311,10 +311,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 long do_syscall_trace_enter(struct pt_regs *regs)
 {
-	/* Do the secure computing check first. */
-	if (secure_computing(NULL) == -1)
-		return -1;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs)) {
 		/*
@@ -325,6 +321,11 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 		regs->gr[20] = -1UL;
 		goto out;
 	}
+
+	/* Do the secure computing check after ptrace. */
+	if (secure_computing(NULL) == -1)
+		return -1;
+
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->gr[20]);
-- 
2.7.4
