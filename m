Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 12:33:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18816 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991977AbcHaKduamgRD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 12:33:50 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0A1E02F5948C;
        Wed, 31 Aug 2016 11:33:32 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 31 Aug 2016 11:33:34 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH] MIPS: Avoid a BUG warning during prctl(PR_SET_FP_MODE, ...)
Date:   Wed, 31 Aug 2016 12:33:23 +0200
Message-ID: <1472639603-26533-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

cpu_has_fpu macro uses smp_processor_id() and is currently executed
with preemption enabled, that triggers the warning at runtime.

It is assumed throughout the kernel that if any CPU has an FPU, then all
CPUs would have an FPU as well, so it is safe to perform the check with
preemption enabled - change the code to use raw_ variant of the check to
avoid the warning.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/kernel/process.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 7429ad0..d2d0615 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -605,14 +605,14 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 		return -EOPNOTSUPP;
 
 	/* Avoid inadvertently triggering emulation */
-	if ((value & PR_FP_MODE_FR) && cpu_has_fpu &&
-	    !(current_cpu_data.fpu_id & MIPS_FPIR_F64))
+	if ((value & PR_FP_MODE_FR) && raw_cpu_has_fpu &&
+	    !(raw_current_cpu_data.fpu_id & MIPS_FPIR_F64))
 		return -EOPNOTSUPP;
-	if ((value & PR_FP_MODE_FRE) && cpu_has_fpu && !cpu_has_fre)
+	if ((value & PR_FP_MODE_FRE) && raw_cpu_has_fpu && !cpu_has_fre)
 		return -EOPNOTSUPP;
 
 	/* FR = 0 not supported in MIPS R6 */
-	if (!(value & PR_FP_MODE_FR) && cpu_has_fpu && cpu_has_mips_r6)
+	if (!(value & PR_FP_MODE_FR) && raw_cpu_has_fpu && cpu_has_mips_r6)
 		return -EOPNOTSUPP;
 
 	/* Proceed with the mode switch */
-- 
2.7.4
