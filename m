Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Dec 2003 21:33:44 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:41928 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225474AbTLPVdn>; Tue, 16 Dec 2003 21:33:43 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 638DF47A4D; Tue, 16 Dec 2003 22:33:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 4F62447813; Tue, 16 Dec 2003 22:33:41 +0100 (CET)
Date: Tue, 16 Dec 2003 22:33:41 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [patch] 2.4: Support for newer gcc/gas options
Message-ID: <Pine.LNX.4.55.0312161822240.8262@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 Since command line options for both gcc and gas has been changed in an 
incompatible way recently and also there are stricter requirements on 
certain options when used simultaneously, I propose the following patch to 
our top-level Makefiles to let the optimal set of options be selected at 
the build time.  The intent is to try modern options first, then obsolete 
ones and to set gas options independently to gcc ones as one may be more 
inclined to upgrade binutils that his old trusty gcc.

 The patch implements a make macro called set_gccflags which accepts two
sets of options consisting of a CPU name and an ISA name each.  Within 
both sets "-march=" and failing that "-mcpu=" is checked with the CPU name 
and the ISA name is checked simultaneously.  For gcc if the first set of 
options fails, the second one is selected even if it would lead to a 
failure.  For gas both sets are checked and if none succeeds, an empty set 
is selected.

 The 32-bit variation accepts a fifth option as well to permit ABI
selection with an ISA when the "-mabi=" option is unavailable, which is 
also tested.

 Beside letting one use modern tools at all the patch also enables CPU
selection using newly added (and closer matching) settings like
"-march=mips64" without forcing users to upgrade tools provided a
conservative fallback is provided.

 Comments, thoughts, opinions, etc. will be appreciated.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.23-20031209-march-11
diff -up --recursive --new-file linux-mips-2.4.23-20031209.macro/arch/mips/Makefile linux-mips-2.4.23-20031209/arch/mips/Makefile
--- linux-mips-2.4.23-20031209.macro/arch/mips/Makefile	2003-10-23 02:56:44.000000000 +0000
+++ linux-mips-2.4.23-20031209/arch/mips/Makefile	2003-12-16 11:20:33.000000000 +0000
@@ -5,7 +5,7 @@
 #
 # Copyright (C) 1994, 1995, 1996 by Ralf Baechle
 # DECStation modifications by Paul M. Antoine, 1996
-# Copyright (C) 2002  Maciej W. Rozycki
+# Copyright (C) 2002, 2003  Maciej W. Rozycki
 #
 # This file is included by the global makefile so that you can add your own
 # architecture-specific flags and dependencies. Remember to do have actions
@@ -43,7 +43,6 @@ check_gcc = $(shell if $(CC) $(1) -S -o 
 #
 GCCFLAGS	:= -I $(TOPDIR)/include/asm/gcc
 GCCFLAGS	+= -G 0 -mno-abicalls -fno-pic -pipe
-GCCFLAGS	+= $(call check_gcc, -mabi=32,)
 GCCFLAGS	+= $(call check_gcc, -finline-limit=100000,)
 LINKFLAGS	+= -G 0 -static # -N
 MODFLAGS	+= -mlong-calls
@@ -55,56 +54,100 @@ GCCFLAGS	+= -mno-sched-prolog -fno-omit-
 endif
 endif
 
+set_gccflags = $(shell \
+while :; do \
+	cpu=$(1); isa=-$(2); \
+	for gcc_opt in -march= -mcpu=; do \
+		$(CC) $$gcc_opt$$cpu $$isa -S -o /dev/null \
+			-xc - < /dev/null > /dev/null 2>&1 && \
+			break 2; \
+	done; \
+	cpu=$(3); isa=-$(4); \
+	for gcc_opt in -march= -mcpu=; do \
+		$(CC) $$gcc_opt$$cpu $$isa -S -o /dev/null \
+			-xc - < /dev/null > /dev/null 2>&1 && \
+			break 2; \
+	done; \
+	break; \
+done; \
+gcc_abi=-mabi=32; gcc_cpu=$$cpu; \
+if $(CC) $$gcc_abi -S -o /dev/null -xc - < /dev/null > /dev/null 2>&1; then \
+	gcc_isa=$$isa; \
+else \
+	gcc_abi=; gcc_isa=-$(5); \
+fi; \
+gas_abi=-Wa,-32; gas_cpu=$$cpu; gas_isa=-Wa,$$isa; \
+while :; do \
+	for gas_opt in -Wa,-march= -Wa,-mcpu=; do \
+		$(CC) $$gas_abi $$gas_opt$$cpu $$gas_isa -c -o /dev/null \
+			-xassembler - < /dev/null > /dev/null 2>&1 && \
+			break 2; \
+	done; \
+	gas_abi=; gas_opt=; gas_cpu=; gas_isa=; \
+	break; \
+done; \
+echo $$gcc_abi $$gcc_opt$$gcc_cpu $$gcc_isa $$gas_abi $$gas_opt$$gas_cpu $$gas_isa)
+
 # CPU-dependent compiler/assembler options for optimization.
 #
 ifdef CONFIG_CPU_R3000
-GCCFLAGS	+= -mcpu=r3000 -mips1
+GCCFLAGS	+= $(call set_gccflags,r3000,mips1,r3000,mips1,mips1)
 endif
 ifdef CONFIG_CPU_TX39XX
-GCCFLAGS	+= -mcpu=r3000 -mips1
+GCCFLAGS	+= $(call set_gccflags,r3000,mips1,r3000,mips1,mips1)
 endif
 ifdef CONFIG_CPU_R6000
-GCCFLAGS	+= -mcpu=r6000 -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,r6000,mips2,r6000,mips2,mips2) \
+		   -Wa,--trap
 endif
 ifdef CONFIG_CPU_R4300
