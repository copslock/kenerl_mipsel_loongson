Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Sep 2004 18:10:39 +0100 (BST)
Received: from p508B7085.dip.t-dialin.net ([IPv6:::ffff:80.139.112.133]:49003
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224937AbUITRKY>; Mon, 20 Sep 2004 18:10:24 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i8KHALYR025878;
	Mon, 20 Sep 2004 19:10:21 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i8KHALlk025877;
	Mon, 20 Sep 2004 19:10:21 +0200
Date: Mon, 20 Sep 2004 19:10:21 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: gcc 3.3.4/3.4.1 and get_user
Message-ID: <20040920171021.GA25371@linux-mips.org>
References: <20040901.012223.59462025.anemo@mba.ocn.ne.jp> <87656yqsmz.fsf@redhat.com> <20040920154042.GB5150@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040920154042.GB5150@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 20, 2004 at 05:40:42PM +0200, Ralf Baechle wrote:

> The purpose of this was to avoid a warning about __gu_val possibly being
> used uninitialized without inflating the code.  I've got a better solution
> that'll actually shrinks the code size of my defconfig build by 5448
> bytes.  Untested patch below.

And here the same for 2.4.  Actually this is a straight backport of the
2.6 uaccess.h to 2.4 so with this patch include/asm-mips/uaccess.h and
include/asm-mips64/uaccess.h are going to be identical.

  Ralf

Index: include/asm-mips/uaccess.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/uaccess.h,v
retrieving revision 1.19.2.2
diff -u -r1.19.2.2 uaccess.h
--- include/asm-mips/uaccess.h	14 Sep 2003 20:55:20 -0000	1.19.2.2
+++ include/asm-mips/uaccess.h	20 Sep 2004 17:04:42 -0000
@@ -3,19 +3,17 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1996, 1997, 1998, 1999, 2000, 03 by Ralf Baechle
+ * Copyright (C) 1996, 1997, 1998, 1999, 2000, 03, 04 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
 #ifndef _ASM_UACCESS_H
 #define _ASM_UACCESS_H
 
+#include <linux/config.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 
-#define STR(x)  __STR(x)
-#define __STR(x)  #x
-
 /*
  * The fs value determines whether argument validity checking should be
  * performed or not.  If get_fs() == USER_DS, checking is performed, with
@@ -23,15 +21,47 @@
  *
  * For historical reasons, these macros are grossly misnamed.
  */
-#define KERNEL_DS	((mm_segment_t) { (unsigned long) 0L })
-#define USER_DS		((mm_segment_t) { (unsigned long) -1L })
+#ifdef CONFIG_MIPS32
+
+#define __UA_LIMIT	0x80000000UL
+
+#define __UA_ADDR	".word"
+#define __UA_LA		"la"
+#define __UA_ADDU	"addu"
+#define __UA_t0		"$8"
+#define __UA_t1		"$9"
+
+#endif /* CONFIG_MIPS32 */
+
+#ifdef CONFIG_MIPS64
+
+#define __UA_LIMIT	(- TASK_SIZE)
+
+#define __UA_ADDR	".dword"
+#define __UA_LA		"dla"
+#define __UA_ADDU	"daddu"
+#define __UA_t0		"$12"
+#define __UA_t1		"$13"
+
+#endif /* CONFIG_MIPS64 */
+
+/*
+ * USER_DS is a bitmask that has the bits set that may not be set in a valid
+ * userspace address.  Note that we limit 32-bit userspace to 0x7fff8000 but
+ * the arithmetic we're doing only works if the limit is a power of two, so
+ * we use 0x80000000 here on 32-bit kernels.  If a process passes an invalid
+ * address in this range it's the process's problem, not ours :-)
+ */
+
+#define KERNEL_DS	((mm_segment_t) { 0UL })
+#define USER_DS		((mm_segment_t) { __UA_LIMIT })
 
 #define VERIFY_READ    0
 #define VERIFY_WRITE   1
 
-#define get_fs()        (current->thread.current_ds)
 #define get_ds()	(KERNEL_DS)
-#define set_fs(x)       (current->thread.current_ds=(x))
+#define get_fs()	(current->thread.current_ds)
+#define set_fs(x)	(current->thread.current_ds = (x))
 
 #define segment_eq(a,b)	((a).seg == (b).seg)
 
@@ -45,14 +75,12 @@
  *  - AND "size" doesn't have any high-bits set
  *  - AND "addr+size" doesn't have any high-bits set
  *  - OR we are in kernel mode.
+ *
+ * __ua_size() is a trick to avoid runtime checking of positive constant
+ * sizes; for those we already know at compile time that the size is ok.
  */
 #define __ua_size(size)							\
-	(__builtin_constant_p(size) && (signed long) (size) > 0 ? 0 : (size))
-
-#define __access_ok(addr,size,mask)                                     \
-	(((signed long)((mask)&(addr | (addr + size) | __ua_size(size)))) >= 0)
-
-#define __access_mask ((long)(get_fs().seg))
+	((__builtin_constant_p(size) && (signed long) (size) > 0) ? 0 : (size))
 
 /*
  * access_ok: - Checks if a user space pointer is valid
@@ -73,8 +101,14 @@
  * checks that the pointer is in the user space range - after calling
  * this function, memory access functions may still return -EFAULT.
  */
+
+#define __access_mask get_fs().seg
+
+#define __access_ok(addr, size, mask)					\
+	(((signed long)((mask) & ((addr) | ((addr) + (size)) | __ua_size(size)))) == 0)
+
 #define access_ok(type, addr, size)					\
-	likely(__access_ok((unsigned long)(addr), (size), __access_mask))
+	likely(__access_ok((unsigned long)(addr), (size),__access_mask))
 
 /*
  * verify_area: - Obsolete, use access_ok()
@@ -190,88 +224,84 @@
  * for 32 bit mode and old iron.
  */
 #ifdef __mips64
-#define __GET_USER_DW __get_user_asm("ld")
+#define __GET_USER_DW(__gu_err) __get_user_asm("ld", __gu_err)
 #else
-#define __GET_USER_DW __get_user_asm_ll32
+#define __GET_USER_DW(__gu_err) __get_user_asm_ll32(__gu_err)
 #endif
 
 #define __get_user_nocheck(x,ptr,size)					\
 ({									\
-	long __gu_err;							\
-	__typeof(*(ptr)) __gu_val;					\
+	long __gu_err = 0;						\
+	__typeof(*(ptr)) __gu_val = 0;					\
 	long __gu_addr;							\
-	__asm__("":"=r" (__gu_val));					\
 	__gu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__gu_err));					\
 	switch (size) {							\
-		case 1: __get_user_asm("lb"); break;			\
-		case 2: __get_user_asm("lh"); break;			\
-		case 4: __get_user_asm("lw"); break;			\
-		case 8: __GET_USER_DW; break;				\
-		default: __get_user_unknown(); break;			\
-	} x = (__typeof__(*(ptr))) __gu_val;				\
+	case 1: __get_user_asm("lb", __gu_err); break;			\
+	case 2: __get_user_asm("lh", __gu_err); break;			\
+	case 4: __get_user_asm("lw", __gu_err); break;			\
+	case 8: __GET_USER_DW(__gu_err); break;				\
+	default: __get_user_unknown(); break;				\
+	}								\
+	 x = (__typeof__(*(ptr))) __gu_val;				\
 	__gu_err;							\
 })
 
 #define __get_user_check(x,ptr,size)					\
 ({									\
-	long __gu_err;							\
-	__typeof__(*(ptr)) __gu_val;					\
+	long __gu_err = 0;						\
+	__typeof__(*(ptr)) __gu_val = 0;				\
 	long __gu_addr;							\
-	__asm__("":"=r" (__gu_val));					\
 	__gu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__gu_err));					\
