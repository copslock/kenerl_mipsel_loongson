Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:29:31 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43596 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870548AbaA0UXrEVk3B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:23:47 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 28/58] MIPS: asm: uaccess: Add EVA support to copy_{in, to,from}_user
Date:   Mon, 27 Jan 2014 20:19:15 +0000
Message-ID: <1390853985-14246-29-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_23_42
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Use the EVA specific functions from memcpy.S to perform
userspace operations. When get_fs() == get_ds() the usual load/store
instructions are used because the destination address is located in
the kernel address space region. Otherwise, the EVA specifc load/store
instructions are used which will go through th TLB to perform the virtual
to physical translation for the userspace address.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/uaccess.h | 191 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 171 insertions(+), 20 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 59bbebb..fe72837 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -781,6 +781,7 @@ extern void __put_user_unaligned_unknown(void);
 
 extern size_t __copy_user(void *__to, const void *__from, size_t __n);
 
+#ifndef CONFIG_EVA
 #define __invoke_copy_to_user(to, from, n)				\
 ({									\
 	register void __user *__cu_to_r __asm__("$4");			\
@@ -799,6 +800,11 @@ extern size_t __copy_user(void *__to, const void *__from, size_t __n);
 	__cu_len_r;							\
 })
 
+#define __invoke_copy_to_kernel(to, from, n)				\
+	__invoke_copy_to_user(to, from, n)
+
+#endif
+
 /*
  * __copy_to_user: - Copy a block of data into user space, with less checking.
  * @to:	  Destination address, in user space.
@@ -823,7 +829,12 @@ extern size_t __copy_user(void *__to, const void *__from, size_t __n);
 	__cu_from = (from);						\
 	__cu_len = (n);							\
 	might_fault();							\
-	__cu_len = __invoke_copy_to_user(__cu_to, __cu_from, __cu_len); \
+	if (segment_eq(get_fs(), get_ds()))				\
+		__cu_len = __invoke_copy_to_kernel(__cu_to, __cu_from,	\
+						   __cu_len);		\
+	else								\
+		__cu_len = __invoke_copy_to_user(__cu_to, __cu_from,	\
+						 __cu_len);		\
 	__cu_len;							\
 })
 
@@ -838,7 +849,12 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	__cu_len = __invoke_copy_to_user(__cu_to, __cu_from, __cu_len); \
+	if (segment_eq(get_fs(), get_ds()))				\
+		__cu_len = __invoke_copy_to_kernel(__cu_to, __cu_from,	\
+						   __cu_len);		\
+	else								\
+		__cu_len = __invoke_copy_to_user(__cu_to, __cu_from,	\
+						 __cu_len);		\
 	__cu_len;							\
 })
 
@@ -851,8 +867,14 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	__cu_len = __invoke_copy_from_user_inatomic(__cu_to, __cu_from, \
-						    __cu_len);		\
+	if (segment_eq(get_fs(), get_ds()))				\
+		__cu_len = __invoke_copy_from_kernel_inatomic(__cu_to,	\
+							      __cu_from,\
+							      __cu_len);\
+	else								\
+		__cu_len = __invoke_copy_from_user_inatomic(__cu_to,	\
+							    __cu_from,	\
+							    __cu_len);	\
 	__cu_len;							\
 })
 
@@ -878,14 +900,23 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	if (access_ok(VERIFY_WRITE, __cu_to, __cu_len)) {		\
-		might_fault();						\
-		__cu_len = __invoke_copy_to_user(__cu_to, __cu_from,	\
-						 __cu_len);		\
+	if (segment_eq(get_fs(), get_ds())) {				\
+		__cu_len = __invoke_copy_to_kernel(__cu_to,		\
+						   __cu_from,		\
+						   __cu_len);		\
+	} else {							\
+		if (access_ok(VERIFY_WRITE, __cu_to, __cu_len)) {       \
+			might_fault();                                  \
+			__cu_len = __invoke_copy_to_user(__cu_to,	\
+							 __cu_from,	\
+							 __cu_len);     \
+		}							\
 	}								\
 	__cu_len;							\
 })
 
+#ifndef CONFIG_EVA
+
 #define __invoke_copy_from_user(to, from, n)				\
 ({									\
 	register void *__cu_to_r __asm__("$4");				\
@@ -909,6 +940,17 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_len_r;							\
 })
 
+#define __invoke_copy_from_kernel(to, from, n)				\
+	__invoke_copy_from_user(to, from, n)
+
+/* For userland <-> userland operations */
+#define ___invoke_copy_in_user(to, from, n)				\
+	__invoke_copy_from_user(to, from, n)
+
+/* For kernel <-> kernel operations */
+#define ___invoke_copy_in_kernel(to, from, n)				\
+	__invoke_copy_from_user(to, from, n)
+
 #define __invoke_copy_from_user_inatomic(to, from, n)			\
 ({									\
 	register void *__cu_to_r __asm__("$4");				\
@@ -932,6 +974,97 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_len_r;							\
 })
 