-GCCFLAGS	+= -mcpu=r4300 -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,r4300,mips3,r4300,mips3,mips2) \
+		   -Wa,--trap
 endif
 ifdef CONFIG_CPU_VR41XX
-GCCFLAGS	+= -mcpu=r4600 -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,r4100,mips3,r4600,mips3,mips2) \
+		   -Wa,--trap
 endif
 ifdef CONFIG_CPU_R4X00
-GCCFLAGS	+= -mcpu=r4600 -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,r4600,mips3,r4600,mips3,mips2) \
+		   -Wa,--trap
 endif
 ifdef CONFIG_CPU_TX49XX
-GCCFLAGS	+= -mcpu=r4600 -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,r4600,mips3,r4600,mips3,mips2) \
+		   -Wa,--trap
 endif
 ifdef CONFIG_CPU_MIPS32
-GCCFLAGS	+= -mcpu=r4600 -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,mips32,mips32,r4600,mips3,mips2) \
+		   -Wa,--trap
 endif
 ifdef CONFIG_CPU_MIPS64
-GCCFLAGS	+= -mcpu=r4600 -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,mips64,mips64,r4600,mips3,mips2) \
+		   -Wa,--trap
 endif
 ifdef CONFIG_CPU_R5000
-GCCFLAGS	+= -mcpu=r5000 -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,r5000,mips4,r5000,mips4,mips2) \
+		   -Wa,--trap
 endif
 ifdef CONFIG_CPU_R5432
-GCCFLAGS	+= -mcpu=r5000 -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,r5400,mips4,r5000,mips4,mips2) \
+		   -Wa,--trap
 endif
 ifdef CONFIG_CPU_NEVADA
-# Cannot use -mmad with currently recommended tools
-GCCFLAGS	+= -mcpu=r5000 -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,rm5200,mips4,r5000,mips4,mips2) \
+		   -Wa,--trap
+GCCFLAGS	+= $(call check_gcc,-mmad,)
 endif
 ifdef CONFIG_CPU_RM7000
-GCCFLAGS	+= $(call check_gcc, -march=rm7000, -mcpu=r5000) \
-		   -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,rm7000,mips4,r5000,mips4,mips2) \
+		   -Wa,--trap
 endif
 ifdef CONFIG_CPU_RM9000
-GCCFLAGS	+= $(call check_gcc, -march=rm9000, -mcpu=r5000) \
-		   -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,rm9000,mips4,r5000,mips4,mips2) \
+		   -Wa,--trap
 endif
 ifdef CONFIG_CPU_SB1
-GCCFLAGS	+= $(call check_gcc, -mcpu=sb1, -mcpu=r5000) \
-		   -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,sb1,mips64,r5000,mips4,mips2) \
+		   -Wa,--trap
 ifdef CONFIG_SB1_PASS_1_WORKAROUNDS
 MODFLAGS	+= -msb1-pass1-workarounds
 endif
diff -up --recursive --new-file linux-mips-2.4.23-20031209.macro/arch/mips64/Makefile linux-mips-2.4.23-20031209/arch/mips64/Makefile
--- linux-mips-2.4.23-20031209.macro/arch/mips64/Makefile	2003-12-01 03:57:04.000000000 +0000
+++ linux-mips-2.4.23-20031209/arch/mips64/Makefile	2003-12-16 11:22:40.000000000 +0000
@@ -3,7 +3,7 @@
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
 #
-# Copyright (C) 2002  Maciej W. Rozycki
+# Copyright (C) 2002, 2003  Maciej W. Rozycki
 #
 # This file is included by the global makefile so that you can add your own
 # architecture-specific flags and dependencies. Remember to do have actions
@@ -11,6 +11,8 @@
 # this architecture
 #
 
+comma := ,
+
 #
 # Select the object file format to substitute into the linker script.
 #
