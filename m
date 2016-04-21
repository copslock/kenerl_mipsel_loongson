Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 13:44:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22990 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026986AbcDULoeJh89h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 13:44:34 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id D01B3C9A936BE;
        Thu, 21 Apr 2016 12:44:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 12:44:28 +0100
Received: from localhost (10.100.200.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Apr
 2016 12:44:27 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "stable # v4 . 0+" <stable@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 1/2] MIPS: Disable preemption during prctl(PR_SET_FP_MODE, ...)
Date:   Thu, 21 Apr 2016 12:43:57 +0100
Message-ID: <1461239038-19991-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53146
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

Whilst a PR_SET_FP_MODE prctl is performed there are decisions made
based upon whether the task is executing on the current CPU. This may
change if we're preempted, so disable preemption to avoid such changes
for the lifetime of the mode switch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
Cc: stable <stable@vger.kernel.org> # v4.0+
---

 arch/mips/kernel/process.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 92880ce..ce55ea0 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -601,6 +601,9 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	if (!(value & PR_FP_MODE_FR) && cpu_has_fpu && cpu_has_mips_r6)
 		return -EOPNOTSUPP;
 
+	/* Proceed with the mode switch */
+	preempt_disable();
+
 	/* Save FP & vector context, then disable FPU & MSA */
 	if (task->signal == current->signal)
 		lose_fpu(1);
@@ -659,6 +662,7 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 
 	/* Allow threads to use FP again */
 	atomic_set(&task->mm->context.fp_mode_switching, 0);
+	preempt_enable();
 
 	return 0;
 }
-- 
2.8.0
