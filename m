Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 23:57:24 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:58472 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990793AbdLKW5OCoa1t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Dec 2017 23:57:14 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 11 Dec 2017 22:57:06 +0000
Received: from [10.20.78.70] (10.20.78.70) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Mon, 11 Dec 2017 14:57:04 -0800
Date:   Mon, 11 Dec 2017 22:56:54 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
CC:     Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Dave Martin <Dave.Martin@arm.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 6/6] MIPS: Disallow outsized PTRACE_SETREGSET NT_PRFPREG
 regset accesses
In-Reply-To: <alpine.DEB.2.00.1712111833360.4584@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1712111840170.4584@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1712111833360.4584@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1513033025-298552-12287-338299-1
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
X-archive-position: 61428
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

Complement commit c23b3d1a5311 ("MIPS: ptrace: Change GP regset to use 
correct core dump register layout") and also reject outsized 
PTRACE_SETREGSET requests to the NT_PRFPREG regset, like with the 
NT_PRSTATUS regset.

Cc: stable@vger.kernel.org # v3.17+
Fixes: c23b3d1a5311 ("MIPS: ptrace: Change GP regset to use correct core dump register layout")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---

Changes from v1:

- regenerated.

---
 arch/mips/kernel/ptrace.c |    3 +++
 1 file changed, 3 insertions(+)

linux-mips-nt-prfpreg-size.diff
Index: linux-sfr-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/ptrace.c	2017-12-08 16:22:08.062741000 +0000
+++ linux-sfr-test/arch/mips/kernel/ptrace.c	2017-12-08 16:22:17.727811000 +0000
@@ -541,6 +541,9 @@ static int fpr_set(struct task_struct *t
 
 	BUG_ON(count % sizeof(elf_fpreg_t));
 
+	if (pos + count > sizeof(elf_fpregset_t))
+		return -EIO;
+
 	init_fp_ctx(target);
 
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
