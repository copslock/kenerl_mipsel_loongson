Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jan 2010 02:18:21 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1990 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492776Ab0AIBRw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Jan 2010 02:17:52 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b47d9410000>; Fri, 08 Jan 2010 17:17:53 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 8 Jan 2010 17:17:50 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 8 Jan 2010 17:17:50 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o091HlfV002379;
        Fri, 8 Jan 2010 17:17:47 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o091HiIH002377;
        Fri, 8 Jan 2010 17:17:44 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: New macro smp_mb__before_llsc.
Date:   Fri,  8 Jan 2010 17:17:43 -0800
Message-Id: <1262999864-2353-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4B47D8ED.1020006@caviumnetworks.com>
References: <4B47D8ED.1020006@caviumnetworks.com>
X-OriginalArrivalTime: 09 Jan 2010 01:17:50.0241 (UTC) FILETIME=[8F6A3910:01CA90C9]
X-archive-position: 25551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6013

Replace some instances of smp_llsc_mb() with a new macro
smp_mb__before_llsc().  It is used before ll/sc sequences that are
documented as needing write barrier semantics.

The default implementation of smp_mb__before_llsc() is just
smp_llsc_mb(), so there are no changes in semantics.

Also simplify definition of smp_mb(), smp_rmb(), and smp_wmb() to be
just barrier() in the non-SMP case.


Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/atomic.h   |   16 ++++++++--------
 arch/mips/include/asm/barrier.h  |   15 +++++++++------
 arch/mips/include/asm/bitops.h   |    8 ++++----
 arch/mips/include/asm/cmpxchg.h  |   10 +++++-----
 arch/mips/include/asm/spinlock.h |    4 ++--
 arch/mips/include/asm/system.h   |    4 ++++
 6 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index dd75d67..519197e 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -137,7 +137,7 @@ static __inline__ int atomic_add_return(int i, atomic_t * v)
 {
 	int result;
 
-	smp_llsc_mb();
+	smp_mb__before_llsc();
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		int temp;
@@ -189,7 +189,7 @@ static __inline__ int atomic_sub_return(int i, atomic_t * v)
 {
 	int result;
 
-	smp_llsc_mb();
+	smp_mb__before_llsc();
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		int temp;
@@ -249,7 +249,7 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 {
 	int result;
 
-	smp_llsc_mb();
+	smp_mb__before_llsc();
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		int temp;
@@ -516,7 +516,7 @@ static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 {
 	long result;
 
-	smp_llsc_mb();
+	smp_mb__before_llsc();
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		long temp;
@@ -568,7 +568,7 @@ static __inline__ long atomic64_sub_return(long i, atomic64_t * v)
 {
 	long result;
 
-	smp_llsc_mb();
+	smp_mb__before_llsc();
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		long temp;
@@ -628,7 +628,7 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 {
 	long result;
 
-	smp_llsc_mb();
+	smp_mb__before_llsc();
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		long temp;
@@ -788,9 +788,9 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
  * atomic*_return operations are serializing but not the non-*_return
  * versions.
  */
-#define smp_mb__before_atomic_dec()	smp_llsc_mb()
+#define smp_mb__before_atomic_dec()	smp_mb__before_llsc()
 #define smp_mb__after_atomic_dec()	smp_llsc_mb()
-#define smp_mb__before_atomic_inc()	smp_llsc_mb()
+#define smp_mb__before_atomic_inc()	smp_mb__before_llsc()
 #define smp_mb__after_atomic_inc()	smp_llsc_mb()
 
 #include <asm-generic/atomic-long.h>
diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index 91785dc..1a5a51c 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -131,23 +131,26 @@
 #endif /* !CONFIG_CPU_HAS_WB */
 
 #if defined(CONFIG_WEAK_ORDERING) && defined(CONFIG_SMP)
-#define __WEAK_ORDERING_MB	"       sync	\n"
+#define smp_mb()	__asm__ __volatile__("sync" : : :"memory")
+#define smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
+#define smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
 #else
-#define __WEAK_ORDERING_MB	"		\n"
+#define smp_mb()	barrier()
+#define smp_rmb()	barrier()
+#define smp_wmb()	barrier()
 #endif
+
 #if defined(CONFIG_WEAK_REORDERING_BEYOND_LLSC) && defined(CONFIG_SMP)
 #define __WEAK_LLSC_MB		"       sync	\n"
 #else
 #define __WEAK_LLSC_MB		"		\n"
 #endif
 
-#define smp_mb()	__asm__ __volatile__(__WEAK_ORDERING_MB : : :"memory")
-#define smp_rmb()	__asm__ __volatile__(__WEAK_ORDERING_MB : : :"memory")
-#define smp_wmb()	__asm__ __volatile__(__WEAK_ORDERING_MB : : :"memory")
-
 #define set_mb(var, value) \
 	do { var = value; smp_mb(); } while (0)
 
 #define smp_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
 
+#define smp_mb__before_llsc() smp_llsc_mb()
+
 #endif /* __ASM_BARRIER_H */
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 84a3838..9255cfb 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -42,7 +42,7 @@
 /*
  * clear_bit() doesn't provide any barrier for the compiler.
  */
-#define smp_mb__before_clear_bit()	smp_llsc_mb()
+#define smp_mb__before_clear_bit()	smp_mb__before_llsc()
 #define smp_mb__after_clear_bit()	smp_llsc_mb()
 
 /*
@@ -258,7 +258,7 @@ static inline int test_and_set_bit(unsigned long nr,
 	unsigned short bit = nr & SZLONG_MASK;
 	unsigned long res;
 
-	smp_llsc_mb();
+	smp_mb__before_llsc();
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
@@ -395,7 +395,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 	unsigned short bit = nr & SZLONG_MASK;
 	unsigned long res;
 
-	smp_llsc_mb();
+	smp_mb__before_llsc();
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
@@ -485,7 +485,7 @@ static inline int test_and_change_bit(unsigned long nr,
 	unsigned short bit = nr & SZLONG_MASK;
 	unsigned long res;
 
-	smp_llsc_mb();
+	smp_mb__before_llsc();
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 815a438..ed9aaaa 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -72,14 +72,14 @@
  */
 extern void __cmpxchg_called_with_bad_pointer(void);
 
-#define __cmpxchg(ptr, old, new, barrier)				\
+#define __cmpxchg(ptr, old, new, pre_barrier, post_barrier)		\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(ptr)) __old = (old);				\
 	__typeof__(*(ptr)) __new = (new);				\
 	__typeof__(*(ptr)) __res = 0;					\
 									\
-	barrier;							\
+	pre_barrier;							\
 									\
 	switch (sizeof(*(__ptr))) {					\
 	case 4:								\
@@ -96,13 +96,13 @@ extern void __cmpxchg_called_with_bad_pointer(void);
 		break;							\
 	}								\
 									\
-	barrier;							\
+	post_barrier;							\
 									\
 	__res;								\
 })
 
-#define cmpxchg(ptr, old, new)		__cmpxchg(ptr, old, new, smp_llsc_mb())
-#define cmpxchg_local(ptr, old, new)	__cmpxchg(ptr, old, new, )
+#define cmpxchg(ptr, old, new)		__cmpxchg(ptr, old, new, smp_mb__before_llsc(), smp_llsc_mb())
+#define cmpxchg_local(ptr, old, new)	__cmpxchg(ptr, old, new, , )
 
 #define cmpxchg64(ptr, o, n)						\
   ({									\
diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index 21ef9ef..5f16696 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -138,7 +138,7 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	int tmp;
 
-	smp_llsc_mb();
+	smp_mb__before_llsc();
 
 	if (R10000_LLSC_WAR) {
 		__asm__ __volatile__ (
@@ -305,7 +305,7 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 {
 	unsigned int tmp;
 
-	smp_llsc_mb();
+	smp_mb__before_llsc();
 
 	if (R10000_LLSC_WAR) {
 		__asm__ __volatile__(
diff --git a/arch/mips/include/asm/system.h b/arch/mips/include/asm/system.h
index 83b5509..bb937cc 100644
--- a/arch/mips/include/asm/system.h
+++ b/arch/mips/include/asm/system.h
@@ -95,6 +95,8 @@ static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
 {
 	__u32 retval;
 
+	smp_mb__before_llsc();
+
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long dummy;
 
@@ -147,6 +149,8 @@ static inline __u64 __xchg_u64(volatile __u64 * m, __u64 val)
 {
 	__u64 retval;
 
+	smp_mb__before_llsc();
+
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long dummy;
 
-- 
1.6.0.6