@@ -48,48 +50,73 @@ endif
 endif
 
 check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+check_gas = $(shell if $(CC) $(1) -c -o /dev/null -xassembler - < /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
+set_gccflags = $(shell \
+while :; do \
+	cpu=$(1); isa=-$(2); \
+	for gcc_opt in -march= -mcpu=; do \
+		$(CC) $$gcc_opt$$cpu $$isa -S -o /dev/null \
+			-xc - < /dev/null > /dev/null 2>&1 && \
+			break 2; \
+	done; \
+	cpu=$(3); isa=-$(4); \
+	for gcc_opt in -march= -mcpu=; do \
+		$(CC) $$gcc_opt$$cpu $$isa -S -o /dev/null \
+			-xc - < /dev/null > /dev/null 2>&1 && \
+			break 2; \
+	done; \
+	break; \
+done; \
+gcc_cpu=$$cpu; gcc_isa=$$isa; \
+gas_cpu=$$cpu; gas_isa=-Wa,$$isa; \
+while :; do \
+	for gas_opt in -Wa,-march= -Wa,-mcpu=; do \
+		$(CC) $$gas_opt$$cpu $$gas_isa -c -o /dev/null \
+			-xassembler - < /dev/null > /dev/null 2>&1 && \
+			break 2; \
+	done; \
+	gas_opt=; gas_cpu=; gas_isa=; \
+	break; \
+done; \
+echo $$gcc_opt$$gcc_cpu $$gcc_isa $$gas_opt$$gas_cpu $$gas_isa)
 
 #
 # CPU-dependent compiler/assembler options for optimization.
 #
 ifdef CONFIG_CPU_R4300
-GCCFLAGS	+= -mcpu=r4300 -mips3
+GCCFLAGS	+= $(call set_gccflags,r4300,mips3,r4300,mips3)
 endif
 ifdef CONFIG_CPU_R4X00
-GCCFLAGS	+= -mcpu=r4600 -mips3
+GCCFLAGS	+= $(call set_gccflags,r4600,mips3,r4600,mips3)
 endif
 ifdef CONFIG_CPU_R5000
-GCCFLAGS	+= -mcpu=r8000 -mips4
+GCCFLAGS	+= $(call set_gccflags,r5000,mips4,r8000,mips4)
 endif
 ifdef CONFIG_CPU_NEVADA
-# Cannot use -mmad with currently recommended tools
-GCCFLAGS	+= -mcpu=r8000 -mips3
+GCCFLAGS	+= $(call set_gccflags,rm5200,mips4,r8000,mips4)
+GCCFLAGS	+= $(call check_gcc,-mmad,)
 endif
 ifdef CONFIG_CPU_RM7000
-GCCFLAGS	+= $(call check_gcc, -march=rm7000, -mcpu=r5000) \
-		   -mips2 -Wa,--trap
+GCCFLAGS	+= $(call set_gccflags,rm7000,mips4,r5000,mips4)
+endif
+ifdef CONFIG_CPU_RM9000
+GCCFLAGS	+= $(call set_gccflags,rm9000,mips4,r5000,mips4)
 endif
 ifdef CONFIG_CPU_R8000
-GCCFLAGS	+= -mcpu=r8000 -mips4
+GCCFLAGS	+= $(call set_gccflags,r8000,mips4,r8000,mips4)
 endif
 ifdef CONFIG_CPU_R10000
-GCCFLAGS	+= -mcpu=r8000 -mips4
+GCCFLAGS	+= $(call set_gccflags,r10000,mips4,r8000,mips4)
 endif
 ifdef CONFIG_CPU_SB1
-GCCFLAGS	+= $(call check_gcc, -mcpu=sb1, -mcpu=r5000) -mips4
+GCCFLAGS	+= $(call set_gccflags,sb1,mips64,r5000,mips4)
 ifdef CONFIG_SB1_PASS_1_WORKAROUNDS
 MODFLAGS	+= -msb1-pass1-workarounds
 endif
 endif
 ifdef CONFIG_CPU_MIPS64
-#CFLAGS		+= -mips64	# Should be used then we get a MIPS64 compiler
-CFLAGS		+= -mcpu=r8000 -mips4
-endif
-ifdef CONFIG_CPU_RM7000
-GCCFLAGS	+= -mcpu=r8000 -mips4
-endif
-ifdef CONFIG_CPU_RM9000
-GCCFLAGS	+= -mcpu=r8000 -mips4
+GCCFLAGS	+= $(call set_gccflags,mips64,mips64,r8000,mips4)
 endif
 
 #
@@ -299,7 +326,7 @@ endif
 # convert to ECOFF using elf2ecoff.
 #
 ifdef CONFIG_BOOT_ELF32
-GCCFLAGS += -Wa,-32 $(shell if $(CC) -Wa,-mgp64 -c -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "-Wa,-mgp64"; fi)
+GCCFLAGS += -Wa,-32 $(call check_gas,-Wa$(comma)-mgp64,)
 LINKFLAGS += -T arch/mips64/ld.script.elf32
 endif
 #
@@ -307,7 +334,7 @@ endif
 # ELF files from 32-bit files by conversion.
 #
 ifdef CONFIG_BOOT_ELF64
-GCCFLAGS += -Wa,-32 $(shell if $(CC) -Wa,-mgp64 -c -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "-Wa,-mgp64"; fi)
+GCCFLAGS += -Wa,-32 $(call check_gas,-Wa$(comma)-mgp64,)
 LINKFLAGS += -T arch/mips64/ld.script.elf32
 #AS += -64
 #LD += -m elf64bmip
