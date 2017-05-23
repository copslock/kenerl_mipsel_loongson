Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 14:39:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64563 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993905AbdEWMjISVMXF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2017 14:39:08 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id DD60B6D629265;
        Tue, 23 May 2017 13:38:53 +0100 (IST)
Received: from [10.20.78.51] (10.20.78.51) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 23 May 2017
 13:38:54 +0100
Date:   Tue, 23 May 2017 13:38:19 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 2/4] MIPS16e2: Subdecode extended LWSP/SWSP instructions
In-Reply-To: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1705180146520.2590@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.51]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57948
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

Implement extended LWSP/SWSP instruction subdecoding for the purpose of 
unaligned GP-relative memory access emulation.

With the introduction of the MIPS16e2 ASE[1] the previously must-be-zero 
3-bit field at bits 7..5 of the extended encodings of the instructions 
selected with the LWSP and SWSP major opcodes has become a `sel' field, 
acting as an opcode extension for additional operations.  In both cases 
the `sel' value of 0 has retained the original operation, that is:

	LW	rx, offset(sp)

and:

	SW	rx, offset(sp)

for LWSP and SWSP respectively.  In hardware predating the MIPS16e2 ASE 
other values may or may not have been decoded, architecturally yielding 
unpredictable results, and in our unaligned memory access emulation we 
have treated the 3-bit field as a don't-care, that is effectively making 
all the possible encodings of the field alias to the architecturally 
defined encoding of 0.

For the non-zero values of the `sel' field the MIPS16e2 ASE has in 
particular defined these GP-relative operations:

	LW	rx, offset(gp)		# sel = 1
	LH	rx, offset(gp)		# sel = 2
	LHU	rx, offset(gp)		# sel = 4

and

	SW	rx, offset(gp)		# sel = 1
	SH	rx, offset(gp)		# sel = 2

for LWSP and SWSP respectively, which will trap with an Address Error 
exception if the effective address calculated is not naturally-aligned 
for the operation requested.  These operations have been selected for 
unaligned access emulation, for consistency with the corresponding 
regular MIPS and microMIPS operations.

For other non-zero values of the `sel' field the MIPS16e2 ASE has 
defined further operations, which however either never trap with an 
Address Error exception, such as LWL or GP-relative SB, or are not 
supposed to be emulated, such as LL or SC.  These operations have been 
selected to exclude from unaligned access emulation, should an Address 
Error exception ever happen with them.

Subdecode the `sel' field in unaligned access emulation then for the 
extended encodings of the instructions selected with the LWSP and SWSP 
major opcodes, whenever support for the MIPS16e2 ASE has been detected 
in hardware, and either emulate the operation requested or send SIGBUS 
to the originating process, according to the selection described above.  
For hardware implementing the MIPS16 ASE, however lacking MIPS16e2 ASE 
support retain the original interpretation of the `sel' field.

The effects of this change are illustrated with the following user 
program:

$ cat mips16e2-test.c
#include <inttypes.h>
#include <stdio.h>

int main(void)
{
	int64_t scratch[16] = { 0 };
	int32_t *tmp0, *tmp1, *tmp2;
	int i;

	scratch[0] = 0xc8c7c6c5c4c3c2c1;
	scratch[1] = 0xd0cfcecdcccbcac9;

	asm volatile(
		"move	%0, $sp\n\t"
		"move	%1, $gp\n\t"
		"move	$sp, %4\n\t"
		"addiu	%2, %4, 8\n\t"
		"move	$gp, %2\n\t"

		"lw	%2, 2($sp)\n\t"
		"sw	%2, 16(%4)\n\t"
		"lw	%2, 2($gp)\n\t"
		"sw	%2, 24(%4)\n\t"

		"lw	%2, 1($sp)\n\t"
		"sw	%2, 32(%4)\n\t"
		"lh	%2, 1($gp)\n\t"
		"sw	%2, 40(%4)\n\t"

		"lw	%2, 3($sp)\n\t"
		"sw	%2, 48(%4)\n\t"
		"lhu	%2, 3($gp)\n\t"
		"sw	%2, 56(%4)\n\t"

		"lw	%2, 0(%4)\n\t"
		"sw	%2, 66($sp)\n\t"
		"lw	%2, 8(%4)\n\t"
		"sw	%2, 82($gp)\n\t"

		"lw	%2, 0(%4)\n\t"
		"sw	%2, 97($sp)\n\t"
		"lw	%2, 8(%4)\n\t"
		"sh	%2, 113($gp)\n\t"

		"move	$gp, %1\n\t"
		"move	$sp, %0"
		: "=&d" (tmp0), "=&d" (tmp1), "=&d" (tmp2), "=m" (scratch)
		: "d" (scratch));

	for (i = 0; i < sizeof(scratch) / sizeof(*scratch); i += 2)
		printf("%016" PRIx64 "\t%016" PRIx64 "\n",
		       scratch[i], scratch[i + 1]);

	return 0;
}
$

to be compiled with:

$ gcc -mips16 -mips32r2 -Wa,-mmips16e2 -o mips16e2-test mips16e2-test.c
$

With 74Kf hardware, which does not implement the MIPS16e2 ASE, this 
program produces the following output:

