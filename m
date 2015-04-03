Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:24:25 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27008399AbbDCWXqJpuje (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:23:46 +0200
Date:   Fri, 3 Apr 2015 23:23:46 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 03/48] MIPS: mipsregs.h: Reorder CP1 macro definitions
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030114080.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46720
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

Originally CP1 macros were placed between CP0 register name macros and 
CP0 register value macros.  As changes were applied to the header the 
position of CP1 macros gradually has become more and more arbitrary and 
two separate blocks were created.  This may only cause confusion.

Move them out of the way then and place together after all the CP0 
macros.  No semantic change.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 FYI, checkpatch.pl has bogus issues with this change:

ERROR: Macros with complex values should be enclosed in parentheses
#99: FILE: arch/mips/include/asm/mipsregs.h:680:
+#define CP1_REVISION   $0

ERROR: Macros with complex values should be enclosed in parentheses
#100: FILE: arch/mips/include/asm/mipsregs.h:681:
+#define CP1_STATUS     $31

I hope that's not going to disturb your patch handling flow.

  Maciej

linux-mips-regs-cp1.diff
Index: linux/arch/mips/include/asm/mipsregs.h
===================================================================
--- linux.orig/arch/mips/include/asm/mipsregs.h	2015-04-02 20:27:51.667161000 +0100
+++ linux/arch/mips/include/asm/mipsregs.h	2015-04-02 20:27:51.855157000 +0100
@@ -111,66 +111,6 @@
  */
 #define CP0_TX39_CACHE	$7
 
-/*
- * Coprocessor 1 (FPU) register names
- */
-#define CP1_REVISION   $0
-#define CP1_STATUS     $31
-
-/*
- * FPU Status Register Values
- */
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
-
-/*
- * Bits 18 - 20 of the FPU Status Register will be read as 0,
- * and should be written as zero.
- */
-#define FPU_CSR_RSVD	0x001c0000
-
-/*
- * X the exception cause indicator
- * E the exception enable
- * S the sticky/flag bit
-*/
-#define FPU_CSR_ALL_X	0x0003f000
-#define FPU_CSR_UNI_X	0x00020000
-#define FPU_CSR_INV_X	0x00010000
-#define FPU_CSR_DIV_X	0x00008000
-#define FPU_CSR_OVF_X	0x00004000
-#define FPU_CSR_UDF_X	0x00002000
-#define FPU_CSR_INE_X	0x00001000
-
-#define FPU_CSR_ALL_E	0x00000f80
-#define FPU_CSR_INV_E	0x00000800
-#define FPU_CSR_DIV_E	0x00000400
-#define FPU_CSR_OVF_E	0x00000200
-#define FPU_CSR_UDF_E	0x00000100
-#define FPU_CSR_INE_E	0x00000080
-
-#define FPU_CSR_ALL_S	0x0000007c
-#define FPU_CSR_INV_S	0x00000040
-#define FPU_CSR_DIV_S	0x00000020
-#define FPU_CSR_OVF_S	0x00000010
-#define FPU_CSR_UDF_S	0x00000008
-#define FPU_CSR_INE_S	0x00000004
-
-/* Bits 0 and 1 of FPU Status Register specify the rounding mode */
-#define FPU_CSR_RM	0x00000003
-#define FPU_CSR_RN	0x0	/* nearest */
-#define FPU_CSR_RZ	0x1	/* towards zero */
-#define FPU_CSR_RU	0x2	/* towards +Infinity */
-#define FPU_CSR_RD	0x3	/* towards -Infinity */
-
 
 /*
  * Values for PageMask register
@@ -683,18 +623,6 @@
 #define MIPS_CMGCRF_BASE	(~_ULCAST_((1 << MIPS_CMGCRB_BASE) - 1))
 
 /*
- * Bits in the MIPS32/64 coprocessor 1 (FPU) revision register.
- */
-#define MIPS_FPIR_S		(_ULCAST_(1) << 16)
-#define MIPS_FPIR_D		(_ULCAST_(1) << 17)
-#define MIPS_FPIR_PS		(_ULCAST_(1) << 18)
-#define MIPS_FPIR_3D		(_ULCAST_(1) << 19)
-#define MIPS_FPIR_W		(_ULCAST_(1) << 20)
-#define MIPS_FPIR_L		(_ULCAST_(1) << 21)
-#define MIPS_FPIR_F64		(_ULCAST_(1) << 22)
-#define MIPS_FPIR_FREP		(_ULCAST_(1) << 29)
-
-/*
  * Bits in the MIPS32 Memory Segmentation registers.
  */
 #define MIPS_SEGCFG_PA_SHIFT	9
