Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 12:43:58 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:61092 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20030599AbXJWLnt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Oct 2007 12:43:49 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 13E37400A5;
	Tue, 23 Oct 2007 13:43:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id ILzR537PdKuU; Tue, 23 Oct 2007 13:43:11 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 921FF40085;
	Tue, 23 Oct 2007 13:43:11 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9NBhE43019805;
	Tue, 23 Oct 2007 13:43:15 +0200
Date:	Tue, 23 Oct 2007 12:43:11 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] R4000/R4400 errata workarounds
Message-ID: <Pine.LNX.4.64N.0710221906540.988@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4572/Tue Oct 23 09:50:50 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 This is the gereric part of R4000/R4400 errata workarounds.  They include 
compiler and assembler support as well as some source code modifications 
to address the problems with some combinations of multiply/divide+shift 
instructions as well as the daddi and daddiu instructions.

 Changes included are as follows:

1. New Kconfig options to select workarounds by platforms as necessary.

2. Arch top-level Makefile to pass necessary options to the compiler; also 
   incompatible configurations are detected (-mno-sym32 unsupported as 
   horribly intrusive for little gain).

3. Bug detection updated and shuffled -- the multiply/divide+shift problem 
   is lethal enough that if not worked around it makes the kernel crash in 
   time_init() because of a division by zero; the daddiu erratum might 
   also trigger early potentially, though I have not observed it.  On the 
   other hand the daddi detection code requires the exception subsystem to 
   have been initialised (and is there mainly for information).

4. r4k_daddiu_bug() added so that the existence of the erratum can be 
   queried by code at the run time as necessary; useful for generated code 
   like TLB fault and copy/clear page handlers.

5. __udelay() updated as it uses multiplication in inline assembly.

 Note that -mdaddi requires modified toolchain (which has been maintained 
by myself and available from my site for ~4years now -- versions covered 
are GCC 2.95.4 - 4.1.2 and binutils from 2.13 onwards).  The -mfix-r4000 
and -mfix-r4400 have been standard for a while though.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 The daddiu-specific part is big enough for me to send it separately.  
This has been verified with a DECstation 5000/150 and works for me 
(including getting rid of that division by zero).

 Comments are welcome.

 Please consider.

  Maciej

patch-mips-2.6.23-20071022-r4000-27
diff -up --recursive --new-file linux-mips-2.6.23-20071022.macro/arch/mips/Kconfig linux-mips-2.6.23-20071022/arch/mips/Kconfig
--- linux-mips-2.6.23-20071022.macro/arch/mips/Kconfig	2007-10-22 04:55:29.000000000 +0000
+++ linux-mips-2.6.23-20071022/arch/mips/Kconfig	2007-10-22 18:00:38.000000000 +0000
@@ -84,9 +84,12 @@ config MACH_DECSTATION
 	bool "DECstations"
 	select BOOT_ELF32
 	select CEVT_R4K
+	select CPU_DADDI_WORKAROUNDS if 64BIT
+	select CPU_R4000_WORKAROUNDS if 64BIT
+	select CPU_R4400_WORKAROUNDS if 64BIT
 	select DMA_NONCOHERENT
-	select NO_IOPORT
 	select IRQ_CPU
+	select NO_IOPORT
 	select SYS_HAS_CPU_R3000
 	select SYS_HAS_CPU_R4X00
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -1574,6 +1577,19 @@ config GENERIC_CLOCKEVENTS_BROADCAST
 	bool
 
 #
+# CPU non-features
+#
+config CPU_DADDI_WORKAROUNDS
+	bool
+
+config CPU_R4000_WORKAROUNDS
+	bool
+	select CPU_R4400_WORKAROUNDS
+
+config CPU_R4400_WORKAROUNDS
+	bool
+
+#
 # Use the generic interrupt handling code in kernel/irq/:
 #
 config GENERIC_HARDIRQS
diff -up --recursive --new-file linux-mips-2.6.23-20071022.macro/arch/mips/Makefile linux-mips-2.6.23-20071022/arch/mips/Makefile
--- linux-mips-2.6.23-20071022.macro/arch/mips/Makefile	2007-10-22 04:55:29.000000000 +0000
+++ linux-mips-2.6.23-20071022/arch/mips/Makefile	2007-10-22 18:00:38.000000000 +0000
@@ -139,6 +139,10 @@ cflags-$(CONFIG_CPU_R8000)	+= -march=r80
 cflags-$(CONFIG_CPU_R10000)	+= $(call cc-option,-march=r10000,-march=r8000) \
 			-Wa,--trap
 
+cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)
+cflags-$(CONFIG_CPU_R4400_WORKAROUNDS)	+= $(call cc-option,-mfix-r4400,)
+cflags-$(CONFIG_CPU_DADDI_WORKAROUNDS)	+= $(call cc-option,-mno-daddi,)
+
 ifdef CONFIG_CPU_SB1
 ifdef CONFIG_SB1_PASS_1_WORKAROUNDS
 MODFLAGS	+= -msb1-pass1-workarounds
@@ -600,10 +604,10 @@ ifdef CONFIG_64BIT
     endif
   endif
 
-  ifeq ($(KBUILD_SYM32), y)
-    ifeq ($(call cc-option-yn,-msym32), y)
-      cflags-y += -msym32 -DKBUILD_64BIT_SYM32
-    endif
+  ifeq ($(KBUILD_SYM32)$(call cc-option-yn,-msym32), yy)
+    cflags-y += -msym32 -DKBUILD_64BIT_SYM32
+  else ifeq ($(CONFIG_CPU_DADDI_WORKAROUNDS), y)
+    $(error CONFIG_CPU_DADDI_WORKAROUNDS unsupported without -msym32)
   endif
 endif
 
diff -up --recursive --new-file linux-mips-2.6.23-20071022.macro/arch/mips/kernel/cpu-bugs64.c linux-mips-2.6.23-20071022/arch/mips/kernel/cpu-bugs64.c
--- linux-mips-2.6.23-20071022.macro/arch/mips/kernel/cpu-bugs64.c	2007-10-11 04:56:52.000000000 +0000
+++ linux-mips-2.6.23-20071022/arch/mips/kernel/cpu-bugs64.c	2007-10-20 00:10:40.000000000 +0000
@@ -18,6 +18,15 @@
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 
+static char bug64hit[] __initdata =
+	"reliable operation impossible!\n%s";
+static char nowar[] __initdata =
+	"Please report to <linux-mips@linux-mips.org>.";
+static char r4kwar[] __initdata =
+	"Enable CPU_R4000_WORKAROUNDS to rectify.";
+static char daddiwar[] __initdata =
+	"Enable CPU_DADDI_WORKAROUNDS to rectify.";
+
 static inline void align_mod(const int align, const int mod)
 {
 	asm volatile(
@@ -155,13 +164,7 @@ static inline void check_mult_sh(void)
 	}
 
 	printk("no.\n");
-	panic("Reliable operation impossible!\n"
-#ifndef CONFIG_CPU_R4000
-	      "Configure for R4000 to enable the workaround."
-#else
-	      "Please report to <linux-mips@linux-mips.org>."
-#endif
-	      );
+	panic(bug64hit, !R4000_WAR ? r4kwar : nowar);
 }
 
 static volatile int daddi_ov __initdata = 0;
@@ -233,15 +236,11 @@ static inline void check_daddi(void)
 	}
 
 	printk("no.\n");
-	panic("Reliable operation impossible!\n"
-#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
-	      "Configure for R4000 or R4400 to enable the workaround."
-#else
-	      "Please report to <linux-mips@linux-mips.org>."
-#endif
-	      );
+	panic(bug64hit, !DADDI_WAR ? daddiwar : nowar);
 }
 
+int daddiu_bug __initdata = -1;
+
 static inline void check_daddiu(void)
 {
 	long v, w, tmp;
@@ -281,7 +280,9 @@ static inline void check_daddiu(void)
 		: "=&r" (v), "=&r" (w), "=&r" (tmp)
 		: "I" (0xffffffffffffdb9aUL), "I" (0x1234));
 
-	if (v == w) {
+	daddiu_bug = v != w;
+
+	if (!daddiu_bug) {
 		printk("no.\n");
 		return;
 	}
@@ -303,18 +304,16 @@ static inline void check_daddiu(void)
 	}
 
 	printk("no.\n");
-	panic("Reliable operation impossible!\n"
-#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
-	      "Configure for R4000 or R4400 to enable the workaround."
-#else
-	      "Please report to <linux-mips@linux-mips.org>."
-#endif
-	      );
+	panic(bug64hit, !DADDI_WAR ? daddiwar : nowar);
 }
 
