Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4V3Q2P28397
	for linux-mips-outgoing; Wed, 30 May 2001 20:26:02 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4V3Pkh28394
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 20:25:47 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA03643
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 20:25:44 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA21204;
	Wed, 30 May 2001 19:58:44 +0200 (MET DST)
Date: Wed, 30 May 2001 19:58:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>, Andreas Jaeger <aj@suse.de>,
   Jun Sun <jsun@mvista.com>
Subject: [patch] RFC: A sys__test_and_set() implementation, 2nd iteration
Message-ID: <Pine.GSO.3.96.1010530190118.9456D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 Here is the second version of the sys__test_and_set() syscall suite.  A
glibc patch is included this time as well.

 There are two small changes to the sys__test_and_set() implementation:

1. verify_area() is now called for the ll/sc version as well.  Otherwise
one could pass a KSEG address and gain unauthorized access.

2. The fuction now returns immediately without performing a write access
if the value stored in the memory wouldn't change.  This is to avoid the
need of a potentially costful sc operation; for consistency, this is also
done for the non-ll/sc version. 

 The glibc patch should be fairly obvious.  There is no inline version of
the _test_and_set() function for MIPS I anymore -- while previously it
saved an extra stack frame just to call sysmips(), this would be pointless
now (well, not quite as long as we fallback to sysmips(), actually, but
that is a temporary compatibility bit that will soon get removed, I hope).
Note that while sys__test_and_set() never returns an error, there might
one happen if someone tries to execute the syscall running a kernel that
does not support it.  Hence we fall back to sysmips(). 

 The official entry point is _test_and_set().  There is also the
___test_and_set() entry point defined, mostly for completeness for MIPS
II+ systems, to be sure all syscalls actually have their wrappers
exported.  Not to be used under normal circumstances, though.

 Andreas, what do you think: Should we fall back to sysmips() as in the
following patch (at a considerable performance hit -- without the fallback
the entire ___test_and_set() wrapper is seven instructions long) or just
require a specific minimum kernel version bail out at the compile time if
no __NR__test_and_set is defined?  Granted, pthreads don't run for
MIPS/Linux for a long time, so it's possible the user base is not that
large such an abrupt switch would be impossible.  Especially as sysmips() 
seems to be continuously in flux for the last few months.  I assume the
switch to the new syscall would be mandatory for glibc 2.3 in any case. 

 I'm open to constructive feedback.  An open question is whether returning
the result in v1 is clean.  I believe it is -- I haven't been convinced
that storing the result in a memory location passed as the third argument
is cleaner.  Certainly it's not faster and v1 is still dedicated to be a
result register.  It's used by sys_pipe() this way, for example. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.0-test12-20010110-tas-12
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/arch/mips/kernel/syscall.c linux-mips-2.4.0-test12-20010110/arch/mips/kernel/syscall.c
--- linux-mips-2.4.0-test12-20010110.macro/arch/mips/kernel/syscall.c	Sun Oct 29 05:26:54 2000
+++ linux-mips-2.4.0-test12-20010110/arch/mips/kernel/syscall.c	Wed May 30 13:01:00 2001
@@ -174,6 +174,90 @@ asmlinkage int sys_olduname(struct oldol
 	return error;
 }
 
