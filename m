Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:29:57 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025286AbbDCWZXljGvL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:23 +0200
Date:   Fri, 3 Apr 2015 23:25:23 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 22/48] MIPS: math-emu: Factor out NaN FP format conversions
Message-ID: <alpine.LFD.2.11.1504030500510.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46739
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

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-convert-qnan.diff
Index: linux/arch/mips/math-emu/dp_fsp.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_fsp.c	2015-04-03 04:57:13.567703000 +0100
+++ linux/arch/mips/math-emu/dp_fsp.c	2015-04-03 04:57:50.206062000 +0100
@@ -22,6 +22,12 @@
 #include "ieee754sp.h"
 #include "ieee754dp.h"
 
+static inline union ieee754dp ieee754dp_nan_fsp(int xs, u64 xm)
+{
+	return builddp(xs, DP_EMAX + 1 + DP_EBIAS,
+		       xm << (DP_FBITS - SP_FBITS));
+}
+
 union ieee754dp ieee754dp_fsp(union ieee754sp x)
 {
 	COMPXSP;
@@ -38,11 +44,8 @@ union ieee754dp ieee754dp_fsp(union ieee
 		return ieee754dp_nanxcpt(ieee754dp_indef());
 
 	case IEEE754_CLASS_QNAN:
-		return ieee754dp_nanxcpt(builddp(xs,
-						 DP_EMAX + 1 + DP_EBIAS,
-						 ((u64) xm
-						  << (DP_FBITS -
-						      SP_FBITS))));
+		return ieee754dp_nanxcpt(ieee754dp_nan_fsp(xs, xm));
+
 	case IEEE754_CLASS_INF:
 		return ieee754dp_inf(xs);
 
Index: linux/arch/mips/math-emu/sp_fdp.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_fdp.c	2015-04-03 04:57:13.579699000 +0100
+++ linux/arch/mips/math-emu/sp_fdp.c	2015-04-03 04:57:50.208062000 +0100
@@ -22,6 +22,12 @@
 #include "ieee754sp.h"
 #include "ieee754dp.h"
 
+static inline union ieee754sp ieee754sp_nan_fdp(int xs, u64 xm)
+{
+	return buildsp(xs, SP_EMAX + 1 + SP_EBIAS,
+		       xm >> (DP_FBITS - SP_FBITS));
+}
+
 union ieee754sp ieee754sp_fdp(union ieee754dp x)
 {
 	u32 rm;
@@ -41,8 +47,7 @@ union ieee754sp ieee754sp_fdp(union ieee
 		return ieee754sp_nanxcpt(ieee754sp_indef());
 
 	case IEEE754_CLASS_QNAN:
-		nan = buildsp(xs, SP_EMAX + 1 + SP_EBIAS, (u32)
-				(xm >> (DP_FBITS - SP_FBITS)));
+		nan = ieee754sp_nan_fdp(xs, xm);
 		if (!ieee754sp_isnan(nan))
 			nan = ieee754sp_indef();
 		return ieee754sp_nanxcpt(nan);
