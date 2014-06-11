Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 22:24:45 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:48296 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854785AbaFKUXXKqbNz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2014 22:23:23 +0200
Received: by mail-pd0-f180.google.com with SMTP id ft15so170160pdb.39
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2014 13:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=oEHt+uc4Kp+70dv+ImTo9hMjKryUC2WJo/8V99cxpGc=;
        b=gQUdls37z0+3E/zFJO2C1siGGR2YDRU/ZcZ6b2xbrCb9tU6HPAU+yCuA9tG9tUglKM
         FkxFZeusJhHkN9L2wSe3q3CPBrp3VuxeLREYrhSdPFOdfXUv9+OIr5qD4Ok3aSBnGKBZ
         DJDUgdXQ+UQzxim+w8KDHcs9GABP9F6fIvbs4AB1rbeCid8bw9DuOdU6K5binb0xwA17
         BnURilBUJZoLnlLGmCXgakbyIylgjdXn5KiCVHx4Gr0wY2LzoXK/A8AmcdKUQ/GUys09
         pL7zjpr0eaPcBF2VWy9D/U/HyQa34VgmPgR2Qh06yWLxyBL45vFRqsx9EWpKWzn8niwc
         pjqA==
X-Gm-Message-State: ALoCoQlE1QA6SG7+jcSKg4tyklskFYXEqIuWNhdt8BeEyXFCsFcu0urTJ+BAwod+jn7HvDSrJJXt
X-Received: by 10.68.110.65 with SMTP id hy1mr7745098pbb.67.1402518196998;
        Wed, 11 Jun 2014 13:23:16 -0700 (PDT)
Received: from localhost (50-76-60-73-ip-static.hfc.comcastbusiness.net. [50.76.60.73])
        by mx.google.com with ESMTPSA id ty3sm34022326pab.20.2014.06.11.13.23.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jun 2014 13:23:16 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: [RFC 4/5] seccomp: Allow arch code to provide seccomp_data
Date:   Wed, 11 Jun 2014 13:23:01 -0700
Message-Id: <af17871053f445e38c743d348f69233035280bb3.1402517933.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1402517933.git.luto@amacapital.net>
References: <cover.1402517933.git.luto@amacapital.net>
In-Reply-To: <cover.1402517933.git.luto@amacapital.net>
References: <cover.1402517933.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40493
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

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 include/linux/seccomp.h |  2 +-
 kernel/seccomp.c        | 32 +++++++++++++++++++-------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 8345fdc..4fc7a84 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -37,7 +37,7 @@ static inline int secure_computing(void)
 #define SECCOMP_PHASE1_OK	0
 #define SECCOMP_PHASE1_SKIP	1
 
-extern u32 seccomp_phase1(void);
+extern u32 seccomp_phase1(struct seccomp_data *sd);
 int seccomp_phase2(u32 phase1_result);
 #else
 extern void secure_computing_strict(int this_syscall);
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index dfdb38a..6848912 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -173,24 +173,27 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
  *
  * Returns valid seccomp BPF response codes.
  */
-static u32 seccomp_run_filters(void)
+static u32 seccomp_run_filters(struct seccomp_data *sd)
 {
 	struct seccomp_filter *f;
-	struct seccomp_data sd;
+	struct seccomp_data sd_local;
 	u32 ret = SECCOMP_RET_ALLOW;
 
 	/* Ensure unexpected behavior doesn't result in failing open. */
 	if (WARN_ON(current->seccomp.filter == NULL))
 		return SECCOMP_RET_KILL;
 
-	populate_seccomp_data(&sd);
+	if (!sd) {
+		populate_seccomp_data(&sd_local);
+		sd = &sd_local;
+	}
 
 	/*
 	 * All filters in the list are evaluated and the lowest BPF return
 	 * value always takes priority (ignoring the DATA).
 	 */
 	for (f = current->seccomp.filter; f; f = f->prev) {
-		u32 cur_ret = sk_run_filter_int_seccomp(&sd, f->insnsi);
+		u32 cur_ret = sk_run_filter_int_seccomp(sd, f->insnsi);
 		if ((cur_ret & SECCOMP_RET_ACTION) < (ret & SECCOMP_RET_ACTION))
 			ret = cur_ret;
 	}
@@ -406,7 +409,7 @@ void secure_computing_strict(int this_syscall)
 #else
 int __secure_computing(void)
 {
-	u32 phase1_result = seccomp_phase1();
+	u32 phase1_result = seccomp_phase1(NULL);
 	if (likely(phase1_result == SECCOMP_PHASE1_OK))
 		return 0;
 	else if (likely(phase1_result == SECCOMP_PHASE1_SKIP))
@@ -416,22 +419,22 @@ int __secure_computing(void)
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
-static u32 __seccomp_phase1_filter(int this_syscall, struct pt_regs *regs)
+static u32 __seccomp_phase1_filter(int this_syscall, struct seccomp_data *sd)
 {
-	u32 filter_ret = seccomp_run_filters();
+	u32 filter_ret = seccomp_run_filters(sd);
 	int data = filter_ret & SECCOMP_RET_DATA;
 	u32 action = filter_ret & SECCOMP_RET_ACTION;
 
 	switch (action) {
 	case SECCOMP_RET_ERRNO:
 		/* Set the low-order 16-bits as a errno. */
-		syscall_set_return_value(current, regs,
+		syscall_set_return_value(current, task_pt_regs(current),
 					 -data, 0);
 		goto skip;
 
 	case SECCOMP_RET_TRAP:
 		/* Show the handler the original registers. */
-		syscall_rollback(current, regs);
+		syscall_rollback(current, task_pt_regs(current));
 		/* Let the filter pass back 16 bits of data. */
 		seccomp_send_sigsys(this_syscall, data);
 		goto skip;
@@ -458,11 +461,14 @@ skip:
 
 /**
  * seccomp_phase1() - run fast path seccomp checks on the current syscall
+ * @arg sd: The seccomp_data or NULL
  *
  * This only reads pt_regs via the syscall_xyz helpers.  The only change
  * it will make to pt_regs is via syscall_set_return_value, and it will
  * only do that if it returns SECCOMP_PHASE1_SKIP.
  *
+ * If sd is provided, it will not read pt_regs at all.
+ *
  * It may also call do_exit or force a signal; these actions must be
  * safe.
  *
@@ -476,11 +482,11 @@ skip:
  * If it returns anything else, then the return value should be passed
  * to seccomp_phase2 from a context in which ptrace hooks are safe.
  */
-u32 seccomp_phase1(void)
+u32 seccomp_phase1(struct seccomp_data *sd)
 {
 	int mode = current->seccomp.mode;
-	struct pt_regs *regs = task_pt_regs(current);
-	int this_syscall = syscall_get_nr(current, regs);
+	int this_syscall = sd ? sd->nr :
+		syscall_get_nr(current, task_pt_regs(current));
 
 	switch (mode) {
 	case SECCOMP_MODE_STRICT:
@@ -488,7 +494,7 @@ u32 seccomp_phase1(void)
 		return SECCOMP_PHASE1_OK;
 #ifdef CONFIG_SECCOMP_FILTER
 	case SECCOMP_MODE_FILTER:
-		return __seccomp_phase1_filter(this_syscall, regs);
+		return __seccomp_phase1_filter(this_syscall, sd);
 #endif
 	default:
 		BUG();
-- 
1.9.3
