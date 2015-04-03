Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:32:55 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025296AbbDCW012x429 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:26:27 +0200
Date:   Fri, 3 Apr 2015 23:26:27 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 32/48] MIPS: BREAK instruction interpretation corrections
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031629580.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Add the missing microMIPS BREAK16 instruction code interpretation and 
reshape code removing instruction fetching duplication and the separate 
call to `do_trap_or_bp' in the MIPS16 path.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-do-bp.diff
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c	2015-04-02 20:27:56.610207000 +0100
+++ linux/arch/mips/kernel/traps.c	2015-04-02 20:27:56.780209000 +0100
@@ -901,10 +901,9 @@ void do_trap_or_bp(struct pt_regs *regs,
 
 asmlinkage void do_bp(struct pt_regs *regs)
 {
+	unsigned long epc = msk_isa16_mode(exception_epc(regs));
 	unsigned int opcode, bcode;
 	enum ctx_state prev_state;
-	unsigned long epc;
-	u16 instr[2];
 	mm_segment_t seg;
 
 	seg = get_fs();
@@ -913,26 +912,28 @@ asmlinkage void do_bp(struct pt_regs *re
 
 	prev_state = exception_enter();
 	if (get_isa16_mode(regs->cp0_epc)) {
-		/* Calculate EPC. */
-		epc = exception_epc(regs);
-		if (cpu_has_mmips) {
-			if ((__get_user(instr[0], (u16 __user *)msk_isa16_mode(epc)) ||
-			    (__get_user(instr[1], (u16 __user *)msk_isa16_mode(epc + 2)))))
-				goto out_sigsegv;
-			opcode = (instr[0] << 16) | instr[1];
-		} else {
+		u16 instr[2];
+
+		if (__get_user(instr[0], (u16 __user *)epc))
+			goto out_sigsegv;
+
+		if (!cpu_has_mmips) {
 			/* MIPS16e mode */
-			if (__get_user(instr[0],
-				       (u16 __user *)msk_isa16_mode(epc)))
-				goto out_sigsegv;
 			bcode = (instr[0] >> 5) & 0x3f;
-			do_trap_or_bp(regs, bcode, "Break");
-			goto out;
+		} else if (mm_insn_16bit(instr[0])) {
+			/* 16-bit microMIPS BREAK */
+			bcode = instr[0] & 0xf;
+		} else {
+			/* 32-bit microMIPS BREAK */
+			if (__get_user(instr[1], (u16 __user *)(epc + 2)))
+				goto out_sigsegv;
+			opcode = (instr[0] << 16) | instr[1];
+			bcode = (opcode >> 6) & ((1 << 20) - 1);
 		}
 	} else {
-		if (__get_user(opcode,
-			       (unsigned int __user *) exception_epc(regs)))
+		if (__get_user(opcode, (unsigned int __user *)epc))
 			goto out_sigsegv;
+		bcode = (opcode >> 6) & ((1 << 20) - 1);
 	}
 
 	/*
@@ -941,7 +942,6 @@ asmlinkage void do_bp(struct pt_regs *re
 	 * Gas is bug-compatible, but not always, grrr...
 	 * We handle both cases with a simple heuristics.  --macro
 	 */
-	bcode = ((opcode >> 6) & ((1 << 20) - 1));
 	if (bcode >= (1 << 10))
 		bcode >>= 10;
 
