Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:33:47 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025304AbbDCW0oPxCs6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:26:44 +0200
Date:   Fri, 3 Apr 2015 23:26:44 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 35/48] MIPS: Correct MIPS I FP context layout
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031711120.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46752
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

Implement the correct ordering of individual floating-point registers 
within double-precision register pairs for the MIPS I FP context, as 
required by our FP emulation code and expected by userland talking via 
ptrace(2).  Use L.D and S.D assembly macros that do the right thing like 
LDC1 and SDC1 from MIPS II up, avoiding the need to mess up with 
endianness conditionals.

This in particular fixes the handling of denormals and NaN generation in 
Unimplemented Operation emulation traps.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-isa1-fp-context.patch
Index: linux/arch/mips/include/asm/asmmacro-32.h
===================================================================
--- linux.orig/arch/mips/include/asm/asmmacro-32.h	2015-04-02 20:18:49.474495000 +0100
+++ linux/arch/mips/include/asm/asmmacro-32.h	2015-04-02 20:27:57.304220000 +0100
@@ -16,38 +16,22 @@
 	.set push
 	SET_HARDFLOAT
 	cfc1	\tmp,  fcr31
-	swc1	$f0,  THREAD_FPR0_LS64(\thread)
-	swc1	$f1,  THREAD_FPR1_LS64(\thread)
-	swc1	$f2,  THREAD_FPR2_LS64(\thread)
-	swc1	$f3,  THREAD_FPR3_LS64(\thread)
-	swc1	$f4,  THREAD_FPR4_LS64(\thread)
-	swc1	$f5,  THREAD_FPR5_LS64(\thread)
-	swc1	$f6,  THREAD_FPR6_LS64(\thread)
-	swc1	$f7,  THREAD_FPR7_LS64(\thread)
-	swc1	$f8,  THREAD_FPR8_LS64(\thread)
-	swc1	$f9,  THREAD_FPR9_LS64(\thread)
-	swc1	$f10, THREAD_FPR10_LS64(\thread)
-	swc1	$f11, THREAD_FPR11_LS64(\thread)
-	swc1	$f12, THREAD_FPR12_LS64(\thread)
-	swc1	$f13, THREAD_FPR13_LS64(\thread)
-	swc1	$f14, THREAD_FPR14_LS64(\thread)
-	swc1	$f15, THREAD_FPR15_LS64(\thread)
-	swc1	$f16, THREAD_FPR16_LS64(\thread)
-	swc1	$f17, THREAD_FPR17_LS64(\thread)
-	swc1	$f18, THREAD_FPR18_LS64(\thread)
-	swc1	$f19, THREAD_FPR19_LS64(\thread)
-	swc1	$f20, THREAD_FPR20_LS64(\thread)
-	swc1	$f21, THREAD_FPR21_LS64(\thread)
-	swc1	$f22, THREAD_FPR22_LS64(\thread)
-	swc1	$f23, THREAD_FPR23_LS64(\thread)
-	swc1	$f24, THREAD_FPR24_LS64(\thread)
-	swc1	$f25, THREAD_FPR25_LS64(\thread)
-	swc1	$f26, THREAD_FPR26_LS64(\thread)
-	swc1	$f27, THREAD_FPR27_LS64(\thread)
-	swc1	$f28, THREAD_FPR28_LS64(\thread)
-	swc1	$f29, THREAD_FPR29_LS64(\thread)
-	swc1	$f30, THREAD_FPR30_LS64(\thread)
-	swc1	$f31, THREAD_FPR31_LS64(\thread)
+	s.d	$f0,  THREAD_FPR0_LS64(\thread)
+	s.d	$f2,  THREAD_FPR2_LS64(\thread)
+	s.d	$f4,  THREAD_FPR4_LS64(\thread)
+	s.d	$f6,  THREAD_FPR6_LS64(\thread)
+	s.d	$f8,  THREAD_FPR8_LS64(\thread)
+	s.d	$f10, THREAD_FPR10_LS64(\thread)
+	s.d	$f12, THREAD_FPR12_LS64(\thread)
+	s.d	$f14, THREAD_FPR14_LS64(\thread)
+	s.d	$f16, THREAD_FPR16_LS64(\thread)
+	s.d	$f18, THREAD_FPR18_LS64(\thread)
+	s.d	$f20, THREAD_FPR20_LS64(\thread)
+	s.d	$f22, THREAD_FPR22_LS64(\thread)
+	s.d	$f24, THREAD_FPR24_LS64(\thread)
+	s.d	$f26, THREAD_FPR26_LS64(\thread)
+	s.d	$f28, THREAD_FPR28_LS64(\thread)
+	s.d	$f30, THREAD_FPR30_LS64(\thread)
 	sw	\tmp, THREAD_FCR31(\thread)
 	.set pop
 	.endm
