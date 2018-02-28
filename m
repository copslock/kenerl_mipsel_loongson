Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 17:00:49 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53197 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992828AbeB1QAeYZNiz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 17:00:34 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yt-0006Xg-GE; Wed, 28 Feb 2018 15:22:31 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-0008Vz-2F; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.175832776@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 094/254] MIPS: prevent FP context set via ptrace
 being discarded
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit ac9ad83bc318635ed7496e9dff30beaa522eaec7 upstream.

If a ptracee has not used the FPU and the ptracer sets its FP context
using PTRACE_POKEUSR, PTRACE_SETFPREGS or PTRACE_SETREGSET then that
context will be discarded upon either the ptracee using the FPU or a
further write to the context via ptrace. Prevent this loss by recording
that the task has "used" math once its FP context has been written to.
The context initialisation code that was present for the PTRACE_POKEUSR
case is reused for the other 2 cases to provide consistent behaviour
for the different ptrace requests.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9166/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -47,6 +47,26 @@
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
@@ -143,6 +163,7 @@ int ptrace_setfpregs(struct task_struct
 	if (!access_ok(VERIFY_READ, data, 33 * 8))
 		return -EIO;
 
+	init_fp_ctx(child);
 	fregs = get_fpu_regs(child);
 
 	for (i = 0; i < 32; i++) {
@@ -440,6 +461,8 @@ static int fpr_set(struct task_struct *t
 
 	/* XXX fcr31  */
 
+	init_fp_ctx(target);
+
 	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
 		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 					  &target->thread.fpu,
@@ -678,12 +701,7 @@ long arch_ptrace(struct task_struct *chi
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
