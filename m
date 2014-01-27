Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:29:12 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43591 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827334AbaA0UXl6KER6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:23:41 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 26/58] MIPS: asm: uaccess: Use EVA instructions wrappers
Date:   Mon, 27 Jan 2014 20:19:13 +0000
Message-ID: <1390853985-14246-27-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_23_37
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39145
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

Use the EVA instruction wrappers from asm.h to perform
read/write operations from userland.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/uaccess.h | 133 ++++++++++++++++++++++++++++++++--------
 1 file changed, 109 insertions(+), 24 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 9c6f5ce..522fc41 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -6,6 +6,7 @@
  * Copyright (C) 1996, 1997, 1998, 1999, 2000, 03, 04 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Copyright (C) 2007  Maciej W. Rozycki
+ * Copyright (C) 2014, Imagination Technologies Ltd.
  */
 #ifndef _ASM_UACCESS_H
 #define _ASM_UACCESS_H
@@ -13,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/thread_info.h>
+#include <asm/asm.h>
 
 /*
  * The fs value determines whether argument validity checking should be
@@ -222,11 +224,44 @@ struct __large_struct { unsigned long buf[100]; };
  * Yuck.  We need two variants, one for 64bit operation and one
  * for 32 bit mode and old iron.
  */
+#ifndef CONFIG_EVA
+#define __get_kernel_common(val, size, ptr) __get_user_common(val, size, ptr)
+#else
+/*
+ * Kernel specific functions for EVA. We need to use normal load instructions
+ * to read data from kernel when operating in EVA mode. We use these macros to
+ * avoid redefining __get_user_asm for EVA.
+ */
+#undef _loadd
+#undef _loadw
+#undef _loadh
+#undef _loadb
+#ifdef CONFIG_32BIT
+#define _loadd			_loadw
+#else
+#define _loadd(reg, addr)	"ld " reg ", " addr
+#endif
+#define _loadw(reg, addr)	"lw " reg ", " addr
+#define _loadh(reg, addr)	"lh " reg ", " addr
+#define _loadb(reg, addr)	"lb " reg ", " addr
+
+#define __get_kernel_common(val, size, ptr)				\
+do {									\
+	switch (size) {							\
+	case 1: __get_user_asm(val, _loadb, ptr); break;		\
+	case 2: __get_user_asm(val, _loadh, ptr); break;		\
+	case 4: __get_user_asm(val, _loadw, ptr); break;		\
+	case 8: __GET_USER_DW(val, _loadd, ptr); break;			\
+	default: __get_user_unknown(); break;				\
+	}								\
+} while (0)
+#endif
+
 #ifdef CONFIG_32BIT
 #define __GET_USER_DW(val, insn, ptr) __get_user_asm_ll32(val, insn, ptr)
 #endif
 #ifdef CONFIG_64BIT
-#define __GET_USER_DW(val, insn, ptr) __get_user_asm(val, "ld", ptr)
+#define __GET_USER_DW(val, insn, ptr) __get_user_asm(val, insn, ptr)
 #endif
 
 extern void __get_user_unknown(void);
@@ -234,10 +269,10 @@ extern void __get_user_unknown(void);
 #define __get_user_common(val, size, ptr)				\
 do {									\
 	switch (size) {							\
-	case 1: __get_user_asm(val, "lb", ptr); break;			\
-	case 2: __get_user_asm(val, "lh", ptr); break;			\
-	case 4: __get_user_asm(val, "lw", ptr); break;			\
-	case 8: __GET_USER_DW(val, "lw", ptr); break;			\
+	case 1: __get_user_asm(val, user_lb, ptr); break;		\
+	case 2: __get_user_asm(val, user_lh, ptr); break;		\
+	case 4: __get_user_asm(val, user_lw, ptr); break;		\
+	case 8: __GET_USER_DW(val, user_ld, ptr); break;		\
 	default: __get_user_unknown(); break;				\
 	}								\
 } while (0)
@@ -246,8 +281,12 @@ do {									\
 ({									\
 	int __gu_err;							\
 									\
-	__chk_user_ptr(ptr);						\
-	__get_user_common((x), size, ptr);				\
+	if (segment_eq(get_fs(), get_ds())) {				\
+		__get_kernel_common((x), size, ptr);			\
+	} else {							\
+		__chk_user_ptr(ptr);					\
+		__get_user_common((x), size, ptr);			\
+	}								\
 	__gu_err;							\
 })
 
@@ -257,8 +296,12 @@ do {									\
 	const __typeof__(*(ptr)) __user * __gu_ptr = (ptr);		\
 									\
 	might_fault();							\
-	if (likely(access_ok(VERIFY_READ,  __gu_ptr, size)))		\
-		__get_user_common((x), size, __gu_ptr);			\
+	if (likely(access_ok(VERIFY_READ,  __gu_ptr, size))) {		\
+		if (segment_eq(get_fs(), get_ds()))			\
+			__get_kernel_common((x), size, __gu_ptr);	\
+		else							\
+			__get_user_common((x), size, __gu_ptr);		\
+	}								\
 									\
 	__gu_err;							\
 })
