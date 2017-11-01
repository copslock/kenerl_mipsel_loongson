Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 22:20:34 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34954 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993023AbdKAVU2AOZzm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Nov 2017 22:20:28 +0100
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id vA1LK77j004612;
        Wed, 1 Nov 2017 22:20:07 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 021/139] MIPS: Send SIGILL for BPOSGE32 in `__compute_return_epc_for_insn'
Date:   Wed,  1 Nov 2017 22:17:21 +0100
Message-Id: <1509571159-4405-22-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1509571159-4405-1-git-send-email-w@1wt.eu>
References: <1509571159-4405-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

commit 7b82c1058ac1f8f8b9f2b8786b1f710a57a870a8 upstream.

Fix commit e50c0a8fa60d ("Support the MIPS32 / MIPS64 DSP ASE.") and
send SIGILL rather than SIGBUS whenever an unimplemented BPOSGE32 DSP
ASE instruction has been encountered in `__compute_return_epc_for_insn'
as our Reserved Instruction exception handler would in response to an
attempt to actually execute the instruction.  Sending SIGBUS only makes
sense for the unaligned PC case, since moved to `__compute_return_epc'.
Adjust function documentation accordingly, correct formatting and use
`pr_info' rather than `printk' as the other exit path already does.

Fixes: e50c0a8fa60d ("Support the MIPS32 / MIPS64 DSP ASE.")
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org 
Patchwork: https://patchwork.linux-mips.org/patch/16396/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kernel/branch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 46c2ad0..9250996 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -200,7 +200,7 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
  *
  * @regs:	Pointer to pt_regs
  * @insn:	branch instruction to decode
- * @returns:	-EFAULT on error and forces SIGBUS, and on success
+ * @returns:	-EFAULT on error and forces SIGILL, and on success
  *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
  *		evaluating the branch.
  */
@@ -436,8 +436,9 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	return ret;
 
 sigill:
-	printk("%s: DSP branch but not DSP ASE - sending SIGBUS.\n", current->comm);
-	force_sig(SIGBUS, current);
+	pr_info("%s: DSP branch but not DSP ASE - sending SIGILL.\n",
+		current->comm);
+	force_sig(SIGILL, current);
 	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(__compute_return_epc_for_insn);
-- 
2.8.0.rc2.1.gbe9624a
