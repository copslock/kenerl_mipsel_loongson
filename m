Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2004 13:45:57 +0000 (GMT)
Received: from pD9562B74.dip.t-dialin.net ([IPv6:::ffff:217.86.43.116]:13865
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225198AbUKLNon>; Fri, 12 Nov 2004 13:44:43 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iACDiew0007624;
	Fri, 12 Nov 2004 14:44:40 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iACDieJr007623;
	Fri, 12 Nov 2004 14:44:40 +0100
Date: Fri, 12 Nov 2004 14:44:40 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: gcc 3.3.4/3.4.1 and get_user
Message-ID: <20041112134440.GA7588@linux-mips.org>
References: <87656yqsmz.fsf@redhat.com> <20040920154042.GB5150@linux-mips.org> <20040920171021.GA25371@linux-mips.org> <20041104.153744.122623401.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104.153744.122623401.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6314
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 04, 2004 at 03:37:44PM +0900, Atsushi Nemoto wrote:

Slow answer - but not forgotten :-)

> ralf> And here the same for 2.4.  Actually this is a straight backport
> ralf> of the 2.6 uaccess.h to 2.4 so with this patch
> ralf> include/asm-mips/uaccess.h and include/asm-mips64/uaccess.h are
> ralf> going to be identical.
> 
> I found that asm-mips/uaccess.h and asm-mips64/uaccess.h in 2.4 are
> sill not identical.  Is this intentional?  Current
> asm-mips64/uaccess.h seems broken...

They were both supposed to be identical.

> Also, arch/mips64/lib/strxxx_user.S should be modified to use t0/t1
> instead of ta0/ta1 ? (__UA_t0 is now $12, not $8)

Right, part of the same mistake.  See the patch below which gets my test
system working.  The 32-bit parts are cosmetic and shouldn't change the
generated code.  They just make the 32-bit and 64-bit str*_user.S files
almost identical.

I'm surprised somebody still cares about 2.4 64-bit ;-)  The 64-bit
improvments in 2.6, especially in the area of the 32-bit compatibility
code are so substancial that I don't think 2.4 is still a good choice.

  Ralf

Index: arch/mips/lib/strlen_user.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/strlen_user.S,v
retrieving revision 1.6.2.1
diff -u -r1.6.2.1 strlen_user.S
--- arch/mips/lib/strlen_user.S	1 Jul 2002 15:27:23 -0000	1.6.2.1
+++ arch/mips/lib/strlen_user.S	12 Nov 2004 13:32:02 -0000
@@ -23,18 +23,18 @@
  * Return 0 for error
  */
 LEAF(__strlen_user_asm)
-	lw	v0, THREAD_CURDS($28)	# pointer ok?
-	and	v0, a0
-	bltz	v0, fault
+	LONG_L		v0, THREAD_CURDS($28)	# pointer ok?
+	and		v0, a0
+	bltz		v0, fault
 
 FEXPORT(__strlen_user_nocheck_asm)
-	move	v0, a0
+	move		v0, a0
 1:	EX(lb, t0, (v0), fault)
-	addiu	v0, 1
-	bnez	t0, 1b
-	subu	v0, a0
-	jr	ra
+	addiu		v0, 1
+	bnez		t0, 1b
+	subu		v0, a0
+	jr		ra
 	END(__strlen_user_asm)
 
-fault:	move	v0, zero
-	jr	ra
+fault:	move		v0, zero
+	jr		ra
Index: arch/mips/lib/strncpy_user.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/strncpy_user.S,v
retrieving revision 1.5
diff -u -r1.5 strncpy_user.S
--- arch/mips/lib/strncpy_user.S	6 Sep 2001 13:12:02 -0000	1.5
+++ arch/mips/lib/strncpy_user.S	12 Nov 2004 13:32:02 -0000
@@ -28,31 +28,31 @@
  */
 
 LEAF(__strncpy_from_user_asm)
