Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Oct 2004 06:31:43 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:32520
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8224836AbUJJFbf>;
	Sun, 10 Oct 2004 06:31:35 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9A5VTu00959;
	Sat, 9 Oct 2004 22:31:29 -0700
Message-ID: <4168C92B.10700@embeddedalley.com>
Date: Sat, 09 Oct 2004 22:31:23 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Subject: PATCH
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ralf,

Here is the 2.6 36 bit I/O support patch. We beat up on it quite a bit 
and it seems solid on the Au1x (Db1500 board).

Pete

Index: arch/mips/au1000/common/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/common/setup.c,v
retrieving revision 1.17
diff -u -r1.17 setup.c
--- arch/mips/au1000/common/setup.c	14 Sep 2004 06:38:46 -0000	1.17
+++ arch/mips/au1000/common/setup.c	19 Sep 2004 22:51:20 -0000
@@ -56,10 +56,6 @@
  extern void au1x_time_init(void);
  extern void (*board_timer_setup)(struct irqaction *irq);
  extern void au1x_timer_setup(struct irqaction *irq);
-#if defined(CONFIG_64BIT_PHYS_ADDR) && (defined(CONFIG_SOC_AU1500) || 
defined(CONFIG_SOC_AU1550))
-extern phys_t (*fixup_bigphys_addr)(phys_t phys_addr, phys_t size);
-static phys_t au1500_fixup_bigphys_addr(phys_t phys_addr, phys_t size);
-#endif
  extern void au1xxx_time_init(void);
  extern void au1xxx_timer_setup(struct irqaction *irq);
  extern void set_cpuspec(void);
@@ -147,9 +143,6 @@
  	_machine_power_off = au1000_power_off;
  	board_time_init = au1xxx_time_init;
  	board_timer_setup = au1xxx_timer_setup;
-#if defined(CONFIG_64BIT_PHYS_ADDR) && (defined(CONFIG_SOC_AU1500) || 
defined(CONFIG_SOC_AU1550))
-	fixup_bigphys_addr = au1500_fixup_bigphys_addr;
-#endif

  	/* IO/MEM resources. */
  	set_io_port_base(0);
@@ -200,7 +193,7 @@

  #if defined(CONFIG_64BIT_PHYS_ADDR) && (defined(CONFIG_SOC_AU1500) || 
defined(CONFIG_SOC_AU1550))
  /* This routine should be valid for all Au1500 based boards */
-static phys_t au1500_fixup_bigphys_addr(phys_t phys_addr, phys_t size)
+phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
  {
  	u32 pci_start = (u32)Au1500_PCI_MEM_START;
  	u32 pci_end = (u32)Au1500_PCI_MEM_END;
Index: arch/mips/mm/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/Makefile,v
retrieving revision 1.68
diff -u -r1.68 Makefile
--- arch/mips/mm/Makefile	20 Jun 2004 23:52:17 -0000	1.68
+++ arch/mips/mm/Makefile	19 Sep 2004 22:51:21 -0000
@@ -41,10 +41,11 @@
  obj-$(CONFIG_CPU_RM7000)	+= tlbex32-r4k.o
  obj-$(CONFIG_CPU_RM9000)	+= tlbex32-r4k.o
  obj-$(CONFIG_CPU_R10000)	+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_MIPS32)	+= tlbex32-r4k.o
+obj-$(CONFIG_CPU_MIPS32)	+= tlbex32-mips32.o
  obj-$(CONFIG_CPU_MIPS64)	+= tlbex32-r4k.o
  obj-$(CONFIG_CPU_SB1)		+= tlbex32-r4k.o
  obj-$(CONFIG_CPU_TX39XX)	+= tlbex32-r3k.o
+obj-$(CONFIG_64BIT_PHYS_ADDR)	+= remap.o
  endif
  ifdef CONFIG_MIPS64
  obj-$(CONFIG_CPU_R4300)		+= tlb64-glue-r4k.o tlbex64-r4k.o