+#define __invoke_copy_from_kernel_inatomic(to, from, n)			\
+	__invoke_copy_from_user_inatomic(to, from, n)			\
+
+#else
+
+/* EVA specific functions */
+
+extern size_t __copy_user_inatomic_eva(void *__to, const void *__from,
+				       size_t __n);
+extern size_t __copy_from_user_eva(void *__to, const void *__from,
+				   size_t __n);
+extern size_t __copy_to_user_eva(void *__to, const void *__from,
+				 size_t __n);
+extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n);
+
+#define __invoke_copy_from_user_eva_generic(to, from, n, func_ptr)	\
+({									\
+	register void *__cu_to_r __asm__("$4");				\
+	register const void __user *__cu_from_r __asm__("$5");		\
+	register long __cu_len_r __asm__("$6");				\
+									\
+	__cu_to_r = (to);						\
+	__cu_from_r = (from);						\
+	__cu_len_r = (n);						\
+	__asm__ __volatile__(						\
+	".set\tnoreorder\n\t"						\
+	__MODULE_JAL(func_ptr)						\
+	".set\tnoat\n\t"						\
+	__UA_ADDU "\t$1, %1, %2\n\t"					\
+	".set\tat\n\t"							\
+	".set\treorder"							\
+	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
+	:								\
+	: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",	\
+	  DADDI_SCRATCH, "memory");					\
+	__cu_len_r;							\
+})
+
+#define __invoke_copy_to_user_eva_generic(to, from, n, func_ptr)	\
+({									\
+	register void *__cu_to_r __asm__("$4");				\
+	register const void __user *__cu_from_r __asm__("$5");		\
+	register long __cu_len_r __asm__("$6");				\
+									\
+	__cu_to_r = (to);						\
+	__cu_from_r = (from);						\
+	__cu_len_r = (n);						\
+	__asm__ __volatile__(						\
+	__MODULE_JAL(func_ptr)						\
+	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
+	:								\
+	: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",	\
+	  DADDI_SCRATCH, "memory");					\
+	__cu_len_r;							\
+})
+
+/*
+ * Source or destination address is in userland. We need to go through
+ * the TLB
+ */
+#define __invoke_copy_from_user(to, from, n)				\
+	__invoke_copy_from_user_eva_generic(to, from, n, __copy_from_user_eva)
+
+#define __invoke_copy_from_user_inatomic(to, from, n)			\
+	__invoke_copy_from_user_eva_generic(to, from, n,		\
+					    __copy_user_inatomic_eva)
+
+#define __invoke_copy_to_user(to, from, n)				\
+	__invoke_copy_to_user_eva_generic(to, from, n, __copy_to_user_eva)
+
+#define ___invoke_copy_in_user(to, from, n)				\
+	__invoke_copy_from_user_eva_generic(to, from, n, __copy_in_user_eva)
+
+/*
+ * Source or destination address in the kernel. We are not going through
+ * the TLB
+ */
+#define __invoke_copy_from_kernel(to, from, n)				\
+	__invoke_copy_from_user_eva_generic(to, from, n, __copy_user)
+
+#define __invoke_copy_from_kernel_inatomic(to, from, n)			\
+	__invoke_copy_from_user_eva_generic(to, from, n, __copy_user_inatomic)
+
+#define __invoke_copy_to_kernel(to, from, n)				\
+	__invoke_copy_to_user_eva_generic(to, from, n, __copy_user)
+
+#define ___invoke_copy_in_kernel(to, from, n)				\
+	__invoke_copy_from_user_eva_generic(to, from, n, __copy_user)
+
+#endif /* CONFIG_EVA */
+
 /*
  * __copy_from_user: - Copy a block of data from user space, with less checking.
  * @to:	  Destination address, in kernel space.
@@ -989,10 +1122,17 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	if (access_ok(VERIFY_READ, __cu_from, __cu_len)) {		\
-		might_fault();						\
-		__cu_len = __invoke_copy_from_user(__cu_to, __cu_from,	\
-						   __cu_len);		\
+	if (segment_eq(get_fs(), get_ds())) {				\
+		__cu_len = __invoke_copy_from_kernel(__cu_to,		\
+						     __cu_from,		\
+						     __cu_len);		\
+	} else {							\
+		if (access_ok(VERIFY_READ, __cu_from, __cu_len)) {	\
+			might_fault();                                  \
+			__cu_len = __invoke_copy_from_user(__cu_to,	\
+							   __cu_from,	\
+							   __cu_len);   \
+		}							\
 	}								\
 	__cu_len;							\
 })
@@ -1006,9 +1146,14 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	might_fault();							\
-	__cu_len = __invoke_copy_from_user(__cu_to, __cu_from,		\
-					   __cu_len);			\
+	if (segment_eq(get_fs(), get_ds())) {				\
+		__cu_len = ___invoke_copy_in_kernel(__cu_to, __cu_from,	\
+						    __cu_len);		\
+	} else {							\
+		might_fault();						\
+		__cu_len = ___invoke_copy_in_user(__cu_to, __cu_from,	\
+						  __cu_len);		\
+	}								\
 	__cu_len;							\
 })
 
@@ -1021,11 +1166,17 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	if (likely(access_ok(VERIFY_READ, __cu_from, __cu_len) &&	\
-		   access_ok(VERIFY_WRITE, __cu_to, __cu_len))) {	\
-		might_fault();						\
-		__cu_len = __invoke_copy_from_user(__cu_to, __cu_from,	\
-						   __cu_len);		\
+	if (segment_eq(get_fs(), get_ds())) {				\
+		__cu_len = ___invoke_copy_in_kernel(__cu_to,__cu_from,	\
+						    __cu_len);		\
+	} else {							\
+		if (likely(access_ok(VERIFY_READ, __cu_from, __cu_len) &&\
+			   access_ok(VERIFY_WRITE, __cu_to, __cu_len))) {\
+			might_fault();					\
+			__cu_len = ___invoke_copy_in_user(__cu_to,	\
+							  __cu_from,	\
+							  __cu_len);	\
+		}							\
 	}								\
 	__cu_len;							\
 })
-- 
1.8.5.3
