Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 14:32:33 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:63183 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226161AbTAJOcc>; Fri, 10 Jan 2003 14:32:32 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA26838;
	Fri, 10 Jan 2003 15:32:37 +0100 (MET)
Date: Fri, 10 Jan 2003 15:32:34 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
cc: Karsten Merker <karsten@excalibur.cologne.de>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: [patch] R4000/R4400 64-bit errata handling
Message-ID: <Pine.GSO.3.96.1030110150339.23678K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 As you might already know there are a few nasty errata in the R4000 and
the early R4400 that hit 64-bit operation badly.  Here is proposed code to
detect them.  If an erratum is found in the processor and no workaround is
applied to a kernel executable, the kernel refuses to run.  In all cases
the result of the probes is output to the bootstrap log.

 The code has bits that make use of features of non-standard tools
(binutils and gcc).  But it doesn't depend on them -- when built with
standard tools and run on an affected system, a kernel will simply fail,
and on good systems it will run normally.  Therefore it's safe to apply,
and if the ultimate implementation in the tools differs, the code may get
adjusted appropriately later. 

 I'd like to apply this code as soon as possible as I consider it a
prerequisite for integrating 64-bit support for the DECstation (to prevent
people from running unreliable code), so please tell me if there are any
doubts about it.  Errata descriptions are available at the MIPS site --
see: 'http://www.mips.com/publications/r400_r5000.html'.  Unfortunately,
despite several attempts to get a permission to duplicate them within
Linux sources, I failed to get one.

 I'd like to express my gratitude to Karsten and Thiemo for testing the
code with their hardware.  Without their help, I wouldn't be able to
prepare appropriate tests for errata my hardware doesn't suffer from. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-pre6-20021212-mips-bugs-20
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips64/kernel/Makefile linux-mips-2.4.20-pre6-20021212/arch/mips64/kernel/Makefile
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips64/kernel/Makefile	2002-12-04 03:56:39.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips64/kernel/Makefile	2003-01-09 19:04:31.000000000 +0000
@@ -32,6 +32,7 @@ ifndef CONFIG_MAPPED_PCI_IO
 obj-y				+= pci-dma.o
 endif
 