-	lw	v0, THREAD_CURDS($28)	# pointer ok?
-	and	v0, a1
-	bltz	v0, fault
+	LONG_L		v0, THREAD_CURDS($28)	# pointer ok?
+	and		v0, a1
+	bltz		v0, fault
 
-EXPORT(__strncpy_from_user_nocheck_asm)
-	move	v0, zero
-	move	v1, a1
-	.set	noreorder
-1:	EX(lbu,	 t0, (v1), fault)
-	addiu	v1, v1, 1
-	beqz	t0, 2f
-	 sb	t0, (a0)
-	addiu	v0, 1
-	bne	v0, a2, 1b
-	 addiu	a0, 1
-	.set	reorder
-2:	addu	t0, a1, v0
-	xor	t0, a1
-	bltz	t0, fault
-	jr	ra				# return n
+FEXPORT(__strncpy_from_user_nocheck_asm)
+	move		v0, zero
+	move		v1, a1
+	.set		noreorder
+1:	EX(lbu, t0, (v1), fault)
+	PTR_ADDIU	v1, 1
+	beqz		t0, 2f
+	 sb		t0, (a0)
+	PTR_ADDIU	v0, 1
+	bne		v0, a2, 1b
+	 PTR_ADDIU	a0, 1
+	.set		reorder
+2:	PTR_ADDU	t0, a1, v0
+	xor		t0, a1
+	bltz		t0, fault
+	jr		ra			# return n
 	END(__strncpy_from_user_asm)
 
-fault:	li	v0, -EFAULT
-	jr	ra
+fault:	li		v0, -EFAULT
+	jr		ra
 
-	.section __ex_table,"a"
-	PTR	1b, fault
+	.section	__ex_table,"a"
+	PTR		1b, fault
 	.previous
Index: arch/mips/lib/strnlen_user.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/strnlen_user.S,v
retrieving revision 1.3.2.1
diff -u -r1.3.2.1 strnlen_user.S
--- arch/mips/lib/strnlen_user.S	1 Jul 2002 15:27:23 -0000	1.3.2.1
+++ arch/mips/lib/strnlen_user.S	12 Nov 2004 13:32:02 -0000
@@ -27,23 +27,22 @@
  *       bytes.  There's nothing secret there ...
  */
 LEAF(__strnlen_user_asm)
-	lw	v0, THREAD_CURDS($28)	# pointer ok?
-	and	v0, a0
-	bltz	v0, fault
+	LONG_L		v0, THREAD_CURDS($28)	# pointer ok?
+	and		v0, a0
+	bltz		v0, fault
 
 FEXPORT(__strnlen_user_nocheck_asm)
-	.type	__strnlen_user_nocheck_asm,@function
-	move	v0, a0
-	addu	a1, a0			# stop pointer
-	.set	noreorder
-1:	beq	v0, a1, 1f		# limit reached?
-	 addiu	v0, 1
-	.set	reorder
+	move		v0, a0
+	PTR_ADDU	a1, a0			# stop pointer
+	.set		noreorder
+1:	beq		v0, a1, 1f		# limit reached?
+	 PTR_ADDIU	v0, 1
+	.set		reorder
 	EX(lb, t0, -1(v0), fault)
-	bnez	t0, 1b
-1:	subu	v0, a0
-	jr	ra
+	bnez		t0, 1b
+1:	PTR_SUBU	v0, a0
+	jr		ra
 	END(__strnlen_user_asm)
 
-fault:	move	v0, zero
-	jr	ra
+fault:	move		v0, zero
+	jr		ra
Index: arch/mips64/lib/strlen_user.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/lib/Attic/strlen_user.S,v
retrieving revision 1.4.2.2
diff -u -r1.4.2.2 strlen_user.S
--- arch/mips64/lib/strlen_user.S	9 Dec 2002 21:24:13 -0000	1.4.2.2
+++ arch/mips64/lib/strlen_user.S	12 Nov 2004 13:32:02 -0000
@@ -23,18 +23,18 @@
  * Return 0 for error
  */
 LEAF(__strlen_user_asm)
