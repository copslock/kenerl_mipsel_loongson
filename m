Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f65BDAI14274
	for linux-mips-outgoing; Thu, 5 Jul 2001 04:13:10 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f65BCiV14261
	for <linux-mips@oss.sgi.com>; Thu, 5 Jul 2001 04:12:45 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA12022;
	Thu, 5 Jul 2001 13:14:17 +0200 (MET DST)
Date: Thu, 5 Jul 2001 13:14:16 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: linux 2.4.5: sysmips(MIPS_ATOMIC_SET) is broken (yep, again...)
Message-ID: <Pine.GSO.3.96.1010705125923.11517B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 Once again a sysmips() patch.  This time the exception fixup code is
broken -- it never returns (well, it probably returns *somewhere* via a
following fixup entry).  Also for whatever reason the R3k code is missing. 

 The following patch fixes it.  While I was at it, I modified contraints a
bit and replaced some of embedded "\t" chars with tabs (the code was
completely unreadable before -- now it should be a bit better, as much as
embedded asm can be).

 The R3k variant works fine for me.  I was unable to thest the ll/sc one,
but the semantics should be unchanged, i.e. if it worked before, so it
will now.  The patch should go into Linus' tree as well. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.5-20010627-sysmips-1
diff -up --recursive --new-file linux-mips-2.4.5-20010627.macro/arch/mips/kernel/sysmips.c linux-mips-2.4.5-20010627/arch/mips/kernel/sysmips.c
--- linux-mips-2.4.5-20010627.macro/arch/mips/kernel/sysmips.c	Mon Apr  9 04:25:42 2001
+++ linux-mips-2.4.5-20010627/arch/mips/kernel/sysmips.c	Wed Jul  4 22:07:30 2001
@@ -75,33 +75,41 @@ sys_sysmips(int cmd, int arg1, int arg2,
 	}
 
 	case MIPS_ATOMIC_SET: {
-#ifdef CONFIG_CPU_HAS_LLSC
-		unsigned int tmp;
+		unsigned int tmp1;
 
 		p = (int *) arg1;
 		errno = verify_area(VERIFY_WRITE, p, sizeof(*p));
 		if (errno)
 			return errno;
-		errno = 0;
 
-		__asm__(".set\tpush\t\t\t# sysmips(MIPS_ATOMIC, ...)\n\t"
-			".set\tmips2\n\t"
-			".set\tnoat\n\t"
-			"1:\tll\t%0, %4\n\t"
-			"move\t$1, %3\n\t"
-			"2:\tsc\t$1, %1\n\t"
-			"beqz\t$1, 1b\n\t"
-			".set\tpop\n\t"
-			".section\t.fixup,\"ax\"\n"
-			"3:\tli\t%2, 1\t\t\t# error\n\t"
+#ifdef CONFIG_CPU_HAS_LLSC
+		__asm__(".set	push	\t\t# sysmips(MIPS_ATOMIC, ...)\n\t"
+			".set	mips2\n"
+			"1:\n\t"
+			"ll	%0, %5\n\t"
+			"move	%3, %4\n"
+			"2:\n\t"
+			"sc	%3, %1\n\t"
+			"beqz	%3, 1b\n"
+			"3:\n\t"
+			".set	pop\n\t"
+			".section .fixup,\"ax\"\n"
+			"4:\n\t"
+			"li	%2, 1	\t\t# error\n\t"
+			"j	3b\n\t"
 			".previous\n\t"
-			".section\t__ex_table,\"a\"\n\t"
-			".word\t1b, 3b\n\t"
-			".word\t2b, 3b\n\t"
+			".section __ex_table,\"a\"\n\t"
+			".word	1b, 4b\n\t"
+			".word	2b, 4b\n\t"
 			".previous\n\t"
-			: "=&r" (tmp), "=o" (* (u32 *) p), "=r" (errno)
-			: "r" (arg2), "o" (* (u32 *) p), "2" (errno)
-			: "$1");
+			: "=&r" (tmp), "=R" (*p), "=r" (errno), "=&r" (tmp1)
+			: "r" (arg2), "1" (*p), "2" (0));
+#else
+		save_and_cli(tmp1);
+		errno = __get_user(tmp, p);
+		errno |= __put_user(arg2, p);
+		restore_flags(tmp1);
+#endif
 
 		if (errno)
 			return -EFAULT;
@@ -119,9 +127,6 @@ sys_sysmips(int cmd, int arg1, int arg2,
 			: /* No outputs */
 			: "r" (&cmd));
 		/* Unreached */
-#else
-	printk("sys_sysmips(MIPS_ATOMIC_SET, ...) not ready for !CONFIG_CPU_HAS_LLSC\n");
-#endif
 	}
 
 	case MIPS_FIXADE:
