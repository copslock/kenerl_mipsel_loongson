Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Dec 2002 04:51:43 +0000 (GMT)
Received: from gateway-1237.mvista.com ([12.44.186.158]:33267 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225264AbSLNEvm>;
	Sat, 14 Dec 2002 04:51:42 +0000
Received: from adsl.pacbell.net (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id UAA08814;
	Fri, 13 Dec 2002 20:51:22 -0800
Subject: PATCH
From: Pete Popov <ppopov@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Dec 2002 20:50:35 -0800
Message-Id: <1039841435.25371.10.camel@adsl.pacbell.net>
Mime-Version: 1.0
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf,

Here's an updated patch for 36 bit address support to replace the patch
I sent you a couple of days ago. This one is "complete" because it takes
care of remap_page_range() as well. It has been tested with a few 36 bit
peripherals on the Alchemy boards. The remap_page_range() fixup was
needed for a RageXL PCI card on the Pb1500 PCI bus and X runs fine on
it.  The patch takes effect only if  CONFIG_64BIT_PHYS_ADDR and
CONFIG_CPU_MIPS32 are both defined.  Otherwise it's a noop. A similar
solution was tested and implemented on PPC, 2.4.x.

Pete

diff -Naur --exclude=CVS linux-2.4-orig/arch/mips/mm/Makefile linux-2.4/arch/mips/mm/Makefile
--- linux-2.4-orig/arch/mips/mm/Makefile	Mon Dec  9 16:57:46 2002
+++ linux-2.4/arch/mips/mm/Makefile	Tue Dec 10 22:14:30 2002
@@ -25,7 +25,7 @@
 obj-$(CONFIG_CPU_R5432)		+= pg-r5432.o c-r5432.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_RM7000)	+= pg-rm7k.o c-rm7k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R10000)	+= pg-andes.o c-andes.o tlb-r4k.o tlbex-r4k.o
-obj-$(CONFIG_CPU_MIPS32)	+= pg-mips32.o c-mips32.o tlb-r4k.o tlbex-r4k.o
+obj-$(CONFIG_CPU_MIPS32)	+= pg-mips32.o c-mips32.o tlb-r4k.o tlbex-mips32.o
 obj-$(CONFIG_CPU_MIPS64)	+= pg-mips32.o c-mips32.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_SB1)		+= pg-sb1.o c-sb1.o tlb-sb1.o tlbex-r4k.o
 
diff -Naur --exclude=CVS linux-2.4-orig/arch/mips/mm/ioremap.c linux-2.4/arch/mips/mm/ioremap.c
--- linux-2.4-orig/arch/mips/mm/ioremap.c	Wed Nov 13 15:04:50 2002
+++ linux-2.4/arch/mips/mm/ioremap.c	Wed Dec 11 22:55:45 2002
@@ -94,6 +94,17 @@
 }
 
 /*
+ * Allow physical addresses to be fixed up to help 36 bit 
+ * peripherals.
+ */
+static phys_t def_fixup_bigphys_addr(phys_t phys_addr, phys_t size)
+{
+	return phys_addr;
+}
+
+phys_t (*fixup_bigphys_addr)(phys_t phys_addr, phys_t size) = def_fixup_bigphys_addr;
+
+/*
  * Generic mapping function (not visible outside):
  */
 
@@ -107,7 +118,7 @@
  * caller shouldn't need to know that small detail.
  */
 
