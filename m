Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 17:58:18 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:59292 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIDP6R>; Wed, 4 Sep 2002 17:58:17 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA15948;
	Wed, 4 Sep 2002 17:57:16 +0200 (MET DST)
Date: Wed, 4 Sep 2002 17:57:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>,
	Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
Subject: [patch] 2.4.19: Support R4000 as a distinct CPU type
Message-ID: <Pine.GSO.3.96.1020904172031.10619I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 79
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 Being an early implementation of a CPU family, R4000 contains a number of
interesting "features".  One of them is a problem that affects a few
variations of shift operations (both 32-bit and 64-bit ones) that are
executed after multiply or divide instructions.  Under certain
circumstances the shifts produce incorrect results.  This is documented as
erratum #28 in "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0" 
which is available at the MIPS site (I can't quote it here, sorry, as it's
copyrighted material and I failed to get permission from MIPS). 

 There is a partial workaround for the problem implemented in gcc which
gets activated if the "-mcpu=r4000" option is passed to the compiler. 
Recent problems with the kernel when run on an affected CPU led me to
complete the multiplication part of the workaround (I'm also working on
the division part that is less biting).  A suitable patch for 2.95.x is
available in mipsel-linux and mips64el-linux cross-gcc packages at my
site.

 But to let gcc activate the workaround, kernel Makefiles must pass the
mentioned option.  Here is a suitable patch.  OK to apply?

 I would like to express my gratitude to Karsten, who patiently tested on
his R4000 system a seemingly endless stream of kernels I fed him until I
discovered the reason of a mysterious misbehaviour.  Without his help I
wouldn't be able to resolve the problem.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020807-r4000-0
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020807.macro/Documentation/Configure.help linux-mips-2.4.19-rc1-20020807/Documentation/Configure.help
--- linux-mips-2.4.19-rc1-20020807.macro/Documentation/Configure.help	2002-06-27 02:56:15.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020807/Documentation/Configure.help	2002-09-02 18:32:45.000000000 +0000
@@ -2196,9 +2196,9 @@ CONFIG_PCMCIA_FDOMAIN
 
 # Choice: mipstype
 CPU type
-CONFIG_CPU_R3000
+CONFIG_CPU_MIPS32
   Please make sure to pick the right CPU type. Linux/MIPS is not
-  designed to be generic, i.e. Kernels compiled for R3000 CPUs will
+  designed to be generic, i.e. kernels compiled for R3000 CPUs will
   *not* work on R4000 machines and vice versa.  However, since most
   of the supported machines have an R4000 (or similar) CPU, R4x00
   might be a safe bet.  If the resulting kernel does not work,
@@ -2210,10 +2210,12 @@ CONFIG_CPU_R3000
   R6000    MIPS Technologies R6000-series processors,
            including the 64474, 64475, 64574 and 64575.
 
+  R4000    MIPS Technologies R4000-series processors.
+
   R4300    MIPS Technologies R4300-series processors.
 
-  R4x00    MIPS Technologies R4000-series processors other than 4300,
-           including the 4640, 4650, and 4700.
+  R4x00    MIPS Technologies R4xxx-series processors other than 4000
+           and 4300, including the 4640, 4650, and 4700.
 
   R5000    MIPS Technologies R5000-series processors other than the
            Nevada.
@@ -2227,14 +2229,18 @@ CONFIG_CPU_R6000
   MIPS Technologies R6000-series processors, including the 64474,
   64475, 64574 and 64575.
 
+R4000
+CONFIG_CPU_R4000
+  MIPS Technologies R4000-series processors.
+
 R4300
 CONFIG_CPU_R4300
   MIPS Technologies R4300-series processors.
 
 R4x00
 CONFIG_CPU_R4X00
-  MIPS Technologies R4000-series processors other than 4300, including
-  the 4640, 4650, and 4700.
+  MIPS Technologies R4xxx-series processors other than 4000 and 4300,
+  including the 4640, 4650, and 4700.
 
 R5000
 CONFIG_CPU_R5000
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020807.macro/arch/mips/Makefile linux-mips-2.4.19-rc1-20020807/arch/mips/Makefile
--- linux-mips-2.4.19-rc1-20020807.macro/arch/mips/Makefile	2002-08-07 02:58:14.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020807/arch/mips/Makefile	2002-09-02 18:34:52.000000000 +0000
@@ -57,6 +57,9 @@ endif
 ifdef CONFIG_CPU_R6000
 GCCFLAGS	+= -mcpu=r6000 -mips2 -Wa,--trap
 endif