-void __init check_bugs64(void)
+void __init check_bugs64_early(void)
 {
 	check_mult_sh();
-	check_daddi();
 	check_daddiu();
 }
+
+void __init check_bugs64(void)
+{
+	check_daddi();
+}
diff -up --recursive --new-file linux-mips-2.6.23-20071022.macro/arch/mips/kernel/setup.c linux-mips-2.6.23-20071022/arch/mips/kernel/setup.c
--- linux-mips-2.6.23-20071022.macro/arch/mips/kernel/setup.c	2007-10-11 04:56:52.000000000 +0000
+++ linux-mips-2.6.23-20071022/arch/mips/kernel/setup.c	2007-10-20 00:10:40.000000000 +0000
@@ -8,7 +8,7 @@
  * Copyright (C) 1994, 95, 96, 97, 98, 99, 2000, 01, 02, 03  Ralf Baechle
  * Copyright (C) 1996 Stoned Elipot
  * Copyright (C) 1999 Silicon Graphics, Inc.
- * Copyright (C) 2000 2001, 2002  Maciej W. Rozycki
+ * Copyright (C) 2000, 2001, 2002, 2007  Maciej W. Rozycki
  */
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -24,6 +24,7 @@
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
+#include <asm/bugs.h>
 #include <asm/cache.h>
 #include <asm/cpu.h>
 #include <asm/sections.h>
@@ -533,6 +534,7 @@ void __init setup_arch(char **cmdline_p)
 	}
 #endif
 	cpu_report();
+	check_bugs_early();
 
 #if defined(CONFIG_VT)
 #if defined(CONFIG_VGA_CONSOLE)
diff -up --recursive --new-file linux-mips-2.6.23-20071022.macro/include/asm-mips/bugs.h linux-mips-2.6.23-20071022/include/asm-mips/bugs.h
--- linux-mips-2.6.23-20071022.macro/include/asm-mips/bugs.h	2006-09-20 20:51:11.000000000 +0000
+++ linux-mips-2.6.23-20071022/include/asm-mips/bugs.h	2007-10-22 18:04:34.000000000 +0000
@@ -1,19 +1,34 @@
 /*
  * This is included by init/main.c to check for architecture-dependent bugs.
  *
+ * Copyright (C) 2007  Maciej W. Rozycki
+ *
  * Needs:
  *	void check_bugs(void);
  */
 #ifndef _ASM_BUGS_H
 #define _ASM_BUGS_H
 
+#include <linux/bug.h>
 #include <linux/delay.h>
+
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
 
+extern int daddiu_bug;
+
+extern void check_bugs64_early(void);
+
 extern void check_bugs32(void);
 extern void check_bugs64(void);
 
+static inline void check_bugs_early(void)
+{
+#ifdef CONFIG_64BIT
+	check_bugs64_early();
+#endif
+}
+
 static inline void check_bugs(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -25,4 +40,14 @@ static inline void check_bugs(void)
 #endif
 }
 
+static inline int r4k_daddiu_bug(void)
+{
+#ifdef CONFIG_64BIT
+	WARN_ON(daddiu_bug < 0);
+	return daddiu_bug != 0;
+#else
+	return 0;
+#endif
+}
+
 #endif /* _ASM_BUGS_H */
diff -up --recursive --new-file linux-mips-2.6.23-20071022.macro/include/asm-mips/delay.h linux-mips-2.6.23-20071022/include/asm-mips/delay.h
--- linux-mips-2.6.23-20071022.macro/include/asm-mips/delay.h	2007-10-11 04:56:53.000000000 +0000
+++ linux-mips-2.6.23-20071022/include/asm-mips/delay.h	2007-10-20 00:10:40.000000000 +0000
@@ -6,13 +6,16 @@
  * Copyright (C) 1994 by Waldorf Electronics
  * Copyright (C) 1995 - 2000, 01, 03 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2007  Maciej W. Rozycki
  */
 #ifndef _ASM_DELAY_H
 #define _ASM_DELAY_H
 
 #include <linux/param.h>
 #include <linux/smp.h>
+
 #include <asm/compiler.h>
