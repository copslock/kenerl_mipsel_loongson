Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA46084 for <linux-archive@neteng.engr.sgi.com>; Fri, 16 Oct 1998 18:11:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA15827
	for linux-list;
	Fri, 16 Oct 1998 18:10:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA38021
	for <linux@engr.sgi.com>;
	Fri, 16 Oct 1998 18:10:54 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA02310
	for <linux@engr.sgi.com>; Fri, 16 Oct 1998 18:10:52 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-06.uni-koblenz.de [141.26.249.6])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id DAA21024
	for <linux@engr.sgi.com>; Sat, 17 Oct 1998 03:10:12 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA04470;
	Sat, 17 Oct 1998 00:44:08 +0200
Message-ID: <19981017004408.E3370@uni-koblenz.de>
Date: Sat, 17 Oct 1998 00:44:08 +0200
From: ralf@uni-koblenz.de
To: Vladimir Roganov <roganov@niisi.msk.ru>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, linux-mips@vger.rutgers.edu
Subject: Re: get_mmu_context()
References: <19981013215927.A2692@uni-koblenz.de> <3625D799.7D923FA9@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=mP3DRpeJDSE+ciuQ
X-Mailer: Mutt 0.91.1
In-Reply-To: <3625D799.7D923FA9@niisi.msk.ru>; from Vladimir Roganov on Thu, Oct 15, 1998 at 03:08:09PM +0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii

Ok, here is the first working and tested version of my runtime patched
get_mmu_context thing.  While writing the code I noticed that the code
patching stuff is actually already a part of what I was intending to implement
since long time like for example getting rid of function pointers and can
be used to optimize many more things throughout the kernel.  So while some
parts already look somewhat generic I'd like to make them really generic.
The thing is probably going to look somewhat similar to the Sparc btfixup
code which I'm going to read now.

  Ralf

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=asid-patch