@@ -56,38 +40,22 @@
 	.set push
 	SET_HARDFLOAT
 	lw	\tmp, THREAD_FCR31(\thread)
-	lwc1	$f0,  THREAD_FPR0_LS64(\thread)
-	lwc1	$f1,  THREAD_FPR1_LS64(\thread)
-	lwc1	$f2,  THREAD_FPR2_LS64(\thread)
-	lwc1	$f3,  THREAD_FPR3_LS64(\thread)
-	lwc1	$f4,  THREAD_FPR4_LS64(\thread)
-	lwc1	$f5,  THREAD_FPR5_LS64(\thread)
-	lwc1	$f6,  THREAD_FPR6_LS64(\thread)
-	lwc1	$f7,  THREAD_FPR7_LS64(\thread)
-	lwc1	$f8,  THREAD_FPR8_LS64(\thread)
-	lwc1	$f9,  THREAD_FPR9_LS64(\thread)
-	lwc1	$f10, THREAD_FPR10_LS64(\thread)
-	lwc1	$f11, THREAD_FPR11_LS64(\thread)
-	lwc1	$f12, THREAD_FPR12_LS64(\thread)
-	lwc1	$f13, THREAD_FPR13_LS64(\thread)
-	lwc1	$f14, THREAD_FPR14_LS64(\thread)
-	lwc1	$f15, THREAD_FPR15_LS64(\thread)
-	lwc1	$f16, THREAD_FPR16_LS64(\thread)
-	lwc1	$f17, THREAD_FPR17_LS64(\thread)
-	lwc1	$f18, THREAD_FPR18_LS64(\thread)
-	lwc1	$f19, THREAD_FPR19_LS64(\thread)
-	lwc1	$f20, THREAD_FPR20_LS64(\thread)
-	lwc1	$f21, THREAD_FPR21_LS64(\thread)
-	lwc1	$f22, THREAD_FPR22_LS64(\thread)
-	lwc1	$f23, THREAD_FPR23_LS64(\thread)
-	lwc1	$f24, THREAD_FPR24_LS64(\thread)
-	lwc1	$f25, THREAD_FPR25_LS64(\thread)
-	lwc1	$f26, THREAD_FPR26_LS64(\thread)
-	lwc1	$f27, THREAD_FPR27_LS64(\thread)
-	lwc1	$f28, THREAD_FPR28_LS64(\thread)
-	lwc1	$f29, THREAD_FPR29_LS64(\thread)
-	lwc1	$f30, THREAD_FPR30_LS64(\thread)
-	lwc1	$f31, THREAD_FPR31_LS64(\thread)
+	l.d	$f0,  THREAD_FPR0_LS64(\thread)
+	l.d	$f2,  THREAD_FPR2_LS64(\thread)
+	l.d	$f4,  THREAD_FPR4_LS64(\thread)
+	l.d	$f6,  THREAD_FPR6_LS64(\thread)
+	l.d	$f8,  THREAD_FPR8_LS64(\thread)
+	l.d	$f10, THREAD_FPR10_LS64(\thread)
+	l.d	$f12, THREAD_FPR12_LS64(\thread)
+	l.d	$f14, THREAD_FPR14_LS64(\thread)
+	l.d	$f16, THREAD_FPR16_LS64(\thread)
+	l.d	$f18, THREAD_FPR18_LS64(\thread)
+	l.d	$f20, THREAD_FPR20_LS64(\thread)
+	l.d	$f22, THREAD_FPR22_LS64(\thread)
+	l.d	$f24, THREAD_FPR24_LS64(\thread)
+	l.d	$f26, THREAD_FPR26_LS64(\thread)
+	l.d	$f28, THREAD_FPR28_LS64(\thread)
+	l.d	$f30, THREAD_FPR30_LS64(\thread)
 	ctc1	\tmp, fcr31
 	.set pop
 	.endm