-	if (access_ok(VERIFY_READ, __gu_addr, size)) {			\
+	if (access_ok(VERIFY_READ,__gu_addr,size)) {			\
 		switch (size) {						\
-		case 1: __get_user_asm("lb"); break;			\
-		case 2: __get_user_asm("lh"); break;			\
-		case 4: __get_user_asm("lw"); break;			\
-		case 8: __GET_USER_DW; break;				\
+		case 1: __get_user_asm("lb", __gu_err); break;		\
+		case 2: __get_user_asm("lh", __gu_err); break;		\
+		case 4: __get_user_asm("lw", __gu_err); break;		\
+		case 8: __GET_USER_DW(__gu_err); break;			\
 		default: __get_user_unknown(); break;			\
 		}							\
-	} x = (__typeof__(*(ptr))) __gu_val;				\
-	__gu_err;							\
+	}								\
+	x = (__typeof__(*(ptr))) __gu_val;				\
+	 __gu_err;							\
 })
 
-#define __get_user_asm(insn)						\
+#define __get_user_asm(insn,__gu_err)					\
 ({									\
 	__asm__ __volatile__(						\
-	"1:\t" insn "\t%1,%2\n\t"					\
-	"move\t%0,$0\n"							\
-	"2:\n\t"							\
-	".section\t.fixup,\"ax\"\n"					\
-	"3:\tli\t%0,%3\n\t"						\
-	"move\t%1,$0\n\t"						\
-	"j\t2b\n\t"							\
-	".previous\n\t"							\
-	".section\t__ex_table,\"a\"\n\t"				\
-	".word\t1b,3b\n\t"						\
-	".previous"							\
-	:"=r" (__gu_err), "=r" (__gu_val)				\
-	:"o" (__m(__gu_addr)), "i" (-EFAULT));				\
+	"1:	" insn "	%1, %3				\n"	\
+	"2:							\n"	\
+	"	.section .fixup,\"ax\"				\n"	\
+	"3:	li	%0, %4					\n"	\
+	"	j	2b					\n"	\
+	"	.previous					\n"	\
+	"	.section __ex_table,\"a\"			\n"	\
+	"	"__UA_ADDR "\t1b, 3b				\n"	\
+	"	.previous					\n"	\
+	: "=r" (__gu_err), "=r" (__gu_val)				\
+	: "0" (__gu_err), "o" (__m(__gu_addr)), "i" (-EFAULT));		\
 })
 
 /*
  * Get a long long 64 using 32 bit registers.
  */
