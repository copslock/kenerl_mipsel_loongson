Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 06:22:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20999 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009770AbcAVFV063LZz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 06:21:26 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 5AA6C161FDDB7;
        Fri, 22 Jan 2016 05:21:20 +0000 (GMT)
Received: from [10.100.200.15] (10.100.200.15) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Fri, 22 Jan 2016
 05:21:20 +0000
Date:   Fri, 22 Jan 2016 05:21:47 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Aurelien Jarno <aurelien@aurel32.net>, <linux-mips@linux-mips.org>
Subject: [PATCH 7/7] MIPS: math-emu: dsemul: Reduce `get_isa16_mode'
 clutter
In-Reply-To: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1601220255140.5958@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.15]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51298
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

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-dsemul-isa16.diff
Index: linux-sfr-sead/arch/mips/math-emu/dsemul.c
===================================================================
--- linux-sfr-sead.orig/arch/mips/math-emu/dsemul.c	2016-01-22 01:58:16.000000000 +0000
+++ linux-sfr-sead/arch/mips/math-emu/dsemul.c	2016-01-22 01:59:52.315227000 +0000
@@ -38,6 +38,7 @@ struct emuframe {
  */
 int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 {
+	int isa16 = get_isa16_mode(regs->cp0_epc);
 	mips_instruction break_math;
 	struct emuframe __user *fr;
 	int err;
@@ -47,7 +48,7 @@ int mips_dsemul(struct pt_regs *regs, mi
 		return -1;
 
 	/* microMIPS instructions */
-	if (get_isa16_mode(regs->cp0_epc)) {
+	if (isa16) {
 		union mips_instruction insn = { .word = ir };
 
 		/* NOP16 aka MOVE16 $0, $0 */
@@ -81,7 +82,7 @@ int mips_dsemul(struct pt_regs *regs, mi
 	 * multiprocessor support.  For Linux we use a BREAK 514
 	 * instruction causing a breakpoint exception.
 	 */
-	break_math = BREAK_MATH(get_isa16_mode(regs->cp0_epc));
+	break_math = BREAK_MATH(isa16);
 
 	/* Ensure that the two instructions are in the same cache line */
 	fr = (struct emuframe __user *)
@@ -91,7 +92,7 @@ int mips_dsemul(struct pt_regs *regs, mi
 	if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
 		return SIGBUS;
 
-	if (get_isa16_mode(regs->cp0_epc)) {
+	if (isa16) {
 		err = __put_user(ir >> 16,
 				 (u16 __user *)(&fr->emul));
 		err |= __put_user(ir & 0xffff,
@@ -113,8 +114,7 @@ int mips_dsemul(struct pt_regs *regs, mi
 		return SIGBUS;
 	}
 
-	regs->cp0_epc = ((unsigned long) &fr->emul) |
-		get_isa16_mode(regs->cp0_epc);
+	regs->cp0_epc = (unsigned long)&fr->emul | isa16;
 
 	flush_cache_sigtramp((unsigned long)&fr->emul);
 
@@ -123,6 +123,7 @@ int mips_dsemul(struct pt_regs *regs, mi
 
 int do_dsemulret(struct pt_regs *xcp)
 {
+	int isa16 = get_isa16_mode(xcp->cp0_epc);
 	struct emuframe __user *fr;
 	unsigned long epc;
 	u32 insn, cookie;
@@ -145,7 +146,7 @@ int do_dsemulret(struct pt_regs *xcp)
 	 *  - Is the instruction pointed to by the EPC an BREAK_MATH?
 	 *  - Is the following memory word the BD_COOKIE?
 	 */
-	if (get_isa16_mode(xcp->cp0_epc)) {
+	if (isa16) {
 		err = __get_user(instr[0],
 				 (u16 __user *)(&fr->badinst));
 		err |= __get_user(instr[1],
@@ -156,8 +157,8 @@ int do_dsemulret(struct pt_regs *xcp)
 	}
 	err |= __get_user(cookie, &fr->cookie);
 
-	if (unlikely(err || insn != BREAK_MATH(get_isa16_mode(xcp->cp0_epc)) ||
-		     cookie != BD_COOKIE)) {
+	if (unlikely(err ||
+		     insn != BREAK_MATH(isa16) || cookie != BD_COOKIE)) {
 		MIPS_FPU_EMU_INC_STATS(errors);
 		return 0;
 	}
