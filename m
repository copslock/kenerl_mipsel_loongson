Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:37:00 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025311AbbDCW1nyJU2Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:27:43 +0200
Date:   Fri, 3 Apr 2015 23:27:43 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 46/48] MIPS: math-emu: Make ABS.fmt and NEG.fmt arithmetic
 again
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504032201480.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46763
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

The ABS.fmt and NEG.fmt instructions have been specified as arithmetic 
in the MIPS architecture, which in particular implies handling NaN data 
in the usual way with qNaN bit patterns propagated unchanged and sNaN 
bit patterns signalling the usual IEEE 754 Invalid Operation exception 
and quieted by default.

A series of changes applied over time to our implementation:

c5033d78 [MIPS] ieee754[sd]p_neg workaround
cea2be44 MIPS: Fix abs.[sd] and neg.[sd] emulation for NaN operands

has led to the current situation where the sign bit is updated according 
to the operation requested even for NaN inputs.  This is according to 
these commits a workaround so that broken binaries produced by GCC 
disregarding the properties of these instructions have a chance to work.

For sNaN inputs this remains within IEEE Std 754 as the standard leaves 
the choice of output qNaN bit patterns produced under the default 
Invalid Operation exception handling for individual sNaN input bit 
patterns to implementer's discretion, even though it still recommends as 
much NaN input information to be preserved in NaN outputs.

For qNaN inputs however it violates the standard as it requires a qNaN 
input bit patterns to propagate unchanged to output.

This is also unlike real MIPS FPU hardware behaves where sNaN and/or 
qNaN processing has been fully implemented with no Unimplemented 
Operation exception signalled.  Such hardware propagates any input qNaN 
bit pattern unchanged.  It also quiets any input sNaN bit pattern in an 
implementer-specific manner, for example the MIPS 74Kf processor returns 
the default qNaN pattern with the sign bit always clear and the Broadcom 
SB-1 and BMIPS5000 processors propagate the input sNaN bit pattern with 
the sign bit unchanged and the quiet bit first cleared in the trailing 
significand field and then the next lower bit set if clearing the quiet 
bit left the field with no other bit set.

Especially the latter observation indicates the limited usefulness of 
the workaround as it will cover many hardware configurations, but not 
all of them, only making it harder to discover such broken binaries that 
need to be recompiled with GCC told to avoid the use of ABS.fmt and 
NEG.fmt instructions where non-arithmetic semantics is required by the 
algorithm used.

Revert the damage done by the series of changes then, and take the 
opportunity to simplify implementation by calling `ieee754dp_sub' and 
`ieee754dp_add' as required and also the rounding mode set towards -Inf 
temporarily so that the sign of 0 is correctly handled.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-fpe-emu-abs.diff
Index: linux/arch/mips/math-emu/dp_simple.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_simple.c	2015-04-02 20:18:47.633483000 +0100
+++ linux/arch/mips/math-emu/dp_simple.c	2015-04-02 20:27:59.532238000 +0100
@@ -23,44 +23,27 @@
 
 union ieee754dp ieee754dp_neg(union ieee754dp x)
 {
-	COMPXDP;
-
-	EXPLODEXDP;
-	ieee754_clearcx();
-	FLUSHXDP;
-
-	/*
-	 * Invert the sign ALWAYS to prevent an endless recursion on
-	 * pow() in libc.
-	 */
-	/* quick fix up */
-	DPSIGN(x) ^= 1;
-
-	if (xc == IEEE754_CLASS_SNAN) {
-		union ieee754dp y = ieee754dp_indef();
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		DPSIGN(y) = DPSIGN(x);
-		return ieee754dp_nanxcpt(y);
-	}
+	unsigned int oldrm;
+	union ieee754dp y;
 
-	return x;
+	oldrm = ieee754_csr.rm;
+	ieee754_csr.rm = FPU_CSR_RD;
+	y = ieee754dp_sub(ieee754dp_zero(0), x);
+	ieee754_csr.rm = oldrm;
+	return y;
 }
 
 union ieee754dp ieee754dp_abs(union ieee754dp x)
 {
-	COMPXDP;
-
-	EXPLODEXDP;
-	ieee754_clearcx();
-	FLUSHXDP;
-
-	/* Clear sign ALWAYS, irrespective of NaN */
-	DPSIGN(x) = 0;
-
-	if (xc == IEEE754_CLASS_SNAN) {
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754dp_nanxcpt(ieee754dp_indef());
-	}
+	unsigned int oldrm;
+	union ieee754dp y;
 
-	return x;
+	oldrm = ieee754_csr.rm;
+	ieee754_csr.rm = FPU_CSR_RD;
+	if (DPSIGN(x))
+		y = ieee754dp_sub(ieee754dp_zero(0), x);
+	else
+		y = ieee754dp_add(ieee754dp_zero(0), x);
+	ieee754_csr.rm = oldrm;
+	return y;
 }
Index: linux/arch/mips/math-emu/sp_simple.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_simple.c	2015-04-02 20:18:47.637483000 +0100
+++ linux/arch/mips/math-emu/sp_simple.c	2015-04-02 20:27:59.534255000 +0100
@@ -23,44 +23,27 @@
 
 union ieee754sp ieee754sp_neg(union ieee754sp x)
 {
-	COMPXSP;
-
-	EXPLODEXSP;
-	ieee754_clearcx();
-	FLUSHXSP;
-
-	/*
-	 * Invert the sign ALWAYS to prevent an endless recursion on
-	 * pow() in libc.
-	 */
-	/* quick fix up */
-	SPSIGN(x) ^= 1;
-
-	if (xc == IEEE754_CLASS_SNAN) {
-		union ieee754sp y = ieee754sp_indef();
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		SPSIGN(y) = SPSIGN(x);
-		return ieee754sp_nanxcpt(y);
-	}
+	unsigned int oldrm;
+	union ieee754sp y;
 
-	return x;
+	oldrm = ieee754_csr.rm;
+	ieee754_csr.rm = FPU_CSR_RD;
+	y = ieee754sp_sub(ieee754sp_zero(0), x);
+	ieee754_csr.rm = oldrm;
+	return y;
 }
 
 union ieee754sp ieee754sp_abs(union ieee754sp x)
 {
-	COMPXSP;
-
-	EXPLODEXSP;
-	ieee754_clearcx();
-	FLUSHXSP;
-
-	/* Clear sign ALWAYS, irrespective of NaN */
-	SPSIGN(x) = 0;
-
-	if (xc == IEEE754_CLASS_SNAN) {
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754sp_nanxcpt(ieee754sp_indef());
-	}
+	unsigned int oldrm;
+	union ieee754sp y;
 
-	return x;
+	oldrm = ieee754_csr.rm;
+	ieee754_csr.rm = FPU_CSR_RD;
+	if (SPSIGN(x))
+		y = ieee754sp_sub(ieee754sp_zero(0), x);
+	else
+		y = ieee754sp_add(ieee754sp_zero(0), x);
+	ieee754_csr.rm = oldrm;
+	return y;
 }
