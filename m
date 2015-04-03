Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:34:21 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025301AbbDCW04VLabB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:26:56 +0200
Date:   Fri, 3 Apr 2015 23:26:56 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 37/48] MIPS: math-emu: Correct delay-slot exception
 propagation
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031834270.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46754
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

Restore EPC at the branch whose delay slot is emulated if the delay-slot 
instruction signals.  This is so that code in `fpu_emulator_cop1Handler' 
does not see EPC having advanced and mistakenly successfully resume 
userland execution from the location at the branch target in that case.
Restoring EPC guarantees an immediate exit from the emulation loop and 
if EPC hasn't advanced at all since entering the loop, also issuing the 
signal reported by the delay-slot instruction.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-bc1x-sigill.patch
Index: linux/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux.orig/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:57.493218000 +0100
+++ linux/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:57.710224000 +0100
@@ -1134,6 +1134,14 @@ static int cop1Emulate(struct pt_regs *x
 				/*
 				 * Branch taken: emulate dslot instruction
 				 */
+				unsigned long bcpc;
+
+				/*
+				 * Remember EPC at the branch to point back
+				 * at so that any delay-slot instruction
+				 * signal is not silently ignored.
+				 */
+				bcpc = xcp->cp0_epc;
 				xcp->cp0_epc += dec_insn.pc_inc;
 
 				contpc = MIPSInst_SIMM(ir);
@@ -1159,7 +1167,15 @@ static int cop1Emulate(struct pt_regs *x
 						 * Single step the non-CP1
 						 * instruction in the dslot.
 						 */
-						return mips_dsemul(xcp, ir, contpc);
+						sig = mips_dsemul(xcp, ir,
+								  contpc);
+						if (sig)
+							xcp->cp0_epc = bcpc;
+						/*
+						 * SIGILL forces out of
+						 * the emulation loop.
+						 */
+						return sig ? sig : SIGILL;
 					}
 				} else
 					contpc = (xcp->cp0_epc + (contpc << 2));
@@ -1174,7 +1190,7 @@ static int cop1Emulate(struct pt_regs *x
 					if (cpu_has_mips_2_3_4_5_r)
 						goto emul;
 
-					return SIGILL;
+					goto bc_sigill;
 
 				case cop1_op:
 					goto emul;
@@ -1184,7 +1200,7 @@ static int cop1Emulate(struct pt_regs *x
 						/* its one of ours */
 						goto emul;
 
-					return SIGILL;
+					goto bc_sigill;
 
 				case spec_op:
 					switch (MIPSInst_FUNC(ir)) {
@@ -1192,16 +1208,24 @@ static int cop1Emulate(struct pt_regs *x
 						if (cpu_has_mips_4_5_r)
 							goto emul;
 
-						return SIGILL;
+						goto bc_sigill;
 					}
 					break;
+
+				bc_sigill:
+					xcp->cp0_epc = bcpc;
+					return SIGILL;
 				}
 
 				/*
 				 * Single step the non-cp1
 				 * instruction in the dslot
 				 */
-				return mips_dsemul(xcp, ir, contpc);
+				sig = mips_dsemul(xcp, ir, contpc);
+				if (sig)
+					xcp->cp0_epc = bcpc;
+				/* SIGILL forces out of the emulation loop.  */
+				return sig ? sig : SIGILL;
 			} else if (likely) {	/* branch not taken */
 				/*
 				 * branch likely nullifies
Index: linux/arch/mips/math-emu/dsemul.c
===================================================================
--- linux.orig/arch/mips/math-emu/dsemul.c	2015-04-02 20:27:57.133225000 +0100
+++ linux/arch/mips/math-emu/dsemul.c	2015-04-02 20:27:57.713219000 +0100
@@ -96,7 +96,7 @@ int mips_dsemul(struct pt_regs *regs, mi
 
 	flush_cache_sigtramp((unsigned long)&fr->emul);
 
-	return SIGILL;		/* force out of emulation loop */
+	return 0;
 }
 
 int do_dsemulret(struct pt_regs *xcp)
