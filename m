Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2009 20:16:14 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:64311 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492476AbZGMSPm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2009 20:15:42 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a5b79bd0001>; Mon, 13 Jul 2009 14:15:25 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Jul 2009 11:15:24 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Jul 2009 11:15:24 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n6DIFLnp029179;
	Mon, 13 Jul 2009 11:15:21 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n6DIFK1j029177;
	Mon, 13 Jul 2009 11:15:20 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Allow kernel use of ll/sc to be separate from the presence of ll/sc.
Date:	Mon, 13 Jul 2009 11:15:19 -0700
Message-Id: <1247508920-29153-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 13 Jul 2009 18:15:24.0467 (UTC) FILETIME=[E436C830:01CA03E5]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On some CPUs, it is more efficient to disable and enable interrupts in
the kernel rather than use ll/sc for atomic operations.  But if we
were to set cpu_has_llsc to false, we would break the userspace futex
interface (in asm/futex.h).

We separate the two concepts, with a new predicate kernel_uses_llsc,
that lets us disable the kernel's use of ll/sc while still allowing
the futex code to use it.

Also there were a couple of cases in bitops.h where we were using
ll/sc unconditionally even if cpu_has_llsc were false.  There are
several places in assembly code where the configure variable
CONFIG_CPU_HAS_LLSC is used instead of cpu_has_llsc, so we make
cpu_has_llsc true if CONFIG_CPU_HAS_LLSC is set, for consistency.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/atomic.h       |   40 +++++++++++++++++-----------------
 arch/mips/include/asm/bitops.h       |   34 ++++++++++++++--------------
 arch/mips/include/asm/cmpxchg.h      |    4 +-
 arch/mips/include/asm/cpu-features.h |    9 ++++++-
 arch/mips/include/asm/local.h        |    8 +++---
 arch/mips/include/asm/system.h       |    8 +++---
 6 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index eb7f01c..dd75d67 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -49,7 +49,7 @@
  */
 static __inline__ void atomic_add(int i, atomic_t * v)
 {
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		int temp;
 
 		__asm__ __volatile__(
@@ -61,7 +61,7 @@ static __inline__ void atomic_add(int i, atomic_t * v)
 		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		int temp;
 
 		__asm__ __volatile__(
@@ -94,7 +94,7 @@ static __inline__ void atomic_add(int i, atomic_t * v)
  */
 static __inline__ void atomic_sub(int i, atomic_t * v)
 {
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		int temp;
 
 		__asm__ __volatile__(
@@ -106,7 +106,7 @@ static __inline__ void atomic_sub(int i, atomic_t * v)
 		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		int temp;
 
 		__asm__ __volatile__(
@@ -139,7 +139,7 @@ static __inline__ int atomic_add_return(int i, atomic_t * v)
 
 	smp_llsc_mb();
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		int temp;
 
 		__asm__ __volatile__(
@@ -153,7 +153,7 @@ static __inline__ int atomic_add_return(int i, atomic_t * v)
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		int temp;
 
 		__asm__ __volatile__(
@@ -191,7 +191,7 @@ static __inline__ int atomic_sub_return(int i, atomic_t * v)
 
 	smp_llsc_mb();
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		int temp;
 
 		__asm__ __volatile__(
@@ -205,7 +205,7 @@ static __inline__ int atomic_sub_return(int i, atomic_t * v)
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		int temp;
 
 		__asm__ __volatile__(
@@ -251,7 +251,7 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 
 	smp_llsc_mb();
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		int temp;
 
 		__asm__ __volatile__(
@@ -269,7 +269,7 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		int temp;
 
 		__asm__ __volatile__(
@@ -428,7 +428,7 @@ static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
  */
 static __inline__ void atomic64_add(long i, atomic64_t * v)
 {
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -440,7 +440,7 @@ static __inline__ void atomic64_add(long i, atomic64_t * v)
 		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -473,7 +473,7 @@ static __inline__ void atomic64_add(long i, atomic64_t * v)
  */
 static __inline__ void atomic64_sub(long i, atomic64_t * v)
 {
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -485,7 +485,7 @@ static __inline__ void atomic64_sub(long i, atomic64_t * v)
 		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -518,7 +518,7 @@ static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 
 	smp_llsc_mb();
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -532,7 +532,7 @@ static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -570,7 +570,7 @@ static __inline__ long atomic64_sub_return(long i, atomic64_t * v)
 
 	smp_llsc_mb();
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -584,7 +584,7 @@ static __inline__ long atomic64_sub_return(long i, atomic64_t * v)
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -630,7 +630,7 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 
 	smp_llsc_mb();
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -648,7 +648,7 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		long temp;
 
 		__asm__ __volatile__(
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index b1e9e97..84a3838 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -61,7 +61,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 	unsigned short bit = nr & SZLONG_MASK;
 	unsigned long temp;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	" __LL "%0, %1			# set_bit	\n"
@@ -72,7 +72,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << bit), "m" (*m));
 #ifdef CONFIG_CPU_MIPSR2
-	} else if (__builtin_constant_p(bit)) {
+	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
 		__asm__ __volatile__(
 		"1:	" __LL "%0, %1			# set_bit	\n"
 		"	" __INS "%0, %4, %2, 1				\n"
@@ -84,7 +84,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (bit), "m" (*m), "r" (~0));
 #endif /* CONFIG_CPU_MIPSR2 */
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	" __LL "%0, %1			# set_bit	\n"
@@ -126,7 +126,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 	unsigned short bit = nr & SZLONG_MASK;
 	unsigned long temp;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	" __LL "%0, %1			# clear_bit	\n"
@@ -137,7 +137,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (~(1UL << bit)), "m" (*m));
 #ifdef CONFIG_CPU_MIPSR2
-	} else if (__builtin_constant_p(bit)) {
+	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
 		__asm__ __volatile__(
 		"1:	" __LL "%0, %1			# clear_bit	\n"
 		"	" __INS "%0, $0, %2, 1				\n"
@@ -149,7 +149,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (bit), "m" (*m));
 #endif /* CONFIG_CPU_MIPSR2 */
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
 		"1:	" __LL "%0, %1			# clear_bit	\n"
@@ -202,7 +202,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned short bit = nr & SZLONG_MASK;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
@@ -215,7 +215,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 		"	.set	mips0				\n"
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << bit), "m" (*m));
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
@@ -260,7 +260,7 @@ static inline int test_and_set_bit(unsigned long nr,
 
 	smp_llsc_mb();
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
@@ -275,7 +275,7 @@ static inline int test_and_set_bit(unsigned long nr,
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << bit), "m" (*m)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
@@ -328,7 +328,7 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 	unsigned short bit = nr & SZLONG_MASK;
 	unsigned long res;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
@@ -343,7 +343,7 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << bit), "m" (*m)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
@@ -397,7 +397,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 
 	smp_llsc_mb();
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
@@ -414,7 +414,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 		: "r" (1UL << bit), "m" (*m)
 		: "memory");
 #ifdef CONFIG_CPU_MIPSR2
-	} else if (__builtin_constant_p(nr)) {
+	} else if (kernel_uses_llsc && __builtin_constant_p(nr)) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
@@ -431,7 +431,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 		: "ir" (bit), "m" (*m)
 		: "memory");
 #endif
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
@@ -487,7 +487,7 @@ static inline int test_and_change_bit(unsigned long nr,
 
 	smp_llsc_mb();
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
@@ -502,7 +502,7 @@ static inline int test_and_change_bit(unsigned long nr,
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << bit), "m" (*m)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 4a812c3..815a438 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -16,7 +16,7 @@
 ({									\
 	__typeof(*(m)) __ret;						\
 									\
-	if (cpu_has_llsc && R10000_LLSC_WAR) {				\
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {				\
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
@@ -33,7 +33,7 @@
 		: "=&r" (__ret), "=R" (*m)				\
 		: "R" (*m), "Jr" (old), "Jr" (new)			\
 		: "memory");						\
-	} else if (cpu_has_llsc) {					\
+	} else if (kernel_uses_llsc) {					\
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 8ab1d12..e581cc0 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -78,7 +78,14 @@
 #define cpu_has_ejtag		(cpu_data[0].options & MIPS_CPU_EJTAG)
 #endif
 #ifndef cpu_has_llsc
-#define cpu_has_llsc		(cpu_data[0].options & MIPS_CPU_LLSC)
+# ifdef CONFIG_CPU_HAS_LLSC
+#  define cpu_has_llsc		1
+# else
+#  define cpu_has_llsc		(cpu_data[0].options & MIPS_CPU_LLSC)
+# endif
+#endif
+#ifndef kernel_uses_llsc
+#define kernel_uses_llsc	cpu_has_llsc
 #endif
 #ifndef cpu_has_mips16
 #define cpu_has_mips16		(cpu_data[0].ases & MIPS_ASE_MIPS16)
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index f96fd59..361f4f1 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -29,7 +29,7 @@ static __inline__ long local_add_return(long i, local_t * l)
 {
 	unsigned long result;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
@@ -43,7 +43,7 @@ static __inline__ long local_add_return(long i, local_t * l)
 		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
 		: "Ir" (i), "m" (l->a.counter)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
@@ -74,7 +74,7 @@ static __inline__ long local_sub_return(long i, local_t * l)
 {
 	unsigned long result;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
@@ -88,7 +88,7 @@ static __inline__ long local_sub_return(long i, local_t * l)
 		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
 		: "Ir" (i), "m" (l->a.counter)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
diff --git a/arch/mips/include/asm/system.h b/arch/mips/include/asm/system.h
index cd30f83..5e6287f 100644
--- a/arch/mips/include/asm/system.h
+++ b/arch/mips/include/asm/system.h
@@ -84,7 +84,7 @@ static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
 {
 	__u32 retval;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long dummy;
 
 		__asm__ __volatile__(
@@ -99,7 +99,7 @@ static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
 		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
 		: "R" (*m), "Jr" (val)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		unsigned long dummy;
 
 		__asm__ __volatile__(
@@ -136,7 +136,7 @@ static inline __u64 __xchg_u64(volatile __u64 * m, __u64 val)
 {
 	__u64 retval;
 
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long dummy;
 
 		__asm__ __volatile__(
@@ -149,7 +149,7 @@ static inline __u64 __xchg_u64(volatile __u64 * m, __u64 val)
 		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
 		: "R" (*m), "Jr" (val)
 		: "memory");
-	} else if (cpu_has_llsc) {
+	} else if (kernel_uses_llsc) {
 		unsigned long dummy;
 
 		__asm__ __volatile__(
-- 
1.6.0.6
