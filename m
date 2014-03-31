Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2014 01:14:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41004 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822097AbaCaXOlkOMBB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2014 01:14:41 +0200
Date:   Tue, 1 Apr 2014 00:14:41 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] DEC/SNI: O32 wrapper stack switching fixes
Message-ID: <alpine.LFD.2.11.1403312351450.27402@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Commit 231a35d37293ab88d325a9cb94e5474c156282c0 [[MIPS] RM: Collected
changes] broke DECstation support by introducing an incompatible copy of
arch/mips/dec/prom/call_o32.S in arch/mips/fw/lib/, built unconditionally.
The copy happens to land earlier of the two among the modules used in the 
link and is therefore chosen for the DECstation rather than the intended
original.  As a result random kernel data is corrupted because a pointer
to the "%s" formatted output template is used as a temporary stack pointer
rather than being passed down to prom_printf.  This also explains why
prom_printf still works, up to a point -- the next argument is the actual
string to output so it works just fine as the output template until enough
kernel data has been corrupted to cause a crash.

This change adjusts the modified wrapper in arch/mips/fw/lib/call_o32.S to 
let callers request no stack switching by passing a null temporary stack 
pointer in $a1, reworks the DECstation callers to work with the updated 
interface and removes the old copy from arch/mips/dec/prom/call_o32.S.  A 
few minor readability adjustments are included as well, most importantly 
O32_SZREG is now used throughout where applicable rather than hardcoded 
multiplies of 4 and $fp is used to access the argument save area as a more 
usual register to operate the stack with rather than $s0.

Finally an update is made to the temporary stack space used by the SNI 
platform to guarantee 8-byte alignment as per o32 requirements.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Thomas,

 Please verify this works for your system.

  Maciej

linux-dec-call-o32.patch
Index: linux-20140329-4maxp64/arch/mips/dec/prom/Makefile
===================================================================
--- linux-20140329-4maxp64.orig/arch/mips/dec/prom/Makefile
+++ linux-20140329-4maxp64/arch/mips/dec/prom/Makefile
@@ -6,4 +6,3 @@
 lib-y			+= init.o memory.o cmdline.o identify.o console.o
 
 lib-$(CONFIG_32BIT)	+= locore.o