-	ld	v0, THREAD_CURDS($28)			# pointer ok?
-	and	v0, a0
-	bnez	v0, fault
+	LONG_L		v0, THREAD_CURDS($28)	# pointer ok?
+	and		v0, a0
+	bnez		v0, fault
 
 FEXPORT(__strlen_user_nocheck_asm)
-	move	v0, a0
-1:	EX(lb, ta0, (v0), fault)
-	daddiu	v0, 1
-	bnez	ta0, 1b
-	dsubu	v0, a0
-	jr	ra
+	move		v0, a0
+1:	EX(lb, t0, (v0), fault)
+	PTR_ADDIU	v0, 1
+	bnez		t0, 1b
+	PTR_SUBU	v0, a0
+	jr		ra
 	END(__strlen_user_asm)
 
-fault:	move	v0, zero
-	jr	ra
+fault:	move		v0, zero
+	jr		ra
Index: arch/mips64/lib/strncpy_user.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/lib/Attic/strncpy_user.S,v
retrieving revision 1.4.2.1
diff -u -r1.4.2.1 strncpy_user.S
--- arch/mips64/lib/strncpy_user.S	9 Dec 2002 21:24:13 -0000	1.4.2.1
+++ arch/mips64/lib/strncpy_user.S	12 Nov 2004 13:32:02 -0000
@@ -28,31 +28,31 @@
  */
 
 LEAF(__strncpy_from_user_asm)
-	ld	v0, THREAD_CURDS($28)		# pointer ok?
-	and	v0, a1
-	bnez	v0, fault
+	LONG_L		v0, THREAD_CURDS($28)	# pointer ok?
+	and		v0, a1
+	bnez		v0, fault
 
 FEXPORT(__strncpy_from_user_nocheck_asm)
-	move	v0, zero
-	move	v1, a1
-	.set	noreorder
-1:	EX(lbu,	 ta0, (v1), fault)
-	daddiu	v1, 1
-	beqz	ta0, 2f
-	 sb	ta0, (a0)
-	daddiu	v0, 1
-	bne	v0, a2, 1b
-	 daddiu	a0, 1
-	.set	reorder
-2:	daddu	ta0, a1, v0
-	xor	ta0, a1
-	bltz	ta0, fault
-	jr	ra				# return n
+	move		v0, zero
+	move		v1, a1
+	.set		noreorder
+1:	EX(lbu, t0, (v1), fault)
+	PTR_ADDIU	v1, 1
+	beqz		t0, 2f
+	 sb		t0, (a0)
+	PTR_ADDIU	v0, 1
+	bne		v0, a2, 1b
+	 PTR_ADDIU	a0, 1
+	.set		reorder
+2:	PTR_ADDU	t0, a1, v0
+	xor		t0, a1
+	bltz		t0, fault
+	jr		ra			# return n
 	END(__strncpy_from_user_asm)
 
-fault:	li	v0, -EFAULT
-	jr	ra
+fault:	li		v0, -EFAULT
+	jr		ra
 
 	.section	__ex_table,"a"
-	PTR	1b, fault
+	PTR		1b, fault
 	.previous
Index: arch/mips64/lib/strnlen_user.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/lib/Attic/strnlen_user.S,v
retrieving revision 1.2.2.3
diff -u -r1.2.2.3 strnlen_user.S
--- arch/mips64/lib/strnlen_user.S	9 Dec 2002 21:24:13 -0000	1.2.2.3
+++ arch/mips64/lib/strnlen_user.S	12 Nov 2004 13:32:02 -0000
@@ -20,23 +20,29 @@
 /*
  * Return the size of a string (including the ending 0)
  *
- * Return 0 for error, len on string but at max a1 otherwise
+ * Return 0 for error, len of string but at max a1 otherwise
+ *
+ * Note: for performance reasons we deliberately accept that a user may
+ *       make strlen_user and strnlen_user access the first few KSEG0
+ *       bytes.  There's nothing secret there ...
  */
 LEAF(__strnlen_user_asm)
