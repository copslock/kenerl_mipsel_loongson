Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:28:10 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025269AbbDCWY4DffGb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:24:56 +0200
Date:   Fri, 3 Apr 2015 23:24:56 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 16/48] MIPS: math-emu: Remove `modeindex' macro
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030250300.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46733
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

Commit 56a64733 [MIPS: math-emu: Switch to using the MIPS rounding 
modes.] removed the distinction between hardware and emulator rounding 
mode encodings, the hardware encoding is now used in emulation as well.  
Complement the change and remove the `modeindex' macro previously used 
for indexing into encoding translation tables, it now does nothing and 
only obfuscates code by reinserting the value extracted from FCSR.  
Adjust comments accordingly.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-fcsr-rm-modeindex.diff
Index: linux/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux.orig/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:53.154170000 +0100
+++ linux/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:54.099185000 +0100
@@ -65,9 +65,6 @@ static int fpux_emu(struct pt_regs *,
 #define FPCREG_RID	0	/* $0  = revision id */
 #define FPCREG_CSR	31	/* $31 = csr */
 
-/* Determine rounding mode from the RM bits of the FCSR */
-#define modeindex(v) ((v) & FPU_CSR_RM)
-
 /* convert condition code register number to csr bit */
 const unsigned int fpucondbit[8] = {
 	FPU_CSR_COND0,
@@ -1051,7 +1048,6 @@ static int cop1Emulate(struct pt_regs *x
 			/* cop control register rd -> gpr[rt] */
 			if (MIPSInst_RD(ir) == FPCREG_CSR) {
 				value = ctx->fcr31;
-				value = (value & ~FPU_CSR_RM) | modeindex(value);
 				pr_debug("%p gpr[%d]<-csr=%08x\n",
 					 (void *) (xcp->cp0_epc),
 					 MIPSInst_RT(ir), value);
@@ -1078,12 +1074,8 @@ static int cop1Emulate(struct pt_regs *x
 					 (void *) (xcp->cp0_epc),
 					 MIPSInst_RT(ir), value);
 
-				/*
-				 * Don't write reserved bits,
-				 * and convert to ieee library modes
-				 */
-				ctx->fcr31 = (value & ~(FPU_CSR_RSVD | FPU_CSR_RM)) |
-					     modeindex(value);
+				/* Don't write reserved bits.  */
+				ctx->fcr31 = value & ~FPU_CSR_RSVD;
 			}
 			if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
 				return SIGFPE;
@@ -1675,7 +1667,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 
 			oldrm = ieee754_csr.rm;
 			SPFROMREG(fs, MIPSInst_FS(ir));
-			ieee754_csr.rm = modeindex(MIPSInst_FUNC(ir));
+			ieee754_csr.rm = MIPSInst_FUNC(ir);
 			rv.w = ieee754sp_tint(fs);
 			ieee754_csr.rm = oldrm;
 			rfmt = w_fmt;
@@ -1699,7 +1691,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 
 			oldrm = ieee754_csr.rm;
 			SPFROMREG(fs, MIPSInst_FS(ir));
-			ieee754_csr.rm = modeindex(MIPSInst_FUNC(ir));
+			ieee754_csr.rm = MIPSInst_FUNC(ir);
 			rv.l = ieee754sp_tlong(fs);
 			ieee754_csr.rm = oldrm;
 			rfmt = l_fmt;
@@ -1852,7 +1844,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 
 			oldrm = ieee754_csr.rm;
 			DPFROMREG(fs, MIPSInst_FS(ir));
-			ieee754_csr.rm = modeindex(MIPSInst_FUNC(ir));
+			ieee754_csr.rm = MIPSInst_FUNC(ir);
 			rv.w = ieee754dp_tint(fs);
 			ieee754_csr.rm = oldrm;
 			rfmt = w_fmt;
@@ -1876,7 +1868,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 
 			oldrm = ieee754_csr.rm;
 			DPFROMREG(fs, MIPSInst_FS(ir));
-			ieee754_csr.rm = modeindex(MIPSInst_FUNC(ir));
+			ieee754_csr.rm = MIPSInst_FUNC(ir);
 			rv.l = ieee754dp_tlong(fs);
 			ieee754_csr.rm = oldrm;
 			rfmt = l_fmt;
@@ -2081,10 +2073,8 @@ int fpu_emulator_cop1Handler(struct pt_r
 			xcp->cp0_epc += dec_insn.pc_inc;	/* Skip NOPs */
 		else {
 			/*
-			 * The 'ieee754_csr' is an alias of
-			 * ctx->fcr31.	No need to copy ctx->fcr31 to
-			 * ieee754_csr.	 But ieee754_csr.rm is ieee
-			 * library modes. (not mips rounding mode)
+			 * The 'ieee754_csr' is an alias of ctx->fcr31.
+			 * No need to copy ctx->fcr31 to ieee754_csr.
 			 */
 			sig = cop1Emulate(xcp, ctx, dec_insn, fault_addr);
 		}
