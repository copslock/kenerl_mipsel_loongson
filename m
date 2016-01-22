Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 06:21:09 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4731 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010087AbcAVFUkkc9Ez (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 06:20:40 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 3B7C2589A7D2A;
        Fri, 22 Jan 2016 05:20:33 +0000 (GMT)
Received: from [10.100.200.15] (10.100.200.15) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Fri, 22 Jan 2016
 05:20:33 +0000
Date:   Fri, 22 Jan 2016 05:21:00 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Aurelien Jarno <aurelien@aurel32.net>, <linux-mips@linux-mips.org>
Subject: [PATCH 4/7] MIPS: math-emu: Correct the emulation of microMIPS
 ADDIUPC instruction
In-Reply-To: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1601220254230.5958@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.15]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51295
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

Emulate the microMIPS ADDIUPC instruction directly in `mips_dsemul'.  If 
executed in the emulation frame, this instruction produces an incorrect
result, because the value of the PC there is not the same as where the
instruction originated.

Reshape code so as to handle all microMIPS cases together.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
Ralf,

 Please apply and backport to stable branches.  This is the program I used 
to validate this change:

#include <stdio.h>

struct pc {
	void *pc0;
	void *pc1;
};

static struct pc addiupc(double x, double y, int i, int unaligned)
{
	struct pc pc;

	asm(	
	"	.set	push		\n"
	"	.set	noreorder	\n"
	"	c.eq.d	%2, %3		\n"
	"	.align	2		\n"
	"	.rept	%5		\n"
	"	nop16			\n"
	"	.endr			\n"
	"	bc1t	1f		\n"
	"0:	 .fill	0		\n"
	"	 addiu	%0, $pc, %4	\n"
	"1:	la	%1, 0b		\n"
	"	addu	%1, %1, %z4	\n"
	"	.set	pop		"
		: "=&u" (pc.pc0), "=&r" (pc.pc1)
		: "f" (x), "f" (y), "i" (i), "i" (unaligned));

	return pc;
}

int main(int argc, char **argv)
{
	struct pc pc;

	pc = addiupc(1.0, 2.0, 0, 0);
	printf("al ne 0: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(0.0, 0.0, 0, 0);
	printf("al eq 0: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(1.0, 2.0, 0, 1);
	printf("un ne 0: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(0.0, 0.0, 0, 1);
	printf("un eq 0: %p, %p\n", pc.pc0, pc.pc1);

	pc = addiupc(1.0, 2.0, 16, 0);
	printf("al ne 16: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(0.0, 0.0, 16, 0);
	printf("al eq 16: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(1.0, 2.0, 16, 1);
	printf("un ne 16: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(0.0, 0.0, 16, 1);
	printf("un eq 16: %p, %p\n", pc.pc0, pc.pc1);

	pc = addiupc(1.0, 2.0, -16, 0);
	printf("al ne -16: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(0.0, 0.0, -16, 0);
	printf("al eq -16: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(1.0, 2.0, -16, 1);
	printf("un ne -16: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(0.0, 0.0, -16, 1);
	printf("un eq -16: %p, %p\n", pc.pc0, pc.pc1);

	pc = addiupc(1.0, 2.0, 16777212, 0);
	printf("al ne 16777212: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(0.0, 0.0, 16777212, 0);
	printf("al eq 16777212: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(1.0, 2.0, 16777212, 1);
	printf("un ne 16777212: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(0.0, 0.0, 16777212, 1);
	printf("un eq 16777212: %p, %p\n", pc.pc0, pc.pc1);

	pc = addiupc(1.0, 2.0, -16777216, 0);
	printf("al ne -16777216: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(0.0, 0.0, -16777216, 0);
	printf("al eq -16777216: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(1.0, 2.0, -16777216, 1);
	printf("un ne -16777216: %p, %p\n", pc.pc0, pc.pc1);
	pc = addiupc(0.0, 0.0, -16777216, 1);
	printf("un eq -16777216: %p, %p\n", pc.pc0, pc.pc1);

	return 0;
}

With the current state of our tree, where FPU emulation is involved this 
program, when compiled to microMIPS code, produces the following output 
(on a DSP-enabled processor):

al ne 0: 0x40052c, 0x40052c
Illegal instruction

(because of the issue fixed with 3/7) with 3/7 applied it prints:

al ne 0: 0x40052c, 0x40052c
al eq 0: 0x7fe144f8, 0x400550
un ne 0: 0x400574, 0x400576
un eq 0: 0x7fe144f8, 0x40059a
al ne 16: 0x4005cc, 0x4005cc
al eq 16: 0x7fe14508, 0x4005f0
un ne 16: 0x400614, 0x400616
un eq 16: 0x7fe14508, 0x40063e
al ne -16: 0x400644, 0x400644
al eq -16: 0x7fe144e8, 0x400668
un ne -16: 0x40068c, 0x40068e
un eq -16: 0x7fe144e8, 0x4006b6
al ne 16777212: 0x14006e8, 0x14006e8
al eq 16777212: 0x80e144f4, 0x1400714
un ne 16777212: 0x1400740, 0x1400742
un eq 16777212: 0x80e144f4, 0x1400772
al ne -16777216: 0xff4007a4, 0xff4007a4
al eq -16777216: 0x7ee144f8, 0xff4007cc
un ne -16777216: 0xff4007f4, 0xff4007f6
un eq -16777216: 0x7ee144f8, 0xff400822

(notice the addresses offsetted from the emulation frame in the "eq" case, 
printed on the left) whereas with the change applied it prints:

al ne 0: 0x40052c, 0x40052c
al eq 0: 0x400550, 0x400550
un ne 0: 0x400574, 0x400576
un eq 0: 0x400598, 0x40059a
al ne 16: 0x4005cc, 0x4005cc
al eq 16: 0x4005f0, 0x4005f0
un ne 16: 0x400614, 0x400616
un eq 16: 0x40063c, 0x40063e
al ne -16: 0x400644, 0x400644
al eq -16: 0x400668, 0x400668
un ne -16: 0x40068c, 0x40068e
un eq -16: 0x4006b4, 0x4006b6
al ne 16777212: 0x14006e8, 0x14006e8
al eq 16777212: 0x1400714, 0x1400714
un ne 16777212: 0x1400740, 0x1400742
un eq 16777212: 0x1400770, 0x1400772
al ne -16777216: 0xff4007a4, 0xff4007a4
al eq -16777216: 0xff4007cc, 0xff4007cc
un ne -16777216: 0xff4007f4, 0xff4007f6
un eq -16777216: 0xff400820, 0xff400822

instead, as expected (notice the 4-byte alignment of the results, absent 
from the reference values calculated with the LA/ADDU sequence, printed on 
the right).

 Further changes will be required to correctly handle PC-relative MIPSr6 
instructions.  I do not intend to make such changes anytime soon, people 
are encouraged to make them themselves if interested in MIPSr6 execution 
environments.

 If adding further cases to `mips_dsemul' I suggest factoring out code to 
