Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JCd2Rw023110
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 05:39:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JCd2sk023109
	for linux-mips-outgoing; Fri, 19 Jul 2002 05:39:02 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JCcARw023100
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 05:38:11 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17VX1h-0001Sb-00; Fri, 19 Jul 2002 14:38:29 +0200
Date: Fri, 19 Jul 2002 14:38:29 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: LL/SC benchmarking [was: Mipsel libc with LL/SC online anywhere?]
Message-ID: <20020719123828.GA5521@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
References: <00ce01c229a4$a7d4ed40$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ce01c229a4$a7d4ed40$10eca8c0@grendel>
User-Agent: Mutt/1.4i
X-Spam-Status: No, hits=-9.4 required=5.0 tests=IN_REP_TO,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 12, 2002 at 03:04:07PM +0200, Kevin D. Kissell wrote:
> I'm benchmarking some code that does lots of
> semaphores, and with the libc from the "standard"
> MIPS/SGI RH 7.1 distribution, those are done using
> sysmips, in the interest of universality.

I'm working on a platform without LL/SC, an embedded system/SOC
with a NEC VR4120A CPU core. To find out the effect of sysmips
vs. emulated LL/SC vs. the branch-likely trick posted by
Kevin D. Kissell <kevink@mips.com> on Tue, 22 Jan 2002 18:16:25 +0100
I created an experimental patch for glibc-2.2.5 which allows
run-time switching of the _test_and_set() and __compare_and_swap()
implementation based on the presence of two "switch files" in /etc/.

Despite its ugliness, I include the patch below for those interested.
(Note: I built my glibc with -mips2, so the patch lacks .set mips2
directives.)

One thing that caused me some headaches was that the __compare_and_swap()
implementation in glibc-2.2.5 is broken (but fixed in glibc CVS and H.J.Lu's
patch).

For lack of a better benchmark I used some of the examples from
glibc-2.2.5/linuxthreads/Examples. The numbers are from the third
of three successive runs of 'time exN >/dev/null'.

sysmips:
  ex1	real    0m0.273s 	user    0m0.040s 	sys     0m0.230s
  ex2	real    0m10.911s 	user    0m2.730s 	sys     0m8.180s
  ex3	real    0m3.648s 	user    0m3.400s 	sys     0m0.250s
  ex5	real    0m4.539s 	user    0m1.830s 	sys     0m2.710s

ll/sc emulation:
  ex1	real    0m0.272s 	user    0m0.020s 	sys     0m0.250s
  ex2	real    0m4.726s 	user    0m1.660s 	sys     0m3.060s
  ex3	real    0m3.968s 	user    0m3.750s 	sys     0m0.220s
  ex5	real    0m4.069s 	user    0m1.710s 	sys     0m2.360s

beql-hack:
  ex1	real    0m0.268s 	user    0m0.010s 	sys     0m0.260s
  ex2	real    0m3.988s 	user    0m1.620s 	sys     0m2.360s
  ex3	real    0m3.965s 	user    0m3.740s 	sys     0m0.220s
  ex5	real    0m2.606s 	user    0m1.000s 	sys     0m1.600s

I think the poor performance of sysmips is caused by the absence of
__compare_and_swap(), which forces libpthread to use less efficient
implementations for semaphore and lock functions.

Running each of the four tests three times yields around one million
LL/SC emulations in /proc/cpuinfo.

I think the beql-hack needs a kernel patch to guarantee k1 !=
MAGIC_COOKIE after each eret, but for a those few tests I was just
taking my chance.

Next, I'm trying to run the pthread tests from LTP. If someone
has a better benchmark code for pthread performance, I'm interested.


Regards,
Johannes