-#define IS_LOW512(addr) (!((phys_t)(addr) & ~0x1fffffffUL))
+#define IS_LOW512(addr) (!((phys_t)(addr) & ~0x1fffffffUL)  && !((phys_t)addr & 0xFFFFFFFF00000000))
 
 void * __ioremap(phys_t phys_addr, phys_t size, unsigned long flags)
 {
@@ -116,6 +127,8 @@
 	phys_t last_addr;
 	void * addr;
 
+	phys_addr = fixup_bigphys_addr(phys_addr, size);
+
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
 	if (!size || last_addr < phys_addr)
diff -Naur --exclude=CVS linux-2.4-orig/arch/mips/mm/tlb-r4k.c linux-2.4/arch/mips/mm/tlb-r4k.c
--- linux-2.4-orig/arch/mips/mm/tlb-r4k.c	Thu Dec  5 16:50:28 2002
+++ linux-2.4/arch/mips/mm/tlb-r4k.c	Tue Dec 10 22:14:30 2002
@@ -210,8 +210,14 @@
 	idx = read_c0_index();
 	ptep = pte_offset(pmdp, address);
 	BARRIER;
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+	write_c0_entrylo0(ptep->pte_high);
+	ptep++;
+	write_c0_entrylo1(ptep->pte_high);
+#else
 	write_c0_entrylo0(pte_val(*ptep++) >> 6);
 	write_c0_entrylo1(pte_val(*ptep) >> 6);
+#endif
 	write_c0_entryhi(address | pid);
 	BARRIER;
 	if (idx < 0) {
diff -Naur --exclude=CVS linux-2.4-orig/arch/mips/mm/tlbex-mips32.S linux-2.4/arch/mips/mm/tlbex-mips32.S
--- linux-2.4-orig/arch/mips/mm/tlbex-mips32.S	Wed Dec 31 16:00:00 1969
+++ linux-2.4/arch/mips/mm/tlbex-mips32.S	Tue Dec 10 22:14:30 2002
@@ -0,0 +1,329 @@
+/*
+ * TLB exception handling code for MIPS32 CPUs.
+ *
+ * Copyright (C) 1994, 1995, 1996 by Ralf Baechle and Andreas Busse
+ *
+ * Multi-cpu abstraction and reworking:
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ *
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ * Pete Popov, ppopov@pacbell.net
+ * Added 36 bit phys address support.
+ * Copyright (C) 2002 MontaVista Software, Inc.
+ */
+#include <linux/init.h>
+
+#include <asm/asm.h>
+#include <asm/current.h>
+#include <asm/offset.h>
+#include <asm/cachectl.h>
+#include <asm/fpregdef.h>
+#include <asm/mipsregs.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+
+#define TLB_OPTIMIZE /* If you are paranoid, disable this. */
+
+#ifdef CONFIG_64BIT_PHYS_ADDR
+
+/* We really only support 36 bit physical addresses on MIPS32 */
+#define PTE_L		lw
+#define PTE_S		sw
+#define PTE_SRL		srl
+#define P_MTC0		mtc0
+#define PTE_HALF        4 /* pte_high contains pre-shifted, ready to go entry */
+#define PTE_SIZE        8
+#define PTEP_INDX_MSK	0xff0
+#define PTE_INDX_MSK	0xff8
+#define PTE_INDX_SHIFT 9
+#define CONVERT_PTE(pte)
+#define PTE_MAKEWRITE_HIGH(pte, ptr) \
+	lw	pte, 4(ptr); \
+	ori	pte, (_PAGE_VALID | _PAGE_DIRTY)>>6; \
+	sw	pte, 4(ptr); \
+	lw	pte, 0(ptr);
+
+#define PTE_MAKEVALID_HIGH(pte, ptr) \
+	lw	pte, 4(ptr); \
+	ori	pte, pte, _PAGE_VALID>>6; \
+	sw	pte, 4(ptr); \
+	lw	pte, 0(ptr);
+
+#else
+
+#define PTE_L		lw
+#define PTE_S		sw
+#define PTE_SRL		srl
+#define P_MTC0		mtc0
+#define PTE_HALF        0
+#define PTE_SIZE	4
+#define PTEP_INDX_MSK	0xff8
+#define PTE_INDX_MSK	0xffc
+#define PTE_INDX_SHIFT	10
+#define CONVERT_PTE(pte) srl pte, pte, 6
+#define PTE_MAKEWRITE_HIGH(pte, ptr)
+#define PTE_MAKEVALID_HIGH(pte, ptr)
+
+#endif  /* CONFIG_64BIT_PHYS_ADDR */
+
+	__INIT
+
+#ifdef CONFIG_64BIT_PHYS_ADDR
+#define GET_PTE_OFF(reg)
+#else
+#define GET_PTE_OFF(reg)	srl	reg, reg, 1
+#endif
+
+/*	
+ * These handlers much be written in a relocatable manner
+ * because based upon the cpu type an arbitrary one of the
+ * following pieces of code will be copied to the KSEG0
+ * vector location.
+ */
+	/* TLB refill, EXL == 0, MIPS32 version */
+	.set	noreorder
+	.set	noat
+	LEAF(except_vec0_r4000)
+	.set	mips3
+#ifdef CONFIG_SMP
+	mfc0	k1, CP0_CONTEXT
+	la	k0, pgd_current
+	srl	k1, 23
+	sll	k1, 2				# log2(sizeof(pgd_t)
+	addu	k1, k0, k1
+	lw	k1, (k1)
+#else 
+	lw	k1, pgd_current			# get pgd pointer
+#endif	
+	nop
+	mfc0	k0, CP0_BADVADDR		# Get faulting address
+	srl	k0, k0, PGDIR_SHIFT		# get pgd only bits
+
+	sll	k0, k0, 2
+	addu	k1, k1, k0			# add in pgd offset
+	mfc0	k0, CP0_CONTEXT			# get context reg
+	lw	k1, (k1)
+	GET_PTE_OFF(k0)				# get pte offset
+	and	k0, k0, PTEP_INDX_MSK
+	addu	k1, k1, k0			# add in offset
+
+	PTE_L	k0, PTE_HALF(k1)		# get even pte
+	CONVERT_PTE(k0)
+	P_MTC0	k0, CP0_ENTRYLO0		# load it
+	PTE_L	k1, (PTE_HALF+PTE_SIZE)(k1)	# get odd pte
+	CONVERT_PTE(k1)
+	P_MTC0	k1, CP0_ENTRYLO1		# load it
+	b	1f
+	tlbwr					# write random tlb entry
+1:
+	nop
+	eret					# return from trap
+	END(except_vec0_r4000)
+
+/*
+ * These are here to avoid putting ifdefs in tlb-r4k.c
+ */
+	.set	noreorder
+	.set	noat
+	LEAF(except_vec0_nevada)
+	.set	mips3
+	PANIC("Nevada Exception Vec 0 called")
+	END(except_vec0_nevada)
+
+	.set	noreorder
+	.set	noat
+	LEAF(except_vec0_r4600)
+	.set	mips3
+	PANIC("R4600 Exception Vec 0 called")
+	END(except_vec0_r4600)
+
+	__FINIT
+
+/*
+ * ABUSE of CPP macros 101.
+ *
+ * After this macro runs, the pte faulted on is
+ * in register PTE, a ptr into the table in which
+ * the pte belongs is in PTR.
+ */
+
+#ifdef CONFIG_SMP
+#define GET_PGD(scratch, ptr)        \
+	mfc0    ptr, CP0_CONTEXT;    \
+	la      scratch, pgd_current;\
+	srl     ptr, 23;             \
+	sll     ptr, 2;              \
+	addu    ptr, scratch, ptr;   \
+	lw      ptr, (ptr);          
+#else
+#define GET_PGD(scratch, ptr)    \
+	lw	ptr, pgd_current;
+#endif
+
+#define LOAD_PTE(pte, ptr) \
+	GET_PGD(pte, ptr)          \
+	mfc0	pte, CP0_BADVADDR; \
+	srl	pte, pte, PGDIR_SHIFT; \
+	sll	pte, pte, 2; \
+	addu	ptr, ptr, pte; \
+	mfc0	pte, CP0_BADVADDR; \
+	lw	ptr, (ptr); \
+	srl	pte, pte, PTE_INDX_SHIFT; \
+	and	pte, pte, PTE_INDX_MSK; \
+	addu	ptr, ptr, pte; \
+	PTE_L	pte, (ptr);
+
+	/* This places the even/odd pte pair in the page
+	 * table at PTR into ENTRYLO0 and ENTRYLO1 using
+	 * TMP as a scratch register.
+	 */
+#define PTE_RELOAD(ptr, tmp) \
+	ori	ptr, ptr, PTE_SIZE; \
+	xori	ptr, ptr, PTE_SIZE; \
+	PTE_L	tmp, (PTE_HALF+PTE_SIZE)(ptr); \
+	CONVERT_PTE(tmp); \
+	P_MTC0	tmp, CP0_ENTRYLO1; \
+	PTE_L	ptr, PTE_HALF(ptr); \
+	CONVERT_PTE(ptr); \
+	P_MTC0	ptr, CP0_ENTRYLO0;
+
+#define DO_FAULT(write) \
+	.set	noat; \
+	SAVE_ALL; \
+	mfc0	a2, CP0_BADVADDR; \
+	STI; \
+	.set	at; \
+	move	a0, sp; \
+	jal	do_page_fault; \
+	 li	a1, write; \
+	j	ret_from_exception; \
+	 nop; \
+	.set	noat;
+
+	/* Check is PTE is present, if not then jump to LABEL.
+	 * PTR points to the page table where this PTE is located,
+	 * when the macro is done executing PTE will be restored
+	 * with it's original value.
+	 */
+#define PTE_PRESENT(pte, ptr, label) \
+	andi	pte, pte, (_PAGE_PRESENT | _PAGE_READ); \
+	xori	pte, pte, (_PAGE_PRESENT | _PAGE_READ); \
+	bnez	pte, label; \
+	PTE_L	pte, (ptr);
+
+	/* Make PTE valid, store result in PTR. */
+#define PTE_MAKEVALID(pte, ptr) \
+	ori	pte, pte, (_PAGE_VALID | _PAGE_ACCESSED); \
+	PTE_S	pte, (ptr);
+
+	/* Check if PTE can be written to, if not branch to LABEL.
+	 * Regardless restore PTE with value from PTR when done.
+	 */
+#define PTE_WRITABLE(pte, ptr, label) \
+	andi	pte, pte, (_PAGE_PRESENT | _PAGE_WRITE); \
+	xori	pte, pte, (_PAGE_PRESENT | _PAGE_WRITE); \
+	bnez	pte, label; \
+	PTE_L	pte, (ptr);
+
+	/* Make PTE writable, update software status bits as well,
+	 * then store at PTR.
+	 */
+#define PTE_MAKEWRITE(pte, ptr) \
+	ori	pte, pte, (_PAGE_ACCESSED | _PAGE_MODIFIED | \
+			   _PAGE_VALID | _PAGE_DIRTY); \
+	PTE_S	pte, (ptr);
+
+	.set	noreorder
+
+#define R5K_HAZARD nop
+
+	.align	5
+	NESTED(handle_tlbl, PT_SIZE, sp)
+	.set	noat
+invalid_tlbl:
+#ifdef TLB_OPTIMIZE
+	/* Test present bit in entry. */
+	LOAD_PTE(k0, k1)
+	R5K_HAZARD
+	tlbp
+	PTE_PRESENT(k0, k1, nopage_tlbl)
+	PTE_MAKEVALID_HIGH(k0, k1)
+	PTE_MAKEVALID(k0, k1)
+	PTE_RELOAD(k1, k0)
+	nop
+	b	1f
+	 tlbwi
+1:
+	nop
+	.set	mips3	
+	eret
+	.set	mips0
+#endif
+
+nopage_tlbl:
+	DO_FAULT(0)
+	END(handle_tlbl)
+
+	.align	5
+	NESTED(handle_tlbs, PT_SIZE, sp)
+	.set	noat
+#ifdef TLB_OPTIMIZE
+	.set	mips3
+        li      k0,0
+	LOAD_PTE(k0, k1)
+	R5K_HAZARD
+	tlbp				# find faulting entry
+	PTE_WRITABLE(k0, k1, nopage_tlbs)
+	PTE_MAKEWRITE(k0, k1)
+	PTE_MAKEWRITE_HIGH(k0, k1)
+	PTE_RELOAD(k1, k0)
+	nop
+	b	1f
+	 tlbwi
+1:
+	nop
+	.set	mips3
+	eret
+	.set	mips0
+#endif
+
+nopage_tlbs:
+	DO_FAULT(1)
+	END(handle_tlbs)
+
+	.align	5
+	NESTED(handle_mod, PT_SIZE, sp)
+	.set	noat
+#ifdef TLB_OPTIMIZE
+	.set	mips3
+	LOAD_PTE(k0, k1)
+	R5K_HAZARD
+	tlbp					# find faulting entry
+	andi	k0, k0, _PAGE_WRITE
+	beqz	k0, nowrite_mod
+	PTE_L	k0, (k1)
+
+	/* Present and writable bits set, set accessed and dirty bits. */
+	PTE_MAKEWRITE(k0, k1)
+	PTE_MAKEWRITE_HIGH(k0, k1)
+	/* Now reload the entry into the tlb. */
+	PTE_RELOAD(k1, k0)
+	nop
+	b	1f
+	 tlbwi
+1:
+	nop
+	.set	mips3
+	eret
+	.set	mips0
+#endif
+
+nowrite_mod:
+	DO_FAULT(1)
+	END(handle_mod)
+
diff -Naur --exclude=CVS linux-2.4-orig/include/asm-mips/page.h linux-2.4/include/asm-mips/page.h
--- linux-2.4-orig/include/asm-mips/page.h	Sat Nov 16 21:39:31 2002
+++ linux-2.4/include/asm-mips/page.h	Fri Dec 13 20:19:10 2002
@@ -71,15 +71,22 @@
  * These are used to make use of C type-checking..
  */
 #ifdef CONFIG_64BIT_PHYS_ADDR
-typedef struct { unsigned long long pte; } pte_t;
+  #ifdef CONFIG_CPU_MIPS32
+    typedef struct { unsigned long pte_low, pte_high; } pte_t;
+    #define pte_val(x)    ((x).pte_low | ((unsigned long long)(x).pte_high << 32))
+  #else
+    typedef struct { unsigned long long pte_low; } pte_t;
+    #define pte_val(x)    ((x).pte_low)
+  #endif
 #else
-typedef struct { unsigned long pte; } pte_t;
+typedef struct { unsigned long pte_low; } pte_t;
+#define pte_val(x)    ((x).pte_low)
 #endif
+
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
 
-#define pte_val(x)	((x).pte)
 #define pmd_val(x)	((x).pmd)
 #define pgd_val(x)	((x).pgd)
 #define pgprot_val(x)	((x).pgprot)
diff -Naur --exclude=CVS linux-2.4-orig/include/asm-mips/pgtable-2level.h linux-2.4/include/asm-mips/pgtable-2level.h
--- linux-2.4-orig/include/asm-mips/pgtable-2level.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4/include/asm-mips/pgtable-2level.h	Fri Dec 13 20:19:10 2002
@@ -0,0 +1,62 @@
+#ifndef _MIPS_PGTABLE_2LEVEL_H
+#define _MIPS_PGTABLE_2LEVEL_H
+
+/*
+ * traditional mips two-level paging structure:
+ */
+
+#if defined(CONFIG_64BIT_PHYS_ADDR)
+#define PMD_SHIFT	21
+#define PTRS_PER_PTE	512
+#define PTRS_PER_PMD	1
+#define PTRS_PER_PGD	2048
+#define PGD_ORDER	1
+#else
+#define PMD_SHIFT	22
+#define PTRS_PER_PTE	1024
+#define PTRS_PER_PMD	1
+#define PTRS_PER_PGD	1024
+#define PGD_ORDER	0
+#endif
+
+#if !defined (_LANGUAGE_ASSEMBLY)
+#define pte_ERROR(e) \
+	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, (e).pte_low)
+#define pmd_ERROR(e) \
+	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
+#define pgd_ERROR(e) \
+	printk("%s:%d: bad pgd %p(%016Lx).\n", __FILE__, __LINE__, &(e), pgd_val(e))
+
+static inline int pte_none(pte_t pte)    { return !(pte.pte_low); }
+
+/* Certain architectures need to do special things when pte's
+ * within a page table are directly modified.  Thus, the following
+ * hook is made available.
+ */
+static inline void set_pte(pte_t *ptep, pte_t pteval)
+{
+	*ptep = pteval;
+#if !defined(CONFIG_CPU_R3000) && !defined(CONFIG_CPU_TX39XX)
+	if (pte_val(pteval) & _PAGE_GLOBAL) {
+		pte_t *buddy = ptep_buddy(ptep);
+		/*
+		 * Make sure the buddy is global too (if it's !none,
+		 * it better already be global)
+		 */
+		if (pte_none(*buddy))
+			pte_val(*buddy) = pte_val(*buddy) | _PAGE_GLOBAL;
+	}
+#endif
+}
+
+#ifdef CONFIG_CPU_VR41XX
+#define pte_page(x)  (mem_map+((unsigned long)(((x).pte_low >> (PAGE_SHIFT+2)))))
+#define __mk_pte(page_nr,pgprot) __pte(((page_nr) << (PAGE_SHIFT+2)) | pgprot_val(pgprot))
+#else
+#define pte_page(x)  (mem_map+((unsigned long)(((x).pte_low >> PAGE_SHIFT))))
+#define __mk_pte(page_nr,pgprot) __pte(((page_nr) << PAGE_SHIFT) | pgprot_val(pgprot))
+#endif
+
+#endif
+
+#endif /* _MIPS_PGTABLE_2LEVEL_H */
diff -Naur --exclude=CVS linux-2.4-orig/include/asm-mips/pgtable-3level.h linux-2.4/include/asm-mips/pgtable-3level.h
--- linux-2.4-orig/include/asm-mips/pgtable-3level.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4/include/asm-mips/pgtable-3level.h	Tue Dec 10 22:14:30 2002
@@ -0,0 +1,63 @@
+#ifndef _MIPS_PGTABLE_3LEVEL_H
+#define _MIPS_PGTABLE_3LEVEL_H
+
+/*
+ * Not really a 3 level page table but we follow most of the x86 PAE code.
+ */
+
+#define PMD_SHIFT	21
+#define PTRS_PER_PTE	512
+#define PTRS_PER_PMD	1
+#define PTRS_PER_PGD	2048
+#define PGD_ORDER	1
+
+#if !defined (_LANGUAGE_ASSEMBLY)
+#define pte_ERROR(e) \
+	printk("%s:%d: bad pte %p(%08lx%08lx).\n", __FILE__, __LINE__, &(e), (e).pte_high, (e).pte_low)
+#define pmd_ERROR(e) \
+	printk("%s:%d: bad pmd %p(%016Lx).\n", __FILE__, __LINE__, &(e), pmd_val(e))
+#define pgd_ERROR(e) \
+	printk("%s:%d: bad pgd %p(%016Lx).\n", __FILE__, __LINE__, &(e), pgd_val(e))
+
+/*
+ * MIPS32 Note
+ * pte_low contains the 12 low bits only.  This includes the 6 lsb bits
+ * which contain software control bits, and the next 6 attribute bits 
+ * which are actually written in the entrylo[0,1] registers (G,V,D,Cache Mask).
+ * pte_high contains the 36 bit physical address and the 6 hardware 
+ * attribute bits (G,V,D, Cache Mask). The entry is already fully setup
+ * so in the tlb refill handler we do not need to shift right 6.
+ */
+
+/* Rules for using set_pte: the pte being assigned *must* be
+ * either not present or in a state where the hardware will
+ * not attempt to update the pte.  In places where this is
+ * not possible, use pte_get_and_clear to obtain the old pte
+ * value and then use set_pte to update it.  -ben
+ */
+static inline void set_pte(pte_t *ptep, pte_t pte)
+{
+	ptep->pte_high = (pte.pte_high & ~0x3f) | ((pte.pte_low>>6) & 0x3f);
+	ptep->pte_low = pte.pte_low;
+}
+
+static inline int pte_same(pte_t a, pte_t b)
+{
+	return a.pte_low == b.pte_low && a.pte_high == b.pte_high;
+}
+
+#define pte_page(x)    (mem_map+(((x).pte_high >> 6)))
+#define pte_none(x)    (!(x).pte_low && !(x).pte_high)
+
+static inline pte_t 
+__mk_pte(unsigned long page_nr, pgprot_t pgprot)
+{
+	pte_t pte;
+
+	pte.pte_high = (page_nr << 6) | (pgprot_val(pgprot) >> 6);
+	pte.pte_low = pgprot_val(pgprot);
+	return pte;
+}
+#endif
+
+#endif /* _MIPS_PGTABLE_3LEVEL_H */
diff -Naur --exclude=CVS linux-2.4-orig/include/asm-mips/pgtable.h linux-2.4/include/asm-mips/pgtable.h
--- linux-2.4-orig/include/asm-mips/pgtable.h	Sat Nov 16 21:39:31 2002
+++ linux-2.4/include/asm-mips/pgtable.h	Fri Dec 13 20:19:10 2002
@@ -13,6 +13,8 @@
 #include <asm/addrspace.h>
 #include <asm/page.h>
 
+#ifndef _LANGUAGE_ASSEMBLY
+
 #include <linux/linkage.h>
 #include <asm/cachectl.h>
 #include <asm/fixmap.h>
@@ -89,11 +91,8 @@
  */
 
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
-#ifdef CONFIG_64BIT_PHYS_ADDR
-#define PMD_SHIFT	21
-#else
-#define PMD_SHIFT	22
-#endif
+#endif /* !defined (_LANGUAGE_ASSEMBLY) */
+
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 
@@ -102,22 +101,6 @@
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-/*
- * Entries per page directory level: we use two-level, so
- * we don't really have any PMD directory physically.
- */
-#ifdef CONFIG_64BIT_PHYS_ADDR
-#define PTRS_PER_PTE	512
-#define PTRS_PER_PMD	1
-#define PTRS_PER_PGD	2048
-#define PGD_ORDER	1
-#else
-#define PTRS_PER_PTE	1024
-#define PTRS_PER_PMD	1
-#define PTRS_PER_PGD	1024
-#define PGD_ORDER	0
-#endif
-
 #define USER_PTRS_PER_PGD	(0x80000000UL/PGDIR_SIZE)
 #define FIRST_USER_PGD_NR	0
 
@@ -169,17 +152,13 @@
 #define __S110	PAGE_SHARED
 #define __S111	PAGE_SHARED
 
-#ifdef CONFIG_64BIT_PHYS_ADDR
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %016Lx.\n", __FILE__, __LINE__, pte_val(e))
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+#include <asm/pgtable-3level.h>
 #else
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
+#include <asm/pgtable-2level.h>
 #endif
-#define pmd_ERROR(e) \
-	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
-#define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
+
+#if !defined (_LANGUAGE_ASSEMBLY)
 
 extern unsigned long empty_zero_page;
 extern unsigned long zero_page_mask;
@@ -205,40 +184,6 @@
 	pmd_val(*pmdp) = (((unsigned long) ptep) & PAGE_MASK);
 }
 
