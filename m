Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 03:53:59 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51135 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023587AbXJACx4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 03:53:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l912rqjn017709;
	Mon, 1 Oct 2007 03:53:52 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l912reID017708;
	Mon, 1 Oct 2007 03:53:40 +0100
Date:	Mon, 1 Oct 2007 03:53:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
Cc:	linux-mips@linux-mips.org
Subject: Re: cmpxchg broken in some situation
Message-ID: <20071001025340.GA7091@linux-mips.org>
References: <46FF7BC2.5050905@ict.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46FF7BC2.5050905@ict.ac.cn>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Sep 30, 2007 at 06:34:42PM +0800, Fuxin Zhang wrote:

> hi,   
>   Today I run across a possible bug of cmpxchg implementation. When 
> playing with DRM on our Fulong, the following function 
> (drivers/char/drm/drm_lock.c) is not working correctly in 64BIT mips:
>   cmpxchg failed to set *lock to new value. (return 0 with *lock unchanged)
> It is probably due to type conversions between unisigned int and 
> unsigned long.  When I change cmpxchg to mycmpxchg(attached below), 
> problem disappeared.                                 

Below a patch to implement the get_user() style big solution to type
safety in cmpxchg.  Can you test it?  Thanks,

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 include/asm-mips/cmpxchg.h |  104 ++++++++++++++++++
 include/asm-mips/local.h   |    1 
 include/asm-mips/system.h  |  261 --------------------------------------------
 3 files changed, 106 insertions(+), 260 deletions(-)

diff --git a/include/asm-mips/cmpxchg.h b/include/asm-mips/cmpxchg.h
new file mode 100644
index 0000000..d1523dd
--- /dev/null
+++ b/include/asm-mips/cmpxchg.h
@@ -0,0 +1,104 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003, 06, 07 by Ralf Baechle (ralf@linux-mips.org)
+ */
+#ifndef __ASM_CMPXCHG_H
+#define __ASM_CMPXCHG_H
+
+#include <linux/irqflags.h>
+
+#define __HAVE_ARCH_CMPXCHG 1
+
+#define __cmpxchg(ld, st, m, old, new)					\
+({									\
+	__typeof(*(m)) __ret;						\
+									\
+	if (cpu_has_llsc && R10000_LLSC_WAR) {				\
+		__asm__ __volatile__(					\
+		"	.set	push				\n"	\
+		"	.set	noat				\n"	\
+		"	.set	mips3				\n"	\
+		"1:	" ld "	%0, %2		# __cmpxchg_u32	\n"	\
+		"	bne	%0, %z3, 2f			\n"	\
+		"	.set	mips0				\n"	\
+		"	move	$1, %z4				\n"	\
+		"	.set	mips3				\n"	\
+		"	" st "	$1, %1				\n"	\
+		"	beqzl	$1, 1b				\n"	\
+		"2:						\n"	\
+		"	.set	pop				\n"	\
+		: "=&r" (__ret), "=R" (*m)				\
+		: "R" (*m), "Jr" (old), "Jr" (new)			\
+		: "memory");						\
+	} else if (cpu_has_llsc) {					\
+		__asm__ __volatile__(					\
+		"	.set	push				\n"	\
+		"	.set	noat				\n"	\
+		"	.set	mips3				\n"	\
+		"1:	" ld "	%0, %2		# __cmpxchg_u32	\n"	\
+		"	bne	%0, %z3, 2f			\n"	\
+		"	.set	mips0				\n"	\
+		"	move	$1, %z4				\n"	\
+		"	.set	mips3				\n"	\
+		"	" st "	$1, %1				\n"	\
+		"	beqz	$1, 3f				\n"	\
+		"2:						\n"	\
+		"	.subsection 2				\n"	\
+		"3:	b	1b				\n"	\
+		"	.previous				\n"	\
+		"	.set	pop				\n"	\
+		: "=&r" (__ret), "=R" (*m)				\
+		: "R" (*m), "Jr" (old), "Jr" (new)			\
+		: "memory");						\
+	} else {							\
+		unsigned long __flags;					\
+									\
+		raw_local_irq_save(__flags);				\
+		__ret = *m;						\
+		if (__ret == old)					\
+			*m = new;					\
+		raw_local_irq_restore(__flags);				\
+	}								\
+									\
+	smp_llsc_mb();							\
+									\
+	__ret;								\
+})
+
+/*
+ * This function doesn't exist, so you'll get a linker error
+ * if something tries to do an invalid cmpxchg().
+ */
+extern void __cmpxchg_called_with_bad_pointer(void);
+
+#define cmpxchg(ptr,old,new)						\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(*(ptr)) __old = (old);				\
+	__typeof__(*(ptr)) __new = (new);				\
+	__typeof__(*(ptr)) __res = 0;					\
+									\
+	switch (sizeof(__ptr)) {					\
+	case 4:								\
+		__res = __cmpxchg("ll", "sc", __ptr, __old, __new);	\
+		break;							\
+	case 8:								\
+		if (sizeof(long) == 8) {				\
+			__res = __cmpxchg("lld", "scd", __ptr,		\
+					   __old, __new);		\
+			break;						\
+		}							\
+	default:							\
+		__cmpxchg_called_with_bad_pointer();			\
+		break;							\
+	}								\
+									\
+	__res;								\
+})
+
+#define cmpxchg_local(ptr, old, new) cmpxchg(ptr, old, new)
+
+#endif /* __ASM_CMPXCHG_H */
diff --git a/include/asm-mips/local.h b/include/asm-mips/local.h
index ed882c8..7034a01 100644
--- a/include/asm-mips/local.h
+++ b/include/asm-mips/local.h
@@ -4,6 +4,7 @@
 #include <linux/percpu.h>
 #include <linux/bitops.h>
 #include <asm/atomic.h>
