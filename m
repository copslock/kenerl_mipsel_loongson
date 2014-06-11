Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 22:23:36 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:65118 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859994AbaFKUXSBqS1o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2014 22:23:18 +0200
Received: by mail-pa0-f50.google.com with SMTP id fb1so179149pad.37
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2014 13:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bhxTkjdZTXrPkzs45YJVn2+YL+AI8m+nniMO1aRB7+U=;
        b=kGZk1tG294M8ILXfLyQvVyeA8JxmgGF62nshaqZYsky+Kz7FfbolNrLrVjIGs9uN3t
         px10ynl1WrsvR3ZTb/zp5f/TDOk3aOtpyb4iy+3Go2jB0GKscWkljRECfWQl8ixlg5BM
         8tR3mQ4+mph+l3hojaSvYu3G9MYt8EDXjgzMMruHvtnkiewU9A2ehpYw2INqnifuJ7Jp
         AaLMU0PtTGchb9wbyDxpVWiy9dIJZFAyg4Cqw+wbJcTAxmWrQBHhZHukujskDXpVywOl
         rXvk8WpdQyEEWP0H/jjNqGpf6Ti+c9skvdKVoU5/ZyUwWgbNoXBCl3cmJWWJ6qrieQXI
         H3KQ==
X-Gm-Message-State: ALoCoQkOb4l1sbyjVWEjfG7+IrEZrsl4Jzb2LwYO+y58ApkbDQZOSl6eYCtvqRC7xbGmmvQZv4lY
X-Received: by 10.68.133.7 with SMTP id oy7mr7802007pbb.43.1402518190745;
        Wed, 11 Jun 2014 13:23:10 -0700 (PDT)
Received: from localhost (50-76-60-73-ip-static.hfc.comcastbusiness.net. [50.76.60.73])
        by mx.google.com with ESMTPSA id zb2sm76536244pbb.45.2014.06.11.13.23.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jun 2014 13:23:10 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [RFC 1/5] seccomp,x86,arm,mips,s390: Remove nr parameter from secure_computing
Date:   Wed, 11 Jun 2014 13:22:58 -0700
Message-Id: <4b5a6a6f58965ac02b84c074b939a3b6240ddb31.1402517933.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1402517933.git.luto@amacapital.net>
References: <cover.1402517933.git.luto@amacapital.net>
In-Reply-To: <cover.1402517933.git.luto@amacapital.net>
References: <cover.1402517933.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40490
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

The secure_computing function took a syscall number parameter, but
it only paid any attention to that parameter if seccomp mode 1 was
enabled.  Rather than coming up with a kludge to get the parameter
to work in mode 2, just remove the parameter.

To avoid churn in arches that don't have seccomp filters (and may
not even support syscall_get_nr right now), this leaves the
parameter in secure_computing_strict, which is now a real function.

For ARM, this is a bit ugly due to the fact that ARM conditionally
supports seccomp filters.  Fixing that is probably only be a couple
of lines of code, but it should be coordinated with the audit
maintainers.

This will be a slight slowdown on some arches.  The right fix is to
pass in all of seccomp_data instead of trying to make just the
syscall nr part be fast.

I'm working on a big seccomp speedup for x86, but I'd like to remove
this wart first.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 arch/arm/kernel/ptrace.c      |  7 ++++-
 arch/mips/kernel/ptrace.c     |  2 +-
 arch/s390/kernel/ptrace.c     |  2 +-
 arch/x86/kernel/ptrace.c      |  2 +-
 arch/x86/kernel/vsyscall_64.c |  2 +-
 include/linux/seccomp.h       | 21 ++++++++-------
 kernel/seccomp.c              | 63 ++++++++++++++++++++++++++++++-------------
 7 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 0dd3b79..f79c9cc 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -934,8 +934,13 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
 	current_thread_info()->syscall = scno;
 
 	/* Do the secure computing check first; failures should be fast. */
-	if (secure_computing(scno) == -1)
+#ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
+	if (secure_computing() == -1)
 		return -1;
+#else
+	/* XXX: remove this once OABI gets fixed */
+	secure_computing_strict(scno);
+#endif
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		scno = tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index f639ccd..808bafc 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -639,7 +639,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 	long ret = 0;
 	user_exit();
 
-	if (secure_computing(syscall) == -1)
+	if (secure_computing() == -1)
 		return -1;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 1c82619..20f1998 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -795,7 +795,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	long ret = 0;
 
 	/* Do the secure computing check first. */
