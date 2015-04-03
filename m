Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:36:24 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27008399AbbDCW1diXLdO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:27:33 +0200
Date:   Fri, 3 Apr 2015 23:27:33 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 44/48] MIPS: math-emu: Implement the FCCR, FEXR and FENR
 registers
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504032113160.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46761
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

Implement the FCCR, FEXR and FENR "shadow" FPU registers for the 
architecture levels that include them, for the CFC1 and CTC1 
instructions in the full emulation mode.

For completeness add macros for the CP1 UFR and UNFR registers too, no 
actual implementation though.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 Again, this causes a flood of checkpatch.pl errors:

ERROR: Macros with complex values should be enclosed in parentheses
#11: FILE: arch/mips/include/asm/mipsregs.h:680:
+#define CP1_REVISION	$0

ERROR: Macros with complex values should be enclosed in parentheses
#12: FILE: arch/mips/include/asm/mipsregs.h:681:
+#define CP1_UFR		$1

ERROR: Macros with complex values should be enclosed in parentheses
#13: FILE: arch/mips/include/asm/mipsregs.h:682:
+#define CP1_UNFR	$4

ERROR: Macros with complex values should be enclosed in parentheses
#14: FILE: arch/mips/include/asm/mipsregs.h:683:
+#define CP1_FCCR	$25

ERROR: Macros with complex values should be enclosed in parentheses
#15: FILE: arch/mips/include/asm/mipsregs.h:684:
+#define CP1_FEXR	$26

ERROR: Macros with complex values should be enclosed in parentheses
#16: FILE: arch/mips/include/asm/mipsregs.h:685:
+#define CP1_FENR	$28

ERROR: Macros with complex values should be enclosed in parentheses
#17: FILE: arch/mips/include/asm/mipsregs.h:686:
+#define CP1_STATUS	$31

that I think we'll just have to live with, there's nothing wrong with 
these macros and their intended purpose.

  Maciej

linux-mips-emu-fcr.diff
Index: linux/arch/mips/include/asm/mipsregs.h
===================================================================
--- linux.orig/arch/mips/include/asm/mipsregs.h	2015-04-02 20:27:52.242161000 +0100
+++ linux/arch/mips/include/asm/mipsregs.h	2015-04-02 20:27:59.089235000 +0100
@@ -677,8 +677,13 @@
 /*
  * Coprocessor 1 (FPU) register names
  */
-#define CP1_REVISION   $0
-#define CP1_STATUS     $31
+#define CP1_REVISION	$0
+#define CP1_UFR		$1
+#define CP1_UNFR	$4
+#define CP1_FCCR	$25
+#define CP1_FEXR	$26
+#define CP1_FENR	$28
+#define CP1_STATUS	$31
 
 
 /*
@@ -694,18 +699,58 @@
 #define MIPS_FPIR_FREP		(_ULCAST_(1) << 29)
 
 /*
+ * Bits in the MIPS32/64 coprocessor 1 (FPU) condition codes register.
+ */
+#define MIPS_FCCR_CONDX_S	0
+#define MIPS_FCCR_CONDX		(_ULCAST_(255) << MIPS_FCCR_CONDX_S)
+#define MIPS_FCCR_COND0_S	0
+#define MIPS_FCCR_COND0		(_ULCAST_(1) << MIPS_FCCR_COND0_S)
+#define MIPS_FCCR_COND1_S	1
+#define MIPS_FCCR_COND1		(_ULCAST_(1) << MIPS_FCCR_COND1_S)
+#define MIPS_FCCR_COND2_S	2
+#define MIPS_FCCR_COND2		(_ULCAST_(1) << MIPS_FCCR_COND2_S)
+#define MIPS_FCCR_COND3_S	3
+#define MIPS_FCCR_COND3		(_ULCAST_(1) << MIPS_FCCR_COND3_S)
+#define MIPS_FCCR_COND4_S	4
+#define MIPS_FCCR_COND4		(_ULCAST_(1) << MIPS_FCCR_COND4_S)
+#define MIPS_FCCR_COND5_S	5
+#define MIPS_FCCR_COND5		(_ULCAST_(1) << MIPS_FCCR_COND5_S)
+#define MIPS_FCCR_COND6_S	6
+#define MIPS_FCCR_COND6		(_ULCAST_(1) << MIPS_FCCR_COND6_S)
+#define MIPS_FCCR_COND7_S	7
+#define MIPS_FCCR_COND7		(_ULCAST_(1) << MIPS_FCCR_COND7_S)
+
+/*
+ * Bits in the MIPS32/64 coprocessor 1 (FPU) enables register.
+ */
+#define MIPS_FENR_FS_S		2
+#define MIPS_FENR_FS		(_ULCAST_(1) << MIPS_FENR_FS_S)
+
+/*
  * FPU Status Register Values
  */