@@ -268,7 +311,7 @@ do {									\
 	long __gu_tmp;							\
 									\
 	__asm__ __volatile__(						\
-	"1:	" insn "	%1, %3				\n"	\
+	"1:	"insn("%1", "%3")"				\n"	\
 	"2:							\n"	\
 	"	.insn						\n"	\
 	"	.section .fixup,\"ax\"				\n"	\
@@ -295,8 +338,8 @@ do {									\
 	} __gu_tmp;							\
 									\
 	__asm__ __volatile__(						\
-	"1:	" insn "	%1, (%3)			\n"	\
-	"2:	" insn "	%D1, 4(%3)			\n"	\
+	"1:	" insn("%1", "(%3)")"				\n"	\
+	"2:	" insn("%D1", "4(%3)")"				\n"	\
 	"3:							\n"	\
 	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
@@ -315,6 +358,40 @@ do {									\
 	(val) = __gu_tmp.t;						\
 }
 
+#ifndef CONFIG_EVA
+#define __put_kernel_common(ptr, size) __put_user_common(ptr, size)
+#else
+/*
+ * Kernel specific functions for EVA. We need to use normal load instructions
+ * to read data from kernel when operating in EVA mode. We use these macros to
+ * avoid redefining __get_user_asm for EVA.
+ */
+#undef _stored
+#undef _storew
+#undef _storeh
+#undef _storeb
+#ifdef CONFIG_32BIT
+#define _stored			_storew
+#else
+#define _stored(reg, addr)	"ld " reg ", " addr
+#endif
+
+#define _storew(reg, addr)	"sw " reg ", " addr
+#define _storeh(reg, addr)	"sh " reg ", " addr
+#define _storeb(reg, addr)	"sb " reg ", " addr
+
+#define __put_kernel_common(ptr, size)					\
+do {									\
+	switch (size) {							\
+	case 1: __put_user_asm(_storeb, ptr); break;			\
+	case 2: __put_user_asm(_storeh, ptr); break;			\
+	case 4: __put_user_asm(_storew, ptr); break;			\
+	case 8: __PUT_USER_DW(_stored, ptr); break;			\
+	default: __put_user_unknown(); break;				\
+	}								\
+} while(0)
+#endif
+
 /*
  * Yuck.  We need two variants, one for 64bit operation and one
  * for 32 bit mode and old iron.
@@ -323,16 +400,16 @@ do {									\
 #define __PUT_USER_DW(insn, ptr) __put_user_asm_ll32(insn, ptr)
 #endif
 #ifdef CONFIG_64BIT
-#define __PUT_USER_DW(insn, ptr) __put_user_asm("sd", ptr)
+#define __PUT_USER_DW(insn, ptr) __put_user_asm(insn, ptr)
 #endif
 
 #define __put_user_common(ptr, size)					\
 do {									\
 	switch (size) {							\
-	case 1: __put_user_asm("sb", ptr); break;			\
-	case 2: __put_user_asm("sh", ptr); break;			\
-	case 4: __put_user_asm("sw", ptr); break;			\
-	case 8: __PUT_USER_DW("sw", ptr); break;			\
+	case 1: __put_user_asm(user_sb, ptr); break;			\
+	case 2: __put_user_asm(user_sh, ptr); break;			\
+	case 4: __put_user_asm(user_sw, ptr); break;			\
+	case 8: __PUT_USER_DW(user_sd, ptr); break;			\
 	default: __put_user_unknown(); break;				\
 	}								\
 } while (0)
@@ -342,9 +419,13 @@ do {									\
 	__typeof__(*(ptr)) __pu_val;					\
 	int __pu_err = 0;						\
 									\
-	__chk_user_ptr(ptr);						\
 	__pu_val = (x);							\
-	__put_user_common(ptr, size);					\
+	if (segment_eq(get_fs(), get_ds())) {				\
+		__put_kernel_common(ptr, size);				\
+	} else {							\
+		__chk_user_ptr(ptr);					\
+		__put_user_common(ptr, size);				\
+	}								\
 	__pu_err;							\
 })
 
@@ -355,8 +436,12 @@ do {									\
 	int __pu_err = -EFAULT;						\
 									\
 	might_fault();							\
-	if (likely(access_ok(VERIFY_WRITE,  __pu_addr, size)))		\
-		__put_user_common(__pu_addr, size);			\
+	if (likely(access_ok(VERIFY_WRITE,  __pu_addr, size))) {	\
+		if (segment_eq(get_fs(), get_ds()))			\
+			__put_kernel_common(__pu_addr, size);		\
+		else							\
+			__put_user_common(__pu_addr, size);		\
+	}								\
 									\
 	__pu_err;							\
 })
@@ -364,7 +449,7 @@ do {									\
 #define __put_user_asm(insn, ptr)					\
 {									\
 	__asm__ __volatile__(						\
-	"1:	" insn "	%z2, %3		# __put_user_asm\n"	\
+	"1:	"insn("%z2", "%3")"	# __put_user_asm	\n"	\
 	"2:							\n"	\
 	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
@@ -382,8 +467,8 @@ do {									\
 #define __put_user_asm_ll32(insn, ptr)					\
 {									\
 	__asm__ __volatile__(						\
-	"1:	" insn "	%2, (%3)# __put_user_asm_ll32	\n"	\
-	"2:	" insn "	%D2, 4(%3)			\n"	\
+	"1:	"insn("%2", "(%3)")"	# __put_user_asm_ll32	\n"	\
+	"2:	"insn("%D2", "4(%3)")"				\n"	\
 	"3:							\n"	\
 	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
-- 
1.8.5.3
