Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Feb 2004 11:11:43 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:7098 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224936AbUBPLLl>; Mon, 16 Feb 2004 11:11:41 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id A9FC3478D5; Mon, 16 Feb 2004 12:11:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 9B4EA43046; Mon, 16 Feb 2004 12:11:39 +0100 (CET)
Date: Mon, 16 Feb 2004 12:11:39 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] Ensure proper section alignment [gcc 3.4]
Message-ID: <Pine.LNX.4.55.0402161203280.19569@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 The exception-related sections appear to work with gcc 2.95 by accident 
-- they lack appropriate alignment directives and just happen to be 
properly aligned, at least most of the time.

 With gcc 3.4, this is no longer true -- I get a quick death of the kernel
because of an unaligned trap on an instruction fetch from the ".fixup"
section.  Here's a proposed solution that works for me.  I decided to
request proper alignment explicitly in all bits that refer to one of the
".fixup", "__ex_table" and "__dbe_table" sections.  This way a proper
alignment is set both for the main kernel binary and for modules, and also
of bits get removed in the future.  It should also make no doubt whether
to add an alignment directive or not for one adding code making use of
these sections.

 I've chosen ".p2align" as it has a well-defined platform-independent 
semantics.

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.24-pre2-20040116-fixup-3
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/gdb-low.S linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/gdb-low.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/gdb-low.S	2003-02-21 03:56:24.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/gdb-low.S	2004-02-15 04:28:37.000000000 +0000
@@ -336,6 +336,7 @@ LEAF(kgdb_read_byte)
 		li	v0, 0
 		jr	ra
 		.section __ex_table,"a"
+		.p2align PTRLOG
 		PTR	4b, kgdbfault
 		.previous
 		END(kgdb_read_byte)
@@ -345,6 +346,7 @@ LEAF(kgdb_write_byte)
 		li	v0, 0
 		jr	ra
 		.section __ex_table,"a"
+		.p2align PTRLOG
 		PTR	5b, kgdbfault
 		.previous
 		END(kgdb_write_byte)
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/r2300_fpu.S linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/r2300_fpu.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/r2300_fpu.S	2001-04-12 04:25:48.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/r2300_fpu.S	2004-02-15 13:53:28.000000000 +0000
@@ -21,6 +21,7 @@
 #define EX(a,b)							\
 9:	a,##b;							\
 	.section __ex_table,"a";				\
+	.p2align PTRLOG;					\
 	PTR	9b,bad_stack;					\
 	.previous
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/r4k_fpu.S linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/r4k_fpu.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/r4k_fpu.S	2001-04-12 04:25:48.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/r4k_fpu.S	2004-02-15 13:53:48.000000000 +0000
@@ -21,6 +21,7 @@
 #define EX(a,b)							\
 9:	a,b;							\
 	.section __ex_table,"a";				\
+	.p2align PTRLOG;					\
 	PTR	9b, fault;					\
 	.previous
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/scall_o32.S linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/scall_o32.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/scall_o32.S	2003-10-29 03:56:51.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/scall_o32.S	2004-02-15 04:14:30.000000000 +0000
@@ -189,6 +189,7 @@ stackargs:
 	j	stack_done		# go back
 
 	.section __ex_table,"a"
+	.p2align PTRLOG
 	PTR	1b,bad_stack
 	PTR	2b,bad_stack
 	.previous
@@ -249,6 +250,7 @@ LEAF(mips_atomic_set)
 	beqz	a0, 1b
 
 	.section __ex_table,"a"
+	.p2align PTRLOG
 	PTR	1b, bad_stack
 	PTR	2b, bad_stack
 	.previous
@@ -272,6 +274,7 @@ LEAF(mips_atomic_set)
 2:	sw	a2, (a1)
 
 	.section __ex_table,"a"
+	.p2align PTRLOG
 	PTR	1b, no_mem
 	PTR	2b, no_mem
 	.previous