+#include <asm/war.h>
 
 static inline void __delay(unsigned long loops)
 {
@@ -50,7 +53,7 @@ static inline void __delay(unsigned long
 
 static inline void __udelay(unsigned long usecs, unsigned long lpj)
 {
-	unsigned long lo;
+	unsigned long hi, lo;
 
 	/*
 	 * The rates of 128 is rounded wrongly by the catchall case
@@ -70,11 +73,16 @@ static inline void __udelay(unsigned lon
 		: "=h" (usecs), "=l" (lo)
 		: "r" (usecs), "r" (lpj)
 		: GCC_REG_ACCUM);
-	else if (sizeof(long) == 8)
+	else if (sizeof(long) == 8 && !R4000_WAR)
 		__asm__("dmultu\t%2, %3"
 		: "=h" (usecs), "=l" (lo)
 		: "r" (usecs), "r" (lpj)
 		: GCC_REG_ACCUM);
+	else if (sizeof(long) == 8 && R4000_WAR)
+		__asm__("dmultu\t%3, %4\n\tmfhi\t%0"
+		: "=r" (usecs), "=h" (hi), "=l" (lo)
+		: "r" (usecs), "r" (lpj)
+		: GCC_REG_ACCUM);
 
 	__delay(usecs);
 }
diff -up --recursive --new-file linux-mips-2.6.23-20071022.macro/include/asm-mips/war.h linux-mips-2.6.23-20071022/include/asm-mips/war.h
--- linux-mips-2.6.23-20071022.macro/include/asm-mips/war.h	2007-10-11 04:56:53.000000000 +0000
+++ linux-mips-2.6.23-20071022/include/asm-mips/war.h	2007-10-20 00:10:40.000000000 +0000
@@ -4,6 +4,7 @@
  * for more details.
  *
  * Copyright (C) 2002, 2004, 2007 by Ralf Baechle
+ * Copyright (C) 2007  Maciej W. Rozycki
  */
 #ifndef _ASM_WAR_H
 #define _ASM_WAR_H
@@ -11,6 +12,67 @@
 #include <war.h>
 
 /*
+ * Work around certain R4000 CPU errata (as implemented by GCC):
+ *
+ * - A double-word or a variable shift may give an incorrect result
+ *   if executed immediately after starting an integer division:
+ *   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
+ *   erratum #28
+ *   "MIPS R4000MC Errata, Processor Revision 2.2 and 3.0", erratum
+ *   #19
+ *
+ * - A double-word or a variable shift may give an incorrect result
+ *   if executed while an integer multiplication is in progress:
+ *   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
+ *   errata #16 & #28
+ *
+ * - An integer division may give an incorrect result if started in
+ *   a delay slot of a taken branch or a jump:
+ *   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
+ *   erratum #52
+ */
+#ifdef CONFIG_CPU_R4000_WORKAROUNDS
+#define R4000_WAR 1
+#else
+#define R4000_WAR 0
+#endif
+
+/*
+ * Work around certain R4400 CPU errata (as implemented by GCC):
+ *
+ * - A double-word or a variable shift may give an incorrect result
+ *   if executed immediately after starting an integer division:
+ *   "MIPS R4400MC Errata, Processor Revision 1.0", erratum #10
+ *   "MIPS R4400MC Errata, Processor Revision 2.0 & 3.0", erratum #4
+ */
+#ifdef CONFIG_CPU_R4400_WORKAROUNDS
+#define R4400_WAR 1
+#else
+#define R4400_WAR 0
+#endif
+
+/*
+ * Work around the "daddi" and "daddiu" CPU errata:
+ *
+ * - The `daddi' instruction fails to trap on overflow.
+ *   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
+ *   erratum #23
+ *
+ * - The `daddiu' instruction can produce an incorrect result.
+ *   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
+ *   erratum #41
+ *   "MIPS R4000MC Errata, Processor Revision 2.2 and 3.0", erratum
+ *   #15
+ *   "MIPS R4400PC/SC Errata, Processor Revision 1.0", erratum #7
+ *   "MIPS R4400MC Errata, Processor Revision 1.0", erratum #5
+ */
+#ifdef CONFIG_CPU_DADDI_WORKAROUNDS
+#define DADDI_WAR 1
+#else
+#define DADDI_WAR 0
+#endif
+
+/*
  * Another R4600 erratum.  Due to the lack of errata information the exact
  * technical details aren't known.  I've experimentally found that disabling
  * interrupts during indexed I-cache flushes seems to be sufficient to deal