-#define __get_user_asm_ll32						\
+#define __get_user_asm_ll32(__gu_err)					\
 ({									\
-__asm__ __volatile__(							\
-	"1:\tlw\t%1,%2\n"						\
-	"2:\tlw\t%D1,%3\n\t"						\
-	"move\t%0,$0\n"							\
-	"3:\t.section\t.fixup,\"ax\"\n"					\
-	"4:\tli\t%0,%4\n\t"						\
-	"move\t%1,$0\n\t"						\
-	"move\t%D1,$0\n\t"						\
-	"j\t3b\n\t"							\
-	".previous\n\t"							\
-	".section\t__ex_table,\"a\"\n\t"				\
-	".word\t1b,4b\n\t"						\
-	".word\t2b,4b\n\t"						\
-	".previous"							\
-	:"=r" (__gu_err), "=&r" (__gu_val)				\
-	:"o" (__m(__gu_addr)), "o" (__m(__gu_addr + 4)),		\
+	__asm__ __volatile__(						\
+	"1:	lw	%1,%2					\n"	\
+	"2:	lw	%D1,%3					\n"	\
+	"	move	%0,$0					\n"	\
+	"3:	.section	.fixup,\"ax\"			\n"	\
+	"4:	li	%0,%4					\n"	\
+	"	move	%1,$0					\n"	\
+	"	move	%D1,$0					\n"	\
+	"	j	3b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b,4b				\n"	\
+	"	" __UA_ADDR "	2b,4b				\n"	\
+	"	.previous					\n"	\
+	: "=r" (__gu_err), "=&r" (__gu_val)				\
+	: "o" (__m(__gu_addr)), "o" (__m(__gu_addr + 4)),		\
 	 "i" (-EFAULT));						\
 })
 
@@ -282,84 +312,81 @@
  * for 32 bit mode and old iron.
  */
 #ifdef __mips64
-#define __PUT_USER_DW __put_user_asm("sd")
+#define __PUT_USER_DW(__pu_val) __put_user_asm("sd", __pu_val)
 #else
-#define __PUT_USER_DW __put_user_asm_ll32
+#define __PUT_USER_DW(__pu_val) __put_user_asm_ll32(__pu_val)
 #endif
 
 #define __put_user_nocheck(x,ptr,size)					\
 ({									\
-	long __pu_err;							\
+	long __pu_err = 0;						\
 	__typeof__(*(ptr)) __pu_val;					\
 	long __pu_addr;							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__pu_err));					\
 	switch (size) {							\
-		case 1: __put_user_asm("sb"); break;			\
-		case 2: __put_user_asm("sh"); break;			\
-		case 4: __put_user_asm("sw"); break;			\
-		case 8: __PUT_USER_DW; break;				\
-		default: __put_user_unknown(); break;			\
+	case 1: __put_user_asm("sb", __pu_val); break;			\
+	case 2: __put_user_asm("sh", __pu_val); break;			\
+	case 4: __put_user_asm("sw", __pu_val); break;			\
+	case 8: __PUT_USER_DW(__pu_val); break;				\
+	default: __put_user_unknown(); break;				\
 	}								\
 	__pu_err;							\
 })
 
 #define __put_user_check(x,ptr,size)					\
 ({									\
-	long __pu_err;							\
+	long __pu_err = 0;						\
 	__typeof__(*(ptr)) __pu_val;					\
 	long __pu_addr;							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__pu_err));					\
 	if (access_ok(VERIFY_WRITE, __pu_addr, size)) {			\
 		switch (size) {						\
-		case 1: __put_user_asm("sb"); break;			\
-		case 2: __put_user_asm("sh"); break;			\
-		case 4: __put_user_asm("sw"); break;			\
-		case 8: __PUT_USER_DW; break;				\
+		case 1: __put_user_asm("sb", __pu_val); break;		\
+		case 2: __put_user_asm("sh", __pu_val); break;		\
+		case 4: __put_user_asm("sw", __pu_val); break;		\
+		case 8: __PUT_USER_DW(__pu_val); break;			\
 		default: __put_user_unknown(); break;			\
 		}							\
 	}								\
 	__pu_err;							\
 })
 
-#define __put_user_asm(insn)						\
+#define __put_user_asm(insn, __pu_val)					\
 ({									\
 	__asm__ __volatile__(						\
-	"1:\t" insn "\t%z1, %2\t\t\t# __put_user_asm\n\t"		\
-	"move\t%0, $0\n"						\
-	"2:\n\t"							\
-	".section\t.fixup,\"ax\"\n"					\
-	"3:\tli\t%0, %3\n\t"						\
-	"j\t2b\n\t"							\
-	".previous\n\t"							\
-	".section\t__ex_table,\"a\"\n\t"				\
-	".word\t1b, 3b\n\t"						\
-	".previous"							\
+	"1:	" insn "	%z1, %2		# __put_user_asm\n"	\
+	"2:							\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
+	"3:	li	%0,%3					\n"	\
+	"	j	2b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 3b				\n"	\
+	"	.previous					\n"	\
 	:"=r" (__pu_err)						\
 	:"Jr" (__pu_val), "o" (__m(__pu_addr)), "i" (-EFAULT));		\
 })
 
