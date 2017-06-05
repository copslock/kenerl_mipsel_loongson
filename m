Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 01:19:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37935 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993873AbdFEXT0hI8DM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 01:19:26 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 34095B609FEE0;
        Tue,  6 Jun 2017 00:19:15 +0100 (IST)
Received: from [10.20.78.130] (10.20.78.130) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 6 Jun 2017
 00:19:19 +0100
Date:   Tue, 6 Jun 2017 00:19:08 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 7/9] MIPS: Send SIGILL for R6 branches in
 `__compute_return_epc_for_insn'
In-Reply-To: <alpine.DEB.2.00.1706040314270.10864@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1706051800200.21750@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1706040314270.10864@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.130]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Cc: stable@vger.kernel.org # 3.19+
Fixes: 8467ca0122e2 ("MIPS: Emulate the new MIPS R6 branch compact (BC) instruction")
Fixes: 84fef630127a ("MIPS: Emulate the new MIPS R6 BALC instruction")
Fixes: 69b9a2fd05a3 ("MIPS: Emulate the new MIPS R6 BEQZC and JIC instructions")
Fixes: 28d6f93d201d ("MIPS: Emulate the new MIPS R6 BNEZC and JIALC instructions")
Fixes: c893ce38b265 ("MIPS: Emulate the new MIPS R6 BOVC, BEQC and BEQZALC instructions")
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
 I have no idea why support for the original instructions has been added 
piecemeal, but I'm not going to split this change, that would be nonsense.

  Maciej

linux-mips-epc-for-insn-sigill-r6.diff
Index: linux-sfr-test/arch/mips/kernel/branch.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/branch.c	2017-06-01 06:33:32.663567000 +0100
+++ linux-sfr-test/arch/mips/kernel/branch.c	2017-06-01 06:35:33.359652000 +0100
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
 		if (insn.i_format.rs)
 			regs->regs[31] = epc + 4;
@@ -809,10 +801,8 @@ int __compute_return_epc_for_insn(struct
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
@@ -835,6 +825,11 @@ int __compute_return_epc_for_insn(struct
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
 
