Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Oct 2010 11:42:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59665 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491766Ab0JJJmM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Oct 2010 11:42:12 +0200
Date:   Sun, 10 Oct 2010 10:42:12 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] LD/SD o32 macro GAS fix update
Message-ID: <alpine.LFD.2.00.1010101008240.15889@eddie.linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 I am about to commit:

http://sourceware.org/ml/binutils/2010-10/msg00033.html

that fixes a problem with the LD/SD macro currently implemented by GAS for 
the o32 ABI in an inconsistent way.  This is best illustrated with a 
simple program, which I'm copying here from the message above for easier 
reference:

$ cat ld.s
	ld	$5,32767($4)
	ld	$5,32768($4)

This gets assebled into the following output:

$ mips-linux-as -32 -mips3 -o ld.o ld.s
$ mips-linux-objdump -d ld.o

ld.o:     file format elf32-tradbigmips


Disassembly of section .text:

00000000 <.text>:
   0:	dc857fff 	ld	a1,32767(a0)
   4:	3c010001 	lui	at,0x1
   8:	00810821 	addu	at,a0,at
   c:	8c258000 	lw	a1,-32768(at)
  10:	8c268004 	lw	a2,-32764(at)
	...

Oops!

 The GAS fix makes the macro behave in a consistent way and pairs of LW/SW 
instructions to be output as appropriate regardless of the size of the 
offset associated with the address used.  The machine instruction is still 
available, but to reach it macros have to be disabled first.  This has a 
side effect of requiring the use of a machine-addressable memory operand.

 As some platforms require 64-bit operations for accesses to some I/O 
registers LD/SD instructions are used in a couple of places in Linux 
regardless of the ABI selected.  Here's a fix for some pieces of code 
affected I've been able to track down.  The fix should be backwards 
compatible with all supported binutils releases in existence and can be 
used as a reference for any other places or off-tree code.  The use of the 
"R" constraint guarantees a machine-addressable operand.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Ralf: please apply, including any relevand maintenance branches.  Note I 
have not tested this change; I have no resources to do so at the moment, 
sorry.

 Platform maintainers: please audit your code for any other places that 
may require such a change.  Note only LD/SD macros are affected, other 
64-bit intructions are fine, including LLD/SCD that are not macros on o32 
(barring any complex address calculations required for modes not directly 
supported by hardware).

  Maciej

patch-mips-2.6.36-rc4-20101010-ldsd-nomacro-0
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index c98bf51..5b017f2 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -329,10 +329,14 @@ static inline void pfx##write##bwlq(type val,				\
 			"dsrl32	%L0, %L0, 0"			"\n\t"	\
 			"dsll32	%M0, %M0, 0"			"\n\t"	\
 			"or	%L0, %L0, %M0"			"\n\t"	\
+			".set	push"				"\n\t"	\
+			".set	noreorder"			"\n\t"	\
+			".set	nomacro"			"\n\t"	\
 			"sd	%L0, %2"			"\n\t"	\
+			".set	pop"				"\n\t"	\
 			".set	mips0"				"\n"	\
 			: "=r" (__tmp)					\
-			: "0" (__val), "m" (*__mem));			\
+			: "0" (__val), "R" (*__mem));			\
 		if (irq)						\
 			local_irq_restore(__flags);			\
 	} else								\
@@ -355,12 +359,16 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 			local_irq_save(__flags);			\
 		__asm__ __volatile__(					\
 			".set	mips3"		"\t\t# __readq"	"\n\t"	\
+			".set	push"				"\n\t"	\
+			".set	noreorder"			"\n\t"	\
+			".set	nomacro"			"\n\t"	\
 			"ld	%L0, %1"			"\n\t"	\
+			".set	pop"				"\n\t"	\
 			"dsra32	%M0, %L0, 0"			"\n\t"	\
 			"sll	%L0, %L0, 0"			"\n\t"	\
 			".set	mips0"				"\n"	\
 			: "=r" (__val)					\
-			: "m" (*__mem));				\
+			: "R" (*__mem));				\
 		if (irq)						\
 			local_irq_restore(__flags);			\
 	} else {							\
diff --git a/arch/mips/pmc-sierra/yosemite/py-console.c b/arch/mips/pmc-sierra/yosemite/py-console.c
index b7f1d9c..434d7b1 100644
--- a/arch/mips/pmc-sierra/yosemite/py-console.c
+++ b/arch/mips/pmc-sierra/yosemite/py-console.c
@@ -65,11 +65,15 @@ static unsigned char readb_outer_space(unsigned long long phys)
 
 	__asm__ __volatile__ (
 	"	.set	mips3		\n"
+	"	.set	push		\n"
+	"	.set	noreorder	\n"
+	"	.set	nomacro		\n"
 	"	ld	%0, %1		\n"
+	"	.set	pop		\n"
 	"	lbu	%0, (%0)	\n"
 	"	.set	mips0		\n"
 	: "=r" (res)
-	: "m" (vaddr));
+	: "R" (vaddr));
 
 	write_c0_status(sr);
 	ssnop_4();
@@ -89,11 +93,15 @@ static void writeb_outer_space(unsigned long long phys, unsigned char c)
 
 	__asm__ __volatile__ (
 	"	.set	mips3		\n"
+	"	.set	push		\n"
+	"	.set	noreorder	\n"
+	"	.set	nomacro		\n"
 	"	ld	%0, %1		\n"
+	"	.set	pop		\n"
 	"	sb	%2, (%0)	\n"
 	"	.set	mips0		\n"
 	: "=&r" (tmp)
-	: "m" (vaddr), "r" (c));
+	: "R" (vaddr), "r" (c));
 
 	write_c0_status(sr);
 	ssnop_4();