-#define FPU_CSR_FLUSH	0x01000000	/* flush denormalised results to 0 */
-#define FPU_CSR_COND	0x00800000	/* $fcc0 */
-#define FPU_CSR_COND0	0x00800000	/* $fcc0 */
-#define FPU_CSR_COND1	0x02000000	/* $fcc1 */
-#define FPU_CSR_COND2	0x04000000	/* $fcc2 */
-#define FPU_CSR_COND3	0x08000000	/* $fcc3 */
-#define FPU_CSR_COND4	0x10000000	/* $fcc4 */
-#define FPU_CSR_COND5	0x20000000	/* $fcc5 */
-#define FPU_CSR_COND6	0x40000000	/* $fcc6 */
-#define FPU_CSR_COND7	0x80000000	/* $fcc7 */
+#define FPU_CSR_COND_S	23					/* $fcc0 */
+#define FPU_CSR_COND	(_ULCAST_(1) << FPU_CSR_COND_S)
+
+#define FPU_CSR_FS_S	24		/* flush denormalised results to 0 */
+#define FPU_CSR_FS	(_ULCAST_(1) << FPU_CSR_FS_S)
+
+#define FPU_CSR_CONDX_S	25					/* $fcc[7:1] */
+#define FPU_CSR_CONDX	(_ULCAST_(127) << FPU_CSR_CONDX_S)
+#define FPU_CSR_COND1_S	25					/* $fcc1 */
+#define FPU_CSR_COND1	(_ULCAST_(1) << FPU_CSR_COND1_S)
+#define FPU_CSR_COND2_S	26					/* $fcc2 */
+#define FPU_CSR_COND2	(_ULCAST_(1) << FPU_CSR_COND2_S)
+#define FPU_CSR_COND3_S	27					/* $fcc3 */
+#define FPU_CSR_COND3	(_ULCAST_(1) << FPU_CSR_COND3_S)
+#define FPU_CSR_COND4_S	28					/* $fcc4 */
+#define FPU_CSR_COND4	(_ULCAST_(1) << FPU_CSR_COND4_S)
+#define FPU_CSR_COND5_S	29					/* $fcc5 */
+#define FPU_CSR_COND5	(_ULCAST_(1) << FPU_CSR_COND5_S)
+#define FPU_CSR_COND6_S	30					/* $fcc6 */
+#define FPU_CSR_COND6	(_ULCAST_(1) << FPU_CSR_COND6_S)
+#define FPU_CSR_COND7_S	31					/* $fcc7 */
+#define FPU_CSR_COND7	(_ULCAST_(1) << FPU_CSR_COND7_S)
 
 /*
  * Bits 18 - 20 of the FPU Status Register will be read as 0,
Index: linux/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux.orig/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:58.894230000 +0100
+++ linux/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:59.094235000 +0100
@@ -64,11 +64,14 @@ static int fpux_emu(struct pt_regs *,
 /* Control registers */
 
 #define FPCREG_RID	0	/* $0  = revision id */