Index: arch/mips/mm/ioremap.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/ioremap.c,v
retrieving revision 1.19
diff -u -r1.19 ioremap.c
--- arch/mips/mm/ioremap.c	19 Apr 2004 16:36:35 -0000	1.19
+++ arch/mips/mm/ioremap.c	19 Sep 2004 22:51:21 -0000
@@ -97,6 +97,15 @@
  }

  /*
+ * Allow physical addresses to be fixed up to help 36 bit peripherals.
+ */
+phys_t __attribute__ ((weak))
+fixup_bigphys_addr(phys_t phys_addr, phys_t size)
+{
+	return phys_addr;
+}
+
+/*
   * Generic mapping function (not visible outside):
   */

@@ -110,7 +119,7 @@
   * caller shouldn't need to know that small detail.
   */

-#define IS_LOW512(addr) (!((phys_t)(addr) & ~0x1fffffffUL))
+#define IS_LOW512(addr) (!((phys_t)(addr) & (phys_t) ~0x1fffffffULL))

  void * __ioremap(phys_t phys_addr, phys_t size, unsigned long flags)
  {
@@ -119,6 +128,8 @@
  	phys_t last_addr;
  	void * addr;

+	phys_addr = fixup_bigphys_addr(phys_addr, size);
+
  	/* Don't allow wraparound or zero size */
  	last_addr = phys_addr + size - 1;
  	if (!size || last_addr < phys_addr)
@@ -190,3 +201,4 @@

  EXPORT_SYMBOL(__ioremap);
  EXPORT_SYMBOL(__iounmap);
+EXPORT_SYMBOL(fixup_bigphys_addr);
Index: arch/mips/mm/remap.c
===================================================================
RCS file: arch/mips/mm/remap.c
diff -N arch/mips/mm/remap.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ arch/mips/mm/remap.c	19 Sep 2004 22:51:21 -0000
@@ -0,0 +1,115 @@
+/*
+ *  arch/mips/mm/remap.c
+ *
+ *  A copy of mm/memory.c, with mods for 64 bit physical I/O addresses on
+ *  32 bit native word platforms.
+ *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ */
+
+
+#include <linux/kernel_stat.h>
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <linux/mman.h>
+#include <linux/swap.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <linux/rmap.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <asm/pgalloc.h>
+#include <asm/uaccess.h>
+#include <asm/tlb.h>
+#include <asm/tlbflush.h>
+#include <asm/pgtable.h>
+
+#include <linux/swapops.h>
+#include <linux/elf.h>
+
+
+/*
+ * maps a range of physical memory into the requested pages. the old
+ * mappings are removed. any references to nonexistent pages results
+ * in null mappings (currently treated as "copy-on-access")
+ */
+static inline void remap_pte_range(pte_t * pte, unsigned long address, 
unsigned long size,
+	phys_t phys_addr, pgprot_t prot)
+{
+	unsigned long end;
+	unsigned long pfn;
+
+	address &= ~PMD_MASK;
+	end = address + size;
+	if (end > PMD_SIZE)
+		end = PMD_SIZE;
+	pfn = phys_addr >> PAGE_SHIFT;
+	do {
+		BUG_ON(!pte_none(*pte));
+		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
+ 			set_pte(pte, pfn_pte(pfn, prot));
+		address += PAGE_SIZE;
+		pfn++;
+		pte++;
+	} while (address && (address < end));
+}
+
+static inline int remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, 
unsigned long address, unsigned long size,
+	phys_t phys_addr, pgprot_t prot)
+{
+	unsigned long base, end;
+
+	base = address & PGDIR_MASK;
+	address &= ~PGDIR_MASK;
+	end = address + size;
+	if (end > PGDIR_SIZE)
+		end = PGDIR_SIZE;
+	phys_addr -= address;
+	do {
+		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
+		if (!pte)
+			return -ENOMEM;
+		remap_pte_range(pte, base + address, end - address, address + 
phys_addr, prot);
+		pte_unmap(pte);
+		address = (address + PMD_SIZE) & PMD_MASK;
+		pmd++;
+	} while (address && (address < end));
+	return 0;
+}
+
+/*  Note: this is only safe if the mm semaphore is held when called. */
+int remap_page_range_high(struct vm_area_struct *vma, unsigned long 
from, phys_t phys_addr, unsigned long size, pgprot_t prot)
+{
+	int error = 0;
+	pgd_t * dir;
+	unsigned long beg = from;
+	unsigned long end = from + size;
+	struct mm_struct *mm = vma->vm_mm;
+
+	phys_addr -= from;
+	dir = pgd_offset(mm, from);
+	flush_cache_range(vma, beg, end);
+	if (from >= end)
+		BUG();
+
+	spin_lock(&mm->page_table_lock);
+	do {
+		pmd_t *pmd = pmd_alloc(mm, dir, from);
+		error = -ENOMEM;
+		if (!pmd)
+			break;
+		error = remap_pmd_range(mm, pmd, from, end - from, phys_addr + from, 
prot);
+		if (error)
+			break;
+		from = (from + PGDIR_SIZE) & PGDIR_MASK;
+		dir++;
+	} while (from && (from < end));
+	/*
+	 * Why flush? remap_pte_range has a BUG_ON for !pte_none()
+	 */
+	flush_tlb_range(vma, beg, end);
+	spin_unlock(&mm->page_table_lock);
+	return error;
+}
+
+EXPORT_SYMBOL(remap_page_range_high);
Index: arch/mips/mm/tlb-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlb-r4k.c,v
retrieving revision 1.38
diff -u -r1.38 tlb-r4k.c
--- arch/mips/mm/tlb-r4k.c	19 Mar 2004 04:07:59 -0000	1.38
+++ arch/mips/mm/tlb-r4k.c	19 Sep 2004 22:51:21 -0000
@@ -255,8 +255,14 @@
  	idx = read_c0_index();
  	ptep = pte_offset_map(pmdp, address);

