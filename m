Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 17:27:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43492 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992886AbcJaQ1R5-Ht1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 17:27:17 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 393C39A89D857;
        Mon, 31 Oct 2016 16:27:07 +0000 (GMT)
Received: from [10.20.78.238] (10.20.78.238) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 31 Oct 2016
 16:27:09 +0000
Date:   Mon, 31 Oct 2016 16:27:01 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] MIPS: Fix ISA I/II FP signal context offsets
In-Reply-To: <alpine.DEB.2.00.1610310319010.31859@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1610310407150.31859@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1610310319010.31859@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.238]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55612
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

Fix a regression introduced with commit 2db9ca0a3551 ("MIPS: Use struct 
mips_abi offsets to save FP context") for MIPS I/I FP signal contexts, 
by converting save/restore code to the updated internal API.  Start FGR
offsets from 0 rather than SC_FPREGS from $a0 and use $a1 rather than
the offset of SC_FPC_CSR from $a0 for the Floating Point Control/Status
Register (FCSR).

Document the new internal API and adjust assembly code formatting for 
consistency.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-isa12-sig-fp-context-offsets.patch
Index: linux-sfr-test/arch/mips/kernel/r2300_fpu.S
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/r2300_fpu.S	2016-10-22 02:28:09.266462000 +0100
+++ linux-sfr-test/arch/mips/kernel/r2300_fpu.S	2016-10-22 02:29:01.523906000 +0100
@@ -26,97 +26,104 @@
 
 	.set	noreorder
 	.set	mips1
-	/* Save floating point context */
+
+/**
+ * _save_fp_context() - save FP context from the FPU
+ * @a0 - pointer to fpregs field of sigcontext
+ * @a1 - pointer to fpc_csr field of sigcontext
+ *
+ * Save FP context, including the 32 FP data registers and the FP
+ * control & status register, from the FPU to signal context.
+ */
 LEAF(_save_fp_context)
 	.set	push
 	SET_HARDFLOAT
 	li	v0, 0					# assume success
-	cfc1	t1,fcr31
-	EX(swc1 $f0,(SC_FPREGS+0)(a0))
-	EX(swc1 $f1,(SC_FPREGS+8)(a0))
-	EX(swc1 $f2,(SC_FPREGS+16)(a0))
-	EX(swc1 $f3,(SC_FPREGS+24)(a0))
-	EX(swc1 $f4,(SC_FPREGS+32)(a0))
-	EX(swc1 $f5,(SC_FPREGS+40)(a0))
-	EX(swc1 $f6,(SC_FPREGS+48)(a0))
-	EX(swc1 $f7,(SC_FPREGS+56)(a0))
-	EX(swc1 $f8,(SC_FPREGS+64)(a0))
-	EX(swc1 $f9,(SC_FPREGS+72)(a0))
-	EX(swc1 $f10,(SC_FPREGS+80)(a0))
-	EX(swc1 $f11,(SC_FPREGS+88)(a0))
-	EX(swc1 $f12,(SC_FPREGS+96)(a0))
-	EX(swc1 $f13,(SC_FPREGS+104)(a0))
-	EX(swc1 $f14,(SC_FPREGS+112)(a0))
-	EX(swc1 $f15,(SC_FPREGS+120)(a0))
-	EX(swc1 $f16,(SC_FPREGS+128)(a0))
-	EX(swc1 $f17,(SC_FPREGS+136)(a0))
-	EX(swc1 $f18,(SC_FPREGS+144)(a0))
-	EX(swc1 $f19,(SC_FPREGS+152)(a0))
-	EX(swc1 $f20,(SC_FPREGS+160)(a0))
-	EX(swc1 $f21,(SC_FPREGS+168)(a0))
-	EX(swc1 $f22,(SC_FPREGS+176)(a0))
-	EX(swc1 $f23,(SC_FPREGS+184)(a0))
-	EX(swc1 $f24,(SC_FPREGS+192)(a0))
-	EX(swc1 $f25,(SC_FPREGS+200)(a0))
-	EX(swc1 $f26,(SC_FPREGS+208)(a0))
-	EX(swc1 $f27,(SC_FPREGS+216)(a0))
-	EX(swc1 $f28,(SC_FPREGS+224)(a0))
-	EX(swc1 $f29,(SC_FPREGS+232)(a0))
-	EX(swc1 $f30,(SC_FPREGS+240)(a0))
-	EX(swc1 $f31,(SC_FPREGS+248)(a0))
+	cfc1	t1, fcr31
+	EX(swc1 $f0, 0(a0))
+	EX(swc1 $f1, 8(a0))
+	EX(swc1 $f2, 16(a0))
+	EX(swc1 $f3, 24(a0))
+	EX(swc1 $f4, 32(a0))
+	EX(swc1 $f5, 40(a0))
+	EX(swc1 $f6, 48(a0))
+	EX(swc1 $f7, 56(a0))
+	EX(swc1 $f8, 64(a0))
+	EX(swc1 $f9, 72(a0))
+	EX(swc1 $f10, 80(a0))
+	EX(swc1 $f11, 88(a0))
+	EX(swc1 $f12, 96(a0))
+	EX(swc1 $f13, 104(a0))
+	EX(swc1 $f14, 112(a0))
+	EX(swc1 $f15, 120(a0))
+	EX(swc1 $f16, 128(a0))
+	EX(swc1 $f17, 136(a0))
+	EX(swc1 $f18, 144(a0))
+	EX(swc1 $f19, 152(a0))
+	EX(swc1 $f20, 160(a0))
+	EX(swc1 $f21, 168(a0))
+	EX(swc1 $f22, 176(a0))
+	EX(swc1 $f23, 184(a0))
+	EX(swc1 $f24, 192(a0))
+	EX(swc1 $f25, 200(a0))
+	EX(swc1 $f26, 208(a0))
+	EX(swc1 $f27, 216(a0))
+	EX(swc1 $f28, 224(a0))
+	EX(swc1 $f29, 232(a0))
+	EX(swc1 $f30, 240(a0))
+	EX(swc1 $f31, 248(a0))
 	jr	ra
-	 EX(sw	t1,(SC_FPC_CSR)(a0))
+	 EX(sw	t1, (a1))
 	.set	pop
 	END(_save_fp_context)
 
-/*
- * Restore FPU state:
- *  - fp gp registers
- *  - cp1 status/control register
+/**
+ * _restore_fp_context() - restore FP context to the FPU
+ * @a0 - pointer to fpregs field of sigcontext
+ * @a1 - pointer to fpc_csr field of sigcontext
  *
- * We base the decision which registers to restore from the signal stack
- * frame on the current content of c0_status, not on the content of the
- * stack frame which might have been changed by the user.
+ * Restore FP context, including the 32 FP data registers and the FP
+ * control & status register, from signal context to the FPU.
  */
 LEAF(_restore_fp_context)
 	.set	push
 	SET_HARDFLOAT
 	li	v0, 0					# assume success
-	EX(lw t0,(SC_FPC_CSR)(a0))
-	EX(lwc1 $f0,(SC_FPREGS+0)(a0))
-	EX(lwc1 $f1,(SC_FPREGS+8)(a0))
-	EX(lwc1 $f2,(SC_FPREGS+16)(a0))
-	EX(lwc1 $f3,(SC_FPREGS+24)(a0))
-	EX(lwc1 $f4,(SC_FPREGS+32)(a0))
-	EX(lwc1 $f5,(SC_FPREGS+40)(a0))
-	EX(lwc1 $f6,(SC_FPREGS+48)(a0))
-	EX(lwc1 $f7,(SC_FPREGS+56)(a0))
-	EX(lwc1 $f8,(SC_FPREGS+64)(a0))
-	EX(lwc1 $f9,(SC_FPREGS+72)(a0))
-	EX(lwc1 $f10,(SC_FPREGS+80)(a0))
-	EX(lwc1 $f11,(SC_FPREGS+88)(a0))
-	EX(lwc1 $f12,(SC_FPREGS+96)(a0))
-	EX(lwc1 $f13,(SC_FPREGS+104)(a0))
-	EX(lwc1 $f14,(SC_FPREGS+112)(a0))
-	EX(lwc1 $f15,(SC_FPREGS+120)(a0))
-	EX(lwc1 $f16,(SC_FPREGS+128)(a0))
-	EX(lwc1 $f17,(SC_FPREGS+136)(a0))
-	EX(lwc1 $f18,(SC_FPREGS+144)(a0))
-	EX(lwc1 $f19,(SC_FPREGS+152)(a0))
-	EX(lwc1 $f20,(SC_FPREGS+160)(a0))
-	EX(lwc1 $f21,(SC_FPREGS+168)(a0))
-	EX(lwc1 $f22,(SC_FPREGS+176)(a0))
-	EX(lwc1 $f23,(SC_FPREGS+184)(a0))
-	EX(lwc1 $f24,(SC_FPREGS+192)(a0))
-	EX(lwc1 $f25,(SC_FPREGS+200)(a0))
-	EX(lwc1 $f26,(SC_FPREGS+208)(a0))
-	EX(lwc1 $f27,(SC_FPREGS+216)(a0))
-	EX(lwc1 $f28,(SC_FPREGS+224)(a0))
-	EX(lwc1 $f29,(SC_FPREGS+232)(a0))
-	EX(lwc1 $f30,(SC_FPREGS+240)(a0))
-	EX(lwc1 $f31,(SC_FPREGS+248)(a0))
+	EX(lw t0, (a1))
+	EX(lwc1 $f0, 0(a0))
+	EX(lwc1 $f1, 8(a0))
+	EX(lwc1 $f2, 16(a0))
+	EX(lwc1 $f3, 24(a0))
+	EX(lwc1 $f4, 32(a0))
+	EX(lwc1 $f5, 40(a0))
+	EX(lwc1 $f6, 48(a0))
+	EX(lwc1 $f7, 56(a0))
+	EX(lwc1 $f8, 64(a0))
+	EX(lwc1 $f9, 72(a0))
+	EX(lwc1 $f10, 80(a0))
+	EX(lwc1 $f11, 88(a0))
+	EX(lwc1 $f12, 96(a0))
+	EX(lwc1 $f13, 104(a0))
+	EX(lwc1 $f14, 112(a0))
+	EX(lwc1 $f15, 120(a0))
+	EX(lwc1 $f16, 128(a0))
+	EX(lwc1 $f17, 136(a0))
+	EX(lwc1 $f18, 144(a0))
+	EX(lwc1 $f19, 152(a0))
+	EX(lwc1 $f20, 160(a0))
+	EX(lwc1 $f21, 168(a0))
+	EX(lwc1 $f22, 176(a0))
+	EX(lwc1 $f23, 184(a0))
+	EX(lwc1 $f24, 192(a0))
+	EX(lwc1 $f25, 200(a0))
+	EX(lwc1 $f26, 208(a0))
+	EX(lwc1 $f27, 216(a0))
+	EX(lwc1 $f28, 224(a0))
+	EX(lwc1 $f29, 232(a0))
+	EX(lwc1 $f30, 240(a0))
+	EX(lwc1 $f31, 248(a0))
 	jr	ra
-	 ctc1	t0,fcr31
+	 ctc1	t0, fcr31
 	.set	pop
 	END(_restore_fp_context)
 	.set	reorder
Index: linux-sfr-test/arch/mips/kernel/r6000_fpu.S
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/r6000_fpu.S	2016-10-22 02:28:57.927876000 +0100
+++ linux-sfr-test/arch/mips/kernel/r6000_fpu.S	2016-10-22 02:29:12.415002000 +0100
@@ -21,7 +21,14 @@
 	.set	push
 	SET_HARDFLOAT
 
-	/* Save floating point context */
+/**
+ * _save_fp_context() - save FP context from the FPU
+ * @a0 - pointer to fpregs field of sigcontext
+ * @a1 - pointer to fpc_csr field of sigcontext
+ *
+ * Save FP context, including the 32 FP data registers and the FP
+ * control & status register, from the FPU to signal context.
+ */
 	LEAF(_save_fp_context)
 	mfc0	t0,CP0_STATUS
 	sll	t0,t0,2
@@ -30,59 +37,59 @@
 
 	cfc1	t1,fcr31
 	/* Store the 16 double precision registers */
-	sdc1	$f0,(SC_FPREGS+0)(a0)
-	sdc1	$f2,(SC_FPREGS+16)(a0)
-	sdc1	$f4,(SC_FPREGS+32)(a0)
-	sdc1	$f6,(SC_FPREGS+48)(a0)
-	sdc1	$f8,(SC_FPREGS+64)(a0)
-	sdc1	$f10,(SC_FPREGS+80)(a0)
-	sdc1	$f12,(SC_FPREGS+96)(a0)
-	sdc1	$f14,(SC_FPREGS+112)(a0)
-	sdc1	$f16,(SC_FPREGS+128)(a0)
-	sdc1	$f18,(SC_FPREGS+144)(a0)
-	sdc1	$f20,(SC_FPREGS+160)(a0)
-	sdc1	$f22,(SC_FPREGS+176)(a0)
-	sdc1	$f24,(SC_FPREGS+192)(a0)
-	sdc1	$f26,(SC_FPREGS+208)(a0)
-	sdc1	$f28,(SC_FPREGS+224)(a0)
-	sdc1	$f30,(SC_FPREGS+240)(a0)
+	sdc1	$f0,0(a0)
+	sdc1	$f2,16(a0)
+	sdc1	$f4,32(a0)
+	sdc1	$f6,48(a0)
+	sdc1	$f8,64(a0)
+	sdc1	$f10,80(a0)
+	sdc1	$f12,96(a0)
+	sdc1	$f14,112(a0)
+	sdc1	$f16,128(a0)
+	sdc1	$f18,144(a0)
+	sdc1	$f20,160(a0)
+	sdc1	$f22,176(a0)
+	sdc1	$f24,192(a0)
+	sdc1	$f26,208(a0)
+	sdc1	$f28,224(a0)
+	sdc1	$f30,240(a0)
 	jr	ra
-	 sw	t0,SC_FPC_CSR(a0)
+	 sw	t0,(a1)
 1:	jr	ra
 	 nop
 	END(_save_fp_context)
 
-/* Restore FPU state:
- *  - fp gp registers
- *  - cp1 status/control register
+/**
+ * _restore_fp_context() - restore FP context to the FPU
+ * @a0 - pointer to fpregs field of sigcontext
+ * @a1 - pointer to fpc_csr field of sigcontext
  *
- * We base the decision which registers to restore from the signal stack
- * frame on the current content of c0_status, not on the content of the
- * stack frame which might have been changed by the user.
+ * Restore FP context, including the 32 FP data registers and the FP
+ * control & status register, from signal context to the FPU.
  */
 	LEAF(_restore_fp_context)
 	mfc0	t0,CP0_STATUS
 	sll	t0,t0,2
 
 	bgez	t0,1f
-	 lw	t0,SC_FPC_CSR(a0)
+	 lw	t0,(a1)
 	/* Restore the 16 double precision registers */
-	ldc1	$f0,(SC_FPREGS+0)(a0)
-	ldc1	$f2,(SC_FPREGS+16)(a0)
-	ldc1	$f4,(SC_FPREGS+32)(a0)
-	ldc1	$f6,(SC_FPREGS+48)(a0)
-	ldc1	$f8,(SC_FPREGS+64)(a0)
-	ldc1	$f10,(SC_FPREGS+80)(a0)
-	ldc1	$f12,(SC_FPREGS+96)(a0)
-	ldc1	$f14,(SC_FPREGS+112)(a0)
-	ldc1	$f16,(SC_FPREGS+128)(a0)
-	ldc1	$f18,(SC_FPREGS+144)(a0)
-	ldc1	$f20,(SC_FPREGS+160)(a0)
-	ldc1	$f22,(SC_FPREGS+176)(a0)
-	ldc1	$f24,(SC_FPREGS+192)(a0)
-	ldc1	$f26,(SC_FPREGS+208)(a0)
-	ldc1	$f28,(SC_FPREGS+224)(a0)
-	ldc1	$f30,(SC_FPREGS+240)(a0)
+	ldc1	$f0,0(a0)
+	ldc1	$f2,16(a0)
+	ldc1	$f4,32(a0)
+	ldc1	$f6,48(a0)
+	ldc1	$f8,64(a0)
+	ldc1	$f10,80(a0)
+	ldc1	$f12,96(a0)
+	ldc1	$f14,112(a0)
+	ldc1	$f16,128(a0)
+	ldc1	$f18,144(a0)
+	ldc1	$f20,160(a0)
+	ldc1	$f22,176(a0)
+	ldc1	$f24,192(a0)
+	ldc1	$f26,208(a0)
+	ldc1	$f28,224(a0)
+	ldc1	$f30,240(a0)
 	jr	ra
 	 ctc1	t0,fcr31
 1:	jr	ra
