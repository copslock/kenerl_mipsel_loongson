Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62IbWRw007849
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 11:37:32 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62IbWLs007848
	for linux-mips-outgoing; Tue, 2 Jul 2002 11:37:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sccrmhc01.attbi.com (sccrmhc01.attbi.com [204.127.202.61])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62IauRw007737
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 11:36:56 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by sccrmhc01.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020702184046.BIQG29588.sccrmhc01.attbi.com@ocean.lucon.org>;
          Tue, 2 Jul 2002 18:40:46 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 59A7E125D3; Tue,  2 Jul 2002 11:40:45 -0700 (PDT)
Date: Tue, 2 Jul 2002 11:40:45 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
Subject: PATCH: Always use ll/sc for mips
Message-ID: <20020702114045.A16197@lucon.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The ll/sc emulation is implemented in 2.4.0 and above. This patch makes
glibc always use ll/sc.


H.J.

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="glibc-mips-llsc.patch"

2002-07-02  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/pspinlock.c: Don't include <sgidefs.h>. Always
	use ll/sc.
	* sysdeps/mips/pt-machine.h: Liekwise.

2002-07-02  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/atomicity.h: Don't include <sgidefs.h>. Always
	use ll/sc.
	* sysdeps/unix/sysv/linux/mips/sys/tas.h: Likewise.

	* sysdeps/unix/sysv/linux/configure.in: Set arch_minimum_kernel
	to 2.4.0 for mips.
	* sysdeps/unix/sysv/linux/configure: Regenerated.

--- libc/linuxthreads/sysdeps/mips/pspinlock.c.llsc	Fri Feb  8 09:08:40 2002
+++ libc/linuxthreads/sysdeps/mips/pspinlock.c	Tue Jul  2 10:58:42 2002
@@ -19,12 +19,9 @@
 
 #include <errno.h>
 #include <pthread.h>
-#include <sgidefs.h>
 #include <sys/tas.h>
 #include "internals.h"
 
-#if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
-
 /* This implementation is similar to the one used in the Linux kernel.  */
 int
 __pthread_spin_lock (pthread_spinlock_t *lock)