-static inline int pte_none(pte_t pte)    { return !(pte_val(pte) & ~_PAGE_GLOBAL); }
-static inline int pte_present(pte_t pte) { return pte_val(pte) & _PAGE_PRESENT; }
-
-/* Certain architectures need to do special things when pte's
- * within a page table are directly modified.  Thus, the following
- * hook is made available.
- */
-static inline void set_pte(pte_t *ptep, pte_t pteval)
-{
-	*ptep = pteval;
-#if !defined(CONFIG_CPU_R3000) && !defined(CONFIG_CPU_TX39XX)
-	if (pte_val(pteval) & _PAGE_GLOBAL) {
-		pte_t *buddy = ptep_buddy(ptep);
-		/*
-		 * Make sure the buddy is global too (if it's !none,
-		 * it better already be global)
-		 */
-		if (pte_none(*buddy))
-			pte_val(*buddy) = pte_val(*buddy) | _PAGE_GLOBAL;
-	}
-#endif
-}
-
-static inline void pte_clear(pte_t *ptep)
-{
-#if !defined(CONFIG_CPU_R3000) && !defined(CONFIG_CPU_TX39XX)
-	/* Preserve global status for the pair */
-	if (pte_val(*ptep_buddy(ptep)) & _PAGE_GLOBAL)
-		set_pte(ptep, __pte(_PAGE_GLOBAL));
-	else
-#endif
-		set_pte(ptep, __pte(0));
-}
-
 /*
  * (pmds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
@@ -281,69 +226,70 @@
 static inline void pgd_clear(pgd_t *pgdp)	{ }
 
 /*
- * Permanent address of a page.  Obviously must never be called on a highmem
- * page.
- */
-#ifdef CONFIG_CPU_VR41XX
-#define pte_page(x)             (mem_map+(unsigned long)((pte_val(x) >> (PAGE_SHIFT + 2))))
-#else
-#define pte_page(x)		(mem_map+(unsigned long)((pte_val(x) >> PAGE_SHIFT)))
-#endif
-
-/*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
-static inline int pte_read(pte_t pte)	{ return pte_val(pte) & _PAGE_READ; }
-static inline int pte_write(pte_t pte)	{ return pte_val(pte) & _PAGE_WRITE; }
-static inline int pte_dirty(pte_t pte)	{ return pte_val(pte) & _PAGE_MODIFIED; }
-static inline int pte_young(pte_t pte)	{ return pte_val(pte) & _PAGE_ACCESSED; }
+
+static inline int pte_present(pte_t pte) { return (pte.pte_low) & _PAGE_PRESENT; }
+
+static inline int pte_read(pte_t pte)	{ return (pte).pte_low & _PAGE_READ; }
+static inline int pte_write(pte_t pte)	{ return (pte).pte_low & _PAGE_WRITE; }
+static inline int pte_dirty(pte_t pte)	{ return (pte).pte_low & _PAGE_MODIFIED; }
+static inline int pte_young(pte_t pte)	{ return (pte).pte_low & _PAGE_ACCESSED; }
+
+static inline void pte_clear(pte_t *ptep)
+{
+	set_pte(ptep, __pte(0));
+}
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	pte_val(pte) &= ~(_PAGE_WRITE | _PAGE_SILENT_WRITE);
+	(pte).pte_low &= ~(_PAGE_WRITE | _PAGE_SILENT_WRITE);
 	return pte;
 }
 
 static inline pte_t pte_rdprotect(pte_t pte)
 {
-	pte_val(pte) &= ~(_PAGE_READ | _PAGE_SILENT_READ);
+	(pte).pte_low &= ~(_PAGE_READ | _PAGE_SILENT_READ);
 	return pte;
 }
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	pte_val(pte) &= ~(_PAGE_MODIFIED|_PAGE_SILENT_WRITE);
+	(pte).pte_low &= ~(_PAGE_MODIFIED|_PAGE_SILENT_WRITE);
 	return pte;
 }
 
 static inline pte_t pte_mkold(pte_t pte)
 {
-	pte_val(pte) &= ~(_PAGE_ACCESSED|_PAGE_SILENT_READ);
+	(pte).pte_low &= ~(_PAGE_ACCESSED|_PAGE_SILENT_READ);
 	return pte;
 }
 
 static inline pte_t pte_mkwrite(pte_t pte)
 {
-	pte_val(pte) |= _PAGE_WRITE;
-	if (pte_val(pte) & _PAGE_MODIFIED)
-		pte_val(pte) |= _PAGE_SILENT_WRITE;
+	(pte).pte_low |= _PAGE_WRITE;
+	if ((pte).pte_low & _PAGE_MODIFIED) {
+		(pte).pte_low |= _PAGE_SILENT_WRITE;
+	}
 	return pte;
 }
 
 static inline pte_t pte_mkread(pte_t pte)
 {
-	pte_val(pte) |= _PAGE_READ;
-	if (pte_val(pte) & _PAGE_ACCESSED)
-		pte_val(pte) |= _PAGE_SILENT_READ;
+	(pte).pte_low |= _PAGE_READ;
+	if ((pte).pte_low & _PAGE_ACCESSED) {
+		(pte).pte_low |= _PAGE_SILENT_READ;
+	}
 	return pte;
 }
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	pte_val(pte) |= _PAGE_MODIFIED;
-	if (pte_val(pte) & _PAGE_WRITE)
-		pte_val(pte) |= _PAGE_SILENT_WRITE;
+	(pte).pte_low |= _PAGE_MODIFIED;
+	if ((pte).pte_low & _PAGE_WRITE) {
+		(pte).pte_low |= _PAGE_SILENT_WRITE;
+	}
 	return pte;
 }
 
@@ -366,9 +312,9 @@
 
 static inline pte_t pte_mkyoung(pte_t pte)
 {
-	pte_val(pte) |= _PAGE_ACCESSED;
-	if (pte_val(pte) & _PAGE_READ)
-		pte_val(pte) |= _PAGE_SILENT_READ;
+	(pte).pte_low |= _PAGE_ACCESSED;
+	if ((pte).pte_low & _PAGE_READ)
+		(pte).pte_low |= _PAGE_SILENT_READ;
 	return pte;
 }
 
@@ -376,43 +322,24 @@
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  */
-
-#ifdef CONFIG_CPU_VR41XX
-#define mk_pte(page, pgprot)                                            \
-({                                                                      \
-        pte_t   __pte;                                                  \
-                                                                        \
-        pte_val(__pte) = ((phys_t)(page - mem_map) << (PAGE_SHIFT + 2)) | \
-                         pgprot_val(pgprot);                            \
-                                                                        \
-        __pte;                                                          \
-})
-#else
-#define mk_pte(page, pgprot)						\
-({									\
-	pte_t   __pte;							\
-									\
-	pte_val(__pte) = ((phys_t)(page - mem_map) << PAGE_SHIFT) | \
-	                 pgprot_val(pgprot);				\
-									\
-	__pte;								\
-})
-#endif
-
-static inline pte_t mk_pte_phys(phys_t physpage, pgprot_t pgprot)
-{
-#ifdef CONFIG_CPU_VR41XX
-        return __pte((physpage << 2) | pgprot_val(pgprot));
-#else
-	return __pte(physpage | pgprot_val(pgprot));
-#endif
-}
+#define mk_pte(page, pgprot) __mk_pte((page) - mem_map, (pgprot))
+#define mk_pte_phys(physpage, pgprot)	__mk_pte((physpage) >> PAGE_SHIFT, pgprot)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
+	pte.pte_low &= _PAGE_CHG_MASK;
+	pte.pte_low |= pgprot_val(newprot);
+	return pte;
 }
 
