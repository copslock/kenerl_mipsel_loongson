Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Sep 2004 16:40:49 +0100 (BST)
Received: from p508B7085.dip.t-dialin.net ([IPv6:::ffff:80.139.112.133]:9318
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224937AbUITPko>; Mon, 20 Sep 2004 16:40:44 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i8KFehA0014934;
	Mon, 20 Sep 2004 17:40:43 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i8KFegZL014933;
	Mon, 20 Sep 2004 17:40:42 +0200
Date: Mon, 20 Sep 2004 17:40:42 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: gcc 3.3.4/3.4.1 and get_user
Message-ID: <20040920154042.GB5150@linux-mips.org>
References: <20040901.012223.59462025.anemo@mba.ocn.ne.jp> <87656yqsmz.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87656yqsmz.fsf@redhat.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 01, 2004 at 09:51:16AM +0100, Richard Sandiford wrote:

> The latter.  gcc is putting the empty asm:
> 
> 	__asm__ ("":"=r" (__gu_val));
> 
> into the delay slot of the call.

The purpose of this was to avoid a warning about __gu_val possibly being
used uninitialized without inflating the code.  I've got a better solution
that'll actually shrinks the code size of my defconfig build by 5448
bytes.  Untested patch below.

  Ralf

Index: include/asm-mips/uaccess.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/uaccess.h,v
retrieving revision 1.35
diff -u -r1.35 uaccess.h
--- include/asm-mips/uaccess.h	19 Sep 2004 12:30:20 -0000	1.35
+++ include/asm-mips/uaccess.h	20 Sep 2004 12:33:27 -0000
@@ -225,88 +225,86 @@
  * for 32 bit mode and old iron.
  */
 #ifdef __mips64
-#define __GET_USER_DW __get_user_asm("ld")
+#define __GET_USER_DW(__gu_err) __get_user_asm("ld", __gu_err)
 #else
-#define __GET_USER_DW __get_user_asm_ll32
+#define __GET_USER_DW(__gu_err) __get_user_asm_ll32(__gu_err)
 #endif
 
-#define __get_user_nocheck(x,ptr,size)				\
-({								\
-	long __gu_err;						\
-	__typeof(*(ptr)) __gu_val;				\
-	long __gu_addr;						\
-	might_sleep();						\
-	__asm__("":"=r" (__gu_val));				\
-	__gu_addr = (long) (ptr);				\
-	__asm__("":"=r" (__gu_err));				\
-	switch (size) {						\
-	case 1: __get_user_asm("lb"); break;			\
-	case 2: __get_user_asm("lh"); break;			\
-	case 4: __get_user_asm("lw"); break;			\
-	case 8: __GET_USER_DW; break;				\
-	default: __get_user_unknown(); break;			\
-	} x = (__typeof__(*(ptr))) __gu_val; __gu_err;		\
+#define __get_user_nocheck(x,ptr,size)					\
+({									\
+	long __gu_err = 0;						\
+	__typeof(*(ptr)) __gu_val = 0;					\
+	long __gu_addr;							\
+	might_sleep();							\
+	__gu_addr = (long) (ptr);					\
+	switch (size) {							\
+	case 1: __get_user_asm("lb", __gu_err); break;			\
+	case 2: __get_user_asm("lh", __gu_err); break;			\
+	case 4: __get_user_asm("lw", __gu_err); break;			\
+	case 8: __GET_USER_DW(__gu_err); break;				\
+	default: __get_user_unknown(); break;				\
+	}								\
+	 x = (__typeof__(*(ptr))) __gu_val;				\
+	__gu_err;							\
 })
 
 #define __get_user_check(x,ptr,size)					\
 ({									\
-	long __gu_err;							\
-	__typeof__(*(ptr)) __gu_val;					\
+	long __gu_err = 0;						\
+	__typeof__(*(ptr)) __gu_val = 0;				\
 	long __gu_addr;							\
 	might_sleep();							\
-	__asm__("":"=r" (__gu_val));					\
 	__gu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__gu_err));					\
 	if (access_ok(VERIFY_READ,__gu_addr,size)) {			\
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
-	} x = (__typeof__(*(ptr))) __gu_val; __gu_err;			\
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
-	__UA_ADDR "\t1b,3b\n\t"						\
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
 	__asm__ __volatile__(						\
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
-	__UA_ADDR "\t1b,4b\n\t"						\
-	__UA_ADDR "\t2b,4b\n\t"						\
-	".previous"							\
-	:"=r" (__gu_err), "=&r" (__gu_val)				\
-	:"o" (__m(__gu_addr)), "o" (__m(__gu_addr + 4)),		\
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
 
@@ -317,25 +315,24 @@
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
 	might_sleep();							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__pu_err));					\
 	switch (size) {							\
-	case 1: __put_user_asm("sb"); break;				\
-	case 2: __put_user_asm("sh"); break;				\
-	case 4: __put_user_asm("sw"); break;				\
-	case 8: __PUT_USER_DW; break;					\
+	case 1: __put_user_asm("sb", __pu_val); break;			\
+	case 2: __put_user_asm("sh", __pu_val); break;			\
+	case 4: __put_user_asm("sw", __pu_val); break;			\
+	case 8: __PUT_USER_DW(__pu_val); break;				\
 	default: __put_user_unknown(); break;				\
 	}								\
 	__pu_err;							\
@@ -343,57 +340,55 @@
 
 #define __put_user_check(x,ptr,size)					\
 ({									\
-	long __pu_err;							\
+	long __pu_err = 0;						\
 	__typeof__(*(ptr)) __pu_val;					\
 	long __pu_addr;							\
 	might_sleep();							\
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
-	"3:\tli\t%0,%3\n\t"						\
-	"j\t2b\n\t"							\
-	".previous\n\t"							\
-	".section\t__ex_table,\"a\"\n\t"				\
-	__UA_ADDR "\t1b,3b\n\t"						\
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
 	__asm__ __volatile__(						\
-	"1:\tsw\t%1, %2\t\t\t# __put_user_asm_ll32\n\t"			\
-	"2:\tsw\t%D1, %3\n"						\
-	"move\t%0, $0\n"						\
-	"3:\n\t"							\
-	".section\t.fixup,\"ax\"\n"					\
-	"4:\tli\t%0,%4\n\t"						\
-	"j\t3b\n\t"							\
-	".previous\n\t"							\
-	".section\t__ex_table,\"a\"\n\t"				\
-	__UA_ADDR "\t1b,4b\n\t"						\
-	__UA_ADDR "\t2b,4b\n\t"						\
-	".previous"							\
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
 	:"r" (__pu_val), "o" (__m(__pu_addr)),				\
 	 "o" (__m(__pu_addr + 4)), "i" (-EFAULT));			\
