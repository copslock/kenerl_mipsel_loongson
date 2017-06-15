Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 01:09:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39227 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994787AbdFOXJkEkmjr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 01:09:40 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 352BD1C1099DF;
        Fri, 16 Jun 2017 00:09:29 +0100 (IST)
Received: from [10.20.78.209] (10.20.78.209) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 16 Jun 2017
 00:09:32 +0100
Date:   Fri, 16 Jun 2017 00:09:23 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 05/10] MIPS: Rename `sigill_r6' to `sigill_r2r6' in
 `__compute_return_epc_for_insn'
In-Reply-To: <alpine.DEB.2.00.1706150032240.23046@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1706150143240.23046@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1706150032240.23046@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.209]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58488
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

Use the more accurate `sigill_r2r6' name for the label used in the case 
of sending SIGILL in the absence of the instruction emulator for an 
earlier ISA level instruction that has been removed as from the R6 ISA, 
so that the `sigill_r6' name is freed for the situation where an R6 
instruction is not supposed to be interpreted, because the executing 
processor does not support the R6 ISA.

Cc: stable@vger.kernel.org # 3.19+
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
Changes from v1:

- add justification.

linux-mips-epc-for-insn-sigill-r6-to-r2r6.diff
Index: linux-sfr-test/arch/mips/kernel/branch.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/branch.c	2017-06-01 06:33:27.149519000 +0100
+++ linux-sfr-test/arch/mips/kernel/branch.c	2017-06-01 06:33:32.663567000 +0100
@@ -431,7 +431,7 @@ int __compute_return_epc_for_insn(struct
 			/* Fall through */
 		case jr_op:
 			if (NO_R6EMU && insn.r_format.func == jr_op)
-				goto sigill_r6;
+				goto sigill_r2r6;
 			regs->cp0_epc = regs->regs[insn.r_format.rs];
 			break;
 		}
@@ -446,7 +446,7 @@ int __compute_return_epc_for_insn(struct
 		switch (insn.i_format.rt) {
 		case bltzl_op:
 			if (NO_R6EMU)
-				goto sigill_r6;
+				goto sigill_r2r6;
 		case bltz_op:
 			if ((long)regs->regs[insn.i_format.rs] < 0) {
 				epc = epc + 4 + (insn.i_format.simmediate << 2);
@@ -459,7 +459,7 @@ int __compute_return_epc_for_insn(struct
 
 		case bgezl_op:
 			if (NO_R6EMU)
-				goto sigill_r6;
+				goto sigill_r2r6;
 		case bgez_op:
 			if ((long)regs->regs[insn.i_format.rs] >= 0) {
 				epc = epc + 4 + (insn.i_format.simmediate << 2);
@@ -574,7 +570,7 @@ int __compute_return_epc_for_insn(struct
 	 */
 	case beql_op:
 		if (NO_R6EMU)
-			goto sigill_r6;
+			goto sigill_r2r6;
 	case beq_op:
 		if (regs->regs[insn.i_format.rs] ==
 		    regs->regs[insn.i_format.rt]) {
@@ -588,7 +584,7 @@ int __compute_return_epc_for_insn(struct
 
 	case bnel_op:
 		if (NO_R6EMU)
-			goto sigill_r6;
+			goto sigill_r2r6;
 	case bne_op:
 		if (regs->regs[insn.i_format.rs] !=
 		    regs->regs[insn.i_format.rt]) {
@@ -602,7 +598,7 @@ int __compute_return_epc_for_insn(struct
 
 	case blezl_op: /* not really i_format */
 		if (!insn.i_format.rt && NO_R6EMU)
-			goto sigill_r6;
+			goto sigill_r2r6;
 	case blez_op:
 		/*
 		 * Compact branches for R6 for the
@@ -637,7 +633,7 @@ int __compute_return_epc_for_insn(struct
 
 	case bgtzl_op:
 		if (!insn.i_format.rt && NO_R6EMU)
-			goto sigill_r6;
+			goto sigill_r2r6;
 	case bgtz_op:
 		/*
 		 * Compact branches for R6 for the
@@ -834,7 +830,7 @@ int __compute_return_epc_for_insn(struct
 		current->comm);
 	force_sig(SIGILL, current);
 	return -EFAULT;
-sigill_r6:
+sigill_r2r6:
 	pr_info("%s: R2 branch but r2-to-r6 emulator is not preset - sending SIGILL.\n",
 		current->comm);
 	force_sig(SIGILL, current);