-#define __put_user_asm_ll32						\
+#define __put_user_asm_ll32(__pu_val)					\
 ({									\
-__asm__ __volatile__(							\
-	"1:\tsw\t%1, %2\t\t\t# __put_user_asm_ll32\n\t"			\
-	"2:\tsw\t%D1, %3\n"						\
-	"move\t%0, $0\n"						\
-	"3:\n\t"							\
-	".section\t.fixup,\"ax\"\n"					\
-	"4:\tli\t%0, %4\n\t"						\
-	"j\t3b\n\t"							\
-	".previous\n\t"							\
-	".section\t__ex_table,\"a\"\n\t"				\
-	".word\t1b,4b\n\t"						\
-	".word\t2b,4b\n\t"						\
-	".previous"							\
+	__asm__ __volatile__(						\
+	"1:	sw	%1, %2		# __put_user_asm_ll32	\n"	\
+	"2:	sw	%D1, %3					\n"	\
+	"	move	%0, $0					\n"	\
+	"3:							\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
+	"4:	li	%0, %4					\n"	\
+	"	j	3b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 4b				\n"	\
+	"	" __UA_ADDR "	2b, 4b				\n"	\
+	"	.previous"						\
 	:"=r" (__pu_err)						\
-	:"r" (__pu_val), "o" (__m(__pu_addr)), "o" (__m(__pu_addr + 4)),\
-	 "i" (-EFAULT));						\
+	:"r" (__pu_val), "o" (__m(__pu_addr)),				\
+	 "o" (__m(__pu_addr + 4)), "i" (-EFAULT));			\
 })
 
 extern void __put_user_unknown(void);
@@ -371,7 +398,7 @@
 #ifdef MODULE
 #define __MODULE_JAL(destination)					\
 	".set\tnoat\n\t"						\
-	"la\t$1, " #destination "\n\t"					\
+	__UA_LA "\t$1, " #destination "\n\t" 				\
 	"jalr\t$1\n\t"							\
 	".set\tat\n\t"
 #else
@@ -426,6 +453,9 @@
 	__cu_len;							\
 })
 
+#define __copy_to_user_inatomic __copy_to_user
+#define __copy_from_user_inatomic __copy_from_user
+
 /*
  * copy_to_user: - Copy a block of data into user space.
  * @to:   Destination address, in user space.
@@ -467,9 +497,10 @@
 	".set\tnoreorder\n\t"						\
 	__MODULE_JAL(__copy_user)					\
 	".set\tnoat\n\t"						\
-	"addu\t$1, %1, %2\n\t"						\
+	__UA_ADDU "\t$1, %1, %2\n\t"					\
 	".set\tat\n\t"							\
 	".set\treorder\n\t"						\
+	"move\t%0, $6"		/* XXX */				\
 	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$15", "$24", "$31",		\
@@ -538,6 +569,24 @@
 	__cu_len;							\
 })
 
+#define __copy_in_user(to, from, n)	__copy_from_user(to, from, n)
+
+#define copy_in_user(to,from,n)						\
+({									\
+	void *__cu_to;							\
+	const void *__cu_from;						\
+	long __cu_len;							\
+									\
+	__cu_to = (to);							\
+	__cu_from = (from);						\
+	__cu_len = (n);							\
+	if (likely(access_ok(VERIFY_READ, __cu_from, __cu_len) &&	\
+	           access_ok(VERIFY_WRITE, __cu_to, __cu_len)))		\
+		__cu_len = __invoke_copy_from_user(__cu_to, __cu_from,	\
+		                                   __cu_len);		\
+	__cu_len;							\
+})
+
 /*
  * __clear_user: - Zero a block of memory in user space, with less checking.
  * @to:   Destination address, in user space.
@@ -562,7 +611,7 @@
 		"move\t%0, $6"
 		: "=r" (res)
 		: "r" (addr), "r" (size)
-		: "$4", "$5", "$6", "$8", "$9", "$31");
+		: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
 
 	return res;
 }
@@ -610,7 +659,7 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (__to), "r" (__from), "r" (__len)
-		: "$2", "$3", "$4", "$5", "$6", "$8", "$31", "memory");
+		: "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
 
 	return res;
 }
@@ -646,7 +695,7 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (__to), "r" (__from), "r" (__len)
-		: "$2", "$3", "$4", "$5", "$6", "$8", "$31", "memory");
+		: "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
 
 	return res;
 }
@@ -662,7 +711,7 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (s)
-		: "$2", "$4", "$8", "$31");
+		: "$2", "$4", __UA_t0, "$31");
 
 	return res;
 }
@@ -691,7 +740,24 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (s)
-		: "$2", "$4", "$8", "$31");
+		: "$2", "$4", __UA_t0, "$31");
+
+	return res;
+}
+
+/* Returns: 0 if bad, string length+1 (memory size) of string if ok */
+static inline long __strnlen_user(const char *s, long n)
+{
+	long res;
+
+	__asm__ __volatile__(
+		"move\t$4, %1\n\t"
+		"move\t$5, %2\n\t"
+		__MODULE_JAL(__strnlen_user_nocheck_asm)
+		"move\t%0, $2"
+		: "=r" (res)
+		: "r" (s), "r" (n)
+		: "$2", "$4", "$5", __UA_t0, "$31");
 
 	return res;
 }
