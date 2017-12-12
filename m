Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 11:05:24 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:56661 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994638AbdLLKBSv1uVC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 11:01:18 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 12 Dec 2017 10:01:07 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 12 Dec 2017 02:00:03 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [RFC PATCH 15/16] MIPS: prep stack walkers for THREAD_INFO_IN_TASK
Date:   Tue, 12 Dec 2017 09:58:01 +0000
Message-ID: <1513072682-1371-16-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
References: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513072838-637138-2170-866389-11
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187894
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

When CONFIG_THREAD_INFO_IN_TASK is selected, task stacks may be freed
before a task is destroyed. To account for this, the stacks are
refcounted, and when manipulating the stack of another task, it is
necessary to get/put the stack to ensure it isn't freed and/or re-used
while we do so.

This patch reworks the MIPS stack walking code to account for this.
When CONFIG_THREAD_INFO_IN_TASK is not selected these perform no
refcounting, and this should only be a structural change that does not
affect behaviour.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/kernel/process.c    | 3 ++-
 arch/mips/kernel/stacktrace.c | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 45d0b6b037ee..24b4e8c02508 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -627,7 +627,7 @@ unsigned long get_wchan(struct task_struct *task)
 
 	if (!task || task == current || task->state == TASK_RUNNING)
 		goto out;
-	if (!task_stack_page(task))
+	if (!try_get_task_stack(task))
 		goto out;
 
 	pc = thread_saved_pc(task);
@@ -639,6 +639,7 @@ unsigned long get_wchan(struct task_struct *task)
 		pc = unwind_stack(task, &sp, pc, &ra);
 #endif
 
+	put_task_stack(task);
 out:
 	return pc;
 }
diff --git a/arch/mips/kernel/stacktrace.c b/arch/mips/kernel/stacktrace.c
index 7c7c902249f2..babf2dd165a0 100644
--- a/arch/mips/kernel/stacktrace.c
+++ b/arch/mips/kernel/stacktrace.c
@@ -81,6 +81,9 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 
 	WARN_ON(trace->nr_entries || !trace->max_entries);
 
+	if (!try_get_task_stack(tsk))
+		return;
+
 	if (tsk != current) {
 		regs->regs[29] = tsk->thread.reg29;
 		regs->regs[31] = 0;
@@ -88,5 +91,7 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	} else
 		prepare_frametrace(regs);
 	save_context_stack(trace, tsk, regs, tsk == current);
+
+	put_task_stack(tsk);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
-- 
2.7.4