-	write_c0_entrylo0(pte_val(*ptep++) >> 6);
-	write_c0_entrylo1(pte_val(*ptep) >> 6);
+ #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+ 	write_c0_entrylo0(ptep->pte_high);
+ 	ptep++;
+ 	write_c0_entrylo1(ptep->pte_high);
+#else
+  	write_c0_entrylo0(pte_val(*ptep++) >> 6);
+  	write_c0_entrylo1(pte_val(*ptep) >> 6);
+#endif
  	write_c0_entryhi(address | pid);
  	mtc0_tlbw_hazard();
  	if (idx < 0)
Index: arch/mips/mm/tlbex32-mips32.S
===================================================================
RCS file: arch/mips/mm/tlbex32-mips32.S
diff -N arch/mips/mm/tlbex32-mips32.S
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ arch/mips/mm/tlbex32-mips32.S	19 Sep 2004 22:51:21 -0000
@@ -0,0 +1,325 @@
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
+#include <asm/asm.h>
+#include <asm/cachectl.h>
+#include <asm/fpregdef.h>
+#include <asm/mipsregs.h>
+#include <asm/page.h>
+#include <asm/pgtable-bits.h>
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
+#define PTE_HALF        4 /* pte_high contains pre-shifted, ready to go 
entry */
+#define PTE_SIZE        8
+#define PTEP_INDX_MSK	0xff0
+#define PTE_INDX_MSK	0xff8
+#define PTE_INDX_SHIFT 9
+#define CONVERT_PTE(pte)
+#define PTE_MAKEWRITE_HIGH(pte, ptr) \
+	lw	pte, 4(ptr); \
+	ori	pte, (_PAGE_VALID | _PAGE_DIRTY); \
+	sw	pte, 4(ptr); \
+	lw	pte, 0(ptr);
+
+#define PTE_MAKEVALID_HIGH(pte, ptr) \
+	lw	pte, 4(ptr); \
+	ori	pte, pte, _PAGE_VALID; \
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
+	srl	k0, k0, _PGDIR_SHIFT		# get pgd only bits
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
+	srl	pte, pte, _PGDIR_SHIFT; \
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
Index: include/asm-mips/addrspace.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/addrspace.h,v
retrieving revision 1.13
diff -u -r1.13 addrspace.h
--- include/asm-mips/addrspace.h	30 Nov 2003 01:52:25 -0000	1.13
+++ include/asm-mips/addrspace.h	19 Sep 2004 22:51:28 -0000
@@ -80,7 +80,11 @@
  #define XKSSEG			0x4000000000000000
  #define XKPHYS			0x8000000000000000
  #define XKSEG			0xc000000000000000
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+#define CKSEG0			0x80000000
+#else
  #define CKSEG0			0xffffffff80000000
