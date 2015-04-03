Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:25:33 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025254AbbDCWYJsqnU- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:24:09 +0200
Date:   Fri, 3 Apr 2015 23:24:09 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 07/48] MIPS: ieee754.h: Supplement comments for special
 values
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030204250.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46724
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

Add the remaining missing comments for IEEE 754 special value array 
indices.  Reindent macro definitions for consistency.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-ieee754-comment.diff
Index: linux/arch/mips/math-emu/ieee754.h
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754.h	2015-04-02 20:27:52.428168000 +0100
+++ linux/arch/mips/math-emu/ieee754.h	2015-04-02 20:27:52.599179000 +0100
@@ -257,23 +257,23 @@ static inline int ieee754_sxtest(unsigne
 union ieee754sp ieee754sp_dump(char *s, union ieee754sp x);
 union ieee754dp ieee754dp_dump(char *s, union ieee754dp x);
 
-#define IEEE754_SPCVAL_PZERO	0
-#define IEEE754_SPCVAL_NZERO	1
-#define IEEE754_SPCVAL_PONE	2
-#define IEEE754_SPCVAL_NONE	3
-#define IEEE754_SPCVAL_PTEN	4
-#define IEEE754_SPCVAL_NTEN	5
-#define IEEE754_SPCVAL_PINFINITY	6
-#define IEEE754_SPCVAL_NINFINITY	7
-#define IEEE754_SPCVAL_INDEF	8
-#define IEEE754_SPCVAL_PMAX	9	/* +max norm */
-#define IEEE754_SPCVAL_NMAX	10	/* -max norm */
-#define IEEE754_SPCVAL_PMIN	11	/* +min norm */
-#define IEEE754_SPCVAL_NMIN	12	/* -min norm */
-#define IEEE754_SPCVAL_PMIND	13	/* +min denorm */
-#define IEEE754_SPCVAL_NMIND	14	/* -min denorm */
-#define IEEE754_SPCVAL_P1E31	15	/* + 1.0e31 */
-#define IEEE754_SPCVAL_P1E63	16	/* + 1.0e63 */
+#define IEEE754_SPCVAL_PZERO		0	/* +0.0 */
+#define IEEE754_SPCVAL_NZERO		1	/* -0.0 */
+#define IEEE754_SPCVAL_PONE		2	/* +1.0 */
+#define IEEE754_SPCVAL_NONE		3	/* -1.0 */
+#define IEEE754_SPCVAL_PTEN		4	/* +10.0 */
+#define IEEE754_SPCVAL_NTEN		5	/* -10.0 */
+#define IEEE754_SPCVAL_PINFINITY	6	/* +inf */
+#define IEEE754_SPCVAL_NINFINITY	7	/* -inf */
+#define IEEE754_SPCVAL_INDEF		8	/* quiet NaN */
+#define IEEE754_SPCVAL_PMAX		9	/* +max norm */
+#define IEEE754_SPCVAL_NMAX		10	/* -max norm */
+#define IEEE754_SPCVAL_PMIN		11	/* +min norm */
+#define IEEE754_SPCVAL_NMIN		12	/* -min norm */
+#define IEEE754_SPCVAL_PMIND		13	/* +min denorm */
+#define IEEE754_SPCVAL_NMIND		14	/* -min denorm */
+#define IEEE754_SPCVAL_P1E31		15	/* + 1.0e31 */
+#define IEEE754_SPCVAL_P1E63		16	/* + 1.0e63 */
 
 extern const union ieee754dp __ieee754dp_spcvals[];
 extern const union ieee754sp __ieee754sp_spcvals[];
