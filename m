Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DFMLd09518
	for linux-mips-outgoing; Wed, 13 Jun 2001 08:22:21 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DFM5P09496
	for <linux-mips@oss.sgi.com>; Wed, 13 Jun 2001 08:22:16 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA24267;
	Wed, 13 Jun 2001 17:22:49 +0200 (MET DST)
Date: Wed, 13 Jun 2001 17:22:49 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux-mips@oss.sgi.com
Subject: Re: A new mips toolchain is available
In-Reply-To: <20010613080829.A9739@lucon.org>
Message-ID: <Pine.GSO.3.96.1010613171535.9854L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 13 Jun 2001, H . J . Lu wrote:

> >  What's the problem with the kernel?  It works fine for my R3400A
> > DECstation.  Glibc is 2.2.3 as released.  If there is something wrong, I
> > definitely want to know. 
> 
> It has something to do with the atomic emulation in kernel for mips I.

 Hmm, I thought Florian's sysmips() fixes went in.  Here is a patch I use
successfully for some time.  It doesn't work for small negative integers,
but glibc doesn't use them, AFAIK.

 Another possibility is to use the set of two patches for
sys__test_and_set() I've sent here recently.  This would break portability
for now, though, if you wanted to distribute glibc or kernel binaries.
This is also the reason I didn't put my current patched version of glibc
on my FTP site.

 The patch is not against a current version of the kernel -- you might
need to apply it manually.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.0-test11-20001211-sysmips-0
diff -up --recursive --new-file linux-mips-2.4.0-test11-20001211.macro/arch/mips/kernel/sysmips.c linux-mips-2.4.0-test11-20001211/arch/mips/kernel/sysmips.c
--- linux-mips-2.4.0-test11-20001211.macro/arch/mips/kernel/sysmips.c	Sat Nov 18 05:27:01 2000
+++ linux-mips-2.4.0-test11-20001211/arch/mips/kernel/sysmips.c	Tue Dec 12 23:09:57 2000
@@ -75,21 +75,31 @@ sys_sysmips(int cmd, int arg1, int arg2,
 	}
 
 	case MIPS_ATOMIC_SET: {
-		unsigned int tmp;
+		int tmp1;
 
 		p = (int *) arg1;
 		errno = verify_area(VERIFY_WRITE, p, sizeof(*p));
 		if (errno)
 			return errno;
+
 		errno = 0;
 
+#ifndef CONFIG_CPU_HAS_LLSC
+
+		save_and_cli(tmp1);
+		errno |= __get_user(tmp, p);
+		errno |= __put_user(arg2, p);
+		restore_flags(tmp1);
+
+#else /* CONFIG_CPU_HAS_LLSC */
+
 		__asm__(".set\tpush\t\t\t# sysmips(MIPS_ATOMIC, ...)\n\t"
 			".set\tmips2\n\t"
 			".set\tnoat\n\t"
-			"1:\tll\t%0, %4\n\t"
-			"move\t$1, %3\n\t"
-			"2:\tsc\t$1, %1\n\t"
-			"beqz\t$1, 1b\n\t"
+			"1:\tll\t%0, %5\n\t"
+			"move\t%3, %4\n\t"
+			"2:\tsc\t%3, %1\n\t"
+			"beqz\t%3, 1b\n\t"
 			".set\tpop\n\t"
 			".section\t.fixup,\"ax\"\n"
 			"3:\tli\t%2, 1\t\t\t# error\n\t"
@@ -98,23 +108,17 @@ sys_sysmips(int cmd, int arg1, int arg2,
 			".word\t1b, 3b\n\t"
 			".word\t2b, 3b\n\t"
 			".previous\n\t"
-			: "=&r" (tmp), "=o" (* (u32 *) p), "=r" (errno)
+			: "=&r" (tmp), "=o" (* (u32 *) p), "=r" (errno),
+			  "=&r" (tmp1)
 			: "r" (arg2), "o" (* (u32 *) p), "2" (errno)
 			: "$1");
 
+#endif /* CONFIG_CPU_HAS_LLSC */
+
 		if (errno)
 			return -EFAULT;
 
-		/* We're skipping error handling etc.  */
-		if (current->ptrace & PT_TRACESYS)
-			syscall_trace();
-
-		__asm__ __volatile__(
-			"move\t$29, %0\n\t"
-			"j\tret_from_sys_call"
-			: /* No outputs */
-			: "r" (&cmd));
-		/* Unreached */
+		return tmp;
 	}
 
 	case MIPS_FIXADE:
