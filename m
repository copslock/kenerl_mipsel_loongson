Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 04:32:59 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:43163 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006514AbcDRCc4Hbja9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 04:32:56 +0200
Received: from localhost (o141114.ppp.asahi-net.or.jp [202.208.141.114])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BFB79E60;
        Mon, 18 Apr 2016 02:32:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.5 073/124] MIPS: Fix MSA ld unaligned failure cases
Date:   Mon, 18 Apr 2016 11:29:05 +0900
Message-Id: <20160418022619.479751838@linuxfoundation.org>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <20160418022615.726954227@linuxfoundation.org>
References: <20160418022615.726954227@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit fa8ff601d72bad3078ddf5ef17a5547700d06908 upstream.

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
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: James Cowgill <James.Cowgill@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/12345/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/unaligned.c |   53 +++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -885,7 +885,7 @@ static void emulate_load_store_insn(stru
 {
 	union mips_instruction insn;
 	unsigned long value;
-	unsigned int res;
+	unsigned int res, preempted;
 	unsigned long origpc;
 	unsigned long orig31;
 	void __user *fault_addr = NULL;
@@ -1226,27 +1226,36 @@ static void emulate_load_store_insn(stru
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
-
-			preempt_enable();
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
+
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
