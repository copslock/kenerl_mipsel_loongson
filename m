Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2014 21:33:30 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64522 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861041AbaGOTc6wnbEB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2014 21:32:58 +0200
Received: by mail-pa0-f42.google.com with SMTP id lf10so3911654pab.15
        for <linux-mips@linux-mips.org>; Tue, 15 Jul 2014 12:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bCasb9cM7TeqrESHyMRFlW92GY0TvUnGzGnSGeGigtw=;
        b=dwjjfV23q/iOwIehYP2i0j9rpOLDiyg1UjJuYb+kUlE3tdVADgSyIC28/wmPsNVXgn
         UXdv//2DCG/sGhv3TJE5FaSZUZLob2h9JoYEGlT2x/sRLHzKVZz4KbGh6F7qtHIhkkmh
         lmYCykS5wjEMTiKrcs74gntfp1s7FJasL6c5RV3HbBLN7ZjQ4gulX8ljUWw7J24cJ7TJ
         Fm+o4AcIpeAdiQxeEVUCnB44cS/KuHADJAOxjJUD2BaTXAw5g9IHLdkX0yF1MlibsPvv
         UzmWNhkYASGfZx/ECfQzdbRoKCz1QJEJFEJR+daTC4Nut/nVaGRPxsNhR6DLi6ppKE6Q
         iE7w==
X-Gm-Message-State: ALoCoQnWSYW+EOoPznVRIFKnPyQqfN9H0UEvEGLXPRXwQ2ygfmxpqUlG4BhbLO+9xyw3QBPnDecW
X-Received: by 10.68.106.101 with SMTP id gt5mr5679844pbb.134.1405452772396;
        Tue, 15 Jul 2014 12:32:52 -0700 (PDT)
Received: from localhost ([2001:5a8:4:83c0:b456:e6bb:934a:3ab7])
        by mx.google.com with ESMTPSA id hl1sm19678237pdb.41.2014.07.15.12.32.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jul 2014 12:32:51 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        James Morris <james.l.morris@oracle.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 2/7] seccomp: Refactor the filter callback and the API
Date:   Tue, 15 Jul 2014 12:32:31 -0700
Message-Id: <4f153feea35430104d6d1a7c83805fccbffdf089.1405452484.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
In-Reply-To: <cover.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41200
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

The reason I did this is to add a seccomp API that will be usable
for an x86 fast path.  The x86 entry code needs to use a rather
expensive slow path for a syscall that might be visible to things
like ptrace.  By splitting seccomp into two phases, we can check
whether we need the slow path and then use the fast path in if the
filter allows the syscall or just returns some errno.

As a side effect, I think the new code is much easier to understand
than the old code.

This has one user-visible effect: the audit record written for
SECCOMP_RET_TRACE is now a simple indication that SECCOMP_RET_TRACE
happened.  It used to depend in a complicated way on what the tracer
did.  I couldn't make much sense of it.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 include/linux/seccomp.h |   6 ++
 kernel/seccomp.c        | 180 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 123 insertions(+), 63 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 6e655a6..8345fdc 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -33,6 +33,12 @@ static inline int secure_computing(void)
 		return  __secure_computing();
 	return 0;
 }
+
+#define SECCOMP_PHASE1_OK	0
+#define SECCOMP_PHASE1_SKIP	1
+
+extern u32 seccomp_phase1(void);
+int seccomp_phase2(u32 phase1_result);
 #else
 extern void secure_computing_strict(int this_syscall);
 #endif
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 15ee9d6..d737445 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -19,8 +19,6 @@
 #include <linux/sched.h>
 #include <linux/seccomp.h>
 
-/* #define SECCOMP_DEBUG 1 */
-
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 #include <asm/syscall.h>
 #endif