-	if (secure_computing(regs->gprs[2])) {
+	if (secure_computing()) {
 		/* seccomp failures shouldn't expose any additional code. */
 		ret = -1;
 		goto out;
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 678c0ad..93c182a 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1471,7 +1471,7 @@ long syscall_trace_enter(struct pt_regs *regs)
 		regs->flags |= X86_EFLAGS_TF;
 
 	/* do the secure computing check first */
-	if (secure_computing(regs->orig_ax)) {
+	if (secure_computing()) {
 		/* seccomp failures shouldn't expose any additional code. */
 		ret = -1L;
 		goto out;
diff --git a/arch/x86/kernel/vsyscall_64.c b/arch/x86/kernel/vsyscall_64.c
index 8b3b3eb..47a4123 100644
--- a/arch/x86/kernel/vsyscall_64.c
+++ b/arch/x86/kernel/vsyscall_64.c
@@ -216,7 +216,7 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 	 */
 	regs->orig_ax = syscall_nr;
 	regs->ax = -ENOSYS;
-	tmp = secure_computing(syscall_nr);
+	tmp = secure_computing();
 	if ((!tmp && regs->orig_ax != syscall_nr) || regs->ip != address) {
 		warn_bad_vsyscall(KERN_DEBUG, regs,
 				  "seccomp tried to change syscall nr or ip");
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 4054b09..6e655a6 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -25,19 +25,17 @@ struct seccomp {
 	struct seccomp_filter *filter;
 };
 
-extern int __secure_computing(int);
-static inline int secure_computing(int this_syscall)
+#ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
+extern int __secure_computing(void);
+static inline int secure_computing(void)
 {
 	if (unlikely(test_thread_flag(TIF_SECCOMP)))
-		return  __secure_computing(this_syscall);
+		return  __secure_computing();
 	return 0;
 }
-
-/* A wrapper for architectures supporting only SECCOMP_MODE_STRICT. */
-static inline void secure_computing_strict(int this_syscall)
-{
-	BUG_ON(secure_computing(this_syscall) != 0);
-}
+#else
+extern void secure_computing_strict(int this_syscall);
+#endif
 
 extern long prctl_get_seccomp(void);
 extern long prctl_set_seccomp(unsigned long, char __user *);
@@ -54,8 +52,11 @@ static inline int seccomp_mode(struct seccomp *s)
 struct seccomp { };
 struct seccomp_filter { };
 
-static inline int secure_computing(int this_syscall) { return 0; }
+#ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
+static inline int secure_computing(void) { return 0; }
+#else
 static inline void secure_computing_strict(int this_syscall) { return; }
+#endif
 
 static inline long prctl_get_seccomp(void)
 {
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index b35c215..4af399a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -21,8 +21,11 @@
 
 /* #define SECCOMP_DEBUG 1 */
 
-#ifdef CONFIG_SECCOMP_FILTER
+#ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 #include <asm/syscall.h>
+#endif
+
+#ifdef CONFIG_SECCOMP_FILTER
 #include <linux/filter.h>
 #include <linux/ptrace.h>
 #include <linux/security.h>
@@ -172,7 +175,7 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
  *
  * Returns valid seccomp BPF response codes.
  */
-static u32 seccomp_run_filters(int syscall)
+static u32 seccomp_run_filters(void)
 {
 	struct seccomp_filter *f;
 	struct seccomp_data sd;
@@ -372,32 +375,53 @@ static int mode1_syscalls_32[] = {
 };
 #endif
 
-int __secure_computing(int this_syscall)
+static void __secure_computing_strict(int this_syscall)
+{
+	int *syscall_whitelist = mode1_syscalls;
+#ifdef CONFIG_COMPAT
+	if (is_compat_task())
+		syscall_whitelist = mode1_syscalls_32;
+#endif
+	do {
+		if (*syscall_whitelist == this_syscall)
+			return;
+	} while (*++syscall_whitelist);
+
+#ifdef SECCOMP_DEBUG
+	dump_stack();
+#endif
+	audit_seccomp(this_syscall, SIGKILL, SECCOMP_RET_KILL);
+	do_exit(SIGKILL);
+}
+
+#ifndef CONFIG_HAVE_ARCH_SECCOMP_FILTER
+void secure_computing_strict(int this_syscall)
+{
+	int mode = current->seccomp.mode;
+	if (mode == 0)
+		return;
+	else if (mode == SECCOMP_MODE_STRICT)
+		__secure_computing_strict(this_syscall);
+	else
+		BUG();
+}
+#else
+int __secure_computing(void)
 {
 	int mode = current->seccomp.mode;
+	struct pt_regs *regs = task_pt_regs(current);
+	int this_syscall = syscall_get_nr(current, regs);
 	int exit_sig = 0;
-	int *syscall;
 	u32 ret;
 
 	switch (mode) {
 	case SECCOMP_MODE_STRICT:
-		syscall = mode1_syscalls;
-#ifdef CONFIG_COMPAT
-		if (is_compat_task())
-			syscall = mode1_syscalls_32;
-#endif
-		do {
-			if (*syscall == this_syscall)
-				return 0;
-		} while (*++syscall);
-		exit_sig = SIGKILL;
-		ret = SECCOMP_RET_KILL;
-		break;
+		__secure_computing_strict(this_syscall);
+		return 0;
 #ifdef CONFIG_SECCOMP_FILTER
 	case SECCOMP_MODE_FILTER: {
 		int data;
-		struct pt_regs *regs = task_pt_regs(current);
-		ret = seccomp_run_filters(this_syscall);
+		ret = seccomp_run_filters();
 		data = ret & SECCOMP_RET_DATA;
 		ret &= SECCOMP_RET_ACTION;
 		switch (ret) {
@@ -455,9 +479,10 @@ int __secure_computing(int this_syscall)
 #ifdef CONFIG_SECCOMP_FILTER
 skip:
 	audit_seccomp(this_syscall, exit_sig, ret);
-#endif
 	return -1;
+#endif
 }
+#endif /* CONFIG_HAVE_ARCH_SECCOMP_FILTER */
 
 long prctl_get_seccomp(void)
 {
-- 
1.9.3
