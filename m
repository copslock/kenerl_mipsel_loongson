Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2017 21:23:46 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36254 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993965AbdGYTUk6NtMn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2017 21:20:40 +0200
Received: from localhost (rrcs-64-183-28-114.west.biz.rr.com [64.183.28.114])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C1CA7A86;
        Tue, 25 Jul 2017 19:20:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 65/83] MIPS: Rename `sigill_r6 to `sigill_r2r6 in `__compute_return_epc_for_insn
Date:   Tue, 25 Jul 2017 12:19:29 -0700
Message-Id: <20170725191718.719781343@linuxfoundation.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170725191708.449126292@linuxfoundation.org>
References: <20170725191708.449126292@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59244
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@imgtec.com>

commit 1f4edde422961397cf4470b347958c13c6a740bb upstream.

Use the more accurate `sigill_r2r6' name for the label used in the case
of sending SIGILL in the absence of the instruction emulator for an
earlier ISA level instruction that has been removed as from the R6 ISA,
so that the `sigill_r6' name is freed for the situation where an R6
instruction is not supposed to be interpreted, because the executing
processor does not support the R6 ISA.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16397/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/branch.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
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
@@ -574,7 +574,7 @@ int __compute_return_epc_for_insn(struct
 	 */
 	case beql_op:
 		if (NO_R6EMU)
-			goto sigill_r6;
+			goto sigill_r2r6;
 	case beq_op:
 		if (regs->regs[insn.i_format.rs] ==
 		    regs->regs[insn.i_format.rt]) {
@@ -588,7 +588,7 @@ int __compute_return_epc_for_insn(struct
 
 	case bnel_op:
 		if (NO_R6EMU)
-			goto sigill_r6;
+			goto sigill_r2r6;
 	case bne_op:
 		if (regs->regs[insn.i_format.rs] !=
 		    regs->regs[insn.i_format.rt]) {
@@ -602,7 +602,7 @@ int __compute_return_epc_for_insn(struct
 
 	case blezl_op: /* not really i_format */
 		if (!insn.i_format.rt && NO_R6EMU)
-			goto sigill_r6;
+			goto sigill_r2r6;
 	case blez_op:
 		/*
 		 * Compact branches for R6 for the
@@ -637,7 +637,7 @@ int __compute_return_epc_for_insn(struct
 
 	case bgtzl_op:
 		if (!insn.i_format.rt && NO_R6EMU)
-			goto sigill_r6;
+			goto sigill_r2r6;
 	case bgtz_op:
 		/*
 		 * Compact branches for R6 for the
@@ -848,7 +848,7 @@ sigill_dsp:
 		current->comm);
 	force_sig(SIGILL, current);
 	return -EFAULT;
-sigill_r6:
+sigill_r2r6:
 	pr_info("%s: R2 branch but r2-to-r6 emulator is not preset - sending SIGILL.\n",
 		current->comm);
 	force_sig(SIGILL, current);