diff -uarN glibc-2.2.5.orig/linuxthreads/sysdeps/mips/pspinlock.c glibc-2.2.5/linuxthreads/sysdeps/mips/pspinlock.c
--- glibc-2.2.5.orig/linuxthreads/sysdeps/mips/pspinlock.c	Thu Jul 18 14:28:07 2002
+++ glibc-2.2.5/linuxthreads/sysdeps/mips/pspinlock.c	Thu Jul 18 18:35:46 2002
@@ -23,7 +23,93 @@
 #include <sys/tas.h>
 #include "internals.h"
 
-#if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+static int
+_compare_and_swap_mips2 (long int *p, long int oldval, long int newval)
+{
+  long int ret;
+
+  __asm__ __volatile__
+    ("/* Inline compare & swap */\n\t"
+     "1:\n\t"
+     "ll	%0,%4\n\t"
+     ".set	push\n"
+     ".set	noreorder\n\t"
+     "bne	%0,%2,2f\n\t"
+     "move	%0,$0\n\t"
+     "move	%0,%3\n\t"
+     ".set	pop\n\t"
+     "sc	%0,%1\n\t"
+     "beqz	%0,1b\n"
+     "2:\n\t"
+     "/* End compare & swap */"
+     : "=&r" (ret), "=m" (*p)
+     : "r" (oldval), "r" (newval), "m" (*p)
+     : "memory");
+
+  return ret;
+}
+
+static int
+_compare_and_swap_mips2_nollsc (long int *p, long int oldval, long int newval)
+{
+  long int r, t;
+
+  __asm__ __volatile__
+    (".set	push\n\t"
+     ".set	noreorder\n\t"
+     "li	%1,0xffaaffaa\n\t"	/* MAGIC_COOKIE */
+     "1:\n\t"
+     "move	$27,%1\n\t"		/* set k1 */
+     "lw	%0,%5\n\t"		/* r = *p */
+     "bne	%0,%3,3f\n\t"		/* if (r != oldval) return 0 */
+     "move	%0,$0\n\t"		/* r = 0 */
+     "move	%0,%4\n\t"		/* r = newval */
+     "beql	$27,%1,2f\n\t"		/* test k1 for change */
+     "sw	%0,%2\n\t"		/* *p = r; return 1 */
+     "b		1b\n\t"			/* k1 changed, retry */
+     "nop\n\t"
+     ".set	pop\n\t"
+     "2:\n"
+     "li	%0,1\n\t"		/* r = 1 */
+     "3:\n"
+     : "=&r" (r), "=&r" (t), "=m" (*p)
+     : "r" (oldval), "r" (newval), "m" (*p)
+     : "memory");
+
+  return r;
+}
+
+int
+compare_and_swap_is_available (void)
+{
+  int fp;
+  /* FIXME: write real test */
+  if ((fp =open ("/etc/mips2_cpu_without_llsc", O_RDONLY)) != -1)
+    {
+      close(fp);
+      _mips_compare_and_swap = _compare_and_swap_mips2_nollsc;
+      return 1;
+    }
+  if ((fp =open ("/etc/mips2_cpu_with_llsc", O_RDONLY)) != -1)
+    {
+      close(fp);
+      _mips_compare_and_swap = _compare_and_swap_mips2;
+      return 1;
+    }
+  return 0;
+}
+
+int (* _mips_compare_and_swap) (long int *p, long int oldval, long int newval)
+  = NULL;
+
+
+#if 0 && (_MIPS_ISA >= _MIPS_ISA_MIPS2)
+  /* don't nother, no one uses this... */
 
 /* This implementation is similar to the one used in the Linux kernel.  */
 int
diff -uarN glibc-2.2.5.orig/linuxthreads/sysdeps/mips/pt-machine.h glibc-2.2.5/linuxthreads/sysdeps/mips/pt-machine.h
--- glibc-2.2.5.orig/linuxthreads/sysdeps/mips/pt-machine.h	Thu Jul 18 14:28:13 2002
+++ glibc-2.2.5/linuxthreads/sysdeps/mips/pt-machine.h	Thu Jul 18 16:27:15 2002
@@ -33,41 +33,11 @@
 
 /* Spinlock implementation; required.  */
 
