Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:39:54 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:54500 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225326AbSLRBhh>;
	Wed, 18 Dec 2002 01:37:37 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 8E0B9D657; Wed, 18 Dec 2002 02:43:33 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: fix compiler warnings in the math-emulator
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:43:33 +0100
Message-ID: <m2znr4p0e2.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        this patch does:

* redefine SETCX to only set cx
* define a new macre SETANDTESTCX for the few cases when we also want to
  test the value set.

Later, Juan.

Index: arch/mips/math-emu/dp_cmp.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/math-emu/dp_cmp.c,v
retrieving revision 1.4.2.1
diff -u -r1.4.2.1 dp_cmp.c
--- arch/mips/math-emu/dp_cmp.c	5 Aug 2002 14:18:22 -0000	1.4.2.1
+++ arch/mips/math-emu/dp_cmp.c	18 Dec 2002 00:49:18 -0000
@@ -44,7 +44,7 @@
 		if (cmp & IEEE754_CUN)
 			return 1;
 		if (cmp & (IEEE754_CLT | IEEE754_CGT)) {
-			if (sig && SETCX(IEEE754_INVALID_OPERATION))
+			if (sig && SETANDTESTCX(IEEE754_INVALID_OPERATION))
 				return ieee754si_xcpt(0, "fcmpf", x);
 		}
 		return 0;
Index: arch/mips/math-emu/ieee754dp.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/math-emu/ieee754dp.c,v
retrieving revision 1.5.2.3
diff -u -r1.5.2.3 ieee754dp.c
--- arch/mips/math-emu/ieee754dp.c	5 Aug 2002 23:53:34 -0000	1.5.2.3
+++ arch/mips/math-emu/ieee754dp.c	18 Dec 2002 00:49:18 -0000
@@ -69,7 +69,7 @@
 	if (!ieee754dp_issnan(r))	/* QNAN does not cause invalid op !! */
 		return r;
 
-	if (!SETCX(IEEE754_INVALID_OPERATION)) {
+	if (!SETANDTESTCX(IEEE754_INVALID_OPERATION)) {
 		/* not enabled convert to a quiet NaN */
 		DPMANT(r) &= (~DP_MBIT(DP_MBITS-1));
 		if (ieee754dp_isnan(r))
Index: arch/mips/math-emu/ieee754int.h
===================================================================
RCS file: /home/cvs/linux/arch/mips/math-emu/ieee754int.h,v
retrieving revision 1.3.2.2
diff -u -r1.3.2.2 ieee754int.h
--- arch/mips/math-emu/ieee754int.h	5 Aug 2002 23:53:34 -0000	1.3.2.2
+++ arch/mips/math-emu/ieee754int.h	18 Dec 2002 00:49:18 -0000
@@ -61,7 +61,10 @@
   (ieee754_csr.cx = 0)
 
 #define SETCX(x) \
-  (ieee754_csr.cx |= (x),ieee754_csr.sx |= (x),ieee754_csr.mx & (x))
+  (ieee754_csr.cx |= (x),ieee754_csr.sx |= (x))
+
+#define SETANDTESTCX(x) \
+  (SETCX(x),ieee754_csr.mx & (x))
 
 #define TSTX()	\
 	(ieee754_csr.cx & ieee754_csr.mx)
Index: arch/mips/math-emu/ieee754sp.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/math-emu/ieee754sp.c,v
retrieving revision 1.6.2.2
diff -u -r1.6.2.2 ieee754sp.c
--- arch/mips/math-emu/ieee754sp.c	5 Aug 2002 23:53:34 -0000	1.6.2.2
+++ arch/mips/math-emu/ieee754sp.c	18 Dec 2002 00:49:18 -0000
@@ -70,7 +70,7 @@
 	if (!ieee754sp_issnan(r))	/* QNAN does not cause invalid op !! */
 		return r;
 
-	if (!SETCX(IEEE754_INVALID_OPERATION)) {
+	if (!SETANDTESTCX(IEEE754_INVALID_OPERATION)) {
 		/* not enabled convert to a quiet NaN */
 		SPMANT(r) &= (~SP_MBIT(SP_MBITS-1));
 		if (ieee754sp_isnan(r))
Index: arch/mips/math-emu/sp_cmp.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/math-emu/sp_cmp.c,v
retrieving revision 1.4.2.1
diff -u -r1.4.2.1 sp_cmp.c
--- arch/mips/math-emu/sp_cmp.c	5 Aug 2002 14:18:23 -0000	1.4.2.1
+++ arch/mips/math-emu/sp_cmp.c	18 Dec 2002 00:49:18 -0000
@@ -44,7 +44,7 @@
 		if (cmp & IEEE754_CUN)
 			return 1;
 		if (cmp & (IEEE754_CLT | IEEE754_CGT)) {
-			if (sig && SETCX(IEEE754_INVALID_OPERATION))
+			if (sig && SETANDTESTCX(IEEE754_INVALID_OPERATION))
 				return ieee754si_xcpt(0, "fcmpf", x);
 		}
 		return 0;
-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
