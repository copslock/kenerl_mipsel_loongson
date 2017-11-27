Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2017 10:39:11 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:48524 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990391AbdK0JjCyjjTz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Nov 2017 10:39:02 +0100
Received: from MIPSMAIL01.mipstec.com (unknown [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 27 Nov 2017 09:38:21 +0000
Received: from [10.20.78.176] (10.20.78.176) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Mon, 27 Nov 2017
 01:33:15 -0800
Date:   Mon, 27 Nov 2017 09:33:03 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
CC:     Paul Burton <Paul.Burton@mips.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Validate PR_SET_FP_MODE prctl(2) requests against the
 ABI of the task
Message-ID: <alpine.DEB.2.00.1711251259130.3865@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1511775305-321459-2322-310978-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Fix an API loophole introduced with commit 9791554b45a2 ("MIPS,prctl: 
add PR_[GS]ET_FP_MODE prctl options for MIPS"), where the caller of 
prctl(2) is incorrectly allowed to make a change to CP0.Status.FR or 
CP0.Config5.FRE register bits even if CONFIG_MIPS_O32_FP64_SUPPORT has 
not been enabled, despite that an executable requesting the mode 
requested via ELF file annotation would not be allowed to run in the 
first place, or for n64 and n64 ABI tasks which do not have non-default 
modes defined at all.  Add suitable checks to `mips_set_process_fp_mode' 
and bail out if an invalid mode change has been requested for the ABI in 
effect, even if the FPU hardware or emulation would otherwise allow it.

Always succeed however without taking any further action if the mode 
requested is the same as one already in effect, regardless of whether 
any mode change, should it be requested, would actually be allowed for 
the task concerned.

Cc: stable@vger.kernel.org # 4.0+
Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
 arch/mips/kernel/process.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

linux-mips-prctl-fp-mode-o32-fp64.diff
Index: linux-sfr-test/arch/mips/kernel/process.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/process.c	2017-11-25 12:40:55.868109000 +0000
+++ linux-sfr-test/arch/mips/kernel/process.c	2017-11-25 12:41:56.411578000 +0000
@@ -705,6 +705,18 @@ int mips_set_process_fp_mode(struct task
 	struct task_struct *t;
 	int max_users;
 
+	/* If nothing to change, return right away, successfully.  */
+	if (value == mips_get_process_fp_mode(task))
+		return 0;
+
+	/* Only accept a mode change if 64-bit FP enabled for o32.  */
+	if (!IS_ENABLED(CONFIG_MIPS_O32_FP64_SUPPORT))
+		return -EOPNOTSUPP;
+
+	/* And only for o32 tasks.  */
+	if (IS_ENABLED(CONFIG_64BIT) && !test_thread_flag(TIF_32BIT_REGS))
+		return -EOPNOTSUPP;
+
 	/* Check the value is valid */
 	if (value & ~known_bits)
 		return -EOPNOTSUPP;