-#if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
-
-PT_EI long int
-testandset (int *spinlock)
-{
-  long int ret, temp;
-
-  __asm__ __volatile__
-    ("/* Inline spinlock test & set */\n\t"
-     "1:\n\t"
-     "ll	%0,%3\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
-     "bnez	%0,2f\n\t"
-     " li	%1,1\n\t"
-     ".set	pop\n\t"
-     "sc	%1,%2\n\t"
-     "beqz	%1,1b\n"
-     "2:\n\t"
-     "/* End spinlock test & set */"
-     : "=&r" (ret), "=&r" (temp), "=m" (*spinlock)
-     : "m" (*spinlock)
-     : "memory");
-
-  return ret;
-}
-
-#else /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
-
 PT_EI long int
 testandset (int *spinlock)
 {
   return _test_and_set (spinlock, 1);
 }
-#endif /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
 
 
 /* Get some notion of the current stack.  Need not be exactly the top
@@ -78,32 +48,13 @@
 
 /* Compare-and-swap for semaphores. */
 
-#if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
-
 #define HAS_COMPARE_AND_SWAP
+#define TEST_FOR_COMPARE_AND_SWAP
+extern int (* _mips_compare_and_swap) (long int *p, long int oldval, long int newval);
+extern int compare_and_swap_is_available (void);
+
 PT_EI int
 __compare_and_swap (long int *p, long int oldval, long int newval)
 {
-  long int ret;
-
-  __asm__ __volatile__
-    ("/* Inline compare & swap */\n\t"
-     "1:\n\t"
-     "ll	%0,%4\n\t"
-     ".set	push\n"
-     ".set	noreorder\n\t"
-     "bne	%0,%2,2f\n\t"
-     " move	%0,%3\n\t"
-     ".set	pop\n\t"
-     "sc	%0,%1\n\t"
-     "beqz	%0,1b\n"
-     "2:\n\t"
-     "/* End compare & swap */"
-     : "=&r" (ret), "=m" (*p)
-     : "r" (oldval), "r" (newval), "m" (*p)
-     : "memory");
-
-  return ret;
+  return _mips_compare_and_swap (p, oldval, newval);
 }
-
-#endif /* (_MIPS_ISA >= _MIPS_ISA_MIPS2) */
diff -uarN glibc-2.2.5.orig/sysdeps/unix/sysv/linux/mips/_test_and_set.c glibc-2.2.5/sysdeps/unix/sysv/linux/mips/_test_and_set.c
--- glibc-2.2.5.orig/sysdeps/unix/sysv/linux/mips/_test_and_set.c	Thu Jul 18 00:21:15 2002
+++ glibc-2.2.5/sysdeps/unix/sysv/linux/mips/_test_and_set.c	Thu Jul 18 14:39:01 2002
@@ -21,6 +21,12 @@
    defined in sys/tas.h  */
 
 #include <features.h>
+#include <sgidefs.h>
+#include <sys/sysmips.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
 
 #define _EXTERN_INLINE
 #ifndef __USE_EXTERN_INLINES
@@ -28,3 +34,80 @@
 #endif
 
 #include "sys/tas.h"