-lib-$(CONFIG_64BIT)	+= call_o32.o
Index: linux-20140329-4maxp64/arch/mips/dec/prom/call_o32.S
===================================================================
--- linux-20140329-4maxp64.orig/arch/mips/dec/prom/call_o32.S
+++ /dev/null
@@ -1,89 +0,0 @@
-/*
- *	O32 interface for the 64 (or N32) ABI.
- *
- *	Copyright (C) 2002  Maciej W. Rozycki
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- */
-
-#include <asm/asm.h>
-#include <asm/regdef.h>
-
-/* Maximum number of arguments supported.  Must be even!  */
-#define O32_ARGC	32
-/* Number of static registers we save.  */
-#define O32_STATC	11
-/* Frame size for both of the above.  */
-#define O32_FRAMESZ	(4 * O32_ARGC + SZREG * O32_STATC)
-
-		.text
-
-/*
- * O32 function call dispatcher, for interfacing 32-bit ROM routines.
- *
- * The standard 64 (N32) calling sequence is supported, with a0
- * holding a function pointer, a1-a7 -- its first seven arguments
- * and the stack -- remaining ones (up to O32_ARGC, including a1-a7).
- * Static registers, gp and fp are preserved, v0 holds a result.
- * This code relies on the called o32 function for sp and ra
- * restoration and thus both this dispatcher and the current stack
- * have to be placed in a KSEGx (or KUSEG) address space.  Any
- * pointers passed have to point to addresses within one of these
- * spaces as well.
- */
-NESTED(call_o32, O32_FRAMESZ, ra)
-		REG_SUBU	sp,O32_FRAMESZ
-
-		REG_S		ra,O32_FRAMESZ-1*SZREG(sp)
-		REG_S		fp,O32_FRAMESZ-2*SZREG(sp)
-		REG_S		gp,O32_FRAMESZ-3*SZREG(sp)
-		REG_S		s7,O32_FRAMESZ-4*SZREG(sp)
-		REG_S		s6,O32_FRAMESZ-5*SZREG(sp)
-		REG_S		s5,O32_FRAMESZ-6*SZREG(sp)
-		REG_S		s4,O32_FRAMESZ-7*SZREG(sp)
-		REG_S		s3,O32_FRAMESZ-8*SZREG(sp)
-		REG_S		s2,O32_FRAMESZ-9*SZREG(sp)
-		REG_S		s1,O32_FRAMESZ-10*SZREG(sp)
-		REG_S		s0,O32_FRAMESZ-11*SZREG(sp)
-
-		move		jp,a0
-
-		sll		a0,a1,zero
-		sll		a1,a2,zero
-		sll		a2,a3,zero
-		sll		a3,a4,zero
-		sw		a5,0x10(sp)
-		sw		a6,0x14(sp)
-		sw		a7,0x18(sp)
-
-		PTR_LA		t0,O32_FRAMESZ(sp)
-		PTR_LA		t1,0x1c(sp)
-		li		t2,O32_ARGC-7
-1:
-		lw		t3,(t0)
-		REG_ADDU	t0,SZREG
-		sw		t3,(t1)
-		REG_SUBU	t2,1
-		REG_ADDU	t1,4
-		bnez		t2,1b
-
-		jalr		jp
-
-		REG_L		s0,O32_FRAMESZ-11*SZREG(sp)
-		REG_L		s1,O32_FRAMESZ-10*SZREG(sp)
-		REG_L		s2,O32_FRAMESZ-9*SZREG(sp)
-		REG_L		s3,O32_FRAMESZ-8*SZREG(sp)
-		REG_L		s4,O32_FRAMESZ-7*SZREG(sp)
-		REG_L		s5,O32_FRAMESZ-6*SZREG(sp)
-		REG_L		s6,O32_FRAMESZ-5*SZREG(sp)
-		REG_L		s7,O32_FRAMESZ-4*SZREG(sp)
-		REG_L		gp,O32_FRAMESZ-3*SZREG(sp)
-		REG_L		fp,O32_FRAMESZ-2*SZREG(sp)
-		REG_L		ra,O32_FRAMESZ-1*SZREG(sp)
-
-		REG_ADDU	sp,O32_FRAMESZ
-		jr		ra
-END(call_o32)
Index: linux-20140329-4maxp64/arch/mips/fw/lib/call_o32.S
===================================================================
--- linux-20140329-4maxp64.orig/arch/mips/fw/lib/call_o32.S
+++ linux-20140329-4maxp64/arch/mips/fw/lib/call_o32.S
@@ -1,7 +1,7 @@
 /*
  *	O32 interface for the 64 (or N32) ABI.
  *
- *	Copyright (C) 2002  Maciej W. Rozycki
+ *	Copyright (C) 2002, 2014  Maciej W. Rozycki
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -12,28 +12,37 @@
 #include <asm/asm.h>
 #include <asm/regdef.h>
 
+/* O32 register size.  */
+#define O32_SZREG	4
 /* Maximum number of arguments supported.  Must be even!  */
 #define O32_ARGC	32
-/* Number of static registers we save.	*/
+/* Number of static registers we save.  */
 #define O32_STATC	11
