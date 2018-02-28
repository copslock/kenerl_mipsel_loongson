Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 17:08:37 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53474 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992827AbeB1QIYelVuz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 17:08:24 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yt-0006XR-56; Wed, 28 Feb 2018 15:22:31 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-0008WP-9P; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.942966468@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 099/254] MIPS: math-emu: Define IEEE 754-2008 feature
 control bits
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit f1f3b7ebac08161761c352fd070cfa07b7b94c54 upstream.

Define IEEE 754-2008 feature control bits: FIR.HAS2008, FCSR.ABS2008 and
FCSR.NAN2008, and update the `_ieee754_csr' structure accordingly.

For completeness define FIR.UFRP too.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9709/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16: In cop1Emulate(), keep converting the rounding mode]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -136,10 +136,13 @@
 #define FPU_CSR_COND7	0x80000000	/* $fcc7 */
 
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
@@ -687,6 +690,8 @@
 #define MIPS_FPIR_W		(_ULCAST_(1) << 20)
 #define MIPS_FPIR_L		(_ULCAST_(1) << 21)
 #define MIPS_FPIR_F64		(_ULCAST_(1) << 22)
+#define MIPS_FPIR_HAS2008	(_ULCAST_(1) << 23)
+#define MIPS_FPIR_UFRP		(_ULCAST_(1) << 28)
 
 /*
  * Bits in the MIPS32 Memory Segmentation registers.
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -929,10 +929,12 @@ emul:
 					 MIPSInst_RT(ir), value);
 
 				/*
-				 * Don't write reserved bits,
+				 * Don't write unsupported bits,
 				 * and convert to ieee library modes
 				 */
-				ctx->fcr31 = (value & ~(FPU_CSR_RSVD | FPU_CSR_RM)) |
+				ctx->fcr31 = (value &
+					      ~(FPU_CSR_RSVD | FPU_CSR_ABS2008 |
+						FPU_CSR_NAN2008 | FPU_CSR_RM)) |
 					     modeindex(value);
 			}
 			if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
--- a/arch/mips/math-emu/ieee754.h
+++ b/arch/mips/math-emu/ieee754.h
@@ -195,15 +195,17 @@ static inline int ieee754dp_ge(union iee
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
 
