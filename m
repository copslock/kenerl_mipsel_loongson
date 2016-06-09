Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:04:27 +0200 (CEST)
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36063 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041409AbcFIVCd4sbQE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:02:33 +0200
Received: by mail-pf0-f171.google.com with SMTP id t190so16329802pfb.3
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 14:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y/6NMxm1BS8HbXsCrULQOUaEIfzh75WRn8CKfb1whdA=;
        b=KiUZaW7grau7IPYrpg1Kgj2VQIUhyJ4ODLQoO+Zqud4Q5U3ZSE8pDAXuLZkaHMv8FS
         ldi0byTdWLx8V46uGNuftwunyU/NomG+OC0x/202HbOdhX1syw5K+nlBg0Z2mjtte7ij
         NZ98XXCiygPjPs5v3pFucJ/07FwTajAZ5wST4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y/6NMxm1BS8HbXsCrULQOUaEIfzh75WRn8CKfb1whdA=;
        b=Hh44p+k6+OSJB9aBoIf+c8AVB1jQwfzlvyOBON0jgFfQVJL6qbOiP65oo3x6pQSh0f
         ctUDgQUoPN1xbaq42KjcyYzGD57ppAEj/5yIWDsyBjr06DVF71scJQTMSlX8To78bgU4
         gY0q+gIxS8TcgiKIg56Y14UFrTEN0/mOmbVmei1nAlcagbzRYPDHMTQq5kmxmY+aB/b4
         amUZjJ/9shaI+8v+V98Zuy6EcVHdaYZCmeo/EfUMY3uCODKGcAbKzir1j/oQFzwpngWz
         07MMmXWBd07DxiXNNfJIgjltWk2MKvWhk5oF6m/O+NUz8mTaScwovUSPBtPqJnoOeAeI
         le4A==
X-Gm-Message-State: ALyK8tIrY4vujyL1IEQdZuCGxwpE39++E6RTo6CgtcOLz68tJ1clB9UyjSK1wchfH2t7ODdm
X-Received: by 10.98.65.209 with SMTP id g78mr6503581pfd.163.1465506148153;
        Thu, 09 Jun 2016 14:02:28 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 75sm12128831pfo.82.2016.06.09.14.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 14:02:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
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
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 06/14] x86/ptrace: run seccomp after ptrace
Date:   Thu,  9 Jun 2016 14:01:56 -0700
Message-Id: <1465506124-21866-7-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53970
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

This moves seccomp after ptrace on x86 to that seccomp can catch changes
made by ptrace. Emulation should skip the rest of processing too.

We can get rid of test_thread_flag because there's no longer any
opportunity for seccomp to mess with ptrace state before invoking
ptrace.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/common.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index df56ca394877..81c0e12d831c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -73,6 +73,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 	struct thread_info *ti = pt_regs_to_thread_info(regs);
 	unsigned long ret = 0;
+	bool emulated = false;
 	u32 work;
 
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
@@ -80,11 +81,19 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 	work = ACCESS_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
 
+	if (unlikely(work & _TIF_SYSCALL_EMU))
+		emulated = true;
+
+	if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
+	    tracehook_report_syscall_entry(regs))
+		return -1L;
+
+	if (emulated)
+		return -1L;
+
 #ifdef CONFIG_SECCOMP
 	/*
-	 * Do seccomp first -- it should minimize exposure of other
-	 * code, and keeping seccomp fast is probably more valuable
-	 * than the rest of this.
+	 * Do seccomp after ptrace, to catch any tracer changes.
 	 */
 	if (work & _TIF_SECCOMP) {
 		struct seccomp_data sd;
@@ -117,13 +126,6 @@ static long syscall_trace_enter(struct pt_regs *regs)
 	}
 #endif
 
-	if (unlikely(work & _TIF_SYSCALL_EMU))
-		ret = -1L;
-
-	if ((ret || test_thread_flag(TIF_SYSCALL_TRACE)) &&
-	    tracehook_report_syscall_entry(regs))
-		ret = -1L;
-
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->orig_ax);
 
-- 
2.7.4
