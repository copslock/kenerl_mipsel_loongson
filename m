Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:21:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54015 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992155AbcKGLUFOdTyd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:20:05 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DD05A51B23E53;
        Mon,  7 Nov 2016 11:19:55 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:19:57 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 7/7] MIPS: uaccess: Use standard __user_copy* function calls
Date:   Mon, 7 Nov 2016 11:18:02 +0000
Message-ID: <20161107111802.12071-8-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107111802.12071-1-paul.burton@imgtec.com>
References: <20161107111802.12071-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The __user_copy* functions are now almost using the standard calling
conventions with the exception of manually redefined argument registers.
Remove those redefinitions such that we use the argument registers
matching the standard calling convention for the kernel build, and call
__user_copy* with standard C function calls. This allows us to remove
the assembly invoke macros & their manual lists of clobbered registers,
simplifying & tidying up the code in asm/uaccess.h significantly.

This does have a cost in that the compiler will now have to presume that
all registers that are call-clobbered in the standard calling convention
are clobbered by calls to __copy_user*. In practice this doesn't seem
to matter & this patch shaves ~850 bytes of code from a 64r6el generic
kernel:

  $ ./scripts/bloat-o-meter vmlinux-pre vmlinux-post
  add/remove: 7/7 grow/shrink: 161/161 up/down: 6420/-7270 (-850)
  function                                     old     new   delta
  ethtool_get_strings                            -     692    +692
  ethtool_get_dump_data                          -     568    +568
  ...
  ethtool_self_test                            540       -    -540
  ethtool_get_phy_stats.isra                   564       -    -564
  Total: Before=7006717, After=7005867, chg -0.01%

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

 arch/mips/cavium-octeon/octeon-memcpy.S |  16 --
 arch/mips/include/asm/uaccess.h         | 493 +++++++-------------------------
 arch/mips/lib/memcpy.S                  |  16 --
 3 files changed, 110 insertions(+), 415 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 9316ab1..e3f6de1 100644
--- a/arch/mips/cavium-octeon/octeon-memcpy.S
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -43,8 +43,6 @@
  *     - src is readable  (no exceptions when reading src)
  *   copy_from_user
  *     - dst is writable  (no exceptions when writing dst)
- * __copy_user uses a non-standard calling convention; see
- * arch/mips/include/asm/uaccess.h
  *
  * When an exception happens on a load, the handler must
  # ensure that all of the destination buffer is overwritten to prevent
@@ -99,20 +97,6 @@
 #define NBYTES 8
 #define LOG_NBYTES 3
 
-/*
- * As we are sharing code base with the mips32 tree (which use the o32 ABI
- * register definitions). We need to redefine the register definitions from
- * the n64 ABI register naming to the o32 ABI register naming.
- */
-#undef t0
-#undef t1
-#undef t2
-#undef t3
-#define t0	$8
-#define t1	$9
-#define t2	$10
-#define t3	$11
-
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 #define LDFIRST LOADR
 #define LDREST	LOADL
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 562ad49..2e13c19 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -96,6 +96,20 @@ static inline bool eva_kernel_access(void)
 	return segment_eq(get_fs(), get_ds());
 }
 
