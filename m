Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 23:56:07 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:54076 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990793AbdLKW4Aig7Ft (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Dec 2017 23:56:00 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 11 Dec 2017 22:55:49 +0000
Received: from [10.20.78.70] (10.20.78.70) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Mon, 11 Dec 2017 14:55:51 -0800
Date:   Mon, 11 Dec 2017 22:55:40 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
CC:     Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Dave Martin <Dave.Martin@arm.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 5/6] MIPS: Also verify sizeof `elf_fpreg_t' with
 PTRACE_SETREGSET
In-Reply-To: <alpine.DEB.2.00.1712111833360.4584@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1712111839220.4584@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1712111833360.4584@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1513032949-637138-2169-845500-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187879
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
X-archive-position: 61427
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

Complement commit d614fd58a283 ("mips/ptrace: Preserve previous 
registers for short regset write") and like with the PTRACE_GETREGSET 
ptrace(2) request also apply a BUILD_BUG_ON check for the size of the 
`elf_fpreg_t' type in the PTRACE_SETREGSET request handler.

Cc: stable@vger.kernel.org # v4.11+
Fixes: d614fd58a283 ("mips/ptrace: Preserve previous registers for short regset write")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---

No changes from v1.

---
 arch/mips/kernel/ptrace.c |    1 +
 1 file changed, 1 insertion(+)

linux-mips-nt-prfpreg-build-bug.diff
Index: linux-sfr-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/ptrace.c	2017-11-28 23:33:33.395023000 +0000
+++ linux-sfr-test/arch/mips/kernel/ptrace.c	2017-11-28 23:52:34.944549000 +0000
@@ -438,6 +438,7 @@ static int fpr_get_msa(struct task_struc
 	u64 fpr_val;
 	int err;
 
+	BUILD_BUG_ON(sizeof(fpr_val) != sizeof(elf_fpreg_t));
 	for (i = 0; i < NUM_FPU_REGS; i++) {
 		fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
 		err = user_regset_copyout(pos, count, kbuf, ubuf,
