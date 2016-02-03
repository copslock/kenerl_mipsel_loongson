Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:37:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63169 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006537AbcBCDhDGTGAQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:37:03 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 84FFA56C782CC;
        Wed,  3 Feb 2016 03:36:56 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:36:57 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:36:56 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "stable # v4 . 3" <stable@vger.kernel.org>,
        "Leonid Yegoshin" <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Fix MSA ld unaligned failure cases
Date:   Wed, 3 Feb 2016 03:35:49 +0000
Message-ID: <1454470549-19411-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Copying the content of an MSA vector from user memory may involve TLB
faults & mapping in pages. This will fail when preemption is disabled
due to an inability to acquire mmap_sem from do_page_fault, which meant
such vector loads to unmapped pages would always fail to be emulated.
Fix this by disabling preemption later only around the updating of
vector register state.

This change does however introduce a race between performing the load
into thread context & the thread being preempted, saving its current
live context & clobbering the loaded value. This should be a rare
occureence, so optimise for the fast path by simply repeating the load if
we are preempted.

Additionally if the copy failed then the failure path was taken with
preemption left disabled, leading to the kernel typically encountering
further issues around sleeping whilst atomic. The change to where
preemption is disabled avoids this issue.

Fixes: e4aa1f153add "MIPS: MSA unaligned memory access support"
Reported-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: stable <stable@vger.kernel.org> # v4.3

---

 arch/mips/kernel/unaligned.c | 51 ++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 490cea5..5c62065 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -885,7 +885,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 {
 	union mips_instruction insn;
 	unsigned long value;
-	unsigned int res;
+	unsigned int res, preempted;
 	unsigned long origpc;
 	unsigned long orig31;
 	void __user *fault_addr = NULL;
@@ -1226,27 +1226,36 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 			if (!access_ok(VERIFY_READ, addr, sizeof(*fpr)))
 				goto sigbus;
 
-			/*
-			 * Disable preemption to avoid a race between copying
-			 * state from userland, migrating to another CPU and
-			 * updating the hardware vector register below.
-			 */
-			preempt_disable();
-
-			res = __copy_from_user_inatomic(fpr, addr,
-							sizeof(*fpr));
-			if (res)
-				goto fault;
-
-			/*
-			 * Update the hardware register if it is in use by the
-			 * task in this quantum, in order to avoid having to
-			 * save & restore the whole vector context.
-			 */
-			if (test_thread_flag(TIF_USEDMSA))
-				write_msa_wr(wd, fpr, df);
+			do {
+				/*
+				 * If we have live MSA context keep track of
+				 * whether we get preempted in order to avoid
+				 * the register context we load being clobbered
+				 * by the live context as it's saved during
+				 * preemption. If we don't have live context
+				 * then it can't be saved to clobber the value
+				 * we load.
+				 */
+				preempted = test_thread_flag(TIF_USEDMSA);
+
+				res = __copy_from_user_inatomic(fpr, addr,
+								sizeof(*fpr));
+				if (res)
+					goto fault;
 
-			preempt_enable();
+				/*
+				 * Update the hardware register if it is in use
+				 * by the task in this quantum, in order to
+				 * avoid having to save & restore the whole
+				 * vector context.
+				 */
+				preempt_disable();
+				if (test_thread_flag(TIF_USEDMSA)) {
+					write_msa_wr(wd, fpr, df);
+					preempted = 0;
+				}
+				preempt_enable();
+			} while (preempted);
 			break;
 
 		case msa_st_op:
-- 
2.7.0
