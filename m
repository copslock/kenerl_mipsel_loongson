Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 10:08:28 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40592 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009837AbcA3JIXCdX9N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 10:08:23 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id C7C2B8C0DE044;
        Sat, 30 Jan 2016 09:08:15 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Sat, 30 Jan 2016
 09:08:16 +0000
Date:   Sat, 30 Jan 2016 09:08:16 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 1/3] MIPS: traps.c: Don't emulate RDHWR in the CpU #0 exception
 handler
In-Reply-To: <alpine.DEB.2.00.1601300356250.5958@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1601300401290.5958@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1601300356250.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51545
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

In the regular MIPS instruction set RDHWR is encoded with the SPECIAL3 
(011111) major opcode.  Therefore it cannot trigger the CpU (Coprocessor 
Unusable) exception, and certainly not for coprocessor 0, as the opcode 
does not overlap with any of the older ISA reservations, i.e. LWC0 
(110000), SWC0 (111000), LDC0 (110100) or SDC0 (111100).  The closest 
match might be SDC3 (111111), possibly causing a CpU #3 exception, 
however our code does not handle it anyway.  A quick check with a MIPS I 
and a MIPS III processor:

CPU0 revision is: 00000220 (R3000)
CPU0 revision is: 00000440 (R4400SC)

indeed indicates that the RI (Reserved Instruction) exception is 
triggered.  It's only LL and SC that require emulation in the CpU #0 
exception handler as they reuse the LWC0 and SWC0 opcodes respectively.

In the microMIPS instruction set RDHWR is mandatory and triggering the 
RI exception is required on unimplemented or disabled register accesses.  
Therefore emulating the microMIPS instruction in the CpU #0 exception 
handler is not required either.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-rdhwr-do-cpu.diff
Index: linux-sfr-test/arch/mips/kernel/traps.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/traps.c	2016-01-30 03:44:50.567566000 +0000
+++ linux-sfr-test/arch/mips/kernel/traps.c	2016-01-30 03:48:33.611317000 +0000
@@ -1369,26 +1369,12 @@ asmlinkage void do_cpu(struct pt_regs *r
 		if (unlikely(compute_return_epc(regs) < 0))
 			break;
 
-		if (get_isa16_mode(regs->cp0_epc)) {
-			unsigned short mmop[2] = { 0 };
-
-			if (unlikely(get_user(mmop[0], epc) < 0))
-				status = SIGSEGV;
-			if (unlikely(get_user(mmop[1], epc) < 0))
-				status = SIGSEGV;
-			opcode = (mmop[0] << 16) | mmop[1];
-
-			if (status < 0)
-				status = simulate_rdhwr_mm(regs, opcode);
-		} else {
+		if (!get_isa16_mode(regs->cp0_epc)) {
 			if (unlikely(get_user(opcode, epc) < 0))
 				status = SIGSEGV;
 
 			if (!cpu_has_llsc && status < 0)
 				status = simulate_llsc(regs, opcode);
-
-			if (status < 0)
-				status = simulate_rdhwr_normal(regs, opcode);
 		}
 
 		if (status < 0)