@@ -699,13 +765,16 @@
 /*
  * strlen_user: - Get the size of a string in user space.
  * @str: The string to measure.
- * @n:   The maximum valid length
+ *
+ * Context: User context only.  This function may sleep.
  *
  * Get the size of a NUL-terminated string in user space.
  *
  * Returns the size of the string INCLUDING the terminating NUL.
  * On exception, returns 0.
- * If the string is too long, returns a value greater than @n.
+ *
+ * If there is a limit on the length of a valid string, you may wish to
+ * consider using strnlen_user() instead.
  */
 static inline long strnlen_user(const char *s, long n)
 {
@@ -718,7 +787,7 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (s), "r" (n)
-		: "$2", "$4", "$5", "$8", "$31");
+		: "$2", "$4", "$5", __UA_t0, "$31");
 
 	return res;
 }
Index: include/asm-mips64/uaccess.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/Attic/uaccess.h,v
retrieving revision 1.13.2.4
diff -u -r1.13.2.4 uaccess.h
--- include/asm-mips64/uaccess.h	14 Sep 2003 20:55:20 -0000	1.13.2.4
+++ include/asm-mips64/uaccess.h	20 Sep 2004 17:04:42 -0000
@@ -3,19 +3,17 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1996, 1997, 1998, 1999, 2000, 03 by Ralf Baechle
+ * Copyright (C) 1996, 1997, 1998, 1999, 2000, 03, 04 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
 #ifndef _ASM_UACCESS_H
 #define _ASM_UACCESS_H
 
+#include <linux/config.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 
-#define STR(x)  __STR(x)
-#define __STR(x)  #x
-
 /*
  * The fs value determines whether argument validity checking should be
  * performed or not.  If get_fs() == USER_DS, checking is performed, with
@@ -23,15 +21,47 @@
  *
  * For historical reasons, these macros are grossly misnamed.
  */
+#ifdef CONFIG_MIPS32
+
+#define __UA_LIMIT	0x80000000UL
+
+#define __UA_ADDR	".word"
+#define __UA_LA		"la"
+#define __UA_ADDU	"addu"
+#define __UA_t0		"$8"
+#define __UA_t1		"$9"
+
+#endif /* CONFIG_MIPS32 */
+
+#ifdef CONFIG_MIPS64
+
+#define __UA_LIMIT	(- TASK_SIZE)
+
+#define __UA_ADDR	".dword"
+#define __UA_LA		"dla"
+#define __UA_ADDU	"daddu"
+#define __UA_t0		"$12"
+#define __UA_t1		"$13"
+
+#endif /* CONFIG_MIPS64 */
+
+/*
+ * USER_DS is a bitmask that has the bits set that may not be set in a valid
+ * userspace address.  Note that we limit 32-bit userspace to 0x7fff8000 but
+ * the arithmetic we're doing only works if the limit is a power of two, so
+ * we use 0x80000000 here on 32-bit kernels.  If a process passes an invalid
+ * address in this range it's the process's problem, not ours :-)
+ */
+
 #define KERNEL_DS	((mm_segment_t) { 0UL })
-#define USER_DS		((mm_segment_t) { -TASK_SIZE })
+#define USER_DS		((mm_segment_t) { __UA_LIMIT })
 
 #define VERIFY_READ    0
 #define VERIFY_WRITE   1
 
-#define get_fs()        (current->thread.current_ds)
 #define get_ds()	(KERNEL_DS)
-#define set_fs(x)       (current->thread.current_ds=(x))
+#define get_fs()	(current->thread.current_ds)
+#define set_fs(x)	(current->thread.current_ds = (x))
 
 #define segment_eq(a,b)	((a).seg == (b).seg)
 
@@ -45,14 +75,12 @@
  *  - AND "size" doesn't have any high-bits set
  *  - AND "addr+size" doesn't have any high-bits set
  *  - OR we are in kernel mode.
+ *
+ * __ua_size() is a trick to avoid runtime checking of positive constant
+ * sizes; for those we already know at compile time that the size is ok.
  */
 #define __ua_size(size)							\
