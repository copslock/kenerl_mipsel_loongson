Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2016 23:42:12 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:40136 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042101AbcFCVjCv--y4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2016 23:39:02 +0200
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u53Lcq2S011007
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:38:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u53LcqOT011836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:38:52 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u53Lcn99023045;
        Fri, 3 Jun 2016 21:38:49 GMT
Received: from lappy.us.oracle.com (/10.154.190.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jun 2016 14:38:48 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 4.1 stable tree] MIPS: ptrace: Prevent writes to read-only FCSR bits
Date:   Fri,  3 Jun 2016 17:36:30 -0400
Message-Id: <1464989831-16666-95-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464989831-16666-1-git-send-email-sasha.levin@oracle.com>
References: <1464989831-16666-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53794
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

From: "Maciej W. Rozycki" <macro@imgtec.com>

This patch has been added to the 4.1 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit abf378be49f38c4d3e23581d3df3fa9f1b1b11d2 ]

Correct the cases missed with commit 9b26616c8d9d ("MIPS: Respect the
ISA level in FCSR handling") and prevent writes to read-only FCSR bits
there.

This in particular applies to FP context initialisation where any IEEE
754-2008 bits preset by `mips_set_personality_nan' are cleared before
the relevant ptrace(2) call takes effect and the PTRACE_POKEUSR request
addressing FPC_CSR where no masking of read-only FCSR bits is done.

Remove the FCSR clearing from FP context initialisation then and unify
PTRACE_POKEUSR/FPC_CSR and PTRACE_SETFPREGS handling, by factoring out
code from `ptrace_setfpregs' and calling it from both places.

This mostly matters to soft float configurations where the emulator can
be switched this way to a mode which should not be accessible and cannot
be set with the CTC1 instruction.  With hard float configurations any
effect is transient anyway as read-only bits will retain their values at
the time the FP context is restored.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: stable@vger.kernel.org # v4.0+
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13239/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/kernel/ptrace.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index d56642a..f7968b5 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -56,8 +56,7 @@ static void init_fp_ctx(struct task_struct *target)
 	/* Begin with data registers set to all 1s... */
 	memset(&target->thread.fpu.fpr, ~0, sizeof(target->thread.fpu.fpr));
 
-	/* ...and FCSR zeroed */
-	target->thread.fpu.fcr31 = 0;
+	/* FCSR has been preset by `mips_set_personality_nan'.  */
 
 	/*
 	 * Record that the target has "used" math, such that the context
@@ -79,6 +78,22 @@ void ptrace_disable(struct task_struct *child)
 }
 
 /*
+ * Poke at FCSR according to its mask.  Don't set the cause bits as
+ * this is currently not handled correctly in FP context restoration
+ * and will cause an oops if a corresponding enable bit is set.
+ */
+static void ptrace_setfcr31(struct task_struct *child, u32 value)
+{
+	u32 fcr31;
+	u32 mask;
+
+	value &= ~FPU_CSR_ALL_X;
+	fcr31 = child->thread.fpu.fcr31;
+	mask = boot_cpu_data.fpu_msk31;
+	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
+}
+
+/*
  * Read a general register set.	 We always use the 64-bit format, even
  * for 32-bit kernels and for 32-bit processes on a 64-bit kernel.
  * Registers are sign extended to fill the available space.
@@ -158,9 +173,7 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
 {
 	union fpureg *fregs;
 	u64 fpr_val;
-	u32 fcr31;
 	u32 value;
-	u32 mask;
 	int i;
 
 	if (!access_ok(VERIFY_READ, data, 33 * 8))
@@ -175,10 +188,7 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
 	}
 
 	__get_user(value, data + 64);
-	value &= ~FPU_CSR_ALL_X;
-	fcr31 = child->thread.fpu.fcr31;
-	mask = boot_cpu_data.fpu_msk31;
-	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
+	ptrace_setfcr31(child, value);
 
 	/* FIR may not be written.  */
 
@@ -721,7 +731,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			break;
 #endif
 		case FPC_CSR:
-			child->thread.fpu.fcr31 = data & ~FPU_CSR_ALL_X;
+			ptrace_setfcr31(child, data);
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
-- 
2.5.0
