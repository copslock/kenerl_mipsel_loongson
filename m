Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 01:33:21 +0200 (CEST)
Received: from smtp.outflux.net ([198.145.64.163]:55689 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860050AbaF0XXRNoT1G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Jun 2014 01:23:17 +0200
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id s5RNN8E7026804;
        Fri, 27 Jun 2014 16:23:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v9 10/11] seccomp: allow mode setting across threads
Date:   Fri, 27 Jun 2014 16:22:59 -0700
Message-Id: <1403911380-27787-11-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1403911380-27787-1-git-send-email-keescook@chromium.org>
References: <1403911380-27787-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40894
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

This changes the mode setting helper to allow threads to change the
seccomp mode from another thread. We must maintain barriers to keep
TIF_SECCOMP synchronized with the rest of the seccomp state.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c |   27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index e1ff2c193190..7bbcb9ed16df 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -207,12 +207,18 @@ static inline bool seccomp_check_mode(unsigned long seccomp_mode)
 	return true;
 }
 
-static inline void seccomp_assign_mode(unsigned long seccomp_mode)
+static inline void seccomp_assign_mode(struct task_struct *task,
+				       unsigned long seccomp_mode)
 {
-	BUG_ON(!spin_is_locked(&current->sighand->siglock));
+	BUG_ON(!spin_is_locked(&task->sighand->siglock));
 
-	current->seccomp.mode = seccomp_mode;
-	set_tsk_thread_flag(current, TIF_SECCOMP);
+	task->seccomp.mode = seccomp_mode;
+	/*
+	 * Make sure TIF_SECCOMP cannot be set before the mode (and
+	 * filter) is set.
+	 */
+	smp_mb__before_atomic();
+	set_tsk_thread_flag(task, TIF_SECCOMP);
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
@@ -433,12 +439,17 @@ static int mode1_syscalls_32[] = {
 
 int __secure_computing(int this_syscall)
 {
-	int mode = current->seccomp.mode;
 	int exit_sig = 0;
 	int *syscall;
 	u32 ret;
 
-	switch (mode) {
+	/*
+	 * Make sure that any changes to mode from another thread have
+	 * been seen after TIF_SECCOMP was seen.
+	 */
+	rmb();
+
+	switch (current->seccomp.mode) {
 	case SECCOMP_MODE_STRICT:
 		syscall = mode1_syscalls;
 #ifdef CONFIG_COMPAT
@@ -543,7 +554,7 @@ static long seccomp_set_mode_strict(void)
 #ifdef TIF_NOTSC
 	disable_TSC();
 #endif
-	seccomp_assign_mode(seccomp_mode);
+	seccomp_assign_mode(current, seccomp_mode);
 	ret = 0;
 
 out:
@@ -593,7 +604,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	/* Do not free the successfully attached filter. */
 	prepared = NULL;
 
-	seccomp_assign_mode(seccomp_mode);
+	seccomp_assign_mode(current, seccomp_mode);
 out:
 	spin_unlock_irq(&current->sighand->siglock);
 	seccomp_filter_free(prepared);
-- 
1.7.9.5