-	ld	v0, THREAD_CURDS($28)	# pointer ok?
-	and	v0, a0
-	bnez	v0, fault
+	LONG_L		v0, THREAD_CURDS($28)	# pointer ok?
+	and		v0, a0
+	bnez		v0, fault
 
 FEXPORT(__strnlen_user_nocheck_asm)
-	move	v0, a0
-	daddu	a1, a0			# stop pointer
-1:	beq	v0, a1, 1f		# limit reached?
-	EX(lb, ta0, (v0), fault)
-	daddiu	v0, 1
-	bnez	ta0, 1b
-1:	dsubu	v0, a0
-	jr	ra
+	move		v0, a0
+	PTR_ADDU	a1, a0			# stop pointer
+	.set		noreorder
+1:	beq		v0, a1, 1f		# limit reached?
+	 PTR_ADDIU	v0, 1
+	.set		reorder
+	EX(lb, t0, -1(v0), fault)
+	bnez		t0, 1b
+1:	PTR_SUBU	v0, a0
+	jr		ra
 	END(__strnlen_user_asm)
 
-fault:	move	v0, zero
-	jr	ra
+fault:	move		v0, zero
+	jr		ra
Index: include/asm-mips64/uaccess.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/Attic/uaccess.h,v
retrieving revision 1.13.2.3
diff -u -r1.13.2.3 uaccess.h
--- include/asm-mips64/uaccess.h	5 Jul 2003 03:23:46 -0000	1.13.2.3
+++ include/asm-mips64/uaccess.h	12 Nov 2004 13:32:06 -0000
@@ -3,18 +3,17 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1996, 1997, 1998, 1999, 2000 by Ralf Baechle
+ * Copyright (C) 1996, 1997, 1998, 1999, 2000, 03, 04 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
 #ifndef _ASM_UACCESS_H
 #define _ASM_UACCESS_H
 