+/**
+ * eva_user_access() - determine whether access should use EVA instructions
+ *
+ * Determines whether memory accesses should be performed using EVA memory
+ * access instructions - that is, whether to access the user address space on
+ * an EVA system.
+ *
+ * Return: true if user memory access on an EVA system, else false
+ */
+static inline bool eva_user_access(void)
+{
+	return IS_ENABLED(CONFIG_EVA) && !eva_kernel_access();
+}
+
 /*
  * Is a address valid? This does a straightforward calculation rather
  * than tests.
@@ -802,41 +816,18 @@ extern void __put_user_unaligned_unknown(void);
 	"jal\t" #destination "\n\t"
 #endif
 
-#if defined(CONFIG_CPU_DADDI_WORKAROUNDS) || (defined(CONFIG_EVA) &&	\
-					      defined(CONFIG_CPU_HAS_PREFETCH))
-#define DADDI_SCRATCH "$3"
-#else
-#define DADDI_SCRATCH "$0"
-#endif
-
-extern size_t __copy_user(void *__to, const void *__from, size_t __n,
-			  const void *__from_end);
-
-#ifndef CONFIG_EVA
-#define __invoke_copy_to_user(to, from, n)				\
-({									\
-	register long __cu_ret_r __asm__("$2");				\
-	register void __user *__cu_to_r __asm__("$4");			\
-	register const void *__cu_from_r __asm__("$5");			\
-	register long __cu_len_r __asm__("$6");				\
-									\
-	__cu_to_r = (to);						\
-	__cu_from_r = (from);						\
-	__cu_len_r = (n);						\
-	__asm__ __volatile__(						\
-	__MODULE_JAL(__copy_user)					\
-	: "=r"(__cu_ret_r), "+r" (__cu_to_r),				\
-	  "+r" (__cu_from_r), "+r" (__cu_len_r)				\
-	:								\
-	: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",	\
-	  DADDI_SCRATCH, "memory");					\
-	__cu_ret_r;							\
-})
-
-#define __invoke_copy_to_kernel(to, from, n)				\
-	__invoke_copy_to_user(to, from, n)
-
-#endif
+extern size_t __copy_user(void *to, const void *from, size_t n,
+			  const void *from_end);
+extern size_t __copy_user_inatomic(void *to, const void *from, size_t n,
+				   const void *from_end);
+extern size_t __copy_to_user_eva(void *to, const void *from, size_t n,
+				 const void *from_end);
+extern size_t __copy_from_user_eva(void *to, const void *from, size_t n,
+				   const void *from_end);
+extern size_t __copy_user_inatomic_eva(void *to, const void *from, size_t n,
+				       const void *from_end);
+extern size_t __copy_in_user_eva(void *to, const void *from, size_t n,
+				 const void *from_end);
 
 /*
  * __copy_to_user: - Copy a block of data into user space, with less checking.
@@ -853,316 +844,92 @@ extern size_t __copy_user(void *__to, const void *__from, size_t __n,
  * Returns number of bytes that could not be copied.
  * On success, this will be zero.
  */
-#define __copy_to_user(to, from, n)					\
-({									\
-	void __user *__cu_to;						\
-	const void *__cu_from;						\
-	long __cu_len;							\
-									\
-	__cu_to = (to);							\
-	__cu_from = (from);						\
-	__cu_len = (n);							\
-									\
-	check_object_size(__cu_from, __cu_len, true);			\
-	might_fault();							\
-									\
-	if (eva_kernel_access())					\
-		__cu_len = __invoke_copy_to_kernel(__cu_to, __cu_from,	\
-						   __cu_len);		\
-	else								\
-		__cu_len = __invoke_copy_to_user(__cu_to, __cu_from,	\
-						 __cu_len);		\
-	__cu_len;							\
-})
-
-extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n,
-				   const void *__from_end);
+static inline unsigned long __must_check
+__copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	check_object_size(from, n, true);
+	might_fault();
 
-#define __copy_to_user_inatomic(to, from, n)				\
-({									\
-	void __user *__cu_to;						\
-	const void *__cu_from;						\
-	long __cu_len;							\
-									\
-	__cu_to = (to);							\
-	__cu_from = (from);						\
-	__cu_len = (n);							\
-									\
-	check_object_size(__cu_from, __cu_len, true);			\
-									\
-	if (eva_kernel_access())					\
-		__cu_len = __invoke_copy_to_kernel(__cu_to, __cu_from,	\
-						   __cu_len);		\
-	else								\
-		__cu_len = __invoke_copy_to_user(__cu_to, __cu_from,	\
-						 __cu_len);		\
-	__cu_len;							\
-})
+	if (eva_user_access())
+		return __copy_to_user_eva(to, from, n, from + n);
 
