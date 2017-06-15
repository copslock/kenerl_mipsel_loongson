Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 01:13:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32790 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994787AbdFOXNKFOwBr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 01:13:10 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 70BBEAEC9715E;
        Fri, 16 Jun 2017 00:12:59 +0100 (IST)
Received: from [10.20.78.209] (10.20.78.209) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 16 Jun 2017
 00:13:03 +0100
Date:   Fri, 16 Jun 2017 00:12:53 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 06/10] MIPS: Send SIGILL for linked branches in
 `__compute_return_epc_for_insn'
In-Reply-To: <alpine.DEB.2.00.1706150032240.23046@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1706150144070.23046@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1706150032240.23046@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.209]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58489
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

Fix commit 319824eabc3f ("MIPS: kernel: branch: Do not emulate the 
branch likelies on MIPS R6") and also send SIGILL rather than returning 
-SIGILL for BLTZAL, BLTZALL, BGEZAL and BGEZALL instruction encodings no 
longer supported in R6, except where emulated.  Returning -SIGILL is 
never correct as the API defines this function's result upon error to be 
-EFAULT and a signal actually issued.

Cc: stable@vger.kernel.org # 3.19+
Fixes: 319824eabc3f ("MIPS: kernel: branch: Do not emulate the branch likelies on MIPS R6")
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
Unchanged from v1.

linux-mips-epc-for-insn-sigill-r2r6.diff
Index: linux-sfr-test/arch/mips/kernel/branch.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/branch.c	2017-06-01 06:33:27.149519000 +0100
+++ linux-sfr-test/arch/mips/kernel/branch.c	2017-06-01 06:33:32.663567000 +0100
@@ -473,10 +473,8 @@ int __compute_return_epc_for_insn(struct
 		case bltzal_op:
 		case bltzall_op:
 			if (NO_R6EMU && (insn.i_format.rs ||
-			    insn.i_format.rt == bltzall_op)) {
-				ret = -SIGILL;
-				break;
-			}
+			    insn.i_format.rt == bltzall_op))
+				goto sigill_r2r6;
 			regs->regs[31] = epc + 8;
 			/*
 			 * OK we are here either because we hit a NAL
@@ -507,10 +505,8 @@ int __compute_return_epc_for_insn(struct
 		case bgezal_op:
 		case bgezall_op:
 			if (NO_R6EMU && (insn.i_format.rs ||
-			    insn.i_format.rt == bgezall_op)) {
-				ret = -SIGILL;
-				break;
-			}
+			    insn.i_format.rt == bgezall_op))
+				goto sigill_r2r6;
 			regs->regs[31] = epc + 8;
 			/*
 			 * OK we are here either because we hit a BAL