@@ -745,6 +673,81 @@
 #define MIPS_PWCTL_PSN_SHIFT	0
 #define MIPS_PWCTL_PSN_MASK	0x0000003f
 
+
+/*
+ * Coprocessor 1 (FPU) register names
+ */
+#define CP1_REVISION   $0
+#define CP1_STATUS     $31
+
+
+/*
+ * Bits in the MIPS32/64 coprocessor 1 (FPU) revision register.
+ */
+#define MIPS_FPIR_S		(_ULCAST_(1) << 16)
+#define MIPS_FPIR_D		(_ULCAST_(1) << 17)
+#define MIPS_FPIR_PS		(_ULCAST_(1) << 18)
+#define MIPS_FPIR_3D		(_ULCAST_(1) << 19)
+#define MIPS_FPIR_W		(_ULCAST_(1) << 20)
+#define MIPS_FPIR_L		(_ULCAST_(1) << 21)
+#define MIPS_FPIR_F64		(_ULCAST_(1) << 22)
+#define MIPS_FPIR_FREP		(_ULCAST_(1) << 29)
+
+/*
+ * FPU Status Register Values
+ */
+#define FPU_CSR_FLUSH	0x01000000	/* flush denormalised results to 0 */
+#define FPU_CSR_COND	0x00800000	/* $fcc0 */
+#define FPU_CSR_COND0	0x00800000	/* $fcc0 */
+#define FPU_CSR_COND1	0x02000000	/* $fcc1 */
+#define FPU_CSR_COND2	0x04000000	/* $fcc2 */
+#define FPU_CSR_COND3	0x08000000	/* $fcc3 */
+#define FPU_CSR_COND4	0x10000000	/* $fcc4 */
+#define FPU_CSR_COND5	0x20000000	/* $fcc5 */
+#define FPU_CSR_COND6	0x40000000	/* $fcc6 */
+#define FPU_CSR_COND7	0x80000000	/* $fcc7 */
+
+/*
+ * Bits 18 - 20 of the FPU Status Register will be read as 0,
+ * and should be written as zero.
+ */
+#define FPU_CSR_RSVD	0x001c0000
+
+/*
+ * X the exception cause indicator
+ * E the exception enable
+ * S the sticky/flag bit
+*/
+#define FPU_CSR_ALL_X	0x0003f000
+#define FPU_CSR_UNI_X	0x00020000
+#define FPU_CSR_INV_X	0x00010000
+#define FPU_CSR_DIV_X	0x00008000
+#define FPU_CSR_OVF_X	0x00004000
+#define FPU_CSR_UDF_X	0x00002000
+#define FPU_CSR_INE_X	0x00001000
+
+#define FPU_CSR_ALL_E	0x00000f80
+#define FPU_CSR_INV_E	0x00000800
+#define FPU_CSR_DIV_E	0x00000400
+#define FPU_CSR_OVF_E	0x00000200
+#define FPU_CSR_UDF_E	0x00000100
+#define FPU_CSR_INE_E	0x00000080
+
+#define FPU_CSR_ALL_S	0x0000007c
+#define FPU_CSR_INV_S	0x00000040
+#define FPU_CSR_DIV_S	0x00000020
+#define FPU_CSR_OVF_S	0x00000010
+#define FPU_CSR_UDF_S	0x00000008
+#define FPU_CSR_INE_S	0x00000004
+
+/* Bits 0 and 1 of FPU Status Register specify the rounding mode */
+#define FPU_CSR_RM	0x00000003
+#define FPU_CSR_RN	0x0	/* nearest */
+#define FPU_CSR_RZ	0x1	/* towards zero */
+#define FPU_CSR_RU	0x2	/* towards +Infinity */
+#define FPU_CSR_RD	0x3	/* towards -Infinity */
+
+
 #ifndef __ASSEMBLY__
 
 /*