+
+
+static int
+_test_and_set_mips2_nollsc (int *p, int v) __THROW
+{
+  int r, t;
+
+  __asm__ __volatile__
+    (".set	push\n\t"
+     ".set	noreorder\n\t"
+     "li	%1,0xffaaffaa\n\t"	/* MAGIC_COOKIE */
+     "1:\n\t"
+     "move	$27,%1\n\t"		/* set k1 */
+     "lw	%0,%3\n\t"		/* r = *p */
+     "beq	%0,%4,2f\n\t"		/* if (*p == v) return r */
+     "beql	$27,%1,2f\n\t"		/* test k1 for change */
+     "sw	%4,%2\n\t"		/* *p = v; return r */
+     "b		1b\n\t"			/* retry */
+     "nop\n\t"
+     ".set	pop\n\t"
+     "2:\n"
+     : "=&r" (r), "=&r" (t), "=m" (*p)
+     : "m" (*p), "r" (v)
+     : "memory");
+
+  return r;
+}
+
+static int
+_test_and_set_mips2 (int *p, int v) __THROW
+{
+  int r, t;
+
+  __asm__ __volatile__
+    ("1:\n\t"
+     "ll	%0,%3\n\t"
+     ".set	push\n\t"
+     ".set	noreorder\n\t"
+     "beq	%0,%4,2f\n\t"
+     " move	%1,%4\n\t"
+     ".set	pop\n\t"
+     "sc	%1,%2\n\t"
+     "beqz	%1,1b\n"
+     "2:\n"
+     : "=&r" (r), "=&r" (t), "=m" (*p)
+     : "m" (*p), "r" (v)
+     : "memory");
+
+  return r;
+}
+
+static int
+_test_and_set_mips1 (int *p, int v) __THROW
+{
+  return sysmips (MIPS_ATOMIC_SET, (int) p, v, 0);
+}
+
+static int
+_mips_test_and_set_init (int *p, int v) __THROW
+{
+  int fp;
+  _mips_test_and_set = _test_and_set_mips1;
+  /* FIXME: write real test */
+  if ((fp =open ("/etc/mips2_cpu_without_llsc", O_RDONLY)) != -1)
+    {
+      close(fp);
+      _mips_test_and_set = _test_and_set_mips2_nollsc;
+    }
+  else if ((fp =open ("/etc/mips2_cpu_with_llsc", O_RDONLY)) != -1)
+    {
+      close(fp);
+      _mips_test_and_set = _test_and_set_mips2;
+    }
+  return _mips_test_and_set (p, v);
+}
+
+int (* _mips_test_and_set) (int *p, int v) __THROW = _mips_test_and_set_init;
diff -uarN glibc-2.2.5.orig/sysdeps/unix/sysv/linux/mips/sys/tas.h glibc-2.2.5/sysdeps/unix/sysv/linux/mips/sys/tas.h
--- glibc-2.2.5.orig/sysdeps/unix/sysv/linux/mips/sys/tas.h	Thu Jul 18 00:13:21 2002
+++ glibc-2.2.5/sysdeps/unix/sysv/linux/mips/sys/tas.h	Thu Jul 18 00:26:54 2002
@@ -27,6 +27,7 @@
 __BEGIN_DECLS
 
 extern int _test_and_set (int *p, int v) __THROW;
+extern int (* _mips_test_and_set) (int *p, int v) __THROW;
 
 #ifdef __USE_EXTERN_INLINES
 
@@ -34,40 +35,11 @@
 #  define _EXTERN_INLINE extern __inline
 # endif
 
-# if (_MIPS_ISA >= _MIPS_ISA_MIPS2)
-
-_EXTERN_INLINE int
-_test_and_set (int *p, int v) __THROW
-{
-  int r, t;
-
-  __asm__ __volatile__
-    ("1:\n\t"
-     "ll	%0,%3\n\t"
-     ".set	push\n\t"
-     ".set	noreorder\n\t"
-     "beq	%0,%4,2f\n\t"
-     " move	%1,%4\n\t"
-     ".set	pop\n\t"
-     "sc	%1,%2\n\t"
-     "beqz	%1,1b\n"
-     "2:\n"
-     : "=&r" (r), "=&r" (t), "=m" (*p)
-     : "m" (*p), "r" (v)
-     : "memory");
-
-  return r;
-}
-
-# else /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
-
 _EXTERN_INLINE int
 _test_and_set (int *p, int v) __THROW
 {
-  return sysmips (MIPS_ATOMIC_SET, (int) p, v, 0);
+  return _mips_test_and_set (p, v);
 }
-
-# endif /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */
 
 #endif /* __USE_EXTERN_INLINES */
 
