Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:30:32 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025287AbbDCWZeKX1tr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:34 +0200
Date:   Fri, 3 Apr 2015 23:25:34 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 24/48] MIPS: math-emu: Reinstate sNaN quieting handlers
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030401351.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46741
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

Revert the changes made by commit fdffbafb [Lots of FPU bug fixes from 
Kjeld Borch Egevang.] to `ieee754sp_nanxcpt' and `ieee754dp_nanxcpt' 
sNaN quieting handlers and their callers so that sNaN processing is done 
within the handlers againg.  Pass the sNaN causing an IEEE 754 invalid 
operation exception down to the relevant handler.  Pass the sNaN in `fs' 
where two sNaNs are supplied to a binary operation.

Set the Invalid Operation FCSR exception bits in the quieting handlers 
rather than at their call sites throughout.  Make the handlers exclusive 
for sNaN processing.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-nanxcpt.diff
Index: linux/arch/mips/math-emu/dp_add.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_add.c	2015-04-03 04:57:13.565700000 +0100
+++ linux/arch/mips/math-emu/dp_add.c	2015-04-03 04:58:15.978323000 +0100
@@ -37,19 +37,20 @@ union ieee754dp ieee754dp_add(union ieee
 	FLUSHYDP;
 
 	switch (CLPAIR(xc, yc)) {
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+		return ieee754dp_nanxcpt(y);
+
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754dp_nanxcpt(ieee754dp_indef());
+		return ieee754dp_nanxcpt(x);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
Index: linux/arch/mips/math-emu/dp_div.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_div.c	2015-04-03 04:57:13.566710000 +0100
+++ linux/arch/mips/math-emu/dp_div.c	2015-04-03 04:58:15.980324000 +0100
@@ -39,19 +39,20 @@ union ieee754dp ieee754dp_div(union ieee
 	FLUSHYDP;
 
 	switch (CLPAIR(xc, yc)) {
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+		return ieee754dp_nanxcpt(y);
+
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754dp_nanxcpt(ieee754dp_indef());
+		return ieee754dp_nanxcpt(x);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
Index: linux/arch/mips/math-emu/dp_fsp.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_fsp.c	2015-04-03 04:58:06.696244000 +0100
+++ linux/arch/mips/math-emu/dp_fsp.c	2015-04-03 04:58:15.982329000 +0100
@@ -40,8 +40,7 @@ union ieee754dp ieee754dp_fsp(union ieee
 
 	switch (xc) {
 	case IEEE754_CLASS_SNAN:
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754dp_nanxcpt(ieee754dp_indef());
+		return ieee754dp_nanxcpt(ieee754dp_nan_fsp(xs, xm));
 
 	case IEEE754_CLASS_QNAN:
 		return ieee754dp_nan_fsp(xs, xm);
Index: linux/arch/mips/math-emu/dp_mul.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_mul.c	2015-04-03 04:57:13.569704000 +0100
+++ linux/arch/mips/math-emu/dp_mul.c	2015-04-03 04:58:15.985318000 +0100
@@ -47,19 +47,20 @@ union ieee754dp ieee754dp_mul(union ieee
 	FLUSHYDP;
 
 	switch (CLPAIR(xc, yc)) {
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+		return ieee754dp_nanxcpt(y);
+
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754dp_nanxcpt(ieee754dp_indef());
+		return ieee754dp_nanxcpt(x);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
Index: linux/arch/mips/math-emu/dp_sqrt.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_sqrt.c	2015-04-03 04:58:06.699229000 +0100
+++ linux/arch/mips/math-emu/dp_sqrt.c	2015-04-03 04:58:15.986332000 +0100
@@ -42,14 +42,13 @@ union ieee754dp ieee754dp_sqrt(union iee
 
 	/* x == INF or NAN? */
 	switch (xc) {
+	case IEEE754_CLASS_SNAN:
+		return ieee754dp_nanxcpt(x);
+
 	case IEEE754_CLASS_QNAN:
 		/* sqrt(Nan) = Nan */
 		return x;
 
-	case IEEE754_CLASS_SNAN:
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754dp_nanxcpt(ieee754dp_indef());
-
 	case IEEE754_CLASS_ZERO:
 		/* sqrt(0) = 0 */
 		return x;
Index: linux/arch/mips/math-emu/dp_sub.c
===================================================================
--- linux.orig/arch/mips/math-emu/dp_sub.c	2015-04-03 04:57:13.572700000 +0100
+++ linux/arch/mips/math-emu/dp_sub.c	2015-04-03 04:58:15.989320000 +0100
@@ -37,19 +37,20 @@ union ieee754dp ieee754dp_sub(union ieee
 	FLUSHYDP;
 
 	switch (CLPAIR(xc, yc)) {
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+		return ieee754dp_nanxcpt(y);
+
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754dp_nanxcpt(ieee754dp_indef());
+		return ieee754dp_nanxcpt(x);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
Index: linux/arch/mips/math-emu/ieee754dp.c
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754dp.c	2015-04-03 04:57:47.065031000 +0100
+++ linux/arch/mips/math-emu/ieee754dp.c	2015-04-03 04:58:15.991322000 +0100
@@ -42,18 +42,16 @@ static inline int ieee754dp_issnan(union
 }
 
 
+/*
+ * Raise the Invalid Operation IEEE 754 exception
+ * and convert the signaling NaN supplied to a quiet NaN.
+ */
 union ieee754dp __cold ieee754dp_nanxcpt(union ieee754dp r)
 {
-	assert(ieee754dp_isnan(r));
-
-	if (!ieee754dp_issnan(r))	/* QNAN does not cause invalid op !! */
-		return r;
-
-	/* If not enabled convert to a quiet NaN.  */
-	if (!ieee754_setandtestcx(IEEE754_INVALID_OPERATION))
-		return ieee754dp_indef();
+	assert(ieee754dp_issnan(r));
 
-	return r;
+	ieee754_setcx(IEEE754_INVALID_OPERATION);
+	return ieee754dp_indef();
 }
 
 static u64 ieee754dp_get_rounding(int sn, u64 xm)
Index: linux/arch/mips/math-emu/ieee754sp.c
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754sp.c	2015-04-03 04:57:47.067040000 +0100
+++ linux/arch/mips/math-emu/ieee754sp.c	2015-04-03 04:58:15.993327000 +0100
@@ -42,18 +42,16 @@ static inline int ieee754sp_issnan(union
 }
 
 
+/*
+ * Raise the Invalid Operation IEEE 754 exception
+ * and convert the signaling NaN supplied to a quiet NaN.
+ */
 union ieee754sp __cold ieee754sp_nanxcpt(union ieee754sp r)
 {
-	assert(ieee754sp_isnan(r));
-
-	if (!ieee754sp_issnan(r))	/* QNAN does not cause invalid op !! */
-		return r;
-
-	/* If not enabled convert to a quiet NaN.  */
-	if (!ieee754_setandtestcx(IEEE754_INVALID_OPERATION))
-		return ieee754sp_indef();
+	assert(ieee754sp_issnan(r));
 
-	return r;
+	ieee754_setcx(IEEE754_INVALID_OPERATION);
+	return ieee754sp_indef();
 }
 
 static unsigned ieee754sp_get_rounding(int sn, unsigned xm)
Index: linux/arch/mips/math-emu/sp_add.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_add.c	2015-04-03 04:57:13.576708000 +0100
+++ linux/arch/mips/math-emu/sp_add.c	2015-04-03 04:58:16.002321000 +0100
@@ -37,19 +37,20 @@ union ieee754sp ieee754sp_add(union ieee
 	FLUSHYSP;
 
 	switch (CLPAIR(xc, yc)) {
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+		return ieee754sp_nanxcpt(y);
+
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754sp_nanxcpt(ieee754sp_indef());
+		return ieee754sp_nanxcpt(x);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
Index: linux/arch/mips/math-emu/sp_div.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_div.c	2015-04-03 04:57:13.578697000 +0100
+++ linux/arch/mips/math-emu/sp_div.c	2015-04-03 04:58:16.005320000 +0100
@@ -39,19 +39,20 @@ union ieee754sp ieee754sp_div(union ieee
 	FLUSHYSP;
 
 	switch (CLPAIR(xc, yc)) {
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+		return ieee754sp_nanxcpt(y);
+
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754sp_nanxcpt(ieee754sp_indef());
+		return ieee754sp_nanxcpt(x);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
Index: linux/arch/mips/math-emu/sp_fdp.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_fdp.c	2015-04-03 04:58:06.701235000 +0100
+++ linux/arch/mips/math-emu/sp_fdp.c	2015-04-03 04:58:16.006329000 +0100
@@ -43,8 +43,7 @@ union ieee754sp ieee754sp_fdp(union ieee
 
 	switch (xc) {
 	case IEEE754_CLASS_SNAN:
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754sp_nanxcpt(ieee754sp_indef());
+		return ieee754sp_nanxcpt(ieee754sp_nan_fdp(xs, xm));
 
 	case IEEE754_CLASS_QNAN:
 		nan = ieee754sp_nan_fdp(xs, xm);
Index: linux/arch/mips/math-emu/sp_mul.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_mul.c	2015-04-03 04:57:13.580714000 +0100
+++ linux/arch/mips/math-emu/sp_mul.c	2015-04-03 04:58:16.009320000 +0100
@@ -47,19 +47,20 @@ union ieee754sp ieee754sp_mul(union ieee
 	FLUSHYSP;
 
 	switch (CLPAIR(xc, yc)) {
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+		return ieee754sp_nanxcpt(y);
+
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754sp_nanxcpt(ieee754sp_indef());
+		return ieee754sp_nanxcpt(x);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
Index: linux/arch/mips/math-emu/sp_sqrt.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_sqrt.c	2015-04-03 04:58:06.703246000 +0100
+++ linux/arch/mips/math-emu/sp_sqrt.c	2015-04-03 04:58:16.011320000 +0100
@@ -35,14 +35,13 @@ union ieee754sp ieee754sp_sqrt(union iee
 
 	/* x == INF or NAN? */
 	switch (xc) {
+	case IEEE754_CLASS_SNAN:
+		return ieee754sp_nanxcpt(x);
+
 	case IEEE754_CLASS_QNAN:
 		/* sqrt(Nan) = Nan */
 		return x;
 
-	case IEEE754_CLASS_SNAN:
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754sp_nanxcpt(ieee754sp_indef());
-
 	case IEEE754_CLASS_ZERO:
 		/* sqrt(0) = 0 */
 		return x;
Index: linux/arch/mips/math-emu/sp_sub.c
===================================================================
--- linux.orig/arch/mips/math-emu/sp_sub.c	2015-04-03 04:57:13.584711000 +0100
+++ linux/arch/mips/math-emu/sp_sub.c	2015-04-03 04:58:16.013323000 +0100
@@ -37,19 +37,20 @@ union ieee754sp ieee754sp_sub(union ieee
 	FLUSHYSP;
 
 	switch (CLPAIR(xc, yc)) {
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_SNAN):
-	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_SNAN):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_SNAN):
+		return ieee754sp_nanxcpt(y);
+
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_SNAN):
+	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
-		ieee754_setcx(IEEE754_INVALID_OPERATION);
-		return ieee754sp_nanxcpt(ieee754sp_indef());
+		return ieee754sp_nanxcpt(x);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
