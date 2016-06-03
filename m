Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2016 23:41:56 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:40121 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042099AbcFCVjCDaxY4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2016 23:39:02 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u53LcpA1010998
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2016 21:38:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.13.8) with ESMTP id u53Lcpxm006302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:38:51 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u53Lco7Q016763;
        Fri, 3 Jun 2016 21:38:50 GMT
Received: from lappy.us.oracle.com (/10.154.190.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jun 2016 14:38:50 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 4.1 stable tree] MIPS: Disable preemption during prctl(PR_SET_FP_MODE, ...)
Date:   Fri,  3 Jun 2016 17:36:31 -0400
Message-Id: <1464989831-16666-96-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464989831-16666-1-git-send-email-sasha.levin@oracle.com>
References: <1464989831-16666-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Paul Burton <paul.burton@imgtec.com>

This patch has been added to the 4.1 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit bd239f1e1429e7781096bf3884bdb1b2b1bb4f28 ]

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
Cc: stable <stable@vger.kernel.org> # v4.0+
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13144/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
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
2.5.0