+#endif
  #define CKSEG1			0xffffffffa0000000
  #define CKSSEG			0xffffffffc0000000
  #define CKSEG3			0xffffffffe0000000
Index: include/asm-mips/io.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/io.h,v
retrieving revision 1.72
diff -u -r1.72 io.h
--- include/asm-mips/io.h	19 Aug 2004 15:27:41 -0000	1.72
+++ include/asm-mips/io.h	19 Sep 2004 22:51:29 -0000
@@ -171,7 +171,7 @@
  extern void * __ioremap(phys_t offset, phys_t size, unsigned long flags);
  extern void __iounmap(void *addr);

-static inline void * __ioremap_mode(unsigned long offset, unsigned long 
size,
+static inline void * __ioremap_mode(phys_t offset, unsigned long size,
  	unsigned long flags)
  {
  	if (cpu_has_64bit_addresses) {
Index: include/asm-mips/page.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/page.h,v
retrieving revision 1.44
diff -u -r1.44 page.h
--- include/asm-mips/page.h	20 Aug 2004 12:02:18 -0000	1.44
+++ include/asm-mips/page.h	19 Sep 2004 22:51:29 -0000
@@ -32,7 +32,7 @@
  #ifdef CONFIG_PAGE_SIZE_64KB
  #define PAGE_SHIFT	16
  #endif
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#define PAGE_SIZE	(1L << PAGE_SHIFT)
  #define PAGE_MASK	(~(PAGE_SIZE-1))

  #ifdef __KERNEL__
@@ -75,15 +75,22 @@
   * These are used to make use of C type-checking..
   */
  #ifdef CONFIG_64BIT_PHYS_ADDR
-typedef struct { unsigned long long pte; } pte_t;
+  #ifdef CONFIG_CPU_MIPS32
+    typedef struct { unsigned long pte_low, pte_high; } pte_t;
+    #define pte_val(x)    ((x).pte_low | ((unsigned long 
long)(x).pte_high << 32))
+  #else
+     typedef struct { unsigned long long pte; } pte_t;
+     #define pte_val(x)	((x).pte)
+  #endif
  #else
  typedef struct { unsigned long pte; } pte_t;
+#define pte_val(x)	((x).pte)
  #endif
+
  typedef struct { unsigned long pmd; } pmd_t;
  typedef struct { unsigned long pgd; } pgd_t;
  typedef struct { unsigned long pgprot; } pgprot_t;

-#define pte_val(x)	((x).pte)
  #define pmd_val(x)	((x).pmd)
  #define pgd_val(x)	((x).pgd)
  #define pgprot_val(x)	((x).pgprot)
Index: include/asm-mips/pgtable-32.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/pgtable-32.h,v
retrieving revision 1.11
diff -u -r1.11 pgtable-32.h
--- include/asm-mips/pgtable-32.h	26 Jun 2004 15:15:24 -0000	1.11
+++ include/asm-mips/pgtable-32.h	19 Sep 2004 22:51:29 -0000
@@ -130,8 +130,21 @@
  static inline int pgd_present(pgd_t pgd)	{ return 1; }
  static inline void pgd_clear(pgd_t *pgdp)	{ }

