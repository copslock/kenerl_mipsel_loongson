Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2017 21:39:09 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994907AbdGYTZHkCvM5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2017 21:25:07 +0200
Received: from localhost (rrcs-64-183-28-114.west.biz.rr.com [64.183.28.114])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 68D54AE1;
        Tue, 25 Jul 2017 19:25:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.12 141/196] MIPS: Send SIGILL for BPOSGE32 in `__compute_return_epc_for_insn
Date:   Tue, 25 Jul 2017 12:22:20 -0700
Message-Id: <20170725192053.013751899@linuxfoundation.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170725192046.422343510@linuxfoundation.org>
References: <20170725192046.422343510@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59273
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

4.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@imgtec.com>

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
Patchwork: https://patchwork.linux-mips.org/patch/16396/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/branch.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -399,7 +399,7 @@ int __MIPS16e_compute_return_epc(struct
  *
  * @regs:	Pointer to pt_regs
  * @insn:	branch instruction to decode
- * @returns:	-EFAULT on error and forces SIGBUS, and on success
+ * @returns:	-EFAULT on error and forces SIGILL, and on success
  *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
  *		evaluating the branch.
  *
@@ -832,8 +832,9 @@ int __compute_return_epc_for_insn(struct
 	return ret;
 
 sigill_dsp:
-	printk("%s: DSP branch but not DSP ASE - sending SIGBUS.\n", current->comm);
-	force_sig(SIGBUS, current);
+	pr_info("%s: DSP branch but not DSP ASE - sending SIGILL.\n",
+		current->comm);
+	force_sig(SIGILL, current);
 	return -EFAULT;
 sigill_r6:
 	pr_info("%s: R2 branch but r2-to-r6 emulator is not preset - sending SIGILL.\n",