+ifdef CONFIG_CPU_R4000
+GCCFLAGS	+= -mcpu=r4000 -mips2 -Wa,--trap
+endif
 ifdef CONFIG_CPU_R4300
 GCCFLAGS	+= -mcpu=r4300 -mips2 -Wa,--trap
 endif
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020807.macro/arch/mips/config-shared.in linux-mips-2.4.19-rc1-20020807/arch/mips/config-shared.in
--- linux-mips-2.4.19-rc1-20020807.macro/arch/mips/config-shared.in	2002-08-07 02:58:14.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020807/arch/mips/config-shared.in	2002-09-02 18:59:33.000000000 +0000
@@ -413,6 +413,7 @@ choice 'CPU type' \
 	 MIPS64	CONFIG_CPU_MIPS64 \
 	 R3000	CONFIG_CPU_R3000 \
 	 R39XX	CONFIG_CPU_TX39XX \
+	 R4000	CONFIG_CPU_R4000 \
 	 R41xx	CONFIG_CPU_VR41XX \
 	 R4300	CONFIG_CPU_R4300 \
 	 R4x00	CONFIG_CPU_R4X00 \
@@ -447,7 +448,8 @@ if [ "$CONFIG_CPU_SB1" = "y" ]; then
    define_bool CONFIG_CPU_HAS_PREFETCH y
 fi
 
