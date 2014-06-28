Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2014 00:12:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50311 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859960AbaF1WM42yUN0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jun 2014 00:12:56 +0200
Date:   Sat, 28 Jun 2014 23:12:56 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Eunbong Song <eunb.song@samsung.com>,
        David Rientjes <rientjes@google.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: math-emu: Avoid anonymous union members
Message-ID: <alpine.LFD.2.11.1406282239230.15455@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40910
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

Commit 49548b09e0fa9fddb64e3cd47266193e36b73144 [MIPS: math-emu: Cleanup 
definition of structs describe sp/dp floats.] introduced a regression for 
pre-4.7 GCC versions that apparently have issues with static initialisers 
setting anonymous struct/union members, even though such members have been 
supported by GCC in other uses for a little bit longer.

This has been figured out by Al Viro and documented in commit 
05064084e82d057f8d74590c51581650e060fbb8 [fix __swap_writepage() compile 
failure on old gcc versions] (thanks Al!).

The regression manifests itself by a load of compilation errors like:

arch/mips/math-emu/ieee754.c:45: error: unknown field 'sign' specified in initializer
arch/mips/math-emu/ieee754.c:45: warning: missing braces around initializer
arch/mips/math-emu/ieee754.c:45: warning: (near initialization for '__ieee754dp_spcvals[0].<anonymous>')
arch/mips/math-emu/ieee754.c:45: error: unknown field 'bexp' specified in initializer
arch/mips/math-emu/ieee754.c:45: warning: excess elements in union initializer
arch/mips/math-emu/ieee754.c:45: warning: (near initialization for '__ieee754dp_spcvals[0]')
arch/mips/math-emu/ieee754.c:45: error: unknown field 'mant' specified in initializer
arch/mips/math-emu/ieee754.c:45: warning: excess elements in union initializer
arch/mips/math-emu/ieee754.c:45: warning: (near initialization for '__ieee754dp_spcvals[0]')

-- and so on, and so on.

This change gives a name back to the anonymous union members and reverts 
parts of the problematic commit while retaining what I believe were the 
good parts of the cleanup.  I concluded a workaround such as one made by 
Al in his commit is infeasible in this context, there's simply too much 
static initialisation across math-emu.

It is worth noting here that we still in principle support GCC versions 
back to 3.2:

$ grep 'Gnu C' Documentation/Changes
o  Gnu C                  3.2                     # gcc --version
$ 

and I think it makes sense to keep this support where feasible as I think 
from the perspective of the Linux kernel it is better if developers' time 
is spent on the kernel itself rather than on sorting out GCC versions.

These anonymous struct/union members are a semi-standard language 
extension BTW, citing from a recent version of the GCC manual:

--------------------------------------------------------------------------
6 Extensions to the C Language Family
*************************************

