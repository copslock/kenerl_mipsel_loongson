Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f51BpPe11969
	for linux-mips-outgoing; Fri, 1 Jun 2001 04:51:25 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f51Bnbh11857
	for <linux-mips@oss.sgi.com>; Fri, 1 Jun 2001 04:49:39 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA27957;
	Fri, 1 Jun 2001 13:32:29 +0200 (MET DST)
Date: Fri, 1 Jun 2001 13:32:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andreas Jaeger <aj@suse.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>, Jun Sun <jsun@mvista.com>
Subject: Re: [patch] RFC: A sys__test_and_set() implementation, 2nd iteration
In-Reply-To: <m3ofsaau2d.fsf@D139.suse.de>
Message-ID: <Pine.GSO.3.96.1010531094603.11865B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 31 May 2001, Andreas Jaeger wrote:

> Do it the following way:
> - Define in sysdeps/unix/sysv/linux/kernel-features a new macro, e.g.
>   __ASSUME_TEST_AND_SET with the appropriate guards
> - Do *both* implementations like this:
> #include <kernel-features.h>
> #if __ASSUME_TEST_AND_SET
> fast code without fallback
> #else
> slow code that first tries kernel call and then falls back to sysmips
> #endif
> This way you get the fast one if you configure glibc with
> --enable-kernel=2.4.6 if we assume that 2.4.6 is the first kernel with
> those features. 

 Thanks for the tip.  It's reasonable, indeed.  Now the point is to get
Linux changes (once introduced) back to Linus' tree.  It would be bad to
to tie a kernel version with a feature that would be present in the CVS at
oss. 

> Check other places in glibc for details how this can be done.

 OK, how about this patch then (the kernel version has to be set once
known)?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

glibc-2.2.3-mips-tas.patch
diff -up --recursive --new-file glibc-2.2.3.macro/sysdeps/unix/sysv/linux/kernel-features.h glibc-2.2.3/sysdeps/unix/sysv/linux/kernel-features.h
--- glibc-2.2.3.macro/sysdeps/unix/sysv/linux/kernel-features.h	Wed Apr 25 21:51:14 2001
+++ glibc-2.2.3/sysdeps/unix/sysv/linux/kernel-features.h	Thu May 31 15:54:59 2001
@@ -182,3 +182,8 @@
 # define __ASSUME_FCNTL64		1
 # define __ASSUME_GETDENTS64_SYSCALL	1
 #endif
+
+/* The _test_and_set syscall is available on MIPS since 2.?.?.  */
+#if 0 && defined __mips__
+# define __ASSUME__TEST_AND_SET		1
+#endif
diff -up --recursive --new-file glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/Versions glibc-2.2.3/sysdeps/unix/sysv/linux/mips/Versions
--- glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/Versions	Wed Aug  2 21:53:16 2000
+++ glibc-2.2.3/sysdeps/unix/sysv/linux/mips/Versions	Wed May 30 02:20:28 2001
@@ -16,6 +16,6 @@ libc {
   }
   GLIBC_2.2 {
     # _*
-    _test_and_set;
+    _test_and_set; ___test_and_set;
   }
 }
diff -up --recursive --new-file glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/_test_and_set.c glibc-2.2.3/sysdeps/unix/sysv/linux/mips/_test_and_set.c
--- glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/_test_and_set.c	Fri Jul 28 13:37:25 2000
+++ glibc-2.2.3/sysdeps/unix/sysv/linux/mips/_test_and_set.c	Thu May 31 23:21:50 2001
@@ -21,6 +21,12 @@
    defined in sys/tas.h  */
 
 #include <features.h>
+#include <sgidefs.h>
+#include <unistd.h>
+#include <sysdep.h>
+#include <sys/sysmips.h>
+
+#include "kernel-features.h"
 
 #define _EXTERN_INLINE
 #ifndef __USE_EXTERN_INLINES
@@ -28,3 +34,46 @@
 #endif
 
 #include "sys/tas.h"
+
+#ifdef __NR__test_and_set
+# ifdef __ASSUME__TEST_AND_SET
+#  define __have_no__test_and_set 0
+# else
+static int __have_no__test_and_set;
+# endif
+#endif
+
+int ___test_and_set (int *p, int v)
+{
+#ifdef __NR__test_and_set
+  if (!__builtin_expect(__have_no__test_and_set, 0))
+    {
+      register int *__p asm ("$4") = p;
+      register int __v asm ("$5") = v;
+      register int __n asm ("$2") = SYS_ify (_test_and_set);
+      register int __e asm ("$7");
+      register int __r asm ("$3");
+
+      asm
+        ("syscall"
+	 : "=r" (__r), "=r" (__e)
+	 : "r" (__p), "r" (__v), "r" (__n)
+	 : "$2",
+	   "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24",
+	   "memory");
+# ifndef __ASSUME__TEST_AND_SET
+      if (__builtin_expect(__e, 0))
+	__have_no__test_and_set = 1;
+      else
+# endif
+	return __r;
+    }
+#endif
+#if !defined __NR__test_and_set || !defined __ASSUME__TEST_AND_SET
+    return sysmips (MIPS_ATOMIC_SET, (int) p, v, 0);
+#endif
+}
+
+#if (_MIPS_ISA < _MIPS_ISA_MIPS2)
+strong_alias (___test_and_set, _test_and_set)
+#endif
diff -up --recursive --new-file glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/sys/tas.h glibc-2.2.3/sysdeps/unix/sysv/linux/mips/sys/tas.h
--- glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/sys/tas.h	Sun Jan  7 04:35:41 2001
+++ glibc-2.2.3/sysdeps/unix/sysv/linux/mips/sys/tas.h	Wed May 30 02:18:19 2001
@@ -22,11 +22,11 @@
 
 #include <features.h>
 #include <sgidefs.h>
-#include <sys/sysmips.h>
 
 __BEGIN_DECLS
 
 extern int _test_and_set (int *p, int v) __THROW;
+extern int ___test_and_set (int *p, int v) __THROW;
 
 #ifdef __USE_EXTERN_INLINES
 
@@ -59,15 +59,7 @@ _test_and_set (int *p, int v) __THROW
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
+# endif /* (_MIPS_ISA >= _MIPS_ISA_MIPS2) */
 
 #endif /* __USE_EXTERN_INLINES */
 