@@ -340,7 +343,8 @@ LEAF(sys_syscall)
 2:	lw	t3, 20(t0)
 3:	lw	t4, 24(t0)
 
-	.section	__ex_table, "a"
+	.section __ex_table, "a"
+	.p2align PTRLOG
 	.word	1b, efault
 	.word	2b, efault
 	.word	3b, efault
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/traps.c linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/traps.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/traps.c	2004-01-10 03:56:33.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/traps.c	2004-02-15 04:01:00.000000000 +0000
@@ -9,7 +9,7 @@
  * Copyright (C) 1999 Silicon Graphics, Inc.
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
- * Copyright (C) 2002, 2003  Maciej W. Rozycki
+ * Copyright (C) 2002, 2003, 2004  Maciej W. Rozycki
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -20,6 +20,7 @@
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 
+#include <asm/asm.h>
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
 #include <asm/cpu.h>
@@ -282,6 +283,7 @@ void __declare_dbe_table(void)
 {
 	__asm__ __volatile__(
 	".section\t__dbe_table,\"a\"\n\t"
+	".p2align\t" STR(PTRLOG) "\n\t"
 	".previous"
 	);
 }
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/unaligned.c linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/unaligned.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/unaligned.c	2004-01-03 03:56:37.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/unaligned.c	2004-02-15 04:16:00.000000000 +0000
@@ -85,9 +85,6 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-#define STR(x)  __STR(x)
-#define __STR(x)  #x
-
 #ifdef CONFIG_PROC_FS
 unsigned long unaligned_instructions;
 #endif
@@ -159,10 +156,12 @@ static inline int emulate_load_store_ins
 			"li\t%1, 0\n"
 			"3:\t.set\tat\n\t"
 			".section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%1, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -189,10 +188,12 @@ static inline int emulate_load_store_ins
 #endif
 			"li\t%1, 0\n"
 			"3:\t.section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%1, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -223,10 +224,12 @@ static inline int emulate_load_store_ins
 			"li\t%1, 0\n"
 			"3:\t.set\tat\n\t"
 			".section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%1, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -263,10 +266,12 @@ static inline int emulate_load_store_ins
 			"dsrl\t%0, %0, 32\n\t"
 			"li\t%1, 0\n"
 			"3:\t.section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%1, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -305,10 +310,12 @@ static inline int emulate_load_store_ins
 #endif
 			"li\t%1, 0\n"
 			"3:\t.section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%1, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -347,10 +354,12 @@ static inline int emulate_load_store_ins
 			"li\t%0, 0\n"
 			"3:\n\t"
 			".section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%0, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -377,10 +386,12 @@ static inline int emulate_load_store_ins
 			"li\t%0, 0\n"
 			"3:\n\t"
 			".section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%0, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -415,10 +426,12 @@ static inline int emulate_load_store_ins
 			"li\t%0, 0\n"
 			"3:\n\t"
 			".section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%0, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/memcpy.S linux-mips-2.4.24-pre2-20040116/arch/mips/lib/memcpy.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/memcpy.S	2003-06-28 02:56:51.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/lib/memcpy.S	2004-02-15 13:54:06.000000000 +0000
@@ -73,6 +73,7 @@
 #define EXC(inst_reg,addr,handler)		\
 9:	inst_reg, addr;				\
 	.section __ex_table,"a";		\
