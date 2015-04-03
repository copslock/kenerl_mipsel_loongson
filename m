Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:30:49 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025288AbbDCWZi3ydYi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:38 +0200
Date:   Fri, 3 Apr 2015 23:25:38 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 25/48] MIPS: math-emu: Optimise NaN handling in comparisons
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031344150.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46742
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

We have the input operands already classified in `ieee754sp_cmp' and 
`ieee754dp_cmp' comparison operations, so use the class obtained to tell 
NaNs and numbers apart rather than classifying inputs again for this 
purpose, reducing the size of code by 24 and 40 instructions or 96 and 
160 bytes respectively.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-cmp-nan.diff
Index: linux/arch/mips/math-emu/dp_cmp.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_cmp.c	2015-04-03 13:23:28.348835000 +0100
+++ linux/arch/mips/math-emu/dp_cmp.c	2015-04-03 13:23:31.663867000 +0100
@@ -35,7 +35,7 @@ int ieee754dp_cmp(union ieee754dp x, uni
 	FLUSHYDP;
 	ieee754_clearcx();	/* Even clear inexact flag here */
 
-	if (ieee754dp_isnan(x) || ieee754dp_isnan(y)) {
+	if (ieee754_class_nan(xc) || ieee754_class_nan(yc)) {
 		if (sig ||
 		    xc == IEEE754_CLASS_SNAN || yc == IEEE754_CLASS_SNAN)
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
Index: linux/arch/mips/math-emu/ieee754dp.c
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754dp.c	2015-04-03 13:23:28.349836000 +0100
+++ linux/arch/mips/math-emu/ieee754dp.c	2015-04-03 13:23:31.665869000 +0100
@@ -32,7 +32,7 @@ int ieee754dp_class(union ieee754dp x)
 
 int ieee754dp_isnan(union ieee754dp x)
 {
-	return ieee754dp_class(x) >= IEEE754_CLASS_SNAN;
+	return ieee754_class_nan(ieee754dp_class(x));
 }
 
 static inline int ieee754dp_issnan(union ieee754dp x)
Index: linux/arch/mips/math-emu/ieee754int.h
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754int.h	2015-04-03 13:23:28.350839000 +0100
+++ linux/arch/mips/math-emu/ieee754int.h	2015-04-03 13:23:31.667874000 +0100
@@ -44,6 +44,11 @@ static inline int ieee754_setandtestcx(c
 	return ieee754_csr.mx & x;
 }
 
+static inline int ieee754_class_nan(int xc)
+{
+	return xc >= IEEE754_CLASS_SNAN;
+}
+
 #define COMPXSP \
 	unsigned xm; int xe; int xs __maybe_unused; int xc
 
Index: linux/arch/mips/math-emu/ieee754sp.c
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754sp.c	2015-04-03 13:23:28.352832000 +0100
+++ linux/arch/mips/math-emu/ieee754sp.c	2015-04-03 13:23:31.678870000 +0100
@@ -32,7 +32,7 @@ int ieee754sp_class(union ieee754sp x)
 
 int ieee754sp_isnan(union ieee754sp x)
 {
-	return ieee754sp_class(x) >= IEEE754_CLASS_SNAN;
+	return ieee754_class_nan(ieee754sp_class(x));
 }
 
 static inline int ieee754sp_issnan(union ieee754sp x)
Index: linux/arch/mips/math-emu/sp_cmp.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_cmp.c	2015-04-03 13:23:28.354835000 +0100
+++ linux/arch/mips/math-emu/sp_cmp.c	2015-04-03 13:23:31.680870000 +0100
@@ -35,7 +35,7 @@ int ieee754sp_cmp(union ieee754sp x, uni
 	FLUSHYSP;
 	ieee754_clearcx();	/* Even clear inexact flag here */
 
-	if (ieee754sp_isnan(x) || ieee754sp_isnan(y)) {
+	if (ieee754_class_nan(xc) || ieee754_class_nan(yc)) {
 		if (sig ||
 		    xc == IEEE754_CLASS_SNAN || yc == IEEE754_CLASS_SNAN)
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