+#include <asm/cmpxchg.h>
 #include <asm/war.h>
 
 typedef struct
diff --git a/include/asm-mips/system.h b/include/asm-mips/system.h
index 357251f..480b574 100644
--- a/include/asm-mips/system.h
+++ b/include/asm-mips/system.h
@@ -17,6 +17,7 @@
 
 #include <asm/addrspace.h>
 #include <asm/barrier.h>
+#include <asm/cmpxchg.h>
 #include <asm/cpu-features.h>
 #include <asm/dsp.h>
 #include <asm/war.h>
@@ -194,266 +195,6 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 
 #define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
 
-#define __HAVE_ARCH_CMPXCHG 1
-
-static inline unsigned long __cmpxchg_u32(volatile int * m, unsigned long old,
-	unsigned long new)
-{
-	__u32 retval;
-
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noat					\n"
-		"	.set	mips3					\n"
-		"1:	ll	%0, %2			# __cmpxchg_u32	\n"
-		"	bne	%0, %z3, 2f				\n"
-		"	.set	mips0					\n"
-		"	move	$1, %z4					\n"
-		"	.set	mips3					\n"
-		"	sc	$1, %1					\n"
-		"	beqzl	$1, 1b					\n"
-		"2:							\n"
-		"	.set	pop					\n"
-		: "=&r" (retval), "=R" (*m)
-		: "R" (*m), "Jr" (old), "Jr" (new)
-		: "memory");
-	} else if (cpu_has_llsc) {
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noat					\n"
-		"	.set	mips3					\n"
-		"1:	ll	%0, %2			# __cmpxchg_u32	\n"
-		"	bne	%0, %z3, 2f				\n"
-		"	.set	mips0					\n"
-		"	move	$1, %z4					\n"
-		"	.set	mips3					\n"
-		"	sc	$1, %1					\n"
-		"	beqz	$1, 3f					\n"
-		"2:							\n"
-		"	.subsection 2					\n"
-		"3:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	pop					\n"
-		: "=&r" (retval), "=R" (*m)
-		: "R" (*m), "Jr" (old), "Jr" (new)
-		: "memory");
-	} else {
-		unsigned long flags;
-
-		raw_local_irq_save(flags);
-		retval = *m;
-		if (retval == old)
-			*m = new;
-		raw_local_irq_restore(flags);	/* implies memory barrier  */
-	}
-
-	smp_llsc_mb();
-
-	return retval;
-}
-
-static inline unsigned long __cmpxchg_u32_local(volatile int * m,
-	unsigned long old, unsigned long new)
-{
-	__u32 retval;
-
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noat					\n"
-		"	.set	mips3					\n"
-		"1:	ll	%0, %2			# __cmpxchg_u32	\n"
-		"	bne	%0, %z3, 2f				\n"
-		"	.set	mips0					\n"
-		"	move	$1, %z4					\n"
-		"	.set	mips3					\n"
-		"	sc	$1, %1					\n"
-		"	beqzl	$1, 1b					\n"
-		"2:							\n"
-		"	.set	pop					\n"
-		: "=&r" (retval), "=R" (*m)
-		: "R" (*m), "Jr" (old), "Jr" (new)
-		: "memory");
-	} else if (cpu_has_llsc) {
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noat					\n"
-		"	.set	mips3					\n"
-		"1:	ll	%0, %2			# __cmpxchg_u32	\n"
-		"	bne	%0, %z3, 2f				\n"
-		"	.set	mips0					\n"
-		"	move	$1, %z4					\n"
-		"	.set	mips3					\n"
-		"	sc	$1, %1					\n"
-		"	beqz	$1, 1b					\n"
-		"2:							\n"
-		"	.set	pop					\n"
-		: "=&r" (retval), "=R" (*m)
-		: "R" (*m), "Jr" (old), "Jr" (new)
-		: "memory");
-	} else {
-		unsigned long flags;
-
-		local_irq_save(flags);
-		retval = *m;
-		if (retval == old)
-			*m = new;
-		local_irq_restore(flags);	/* implies memory barrier  */
-	}
-
-	return retval;
-}
-
-#ifdef CONFIG_64BIT
-static inline unsigned long __cmpxchg_u64(volatile int * m, unsigned long old,
-	unsigned long new)
-{
-	__u64 retval;
-
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noat					\n"
-		"	.set	mips3					\n"
-		"1:	lld	%0, %2			# __cmpxchg_u64	\n"
-		"	bne	%0, %z3, 2f				\n"
-		"	move	$1, %z4					\n"
-		"	scd	$1, %1					\n"
-		"	beqzl	$1, 1b					\n"
-		"2:							\n"
-		"	.set	pop					\n"
-		: "=&r" (retval), "=R" (*m)
-		: "R" (*m), "Jr" (old), "Jr" (new)
-		: "memory");
-	} else if (cpu_has_llsc) {
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noat					\n"
-		"	.set	mips3					\n"
-		"1:	lld	%0, %2			# __cmpxchg_u64	\n"
-		"	bne	%0, %z3, 2f				\n"
-		"	move	$1, %z4					\n"
-		"	scd	$1, %1					\n"
-		"	beqz	$1, 3f					\n"
-		"2:							\n"
-		"	.subsection 2					\n"
-		"3:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	pop					\n"
-		: "=&r" (retval), "=R" (*m)
-		: "R" (*m), "Jr" (old), "Jr" (new)
-		: "memory");
-	} else {
-		unsigned long flags;
-
-		raw_local_irq_save(flags);
-		retval = *m;
-		if (retval == old)
-			*m = new;
-		raw_local_irq_restore(flags);	/* implies memory barrier  */
-	}
-
-	smp_llsc_mb();
-
-	return retval;
-}
-
-static inline unsigned long __cmpxchg_u64_local(volatile int * m,
-	unsigned long old, unsigned long new)
-{
-	__u64 retval;
-
-	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noat					\n"
-		"	.set	mips3					\n"
-		"1:	lld	%0, %2			# __cmpxchg_u64	\n"
-		"	bne	%0, %z3, 2f				\n"
-		"	move	$1, %z4					\n"
-		"	scd	$1, %1					\n"
-		"	beqzl	$1, 1b					\n"
-		"2:							\n"
-		"	.set	pop					\n"
-		: "=&r" (retval), "=R" (*m)
-		: "R" (*m), "Jr" (old), "Jr" (new)
-		: "memory");
-	} else if (cpu_has_llsc) {
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noat					\n"
-		"	.set	mips3					\n"
-		"1:	lld	%0, %2			# __cmpxchg_u64	\n"
-		"	bne	%0, %z3, 2f				\n"
-		"	move	$1, %z4					\n"
-		"	scd	$1, %1					\n"
-		"	beqz	$1, 1b					\n"
-		"2:							\n"
-		"	.set	pop					\n"
-		: "=&r" (retval), "=R" (*m)
-		: "R" (*m), "Jr" (old), "Jr" (new)
-		: "memory");
-	} else {
-		unsigned long flags;
-
-		local_irq_save(flags);
-		retval = *m;
-		if (retval == old)
-			*m = new;
-		local_irq_restore(flags);	/* implies memory barrier  */
-	}
-
-	return retval;
-}
-
-#else
-extern unsigned long __cmpxchg_u64_unsupported_on_32bit_kernels(
-	volatile int * m, unsigned long old, unsigned long new);
-#define __cmpxchg_u64 __cmpxchg_u64_unsupported_on_32bit_kernels
-extern unsigned long __cmpxchg_u64_local_unsupported_on_32bit_kernels(
-	volatile int * m, unsigned long old, unsigned long new);
-#define __cmpxchg_u64_local __cmpxchg_u64_local_unsupported_on_32bit_kernels
-#endif
-
-/* This function doesn't exist, so you'll get a linker error
-   if something tries to do an invalid cmpxchg().  */
-extern void __cmpxchg_called_with_bad_pointer(void);
-
-static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
-	unsigned long new, int size)
-{
-	switch (size) {
-	case 4:
-		return __cmpxchg_u32(ptr, old, new);
-	case 8:
-		return __cmpxchg_u64(ptr, old, new);
-	}
-	__cmpxchg_called_with_bad_pointer();
-	return old;
-}
-
-static inline unsigned long __cmpxchg_local(volatile void * ptr,
-	unsigned long old, unsigned long new, int size)
-{
-	switch (size) {
-	case 4:
-		return __cmpxchg_u32_local(ptr, old, new);
-	case 8:
-		return __cmpxchg_u64_local(ptr, old, new);
-	}
-	__cmpxchg_called_with_bad_pointer();
-	return old;
-}
-
-#define cmpxchg(ptr,old,new) \
-	((__typeof__(*(ptr)))__cmpxchg((ptr), \
-		(unsigned long)(old), (unsigned long)(new),sizeof(*(ptr))))
-
-#define cmpxchg_local(ptr,old,new) \
-	((__typeof__(*(ptr)))__cmpxchg_local((ptr), \
-		(unsigned long)(old), (unsigned long)(new),sizeof(*(ptr))))
-
 extern void set_handler (unsigned long offset, void *addr, unsigned long len);
 extern void set_uncached_handler (unsigned long offset, void *addr, unsigned long len);
 
