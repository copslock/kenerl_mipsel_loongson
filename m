Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:10:42 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18079 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011506AbbAPKyNGn4uM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:54:13 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 64AE59A4242A6
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:54:05 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:54:07 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:54:06 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Matthew Fortune <matthew.fortune@imgtec.com>
Subject: [PATCH RFC v2 67/70] MIPS: kernel: process: Do not allow FR=0 on MIPS R6
Date:   Fri, 16 Jan 2015 10:49:46 +0000
Message-ID: <1421405389-15512-68-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

A prctl() call to set FR=0 for MIPS R6 should not be allowed
since FR=1 is the only option for R6 cores.

Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Matthew Fortune <matthew.fortune@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/fpu.h | 3 ++-
 arch/mips/kernel/process.c  | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 994d21939676..b96d9d327626 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -68,7 +68,8 @@ static inline int __enable_fpu(enum fpu_mode mode)
 		goto fr_common;
 
 	case FPU_64BIT:
-#if !(defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_64BIT))
+#if !(defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_CPU_MIPS32_R6) \
+      || defined(CONFIG_64BIT))
 		/* we only have a 32-bit FPU */
 		return SIGFPE;
 #endif
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index b732c0ce2e56..41ebd5d0ac30 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -581,6 +581,10 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	if ((value & PR_FP_MODE_FRE) && !cpu_has_fre)
 		return -EOPNOTSUPP;
 
+	/* FR = 0 not supported in MIPS R6 */
+	if (!(value & PR_FP_MODE_FR) && cpu_has_fpu && cpu_has_mips_r6)
+		return -EOPNOTSUPP;
+
 	/* Save FP & vector context, then disable FPU & MSA */
 	if (task->signal == current->signal)
 		lose_fpu(1);
-- 
2.2.1
