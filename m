Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f55DMd009532
	for linux-mips-outgoing; Tue, 5 Jun 2001 06:22:39 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f55DL0h09297
	for <linux-mips@oss.sgi.com>; Tue, 5 Jun 2001 06:21:02 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA20513;
	Tue, 5 Jun 2001 14:58:53 +0200 (MET DST)
Date: Tue, 5 Jun 2001 14:58:52 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andreas Jaeger <aj@suse.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>, Jun Sun <jsun@mvista.com>
Subject: Re: [patch] RFC: A sys__test_and_set() implementation, 2nd iteration
In-Reply-To: <howv6w5sr0.fsf@gee.suse.de>
Message-ID: <Pine.GSO.3.96.1010605134626.12987D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 This version should be better.

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
diff -up --recursive --new-file glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/_test_and_set.c glibc-2.2.3/sysdeps/unix/sysv/linux/mips/_test_and_set.c
--- glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/_test_and_set.c	Fri Jul 28 13:37:25 2000
+++ glibc-2.2.3/sysdeps/unix/sysv/linux/mips/_test_and_set.c	Sat Jun  2 13:04:35 2001
@@ -1,4 +1,4 @@
-/* Copyright (C) 2000 Free Software Foundation, Inc.
+/* Copyright (C) 2000, 2001 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Maciej W. Rozycki <macro@ds2.pg.gda.pl>, 2000.
 
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
@@ -28,3 +34,45 @@
 #endif
 
 #include "sys/tas.h"
+
+#if (_MIPS_ISA < _MIPS_ISA_MIPS2)
+
+#if defined __NR__test_and_set && __ASSUME__TEST_AND_SET == 0
+static int __have_no__test_and_set;
+#endif
+
+int _test_and_set (int *p, int v)
+{
+#ifdef __NR__test_and_set
+# if __ASSUME__TEST_AND_SET == 0
+  if (!__builtin_expect(__have_no__test_and_set, 0))
+# endif
+    {
+      register int *__p asm ("$4") = p;
+      register int __v asm ("$5") = v;
+      register int __n asm ("$2") = SYS_ify (_test_and_set);
+      register int __e asm ("$7");
+      register int __r asm ("$3");
+
+      asm ("syscall"
+	   : "=r" (__r), "=r" (__e)
+	   : "r" (__p), "r" (__v), "r" (__n)
+	   : "$2",
+	     "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24",
+	     "memory");
+# if __ASSUME__TEST_AND_SET > 0
+      return __r;
+# else
+      if (!__builtin_expect(__e, 0))
+	return __r;
+
+      __have_no__test_and_set = 1;
+# endif
+    }
+#endif /* __NR__test_and_set */
+#if !defined __NR__test_and_set || __ASSUME__TEST_AND_SET == 0
+    return sysmips (MIPS_ATOMIC_SET, (int) p, v, 0);
+#endif
+}
+
+#endif /* _MIPS_ISA < _MIPS_ISA_MIPS2 */
diff -up --recursive --new-file glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/sys/tas.h glibc-2.2.3/sysdeps/unix/sysv/linux/mips/sys/tas.h
--- glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/sys/tas.h	Sun Jan  7 04:35:41 2001
+++ glibc-2.2.3/sysdeps/unix/sysv/linux/mips/sys/tas.h	Sat Jun  2 13:44:12 2001
@@ -1,4 +1,4 @@
-/* Copyright (C) 2000 Free Software Foundation, Inc.
+/* Copyright (C) 2000, 2001 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Maciej W. Rozycki <macro@ds2.pg.gda.pl>, 2000.
 
@@ -22,7 +22,6 @@
 
 #include <features.h>
 #include <sgidefs.h>
-#include <sys/sysmips.h>
 
 __BEGIN_DECLS
 
@@ -59,15 +58,7 @@ _test_and_set (int *p, int v) __THROW
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
 
