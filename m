Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:22:27 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:34907 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041471AbcFIVTBU7yrE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:19:01 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7Lw-0005MV-FH; Thu, 09 Jun 2016 21:19:00 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7Lt-0006Ca-PL; Thu, 09 Jun 2016 14:18:57 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 104/206] MIPS: Disable preemption during prctl(PR_SET_FP_MODE, ...)
Date:   Thu,  9 Jun 2016 14:15:13 -0700
Message-Id: <1465507015-23052-105-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Paul Burton <paul.burton@imgtec.com>

commit bd239f1e1429e7781096bf3884bdb1b2b1bb4f28 upstream.

Whilst a PR_SET_FP_MODE prctl is performed there are decisions made
based upon whether the task is executing on the current CPU. This may
change if we're preempted, so disable preemption to avoid such changes
for the lifetime of the mode switch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Cc: Adam Buchbinder <adam.buchbinder@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13144/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/process.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 6b3ae73..89847be 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -603,6 +603,9 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	if (!(value & PR_FP_MODE_FR) && cpu_has_fpu && cpu_has_mips_r6)
 		return -EOPNOTSUPP;
 
+	/* Proceed with the mode switch */
+	preempt_disable();
+
 	/* Save FP & vector context, then disable FPU & MSA */
 	if (task->signal == current->signal)
 		lose_fpu(1);
@@ -661,6 +664,7 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 
 	/* Allow threads to use FP again */
 	atomic_set(&task->mm->context.fp_mode_switching, 0);
+	preempt_enable();
 
 	return 0;
 }
-- 
2.7.4