-#define __copy_from_user_inatomic(to, from, n)				\
-({									\
-	void *__cu_to;							\
-	const void __user *__cu_from;					\
-	long __cu_len;							\
-									\
-	__cu_to = (to);							\
-	__cu_from = (from);						\
-	__cu_len = (n);							\
-									\
-	check_object_size(__cu_to, __cu_len, false);			\
-									\
-	if (eva_kernel_access())					\
-		__cu_len = __invoke_copy_from_kernel_inatomic(__cu_to,	\
-							      __cu_from,\
-							      __cu_len);\
-	else								\
-		__cu_len = __invoke_copy_from_user_inatomic(__cu_to,	\
-							    __cu_from,	\
-							    __cu_len);	\
-	__cu_len;							\
-})
+	return __copy_user(to, from, n, from + n);
+}
 
 /*
- * copy_to_user: - Copy a block of data into user space.
- * @to:	  Destination address, in user space.
- * @from: Source address, in kernel space.
+ * __copy_from_user: - Copy a block of data from user space, with less checking.
+ * @to:	  Destination address, in kernel space.
+ * @from: Source address, in user space.
  * @n:	  Number of bytes to copy.
  *
  * Context: User context only. This function may sleep if pagefaults are
  *          enabled.
  *
- * Copy data from kernel space to user space.
+ * Copy data from user space to kernel space.  Caller must check
+ * the specified block with access_ok() before calling this function.
  *
  * Returns number of bytes that could not be copied.
  * On success, this will be zero.
+ *
+ * If some data could not be copied, this function will pad the copied
+ * data to the requested size using zero bytes.
  */