+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_MIPS32)
  #define pte_page(x)		pfn_to_page(pte_pfn(x))
+#define pte_pfn(x)		((unsigned long)((x).pte_high >> 6))
+static inline pte_t
+pfn_pte(unsigned long pfn, pgprot_t prot)
+{
+	pte_t pte;
+	pte.pte_high = (pfn << 6) | (pgprot_val(prot) & 0x3f);
+	pte.pte_low = pgprot_val(prot);
+	return pte;
+}
+
+#else

+#define pte_page(x)		pfn_to_page(pte_pfn(x))

  #ifdef CONFIG_CPU_VR41XX
  #define pte_pfn(x)		((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
@@ -140,6 +153,7 @@
  #define pte_pfn(x)		((unsigned long)((x).pte >> PAGE_SHIFT))
  #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
  #endif
+#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_MIPS32) */

  #define __pgd_offset(address)	pgd_index(address)
  #define __pmd_offset(address)	(((address) >> PMD_SHIFT) & 
(PTRS_PER_PMD-1))
@@ -207,11 +221,19 @@
   */
  #define PTE_FILE_MAX_BITS	27

+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_MIPS32)
+	/* fixme */
+#define pte_to_pgoff(_pte) (((_pte).pte_high >> 6) + ((_pte).pte_high & 
0x3f))
+#define pgoff_to_pte(off) \
+ 	((pte_t){(((off) & 0x3f) + ((off) << 6) + _PAGE_FILE)})
+
+#else
  #define pte_to_pgoff(_pte) \
  	((((_pte).pte >> 3) & 0x1f ) + (((_pte).pte >> 9) << 6 ))

  #define pgoff_to_pte(off) \
  	((pte_t) { (((off) & 0x1f) << 3) + (((off) >> 6) << 9) + _PAGE_FILE })
+#endif

  #endif

Index: include/asm-mips/pgtable-bits.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/pgtable-bits.h,v
retrieving revision 1.9
diff -u -r1.9 pgtable-bits.h
--- include/asm-mips/pgtable-bits.h	24 Jun 2004 20:31:11 -0000	1.9
+++ include/asm-mips/pgtable-bits.h	19 Sep 2004 22:51:29 -0000
@@ -33,6 +33,31 @@
   * unpredictable things.  The code (when it is written) to deal with
   * this problem will be in the update_mmu_cache() code for the r4k.
   */
+#if defined(CONFIG_CPU_MIPS32) && defined(CONFIG_64BIT_PHYS_ADDR)
+
+#define _PAGE_PRESENT               (1<<6)  /* implemented in software */
+#define _PAGE_READ                  (1<<7)  /* implemented in software */
+#define _PAGE_WRITE                 (1<<8)  /* implemented in software */
+#define _PAGE_ACCESSED              (1<<9)  /* implemented in software */
+#define _PAGE_MODIFIED              (1<<10) /* implemented in software */
+#define _PAGE_FILE                  (1<<10)  /* set:pagecache unset:swap */
+
+#define _PAGE_R4KBUG                (1<<0)  /* workaround for r4k bug  */
+#define _PAGE_GLOBAL                (1<<0)
+#define _PAGE_VALID                 (1<<1)
+#define _PAGE_SILENT_READ           (1<<1)  /* synonym                 */
+#define _PAGE_DIRTY                 (1<<2)  /* The MIPS dirty bit      */
+#define _PAGE_SILENT_WRITE          (1<<2)
+#define _CACHE_MASK                 (7<<3)
+
+/* MIPS32 defines only values 2 and 3. The rest are implementation
+ * dependent.
+ */
+#define _CACHE_UNCACHED             (2<<3)
+#define _CACHE_CACHABLE_NONCOHERENT (3<<3)
+
+#else
+
  #define _PAGE_PRESENT               (1<<0)  /* implemented in software */
  #define _PAGE_READ                  (1<<1)  /* implemented in software */
  #define _PAGE_WRITE                 (1<<2)  /* implemented in software */
