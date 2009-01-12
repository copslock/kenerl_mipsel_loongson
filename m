Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2009 01:27:11 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33983 "EHLO mail.linux-mips.net")
	by ftp.linux-mips.org with ESMTP id S21365113AbZALB1J (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2009 01:27:09 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.14.3/8.14.2) with ESMTP id n0C1QtTJ005856;
	Mon, 12 Jan 2009 01:26:55 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0C1QsZF005855;
	Mon, 12 Jan 2009 01:26:54 GMT
Date:	Mon, 12 Jan 2009 01:26:54 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Cc:	Roel Kluin <roel.kluin@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: unsigned result is always greater than 0
Message-ID: <20090112012654.GB27976@linux-mips.org>
References: <495E2E47.6080605@gmail.com> <FF038EB85946AA46B18DFEE6E6F8A2896606BB@xmb-rtp-218.amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF038EB85946AA46B18DFEE6E6F8A2896606BB@xmb-rtp-218.amer.cisco.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 06, 2009 at 04:46:19PM -0500, David VomLehn (dvomlehn) wrote:

> I agree that the code as it exists is wrong, but, as I see it, the
> problem is that the type of result should be changed from unsigned long
> to int. This fixes the comparison so it works correctly. In addition,
> such a change means that result would be the same type as the counter
> element of atomic_t, avoiding possible surprises should longs be larger
> than ints.

Originally that code was intended only for R2000-class processors.  But
LL/SC don't work correctly on XKPHYS addresses on some R5000-class
processors, so we avoid these instructions on the affected processors
running 64-bit kernels and use the fallback method of disabling interrupts
anyway, so long indeed might be longer than int.  What in the end saves
us is that atomic_sub_if_positive's only caller atomic_dec_if_positive
is only being used by the RM9000 watchdog driver and the RM9000 doesn't
suffer from the mentioned CPU bug.

Still no reason not to fix it.  I changed the intermediate variables used in
all functions that operate on atomic_t to int rsp. long for the atomic64_*
functions for consistency - which as a nice side effect also shaves of
almost 2kB from the kernel due to the elemination of gcc-generated
non-sense sign extension code.

  Ralf

MIPS: atomic_*(): Change type of intermediate variables.

This shaves of 1912 bytes of an IP27 defconfig kernel and avoids
unexpected overflow behaviour in atomic_sub_if_positive.  Apply the same
changes to the atomic64_* functions for consistency.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index c996c3b..1b332e1 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -50,7 +50,7 @@
 static __inline__ void atomic_add(int i, atomic_t * v)
 {
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long temp;
+		int temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -62,7 +62,7 @@ static __inline__ void atomic_add(int i, atomic_t * v)
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else if (cpu_has_llsc) {
-		unsigned long temp;
+		int temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -95,7 +95,7 @@ static __inline__ void atomic_add(int i, atomic_t * v)
 static __inline__ void atomic_sub(int i, atomic_t * v)
 {
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long temp;
+		int temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -107,7 +107,7 @@ static __inline__ void atomic_sub(int i, atomic_t * v)
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else if (cpu_has_llsc) {
-		unsigned long temp;
+		int temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -135,12 +135,12 @@ static __inline__ void atomic_sub(int i, atomic_t * v)
  */
 static __inline__ int atomic_add_return(int i, atomic_t * v)
 {
-	unsigned long result;
+	int result;
 
 	smp_llsc_mb();
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long temp;
+		int temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -154,7 +154,7 @@ static __inline__ int atomic_add_return(int i, atomic_t * v)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
 	} else if (cpu_has_llsc) {
-		unsigned long temp;
+		int temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -187,12 +187,12 @@ static __inline__ int atomic_add_return(int i, atomic_t * v)
 
 static __inline__ int atomic_sub_return(int i, atomic_t * v)
 {
-	unsigned long result;
+	int result;
 
 	smp_llsc_mb();
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long temp;
+		int temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -206,7 +206,7 @@ static __inline__ int atomic_sub_return(int i, atomic_t * v)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
 	} else if (cpu_has_llsc) {
-		unsigned long temp;
+		int temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -247,12 +247,12 @@ static __inline__ int atomic_sub_return(int i, atomic_t * v)
  */
 static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 {
-	unsigned long result;
+	int result;
 
 	smp_llsc_mb();
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long temp;
+		int temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -270,7 +270,7 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
 	} else if (cpu_has_llsc) {
-		unsigned long temp;
+		int temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -429,7 +429,7 @@ static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
 static __inline__ void atomic64_add(long i, atomic64_t * v)
 {
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long temp;
+		long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -441,7 +441,7 @@ static __inline__ void atomic64_add(long i, atomic64_t * v)
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else if (cpu_has_llsc) {
-		unsigned long temp;
+		long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -474,7 +474,7 @@ static __inline__ void atomic64_add(long i, atomic64_t * v)
 static __inline__ void atomic64_sub(long i, atomic64_t * v)
 {
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long temp;
+		long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -486,7 +486,7 @@ static __inline__ void atomic64_sub(long i, atomic64_t * v)
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else if (cpu_has_llsc) {
-		unsigned long temp;
+		long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -514,12 +514,12 @@ static __inline__ void atomic64_sub(long i, atomic64_t * v)
  */
 static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 {
-	unsigned long result;
+	long result;
 
 	smp_llsc_mb();
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long temp;
+		long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -533,7 +533,7 @@ static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
 	} else if (cpu_has_llsc) {
-		unsigned long temp;
+		long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -566,12 +566,12 @@ static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 
 static __inline__ long atomic64_sub_return(long i, atomic64_t * v)
 {
-	unsigned long result;
+	long result;
 
 	smp_llsc_mb();
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long temp;
+		long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -585,7 +585,7 @@ static __inline__ long atomic64_sub_return(long i, atomic64_t * v)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
 	} else if (cpu_has_llsc) {
-		unsigned long temp;
+		long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -626,12 +626,12 @@ static __inline__ long atomic64_sub_return(long i, atomic64_t * v)
  */
 static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 {
-	unsigned long result;
+	long result;
 
 	smp_llsc_mb();
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long temp;
+		long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -649,7 +649,7 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
 	} else if (cpu_has_llsc) {
-		unsigned long temp;
+		long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
