Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:28:47 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025275AbbDCWZEexkuF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:04 +0200
Date:   Fri, 3 Apr 2015 23:25:04 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 18/48] MIPS: math-emu: Factor out CFC1/CTC1 emulation
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030318150.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46735
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

Move CFC1/CTC1 emulation code to separate functions to avoid excessive 
indentation in forthcoming changes.  Adjust formatting in a minor way 
and remove extraneous round brackets.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-cxc.diff
Index: linux/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux.orig/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:54.099185000 +0100
+++ linux/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:54.459192000 +0100
@@ -840,6 +840,52 @@ do {									\
 #define DPTOREG(dp, x)	DITOREG((dp).bits, x)
 
 /*
+ * Emulate a CFC1 instruction.
+ */
+static inline void cop1_cfc(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
+			    mips_instruction ir)
+{
+	u32 value;
+
+	if (MIPSInst_RD(ir) == FPCREG_CSR) {
+		value = ctx->fcr31;
+		pr_debug("%p gpr[%d]<-csr=%08x\n",
+			 (void *)xcp->cp0_epc,
+			 MIPSInst_RT(ir), value);
+	} else if (MIPSInst_RD(ir) == FPCREG_RID)
+		value = 0;
+	else
+		value = 0;
+	if (MIPSInst_RT(ir))
+		xcp->regs[MIPSInst_RT(ir)] = value;
+}
+
+/*
+ * Emulate a CTC1 instruction.
+ */
+static inline void cop1_ctc(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
+			    mips_instruction ir)
+{
+	u32 value;
+
+	if (MIPSInst_RT(ir) == 0)
+		value = 0;
+	else
+		value = xcp->regs[MIPSInst_RT(ir)];
+
+	/* we only have one writable control reg
+	 */
+	if (MIPSInst_RD(ir) == FPCREG_CSR) {
+		pr_debug("%p gpr[%d]->csr=%08x\n",
+			 (void *)xcp->cp0_epc,
+			 MIPSInst_RT(ir), value);
+
+		/* Don't write reserved bits.  */
+		ctx->fcr31 = value & ~FPU_CSR_RSVD;
+	}
+}
+
+/*
  * Emulate the single floating point instruction pointed at by EPC.
  * Two instructions if the instruction is in a branch delay slot.
  */
@@ -853,7 +899,6 @@ static int cop1Emulate(struct pt_regs *x
 	int likely, pc_inc;
 	u32 __user *wva;
 	u64 __user *dva;
-	u32 value;
 	u32 wval;
 	u64 dval;
 	int sig;
@@ -1046,37 +1091,12 @@ static int cop1Emulate(struct pt_regs *x
 
 		case cfc_op:
 			/* cop control register rd -> gpr[rt] */
-			if (MIPSInst_RD(ir) == FPCREG_CSR) {
-				value = ctx->fcr31;
-				pr_debug("%p gpr[%d]<-csr=%08x\n",
-					 (void *) (xcp->cp0_epc),
-					 MIPSInst_RT(ir), value);
-			}
-			else if (MIPSInst_RD(ir) == FPCREG_RID)
-				value = 0;
-			else
-				value = 0;
-			if (MIPSInst_RT(ir))
-				xcp->regs[MIPSInst_RT(ir)] = value;
+			cop1_cfc(xcp, ctx, ir);
 			break;
 
 		case ctc_op:
 			/* copregister rd <- rt */
-			if (MIPSInst_RT(ir) == 0)
-				value = 0;
-			else
-				value = xcp->regs[MIPSInst_RT(ir)];
-
-			/* we only have one writable control reg
-			 */
-			if (MIPSInst_RD(ir) == FPCREG_CSR) {
-				pr_debug("%p gpr[%d]->csr=%08x\n",
-					 (void *) (xcp->cp0_epc),
-					 MIPSInst_RT(ir), value);
-
-				/* Don't write reserved bits.  */
-				ctx->fcr31 = value & ~FPU_CSR_RSVD;
-			}
+			cop1_ctc(xcp, ctx, ir);
 			if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
 				return SIGFPE;
 			}
