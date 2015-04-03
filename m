Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:26:58 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025263AbbDCWYfCRLAc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:24:35 +0200
Date:   Fri, 3 Apr 2015 23:24:35 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 12/48] MIPS: math-emu: Fix oversize lines in comparisons
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031329520.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46729
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
Ralf,

 There's another line going past 79 columns in these functions, it'll be 
removed altogether with a later functional change.

  Maciej

linux-mips-emu-cmp-indent.diff
Index: linux/arch/mips/math-emu/dp_cmp.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_cmp.c	2015-04-03 12:57:39.280529000 +0100
+++ linux/arch/mips/math-emu/dp_cmp.c	2015-04-03 12:57:45.552589000 +0100
@@ -36,7 +36,8 @@ int ieee754dp_cmp(union ieee754dp x, uni
 	ieee754_clearcx();	/* Even clear inexact flag here */
 
 	if (ieee754dp_isnan(x) || ieee754dp_isnan(y)) {
-		if (sig || xc == IEEE754_CLASS_SNAN || yc == IEEE754_CLASS_SNAN)
+		if (sig ||
+		    xc == IEEE754_CLASS_SNAN || yc == IEEE754_CLASS_SNAN)
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
 		if (cmp & IEEE754_CUN)
 			return 1;
Index: linux/arch/mips/math-emu/sp_cmp.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_cmp.c	2015-04-03 12:57:39.282535000 +0100
+++ linux/arch/mips/math-emu/sp_cmp.c	2015-04-03 12:57:45.554593000 +0100
@@ -36,7 +36,8 @@ int ieee754sp_cmp(union ieee754sp x, uni
 	ieee754_clearcx();	/* Even clear inexact flag here */
 
 	if (ieee754sp_isnan(x) || ieee754sp_isnan(y)) {
-		if (sig || xc == IEEE754_CLASS_SNAN || yc == IEEE754_CLASS_SNAN)
+		if (sig ||
+		    xc == IEEE754_CLASS_SNAN || yc == IEEE754_CLASS_SNAN)
 			ieee754_setcx(IEEE754_INVALID_OPERATION);
 		if (cmp & IEEE754_CUN)
 			return 1;