-/* Frame size for static register  */
-#define O32_FRAMESZ	(SZREG * O32_STATC)
-/* Frame size on new stack */
-#define O32_FRAMESZ_NEW (SZREG + 4 * O32_ARGC)
+/* Argument area frame size.  */
+#define O32_ARGSZ	(O32_SZREG * O32_ARGC)
+/* Static register save area frame size.  */
+#define O32_STATSZ	(SZREG * O32_STATC)
+/* Stack pointer register save area frame size.  */
+#define O32_SPSZ	SZREG
+/* Combined area frame size.  */
+#define O32_FRAMESZ	(O32_ARGSZ + O32_SPSZ + O32_STATSZ)
+/* Switched stack frame size.  */
+#define O32_NFRAMESZ	(O32_ARGSZ + O32_SPSZ)
 
 		.text
 
 /*
  * O32 function call dispatcher, for interfacing 32-bit ROM routines.
  *
- * The standard 64 (N32) calling sequence is supported, with a0
- * holding a function pointer, a1 a new stack pointer, a2-a7 -- its
- * first six arguments and the stack -- remaining ones (up to O32_ARGC,
- * including a2-a7). Static registers, gp and fp are preserved, v0 holds
- * a result. This code relies on the called o32 function for sp and ra
- * restoration and this dispatcher has to be placed in a KSEGx (or KUSEG)
- * address space.  Any pointers passed have to point to addresses within
- * one of these spaces as well.
+ * The standard 64 (N32) calling sequence is supported, with a0 holding
+ * a function pointer, a1 a pointer to the new stack to call the
+ * function with or 0 if no stack switching is requested, a2-a7 -- the
+ * function call's first six arguments, and the stack -- the remaining
+ * arguments (up to O32_ARGC, including a2-a7).  Static registers, gp
+ * and fp are preserved, v0 holds the result.  This code relies on the
+ * called o32 function for sp and ra restoration and this dispatcher has
+ * to be placed in a KSEGx (or KUSEG) address space.  Any pointers
+ * passed have to point to addresses within one of these spaces as well.
  */
 NESTED(call_o32, O32_FRAMESZ, ra)
 		REG_SUBU	sp,O32_FRAMESZ
@@ -51,32 +60,36 @@ NESTED(call_o32, O32_FRAMESZ, ra)
 		REG_S		s0,O32_FRAMESZ-11*SZREG(sp)
 
 		move		jp,a0
-		REG_SUBU	s0,a1,O32_FRAMESZ_NEW
-		REG_S		sp,O32_FRAMESZ_NEW-1*SZREG(s0)
+
+		move		fp,sp
+		beqz		a1,0f
+		REG_SUBU	fp,a1,O32_NFRAMESZ
+0:
+		REG_S		sp,O32_NFRAMESZ-1*SZREG(fp)
 
 		sll		a0,a2,zero
 		sll		a1,a3,zero
 		sll		a2,a4,zero
 		sll		a3,a5,zero
-		sw		a6,0x10(s0)
-		sw		a7,0x14(s0)
+		sw		a6,4*O32_SZREG(fp)
+		sw		a7,5*O32_SZREG(fp)
 
 		PTR_LA		t0,O32_FRAMESZ(sp)
-		PTR_LA		t1,0x18(s0)
+		PTR_LA		t1,6*O32_SZREG(fp)
 		li		t2,O32_ARGC-6
 1:
 		lw		t3,(t0)
 		REG_ADDU	t0,SZREG
 		sw		t3,(t1)
 		REG_SUBU	t2,1
-		REG_ADDU	t1,4
+		REG_ADDU	t1,O32_SZREG
 		bnez		t2,1b
 
-		move		sp,s0
+		move		sp,fp
 
 		jalr		jp
 
-		REG_L		sp,O32_FRAMESZ_NEW-1*SZREG(sp)
+		REG_L		sp,O32_NFRAMESZ-1*SZREG(sp)
 
 		REG_L		s0,O32_FRAMESZ-11*SZREG(sp)
 		REG_L		s1,O32_FRAMESZ-10*SZREG(sp)
Index: linux-20140329-4maxp64/arch/mips/fw/sni/sniprom.c
===================================================================
--- linux-20140329-4maxp64.orig/arch/mips/fw/sni/sniprom.c
+++ linux-20140329-4maxp64/arch/mips/fw/sni/sniprom.c
@@ -40,7 +40,8 @@
 
 #ifdef CONFIG_64BIT
 
-static u8 o32_stk[16384];
+/* O32 stack has to be 8-byte aligned. */
+static u64 o32_stk[4096];
 #define O32_STK	  &o32_stk[sizeof(o32_stk)]
 
 #define __PROM_O32(fun, arg) fun arg __asm__(#fun); \
