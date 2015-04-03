Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:25:16 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025252AbbDCWYB63DKC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:24:01 +0200
Date:   Fri, 3 Apr 2015 23:24:01 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 06/48] MIPS: ieee754.h: Correct comments for special values
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030151270.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46723
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

IEEE754_SPCVAL_NMIN denotes the index into the special value array where 
the closest to zero negative normal number expressible is stored.  
Similarly IEEE754_SPCVAL_NMIND denotes such index for the closest to 
zero negative subnormal number expressible.  Make comments match that.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-ieee754-comment-fix.diff
Index: linux/arch/mips/math-emu/ieee754.h
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754.h	2015-04-02 20:18:52.566531000 +0100
+++ linux/arch/mips/math-emu/ieee754.h	2015-04-02 20:27:52.428168000 +0100
@@ -269,9 +269,9 @@ union ieee754dp ieee754dp_dump(char *s, 
 #define IEEE754_SPCVAL_PMAX	9	/* +max norm */
 #define IEEE754_SPCVAL_NMAX	10	/* -max norm */
 #define IEEE754_SPCVAL_PMIN	11	/* +min norm */
-#define IEEE754_SPCVAL_NMIN	12	/* +min norm */
+#define IEEE754_SPCVAL_NMIN	12	/* -min norm */
 #define IEEE754_SPCVAL_PMIND	13	/* +min denorm */
-#define IEEE754_SPCVAL_NMIND	14	/* +min denorm */
+#define IEEE754_SPCVAL_NMIND	14	/* -min denorm */
 #define IEEE754_SPCVAL_P1E31	15	/* + 1.0e31 */
 #define IEEE754_SPCVAL_P1E63	16	/* + 1.0e63 */
 
