Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:31:29 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025290AbbDCWZsI2Vbx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:48 +0200
Date:   Fri, 3 Apr 2015 23:25:48 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 27/48] MIPS: math-emu: Remove dead comparison helpers
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031551130.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46744
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

None of the comparison helpers in ieee754.h is used, remove them.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-cmp-helper.diff
Index: linux/arch/mips/math-emu/ieee754.h
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754.h	2015-04-03 12:38:50.000000000 +0100
+++ linux/arch/mips/math-emu/ieee754.h	2015-04-03 13:42:52.928882000 +0100
@@ -126,71 +126,6 @@ enum {
 #define IEEE754_CGT	0x04
 #define IEEE754_CUN	0x08
 
-/* "normal" comparisons
-*/
-static inline int ieee754sp_eq(union ieee754sp x, union ieee754sp y)
-{
-	return ieee754sp_cmp(x, y, IEEE754_CEQ, 0);
-}
-
-static inline int ieee754sp_ne(union ieee754sp x, union ieee754sp y)
-{
-	return ieee754sp_cmp(x, y,
-			     IEEE754_CLT | IEEE754_CGT | IEEE754_CUN, 0);
-}
-
-static inline int ieee754sp_lt(union ieee754sp x, union ieee754sp y)
-{
-	return ieee754sp_cmp(x, y, IEEE754_CLT, 0);
-}
-
-static inline int ieee754sp_le(union ieee754sp x, union ieee754sp y)
-{
-	return ieee754sp_cmp(x, y, IEEE754_CLT | IEEE754_CEQ, 0);
-}
-
-static inline int ieee754sp_gt(union ieee754sp x, union ieee754sp y)
-{
-	return ieee754sp_cmp(x, y, IEEE754_CGT, 0);
-}
-
-
-static inline int ieee754sp_ge(union ieee754sp x, union ieee754sp y)
-{
-	return ieee754sp_cmp(x, y, IEEE754_CGT | IEEE754_CEQ, 0);
-}
-
-static inline int ieee754dp_eq(union ieee754dp x, union ieee754dp y)
-{
-	return ieee754dp_cmp(x, y, IEEE754_CEQ, 0);
-}
-
-static inline int ieee754dp_ne(union ieee754dp x, union ieee754dp y)
-{
-	return ieee754dp_cmp(x, y,
-			     IEEE754_CLT | IEEE754_CGT | IEEE754_CUN, 0);
-}
-
-static inline int ieee754dp_lt(union ieee754dp x, union ieee754dp y)
-{
-	return ieee754dp_cmp(x, y, IEEE754_CLT, 0);
-}
-
-static inline int ieee754dp_le(union ieee754dp x, union ieee754dp y)
-{
-	return ieee754dp_cmp(x, y, IEEE754_CLT | IEEE754_CEQ, 0);
-}
-
-static inline int ieee754dp_gt(union ieee754dp x, union ieee754dp y)
-{
-	return ieee754dp_cmp(x, y, IEEE754_CGT, 0);
-}
-
-static inline int ieee754dp_ge(union ieee754dp x, union ieee754dp y)
-{
-	return ieee754dp_cmp(x, y, IEEE754_CGT | IEEE754_CEQ, 0);
-}
-
 /*
  * The control status register
  */