@@ -97,6 +122,7 @@

  #endif
  #endif
+#endif /* defined(CONFIG_CPU_MIPS32) && defined(CONFIG_64BIT_PHYS_ADDR) */

  #define __READABLE	(_PAGE_READ | _PAGE_SILENT_READ | _PAGE_ACCESSED)
  #define __WRITEABLE	(_PAGE_WRITE | _PAGE_SILENT_WRITE | _PAGE_MODIFIED)
@@ -113,6 +139,10 @@
  #define PAGE_CACHABLE_DEFAULT	_CACHE_CACHABLE_COW
  #endif

+#if defined(CONFIG_CPU_MIPS32) && defined(CONFIG_64BIT_PHYS_ADDR)
+#define CONF_CM_DEFAULT		(PAGE_CACHABLE_DEFAULT >> 3)
+#else
  #define CONF_CM_DEFAULT		(PAGE_CACHABLE_DEFAULT >> 9)
+#endif

  #endif /* _ASM_PGTABLE_BITS_H */
Index: include/asm-mips/pgtable.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/pgtable.h,v
retrieving revision 1.97
diff -u -r1.97 pgtable.h
--- include/asm-mips/pgtable.h	19 Jun 2004 01:39:24 -0000	1.97
+++ include/asm-mips/pgtable.h	19 Sep 2004 22:51:29 -0000
@@ -80,6 +80,34 @@
  #define pte_none(pte)		(!(pte_val(pte) & ~_PAGE_GLOBAL))
  #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)

