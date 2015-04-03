Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:29:38 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025284AbbDCWZSuQiD3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:18 +0200
Date:   Fri, 3 Apr 2015 23:25:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 21/48] MIPS: math-emu: Update sNaN quieting handlers
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030344350.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46738
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

Commit fdffbafb [Lots of FPU bug fixes from Kjeld Borch Egevang.] 
replaced the two single `ieee754sp_nanxcpt' and `ieee754dp_nanxcpt' 
places, where sNaN quieting used to happen for single and double 
floating-point operations respectively, with individual qNaN 
instantiations across all the call sites instead.  It also made most of 
these two functions dead code as where called on a qNaN they return 
right away.

To revert the damage and make sNaN quieting uniform again first rewrite 
`ieee754sp_nanxcpt' and `ieee754dp_nanxcpt' to do the same quieting all 
the call sites do, that is return the default qNaN encoding for all 
input sNaN values; never propagate any sNaN payload bits from its 
trailing significand field.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-nanxcpt-snan.diff
Index: linux/arch/mips/math-emu/ieee754dp.c
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754dp.c	2015-04-02 20:18:51.033516000 +0100
+++ linux/arch/mips/math-emu/ieee754dp.c	2015-04-02 20:27:54.976193000 +0100
@@ -49,14 +49,9 @@ union ieee754dp __cold ieee754dp_nanxcpt
 	if (!ieee754dp_issnan(r))	/* QNAN does not cause invalid op !! */
 		return r;
 
-	if (!ieee754_setandtestcx(IEEE754_INVALID_OPERATION)) {
-		/* not enabled convert to a quiet NaN */
-		DPMANT(r) &= (~DP_MBIT(DP_FBITS-1));
-		if (ieee754dp_isnan(r))
-			return r;
-		else
-			return ieee754dp_indef();
-	}
+	/* If not enabled convert to a quiet NaN.  */
+	if (!ieee754_setandtestcx(IEEE754_INVALID_OPERATION))
+		return ieee754dp_indef();
 
 	return r;
 }
Index: linux/arch/mips/math-emu/ieee754sp.c
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754sp.c	2015-04-02 20:18:51.036515000 +0100
+++ linux/arch/mips/math-emu/ieee754sp.c	2015-04-02 20:27:54.979190000 +0100
@@ -49,14 +49,9 @@ union ieee754sp __cold ieee754sp_nanxcpt
 	if (!ieee754sp_issnan(r))	/* QNAN does not cause invalid op !! */
 		return r;
 
-	if (!ieee754_setandtestcx(IEEE754_INVALID_OPERATION)) {
-		/* not enabled convert to a quiet NaN */
-		SPMANT(r) &= (~SP_MBIT(SP_FBITS-1));
-		if (ieee754sp_isnan(r))
-			return r;
-		else
-			return ieee754sp_indef();
-	}
+	/* If not enabled convert to a quiet NaN.  */
+	if (!ieee754_setandtestcx(IEEE754_INVALID_OPERATION))
+		return ieee754sp_indef();
 
 	return r;
 }