-AFLAGS_r4k_genex.o := -P
+CFLAGS_cpu-probe.o	= $(shell if $(CC) $(CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
+AFLAGS_r4k_genex.o	= -P
 
 include $(TOPDIR)/Rules.make
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips64/kernel/cpu-probe.c linux-mips-2.4.20-pre6-20021212/arch/mips64/kernel/cpu-probe.c
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips64/kernel/cpu-probe.c	2002-12-04 03:56:39.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips64/kernel/cpu-probe.c	2003-01-09 20:19:32.000000000 +0000
@@ -1,10 +1,27 @@
+/*
+ *	arch/mips64/kernel/cpu-probe.c
+ *
+ *	Processor capabilities determination functions.
+ *
+ *	Copyright (C) xxxx  the Anonymous
+ *	Copyright (C) 2003  Maciej W. Rozycki
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/ptrace.h>
 #include <linux/stddef.h>
+
 #include <asm/bugs.h>
 #include <asm/cpu.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
+#include <asm/system.h>
 
 /*
  * Not all of the MIPS CPUs have the "wait" instruction available. Moreover,
@@ -90,9 +107,229 @@ static inline void check_wait(void)
 	}
 }
 
+static inline void check_mult_sh(void)
+{
+	unsigned long flags;
+	int m1, m2;
+	long p, s, v;
+
+	printk("Checking for the multiply/shift bug... ");
+
+	__save_and_cli(flags);
+	/*
+	 * The following code leads to a wrong result of dsll32 when
+	 * executed on R4000 rev. 2.2 or 3.0.
+	 *
+	 * See "MIPS R4000PC/SC Errata, Processor Revision 2.2 and
+	 * 3.0" by MIPS Technologies, Inc., errata #16 and #28 for
+	 * details.  I got no permission to duplicate them here,
+	 * sigh... --macro
+	 */
+	asm volatile(
+		".set	push\n\t"
+		".set	noat\n\t"
+		".set	noreorder\n\t"
+		".set	nomacro\n\t"
+		"mult	%1, %2\n\t"
+		"dsll32	%0, %3, %4\n\t"
+		"mflo	$0\n\t"
+		".set	pop"
+		: "=r" (v)
+		: "r" (5), "r" (8), "r" (5), "I" (0)
+		: "hi", "lo", "accum");
+	__restore_flags(flags);
+
+	if (v == 5L << 32) {
+		printk("no.\n");
+		return;
+	}
+
+	printk("yes, workaround... ");
+	__save_and_cli(flags);
+	/*
+	 * We want the multiply and the shift to be isolated from the
+	 * rest of the code to disable gcc optimizations.  Hence the
+	 * asm statements that execute nothing, but make gcc not know
+	 * what the values of m1, m2 and s are and what v and p are
+	 * used for.
+	 *
+	 * We have to use single integers for m1 and m2 and a double
+	 * one for p to be sure the mulsidi3 gcc's RTL multiplication
+	 * instruction has the workaround applied.  Older versions of
+	 * gcc have correct mulsi3, but other multiplication variants
+	 * lack the workaround.
+	 */
+	asm volatile(
+		""
+		: "=r" (m1), "=r" (m2), "=r" (s)
+		: "0" (5), "1" (8), "2" (5));
+	p = m1 * m2;
+	v = s << 32;
+	asm volatile(
+		""
+		: "=r" (v)
+		: "0" (v), "r" (p));
+	__restore_flags(flags);
+
+	if (v == 5L << 32) {
+		printk("yes.\n");
+		return;
+	}
+
+	printk("no.\n");
+	panic("Reliable operation impossible!\n"
+#ifndef CONFIG_CPU_R4000
+	      "Configure for R4000 to enable the workaround."
+#else
+	      "Please report to <linux-mips@linux-mips.org>."
+#endif
+	      );
+}
+
+static volatile int daddi_ov __initdata = 0;
+
+asmlinkage void __init do_daddi_ov(struct pt_regs *regs)
+{
+	daddi_ov = 1;
+	regs->cp0_epc += 4;
+}
+
+static inline void check_daddi(void)
+{
+	extern asmlinkage void handle_daddi_ov(void);
+	unsigned long flags;
+	void *handler;
+	long v;
+
+	printk("Checking for the daddi bug... ");
+
+	__save_and_cli(flags);
+	handler = set_except_vector(12, handle_daddi_ov);
+	/*
+	 * The following code fails to trigger an overflow exception
+	 * when executed on R4000 rev. 2.2 or 3.0.
+	 *
+	 * See "MIPS R4000PC/SC Errata, Processor Revision 2.2 and
+	 * 3.0" by MIPS Technologies, Inc., erratum #23 for details.
+	 * I got no permission to duplicate it here, sigh... --macro
+	 */
+	asm volatile(
+		".set	push\n\t"
+		".set	noat\n\t"
+		".set	noreorder\n\t"
+		".set	nomacro\n\t"
+#ifdef HAVE_AS_SET_DADDI
+		".set	daddi\n\t"
+#endif
+		"daddi	%0, %1, %2\n\t"
+		".set	pop"
+		: "=r" (v)
+		: "r" (0x7fffffffffffedcd), "I" (0x1234));
+	set_except_vector(12, handler);
+	__restore_flags(flags);
+
+	if (daddi_ov) {
+		printk("no.\n");
+		return;
+	}
+
+	printk("yes, workaround... ");
+
+	__save_and_cli(flags);
+	handler = set_except_vector(12, handle_daddi_ov);
+	asm volatile(
+		"daddi	%0, %1, %2"
+		: "=r" (v)
+		: "r" (0x7fffffffffffedcd), "I" (0x1234));
+	set_except_vector(12, handler);
+	__restore_flags(flags);
+
+	if (daddi_ov) {
+		printk("yes.\n");
+		return;
+	}
+
+	printk("no.\n");
+	panic("Reliable operation impossible!\n"
+#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
+	      "Configure for R4000 or R4400 to enable the workaround."
+#else
+	      "Please report to <linux-mips@linux-mips.org>."
+#endif
+	      );
+}
+
+static inline void check_daddiu(void)
+{
+	long v, w;
+
+	printk("Checking for the daddiu bug... ");
+
+	/*
+	 * The following code leads to a wrong result of daddiu when
+	 * executed on R4400 rev. 1.0.
+	 *
+	 * See "MIPS R4400PC/SC Errata, Processor Revision 1.0" by
+	 * MIPS Technologies, Inc., erratum #7 for details.
+	 *
+	 * According to "MIPS R4000PC/SC Errata, Processor Revision
+	 * 2.2 and 3.0" by MIPS Technologies, Inc., erratum #41 this
+	 * problem affects R4000 rev. 2.2 and 3.0, too.  Testing
+	 * failed to trigger it so far.
+	 *
+	 * I got no permission to duplicate the errata here, sigh...
+	 * --macro
+	 */
+	asm volatile(
+		".set	push\n\t"
+		".set	noat\n\t"
+		".set	noreorder\n\t"
+		".set	nomacro\n\t"
+#ifdef HAVE_AS_SET_DADDI
+		".set	daddi\n\t"
+#endif
+		"daddiu	%0, %2, %3\n\t"
+		"addiu	%1, $0, %3\n\t"
+		"daddu	%1, %2\n\t"
+		".set	pop"
+		: "=&r" (v), "=&r" (w)
+		: "r" (0x7fffffffffffedcd), "I" (0x1234));
+
+	if (v == w) {
+		printk("no.\n");
+		return;
+	}
+
+	printk("yes, workaround... ");
+
+	asm volatile(
+		"daddiu	%0, %2, %3\n\t"
+		"addiu	%1, $0, %3\n\t"
+		"daddu	%1, %2"
+		: "=&r" (v), "=&r" (w)
+		: "r" (0x7fffffffffffedcd), "I" (0x1234));
+
+	if (v == w) {
+		printk("yes.\n");
+		return;
+	}
+
+	printk("no.\n");
+	panic("Reliable operation impossible!\n"
+#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
+	      "Configure for R4000 or R4400 to enable the workaround."
+#else
+	      "Please report to <linux-mips@linux-mips.org>."
+#endif
+	      );
+}
+
 void __init check_bugs(void)
 {
 	check_wait();
+	check_mult_sh();
+	check_daddi();
+	check_daddiu();
 }
 
 /*
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips64/kernel/r4k_genex.S linux-mips-2.4.20-pre6-20021212/arch/mips64/kernel/r4k_genex.S
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips64/kernel/r4k_genex.S	2002-10-02 17:22:18.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips64/kernel/r4k_genex.S	2002-10-22 21:44:51.000000000 +0000
@@ -35,6 +35,11 @@
 
 	__INIT
 
+/* A temporary overflow handler used by check_daddi(). */
+
+	BUILD_HANDLER  daddi_ov daddi_ov none silent	/* #12 */
+
+
 /* General exception handler for CPUs with virtual coherency exception.
  *
  * Be careful when changing this, it has to be at most 256 (as a special