Index: linux/arch/mips/mm/andes.c
diff -u linux/arch/mips/mm/andes.c:1.5 linux/arch/mips/mm/andes.c:1.6
--- linux/arch/mips/mm/andes.c:1.5	Fri May  1 08:33:13 1998
+++ linux/arch/mips/mm/andes.c	Fri Oct 16 21:22:42 1998
@@ -1,9 +1,8 @@
-/*
+/* $Id: andes.c,v 1.6 1998/10/16 19:22:42 ralf Exp $
+ *
  * andes.c: MMU and cache operations for the R10000 (ANDES).
  *
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- *
- * $Id: andes.c,v 1.5 1998/05/01 06:33:13 ralf Exp $
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -13,6 +12,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/sgialib.h>
+#include <asm/mmu_context.h>
 
 extern unsigned long mips_tlb_entries;
 
@@ -104,6 +104,7 @@
 	flush_tlb_mm = andes_flush_tlb_mm;
 	flush_tlb_range = andes_flush_tlb_range;
 	flush_tlb_page = andes_flush_tlb_page;
+	andes_asid_setup();
     
         add_wired_entry = andes_add_wired_entry;
 
Index: linux/arch/mips/mm/fault.c
diff -u linux/arch/mips/mm/fault.c:1.10 linux/arch/mips/mm/fault.c:1.11
--- linux/arch/mips/mm/fault.c:1.10	Thu Sep 17 00:50:44 1998
+++ linux/arch/mips/mm/fault.c	Fri Oct 16 21:22:42 1998
@@ -1,4 +1,4 @@
-/* $Id: fault.c,v 1.10 1998/09/16 22:50:44 ralf Exp $
+/* $Id: fault.c,v 1.11 1998/10/16 19:22:42 ralf Exp $
  *
  *  arch/mips/mm/fault.c
  *
@@ -26,7 +26,7 @@
 
 extern void die(char *, struct pt_regs *, unsigned long write);
 
-unsigned long asid_cache = ASID_FIRST_VERSION;
+unsigned long asid_cache;
 
 /*
  * Macro for exception fixup code to access integer registers.
Index: linux/arch/mips/mm/init.c
diff -u linux/arch/mips/mm/init.c:1.12 linux/arch/mips/mm/init.c:1.13
--- linux/arch/mips/mm/init.c:1.12	Thu Sep 17 00:50:44 1998
+++ linux/arch/mips/mm/init.c	Fri Oct 16 21:22:42 1998
@@ -1,4 +1,4 @@
-/* $Id: init.c,v 1.12 1998/09/16 22:50:44 ralf Exp $
+/* $Id: init.c,v 1.13 1998/10/16 19:22:42 ralf Exp $
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -33,6 +33,7 @@
 #ifdef CONFIG_SGI
 #include <asm/sgialib.h>
 #endif
+#include <asm/mmu_context.h>
 
 /*
  * Define this to effectivly disable the userpage colouring shit.
@@ -463,4 +464,36 @@
 	val->totalram <<= PAGE_SHIFT;
 	val->sharedram <<= PAGE_SHIFT;
 	return;
+}
+
+/* Fixup an immediate instruction  */
+__initfunc(static void __i_insn_fixup(unsigned int **start, unsigned int **stop,
+                         unsigned int i_const))
+{
+	unsigned int **p, *ip;
+
+	for (p = start;p < stop; p++) {
+		ip = *p;
+		*ip = (*ip & 0xffff0000) | i_const;
+	}
+}
+
+#define i_insn_fixup(section, const)					  \
+do {									  \
+	extern unsigned int *__start_ ## section;			  \
+	extern unsigned int *__stop_ ## section;			  \
+	__i_insn_fixup(&__start_ ## section, &__stop_ ## section, const); \
+} while(0)
+
+/* Caller is assumed to flush the caches before the first context switch.  */
+__initfunc(void __asid_setup(unsigned int inc, unsigned int mask,
+                             unsigned int version_mask,
+                             unsigned int first_version))
+{
+	i_insn_fixup(__asid_inc, inc);
+	i_insn_fixup(__asid_mask, mask);
+	i_insn_fixup(__asid_version_mask, version_mask);
+	i_insn_fixup(__asid_first_version, first_version);
+
+	asid_cache = first_version;
 }
Index: linux/arch/mips/mm/r2300.c
diff -u linux/arch/mips/mm/r2300.c:1.6 linux/arch/mips/mm/r2300.c:1.7
--- linux/arch/mips/mm/r2300.c:1.6	Tue Aug 18 22:45:08 1998
+++ linux/arch/mips/mm/r2300.c	Fri Oct 16 21:22:43 1998
@@ -1,9 +1,8 @@
-/*
+/* $Id: r2300.c,v 1.7 1998/10/16 19:22:43 ralf Exp $
+ *
  * r2300.c: R2000 and R3000 specific mmu/cache code.
  *
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- *
- * $Id: r2300.c,v 1.6 1998/08/18 20:45:08 ralf Exp $
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -14,6 +13,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/sgialib.h>
+#include <asm/mmu_context.h>
 
 extern unsigned long mips_tlb_entries;
 
@@ -274,6 +274,7 @@
 	flush_tlb_mm = r2300_flush_tlb_mm;
 	flush_tlb_range = r2300_flush_tlb_range;
 	flush_tlb_page = r2300_flush_tlb_page;
+	r3000_asid_setup();
 
 	load_pgd = r2300_load_pgd;
 	pgd_init = r2300_pgd_init;
Index: linux/arch/mips/mm/r4xx0.c
diff -u linux/arch/mips/mm/r4xx0.c:1.29 linux/arch/mips/mm/r4xx0.c:1.30
--- linux/arch/mips/mm/r4xx0.c:1.29	Wed Oct 14 22:29:59 1998
+++ linux/arch/mips/mm/r4xx0.c	Fri Oct 16 21:22:43 1998
@@ -1,4 +1,4 @@
-/* $Id: r4xx0.c,v 1.29 1998/10/14 20:29:59 ralf Exp $
+/* $Id: r4xx0.c,v 1.30 1998/10/16 19:22:43 ralf Exp $
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -2791,6 +2791,7 @@
 	flush_tlb_mm = r4k_flush_tlb_mm;
 	flush_tlb_range = r4k_flush_tlb_range;
 	flush_tlb_page = r4k_flush_tlb_page;
+	r4xx0_asid_setup();
 
 	load_pgd = r4k_load_pgd;
 	pgd_init = r4k_pgd_init;
Index: linux/arch/mips/mm/r6000.c
diff -u linux/arch/mips/mm/r6000.c:1.5 linux/arch/mips/mm/r6000.c:1.6
--- linux/arch/mips/mm/r6000.c:1.5	Tue Aug 18 22:45:09 1998
+++ linux/arch/mips/mm/r6000.c	Fri Oct 16 21:22:44 1998
@@ -1,4 +1,5 @@
-/* $Id: r6000.c,v 1.5 1998/08/18 20:45:09 ralf Exp $
+/* $Id: r6000.c,v 1.6 1998/10/16 19:22:44 ralf Exp $
+ *
  * r6000.c: MMU and cache routines for the R6000 processors.
  *
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
@@ -13,6 +14,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/sgialib.h>
+#include <asm/mmu_context.h>
 
 __asm__(".set mips3"); /* because we know... */
 
@@ -180,6 +182,7 @@
 	flush_tlb_mm = r6000_flush_tlb_mm;
 	flush_tlb_range = r6000_flush_tlb_range;
 	flush_tlb_page = r6000_flush_tlb_page;
+	r6000_asid_setup();
 
 	load_pgd = r6000_load_pgd;
 	pgd_init = r6000_pgd_init;
Index: linux/arch/mips/mm/tfp.c
diff -u linux/arch/mips/mm/tfp.c:1.5 linux/arch/mips/mm/tfp.c:1.6
--- linux/arch/mips/mm/tfp.c:1.5	Fri May  1 08:31:34 1998
+++ linux/arch/mips/mm/tfp.c	Fri Oct 16 21:22:44 1998
@@ -1,4 +1,5 @@
-/*
+/* $Id: tfp.c,v 1.6 1998/10/16 19:22:44 ralf Exp $
+ *
  * tfp.c: MMU and cache routines specific to the r8000 (TFP).
  *
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
@@ -13,6 +14,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/sgialib.h>
+#include <asm/mmu_context.h>
 
 extern unsigned long mips_tlb_entries;
 
@@ -104,6 +106,7 @@
 	flush_tlb_mm = tfp_flush_tlb_mm;
 	flush_tlb_range = tfp_flush_tlb_range;
 	flush_tlb_page = tfp_flush_tlb_page;
+	tfp_asid_setup();
 
         add_wired_entry = tfp_add_wired_entry;
 
Index: linux/include/asm-mips/mmu_context.h
diff -u linux/include/asm-mips/mmu_context.h:1.2 linux/include/asm-mips/mmu_context.h:1.3
--- linux/include/asm-mips/mmu_context.h:1.2	Tue May  5 12:22:01 1998
+++ linux/include/asm-mips/mmu_context.h	Fri Oct 16 21:22:54 1998
@@ -1,4 +1,4 @@
-/* $Id: mmu_context.h,v 1.2 1998/05/05 10:22:01 ralf Exp $
+/* $Id: mmu_context.h,v 1.3 1998/10/16 19:22:54 ralf Exp $
  *
  * Switch a MMU context.
  *
@@ -11,29 +11,61 @@
 #ifndef __ASM_MIPS_MMU_CONTEXT_H
 #define __ASM_MIPS_MMU_CONTEXT_H
 
-#define MAX_ASID 255
-
+/* Fuck.  The f-word is here so you can grep for it :-)  */
 extern unsigned long asid_cache;
 
-#define ASID_VERSION_SHIFT 16
-#define ASID_VERSION_MASK  ((~0UL) << ASID_VERSION_SHIFT)
-#define ASID_FIRST_VERSION (1UL << ASID_VERSION_SHIFT)
-
-extern inline void get_new_mmu_context(struct mm_struct *mm, unsigned long asid)
-{
-	/* check if it's legal.. */
-	if ((asid & ~ASID_VERSION_MASK) > MAX_ASID) {
-		/* start a new version, invalidate all old asid's */
-		flush_tlb_all();
-		asid = (asid & ASID_VERSION_MASK) + ASID_FIRST_VERSION;
-		if (!asid)
+/* I patch, therefore I am ...  */
+#define ASID_INC(asid)						\
+ ({ unsigned long __asid = asid;				\
+   __asm__("1:\taddiu\t%0,0\t\t\t\t# patched\n\t"		\
+           ".section\t__asid_inc,\"a\"\n\t"			\
+           ".word\t1b\n\t"					\
+           ".previous"						\
+           :"=r" (__asid)					\
+           :"0" (__asid));					\
+   __asid; })
+#define ASID_MASK(asid)						\
+ ({ unsigned long __asid = asid;				\
+   __asm__("1:\tandi\t%0,%1,0\t\t\t# patched\n\t"			\
+           ".section\t__asid_mask,\"a\"\n\t"			\
+           ".word\t1b\n\t"					\
+           ".previous"						\
+           :"=r" (__asid)					\
+           :"r" (__asid));					\
+   __asid; })
+#define ASID_VERSION_MASK					\
+ ({ unsigned long __asid;					\
+   __asm__("1:\tli\t%0,0\t\t\t\t# patched\n\t"			\
+           ".section\t__asid_version_mask,\"a\"\n\t"		\
+           ".word\t1b\n\t"					\
+           ".previous"						\
+           :"=r" (__asid));					\
+   __asid; })
+#define ASID_FIRST_VERSION					\
+ ({ unsigned long __asid = asid;				\
+   __asm__("1:\tli\t%0,0\t\t\t\t# patched\n\t"			\
+           ".section\t__asid_first_version,\"a\"\n\t"		\
+           ".word\t1b\n\t"					\
+           ".previous"						\
+           :"=r" (__asid));					\
+   __asid; })
+
+#define ASID_FIRST_VERSION_R3000 0x1000
+#define ASID_FIRST_VERSION_R4000 0x100
+
+extern inline void
+get_new_mmu_context(struct mm_struct *mm, unsigned long asid)
+{
+	if (!ASID_MASK((asid = ASID_INC(asid)))) {
+		flush_tlb_all(); /* start new asid cycle */
+		if (!asid)      /* fix version if needed */
 			asid = ASID_FIRST_VERSION;
 	}
-	asid_cache = asid + 1;
-	mm->context = asid;			 /* full version + asid */
+	mm->context = asid_cache = asid;
 }
 
-extern inline void get_mmu_context(struct task_struct *p)
+extern inline void
+get_mmu_context(struct task_struct *p)
 {
 	struct mm_struct *mm = p->mm;
 
@@ -72,5 +104,31 @@
 	get_mmu_context(tsk);
 	set_entryhi(tsk->mm->context);
 }
+
+extern void __asid_setup(unsigned int inc, unsigned int mask,
+                         unsigned int version_mask, unsigned int first_version);
+
+extern inline void r3000_asid_setup(void)
+{
+	__asid_setup(0x40, 0xfc0, 0xf000, ASID_FIRST_VERSION_R3000);
+}
+
+extern inline void r6000_asid_setup(void)
+{
+	panic("r6000_asid_setup: implement me");	/* No idea ...  */
+}
+
+extern inline void tfp_asid_setup(void)
+{
+	panic("tfp_asid_setup: implement me");	/* No idea ...  */
+}
+
+extern inline void r4xx0_asid_setup(void)
+{
+	__asid_setup(1, 0xff, 0xff00, ASID_FIRST_VERSION_R4000);
+}
+
+/* R10000 has the same ASID mechanism as the R4000.  */
+#define andes_asid_setup r4xx0_asid_setup
 
 #endif /* __ASM_MIPS_MMU_CONTEXT_H */

--mP3DRpeJDSE+ciuQ--
