Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:31:10 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025289AbbDCWZnLfEHI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:43 +0200
Date:   Fri, 3 Apr 2015 23:25:43 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 26/48] MIPS: math-emu: Remove redundant code from NaN
 comparison
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030533480.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46743
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

Remove a redundant call to `ieee754_setandtestcx' in `ieee754sp_cmp' and 
`ieee754dp_cmp'.  The IEEE 754 exception requested will have already 
been set by a call to `ieee754_setcx' immediately above, because `sig' 
has to be non-zero to reach here, and the comparison result returned 
will be 0 regardless of the result from the call.  Simplify the return 
expression remaining.  All this reducing the size of code by 16 and 12 
instructions or 64 and 48 bytes respectively.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-cmp.diff
Index: linux/arch/mips/math-emu/dp_cmp.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_cmp.c	2015-04-03 13:23:31.663867000 +0100
+++ linux/arch/mips/math-emu/dp_cmp.c	2015-04-03 13:23:37.279924000 +0100
@@ -39,13 +39,7 @@ int ieee754dp_cmp(union ieee754dp x, uni
 		if (sig ||
 		    xc == IEEE754_CLASS_SNAN || yc == IEEE754_CLASS_SNAN)
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
-		if (cmp & IEEE754_CUN)
-			return 1;
-		if (cmp & (IEEE754_CLT | IEEE754_CGT)) {
-			if (sig && ieee754_setandtestcx(IEEE754_INVALID_OPERATION))
-				return 0;
-		}
-		return 0;
+		return (cmp & IEEE754_CUN) != 0;
 	} else {
 		vx = x.bits;
 		vy = y.bits;
Index: linux/arch/mips/math-emu/sp_cmp.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_cmp.c	2015-04-03 13:23:31.680870000 +0100
+++ linux/arch/mips/math-emu/sp_cmp.c	2015-04-03 13:23:37.281921000 +0100
@@ -39,13 +39,7 @@ int ieee754sp_cmp(union ieee754sp x, uni
 		if (sig ||
 		    xc == IEEE754_CLASS_SNAN || yc == IEEE754_CLASS_SNAN)
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
-		if (cmp & IEEE754_CUN)
-			return 1;
-		if (cmp & (IEEE754_CLT | IEEE754_CGT)) {
-			if (sig && ieee754_setandtestcx(IEEE754_INVALID_OPERATION))
-				return 0;
-		}
-		return 0;
+		return (cmp & IEEE754_CUN) != 0;
 	} else {
 		vx = x.bits;
 		vy = y.bits;