+#include <linux/config.h>
+#include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 
-#define STR(x)  __STR(x)
-#define __STR(x)  #x
-
 /*
  * The fs value determines whether argument validity checking should be
  * performed or not.  If get_fs() == USER_DS, checking is performed, with
@@ -22,15 +21,47 @@
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
 
@@ -44,14 +75,12 @@
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
@@ -72,8 +101,14 @@
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
-	__access_ok((unsigned long)(addr), (size), __access_mask)
+	likely(__access_ok((unsigned long)(addr), (size),__access_mask))
 
 /*
  * verify_area: - Obsolete, use access_ok()
@@ -184,117 +219,177 @@
 struct __large_struct { unsigned long buf[100]; };
 #define __m(x) (*(struct __large_struct *)(x))
 
-#define __get_user_nocheck(x,ptr,size)				\
-({								\
-	long __gu_err;						\
-	__typeof(*(ptr)) __gu_val;				\
-	long __gu_addr;						\
-	__asm__("":"=r" (__gu_val));				\
-	__gu_addr = (long) (ptr);				\
-	__asm__("":"=r" (__gu_err));				\
-	switch (size) {						\
-		case 1: __get_user_asm("lb"); break;		\
-		case 2: __get_user_asm("lh"); break;		\
-		case 4: __get_user_asm("lw"); break;		\
-		case 8: __get_user_asm("ld"); break;		\
-		default: __get_user_unknown(); break;		\
-	} x = (__typeof__(*(ptr))) __gu_val;			\
-	__gu_err;						\
-})
-
-#define __get_user_check(x,ptr,size)				\
-({								\
-	long __gu_err;						\
-	__typeof__(*(ptr)) __gu_val;				\
-	long __gu_addr;						\
-	__asm__("":"=r" (__gu_val));				\
-	__gu_addr = (long) (ptr);				\
-	__asm__("":"=r" (__gu_err));				\
-	if (__access_ok(__gu_addr,size,__access_mask)) {	\
-		switch (size) {					\
-		case 1: __get_user_asm("lb"); break;		\
-		case 2: __get_user_asm("lh"); break;		\
-		case 4: __get_user_asm("lw"); break;		\
-		case 8: __get_user_asm("ld"); break;		\
-		default: __get_user_unknown(); break;		\
-		}						\
-	} x = (__typeof__(*(ptr))) __gu_val;			\
-	__gu_err;						\
-})
-
-#define __get_user_asm(insn)					\
-({								\
-	__asm__ __volatile__(					\
-	"1:\t" insn "\t%1,%2\n\t"				\
-	"move\t%0,$0\n"						\
-	"2:\n\t"						\
-	".section\t.fixup,\"ax\"\n"				\
-	"3:\tli\t%0,%3\n\t"					\
-	"move\t%1,$0\n\t"					\
-	"j\t2b\n\t"						\
-	".previous\n\t"						\
-	".section\t__ex_table,\"a\"\n\t"			\
-	".dword\t1b,3b\n\t"					\
-	".previous"						\
-	:"=r" (__gu_err), "=r" (__gu_val)			\
-	:"o" (__m(__gu_addr)), "i" (-EFAULT));			\
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
+#define __get_user_nocheck(x,ptr,size)					\
+({									\
+	long __gu_err = 0;						\
+	__typeof(*(ptr)) __gu_val = 0;					\
+	long __gu_addr;							\
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
+})
+
+#define __get_user_check(x,ptr,size)					\
+({									\
+	__typeof__(*(ptr)) __gu_val = 0;				\
+	long __gu_addr = (long) (ptr);					\
+	long __gu_err;							\
+									\
+	__gu_err = verify_area(VERIFY_READ, (void *) __gu_addr, size);	\
+									\
+	if (likely(!__gu_err)) {					\
+		switch (size) {						\
+		case 1: __get_user_asm("lb", __gu_err); break;		\
+		case 2: __get_user_asm("lh", __gu_err); break;		\
+		case 4: __get_user_asm("lw", __gu_err); break;		\
+		case 8: __GET_USER_DW(__gu_err); break;			\
+		default: __get_user_unknown(); break;			\
+		}							\
+	}								\
+	x = (__typeof__(*(ptr))) __gu_val;				\
+	 __gu_err;							\
+})
+
+#define __get_user_asm(insn,__gu_err)					\
+({									\
+	__asm__ __volatile__(						\
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
+	"1:	lw	%1, %3					\n"	\
+	"2:	lw	%D1, %4					\n"	\
+	"	move	%0, $0					\n"	\
+	"3:	.section	.fixup,\"ax\"			\n"	\
+	"4:	li	%0, %5					\n"	\
+	"	move	%1, $0					\n"	\
+	"	move	%D1, $0					\n"	\
+	"	j	3b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 4b				\n"	\
+	"	" __UA_ADDR "	2b, 4b				\n"	\
+	"	.previous					\n"	\
+	: "=r" (__gu_err), "=&r" (__gu_val)				\
+	: "0" (__gu_err), "o" (__m(__gu_addr)),				\
+	  "o" (__m(__gu_addr + 4)), "i" (-EFAULT));			\
 })
 
 extern void __get_user_unknown(void);
 
-#define __put_user_nocheck(x,ptr,size)				\
-({								\
-	long __pu_err;						\
-	__typeof__(*(ptr)) __pu_val;				\
-	long __pu_addr;						\
-	__pu_val = (x);						\
-	__pu_addr = (long) (ptr);				\
-	__asm__("":"=r" (__pu_err));				\
-	switch (size) {						\
-		case 1: __put_user_asm("sb"); break;		\
-		case 2: __put_user_asm("sh"); break;		\
-		case 4: __put_user_asm("sw"); break;		\
-		case 8: __put_user_asm("sd"); break;		\
-		default: __put_user_unknown(); break;		\
-	}							\
-	__pu_err;						\
-})
-
-#define __put_user_check(x,ptr,size)				\
-({								\
-	long __pu_err;						\
-	__typeof__(*(ptr)) __pu_val;				\
-	long __pu_addr;						\
-	__pu_val = (x);						\
-	__pu_addr = (long) (ptr);				\
-	__asm__("":"=r" (__pu_err));				\
-	if (__access_ok(__pu_addr,size,__access_mask)) {	\
-		switch (size) {					\
-		case 1: __put_user_asm("sb"); break;		\
-		case 2: __put_user_asm("sh"); break;		\
-		case 4: __put_user_asm("sw"); break;		\
-		case 8: __put_user_asm("sd"); break;		\
-		default: __put_user_unknown(); break;		\
-		}						\
-	}							\
-	__pu_err;						\
-})
-
-#define __put_user_asm(insn)					\
-({								\
-	__asm__ __volatile__(					\
-	"1:\t" insn "\t%z1, %2\t\t\t# __put_user_asm\n\t"	\
-	"move\t%0, $0\n"					\
-	"2:\n\t"						\
-	".section\t.fixup,\"ax\"\n"				\
-	"3:\tli\t%0, %3\n\t"					\
-	"j\t2b\n\t"						\
-	".previous\n\t"						\
-	".section\t__ex_table,\"a\"\n\t"			\
-	".dword\t1b, 3b\n\t"					\
-	".previous"						\
-	:"=r" (__pu_err)					\
-	:"Jr" (__pu_val), "o" (__m(__pu_addr)), "i" (-EFAULT));	\
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
+#define __put_user_nocheck(x,ptr,size)					\
+({									\
+	long __pu_err = 0;						\
+	__typeof__(*(ptr)) __pu_val;					\
+	long __pu_addr;							\
+	__pu_val = (x);							\
+	__pu_addr = (long) (ptr);					\
+	switch (size) {							\
+	case 1: __put_user_asm("sb", __pu_val); break;			\
+	case 2: __put_user_asm("sh", __pu_val); break;			\
+	case 4: __put_user_asm("sw", __pu_val); break;			\
+	case 8: __PUT_USER_DW(__pu_val); break;				\
+	default: __put_user_unknown(); break;				\
+	}								\
+	__pu_err;							\
+})
+
+#define __put_user_check(x,ptr,size)					\
+({									\
+	__typeof__(*(ptr)) __pu_val = (x);				\
+	long __pu_addr = (long) (ptr);					\
+	long __pu_err;							\
+									\
+	__pu_err = verify_area(VERIFY_WRITE, (void *) __pu_addr, size);	\
+									\
+	if (likely(!__pu_err)) {					\
+		switch (size) {						\
+		case 1: __put_user_asm("sb", __pu_val); break;		\
+		case 2: __put_user_asm("sh", __pu_val); break;		\
+		case 4: __put_user_asm("sw", __pu_val); break;		\
+		case 8: __PUT_USER_DW(__pu_val); break;			\
+		default: __put_user_unknown(); break;			\
+		}							\
+	}								\
+	__pu_err;							\
+})
+
+#define __put_user_asm(insn, __pu_val)					\
+({									\
+	__asm__ __volatile__(						\
+	"1:	" insn "	%z2, %3		# __put_user_asm\n"	\
+	"2:							\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
+	"3:	li	%0, %4					\n"	\
+	"	j	2b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 3b				\n"	\
+	"	.previous					\n"	\
+	: "=r" (__pu_err)						\
+	: "0" (__pu_err), "Jr" (__pu_val), "o" (__m(__pu_addr)),	\
+	  "i" (-EFAULT));						\
+})
+
+#define __put_user_asm_ll32(__pu_val)					\
+({									\
+	__asm__ __volatile__(						\
+	"1:	sw	%2, %3		# __put_user_asm_ll32	\n"	\
+	"2:	sw	%D2, %4					\n"	\
+	"3:							\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
+	"4:	li	%0, %5					\n"	\
+	"	j	3b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 4b				\n"	\
+	"	" __UA_ADDR "	2b, 4b				\n"	\
+	"	.previous"						\
+	: "=r" (__pu_err)						\
+	: "0" (__pu_err), "r" (__pu_val), "o" (__m(__pu_addr)),		\
+	  "o" (__m(__pu_addr + 4)), "i" (-EFAULT));			\
 })
 
 extern void __put_user_unknown(void);
@@ -304,13 +399,13 @@
  * jump instructions
  */
 #ifdef MODULE