+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_MIPS32)
+static inline void set_pte(pte_t *ptep, pte_t pte)
+{
+	ptep->pte_high = pte.pte_high;
+	smp_wmb();
+	ptep->pte_low = pte.pte_low;
+	//printk("pte_high %x pte_low %x\n", ptep->pte_high, ptep->pte_low);
+
+	if (pte_val(pte) & _PAGE_GLOBAL) {
+		pte_t *buddy = ptep_buddy(ptep);
+		/*
+		 * Make sure the buddy is global too (if it's !none,
+		 * it better already be global)
+		 */
+		if (pte_none(*buddy))
+			buddy->pte_low |= _PAGE_GLOBAL;
+	}
+}
+
+static inline void pte_clear(pte_t *ptep)
+{
+	/* Preserve global status for the pair */
+	if (pte_val(*ptep_buddy(ptep)) & _PAGE_GLOBAL)
+		set_pte(ptep, __pte(_PAGE_GLOBAL));
+	else
+		set_pte(ptep, __pte(0));
+}
+#else
  /*
   * Certain architectures need to do special things when pte's
   * within a page table are directly modified.  Thus, the following
@@ -111,6 +139,7 @@
  #endif
  		set_pte(ptep, __pte(0));
  }
+#endif

  /*
   * (pmds are folded into pgds so this doesn't get actually called,
@@ -130,6 +159,79 @@
   * Undefined behaviour if not..
   */
  static inline int pte_user(pte_t pte)	{ BUG(); return 0; }
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_MIPS32)
+static inline int pte_read(pte_t pte)	{ return (pte).pte_low & 
_PAGE_READ; }
+static inline int pte_write(pte_t pte)	{ return (pte).pte_low & 
_PAGE_WRITE; }
+static inline int pte_dirty(pte_t pte)	{ return (pte).pte_low & 
_PAGE_MODIFIED; }
+static inline int pte_young(pte_t pte)	{ return (pte).pte_low & 
_PAGE_ACCESSED; }
+static inline int pte_file(pte_t pte)	{ return (pte).pte_low & 
_PAGE_FILE; }
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	(pte).pte_low &= ~(_PAGE_WRITE | _PAGE_SILENT_WRITE);
+	(pte).pte_high &= ~_PAGE_SILENT_WRITE;
+	return pte;
+}
+
+static inline pte_t pte_rdprotect(pte_t pte)
+{
+	(pte).pte_low &= ~(_PAGE_READ | _PAGE_SILENT_READ);
+	(pte).pte_high &= ~_PAGE_SILENT_READ;
+	return pte;
+}
+
+static inline pte_t pte_mkclean(pte_t pte)
+{
+	(pte).pte_low &= ~(_PAGE_MODIFIED|_PAGE_SILENT_WRITE);
+	(pte).pte_high &= ~_PAGE_SILENT_WRITE;
+	return pte;
+}
+
+static inline pte_t pte_mkold(pte_t pte)
+{
+	(pte).pte_low &= ~(_PAGE_ACCESSED|_PAGE_SILENT_READ);
+	(pte).pte_high &= ~_PAGE_SILENT_READ;
+	return pte;
+}
+
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	(pte).pte_low |= _PAGE_WRITE;
+	if ((pte).pte_low & _PAGE_MODIFIED) {
+		(pte).pte_low |= _PAGE_SILENT_WRITE;
+		(pte).pte_high |= _PAGE_SILENT_WRITE;
+	}
+	return pte;
+}
+
+static inline pte_t pte_mkread(pte_t pte)
+{
+	(pte).pte_low |= _PAGE_READ;
+	if ((pte).pte_low & _PAGE_ACCESSED) {
+		(pte).pte_low |= _PAGE_SILENT_READ;
+		(pte).pte_high |= _PAGE_SILENT_READ;
+	}
+	return pte;
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	(pte).pte_low |= _PAGE_MODIFIED;
+	if ((pte).pte_low & _PAGE_WRITE) {
+		(pte).pte_low |= _PAGE_SILENT_WRITE;
+		(pte).pte_high |= _PAGE_SILENT_WRITE;
+	}
+	return pte;
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	(pte).pte_low |= _PAGE_ACCESSED;
+	if ((pte).pte_low & _PAGE_READ)
+		(pte).pte_low |= _PAGE_SILENT_READ;
+		(pte).pte_high |= _PAGE_SILENT_READ;
+	return pte;
+}
+#else
  static inline int pte_read(pte_t pte)	{ return pte_val(pte) & 
_PAGE_READ; }
  static inline int pte_write(pte_t pte)	{ return pte_val(pte) & 
_PAGE_WRITE; }
  static inline int pte_dirty(pte_t pte)	{ return pte_val(pte) & 
_PAGE_MODIFIED; }
@@ -191,6 +293,7 @@
  		pte_val(pte) |= _PAGE_SILENT_READ;
  	return pte;
  }
+#endif

  /*
   * Macro to make mark a page protection value as "uncacheable".  Note
@@ -215,10 +318,20 @@
   */
  #define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))

+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_MIPS32)
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	pte.pte_low &= _PAGE_CHG_MASK;
+	pte.pte_low |= pgprot_val(newprot);
+	pte.pte_high |= pgprot_val(newprot) & 0x3f;
+	return pte;
+}
+#else
  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
  {
  	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
  }
+#endif


  extern void __update_tlb(struct vm_area_struct *vma, unsigned long 
address,
@@ -245,7 +358,27 @@
   */
  #define HAVE_ARCH_UNMAPPED_AREA

+#ifdef CONFIG_64BIT_PHYS_ADDR
+extern phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size);
+
+extern int remap_page_range_high(struct vm_area_struct *vma,
+		unsigned long from,
+		phys_t phys_addr,
+		unsigned long size,
+		pgprot_t prot);
+
+static inline int io_remap_page_range(struct vm_area_struct *vma,
+		unsigned long from,
+		unsigned long phys_addr,
+		unsigned long size,
+		pgprot_t prot)
+{
+	phys_t phys_addr_high = fixup_bigphys_addr(phys_addr, size);
+	return remap_page_range_high(vma, from, phys_addr_high, size, prot);
+}
+#else
  #define io_remap_page_range remap_page_range
+#endif

  /*
   * No page table caches to initialise