+/*
+ * (pmds are folded into pgds so this doesnt get actually called,
+ * but the define is needed for a generic inline function.)
+ */
+#define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
+#define set_pgd(pgdptr, pgdval) (*(pgdptr) = pgdval)
+
+
 #define page_pte(page) page_pte_prot(page, __pgprot(0))
 
 #define __pgd_offset(address)	pgd_index(address)
@@ -464,7 +391,7 @@
 #define SWP_ENTRY(type,offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
 #endif
 
-#define pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define pte_to_swp_entry(pte)	((swp_entry_t) { (pte).pte_low })
 #define swp_entry_to_pte(x)	((pte_t) { (x).val })
 

@@ -474,6 +401,8 @@
 
 #include <asm-generic/pgtable.h>
 
+#endif /* !defined (_LANGUAGE_ASSEMBLY) */
+
 /*
  * We provide our own get_unmapped area to cope with the virtual aliasing
  * constraints placed on us by the cache architecture.
diff -Naur --exclude=CVS linux-2.4-orig/include/linux/mm.h linux-2.4/include/linux/mm.h
--- linux-2.4-orig/include/linux/mm.h	Sat Nov 16 21:39:31 2002
+++ linux-2.4/include/linux/mm.h	Fri Dec 13 20:19:10 2002
@@ -473,7 +473,7 @@
 
 extern void zap_page_range(struct mm_struct *mm, unsigned long address, unsigned long size);
 extern int copy_page_range(struct mm_struct *dst, struct mm_struct *src, struct vm_area_struct *vma);
-extern int remap_page_range(unsigned long from, unsigned long to, unsigned long size, pgprot_t prot);
+extern int remap_page_range(unsigned long from, phys_t to, unsigned long size, pgprot_t prot);
 extern int zeromap_page_range(unsigned long from, unsigned long size, pgprot_t prot);
 
 extern int vmtruncate(struct inode * inode, loff_t offset);
diff -Naur --exclude=CVS linux-2.4-orig/mm/memory.c linux-2.4/mm/memory.c
--- linux-2.4-orig/mm/memory.c	Wed Nov 13 15:08:45 2002
+++ linux-2.4/mm/memory.c	Fri Dec 13 20:15:39 2002
@@ -824,7 +824,7 @@
  * in null mappings (currently treated as "copy-on-access")
  */
 static inline void remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long phys_addr, pgprot_t prot)
+	phys_t phys_addr, pgprot_t prot)
 {
 	unsigned long end;
 
@@ -848,7 +848,7 @@
 }
 
 static inline int remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long phys_addr, pgprot_t prot)
+	phys_t phys_addr, pgprot_t prot)
 {
 	unsigned long end;
 
@@ -868,8 +868,9 @@
 	return 0;
 }
 
+extern phys_t (*fixup_bigphys_addr)(phys_t phys_addr, phys_t size);
 /*  Note: this is only safe if the mm semaphore is held when called. */
-int remap_page_range(unsigned long from, unsigned long phys_addr, unsigned long size, pgprot_t prot)
+int remap_page_range(unsigned long from, phys_t phys_addr, unsigned long size, pgprot_t prot)
 {
 	int error = 0;
 	pgd_t * dir;
@@ -877,6 +878,7 @@
 	unsigned long end = from + size;
 	struct mm_struct *mm = current->mm;
 
+	phys_addr = fixup_bigphys_addr(phys_addr, size);
 	phys_addr -= from;
 	dir = pgd_offset(mm, from);
 	flush_cache_range(mm, beg, end);
