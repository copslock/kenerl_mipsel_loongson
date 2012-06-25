Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2012 03:01:51 +0200 (CEST)
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:42554
        "EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903494Ab2FYBBl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jun 2012 03:01:41 +0200
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
        by qmta05.westchester.pa.mail.comcast.net with comcast
        id SQzN1j0080mv7h055R1bzH; Mon, 25 Jun 2012 01:01:35 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta11.westchester.pa.mail.comcast.net with comcast
        id SR1Y1j00H1rgsis3XR1ZDX; Mon, 25 Jun 2012 01:01:34 +0000
Message-ID: <4FE7B86E.7030601@gentoo.org>
Date:   Sun, 24 Jun 2012 21:01:34 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: Improve atomic.h robustness
X-Enigmail-Version: 1.4.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>


I've maintained this patch, originally from Thiemo Seufer in 2004, for a
really long time, but I think it's time for it to get a look at for possible
inclusion.  I have had no problems with it across various SGI systems over
the years.

To quote the post here:
http://www.linux-mips.org/archives/linux-mips/2004-12/msg00000.html

"the atomic functions use so far memory references for the inline
assembler to access the semaphore. This can lead to additional
instructions in the ll/sc loop, because newer compilers don't
expand the memory reference any more but leave it to the assembler.

The appended patch uses registers instead, and makes the ll/sc
arguments more explicit. In some cases it will lead also to better
register scheduling because the register isn't bound to an output
any more."

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---

 atomic.h |   64 ++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 29 insertions(+), 35 deletions(-)


diff -Naurp a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -59,8 +59,8 @@ static __inline__ void atomic_add(int i,
 		"	sc	%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		: "=&r" (temp), "+m" (v->counter)
+		: "Ir" (i));
 	} else if (kernel_uses_llsc) {
 		int temp;

@@ -71,8 +71,8 @@ static __inline__ void atomic_add(int i,
 			"	addu	%0, %2				\n"
 			"	sc	%0, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "=m" (v->counter)
-			: "Ir" (i), "m" (v->counter));
+			: "=&r" (temp), "+m" (v->counter)
+			: "Ir" (i));
 		} while (unlikely(!temp));
 	} else {
 		unsigned long flags;
@@ -102,8 +102,8 @@ static __inline__ void atomic_sub(int i,
 		"	sc	%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		: "=&r" (temp), "+m" (v->counter)
+		: "Ir" (i));
 	} else if (kernel_uses_llsc) {
 		int temp;

@@ -114,8 +114,8 @@ static __inline__ void atomic_sub(int i,
 			"	subu	%0, %2				\n"
 			"	sc	%0, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "=m" (v->counter)
-			: "Ir" (i), "m" (v->counter));
+			: "=&r" (temp), "+m" (v->counter)
+			: "Ir" (i));
 		} while (unlikely(!temp));
 	} else {
 		unsigned long flags;
@@ -146,9 +146,8 @@ static __inline__ int atomic_add_return(
 		"	beqzl	%0, 1b					\n"
 		"	addu	%0, %1, %3				\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
-		: "memory");
+		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
+		: "Ir" (i));
 	} else if (kernel_uses_llsc) {
 		int temp;

@@ -159,9 +158,8 @@ static __inline__ int atomic_add_return(
 			"	addu	%0, %1, %3			\n"
 			"	sc	%0, %2				\n"
 			"	.set	mips0				\n"
-			: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-			: "Ir" (i), "m" (v->counter)
-			: "memory");
+			: "=&r" (result), "=&r" (temp), "+m" (v->counter)
+			: "Ir" (i));
 		} while (unlikely(!result));

 		result = temp + i;
@@ -212,9 +210,8 @@ static __inline__ int atomic_sub_return(
 			"	subu	%0, %1, %3			\n"
 			"	sc	%0, %2				\n"
 			"	.set	mips0				\n"
-			: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-			: "Ir" (i), "m" (v->counter)
-			: "memory");
+			: "=&r" (result), "=&r" (temp), "+m" (v->counter)
+			: "Ir" (i));
 		} while (unlikely(!result));

 		result = temp - i;
@@ -262,7 +259,7 @@ static __inline__ int atomic_sub_if_posi
 		"	.set	reorder					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
+		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
 	} else if (kernel_uses_llsc) {
@@ -280,9 +277,8 @@ static __inline__ int atomic_sub_if_posi
 		"	.set	reorder					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
-		: "memory");
+		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
+		: "Ir" (i));
 	} else {
 		unsigned long flags;

@@ -430,8 +426,8 @@ static __inline__ void atomic64_add(long
 		"	scd	%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		: "=&r" (temp), "+m" (v->counter)
+		: "Ir" (i));
 	} else if (kernel_uses_llsc) {
 		long temp;

@@ -442,8 +438,8 @@ static __inline__ void atomic64_add(long
 			"	daddu	%0, %2				\n"
 			"	scd	%0, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "=m" (v->counter)
-			: "Ir" (i), "m" (v->counter));
+			: "=&r" (temp), "+m" (v->counter)
+			: "Ir" (i));
 		} while (unlikely(!temp));
 	} else {
 		unsigned long flags;
@@ -473,8 +469,8 @@ static __inline__ void atomic64_sub(long
 		"	scd	%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		: "=&r" (temp), "+m" (v->counter)
+		: "Ir" (i));
 	} else if (kernel_uses_llsc) {
 		long temp;

@@ -485,8 +481,8 @@ static __inline__ void atomic64_sub(long
 			"	dsubu	%0, %2				\n"
 			"	scd	%0, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "=m" (v->counter)
-			: "Ir" (i), "m" (v->counter));
+			: "=&r" (temp), "+m" (v->counter)
+			: "Ir" (i));
 		} while (unlikely(!temp));
 	} else {
 		unsigned long flags;
@@ -517,9 +513,8 @@ static __inline__ long atomic64_add_retu
 		"	beqzl	%0, 1b					\n"
 		"	daddu	%0, %1, %3				\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
-		: "memory");
+		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
+		: "Ir" (i));
 	} else if (kernel_uses_llsc) {
 		long temp;

@@ -649,9 +644,8 @@ static __inline__ long atomic64_sub_if_p
 		"	.set	reorder					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
-		: "memory");
+		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
+		: "Ir" (i));
 	} else {
 		unsigned long flags;