$ ./mips16e2-test
c8c7c6c5c4c3c2c1        d0cfcecdcccbcac9
00000000c6c5c4c3        00000000c6c5c4c3
00000000c5c4c3c2        00000000c5c4c3c2
00000000c7c6c5c4        00000000c7c6c5c4
0000c4c3c2c10000        0000000000000000
0000cccbcac90000        0000000000000000
000000c4c3c2c100        0000000000000000
000000cccbcac900        0000000000000000
$ 

regardless of whether the change has been applied or not.

With the change not applied and interAptive MR2 hardware[2], which does 
implement the MIPS16e2 ASE, it produces the following output:

$ ./mips16e2-test
c8c7c6c5c4c3c2c1        d0cfcecdcccbcac9
00000000c6c5c4c3        00000000cecdcccb
00000000c5c4c3c2        00000000cdcccbca
00000000c7c6c5c4        00000000cfcecdcc
0000c4c3c2c10000        0000000000000000
0000000000000000        0000cccbcac90000
000000c4c3c2c100        0000000000000000
0000000000000000        000000cccbcac900
$ 

which shows that for GP-relative operations the correct trapping address 
calculated from $gp has been obtained from the CP0 BadVAddr register and 
so has data from the source operand, however masking and extension has 
not been applied for halfword operations.

With the change applied and interAptive MR2 hardware the program 
produces the following output:

$ ./mips16e2-test
c8c7c6c5c4c3c2c1        d0cfcecdcccbcac9
00000000c6c5c4c3        00000000cecdcccb
00000000c5c4c3c2        00000000ffffcbca
00000000c7c6c5c4        000000000000cdcc
0000c4c3c2c10000        0000000000000000
0000000000000000        0000cccbcac90000
000000c4c3c2c100        0000000000000000
0000000000000000        0000000000cac900
$ 

as expected.

References:

[1] "MIPS32 Architecture for Programmers: MIPS16e2 Application-Specific
    Extension Technical Reference Manual", Imagination Technologies
    Ltd., Document Number: MD01172, Revision 01.00, April 26, 2016

[2] "MIPS32 interAptiv Multiprocessing System Software User's Manual",
    Imagination Technologies Ltd., Document Number: MD00904, Revision
    02.01, June 15, 2016, Chapter 24 "MIPS16e Application-Specific 
    Extension to the MIPS32 Instruction Set", pp. 871-883

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
 NB a recent binutils version, as from commit 25499ac7ee92 ("MIPS16e2: 
Add MIPS16e2 ASE support"), is required to build the test program.

  Maciej

linux-mips16e2-ase-emul.diff
Index: linux-sfr-test/arch/mips/kernel/unaligned.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/unaligned.c	2017-05-22 22:42:16.000000000 +0100
+++ linux-sfr-test/arch/mips/kernel/unaligned.c	2017-05-22 22:54:28.686096000 +0100
@@ -1984,6 +1984,8 @@ static void emulate_load_store_MIPS16e(s
 	u16 __user *pc16;
 	unsigned long origpc;
 	union mips16e_instruction mips16inst, oldinst;
+	unsigned int opcode;
+	int extended = 0;
 
 	origpc = regs->cp0_epc;
 	orig31 = regs->regs[31];
@@ -1996,6 +1998,7 @@ static void emulate_load_store_MIPS16e(s
 
 	/* skip EXTEND instruction */
 	if (mips16inst.ri.opcode == MIPS16e_extend_op) {
+		extended = 1;
 		pc16++;
 		__get_user(mips16inst.full, pc16);
 	} else if (delay_slot(regs)) {
@@ -2008,7 +2011,8 @@ static void emulate_load_store_MIPS16e(s
 			goto sigbus;
 	}
 
-	switch (mips16inst.ri.opcode) {
+	opcode = mips16inst.ri.opcode;
+	switch (opcode) {
 	case MIPS16e_i64_op:	/* I64 or RI64 instruction */
 		switch (mips16inst.i64.func) {	/* I64/RI64 func field check */
 		case MIPS16e_ldpc_func:
@@ -2028,9 +2032,40 @@ static void emulate_load_store_MIPS16e(s
 		goto sigbus;
 
 	case MIPS16e_swsp_op:
+		reg = reg16to32[mips16inst.ri.rx];
+		if (extended && cpu_has_mips16e2)
+			switch (mips16inst.ri.imm >> 5) {
+			case 0:		/* SWSP */
+			case 1:		/* SWGP */
+				break;
+			case 2:		/* SHGP */
+				opcode = MIPS16e_sh_op;
+				break;
+			default:
+				goto sigbus;
+			}
+		break;
+
 	case MIPS16e_lwpc_op:
+		reg = reg16to32[mips16inst.ri.rx];
+		break;
+
 	case MIPS16e_lwsp_op:
 		reg = reg16to32[mips16inst.ri.rx];
+		if (extended && cpu_has_mips16e2)
+			switch (mips16inst.ri.imm >> 5) {
+			case 0:		/* LWSP */
+			case 1:		/* LWGP */
+				break;
+			case 2:		/* LHGP */
+				opcode = MIPS16e_lh_op;
+				break;
+			case 4:		/* LHUGP */
+				opcode = MIPS16e_lhu_op;
+				break;
+			default:
+				goto sigbus;
+			}
 		break;
 
 	case MIPS16e_i8_op:
@@ -2044,7 +2079,7 @@ static void emulate_load_store_MIPS16e(s
 		break;
 	}
 
-	switch (mips16inst.ri.opcode) {
+	switch (opcode) {
 
 	case MIPS16e_lb_op:
 	case MIPS16e_lbu_op:
