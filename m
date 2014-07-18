Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 23:19:45 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:54696 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861361AbaGRVTD4gihW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 23:19:03 +0200
Received: by mail-pd0-f180.google.com with SMTP id y13so5667400pdi.11
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 14:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EJJLfS8opdD37HkB9j+MtWi+63KwbM1xtGRDDzLjWn4=;
        b=mAdhN/DT2DYGdPGSzdcB4nFjaW2JW+Vn0MpK+1tc04kTCDu/PhzozKLNEmP53NSF5h
         4ia78mJDZPFfmsn7b3Ks2B63qBKf2f/KjtSaSEH61wRHADdqStkOXJXJPeN7gbbbTjtN
         NVTPRde3kGAOPq1JCnFEHDap1GsbFvpuZOKDvUcSfD30e/lBAbmhU8KmseD7ls39FbHw
         wmJrI82J8Hy98ZfrVp1x/nhKqvSQdmfQpbcHQ9UkXU13J5jZIf1jgSqmTGZhRmJJUg8s
         2qv9+bwtpdM7d8+Vlri2uJcDCspe2LosiPo+nDIanc2JfL9aWBbLXsHU69xivWhiCoV2
         LvKQ==
X-Gm-Message-State: ALoCoQnvNzNVwpEhJdNOxvMamR09k7+nT9IMfIZd8uUpK5pCdp+QeAlw+wn82bnN9vg2xUtQyXMD
X-Received: by 10.66.253.170 with SMTP id ab10mr8359581pad.53.1405718337342;
        Fri, 18 Jul 2014 14:18:57 -0700 (PDT)
Received: from localhost (50-76-60-73-ip-static.hfc.comcastbusiness.net. [50.76.60.73])
        by mx.google.com with ESMTPSA id wd7sm26860190pab.47.2014.07.18.14.18.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jul 2014 14:18:56 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 3/7] seccomp: Allow arch code to provide seccomp_data
Date:   Fri, 18 Jul 2014 14:18:11 -0700
Message-Id: <ce65e0e8be18ae8fab437899db44ca41c912b506.1405717901.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1405717901.git.luto@amacapital.net>
References: <cover.1405717901.git.luto@amacapital.net>
In-Reply-To: <cover.1405717901.git.luto@amacapital.net>
References: <cover.1405717901.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41336
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

populate_seccomp_data is expensive: it works by inspecting
task_pt_regs and various other bits to piece together all the
information, and it's does so in multiple partially redundant steps.

Arch-specific code in the syscall entry path can do much better.

Admittedly this adds a bit of additional room for error, but the
speedup should be worth it.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 include/linux/seccomp.h |  2 +-
 kernel/seccomp.c        | 32 +++++++++++++++++++-------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 3885108..a19ddac 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -39,7 +39,7 @@ static inline int secure_computing(void)
 #define SECCOMP_PHASE1_OK	0
 #define SECCOMP_PHASE1_SKIP	1
 
-extern u32 seccomp_phase1(void);
+extern u32 seccomp_phase1(struct seccomp_data *sd);
 int seccomp_phase2(u32 phase1_result);
 #else
 extern void secure_computing_strict(int this_syscall);
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 0088d29..80115b0 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -173,10 +173,10 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
  *
  * Returns valid seccomp BPF response codes.
  */
-static u32 seccomp_run_filters(void)
+static u32 seccomp_run_filters(struct seccomp_data *sd)
 {
 	struct seccomp_filter *f = ACCESS_ONCE(current->seccomp.filter);
-	struct seccomp_data sd;
+	struct seccomp_data sd_local;
 	u32 ret = SECCOMP_RET_ALLOW;
 
 	/* Ensure unexpected behavior doesn't result in failing open. */
@@ -186,14 +186,17 @@ static u32 seccomp_run_filters(void)
 	/* Make sure cross-thread synced filter points somewhere sane. */
 	smp_read_barrier_depends();
 
-	populate_seccomp_data(&sd);
+	if (!sd) {
+		populate_seccomp_data(&sd_local);
+		sd = &sd_local;
+	}
 
 	/*
 	 * All filters in the list are evaluated and the lowest BPF return
 	 * value always takes priority (ignoring the DATA).
 	 */
 	for (; f; f = f->prev) {
-		u32 cur_ret = SK_RUN_FILTER(f->prog, (void *)&sd);
+		u32 cur_ret = SK_RUN_FILTER(f->prog, (void *)sd);
 
 		if ((cur_ret & SECCOMP_RET_ACTION) < (ret & SECCOMP_RET_ACTION))
 			ret = cur_ret;
@@ -599,7 +602,7 @@ void secure_computing_strict(int this_syscall)
 #else
 int __secure_computing(void)
 {
-	u32 phase1_result = seccomp_phase1();
+	u32 phase1_result = seccomp_phase1(NULL);
 
 	if (likely(phase1_result == SECCOMP_PHASE1_OK))
 		return 0;
@@ -610,7 +613,7 @@ int __secure_computing(void)
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
-static u32 __seccomp_phase1_filter(int this_syscall, struct pt_regs *regs)
+static u32 __seccomp_phase1_filter(int this_syscall, struct seccomp_data *sd)
 {
 	u32 filter_ret, action;
 	int data;
@@ -621,20 +624,20 @@ static u32 __seccomp_phase1_filter(int this_syscall, struct pt_regs *regs)
 	 */
 	rmb();
 
-	filter_ret = seccomp_run_filters();
+	filter_ret = seccomp_run_filters(sd);
 	data = filter_ret & SECCOMP_RET_DATA;
 	action = filter_ret & SECCOMP_RET_ACTION;
 
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
@@ -661,11 +664,14 @@ skip:
 
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
@@ -679,11 +685,11 @@ skip:
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
@@ -691,7 +697,7 @@ u32 seccomp_phase1(void)
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
