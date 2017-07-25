Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2017 21:41:10 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993949AbdGYTZmKlM5b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2017 21:25:42 +0200
Received: from localhost (rrcs-64-183-28-114.west.biz.rr.com [64.183.28.114])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 02EA3504;
        Tue, 25 Jul 2017 19:25:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.12 144/196] MIPS: Send SIGILL for R6 branches in `__compute_return_epc_for_insn
Date:   Tue, 25 Jul 2017 12:22:23 -0700
Message-Id: <20170725192053.137386676@linuxfoundation.org>
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
X-archive-position: 59277
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

commit a60b1a5bf88a250f1a77977c0224e502c901c77b upstream.

Fix:

* commit 8467ca0122e2 ("MIPS: Emulate the new MIPS R6 branch compact
(BC) instruction"),

* commit 84fef630127a ("MIPS: Emulate the new MIPS R6 BALC
instruction"),

* commit 69b9a2fd05a3 ("MIPS: Emulate the new MIPS R6 BEQZC and JIC
instructions"),

* commit 28d6f93d201d ("MIPS: Emulate the new MIPS R6 BNEZC and JIALC
instructions"),

* commit c893ce38b265 ("MIPS: Emulate the new MIPS R6 BOVC, BEQC and
BEQZALC instructions")

and send SIGILL rather than returning -SIGILL for R6 branch and jump
instructions.  Returning -SIGILL is never correct as the API defines
this function's result upon error to be -EFAULT and a signal actually
issued.

Fixes: 8467ca0122e2 ("MIPS: Emulate the new MIPS R6 branch compact (BC) instruction")
Fixes: 84fef630127a ("MIPS: Emulate the new MIPS R6 BALC instruction")
Fixes: 69b9a2fd05a3 ("MIPS: Emulate the new MIPS R6 BEQZC and JIC instructions")
Fixes: 28d6f93d201d ("MIPS: Emulate the new MIPS R6 BNEZC and JIALC instructions")
Fixes: c893ce38b265 ("MIPS: Emulate the new MIPS R6 BOVC, BEQC and BEQZALC instructions")
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16399/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/branch.c |   35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -771,35 +771,27 @@ int __compute_return_epc_for_insn(struct
 #else
 	case bc6_op:
 		/* Only valid for MIPS R6 */
-		if (!cpu_has_mips_r6) {
-			ret = -SIGILL;
-			break;
-		}
+		if (!cpu_has_mips_r6)
+			goto sigill_r6;
 		regs->cp0_epc += 8;
 		break;
 	case balc6_op:
-		if (!cpu_has_mips_r6) {
-			ret = -SIGILL;
-			break;
-		}
+		if (!cpu_has_mips_r6)
+			goto sigill_r6;
 		/* Compact branch: BALC */
 		regs->regs[31] = epc + 4;
 		epc += 4 + (insn.i_format.simmediate << 2);
 		regs->cp0_epc = epc;
 		break;
 	case pop66_op:
-		if (!cpu_has_mips_r6) {
-			ret = -SIGILL;
-			break;
-		}
+		if (!cpu_has_mips_r6)
+			goto sigill_r6;
 		/* Compact branch: BEQZC || JIC */
 		regs->cp0_epc += 8;
 		break;
 	case pop76_op:
-		if (!cpu_has_mips_r6) {
-			ret = -SIGILL;
-			break;
-		}
+		if (!cpu_has_mips_r6)
+			goto sigill_r6;
 		/* Compact branch: BNEZC || JIALC */
 		if (!insn.i_format.rs) {
 			/* JIALC: set $31/ra */
@@ -811,10 +803,8 @@ int __compute_return_epc_for_insn(struct
 	case pop10_op:
 	case pop30_op:
 		/* Only valid for MIPS R6 */
-		if (!cpu_has_mips_r6) {
-			ret = -SIGILL;
-			break;
-		}
+		if (!cpu_has_mips_r6)
+			goto sigill_r6;
 		/*
 		 * Compact branches:
 		 * bovc, beqc, beqzalc, bnvc, bnec, bnezlac
@@ -837,6 +827,11 @@ sigill_r2r6:
 		current->comm);
 	force_sig(SIGILL, current);
 	return -EFAULT;
+sigill_r6:
+	pr_info("%s: R6 branch but no MIPSr6 ISA support - sending SIGILL.\n",
+		current->comm);
+	force_sig(SIGILL, current);
+	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(__compute_return_epc_for_insn);
 