-	((__builtin_constant_p(size) && (size)) > 0 ? 0 : (size))
-
-#define __access_ok(addr, size, mask)					\
-	(((mask) & ((addr) | ((addr) + (size)) | __ua_size(size))) == 0)
-
-#define __access_mask get_fs().seg
+	((__builtin_constant_p(size) && (signed long) (size) > 0) ? 0 : (size))
 
 /*
  * access_ok: - Checks if a user space pointer is valid
@@ -73,8 +101,14 @@
  * checks that the pointer is in the user space range - after calling
  * this function, memory access functions may still return -EFAULT.
  */
+
+#define __access_mask get_fs().seg
+
+#define __access_ok(addr, size, mask)					\
+	(((signed long)((mask) & ((addr) | ((addr) + (size)) | __ua_size(size)))) == 0)
+
 #define access_ok(type, addr, size)					\
-	likely(__access_ok((unsigned long)(addr), (size), __access_mask))
+	likely(__access_ok((unsigned long)(addr), (size),__access_mask))
 
 /*
  * verify_area: - Obsolete, use access_ok()
@@ -185,119 +219,176 @@
 struct __large_struct { unsigned long buf[100]; };
 #define __m(x) (*(struct __large_struct *)(x))
 
+/*
+ * Yuck.  We need two variants, one for 64bit operation and one
+ * for 32 bit mode and old iron.
+ */
+#ifdef __mips64
+#define __GET_USER_DW(__gu_err) __get_user_asm("ld", __gu_err)
+#else
+#define __GET_USER_DW(__gu_err) __get_user_asm_ll32(__gu_err)
+#endif
+
 #define __get_user_nocheck(x,ptr,size)					\
 ({									\
-	long __gu_err;							\
-	__typeof(*(ptr)) __gu_val;					\
+	long __gu_err = 0;						\
+	__typeof(*(ptr)) __gu_val = 0;					\
 	long __gu_addr;							\
-	__asm__("":"=r" (__gu_val));					\
 	__gu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__gu_err));					\
 	switch (size) {							\
-		case 1: __get_user_asm("lb"); break;			\
-		case 2: __get_user_asm("lh"); break;			\
-		case 4: __get_user_asm("lw"); break;			\
-		case 8: __get_user_asm("ld"); break;			\
-		default: __get_user_unknown(); break;			\
-	} x = (__typeof__(*(ptr))) __gu_val;				\
+	case 1: __get_user_asm("lb", __gu_err); break;			\
+	case 2: __get_user_asm("lh", __gu_err); break;			\
+	case 4: __get_user_asm("lw", __gu_err); break;			\
+	case 8: __GET_USER_DW(__gu_err); break;				\
+	default: __get_user_unknown(); break;				\
+	}								\
+	 x = (__typeof__(*(ptr))) __gu_val;				\
 	__gu_err;							\
 })
 
 #define __get_user_check(x,ptr,size)					\
 ({									\
-	long __gu_err;							\
-	__typeof__(*(ptr)) __gu_val;					\
+	long __gu_err = 0;						\
+	__typeof__(*(ptr)) __gu_val = 0;				\
 	long __gu_addr;							\
-	__asm__("":"=r" (__gu_val));					\
 	__gu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__gu_err));					\
-	if (access_ok(VERIFY_READ, __gu_addr, size)) {			\
+	if (access_ok(VERIFY_READ,__gu_addr,size)) {			\
 		switch (size) {						\
-		case 1: __get_user_asm("lb"); break;			\
-		case 2: __get_user_asm("lh"); break;			\
-		case 4: __get_user_asm("lw"); break;			\
-		case 8: __get_user_asm("ld"); break;			\
+		case 1: __get_user_asm("lb", __gu_err); break;		\
+		case 2: __get_user_asm("lh", __gu_err); break;		\
+		case 4: __get_user_asm("lw", __gu_err); break;		\
+		case 8: __GET_USER_DW(__gu_err); break;			\
 		default: __get_user_unknown(); break;			\
 		}							\
-	} x = (__typeof__(*(ptr))) __gu_val;				\
-	__gu_err;							\
+	}								\
+	x = (__typeof__(*(ptr))) __gu_val;				\
+	 __gu_err;							\
 })
 