+#define FPCREG_FCCR	25	/* $25 = fccr */
+#define FPCREG_FEXR	26	/* $26 = fexr */
+#define FPCREG_FENR	28	/* $28 = fenr */
 #define FPCREG_CSR	31	/* $31 = csr */
 
 /* convert condition code register number to csr bit */
 const unsigned int fpucondbit[8] = {
-	FPU_CSR_COND0,
+	FPU_CSR_COND,
 	FPU_CSR_COND1,
 	FPU_CSR_COND2,
 	FPU_CSR_COND3,
@@ -846,17 +849,53 @@ do {									\
 static inline void cop1_cfc(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			    mips_instruction ir)
 {
-	u32 value;
+	u32 fcr31 = ctx->fcr31;
+	u32 value = 0;
 
-	if (MIPSInst_RD(ir) == FPCREG_CSR) {
-		value = ctx->fcr31;
+	switch (MIPSInst_RD(ir)) {
+	case FPCREG_CSR:
+		value = fcr31;
 		pr_debug("%p gpr[%d]<-csr=%08x\n",
-			 (void *)xcp->cp0_epc,
-			 MIPSInst_RT(ir), value);
-	} else if (MIPSInst_RD(ir) == FPCREG_RID)
+			 (void *)xcp->cp0_epc, MIPSInst_RT(ir), value);
+		break;
+
+	case FPCREG_FENR:
+		if (!cpu_has_mips_r)
+			break;
+		value = (fcr31 >> (FPU_CSR_FS_S - MIPS_FENR_FS_S)) &
+			MIPS_FENR_FS;
+		value |= fcr31 & (FPU_CSR_ALL_E | FPU_CSR_RM);
+		pr_debug("%p gpr[%d]<-enr=%08x\n",
+			 (void *)xcp->cp0_epc, MIPSInst_RT(ir), value);
+		break;
+
+	case FPCREG_FEXR:
+		if (!cpu_has_mips_r)
+			break;
+		value = fcr31 & (FPU_CSR_ALL_X | FPU_CSR_ALL_S);
+		pr_debug("%p gpr[%d]<-exr=%08x\n",
+			 (void *)xcp->cp0_epc, MIPSInst_RT(ir), value);
+		break;
+
+	case FPCREG_FCCR:
+		if (!cpu_has_mips_r)
+			break;
+		value = (fcr31 >> (FPU_CSR_COND_S - MIPS_FCCR_COND0_S)) &
+			MIPS_FCCR_COND0;
+		value |= (fcr31 >> (FPU_CSR_COND1_S - MIPS_FCCR_COND1_S)) &
+			 (MIPS_FCCR_CONDX & ~MIPS_FCCR_COND0);
+		pr_debug("%p gpr[%d]<-ccr=%08x\n",
+			 (void *)xcp->cp0_epc, MIPSInst_RT(ir), value);
+		break;
+
+	case FPCREG_RID:
 		value = current_cpu_data.fpu_id;
-	else
-		value = 0;
+		break;
+
+	default:
+		break;
+	}
+
 	if (MIPSInst_RT(ir))
 		xcp->regs[MIPSInst_RT(ir)] = value;
 }
@@ -867,6 +906,7 @@ static inline void cop1_cfc(struct pt_re
 static inline void cop1_ctc(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			    mips_instruction ir)
 {
+	u32 fcr31 = ctx->fcr31;
 	u32 value;
 
 	if (MIPSInst_RT(ir) == 0)
@@ -874,16 +914,52 @@ static inline void cop1_ctc(struct pt_re
 	else
 		value = xcp->regs[MIPSInst_RT(ir)];
 
-	/* we only have one writable control reg
-	 */
-	if (MIPSInst_RD(ir) == FPCREG_CSR) {
+	switch (MIPSInst_RD(ir)) {
+	case FPCREG_CSR:
 		pr_debug("%p gpr[%d]->csr=%08x\n",
-			 (void *)xcp->cp0_epc,
-			 MIPSInst_RT(ir), value);
+			 (void *)xcp->cp0_epc, MIPSInst_RT(ir), value);
 
 		/* Don't write reserved bits.  */
-		ctx->fcr31 = value & ~FPU_CSR_RSVD;
+		fcr31 = value & ~FPU_CSR_RSVD;
+		break;
+
+	case FPCREG_FENR:
+		if (!cpu_has_mips_r)
+			break;
+		pr_debug("%p gpr[%d]->enr=%08x\n",
+			 (void *)xcp->cp0_epc, MIPSInst_RT(ir), value);
+		fcr31 &= ~(FPU_CSR_FS | FPU_CSR_ALL_E | FPU_CSR_RM);
+		fcr31 |= (value << (FPU_CSR_FS_S - MIPS_FENR_FS_S)) &
+			 FPU_CSR_FS;
+		fcr31 |= value & (FPU_CSR_ALL_E | FPU_CSR_RM);
+		break;
+
+	case FPCREG_FEXR:
+		if (!cpu_has_mips_r)
+			break;
+		pr_debug("%p gpr[%d]->exr=%08x\n",
+			 (void *)xcp->cp0_epc, MIPSInst_RT(ir), value);
+		fcr31 &= ~(FPU_CSR_ALL_X | FPU_CSR_ALL_S);
+		fcr31 |= value & (FPU_CSR_ALL_X | FPU_CSR_ALL_S);
+		break;
+
+	case FPCREG_FCCR:
+		if (!cpu_has_mips_r)
+			break;
+		pr_debug("%p gpr[%d]->ccr=%08x\n",
+			 (void *)xcp->cp0_epc, MIPSInst_RT(ir), value);
+		fcr31 &= ~(FPU_CSR_CONDX | FPU_CSR_COND);
+		fcr31 |= (value << (FPU_CSR_COND_S - MIPS_FCCR_COND0_S)) &
+			 FPU_CSR_COND;
+		fcr31 |= (value << (FPU_CSR_COND1_S - MIPS_FCCR_COND1_S)) &
+			 FPU_CSR_CONDX;
+		break;
+
+	default:
+		break;
 	}
+
+	ctx->fcr31 = fcr31;
 }
 
 /*