handle direct emulation (-1 return code).

  Maciej

linux-umips-dsemul-addiupc.diff
Index: linux-sfr-sead/arch/mips/include/uapi/asm/inst.h
===================================================================
--- linux-sfr-sead.orig/arch/mips/include/uapi/asm/inst.h	2016-01-22 01:07:02.925179000 +0000
+++ linux-sfr-sead/arch/mips/include/uapi/asm/inst.h	2016-01-22 01:10:10.472810000 +0000
@@ -799,6 +799,13 @@ struct mm_x_format {		/* Scaled indexed 
 	;)))))
 };
 
+struct mm_a_format {		/* ADDIUPC format (microMIPS) */
+	__BITFIELD_FIELD(unsigned int opcode : 6,
+	__BITFIELD_FIELD(unsigned int rs : 3,
+	__BITFIELD_FIELD(signed int simmediate : 23,
+	;)))
+};
+
 /*
  * microMIPS instruction formats (16-bit length)
  */
@@ -940,6 +947,7 @@ union mips_instruction {
 	struct mm_i_format mm_i_format;
 	struct mm_m_format mm_m_format;
 	struct mm_x_format mm_x_format;
+	struct mm_a_format mm_a_format;
 	struct mm_b0_format mm_b0_format;
 	struct mm_b1_format mm_b1_format;
 	struct mm16_m_format mm16_m_format ;
Index: linux-sfr-sead/arch/mips/math-emu/dsemul.c
===================================================================
--- linux-sfr-sead.orig/arch/mips/math-emu/dsemul.c	2016-01-22 01:09:07.914682000 +0000
+++ linux-sfr-sead/arch/mips/math-emu/dsemul.c	2016-01-22 01:10:10.476810000 +0000
@@ -43,10 +43,30 @@ int mips_dsemul(struct pt_regs *regs, mi
 	int err;
 
 	/* NOP is easy */
-	if ((get_isa16_mode(regs->cp0_epc) && ((ir >> 16) == MM_NOP16)) ||
-	    (ir == 0))
+	if (ir == 0)
 		return -1;
 
+	/* microMIPS instructions */
+	if (get_isa16_mode(regs->cp0_epc)) {
+		union mips_instruction insn = { .word = ir };
+
+		/* NOP16 aka MOVE16 $0, $0 */
+		if ((ir >> 16) == MM_NOP16)
+			return -1;
+
+		/* ADDIUPC */
+		if (insn.mm_a_format.opcode == mm_addiupc_op) {
+			unsigned int rs;
+			s32 v;
+
+			rs = (((insn.mm_a_format.rs + 0x1e) & 0xf) + 2);
+			v = regs->cp0_epc & ~3;
+			v += insn.mm_a_format.simmediate << 2;
+			regs->regs[rs] = (long)v;
+			return -1;
+		}
+	}
+
 	pr_debug("dsemul %lx %lx\n", regs->cp0_epc, cpc);
 
 	/*
