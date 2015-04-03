Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:31:45 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025291AbbDCWZwxrJ9L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:52 +0200
Date:   Fri, 3 Apr 2015 23:25:52 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 28/48] MIPS: math-emu: Optimise qNaN handling in
 `ieee754sp_fdp'
Message-ID: <alpine.LFD.2.11.1504031557450.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46745
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

Rewrite qNaN handling in `ieee754sp_fdp' using the `ieee754_class_nan' 
helper recently added, removing the external call to `ieee754sp_isnan' 
and reducing the size of code by 16 instructions or 64 bytes.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-sp-fdp.diff
Index: linux/arch/mips/math-emu/sp_fdp.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_fdp.c	2015-04-02 20:27:55.198207000 +0100
+++ linux/arch/mips/math-emu/sp_fdp.c	2015-04-02 20:27:55.835200000 +0100
@@ -30,10 +30,11 @@ static inline union ieee754sp ieee754sp_
 
 union ieee754sp ieee754sp_fdp(union ieee754dp x)
 {
+	union ieee754sp y;
 	u32 rm;
 
 	COMPXDP;
-	union ieee754sp nan;
+	COMPYSP;
 
 	EXPLODEXDP;
 
@@ -46,10 +47,11 @@ union ieee754sp ieee754sp_fdp(union ieee
 		return ieee754sp_nanxcpt(ieee754sp_nan_fdp(xs, xm));
 
 	case IEEE754_CLASS_QNAN:
-		nan = ieee754sp_nan_fdp(xs, xm);
-		if (!ieee754sp_isnan(nan))
-			nan = ieee754sp_indef();
-		return nan;
+		y = ieee754sp_nan_fdp(xs, xm);
+		EXPLODEYSP;
+		if (!ieee754_class_nan(yc))
+			y = ieee754sp_indef();
+		return y;
 
 	case IEEE754_CLASS_INF:
 		return ieee754sp_inf(xs);