-#define __get_user_asm(insn)						\
+#define __get_user_asm(insn,__gu_err)					\
 ({									\
 	__asm__ __volatile__(						\
-	"1:\t" insn "\t%1,%2\n\t"					\
-	"move\t%0,$0\n"							\
-	"2:\n\t"							\
-	".section\t.fixup,\"ax\"\n"					\
-	"3:\tli\t%0,%3\n\t"						\
-	"move\t%1,$0\n\t"						\
-	"j\t2b\n\t"							\
-	".previous\n\t"							\
-	".section\t__ex_table,\"a\"\n\t"				\
-	".dword\t1b,3b\n\t"						\
-	".previous"							\
-	:"=r" (__gu_err), "=r" (__gu_val)				\
-	:"o" (__m(__gu_addr)), "i" (-EFAULT));				\
+	"1:	" insn "	%1, %3				\n"	\
+	"2:							\n"	\
+	"	.section .fixup,\"ax\"				\n"	\
+	"3:	li	%0, %4					\n"	\
+	"	j	2b					\n"	\
+	"	.previous					\n"	\
+	"	.section __ex_table,\"a\"			\n"	\
+	"	"__UA_ADDR "\t1b, 3b				\n"	\
+	"	.previous					\n"	\
+	: "=r" (__gu_err), "=r" (__gu_val)				\
+	: "0" (__gu_err), "o" (__m(__gu_addr)), "i" (-EFAULT));		\
+})
+
+/*
+ * Get a long long 64 using 32 bit registers.
+ */
+#define __get_user_asm_ll32(__gu_err)					\
+({									\
+	__asm__ __volatile__(						\
+	"1:	lw	%1,%2					\n"	\
+	"2:	lw	%D1,%3					\n"	\
+	"	move	%0,$0					\n"	\
+	"3:	.section	.fixup,\"ax\"			\n"	\
+	"4:	li	%0,%4					\n"	\
+	"	move	%1,$0					\n"	\
+	"	move	%D1,$0					\n"	\
+	"	j	3b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b,4b				\n"	\
+	"	" __UA_ADDR "	2b,4b				\n"	\
+	"	.previous					\n"	\
+	: "=r" (__gu_err), "=&r" (__gu_val)				\
+	: "o" (__m(__gu_addr)), "o" (__m(__gu_addr + 4)),		\
+	 "i" (-EFAULT));						\
 })
 
 extern void __get_user_unknown(void);
 
+/*
+ * Yuck.  We need two variants, one for 64bit operation and one
+ * for 32 bit mode and old iron.
+ */
+#ifdef __mips64
+#define __PUT_USER_DW(__pu_val) __put_user_asm("sd", __pu_val)
+#else
+#define __PUT_USER_DW(__pu_val) __put_user_asm_ll32(__pu_val)
+#endif
+
 #define __put_user_nocheck(x,ptr,size)					\
 ({									\
-	long __pu_err;							\
+	long __pu_err = 0;						\
 	__typeof__(*(ptr)) __pu_val;					\
 	long __pu_addr;							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__pu_err));					\
 	switch (size) {							\
-		case 1: __put_user_asm("sb"); break;			\
-		case 2: __put_user_asm("sh"); break;			\
-		case 4: __put_user_asm("sw"); break;			\
-		case 8: __put_user_asm("sd"); break;			\
-		default: __put_user_unknown(); break;			\
+	case 1: __put_user_asm("sb", __pu_val); break;			\
+	case 2: __put_user_asm("sh", __pu_val); break;			\
+	case 4: __put_user_asm("sw", __pu_val); break;			\
+	case 8: __PUT_USER_DW(__pu_val); break;				\
+	default: __put_user_unknown(); break;				\
 	}								\
 	__pu_err;							\
 })
 
 #define __put_user_check(x,ptr,size)					\
 ({									\
-	long __pu_err;							\
+	long __pu_err = 0;						\
 	__typeof__(*(ptr)) __pu_val;					\
 	long __pu_addr;							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__pu_err));					\
 	if (access_ok(VERIFY_WRITE, __pu_addr, size)) {			\
 		switch (size) {						\
-		case 1: __put_user_asm("sb"); break;			\
-		case 2: __put_user_asm("sh"); break;			\
-		case 4: __put_user_asm("sw"); break;			\
-		case 8: __put_user_asm("sd"); break;			\
+		case 1: __put_user_asm("sb", __pu_val); break;		\
+		case 2: __put_user_asm("sh", __pu_val); break;		\
+		case 4: __put_user_asm("sw", __pu_val); break;		\
+		case 8: __PUT_USER_DW(__pu_val); break;			\
 		default: __put_user_unknown(); break;			\
 		}							\
 	}								\
 	__pu_err;							\
 })
 
-#define __put_user_asm(insn)						\
+#define __put_user_asm(insn, __pu_val)					\
 ({									\
 	__asm__ __volatile__(						\
-	"1:\t" insn "\t%z1, %2\t\t\t# __put_user_asm\n\t"		\
-	"move\t%0, $0\n"						\
-	"2:\n\t"							\
-	".section\t.fixup,\"ax\"\n"					\
-	"3:\tli\t%0, %3\n\t"						\
-	"j\t2b\n\t"							\
-	".previous\n\t"							\
-	".section\t__ex_table,\"a\"\n\t"				\
-	".dword\t1b, 3b\n\t"						\
-	".previous"							\
+	"1:	" insn "	%z1, %2		# __put_user_asm\n"	\
+	"2:							\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
+	"3:	li	%0,%3					\n"	\
+	"	j	2b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 3b				\n"	\
+	"	.previous					\n"	\
 	:"=r" (__pu_err)						\
 	:"Jr" (__pu_val), "o" (__m(__pu_addr)), "i" (-EFAULT));		\
 })
 