-if [ "$CONFIG_CPU_R4X00"  = "y" -o \
+if [ "$CONFIG_CPU_R4000"  = "y" -o \
+     "$CONFIG_CPU_R4X00"  = "y" -o \
      "$CONFIG_CPU_R5000"  = "y" -o \
      "$CONFIG_CPU_RM7000" = "y" -o \
      "$CONFIG_CPU_R10000" = "y" -o \
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020807.macro/arch/mips/dec/prom/init.c linux-mips-2.4.19-rc1-20020807/arch/mips/dec/prom/init.c
--- linux-mips-2.4.19-rc1-20020807.macro/arch/mips/dec/prom/init.c	2002-08-06 02:57:08.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020807/arch/mips/dec/prom/init.c	2002-09-02 18:38:37.000000000 +0000
@@ -100,7 +100,7 @@ int __init prom_init(int argc, char **ar
 	}
 #endif
 
-#if defined(CONFIG_CPU_R4X00)
+#if defined(CONFIG_CPU_R4000) || defined(CONFIG_CPU_R4X00)
 	if ((mips_cpu.cputype == CPU_R3000) ||
 	    (mips_cpu.cputype == CPU_R3000A)) {
 		prom_printf("Sorry, this kernel is compiled for the wrong CPU type!\n");
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020807.macro/arch/mips/mm/Makefile linux-mips-2.4.19-rc1-20020807/arch/mips/mm/Makefile
--- linux-mips-2.4.19-rc1-20020807.macro/arch/mips/mm/Makefile	2002-06-26 03:04:37.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020807/arch/mips/mm/Makefile	2002-09-02 18:41:00.000000000 +0000
@@ -17,6 +17,7 @@ obj-$(CONFIG_CPU_R3000)		+= pg-r3k.o c-r
 				   tlbex-r3k.o
 obj-$(CONFIG_CPU_TX39XX)	+= pg-r3k.o c-tx39.o tlb-r3k.o tlbex-r3k.o
 obj-$(CONFIG_CPU_TX49XX)	+= pg-r4k.o c-tx49.o tlb-r4k.o tlbex-r4k.o
+obj-$(CONFIG_CPU_R4000)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R4300)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R4X00)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020807.macro/arch/mips/mm/loadmmu.c linux-mips-2.4.19-rc1-20020807/arch/mips/mm/loadmmu.c
--- linux-mips-2.4.19-rc1-20020807.macro/arch/mips/mm/loadmmu.c	2002-08-06 02:57:32.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020807/arch/mips/mm/loadmmu.c	2002-09-02 18:42:30.000000000 +0000
@@ -68,9 +68,9 @@ extern void sb1_tlb_init(void);
 void __init loadmmu(void)
 {
 	if (mips_cpu.options & MIPS_CPU_4KTLB) {
-#if defined(CONFIG_CPU_R4X00) || defined(CONFIG_CPU_VR41XX) || \
-    defined(CONFIG_CPU_R4300) || defined(CONFIG_CPU_R5000) || \
-    defined(CONFIG_CPU_NEVADA)
+#if defined(CONFIG_CPU_R4000) || defined(CONFIG_CPU_VR41XX) || \
+    defined(CONFIG_CPU_R4300) || defined(CONFIG_CPU_R4X00) || \
+    defined(CONFIG_CPU_R5000) || defined(CONFIG_CPU_NEVADA)
 		ld_mmu_r4xx0();
 		r4k_tlb_init();
 #endif
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020807.macro/arch/mips64/Makefile linux-mips-2.4.19-rc1-20020807/arch/mips64/Makefile
--- linux-mips-2.4.19-rc1-20020807.macro/arch/mips64/Makefile	2002-08-07 02:58:22.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020807/arch/mips64/Makefile	2002-09-02 18:45:02.000000000 +0000
@@ -46,6 +46,9 @@ endif
 #
 # CPU-dependent compiler/assembler options for optimization.
 #
+ifdef CONFIG_CPU_R4000
+GCCFLAGS	+= -mcpu=r4000 -mips3
+endif
 ifdef CONFIG_CPU_R4300
 GCCFLAGS	+= -mcpu=r4300 -mips3
 endif
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020807.macro/arch/mips64/mm/Makefile linux-mips-2.4.19-rc1-20020807/arch/mips64/mm/Makefile
--- linux-mips-2.4.19-rc1-20020807.macro/arch/mips64/mm/Makefile	2002-07-25 02:57:02.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020807/arch/mips64/mm/Makefile	2002-09-02 18:45:30.000000000 +0000
@@ -9,6 +9,7 @@ O_TARGET := mm.o
 export-objs			+= umap.o
 obj-y				:= extable.o init.o fault.o loadmmu.o
 
+obj-$(CONFIG_CPU_R4000)		+= r4xx0.o tlbex-r4k.o tlb-glue-r4k.o
 obj-$(CONFIG_CPU_R4300)		+= r4xx0.o tlbex-r4k.o tlb-glue-r4k.o
 obj-$(CONFIG_CPU_R4X00)		+= r4xx0.o tlbex-r4k.o tlb-glue-r4k.o
 obj-$(CONFIG_CPU_R5000)		+= r4xx0.o tlbex-r4k.o tlb-glue-r4k.o
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020807.macro/arch/mips64/mm/loadmmu.c linux-mips-2.4.19-rc1-20020807/arch/mips64/mm/loadmmu.c
--- linux-mips-2.4.19-rc1-20020807.macro/arch/mips64/mm/loadmmu.c	2002-08-06 02:57:39.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020807/arch/mips64/mm/loadmmu.c	2002-09-02 18:46:37.000000000 +0000
@@ -60,7 +60,8 @@ extern void r4k_tlb_init(void);
 void __init load_mmu(void)
 {
 	if (mips_cpu.options & MIPS_CPU_4KTLB) {
-#if defined (CONFIG_CPU_R4300)						\
+#if defined (CONFIG_CPU_R4000)						\
+    || defined (CONFIG_CPU_R4300)					\
     || defined (CONFIG_CPU_R4X00)					\
     || defined (CONFIG_CPU_R5000)					\
     || defined (CONFIG_CPU_NEVADA)
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020807.macro/include/asm-mips64/addrspace.h linux-mips-2.4.19-rc1-20020807/include/asm-mips64/addrspace.h
--- linux-mips-2.4.19-rc1-20020807.macro/include/asm-mips64/addrspace.h	2002-08-22 06:18:02.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020807/include/asm-mips64/addrspace.h	2002-09-02 19:00:37.000000000 +0000
@@ -82,7 +82,8 @@
 #define CKSSEG			0xffffffffc0000000
 #define CKSEG3			0xffffffffe0000000
 
-#if defined (CONFIG_CPU_R4300)						\
+#if defined (CONFIG_CPU_R4000)						\
+    || defined (CONFIG_CPU_R4300)					\
     || defined (CONFIG_CPU_R4X00)					\
     || defined (CONFIG_CPU_R5000)					\
     || defined (CONFIG_CPU_NEVADA)					\
