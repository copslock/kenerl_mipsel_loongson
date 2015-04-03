Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:30:13 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025285AbbDCWZa0sr-a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:30 +0200
Date:   Fri, 3 Apr 2015 23:25:30 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 23/48] MIPS: math-emu: Don't pass qNaNs through quieting
 handlers
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030506300.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46740
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

Don't call the `ieee754sp_nanxcpt' and `ieee754dp_nanxcpt' sNaN quieting 
handlers for a qNaN supplied to floating-point format conversions or 
SQRT.S/SQRT.D instructions, or for a qNaN produced out of a negative 
operand supplied to SQRT.S/SQRT.D instructions.  Return the qNaN right 
away in these cases.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-nanxcpt-qnan.diff
Index: linux/arch/mips/math-emu/dp_fsp.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_fsp.c	2015-04-03 04:57:50.206062000 +0100
+++ linux/arch/mips/math-emu/dp_fsp.c	2015-04-03 04:58:06.696244000 +0100
@@ -44,7 +44,7 @@ union ieee754dp ieee754dp_fsp(union ieee
 		return ieee754dp_nanxcpt(ieee754dp_indef());
 
 	case IEEE754_CLASS_QNAN:
-		return ieee754dp_nanxcpt(ieee754dp_nan_fsp(xs, xm));
+		return ieee754dp_nan_fsp(xs, xm);
 
 	case IEEE754_CLASS_INF:
 		return ieee754dp_inf(xs);
Index: linux/arch/mips/math-emu/dp_sqrt.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_sqrt.c	2015-04-03 04:57:13.570713000 +0100
+++ linux/arch/mips/math-emu/dp_sqrt.c	2015-04-03 04:58:06.699229000 +0100
@@ -44,7 +44,7 @@ union ieee754dp ieee754dp_sqrt(union iee
 	switch (xc) {
 	case IEEE754_CLASS_QNAN:
 		/* sqrt(Nan) = Nan */
-		return ieee754dp_nanxcpt(x);
+		return x;
 
 	case IEEE754_CLASS_SNAN:
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
@@ -58,7 +58,7 @@ union ieee754dp ieee754dp_sqrt(union iee
 		if (xs) {
 			/* sqrt(-Inf) = Nan */
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
-			return ieee754dp_nanxcpt(ieee754dp_indef());
+			return ieee754dp_indef();
 		}
 		/* sqrt(+Inf) = Inf */
 		return x;
@@ -71,7 +71,7 @@ union ieee754dp ieee754dp_sqrt(union iee
 		if (xs) {
 			/* sqrt(-x) = Nan */
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
-			return ieee754dp_nanxcpt(ieee754dp_indef());
+			return ieee754dp_indef();
 		}
 		break;
 	}
Index: linux/arch/mips/math-emu/sp_fdp.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_fdp.c	2015-04-03 04:57:50.208062000 +0100
+++ linux/arch/mips/math-emu/sp_fdp.c	2015-04-03 04:58:06.701235000 +0100
@@ -50,7 +50,7 @@ union ieee754sp ieee754sp_fdp(union ieee
 		nan = ieee754sp_nan_fdp(xs, xm);
 		if (!ieee754sp_isnan(nan))
 			nan = ieee754sp_indef();
-		return ieee754sp_nanxcpt(nan);
+		return nan;
 
 	case IEEE754_CLASS_INF:
 		return ieee754sp_inf(xs);
Index: linux/arch/mips/math-emu/sp_sqrt.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_sqrt.c	2015-04-03 04:57:13.582698000 +0100
+++ linux/arch/mips/math-emu/sp_sqrt.c	2015-04-03 04:58:06.703246000 +0100
@@ -37,7 +37,7 @@ union ieee754sp ieee754sp_sqrt(union iee
 	switch (xc) {
 	case IEEE754_CLASS_QNAN:
 		/* sqrt(Nan) = Nan */
-		return ieee754sp_nanxcpt(x);
+		return x;
 
 	case IEEE754_CLASS_SNAN:
 		ieee754_setcx(IEEE754_INVALID_OPERATION);
@@ -51,7 +51,7 @@ union ieee754sp ieee754sp_sqrt(union iee
 		if (xs) {
 			/* sqrt(-Inf) = Nan */
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
-			return ieee754sp_nanxcpt(ieee754sp_indef());
+			return ieee754sp_indef();
 		}
 		/* sqrt(+Inf) = Inf */
 		return x;
@@ -61,7 +61,7 @@ union ieee754sp ieee754sp_sqrt(union iee
 		if (xs) {
 			/* sqrt(-x) = Nan */
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
-			return ieee754sp_nanxcpt(ieee754sp_indef());
+			return ieee754sp_indef();
 		}
 		break;
 	}