+#define __put_user_asm_ll32(__pu_val)					\
+({									\
+	__asm__ __volatile__(						\
+	"1:	sw	%1, %2		# __put_user_asm_ll32	\n"	\
+	"2:	sw	%D1, %3					\n"	\
+	"	move	%0, $0					\n"	\
+	"3:							\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
+	"4:	li	%0, %4					\n"	\
+	"	j	3b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 4b				\n"	\
+	"	" __UA_ADDR "	2b, 4b				\n"	\
+	"	.previous"						\
+	:"=r" (__pu_err)						\
+	:"r" (__pu_val), "o" (__m(__pu_addr)),				\
+	 "o" (__m(__pu_addr + 4)), "i" (-EFAULT));			\
+})
+
 extern void __put_user_unknown(void);
 
 /*
@@ -307,7 +398,7 @@
 #ifdef MODULE
 #define __MODULE_JAL(destination)					\
 	".set\tnoat\n\t"						\
-	"dla\t$1, " #destination "\n\t"					 \
+	__UA_LA "\t$1, " #destination "\n\t" 				\
 	"jalr\t$1\n\t"							\
 	".set\tat\n\t"
 #else
@@ -362,6 +453,9 @@
 	__cu_len;							\
 })
 
+#define __copy_to_user_inatomic __copy_to_user
+#define __copy_from_user_inatomic __copy_from_user
+
 /*
  * copy_to_user: - Copy a block of data into user space.
  * @to:   Destination address, in user space.
@@ -403,10 +497,10 @@
 	".set\tnoreorder\n\t"						\
 	__MODULE_JAL(__copy_user)					\
 	".set\tnoat\n\t"						\
-	"daddu\t$1, %1, %2\n\t"						\
+	__UA_ADDU "\t$1, %1, %2\n\t"					\
 	".set\tat\n\t"							\
 	".set\treorder\n\t"						\
-	"move\t%0, $6"							\
+	"move\t%0, $6"		/* XXX */				\
 	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$15", "$24", "$31",		\
@@ -475,6 +569,24 @@
 	__cu_len;							\
 })
 
+#define __copy_in_user(to, from, n)	__copy_from_user(to, from, n)
+
+#define copy_in_user(to,from,n)						\
+({									\
+	void *__cu_to;							\
+	const void *__cu_from;						\
+	long __cu_len;							\
+									\
+	__cu_to = (to);							\
+	__cu_from = (from);						\
+	__cu_len = (n);							\
+	if (likely(access_ok(VERIFY_READ, __cu_from, __cu_len) &&	\
+	           access_ok(VERIFY_WRITE, __cu_to, __cu_len)))		\
+		__cu_len = __invoke_copy_from_user(__cu_to, __cu_from,	\
+		                                   __cu_len);		\
+	__cu_len;							\
+})
+
 /*
  * __clear_user: - Zero a block of memory in user space, with less checking.
  * @to:   Destination address, in user space.
@@ -499,7 +611,7 @@
 		"move\t%0, $6"
 		: "=r" (res)
 		: "r" (addr), "r" (size)
-		: "$4", "$5", "$6", "$8", "$9", "$31");
+		: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
 
 	return res;
 }
@@ -547,7 +659,7 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (__to), "r" (__from), "r" (__len)
-		: "$2", "$3", "$4", "$5", "$6", "$8", "$31", "memory");
+		: "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
 
 	return res;
 }
@@ -583,7 +695,7 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (__to), "r" (__from), "r" (__len)
-		: "$2", "$3", "$4", "$5", "$6", "$8", "$31", "memory");
+		: "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
 
 	return res;
 }
@@ -599,7 +711,7 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (s)
-		: "$2", "$4", "$8", "$31");
+		: "$2", "$4", __UA_t0, "$31");
 
 	return res;
 }
@@ -628,7 +740,24 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (s)
-		: "$2", "$4", "$8", "$31");
+		: "$2", "$4", __UA_t0, "$31");
+
+	return res;
+}
+
+/* Returns: 0 if bad, string length+1 (memory size) of string if ok */
+static inline long __strnlen_user(const char *s, long n)
+{
+	long res;
+
+	__asm__ __volatile__(
+		"move\t$4, %1\n\t"
+		"move\t$5, %2\n\t"
+		__MODULE_JAL(__strnlen_user_nocheck_asm)
+		"move\t%0, $2"
+		: "=r" (res)
+		: "r" (s), "r" (n)
+		: "$2", "$4", "$5", __UA_t0, "$31");
 
 	return res;
 }
@@ -636,13 +765,16 @@
 /*
  * strlen_user: - Get the size of a string in user space.
  * @str: The string to measure.
- * @n:   The maximum valid length
+ *
+ * Context: User context only.  This function may sleep.
  *
  * Get the size of a NUL-terminated string in user space.
  *
  * Returns the size of the string INCLUDING the terminating NUL.
  * On exception, returns 0.
- * If the string is too long, returns a value greater than @n.
+ *
+ * If there is a limit on the length of a valid string, you may wish to
+ * consider using strnlen_user() instead.
  */
 static inline long strnlen_user(const char *s, long n)
 {
@@ -655,7 +787,7 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (s), "r" (n)
-		: "$2", "$4", "$5", "$8", "$31");
+		: "$2", "$4", "$5", __UA_t0, "$31");
 
 	return res;
 }