+	.p2align PTRLOG;			\
 	PTR	9b, handler;			\
 	.previous
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/memset.S linux-mips-2.4.24-pre2-20040116/arch/mips/lib/memset.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/memset.S	2002-08-06 02:57:18.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/lib/memset.S	2004-02-15 13:54:10.000000000 +0000
@@ -12,6 +12,7 @@
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a"; 			\
+	.p2align PTRLOG;				\
 	PTR	9b, handler; 				\
 	.previous
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/strlen_user.S linux-mips-2.4.24-pre2-20040116/arch/mips/lib/strlen_user.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/strlen_user.S	2002-07-02 02:57:21.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/lib/strlen_user.S	2004-02-15 13:54:15.000000000 +0000
@@ -14,6 +14,7 @@
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a";			\
+	.p2align PTRLOG;				\
 	PTR	9b, handler;				\
 	.previous
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/strncpy_user.S linux-mips-2.4.24-pre2-20040116/arch/mips/lib/strncpy_user.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/strncpy_user.S	2001-09-07 04:26:28.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/lib/strncpy_user.S	2004-02-15 13:54:19.000000000 +0000
@@ -13,6 +13,7 @@
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a";			\
+	.p2align PTRLOG;				\
 	PTR	9b, handler;				\
 	.previous
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/strnlen_user.S linux-mips-2.4.24-pre2-20040116/arch/mips/lib/strnlen_user.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/strnlen_user.S	2002-07-02 02:57:21.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/lib/strnlen_user.S	2004-02-15 13:54:22.000000000 +0000
@@ -14,6 +14,7 @@
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a";			\
+	.p2align PTRLOG;				\
 	PTR	9b, handler;				\
 	.previous
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/gdb-low.S linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/gdb-low.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/gdb-low.S	2003-07-15 15:17:59.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/gdb-low.S	2004-02-15 04:21:15.000000000 +0000
@@ -336,6 +336,7 @@ LEAF(kgdb_read_byte)
 		li	v0, 0
 		jr	ra
 		.section __ex_table,"a"
+		.p2align PTRLOG
 		PTR	4b, kgdbfault
 		.previous
 		END(kgdb_read_byte)
@@ -345,6 +346,7 @@ LEAF(kgdb_write_byte)
 		li	v0, 0
 		jr	ra
 		.section __ex_table,"a"
+		.p2align PTRLOG
 		PTR	5b, kgdbfault
 		.previous
 		END(kgdb_write_byte)
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/r4k_fpu.S linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/r4k_fpu.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/r4k_fpu.S	2003-07-16 02:56:44.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/r4k_fpu.S	2004-02-15 04:21:53.000000000 +0000
@@ -25,6 +25,7 @@
 .ex\@:	\insn	\reg, \src
 	.set	pop
 	.section __ex_table,"a"
+	.p2align PTRLOG
 	PTR	.ex\@, fault
 	.previous
 	.endm
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/scall_o32.S linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/scall_o32.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/scall_o32.S	2003-10-16 02:57:04.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/scall_o32.S	2004-02-15 04:22:31.000000000 +0000
@@ -176,6 +176,7 @@ stackargs:
 	j	stack_done		# go back
 
 	.section __ex_table,"a"
+	.p2align PTRLOG
 	PTR	1b, bad_stack
 	PTR	2b, bad_stack
 	.previous
@@ -226,6 +227,7 @@ LEAF(mips_atomic_set)
 	beqz	a0, 1b
 
 	.section __ex_table,"a"
+	.p2align PTRLOG
 	PTR	1b, bad_stack
 	PTR	2b, bad_stack
 	.previous
@@ -292,6 +294,7 @@ LEAF(sys32_syscall)
 3:	lw	t1, 24(t0)
 
 	.section __ex_table,"a"
+	.p2align PTRLOG
 	PTR	1b, efault
 	PTR	2b, efault
 	PTR	3b, efault
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/traps.c linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/traps.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/traps.c	2003-12-16 03:57:14.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/traps.c	2004-02-15 04:01:06.000000000 +0000
@@ -9,7 +9,7 @@
  * Copyright (C) 1999 Silicon Graphics, Inc.
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
- * Copyright (C) 2002, 2003  Maciej W. Rozycki
+ * Copyright (C) 2002, 2003, 2004  Maciej W. Rozycki
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -20,6 +20,7 @@
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 
+#include <asm/asm.h>
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
 #include <asm/cpu.h>
