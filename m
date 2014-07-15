Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2014 21:33:51 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:59855 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861046AbaGOTdDnzGaR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2014 21:33:03 +0200
Received: by mail-pd0-f175.google.com with SMTP id v10so7579220pde.20
        for <linux-mips@linux-mips.org>; Tue, 15 Jul 2014 12:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xWKzimVmCKJcb9GSSnzNhvAVEQwc+CoObREU8dCjiQQ=;
        b=WCdIH9wGKAwzLn0/ZIm/GfzyE4r4uRApqeK6sepflN4HqVy1j3ybuhh+ItSu606zzv
         +yYu7A5xofJiBpkoSmSH11FGTZQ2Wh98YG7oDGuxOf0gv0iSBX9K5YbotybtqXC7WCWL
         smOS91naDC6rdacf5FLSUz7+wyEybcxtVQBuexm5GNlC2f7uuqsaVk0zlsTpHh0io9gJ
         77we3YwlYjsopbIQFaf5MFl6bmpKYTPS3gRDRleK0YHiG3JMPk1Uns/FPB1e3GhnYBFy
         K4OphXilQqTtzvi9YqAUFGkr0jbGamyH4murIvv+LhKyKDHqOdolg6iym8uw0/+/6uO+
         i9UQ==
X-Gm-Message-State: ALoCoQkP/WFHMf6w+bHetQPMnz+FQgUzQ8IqIPUwTdtycEXgmE8y4TIMKA2MQcQuweY2/8owX4xj
X-Received: by 10.70.92.49 with SMTP id cj17mr24886559pdb.53.1405452777531;
        Tue, 15 Jul 2014 12:32:57 -0700 (PDT)
Received: from localhost ([2001:5a8:4:83c0:b456:e6bb:934a:3ab7])
        by mx.google.com with ESMTPSA id io8sm14740052pbc.96.2014.07.15.12.32.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jul 2014 12:32:56 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        James Morris <james.l.morris@oracle.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 3/7] seccomp: Allow arch code to provide seccomp_data
Date:   Tue, 15 Jul 2014 12:32:32 -0700
Message-Id: <bc33fe6f3afc640ec53d8e135e1c66ed12746dab.1405452484.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
In-Reply-To: <cover.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41201
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
index d737445..391f6c4 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -171,24 +171,27 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
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
-		u32 cur_ret = SK_RUN_FILTER(f->prog, (void *)&sd);
+		u32 cur_ret = SK_RUN_FILTER(f->prog, (void *)sd);
 
 		if ((cur_ret & SECCOMP_RET_ACTION) < (ret & SECCOMP_RET_ACTION))
 			ret = cur_ret;
@@ -415,7 +418,7 @@ void secure_computing_strict(int this_syscall)
 #else
 int __secure_computing(void)
 {
-	u32 phase1_result = seccomp_phase1();
+	u32 phase1_result = seccomp_phase1(NULL);
 
 	if (likely(phase1_result == SECCOMP_PHASE1_OK))
 		return 0;
@@ -426,22 +429,22 @@ int __secure_computing(void)
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
@@ -468,11 +471,14 @@ skip:
 
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
@@ -486,11 +492,11 @@ skip:
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
@@ -498,7 +504,7 @@ u32 seccomp_phase1(void)
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
