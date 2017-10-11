Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2017 11:02:12 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.150.247]:46234 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990432AbdJKJCApS09I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2017 11:02:00 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 11 Oct 2017 09:01:48 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 11 Oct 2017 01:59:42 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
CC:     Matthew Fortune <matthew.fortune@mips.com>,
        <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Corey Minyard <cminyard@mvista.com>,
        <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <jason@zx2c4.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: Fix exception entry when CONFIG_EVA enabled
Date:   Wed, 11 Oct 2017 09:59:20 +0100
Message-ID: <1507712360-20657-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1507712412-298552-31552-21987-10
X-BESS-VER: 2017.12-r1710102214
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.185885
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Commit 9fef68686317b ("MIPS: Make SAVE_SOME more standard") made several
changes to the order in which registers are saved in the SAVE_SOME
macro, used by exception handlers to save the processor state. In
particular, it removed the
move   k1, sp
in the delay slot of the branch testing if the processor is already in
kernel mode. This is replaced later in the macro by a
move   k0, sp
When CONFIG_EVA is disabled, this instruction actually appears in the
delay slot of the branch. However, when CONFIG_EVA is enabled, instead
the RPS workaround of
MFC0	k0, CP0_ENTRYHI
appears in the delay slot. This results in k0 not containing the stack
pointer, but some unrelated value, which is then saved to the kernel
stack. On exit from the exception, this bogus value is restored to the
stack pointer, resulting in an OOPS.

Fix this by moving the save of SP in k0 explicitly in the delay slot of
the branch, outside of the CONFIG_EVA section, restoring the expected
instruction ordering when CONFIG_EVA is active.

Fixes: 9fef68686317b ("MIPS: Make SAVE_SOME more standard")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reported-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>

---

Note that some of our compiler people are dubious about putting frame
related instructions in conditionally executed blocks of code. In this
case, presuming that we only care about unwinding the kernel stack, then
we only care about the case in which the branch is taken, and k0 always
contains the SP to be saved. There is also a question about putting
frame related instructions in branch delay slots. Again, in this case,
we think it's OK to use them since the only path that ought to be
unwound will be the "branch taken" route where we are already on the
kernel stack.
Not having access to a CFI based kernel stack unwinder makes this change
difficult to verify, but since the same construct already existed when
CONFIG_EVA is disabled, I don't think this change is likely to break the
unwinder, and fixes exception entry when CONFIG_EVA is enabled.

Thanks,
Matt

---
 arch/mips/include/asm/stackframe.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 5d3563c55e0c..2161357cc68f 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -199,6 +199,10 @@
 		sll	k0, 3		/* extract cu0 bit */
 		.set	noreorder
 		bltz	k0, 8f
+		 move	k0, sp
+		.if \docfi
+		.cfi_register sp, k0
+		.endif
 #ifdef CONFIG_EVA
 		/*
 		 * Flush interAptiv's Return Prediction Stack (RPS) by writing
@@ -225,10 +229,6 @@
 		MTC0	k0, CP0_ENTRYHI
 #endif
 		.set	reorder
-		 move	k0, sp
-		.if \docfi
-		.cfi_register sp, k0
-		.endif
 		/* Called from user mode, new stack. */
 		get_saved_sp docfi=\docfi tosp=1
 8:
-- 
2.7.4