@@ -292,6 +293,7 @@ void __declare_dbe_table(void)
 {
 	__asm__ __volatile__(
 	".section\t__dbe_table,\"a\"\n\t"
+	".p2align\t" STR(PTRLOG) "\n\t"
 	".previous"
 	);
 }
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/unaligned.c linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/unaligned.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/unaligned.c	2004-01-03 03:56:46.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/unaligned.c	2004-02-15 04:16:20.000000000 +0000
@@ -85,9 +85,6 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-#define STR(x)  __STR(x)
-#define __STR(x)  #x
-
 #ifdef CONFIG_PROC_FS
 unsigned long unaligned_instructions;
 #endif
@@ -159,10 +156,12 @@ static inline int emulate_load_store_ins
 			"li\t%1, 0\n"
 			"3:\t.set\tat\n\t"
 			".section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%1, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -189,10 +188,12 @@ static inline int emulate_load_store_ins
 #endif
 			"li\t%1, 0\n"
 			"3:\t.section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%1, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -223,10 +224,12 @@ static inline int emulate_load_store_ins
 			"li\t%1, 0\n"
 			"3:\t.set\tat\n\t"
 			".section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%1, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -263,10 +266,12 @@ static inline int emulate_load_store_ins
 			"dsrl\t%0, %0, 32\n\t"
 			"li\t%1, 0\n"
 			"3:\t.section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%1, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -305,10 +310,12 @@ static inline int emulate_load_store_ins
 #endif
 			"li\t%1, 0\n"
 			"3:\t.section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%1, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -347,10 +354,12 @@ static inline int emulate_load_store_ins
 			"li\t%0, 0\n"
 			"3:\n\t"
 			".section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%0, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -377,10 +386,12 @@ static inline int emulate_load_store_ins
 			"li\t%0, 0\n"
 			"3:\n\t"
 			".section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%0, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
@@ -415,10 +426,12 @@ static inline int emulate_load_store_ins
 			"li\t%0, 0\n"
 			"3:\n\t"
 			".section\t.fixup,\"ax\"\n\t"
+			".p2align\t2\n"
 			"4:\tli\t%0, %3\n\t"
 			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
+			".p2align\t" STR(PTRLOG) "\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
 			STR(PTR)"\t2b, 4b\n\t"
 			".previous"
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/lib/memcpy.S linux-mips-2.4.24-pre2-20040116/arch/mips64/lib/memcpy.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/lib/memcpy.S	2003-06-28 02:56:53.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/lib/memcpy.S	2004-02-15 13:55:03.000000000 +0000
@@ -73,6 +73,7 @@
 #define EXC(inst_reg,addr,handler)		\
 9:	inst_reg, addr;				\
 	.section __ex_table,"a";		\
+	.p2align PTRLOG;			\
 	PTR	9b, handler;			\
 	.previous
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/lib/memset.S linux-mips-2.4.24-pre2-20040116/arch/mips64/lib/memset.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/lib/memset.S	2002-08-06 02:57:38.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/lib/memset.S	2004-02-15 13:55:09.000000000 +0000
@@ -15,6 +15,7 @@
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a"; 			\
+	.p2align PTRLOG;				\
 	PTR	9b, handler; 				\
 	.previous
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/lib/strlen_user.S linux-mips-2.4.24-pre2-20040116/arch/mips64/lib/strlen_user.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/lib/strlen_user.S	2002-12-11 03:56:45.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/lib/strlen_user.S	2004-02-15 13:55:13.000000000 +0000
@@ -14,6 +14,7 @@
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a";			\
+	.p2align PTRLOG;				\
 	PTR	9b, handler;				\
 	.previous
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/lib/strncpy_user.S linux-mips-2.4.24-pre2-20040116/arch/mips64/lib/strncpy_user.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/lib/strncpy_user.S	2002-12-11 03:56:45.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/lib/strncpy_user.S	2004-02-15 13:55:16.000000000 +0000
@@ -13,6 +13,7 @@
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a";			\
+	.p2align PTRLOG;				\
 	PTR	9b, handler;				\
 	.previous
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/lib/strnlen_user.S linux-mips-2.4.24-pre2-20040116/arch/mips64/lib/strnlen_user.S
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/lib/strnlen_user.S	2002-12-11 03:56:45.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/lib/strnlen_user.S	2004-02-15 13:55:20.000000000 +0000
@@ -14,6 +14,7 @@
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a";			\
+	.p2align PTRLOG;				\
 	PTR	9b, handler;				\
 	.previous
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/asm.h linux-mips-2.4.24-pre2-20040116/include/asm-mips/asm.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/asm.h	2003-12-31 03:57:05.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips/asm.h	2004-02-15 04:01:41.000000000 +0000
@@ -29,6 +29,11 @@
 #define CAT(str1,str2) __CAT(str1,str2)
 #endif
 
