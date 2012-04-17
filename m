Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2012 21:50:35 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:35700 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903725Ab2DQTu1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2012 21:50:27 +0200
Received: by ggnk1 with SMTP id k1so3713391ggn.36
        for <linux-mips@linux-mips.org>; Tue, 17 Apr 2012 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8242z81rj4K9wM0lnlYOF+4SYShWucsRygbDwGwRaQA=;
        b=O10Mr+PUzdG79eTGVs6uV2xL5E6Cf+XZ8oIDyJpebU3buKEr3ifvOu/KKVGErhlGxw
         wOHNySsVhykJO6kgJyCoNnftQRLH4zOi91D90cxokYbdQQMhauNSzmdD0QOiAQIuUErv
         ZGgPw1GMq6e+WGiu3YY+l5+kbK5CVjaIPMrUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=8242z81rj4K9wM0lnlYOF+4SYShWucsRygbDwGwRaQA=;
        b=ZgiLHrqeLnT+N8CVIoHJSIXj2rrPekO3YMz46uK7u8Oq3CjZeQHT0+piUWf3ffqMGU
         X121ROeb2fHJ1iWi2dO4BXTBwikEukldRQBIs7QQ0ayNFIY48Yn++/1LHUe1UsO0eQk7
         ZpxgKZ0pjhNSJoJSMSxRDBSAJOKEn52qeo+sg4I9fVZ87tSDQd9ZBzUUf8TxtLDZ7VIw
         f8ynZ6VnC+hYENtTUhTUDKd5GBny/pFW6UX/A0FSt5OxEiWZvNgmmUQM3Dc+bKKiBTQ0
         WRJJ8xHU5uhx49zYTtbphZlcX3l2Q/JdRjOTcjt1KneYAaYPa1WXvc8w/wMU+hkKIQIi
         Hp4w==
Received: by 10.236.179.70 with SMTP id g46mr16659548yhm.28.1334692217046;
        Tue, 17 Apr 2012 12:50:17 -0700 (PDT)
Received: from localhost.localdomain (173-164-30-65-Nashville.hfc.comcastbusiness.net. [173.164.30.65])
        by mx.google.com with ESMTPS id b27sm23183436yhe.8.2012.04.17.12.50.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 12:50:15 -0700 (PDT)
From:   Will Drewry <wad@chromium.org>
To:     jmorris@namei.org
Cc:     linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        linux-security-module@vger.kernel.org,
        Will Drewry <wad@chromium.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Paris <eparis@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@elte.hu>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        James Morris <james.l.morris@oracle.com>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 1/2] seccomp: ignore secure_computing return values
Date:   Tue, 17 Apr 2012 14:48:57 -0500
Message-Id: <1334692161-6834-1-git-send-email-wad@chromium.org>
X-Mailer: git-send-email 1.7.5.4
X-Gm-Message-State: ALoCoQkRovhgL2o0qhpRplGflUf1kjVNhlZXlubU2PpUYiIzMSfvBTOMRcNNrlu02PYvdcSM8kJf
X-archive-position: 32957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wad@chromium.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This change is inspired by
  https://lkml.org/lkml/2012/4/16/14
which fixes the build warnings for arches that don't support
CONFIG_HAVE_ARCH_SECCOMP_FILTER.

In particular, there is no requirement for the return value of
secure_computing() to be checked unless the architecture supports
seccomp filter.  Instead of silencing the warnings with (void)
a new static inline is added to encode the expected behavior
in a compiler and human friendly way.

v2: - cleans things up with a static inline
    - removes sfr's signed-off-by since it is a different approach
v1: - matches sfr's original change

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Will Drewry <wad@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
---
 arch/microblaze/kernel/ptrace.c |    2 +-
 arch/mips/kernel/ptrace.c       |    2 +-
 arch/powerpc/kernel/ptrace.c    |    2 +-
 arch/s390/kernel/ptrace.c       |    2 +-
 arch/sh/kernel/ptrace_32.c      |    2 +-
 arch/sh/kernel/ptrace_64.c      |    2 +-
 arch/sparc/kernel/ptrace_64.c   |    2 +-
 include/linux/seccomp.h         |    7 +++++++
 8 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/kernel/ptrace.c b/arch/microblaze/kernel/ptrace.c
index 6eb2aa9..ab1b9db 100644
--- a/arch/microblaze/kernel/ptrace.c
+++ b/arch/microblaze/kernel/ptrace.c
@@ -136,7 +136,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	long ret = 0;
 
-	secure_computing(regs->r12);
+	secure_computing_strict(regs->r12);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs))
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 7c24c29..4812c6d 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -535,7 +535,7 @@ static inline int audit_arch(void)
 asmlinkage void syscall_trace_enter(struct pt_regs *regs)
 {
 	/* do the secure computing check first */
-	secure_computing(regs->regs[2]);
+	secure_computing_strict(regs->regs[2]);
 
 	if (!(current->ptrace & PT_PTRACED))
 		goto out;
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 8d8e028..dd5e214 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1710,7 +1710,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	long ret = 0;
 
-	secure_computing(regs->gpr[0]);
+	secure_computing_strict(regs->gpr[0]);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs))
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 02f300f..4993e68 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -719,7 +719,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	long ret = 0;
 
 	/* Do the secure computing check first. */
-	secure_computing(regs->gprs[2]);
+	secure_computing_strict(regs->gprs[2]);
 
 	/*
 	 * The sysc_tracesys code in entry.S stored the system
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 9698671..81f999a 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -503,7 +503,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	long ret = 0;
 
-	secure_computing(regs->regs[0]);
+	secure_computing_strict(regs->regs[0]);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs))
diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index bc81e07..af90339 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -522,7 +522,7 @@ asmlinkage long long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	long long ret = 0;
 
-	secure_computing(regs->regs[9]);
+	secure_computing_strict(regs->regs[9]);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs))
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 6f97c07..484daba 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -1062,7 +1062,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	int ret = 0;
 
 	/* do the secure computing check first */
-	secure_computing(regs->u_regs[UREG_G1]);
+	secure_computing_strict(regs->u_regs[UREG_G1]);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		ret = tracehook_report_syscall_entry(regs);
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 60f2b35..84f6320d 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -75,6 +75,12 @@ static inline int secure_computing(int this_syscall)
 	return 0;
 }
 
+/* A wrapper for architectures supporting only SECCOMP_MODE_STRICT. */
+static inline void secure_computing_strict(int this_syscall)
+{
+	BUG_ON(secure_computing(this_syscall) != 0);
+}
+
 extern long prctl_get_seccomp(void);
 extern long prctl_set_seccomp(unsigned long, char __user *);
 
@@ -91,6 +97,7 @@ struct seccomp { };
 struct seccomp_filter { };
 
 static inline int secure_computing(int this_syscall) { return 0; }
+static inline void secure_computing_strict(int this_syscall) { return; }
 
 static inline long prctl_get_seccomp(void)
 {
-- 
1.7.5.4