Index: linux-20140329-4maxp64/arch/mips/include/asm/dec/prom.h
===================================================================
--- linux-20140329-4maxp64.orig/arch/mips/include/asm/dec/prom.h
+++ linux-20140329-4maxp64/arch/mips/include/asm/dec/prom.h
@@ -113,31 +113,31 @@ extern int (*__pmax_close)(int);
 #define __DEC_PROM_O32(fun, arg) fun arg __asm__(#fun); \
 				 __asm__(#fun " = call_o32")
 
-int __DEC_PROM_O32(_rex_bootinit, (int (*)(void)));
-int __DEC_PROM_O32(_rex_bootread, (int (*)(void)));
-int __DEC_PROM_O32(_rex_getbitmap, (int (*)(memmap *), memmap *));
+int __DEC_PROM_O32(_rex_bootinit, (int (*)(void), void *));
+int __DEC_PROM_O32(_rex_bootread, (int (*)(void), void *));
+int __DEC_PROM_O32(_rex_getbitmap, (int (*)(memmap *), void *, memmap *));
 unsigned long *__DEC_PROM_O32(_rex_slot_address,
-			     (unsigned long *(*)(int), int));
-void *__DEC_PROM_O32(_rex_gettcinfo, (void *(*)(void)));
-int __DEC_PROM_O32(_rex_getsysid, (int (*)(void)));
-void __DEC_PROM_O32(_rex_clear_cache, (void (*)(void)));
+			     (unsigned long *(*)(int), void *, int));
+void *__DEC_PROM_O32(_rex_gettcinfo, (void *(*)(void), void *));
+int __DEC_PROM_O32(_rex_getsysid, (int (*)(void), void *));
+void __DEC_PROM_O32(_rex_clear_cache, (void (*)(void), void *));
 
-int __DEC_PROM_O32(_prom_getchar, (int (*)(void)));
-char *__DEC_PROM_O32(_prom_getenv, (char *(*)(char *), char *));
-int __DEC_PROM_O32(_prom_printf, (int (*)(char *, ...), char *, ...));
+int __DEC_PROM_O32(_prom_getchar, (int (*)(void), void *));
+char *__DEC_PROM_O32(_prom_getenv, (char *(*)(char *), void *, char *));
+int __DEC_PROM_O32(_prom_printf, (int (*)(char *, ...), void *, char *, ...));
 
 
-#define rex_bootinit()		_rex_bootinit(__rex_bootinit)
-#define rex_bootread()		_rex_bootread(__rex_bootread)
-#define rex_getbitmap(x)	_rex_getbitmap(__rex_getbitmap, x)
-#define rex_slot_address(x)	_rex_slot_address(__rex_slot_address, x)
-#define rex_gettcinfo()		_rex_gettcinfo(__rex_gettcinfo)
-#define rex_getsysid()		_rex_getsysid(__rex_getsysid)
-#define rex_clear_cache()	_rex_clear_cache(__rex_clear_cache)
+#define rex_bootinit()		_rex_bootinit(__rex_bootinit, NULL)
+#define rex_bootread()		_rex_bootread(__rex_bootread, NULL)
+#define rex_getbitmap(x)	_rex_getbitmap(__rex_getbitmap, NULL, x)
+#define rex_slot_address(x)	_rex_slot_address(__rex_slot_address, NULL, x)
+#define rex_gettcinfo()		_rex_gettcinfo(__rex_gettcinfo, NULL)
+#define rex_getsysid()		_rex_getsysid(__rex_getsysid, NULL)
+#define rex_clear_cache()	_rex_clear_cache(__rex_clear_cache, NULL)
 
-#define prom_getchar()		_prom_getchar(__prom_getchar)
-#define prom_getenv(x)		_prom_getenv(__prom_getenv, x)
-#define prom_printf(x...)	_prom_printf(__prom_printf, x)
+#define prom_getchar()		_prom_getchar(__prom_getchar, NULL)
+#define prom_getenv(x)		_prom_getenv(__prom_getenv, NULL, x)
+#define prom_printf(x...)	_prom_printf(__prom_printf, NULL, x)
 
 #else /* !CONFIG_64BIT */
 
