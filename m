Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 16:23:27 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:40803 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbdK2PXSUNuro (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 16:23:18 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 29 Nov 2017 15:21:33 +0000
Received: from [10.20.78.197] (10.20.78.197) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Wed, 29 Nov 2017
 07:21:26 -0800
Date:   Wed, 29 Nov 2017 15:21:14 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
CC:     Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Dave Martin <Dave.Martin@arm.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 4/5] MIPS: Execute any partial write of the last register
 with PTRACE_SETREGSET
In-Reply-To: <alpine.DEB.2.00.1711290152040.31156@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1711291226320.31156@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1711290152040.31156@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1511968892-321458-15266-74779-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187425
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61190
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

Fix a commit d614fd58a283 ("mips/ptrace: Preserve previous registers for 
short regset write") bug and allow the last register requested with a 
ptrace(2) PTRACE_SETREGSET call to be partially written if supplied this 
way by the caller, like with other register sets.

Cc: stable@vger.kernel.org # v4.11+
Fixes: d614fd58a283 ("mips/ptrace: Preserve previous registers for short regset write")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
 arch/mips/kernel/ptrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-mips-nt-prfpreg-count.diff
Index: linux-sfr-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/ptrace.c	2017-11-21 22:12:00.000000000 +0000
+++ linux-sfr-test/arch/mips/kernel/ptrace.c	2017-11-21 22:13:13.471970000 +0000
@@ -484,7 +484,7 @@ static int fpr_set_msa(struct task_struc
 	int err;
 
 	BUILD_BUG_ON(sizeof(fpr_val) != sizeof(elf_fpreg_t));
-	for (i = 0; i < NUM_FPU_REGS && *count >= sizeof(elf_fpreg_t); i++) {
+	for (i = 0; i < NUM_FPU_REGS && *count > 0; i++) {
 		err = user_regset_copyin(pos, count, kbuf, ubuf,
 					 &fpr_val, i * sizeof(elf_fpreg_t),
 					 (i + 1) * sizeof(elf_fpreg_t));
