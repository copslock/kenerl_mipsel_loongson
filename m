Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 13:12:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50526 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012312AbbA3ML6eDIbT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 13:11:58 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 90FB89C8A6ED2
        for <linux-mips@linux-mips.org>; Fri, 30 Jan 2015 12:11:50 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 12:11:52 +0000
Received: from localhost (192.168.159.167) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 30 Jan
 2015 12:11:50 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 07/10] MIPS: prevent FP context set via ptrace being discarded
Date:   Fri, 30 Jan 2015 12:09:36 +0000
Message-ID: <1422619779-9940-8-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1422619779-9940-1-git-send-email-paul.burton@imgtec.com>
References: <1422619779-9940-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.167]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

If a ptracee has not used the FPU and the ptracer sets its FP context
using PTRACE_POKEUSR, PTRACE_SETFPREGS or PTRACE_SETREGSET then that
context will be discarded upon either the ptracee using the FPU or a
further write to the context via ptrace. Prevent this loss by recording
that the task has "used" math once its FP context has been written to.
The context initialisation code that was present for the PTRACE_POKEUSR
case is reused for the other 2 cases to provide consistent behaviour
for the different ptrace requests.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - Rebase atop v3.19-rc6.
---
 arch/mips/kernel/ptrace.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 9d1487d..917bb93 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -46,6 +46,26 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+static void init_fp_ctx(struct task_struct *target)
+{
+	/* If FP has been used then the target already has context */
+	if (tsk_used_math(target))
+		return;
+
+	/* Begin with data registers set to all 1s... */
+	memset(&target->thread.fpu.fpr, ~0, sizeof(target->thread.fpu.fpr));
+
+	/* ...and FCSR zeroed */
+	target->thread.fpu.fcr31 = 0;
+
+	/*
+	 * Record that the target has "used" math, such that the context
+	 * just initialised, and any modifications made by the caller,
+	 * aren't discarded.
+	 */
+	set_stopped_child_used_math(target);
+}
+
 /*
  * Called by kernel/ptrace.c when detaching..
  *
@@ -142,6 +162,7 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
 	if (!access_ok(VERIFY_READ, data, 33 * 8))
 		return -EIO;
 
+	init_fp_ctx(child);
 	fregs = get_fpu_regs(child);
 
 	for (i = 0; i < 32; i++) {
@@ -439,6 +460,8 @@ static int fpr_set(struct task_struct *target,
 
 	/* XXX fcr31  */
 
+	init_fp_ctx(target);
+
 	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
 		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 					  &target->thread.fpu,
@@ -660,12 +683,7 @@ long arch_ptrace(struct task_struct *child, long request,
 		case FPR_BASE ... FPR_BASE + 31: {
 			union fpureg *fregs = get_fpu_regs(child);
 
-			if (!tsk_used_math(child)) {
-				/* FP not yet used  */
-				memset(&child->thread.fpu, ~0,
-				       sizeof(child->thread.fpu));
-				child->thread.fpu.fcr31 = 0;
-			}
+			init_fp_ctx(child);
 #ifdef CONFIG_32BIT
 			if (test_thread_flag(TIF_32BIT_FPREGS)) {
 				/*
-- 
2.2.2
