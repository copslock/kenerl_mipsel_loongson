Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4SI5Q332333
	for linux-mips-outgoing; Mon, 28 May 2001 11:05:26 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4SHv5d32057
	for <linux-mips@oss.sgi.com>; Mon, 28 May 2001 10:57:31 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA26147;
	Mon, 28 May 2001 17:21:59 +0200 (MET DST)
Date: Mon, 28 May 2001 17:21:59 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>
Subject: [patch] RFC: A sys__test_and_set() implementation
Message-ID: <Pine.GSO.3.96.1010528165056.15200H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 Following is a sys__test_and_set() syscall implementation that should
suite well the _test_and_set() library call as defined by the MIPS ABI.  I
didn't have enough time to implement a glibc wrapper, yet, but I have
written a test program that is much similar to how the wrapper will look
like. 

 The syscall uses a slightly modified calling convention which allows it
to avoid errno mangling code and always return consistent results.  The
call never returns an error -- there is no reason to.  If an illegal
access is detected, a SIGBUS or a SIGSEGV is sent appropriately, depending
on the kind of the violation.  This mimics the ll/sc behaviour in these
circumstances and makes the kernel vs library implementation more
consistent.

 Here is the test program:

#include <stdio.h>
#include <sys/syscall.h>

#ifndef __NR__test_and_set
#define __NR__test_and_set (__NR_Linux + 221)
#endif

static inline int _test_and_set(int *p, int v)
{
	int r;

	asm volatile(
		"la	$4,%1\n\t"
		"move	$5,%2\n\t"
		"li	$2,%3\n\t"
		"syscall\n\t"
		"move	%0,$3"
		: "=r" (r)
		: "m" (*p), "r" (v), "i" (__NR__test_and_set)
		: "$2", "$3", "$4", "$5",
		  "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24",
		  "memory");

	return r;
}

int main(void)
{
	volatile int v = 1;
	int v0, v1, r;

	v0 = v;
	r = _test_and_set((int *)&v, -1);
	v1 = v;

	printf("v0: %i, v1: %i, r: %i\n", v0, v1, r);

	return 0;
}

 Following it the patch.  It was built and tested using a linux
2.4.0-test12 CVS snapshot from oss.  It applies to a current snapshot of
2.4.3, but it wasn't run-time tested in this configuration.  Given it's
self-contained, I hope it works for 2.4.3 as well. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.0-test12-20010110-tas-11
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/arch/mips/kernel/syscall.c linux-mips-2.4.0-test12-20010110/arch/mips/kernel/syscall.c
--- linux-mips-2.4.0-test12-20010110.macro/arch/mips/kernel/syscall.c	Sun Oct 29 05:26:54 2000
+++ linux-mips-2.4.0-test12-20010110/arch/mips/kernel/syscall.c	Sun May 27 22:56:21 2001
@@ -174,6 +174,82 @@ asmlinkage int sys_olduname(struct oldol
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
+#ifdef CONFIG_CPU_HAS_LLSC
+	__asm__(".set	mips2\n\t"
+		"1:\n\t"
+		"ll	%0,%5\n\t"
+		"move	%3,%4\n"
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
+	/* A zero here saves us three instructions. */
+	err = verify_area(VERIFY_WRITE, ptr, 0);
+
+	save_and_cli(tmp);
+	err |= __get_user(ret, ptr);
+	err |= __put_user(val, ptr);	/* No fault unless unwriteable. */
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
 
