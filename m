Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:36:43 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025310AbbDCW1i7ZX8y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:27:38 +0200
Date:   Fri, 3 Apr 2015 23:27:38 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 45/48] MIPS: math-emu: Define IEEE 754-2008 feature control
 bits
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504032122520.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46762
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

Define IEEE 754-2008 feature control bits: FIR.HAS2008, FCSR.ABS2008 and 
FCSR.NAN2008, and update the `_ieee754_csr' structure accordingly.

For completeness define FIR.UFRP too.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-cp1-fcsr.diff
Index: linux/arch/mips/include/asm/mipsregs.h
===================================================================
--- linux.orig/arch/mips/include/asm/mipsregs.h	2015-04-03 15:55:16.641969000 +0100
+++ linux/arch/mips/include/asm/mipsregs.h	2015-04-03 15:55:17.630977000 +0100
@@ -696,6 +696,8 @@
 #define MIPS_FPIR_W		(_ULCAST_(1) << 20)
 #define MIPS_FPIR_L		(_ULCAST_(1) << 21)
 #define MIPS_FPIR_F64		(_ULCAST_(1) << 22)
+#define MIPS_FPIR_HAS2008	(_ULCAST_(1) << 23)
+#define MIPS_FPIR_UFRP		(_ULCAST_(1) << 28)
 #define MIPS_FPIR_FREP		(_ULCAST_(1) << 29)
 
 /*
@@ -753,10 +755,13 @@
 #define FPU_CSR_COND7	(_ULCAST_(1) << FPU_CSR_COND7_S)
 
 /*
- * Bits 18 - 20 of the FPU Status Register will be read as 0,
+ * Bits 22:20 of the FPU Status Register will be read as 0,
  * and should be written as zero.
  */
-#define FPU_CSR_RSVD	0x001c0000
+#define FPU_CSR_RSVD	(_ULCAST_(7) << 20)
+
+#define FPU_CSR_ABS2008	(_ULCAST_(1) << 19)
+#define FPU_CSR_NAN2008	(_ULCAST_(1) << 18)
 
 /*
  * X the exception cause indicator
Index: linux/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux.orig/arch/mips/math-emu/cp1emu.c	2015-04-03 15:55:16.656968000 +0100
+++ linux/arch/mips/math-emu/cp1emu.c	2015-04-03 15:55:17.635977000 +0100
@@ -919,8 +919,9 @@ static inline void cop1_ctc(struct pt_re
 		pr_debug("%p gpr[%d]->csr=%08x\n",
 			 (void *)xcp->cp0_epc, MIPSInst_RT(ir), value);
 
-		/* Don't write reserved bits.  */
-		fcr31 = value & ~FPU_CSR_RSVD;
+		/* Don't write unsupported bits.  */
+		fcr31 = value &
+			~(FPU_CSR_RSVD | FPU_CSR_ABS2008 | FPU_CSR_NAN2008);
 		break;
 
 	case FPCREG_FENR:
Index: linux/arch/mips/math-emu/ieee754.h
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754.h	2015-04-03 13:42:52.928882000 +0100
+++ linux/arch/mips/math-emu/ieee754.h	2015-04-03 15:55:17.637981000 +0100
@@ -130,15 +130,17 @@ enum {
  * The control status register
  */
 struct _ieee754_csr {
-	__BITFIELD_FIELD(unsigned pad0:7,
-	__BITFIELD_FIELD(unsigned nod:1,	/* set 1 for no denormalised numbers */
-	__BITFIELD_FIELD(unsigned c:1,		/* condition */
-	__BITFIELD_FIELD(unsigned pad1:5,
+	__BITFIELD_FIELD(unsigned fcc:7,	/* condition[7:1] */
+	__BITFIELD_FIELD(unsigned nod:1,	/* set 1 for no denormals */
+	__BITFIELD_FIELD(unsigned c:1,		/* condition[0] */
+	__BITFIELD_FIELD(unsigned pad0:3,
+	__BITFIELD_FIELD(unsigned abs2008:1,	/* IEEE 754-2008 ABS/NEG.fmt */
+	__BITFIELD_FIELD(unsigned nan2008:1,	/* IEEE 754-2008 NaN mode */
 	__BITFIELD_FIELD(unsigned cx:6,		/* exceptions this operation */
 	__BITFIELD_FIELD(unsigned mx:5,		/* exception enable  mask */
 	__BITFIELD_FIELD(unsigned sx:5,		/* exceptions total */
 	__BITFIELD_FIELD(unsigned rm:2,		/* current rounding mode */
-	;))))))))
+	;))))))))))
 };
 #define ieee754_csr (*(struct _ieee754_csr *)(&current->thread.fpu.fcr31))
 