-#define copy_to_user(to, from, n)					\
-({									\
-	void __user *__cu_to;						\
-	const void *__cu_from;						\
-	long __cu_len;							\
-									\
-	__cu_to = (to);							\
-	__cu_from = (from);						\
-	__cu_len = (n);							\
-									\
-	check_object_size(__cu_from, __cu_len, true);			\
-									\
-	if (eva_kernel_access()) {					\
-		__cu_len = __invoke_copy_to_kernel(__cu_to,		\
-						   __cu_from,		\
-						   __cu_len);		\
-	} else {							\
-		if (access_ok(VERIFY_WRITE, __cu_to, __cu_len)) {       \
-			might_fault();                                  \
-			__cu_len = __invoke_copy_to_user(__cu_to,	\
-							 __cu_from,	\
-							 __cu_len);     \
-		}							\
-	}								\
-	__cu_len;							\
-})
-
-#ifndef CONFIG_EVA
-
-#define __invoke_copy_from_user(to, from, n)				\
-({									\
-	register long __cu_ret_r __asm__("$2");				\
-	register void *__cu_to_r __asm__("$4");				\
-	register const void __user *__cu_from_r __asm__("$5");		\
-	register long __cu_len_r __asm__("$6");				\
-									\
-	__cu_to_r = (to);						\
-	__cu_from_r = (from);						\
-	__cu_len_r = (n);						\
-	__asm__ __volatile__(						\
-	".set\tnoreorder\n\t"						\
-	__MODULE_JAL(__copy_user)					\
-	".set\tnoat\n\t"						\
-	__UA_ADDU "\t$7, %1, %2\n\t"					\
-	".set\tat\n\t"							\
-	".set\treorder"							\
-	: "=r"(__cu_ret_r), "+r" (__cu_to_r),				\
-	  "+r" (__cu_from_r), "+r" (__cu_len_r)				\
-	:								\
-	: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",	\
-	  DADDI_SCRATCH, "memory");					\
-	__cu_ret_r;							\
-})
-
-#define __invoke_copy_from_kernel(to, from, n)				\
-	__invoke_copy_from_user(to, from, n)
-
-/* For userland <-> userland operations */
-#define ___invoke_copy_in_user(to, from, n)				\
-	__invoke_copy_from_user(to, from, n)
-
-/* For kernel <-> kernel operations */
-#define ___invoke_copy_in_kernel(to, from, n)				\
-	__invoke_copy_from_user(to, from, n)
-
-#define __invoke_copy_from_user_inatomic(to, from, n)			\
-({									\
-	register long __cu_ret_r __asm__("$2");				\
-	register void *__cu_to_r __asm__("$4");				\
-	register const void __user *__cu_from_r __asm__("$5");		\
-	register long __cu_len_r __asm__("$6");				\
-									\
-	__cu_to_r = (to);						\
-	__cu_from_r = (from);						\
-	__cu_len_r = (n);						\
-	__asm__ __volatile__(						\
-	".set\tnoreorder\n\t"						\
-	__MODULE_JAL(__copy_user_inatomic)				\
-	".set\tnoat\n\t"						\
-	__UA_ADDU "\t$7, %1, %2\n\t"					\
-	".set\tat\n\t"							\
-	".set\treorder"							\
-	: "=r"(__cu_ret_r), "+r" (__cu_to_r),				\
-	  "+r" (__cu_from_r), "+r" (__cu_len_r)				\
-	:								\
-	: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",	\
-	  DADDI_SCRATCH, "memory");					\
-	__cu_ret_r;							\
-})
-
-#define __invoke_copy_from_kernel_inatomic(to, from, n)			\
-	__invoke_copy_from_user_inatomic(to, from, n)			\
-
-#else
-
-/* EVA specific functions */
-
-extern size_t __copy_user_inatomic_eva(void *__to, const void *__from,
-				       size_t __n, const void *__from_end);
-extern size_t __copy_from_user_eva(void *__to, const void *__from,
-				   size_t __n, const void *__from_end);
-extern size_t __copy_to_user_eva(void *__to, const void *__from,
-				 size_t __n, const void *__from_end);
-extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n,
-				 const void *__from_end);
-
-#define __invoke_copy_from_user_eva_generic(to, from, n, func_ptr)	\
-({									\
-	register long __cu_ret_r __asm__("$2");				\
-	register void *__cu_to_r __asm__("$4");				\
-	register const void __user *__cu_from_r __asm__("$5");		\
-	register long __cu_len_r __asm__("$6");				\
-									\
-	__cu_to_r = (to);						\
-	__cu_from_r = (from);						\
-	__cu_len_r = (n);						\
-	__asm__ __volatile__(						\
-	".set\tnoreorder\n\t"						\
-	__MODULE_JAL(func_ptr)						\
-	".set\tnoat\n\t"						\
-	__UA_ADDU "\t$7, %1, %2\n\t"					\
-	".set\tat\n\t"							\
-	".set\treorder"							\
-	: "=r"(__cu_ret_r), "+r" (__cu_to_r),				\
-	  "+r" (__cu_from_r), "+r" (__cu_len_r)				\
-	:								\
-	: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",	\
-	  DADDI_SCRATCH, "memory");					\
-	__cu_ret_r;							\
-})
-
-#define __invoke_copy_to_user_eva_generic(to, from, n, func_ptr)	\
-({									\
-	register long __cu_ret_r __asm__("$2");				\
-	register void *__cu_to_r __asm__("$4");				\
-	register const void __user *__cu_from_r __asm__("$5");		\
-	register long __cu_len_r __asm__("$6");				\
-									\
-	__cu_to_r = (to);						\
-	__cu_from_r = (from);						\
-	__cu_len_r = (n);						\
-	__asm__ __volatile__(						\
-	__MODULE_JAL(func_ptr)						\
-	: "=r"(__cu_ret_r), "+r" (__cu_to_r),				\
-	  "+r" (__cu_from_r), "+r" (__cu_len_r)				\
-	:								\
-	: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",	\
-	  DADDI_SCRATCH, "memory");					\
-	__cu_ret_r;							\
-})
-
-/*
- * Source or destination address is in userland. We need to go through
- * the TLB
- */
-#define __invoke_copy_from_user(to, from, n)				\
-	__invoke_copy_from_user_eva_generic(to, from, n, __copy_from_user_eva)
+static inline unsigned long __must_check
+__copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	check_object_size(to, n, false);
+	might_fault();
 
-#define __invoke_copy_from_user_inatomic(to, from, n)			\
-	__invoke_copy_from_user_eva_generic(to, from, n,		\
-					    __copy_user_inatomic_eva)
+	if (eva_user_access())
+		return __copy_from_user_eva(to, from, n, from + n);
 
-#define __invoke_copy_to_user(to, from, n)				\
-	__invoke_copy_to_user_eva_generic(to, from, n, __copy_to_user_eva)
+	return __copy_user(to, from, n, from + n);
+}
 
-#define ___invoke_copy_in_user(to, from, n)				\
-	__invoke_copy_from_user_eva_generic(to, from, n, __copy_in_user_eva)
+static inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	check_object_size(from, n, true);
 
-/*
- * Source or destination address in the kernel. We are not going through
- * the TLB
- */
-#define __invoke_copy_from_kernel(to, from, n)				\
-	__invoke_copy_from_user_eva_generic(to, from, n, __copy_user)
+	if (eva_user_access())
+		return __copy_to_user_eva(to, from, n, from + n);
 
-#define __invoke_copy_from_kernel_inatomic(to, from, n)			\
-	__invoke_copy_from_user_eva_generic(to, from, n, __copy_user_inatomic)
+	return __copy_user(to, from, n, from + n);
+}
 
-#define __invoke_copy_to_kernel(to, from, n)				\
-	__invoke_copy_to_user_eva_generic(to, from, n, __copy_user)
+static inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	check_object_size(to, n, false);
 
-#define ___invoke_copy_in_kernel(to, from, n)				\
-	__invoke_copy_from_user_eva_generic(to, from, n, __copy_user)
+	if (eva_user_access())
+		return __copy_user_inatomic_eva(to, from, n, from + n);
 
-#endif /* CONFIG_EVA */
+	return __copy_user_inatomic(to, from, n, from + n);
+}
 
 /*
- * __copy_from_user: - Copy a block of data from user space, with less checking.
- * @to:	  Destination address, in kernel space.
- * @from: Source address, in user space.
+ * copy_to_user: - Copy a block of data into user space.
+ * @to:	  Destination address, in user space.
+ * @from: Source address, in kernel space.
  * @n:	  Number of bytes to copy.
  *
  * Context: User context only. This function may sleep if pagefaults are
  *          enabled.
  *
- * Copy data from user space to kernel space.  Caller must check
- * the specified block with access_ok() before calling this function.
+ * Copy data from kernel space to user space.
  *
  * Returns number of bytes that could not be copied.
  * On success, this will be zero.
- *
- * If some data could not be copied, this function will pad the copied
- * data to the requested size using zero bytes.
  */
-#define __copy_from_user(to, from, n)					\
-({									\
-	void *__cu_to;							\
-	const void __user *__cu_from;					\
-	long __cu_len;							\
-									\
-	__cu_to = (to);							\
-	__cu_from = (from);						\
-	__cu_len = (n);							\
-									\
-	check_object_size(__cu_to, __cu_len, false);			\
-									\
-	if (eva_kernel_access()) {					\
-		__cu_len = __invoke_copy_from_kernel(__cu_to,		\
-						     __cu_from,		\
-						     __cu_len);		\
-	} else {							\
-		might_fault();						\
-		__cu_len = __invoke_copy_from_user(__cu_to, __cu_from,	\
-						   __cu_len);		\
-	}								\
-	__cu_len;							\
-})
+static inline unsigned long __must_check
+copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	if (!access_ok(VERIFY_WRITE, to, n))
+		return n;
+
+	return __copy_to_user(to, from, n);
+}
 
 /*
  * copy_from_user: - Copy a block of data from user space.
@@ -1181,78 +948,38 @@ extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n,
  * If some data could not be copied, this function will pad the copied
  * data to the requested size using zero bytes.
  */
-#define copy_from_user(to, from, n)					\
-({									\
-	void *__cu_to;							\
-	const void __user *__cu_from;					\
-	long __cu_len;							\
-									\
-	__cu_to = (to);							\
-	__cu_from = (from);						\
-	__cu_len = (n);							\
-									\
-	check_object_size(__cu_to, __cu_len, false);			\
-									\
-	if (eva_kernel_access()) {					\
-		__cu_len = __invoke_copy_from_kernel(__cu_to,		\
-						     __cu_from,		\
-						     __cu_len);		\
-	} else {							\
-		if (access_ok(VERIFY_READ, __cu_from, __cu_len)) {	\
-			might_fault();                                  \
-			__cu_len = __invoke_copy_from_user(__cu_to,	\
-							   __cu_from,	\
-							   __cu_len);   \
-		} else {						\
-			memset(__cu_to, 0, __cu_len);			\
-		}							\
-	}								\
-	__cu_len;							\
-})
+static inline unsigned long __must_check
+copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	if (!access_ok(VERIFY_READ, from, n)) {
+		memset(to, 0, n);
+		return n;
+	}
 
-#define __copy_in_user(to, from, n)					\
-({									\
-	void __user *__cu_to;						\
-	const void __user *__cu_from;					\
-	long __cu_len;							\
-									\
-	__cu_to = (to);							\
-	__cu_from = (from);						\
-	__cu_len = (n);							\
-	if (eva_kernel_access()) {					\
-		__cu_len = ___invoke_copy_in_kernel(__cu_to, __cu_from,	\
-						    __cu_len);		\
-	} else {							\
-		might_fault();						\
-		__cu_len = ___invoke_copy_in_user(__cu_to, __cu_from,	\
-						  __cu_len);		\
-	}								\
-	__cu_len;							\
-})
+	return __copy_from_user(to, from, n);
+}
 
-#define copy_in_user(to, from, n)					\
-({									\
-	void __user *__cu_to;						\
-	const void __user *__cu_from;					\
-	long __cu_len;							\
-									\
-	__cu_to = (to);							\
-	__cu_from = (from);						\
-	__cu_len = (n);							\
-	if (eva_kernel_access()) {					\
-		__cu_len = ___invoke_copy_in_kernel(__cu_to,__cu_from,	\
-						    __cu_len);		\
-	} else {							\
-		if (likely(access_ok(VERIFY_READ, __cu_from, __cu_len) &&\
-			   access_ok(VERIFY_WRITE, __cu_to, __cu_len))) {\
-			might_fault();					\
-			__cu_len = ___invoke_copy_in_user(__cu_to,	\
-							  __cu_from,	\
-							  __cu_len);	\
-		}							\
-	}								\
-	__cu_len;							\
-})
+static inline unsigned long __must_check
+__copy_in_user(void __user *to, const void __user *from, unsigned long n)
+{
+	might_fault();
+
+	if (eva_user_access())
+		return __copy_in_user_eva(to, from, n, from + n);
+
+	return __copy_user(to, from, n, from + n);
+}
+
+static inline unsigned long __must_check
+copy_in_user(void __user *to, const void __user *from, unsigned long n)
+{
+	if (unlikely(!access_ok(VERIFY_READ, from, n)))
+		return n;
+	if (unlikely(!access_ok(VERIFY_WRITE, to, n)))
+		return n;
+
+	return __copy_in_user(to, from, n);
+}
 
 /*
  * __clear_user: - Zero a block of memory in user space, with less checking.
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 5af9f03..dbd7013 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -56,8 +56,6 @@
  *     - src is readable  (no exceptions when reading src)
  *   copy_from_user
  *     - dst is writable  (no exceptions when writing dst)
- * __copy_user uses a non-standard calling convention; see
- * include/asm-mips/uaccess.h
  *
  * When an exception happens on a load, the handler must
  # ensure that all of the destination buffer is overwritten to prevent
@@ -159,20 +157,6 @@
 #define NBYTES 8
 #define LOG_NBYTES 3
 
-/*
- * As we are sharing code base with the mips32 tree (which use the o32 ABI
- * register definitions). We need to redefine the register definitions from
- * the n64 ABI register naming to the o32 ABI register naming.
- */
-#undef t0
-#undef t1
-#undef t2
-#undef t3
-#define t0	$8
-#define t1	$9
-#define t2	$10
-#define t3	$11
-
 #else
 
 #define LOADK lw /* No exception */
-- 
2.10.2