@@ -417,79 +415,135 @@ void secure_computing_strict(int this_syscall)
 #else
 int __secure_computing(void)
 {
+	u32 phase1_result = seccomp_phase1();
+
+	if (likely(phase1_result == SECCOMP_PHASE1_OK))
+		return 0;
+	else if (likely(phase1_result == SECCOMP_PHASE1_SKIP))
+		return -1;
+	else
+		return seccomp_phase2(phase1_result);
+}
+
+#ifdef CONFIG_SECCOMP_FILTER
+static u32 __seccomp_phase1_filter(int this_syscall, struct pt_regs *regs)
+{
+	u32 filter_ret = seccomp_run_filters();
+	int data = filter_ret & SECCOMP_RET_DATA;
+	u32 action = filter_ret & SECCOMP_RET_ACTION;
+
+	switch (action) {
+	case SECCOMP_RET_ERRNO:
+		/* Set the low-order 16-bits as a errno. */
+		syscall_set_return_value(current, regs,
+					 -data, 0);
+		goto skip;
+
+	case SECCOMP_RET_TRAP:
+		/* Show the handler the original registers. */
+		syscall_rollback(current, regs);
+		/* Let the filter pass back 16 bits of data. */
+		seccomp_send_sigsys(this_syscall, data);
+		goto skip;
+
+	case SECCOMP_RET_TRACE:
+		return filter_ret;  /* Save the rest for phase 2. */
+
+	case SECCOMP_RET_ALLOW:
+		return SECCOMP_PHASE1_OK;
+
+	case SECCOMP_RET_KILL:
+	default:
+		audit_seccomp(this_syscall, SIGSYS, action);
+		do_exit(SIGSYS);
+	}
+
+	unreachable();
+
+skip:
+	audit_seccomp(this_syscall, 0, action);
+	return SECCOMP_PHASE1_SKIP;
+}
+#endif
+
+/**
+ * seccomp_phase1() - run fast path seccomp checks on the current syscall
+ *
+ * This only reads pt_regs via the syscall_xyz helpers.  The only change
+ * it will make to pt_regs is via syscall_set_return_value, and it will
+ * only do that if it returns SECCOMP_PHASE1_SKIP.
+ *
+ * It may also call do_exit or force a signal; these actions must be
+ * safe.
+ *
+ * If it returns SECCOMP_PHASE1_OK, the syscall passes checks and should
+ * be processed normally.
+ *
+ * If it returns SECCOMP_PHASE1_SKIP, then the syscall should not be
+ * invoked.  In this case, seccomp_phase1 will have set the return value
+ * using syscall_set_return_value.
+ *
+ * If it returns anything else, then the return value should be passed
+ * to seccomp_phase2 from a context in which ptrace hooks are safe.
+ */
+u32 seccomp_phase1(void)
+{
 	int mode = current->seccomp.mode;
 	struct pt_regs *regs = task_pt_regs(current);
 	int this_syscall = syscall_get_nr(current, regs);
-	int exit_sig = 0;
-	u32 ret;
 
 	switch (mode) {
 	case SECCOMP_MODE_STRICT:
-		__secure_computing_strict(this_syscall);
-		return 0;
+		__secure_computing_strict(this_syscall);  /* may call do_exit */
+		return SECCOMP_PHASE1_OK;
 #ifdef CONFIG_SECCOMP_FILTER
-	case SECCOMP_MODE_FILTER: {
-		int data;
-		ret = seccomp_run_filters();
-		data = ret & SECCOMP_RET_DATA;
-		ret &= SECCOMP_RET_ACTION;
-		switch (ret) {
-		case SECCOMP_RET_ERRNO:
-			/* Set the low-order 16-bits as a errno. */
-			syscall_set_return_value(current, regs,
-						 -data, 0);
-			goto skip;
-		case SECCOMP_RET_TRAP:
-			/* Show the handler the original registers. */
-			syscall_rollback(current, regs);
-			/* Let the filter pass back 16 bits of data. */
-			seccomp_send_sigsys(this_syscall, data);
-			goto skip;
-		case SECCOMP_RET_TRACE:
-			/* Skip these calls if there is no tracer. */
-			if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
-				syscall_set_return_value(current, regs,
-							 -ENOSYS, 0);
-				goto skip;
-			}
-			/* Allow the BPF to provide the event message */
-			ptrace_event(PTRACE_EVENT_SECCOMP, data);
-			/*
-			 * The delivery of a fatal signal during event
-			 * notification may silently skip tracer notification.
-			 * Terminating the task now avoids executing a system
-			 * call that may not be intended.
-			 */
-			if (fatal_signal_pending(current))
-				break;
-			if (syscall_get_nr(current, regs) < 0)
-				goto skip;  /* Explicit request to skip. */
-
-			return 0;
-		case SECCOMP_RET_ALLOW:
-			return 0;
-		case SECCOMP_RET_KILL:
-		default:
-			break;
-		}
-		exit_sig = SIGSYS;
-		break;
-	}
+	case SECCOMP_MODE_FILTER:
+		return __seccomp_phase1_filter(this_syscall, regs);
 #endif
 	default:
 		BUG();
 	}
+}
 
-#ifdef SECCOMP_DEBUG
-	dump_stack();
-#endif
-	audit_seccomp(this_syscall, exit_sig, ret);
-	do_exit(exit_sig);
-#ifdef CONFIG_SECCOMP_FILTER
-skip:
-	audit_seccomp(this_syscall, exit_sig, ret);
-	return -1;
-#endif
+/**
+ * seccomp_phase2() - finish slow path seccomp work for the current syscall
+ * @phase1_result: The return value from seccomp_phase1()
+ *
+ * This must be called from a context in which ptrace hooks can be used.
+ *
+ * Returns 0 if the syscall should be processed or -1 to skip the syscall.
+ */
+int seccomp_phase2(u32 phase1_result)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	u32 action = phase1_result & SECCOMP_RET_ACTION;
+	int data = phase1_result & SECCOMP_RET_DATA;
+
+	BUG_ON(action != SECCOMP_RET_TRACE);
+
+	audit_seccomp(syscall_get_nr(current, regs), 0, action);
+
+	/* Skip these calls if there is no tracer. */
+	if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
+		syscall_set_return_value(current, regs,
+					 -ENOSYS, 0);
+		return -1;
+	}
+
+	/* Allow the BPF to provide the event message */
+	ptrace_event(PTRACE_EVENT_SECCOMP, data);
+	/*
+	 * The delivery of a fatal signal during event
+	 * notification may silently skip tracer notification.
+	 * Terminating the task now avoids executing a system
+	 * call that may not be intended.
+	 */
+	if (fatal_signal_pending(current))
+		do_exit(SIGSYS);
+	if (syscall_get_nr(current, regs) < 0)
+		return -1;  /* Explicit request to skip. */
+
+	return 0;
 }
 #endif /* CONFIG_HAVE_ARCH_SECCOMP_FILTER */
 
-- 
1.9.3