+#ifndef STR
+#define STR(x) __STR(x)
+#define __STR(x) #x
+#endif
+
 /*
  * PIC specific declarations
  * Not used for the kernel but here seems to be the right place.
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/paccess.h linux-mips-2.4.24-pre2-20040116/include/asm-mips/paccess.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/paccess.h	2002-07-06 23:48:37.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips/paccess.h	2004-02-15 05:18:36.000000000 +0000
@@ -14,6 +14,7 @@
 #define _ASM_PACCESS_H
 
 #include <linux/errno.h>
+#include <asm/asm.h>
 
 #define put_dbe(x,ptr) __put_dbe((x),(ptr),sizeof(*(ptr)))
 #define get_dbe(x,ptr) __get_dbe((x),(ptr),sizeof(*(ptr)))
@@ -45,13 +46,15 @@ __asm__ __volatile__( \
 	"1:\tmove\t%0,$0\n" \
 	".set\tpop\n\t" \
 	"2:\n\t" \
-	".section\t.fixup,\"ax\"\n" \
+	".section\t.fixup,\"ax\"\n\t" \
+	".p2align\t2\n" \
 	"3:\tli\t%0,%3\n\t" \
 	"move\t%1,$0\n\t" \
 	"j\t2b\n\t" \
 	".previous\n\t" \
 	".section\t__dbe_table,\"a\"\n\t" \
-	".word\t1b-4,3b\n\t" \
+	".p2align\t" STR(PTRLOG) "\n\t" \
+	STR(PTR) "\t1b-4,3b\n\t" \
 	".previous" \
 	:"=r" (__gu_err), "=r" (__gu_val) \
 	:"o" (__mp(__gu_addr)), "i" (-EFAULT)); })
@@ -82,12 +85,14 @@ __asm__ __volatile__( \
 	"1:\tmove\t%0,$0\n" \
 	".set\tpop\n\t" \
 	"2:\n\t" \
-	".section\t.fixup,\"ax\"\n" \
+	".section\t.fixup,\"ax\"\n\t" \
+	".p2align\t2\n" \
 	"3:\tli\t%0,%3\n\t" \
 	"j\t2b\n\t" \
 	".previous\n\t" \
 	".section\t__dbe_table,\"a\"\n\t" \
-	".word\t1b-4,3b\n\t" \
+	".p2align\t" STR(PTRLOG) "\n\t" \
+	STR(PTR) "\t1b-4,3b\n\t" \
 	".previous" \
 	:"=r" (__pu_err) \
 	:"r" (__pu_val), "o" (__mp(__pu_addr)), "i" (-EFAULT)); })
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/r4kcache.h linux-mips-2.4.24-pre2-20040116/include/asm-mips/r4kcache.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/r4kcache.h	2004-01-05 03:57:13.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips/r4kcache.h	2004-02-15 04:24:10.000000000 +0000
@@ -77,6 +77,7 @@ static inline void protected_flush_icach
 		"2:\t.set mips0\n\t"
 		".set reorder\n\t"
 		".section\t__ex_table,\"a\"\n\t"
+		".p2align\t" STR(PTRLOG) "\n\t"
 		STR(PTR)"\t1b,2b\n\t"
 		".previous"
 		:
@@ -98,6 +99,7 @@ static inline void protected_writeback_d
 		"2:\t.set mips0\n\t"
 		".set reorder\n\t"
 		".section\t__ex_table,\"a\"\n\t"
+		".p2align\t" STR(PTRLOG) "\n\t"
 		STR(PTR)"\t1b,2b\n\t"
 		".previous"
 		:
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/uaccess.h linux-mips-2.4.24-pre2-20040116/include/asm-mips/uaccess.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/uaccess.h	2004-02-13 06:26:20.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips/uaccess.h	2004-02-15 05:19:03.000000000 +0000
@@ -13,8 +13,7 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 
-#define STR(x)  __STR(x)
-#define __STR(x)  #x
+#include <asm/asm.h>
 
 /*
  * The fs value determines whether argument validity checking should be
@@ -239,13 +238,15 @@ struct __large_struct { unsigned long bu
 	"1:\t" insn "\t%1,%2\n\t"					\
 	"move\t%0,$0\n"							\
 	"2:\n\t"							\
-	".section\t.fixup,\"ax\"\n"					\
+	".section\t.fixup,\"ax\"\n\t"					\
+	".p2align\t2\n"							\
 	"3:\tli\t%0,%3\n\t"						\
 	"move\t%1,$0\n\t"						\
 	"j\t2b\n\t"							\
 	".previous\n\t"							\
 	".section\t__ex_table,\"a\"\n\t"				\
-	".word\t1b,3b\n\t"						\
+	".p2align\t" STR(PTRLOG) "\n\t"					\
+	STR(PTR) "\t1b,3b\n\t"						\
 	".previous"							\
 	:"=r" (__gu_err), "=r" (__gu_val)				\
 	:"o" (__m(__gu_addr)), "i" (-EFAULT));				\
@@ -260,15 +261,18 @@ __asm__ __volatile__(							\
 	"1:\tlw\t%1,%2\n"						\
 	"2:\tlw\t%D1,%3\n\t"						\
 	"move\t%0,$0\n"							\
-	"3:\t.section\t.fixup,\"ax\"\n"					\
+	"3:\n\t"							\
+	".section\t.fixup,\"ax\"\n\t"					\
+	".p2align\t2\n"							\
 	"4:\tli\t%0,%4\n\t"						\
 	"move\t%1,$0\n\t"						\
 	"move\t%D1,$0\n\t"						\
 	"j\t3b\n\t"							\
 	".previous\n\t"							\
 	".section\t__ex_table,\"a\"\n\t"				\
-	".word\t1b,4b\n\t"						\
-	".word\t2b,4b\n\t"						\
+	".p2align\t" STR(PTRLOG) "\n\t"					\
+	STR(PTR) "\t1b,4b\n\t"						\
+	STR(PTR) "\t2b,4b\n\t"						\
 	".previous"							\
 	:"=r" (__gu_err), "=&r" (__gu_val)				\
 	:"o" (__m(__gu_addr)), "o" (__m(__gu_addr + 4)),		\
@@ -331,12 +335,14 @@ extern void __get_user_unknown(void);
 	"1:\t" insn "\t%z1, %2\t\t\t# __put_user_asm\n\t"		\
 	"move\t%0, $0\n"						\
 	"2:\n\t"							\
-	".section\t.fixup,\"ax\"\n"					\
+	".section\t.fixup,\"ax\"\n\t"					\
+	".p2align\t2\n"							\
 	"3:\tli\t%0, %3\n\t"						\
 	"j\t2b\n\t"							\
 	".previous\n\t"							\
 	".section\t__ex_table,\"a\"\n\t"				\
-	".word\t1b, 3b\n\t"						\
+	".p2align\t" STR(PTRLOG) "\n\t"					\
+	STR(PTR) "\t1b,3b\n\t"						\
 	".previous"							\
 	:"=r" (__pu_err)						\
 	:"Jr" (__pu_val), "o" (__m(__pu_addr)), "i" (-EFAULT));		\
@@ -349,13 +355,15 @@ __asm__ __volatile__(							\
 	"2:\tsw\t%D1, %3\n"						\
 	"move\t%0, $0\n"						\
 	"3:\n\t"							\
-	".section\t.fixup,\"ax\"\n"					\
+	".section\t.fixup,\"ax\"\n\t"					\
+	".p2align\t2\n"							\
 	"4:\tli\t%0, %4\n\t"						\
 	"j\t3b\n\t"							\
 	".previous\n\t"							\
 	".section\t__ex_table,\"a\"\n\t"				\
-	".word\t1b,4b\n\t"						\
-	".word\t2b,4b\n\t"						\
+	".p2align\t" STR(PTRLOG) "\n\t"					\
+	STR(PTR) "\t1b,4b\n\t"						\
+	STR(PTR) "\t2b,4b\n\t"						\
 	".previous"							\
 	:"=r" (__pu_err)						\
 	:"r" (__pu_val), "o" (__m(__pu_addr)), "o" (__m(__pu_addr + 4)),\
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/asm.h linux-mips-2.4.24-pre2-20040116/include/asm-mips64/asm.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/asm.h	2003-12-31 03:57:06.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips64/asm.h	2004-02-15 04:02:27.000000000 +0000
@@ -29,6 +29,11 @@
 #define CAT(str1,str2) __CAT(str1,str2)
 #endif
 
+#ifndef STR
+#define STR(x) __STR(x)
+#define __STR(x) #x
+#endif
+
 /*
  * PIC specific declarations
  * Not used for the kernel but here seems to be the right place.
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/paccess.h linux-mips-2.4.24-pre2-20040116/include/asm-mips64/paccess.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/paccess.h	2002-07-07 10:08:24.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips64/paccess.h	2004-02-15 05:18:41.000000000 +0000
@@ -14,6 +14,7 @@
 #define _ASM_PACCESS_H
 
 #include <linux/errno.h>
+#include <asm/asm.h>
 
 #define put_dbe(x,ptr) __put_dbe((x),(ptr),sizeof(*(ptr)))
 #define get_dbe(x,ptr) __get_dbe((x),(ptr),sizeof(*(ptr)))
@@ -42,13 +43,15 @@ __asm__ __volatile__( \
 	"1:\t" insn "\t%1,%2\n\t" \
 	"move\t%0,$0\n" \
 	"2:\n\t" \
-	".section\t.fixup,\"ax\"\n" \
+	".section\t.fixup,\"ax\"\n\t" \
+	".p2align\t2\n" \
 	"3:\tli\t%0,%3\n\t" \
 	"move\t%1,$0\n\t" \
 	"j\t2b\n\t" \
 	".previous\n\t" \
 	".section\t__dbe_table,\"a\"\n\t" \
-	".dword\t1b,3b\n\t" \
+	".p2align\t" STR(PTRLOG) "\n\t" \
+	STR(PTR) "\t1b,3b\n\t" \
 	".previous" \
 	:"=r" (__gu_err), "=r" (__gu_val) \
 	:"o" (__mp(__gu_addr)), "i" (-EFAULT)); })
@@ -76,12 +79,14 @@ __asm__ __volatile__( \
 	"1:\t" insn "\t%1,%2\n\t" \
 	"move\t%0,$0\n" \
 	"2:\n\t" \
-	".section\t.fixup,\"ax\"\n" \
+	".section\t.fixup,\"ax\"\n\t" \
+	".p2align\t2\n" \
 	"3:\tli\t%0,%3\n\t" \
 	"j\t2b\n\t" \
 	".previous\n\t" \
 	".section\t__dbe_table,\"a\"\n\t" \
-	".dword\t1b,3b\n\t" \
+	".p2align\t" STR(PTRLOG) "\n\t" \
+	STR(PTR) "\t1b,3b\n\t" \
 	".previous" \
 	:"=r" (__pu_err) \
 	:"r" (__pu_val), "o" (__mp(__pu_addr)), "i" (-EFAULT)); })
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/r4kcache.h linux-mips-2.4.24-pre2-20040116/include/asm-mips64/r4kcache.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/r4kcache.h	2004-01-05 03:57:15.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips64/r4kcache.h	2004-02-15 04:24:26.000000000 +0000
@@ -77,6 +77,7 @@ static inline void protected_flush_icach
 		"2:\t.set mips0\n\t"
 		".set reorder\n\t"
 		".section\t__ex_table,\"a\"\n\t"
+		".p2align\t" STR(PTRLOG) "\n\t"
 		STR(PTR)"\t1b,2b\n\t"
 		".previous"
 		:
@@ -98,6 +99,7 @@ static inline void protected_writeback_d
 		"2:\t.set mips0\n\t"
 		".set reorder\n\t"
 		".section\t__ex_table,\"a\"\n\t"
+		".p2align\t" STR(PTRLOG) "\n\t"
 		STR(PTR)"\t1b,2b\n\t"
 		".previous"
 		:
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/uaccess.h linux-mips-2.4.24-pre2-20040116/include/asm-mips64/uaccess.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/uaccess.h	2003-09-15 02:57:28.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips64/uaccess.h	2004-02-15 05:18:54.000000000 +0000
@@ -13,8 +13,7 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 
-#define STR(x)  __STR(x)
-#define __STR(x)  #x
+#include <asm/asm.h>
 
 /*
  * The fs value determines whether argument validity checking should be
@@ -229,13 +228,15 @@ struct __large_struct { unsigned long bu
 	"1:\t" insn "\t%1,%2\n\t"					\
 	"move\t%0,$0\n"							\
 	"2:\n\t"							\
-	".section\t.fixup,\"ax\"\n"					\
+	".section\t.fixup,\"ax\"\n\t"					\
+	".p2align\t2\n"							\
 	"3:\tli\t%0,%3\n\t"						\
 	"move\t%1,$0\n\t"						\
 	"j\t2b\n\t"							\
 	".previous\n\t"							\
 	".section\t__ex_table,\"a\"\n\t"				\
-	".dword\t1b,3b\n\t"						\
+	".p2align\t" STR(PTRLOG) "\n\t"					\
+	STR(PTR) "\t1b,3b\n\t"						\
 	".previous"							\
 	:"=r" (__gu_err), "=r" (__gu_val)				\
 	:"o" (__m(__gu_addr)), "i" (-EFAULT));				\
@@ -287,12 +288,14 @@ extern void __get_user_unknown(void);
 	"1:\t" insn "\t%z1, %2\t\t\t# __put_user_asm\n\t"		\
 	"move\t%0, $0\n"						\
 	"2:\n\t"							\
-	".section\t.fixup,\"ax\"\n"					\
+	".section\t.fixup,\"ax\"\n\t"					\
+	".p2align\t2\n"							\
 	"3:\tli\t%0, %3\n\t"						\
 	"j\t2b\n\t"							\
 	".previous\n\t"							\
 	".section\t__ex_table,\"a\"\n\t"				\
-	".dword\t1b, 3b\n\t"						\
+	".p2align\t" STR(PTRLOG) "\n\t"					\
+	STR(PTR) "\t1b,3b\n\t"						\
 	".previous"							\
 	:"=r" (__pu_err)						\
 	:"Jr" (__pu_val), "o" (__m(__pu_addr)), "i" (-EFAULT));		\