GNU C provides several language features not found in ISO standard C.
(The `-pedantic' option directs GCC to print a warning message if any
of these features is used.)  To test for the availability of these
features in conditional compilation, check for a predefined macro
`__GNUC__', which is always defined under GCC.

6.59 Unnamed struct/union fields within structs/unions
======================================================

As permitted by ISO C11 and for compatibility with other compilers, GCC
allows you to define a structure or union that contains, as fields,
structures and unions without names.
--------------------------------------------------------------------------

-- note the term "permitted" rather than "required".

We do make use of a few GCC language extensions, most notably inline 
assembly, however in this case we merely save a couple of characters here 
and there and this is IMO not worth breaking people's development 
environments.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-anon-ieee754.patch
Index: linux-20140623-4maxp64/arch/mips/math-emu/dp_sqrt.c
===================================================================
--- linux-20140623-4maxp64.orig/arch/mips/math-emu/dp_sqrt.c
+++ linux-20140623-4maxp64/arch/mips/math-emu/dp_sqrt.c
@@ -110,13 +110,13 @@ union ieee754dp ieee754dp_sqrt(union iee
 	/* triple to almost 56 sig. bits: y ~= sqrt(x) to within 1 ulp */
 	/* t=y*y; z=t;	pt[n0]+=0x00100000; t+=z; z=(x-z)*y; */
 	z = t = ieee754dp_mul(y, y);
-	t.bexp += 0x001;
+	t.parts.bexp += 0x001;
 	t = ieee754dp_add(t, z);
 	z = ieee754dp_mul(ieee754dp_sub(x, z), y);
 
 	/* t=z/(t+x) ;	pt[n0]+=0x00100000; y+=t; */
 	t = ieee754dp_div(z, ieee754dp_add(t, x));
-	t.bexp += 0x001;
+	t.parts.bexp += 0x001;
 	y = ieee754dp_add(y, t);
 
 	/* twiddle last bit to force y correctly rounded */
@@ -155,7 +155,7 @@ union ieee754dp ieee754dp_sqrt(union iee
 	}
 
 	/* py[n0]=py[n0]+scalx; ...scale back y */
-	y.bexp += scalx;
+	y.parts.bexp += scalx;
 
 	/* restore rounding mode, possibly set inexact */
 	ieee754_csr = oldcsr;
Index: linux-20140623-4maxp64/arch/mips/math-emu/ieee754.c
===================================================================
--- linux-20140623-4maxp64.orig/arch/mips/math-emu/ieee754.c
+++ linux-20140623-4maxp64/arch/mips/math-emu/ieee754.c
@@ -36,9 +36,11 @@
 
 #define DPCNST(s, b, m)							\
 {									\
-	.sign	= (s),							\
-	.bexp	= (b) + DP_EBIAS,					\
-	.mant	= (m)							\
+	.parts = {							\
+		.sign	= (s),						\
+		.bexp	= (b) + DP_EBIAS,				\
+		.mant	= (m)						\
+	}								\
 }
 
 const union ieee754dp __ieee754dp_spcvals[] = {
@@ -63,9 +65,11 @@ const union ieee754dp __ieee754dp_spcval
 
 #define SPCNST(s, b, m)							\
 {									\
-	.sign	= (s),							\
-	.bexp	= (b) + SP_EBIAS,					\
-	.mant	= (m)							\
+	.parts = {							\
+		.sign	= (s),						\
+		.bexp	= (b) + SP_EBIAS,				\
+		.mant	= (m)						\
+	}								\
 }
 
 const union ieee754sp __ieee754sp_spcvals[] = {
Index: linux-20140623-4maxp64/arch/mips/math-emu/ieee754.h
===================================================================
--- linux-20140623-4maxp64.orig/arch/mips/math-emu/ieee754.h
+++ linux-20140623-4maxp64/arch/mips/math-emu/ieee754.h
@@ -37,7 +37,7 @@ union ieee754dp {
 		__BITFIELD_FIELD(unsigned int bexp:11,
 		__BITFIELD_FIELD(u64 mant:52,
 		;)))
-	};
+	} parts;
 	u64 bits;
 };
 
@@ -47,7 +47,7 @@ union ieee754sp {
 		__BITFIELD_FIELD(unsigned bexp:8,
 		__BITFIELD_FIELD(unsigned mant:23,
 		;)))
-	};
+	} parts;
 	u32 bits;
 };
 
Index: linux-20140623-4maxp64/arch/mips/math-emu/ieee754dp.h
===================================================================
--- linux-20140623-4maxp64.orig/arch/mips/math-emu/ieee754dp.h
+++ linux-20140623-4maxp64/arch/mips/math-emu/ieee754dp.h
@@ -36,9 +36,9 @@
 #define DP_HIDDEN_BIT	DP_MBIT(DP_FBITS)
 #define DP_SIGN_BIT	DP_MBIT(63)
 
-#define DPSIGN(dp)	(dp.sign)
-#define DPBEXP(dp)	(dp.bexp)
-#define DPMANT(dp)	(dp.mant)
+#define DPSIGN(dp)	(dp.parts.sign)
+#define DPBEXP(dp)	(dp.parts.bexp)
+#define DPMANT(dp)	(dp.parts.mant)
 
 static inline int ieee754dp_finite(union ieee754dp x)
 {
@@ -70,9 +70,9 @@ static inline union ieee754dp builddp(in
 	       && (bx) <= DP_EMAX + 1 + DP_EBIAS);
 	assert(((m) >> DP_FBITS) == 0);
 
-	r.sign = s;
-	r.bexp = bx;
-	r.mant = m;
+	r.parts.sign = s;
+	r.parts.bexp = bx;
+	r.parts.mant = m;
 
 	return r;
 }
Index: linux-20140623-4maxp64/arch/mips/math-emu/ieee754sp.h
===================================================================
--- linux-20140623-4maxp64.orig/arch/mips/math-emu/ieee754sp.h
+++ linux-20140623-4maxp64/arch/mips/math-emu/ieee754sp.h
@@ -36,9 +36,9 @@
 #define SP_HIDDEN_BIT	SP_MBIT(SP_FBITS)
 #define SP_SIGN_BIT	SP_MBIT(31)
 
-#define SPSIGN(sp)	(sp.sign)
-#define SPBEXP(sp)	(sp.bexp)
-#define SPMANT(sp)	(sp.mant)
+#define SPSIGN(sp)	(sp.parts.sign)
+#define SPBEXP(sp)	(sp.parts.bexp)
+#define SPMANT(sp)	(sp.parts.mant)
 
 static inline int ieee754sp_finite(union ieee754sp x)
 {
@@ -75,9 +75,9 @@ static inline union ieee754sp buildsp(in
 	       && (bx) <= SP_EMAX + 1 + SP_EBIAS);
 	assert(((m) >> SP_FBITS) == 0);
 
-	r.sign = s;
-	r.bexp = bx;
-	r.mant = m;
+	r.parts.sign = s;
+	r.parts.bexp = bx;
+	r.parts.mant = m;
 
 	return r;
 }