@@ -34,10 +31,13 @@ __pthread_spin_lock (pthread_spinlock_t 
   asm volatile
     ("\t\t\t# spin_lock\n"
      "1:\n\t"
+     ".set	push\n\t"
+     ".set	mips2\n\t"
      "ll	%1,%3\n\t"
      "li	%2,1\n\t"
      "bnez	%1,1b\n\t"
      "sc	%2,%0\n\t"
+     ".set	pop\n\t"
      "beqz	%2,1b"
      : "=m" (*lock), "=&r" (tmp1), "=&r" (tmp2)
      : "m" (*lock)
@@ -46,17 +46,6 @@ __pthread_spin_lock (pthread_spinlock_t 
   return 0;
 }
 
-#else /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
-
-int
-__pthread_spin_lock (pthread_spinlock_t *lock)
-{
-  while (_test_and_set ((int *) lock, 1));
-  return 0;
-}
-
-#endif /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
-
 weak_alias (__pthread_spin_lock, pthread_spin_lock)
 
 
--- libc/linuxthreads/sysdeps/mips/pt-machine.h.llsc	Wed Apr 10 11:38:44 2002
+++ libc/linuxthreads/sysdeps/mips/pt-machine.h	Tue Jul  2 10:58:21 2002
@@ -23,7 +23,6 @@
 #ifndef _PT_MACHINE_H
 #define _PT_MACHINE_H   1
 
-#include <sgidefs.h>
 #include <sys/tas.h>
 
 #ifndef PT_EI
@@ -51,8 +50,6 @@ register char * stack_pointer __asm__ ("
 
 /* Compare-and-swap for semaphores. */
 
-#if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
-
 #define HAS_COMPARE_AND_SWAP
 PT_EI int
 __compare_and_swap (long int *p, long int oldval, long int newval)
@@ -62,11 +59,14 @@ __compare_and_swap (long int *p, long in
   __asm__ __volatile__
     ("/* Inline compare & swap */\n"
      "1:\n\t"
+     ".set	push\n\t"
+     ".set	mips2\n\t"
      "ll	%1,%5\n\t"
      "move	%0,$0\n\t"
      "bne	%1,%3,2f\n\t"
      "move	%0,%4\n\t"
      "sc	%0,%2\n\t"
+     ".set	pop\n\t"
      "beqz	%0,1b\n"
      "2:\n\t"
      "/* End compare & swap */"
@@ -77,6 +77,4 @@ __compare_and_swap (long int *p, long in
   return ret;
 }
 
-#endif /* (_MIPS_ISA >= _MIPS_ISA_MIPS2) */
-
 #endif /* pt-machine.h */
--- libc/sysdeps/mips/atomicity.h.llsc	Fri Feb  8 09:09:06 2002
+++ libc/sysdeps/mips/atomicity.h	Tue Jul  2 10:58:05 2002
@@ -20,11 +20,8 @@
 #ifndef _MIPS_ATOMICITY_H
 #define _MIPS_ATOMICITY_H    1
 
-#include <sgidefs.h>
 #include <inttypes.h>
 
-#if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
-
 static inline int
 __attribute__ ((unused))
 exchange_and_add (volatile uint32_t *mem, int val)
@@ -34,9 +31,12 @@ exchange_and_add (volatile uint32_t *mem
   __asm__ __volatile__
     ("/* Inline exchange & add */\n"
      "1:\n\t"
+     ".set	push\n\t"
+     ".set	mips2\n\t"
      "ll	%0,%3\n\t"
      "addu	%1,%4,%0\n\t"
      "sc	%1,%2\n\t"
+     ".set	pop\n\t"
      "beqz	%1,1b\n\t"
      "/* End exchange & add */"
      : "=&r"(result), "=&r"(tmp), "=m"(*mem)
@@ -55,9 +55,12 @@ atomic_add (volatile uint32_t *mem, int 
   __asm__ __volatile__
     ("/* Inline atomic add */\n"
      "1:\n\t"
+     ".set	push\n\t"
+     ".set	mips2\n\t"
      "ll	%0,%2\n\t"
      "addu	%0,%3,%0\n\t"
      "sc	%0,%1\n\t"
+     ".set	pop\n\t"
      "beqz	%0,1b\n\t"
      "/* End atomic add */"
      : "=&r"(result), "=m"(*mem)
@@ -74,11 +77,14 @@ compare_and_swap (volatile long int *p, 
   __asm__ __volatile__
     ("/* Inline compare & swap */\n"
      "1:\n\t"
+     ".set	push\n\t"
+     ".set	mips2\n\t"
      "ll	%1,%5\n\t"
      "move	%0,$0\n\t"
      "bne	%1,%3,2f\n\t"
      "move	%0,%4\n\t"
      "sc	%0,%2\n\t"
+     ".set	pop\n\t"
      "beqz	%0,1b\n"
      "2:\n\t"
      "/* End compare & swap */"
@@ -89,37 +95,4 @@ compare_and_swap (volatile long int *p, 
   return ret;
 }
 
-#else /* (_MIPS_ISA >= _MIPS_ISA_MIPS2) */
-
-#warning MIPS I atomicity functions are not atomic
-
-static inline int
-__attribute__ ((unused))
-exchange_and_add (volatile uint32_t *mem, int val)
-{
-  int result = *mem;
-  *mem += val;
-  return result;
-}
-
-static inline void
-__attribute__ ((unused))
-atomic_add (volatile uint32_t *mem, int val)
-{
-  *mem += val;
-}
-
-static inline int
-__attribute__ ((unused))
-compare_and_swap (volatile long int *p, long int oldval, long int newval)
-{
-  if (*p != oldval)
-    return 0;
-
-  *p = newval;
-  return 1;
-}
-
-#endif /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
-
 #endif /* atomicity.h */
--- libc/sysdeps/unix/sysv/linux/configure.in.llsc	Tue May 21 11:30:10 2002
+++ libc/sysdeps/unix/sysv/linux/configure.in	Tue Jul  2 10:32:35 2002
@@ -59,7 +59,7 @@ case "$machine" in
     libc_cv_gcc_unwind_find_fde=yes
     ;;
   mips*)
-    arch_minimum_kernel=2.2.15
+    arch_minimum_kernel=2.4.0
     libc_cv_gcc_unwind_find_fde=yes
     ;;
   powerpc*)
--- libc/sysdeps/unix/sysv/linux/mips/sys/tas.h.llsc	Fri Feb  8 09:09:06 2002
+++ libc/sysdeps/unix/sysv/linux/mips/sys/tas.h	Tue Jul  2 10:57:14 2002
@@ -21,8 +21,6 @@
 #define _SYS_TAS_H 1
 
 #include <features.h>
-#include <sgidefs.h>
-#include <sys/sysmips.h>
 
 __BEGIN_DECLS
 
@@ -34,8 +32,6 @@ extern int _test_and_set (int *p, int v)
 #  define _EXTERN_INLINE extern __inline
 # endif
 
-# if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
-
 _EXTERN_INLINE int
 _test_and_set (int *p, int v) __THROW
 {
@@ -44,10 +40,13 @@ _test_and_set (int *p, int v) __THROW
   __asm__ __volatile__
     ("/* Inline test and set */\n"
      "1:\n\t"
+     ".set	push\n\t"
+     ".set	mips2\n\t"
      "ll	%0,%3\n\t"
      "move	%1,%4\n\t"
      "beq	%0,%4,2f\n\t"
      "sc	%1,%2\n\t"
+     ".set	pop\n\t"
      "beqz	%1,1b\n"
      "2:\n\t"
      "/* End test and set */"
@@ -58,16 +57,6 @@ _test_and_set (int *p, int v) __THROW
   return r;
 }
 
-# else /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
-
-_EXTERN_INLINE int
-_test_and_set (int *p, int v) __THROW
-{
-  return sysmips (MIPS_ATOMIC_SET, (int) p, v, 0);
-}
-
-# endif /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
-
 #endif /* __USE_EXTERN_INLINES */
 
 __END_DECLS

--ikeVEW9yuYc//A+q--