+/* Note: errno is always zero and the result is in v1. */
+asmlinkage int sys__test_and_set(struct pt_regs regs)
+{
+	int *ptr, val, ret, err, tmp;
+
+	ptr = (int *)(regs.regs[4]);
+	val = (int)(regs.regs[5]);
+
+	/* Don't emulate unaligned accesses. */
+	if ((int)ptr & 3)
+		goto fault;
+
+	/* A zero here saves us three instructions. */
+	err = verify_area(VERIFY_WRITE, ptr, 0);
+	if (err)
+		goto fault;
+
+#ifdef CONFIG_CPU_HAS_LLSC
+	__asm__(".set	mips2\n\t"
+		"1:\n\t"
+		"ll	%0,%5\n\t"
+		".set	push\n\t"
+		".set	noreorder\n\t"
+		"beq	%0,%4,3f\n\t"
+		" move	%3,%4\n"
+		".set	pop\n\t"
+		"2:\n\t"
+		"sc	%3,%1\n\t"
+		"beqz	%3,1b\n\t"
+		"3:\n\t"
+		".set	mips0\n\t"
+		".section .fixup,\"ax\"\n"
+		"4:\n\t"
+		"li	%2,%7\n\t"
+		"j	3b\n\t"
+		".previous\n\t"
+		".section __ex_table,\"a\"\n\t"
+		".word	1b,4b\n\t"
+		".word	2b,4b\n\t"
+		".previous"
+		: "=&r" (ret), "=R" (*ptr), "=r" (err), "=&r" (tmp)
+		: "r" (val), "1" (*ptr), "2" (0), "i" (-EFAULT));
+#else
+	save_and_cli(tmp);
+	err = __get_user(ret, ptr);
+	if (ret != val)
+		err |= __put_user(val, ptr);	/* No fault
+						   unless unwriteable. */
+	restore_flags(tmp);
+#endif
+
+	if (err)
+		goto fault;
+
+	(int)(regs.regs[3]) = ret;
+
+	return 0;
+
+fault:
+	regs.cp0_epc -= 4;		/* Go back to SYSCALL. */
+
+	{
+		struct siginfo info;
+
+
+		if ((int)ptr & 3) {
+			info.si_signo = SIGBUS;
+			info.si_code = BUS_ADRALN;
+		} else {
+			info.si_signo = SIGSEGV;
+			if (verify_area(VERIFY_WRITE, ptr, 0))
+				info.si_code = SEGV_ACCERR;
+			else
+				info.si_code = SEGV_MAPERR;
+		}
+		info.si_errno = 0;
+		info.si_addr = (void *)regs.cp0_epc;
+		
+		force_sig_info(info.si_signo, &info, current);
+	}
+
+	return 0;
+}
+
 /*
  * Do the indirect syscall syscall.
  * Don't care about kernel locking; the actual syscall will do it.
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/arch/mips/kernel/syscalls.h linux-mips-2.4.0-test12-20010110/arch/mips/kernel/syscalls.h
--- linux-mips-2.4.0-test12-20010110.macro/arch/mips/kernel/syscalls.h	Wed Nov  8 05:26:57 2000
+++ linux-mips-2.4.0-test12-20010110/arch/mips/kernel/syscalls.h	Wed May 23 23:59:02 2001
@@ -235,3 +235,4 @@ SYS(sys_mincore, 3)
 SYS(sys_madvise, 3)
 SYS(sys_getdents64, 3)
 SYS(sys_fcntl64, 3)				/* 4220 */
+SYS(sys__test_and_set, 0)
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/include/asm-mips/unistd.h linux-mips-2.4.0-test12-20010110/include/asm-mips/unistd.h
--- linux-mips-2.4.0-test12-20010110.macro/include/asm-mips/unistd.h	Thu Oct 26 04:27:09 2000
+++ linux-mips-2.4.0-test12-20010110/include/asm-mips/unistd.h	Wed May 23 23:09:00 2001
@@ -233,11 +233,12 @@
 #define __NR_madvise			(__NR_Linux + 218)
 #define __NR_getdents64			(__NR_Linux + 219)
 #define __NR_fcntl64			(__NR_Linux + 220)
+#define __NR__test_and_set		(__NR_Linux + 221)
 
 /*
  * Offset of the last Linux flavoured syscall
  */
-#define __NR_Linux_syscalls		220
+#define __NR_Linux_syscalls		221
 
 #ifndef _LANGUAGE_ASSEMBLY
 

glibc-2.2.3-mips-tas.patch
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
+++ glibc-2.2.3/sysdeps/unix/sysv/linux/mips/_test_and_set.c	Wed May 30 12:05:33 2001
@@ -21,10 +21,47 @@
    defined in sys/tas.h  */
 
 #include <features.h>
+#include <sgidefs.h>
+#include <unistd.h>
+#include <sysdep.h>
+#include <sys/sysmips.h>
 
 #define _EXTERN_INLINE
 #ifndef __USE_EXTERN_INLINES
 # define __USE_EXTERN_INLINES 1
 #endif
 
+#ifdef __NR__test_and_set
+#define __HAVE__TEST_AND_SET 1
+#else
+#define __HAVE__TEST_AND_SET 0
+#endif
+
 #include "sys/tas.h"
+
+int ___test_and_set (int *p, int v)
+{
+  if (__HAVE__TEST_AND_SET)
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
+      if (!__e)
+	return __r;
+    }
+  return sysmips (MIPS_ATOMIC_SET, (int) p, v, 0);
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
 
