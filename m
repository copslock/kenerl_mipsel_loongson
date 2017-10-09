Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2017 14:54:42 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52294 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992675AbdJIMy20FXOY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2017 14:54:28 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQk-0004v6-HM; Mon, 09 Oct 2017 13:45:10 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQQ-00020s-0I; Mon, 09 Oct 2017 13:44:50 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "James Hogan" <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Mon, 09 Oct 2017 13:44:24 +0100
Message-ID: <lsq.1507553064.495865653@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 072/192] MIPS: Send SIGILL for BPOSGE32 in
 `__compute_return_epc_for_insn'
In-Reply-To: <lsq.1507553063.449494954@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.49-rc1 review patch.  If anyone has any objections, please let me know.

------------------

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
Patchwork: https://patchwork.linux-mips.org/patch/16396/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/branch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -396,7 +396,7 @@ int __MIPS16e_compute_return_epc(struct
  *
  * @regs:	Pointer to pt_regs
  * @insn:	branch instruction to decode
- * @returns:	-EFAULT on error and forces SIGBUS, and on success
+ * @returns:	-EFAULT on error and forces SIGILL, and on success
  *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
  *		evaluating the branch.
  */
@@ -633,8 +633,9 @@ int __compute_return_epc_for_insn(struct
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