-#define __MODULE_JAL(destination)	\
-	".set\tnoat\n\t"		\
-	"dla\t$1, " #destination "\n\t" \
-	"jalr\t$1\n\t"			\
+#define __MODULE_JAL(destination)					\
+	".set\tnoat\n\t"						\
+	__UA_LA "\t$1, " #destination "\n\t" 				\
+	"jalr\t$1\n\t"							\
 	".set\tat\n\t"
 #else
-#define __MODULE_JAL(destination)	\
+#define __MODULE_JAL(destination)					\
 	"jal\t" #destination "\n\t"
 #endif
 
@@ -361,6 +456,9 @@
 	__cu_len;							\
 })
 
+#define __copy_to_user_inatomic __copy_to_user
+#define __copy_from_user_inatomic __copy_from_user
+
 /*
  * copy_to_user: - Copy a block of data into user space.
  * @to:   Destination address, in user space.
@@ -402,10 +500,9 @@
 	".set\tnoreorder\n\t"						\
 	__MODULE_JAL(__copy_user)					\
 	".set\tnoat\n\t"						\
-	"daddu\t$1, %1, %2\n\t"						\
+	__UA_ADDU "\t$1, %1, %2\n\t"					\
 	".set\tat\n\t"							\
-	".set\treorder\n\t"						\
-	"move\t%0, $6"							\
+	".set\treorder"							\
 	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$15", "$24", "$31",		\
@@ -498,19 +595,19 @@
 		"move\t%0, $6"
 		: "=r" (res)
 		: "r" (addr), "r" (size)
-		: "$4", "$5", "$6", "$8", "$9", "$31");
+		: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
 
 	return res;
 }
 
-#define clear_user(addr,n)					\
-({								\
-	void * __cl_addr = (addr);				\
-	unsigned long __cl_size = (n);				\
-	if (__cl_size && access_ok(VERIFY_WRITE,		\
-		((unsigned long)(__cl_addr)), __cl_size))	\
-		__cl_size = __clear_user(__cl_addr, __cl_size);	\
-	__cl_size;						\
+#define clear_user(addr,n)						\
+({									\
+	void * __cl_addr = (addr);					\
+	unsigned long __cl_size = (n);					\
+	if (__cl_size && access_ok(VERIFY_WRITE,			\
+		((unsigned long)(__cl_addr)), __cl_size))		\
+		__cl_size = __clear_user(__cl_addr, __cl_size);		\
+	__cl_size;							\
 })
 
 /*
@@ -546,7 +643,7 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (__to), "r" (__from), "r" (__len)
-		: "$2", "$3", "$4", "$5", "$6", "$8", "$31", "memory");
+		: "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
 
 	return res;
 }
@@ -582,7 +679,7 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (__to), "r" (__from), "r" (__len)
-		: "$2", "$3", "$4", "$5", "$6", "$8", "$31", "memory");
+		: "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
 
 	return res;
 }
@@ -598,7 +695,7 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (s)
-		: "$2", "$4", "$8", "$31");
+		: "$2", "$4", __UA_t0, "$31");
 
 	return res;
 }
@@ -627,7 +724,24 @@
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
@@ -635,13 +749,16 @@
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
@@ -654,7 +771,7 @@
 		"move\t%0, $2"
 		: "=r" (res)
 		: "r" (s), "r" (n)
-		: "$2", "$4", "$5", "$8", "$31");
+		: "$2", "$4", "$5", __UA_t0, "$31");
 
 	return res;
 }
@@ -669,9 +786,9 @@
 extern unsigned long search_exception_table(unsigned long addr);
 
 /* Returns the new pc */
-#define fixup_exception(map_reg, fixup_unit, pc)                \
-({                                                              \
-	fixup_unit;                                             \
+#define fixup_exception(map_reg, fixup_unit, pc)			\
+({									\
+	fixup_unit;							\
 })
 
 #endif /* _ASM_UACCESS_H */
