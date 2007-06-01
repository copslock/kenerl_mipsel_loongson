Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2007 16:21:15 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:35822 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021392AbXFAPVL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Jun 2007 16:21:11 +0100
Received: from localhost (p8230-ipad205funabasi.chiba.ocn.ne.jp [222.146.103.230])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DE7C5B775; Sat,  2 Jun 2007 00:21:03 +0900 (JST)
Date:	Sat, 02 Jun 2007 00:21:30 +0900 (JST)
Message-Id: <20070602.002130.41010462.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Unify dump_tlb
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Unify lib-{32,64}/dump_tlb.c into lib/dump_tlb.c and move
lib-32/r3k_dump_tlb.c to lib directory.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/lib-32/Makefile                |   18 ---
 arch/mips/lib-32/dump_tlb.c              |  240 ------------------------------
 arch/mips/lib-64/Makefile                |   18 ---
 arch/mips/lib/Makefile                   |   18 +++
 arch/mips/{lib-64 => lib}/dump_tlb.c     |   56 +++++--
 arch/mips/{lib-32 => lib}/r3k_dump_tlb.c |    0 
 6 files changed, 60 insertions(+), 290 deletions(-)

diff --git a/arch/mips/lib-32/Makefile b/arch/mips/lib-32/Makefile
index 8b94d4c..7bae849 100644
--- a/arch/mips/lib-32/Makefile
+++ b/arch/mips/lib-32/Makefile
@@ -3,21 +3,3 @@
 #
 
 lib-y	+= watch.o
-
-obj-$(CONFIG_CPU_MIPS32)	+= dump_tlb.o
-obj-$(CONFIG_CPU_MIPS64)	+= dump_tlb.o
-obj-$(CONFIG_CPU_NEVADA)	+= dump_tlb.o
-obj-$(CONFIG_CPU_R10000)	+= dump_tlb.o
-obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
-obj-$(CONFIG_CPU_R4300)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R4X00)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R5000)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R5432)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R6000)		+=
-obj-$(CONFIG_CPU_R8000)		+=
-obj-$(CONFIG_CPU_RM7000)	+= dump_tlb.o
-obj-$(CONFIG_CPU_RM9000)	+= dump_tlb.o
-obj-$(CONFIG_CPU_SB1)		+= dump_tlb.o
-obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
-obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
-obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
diff --git a/arch/mips/lib-32/dump_tlb.c b/arch/mips/lib-32/dump_tlb.c
deleted file mode 100644
index 63525ec..0000000
--- a/arch/mips/lib-32/dump_tlb.c
+++ /dev/null
@@ -1,240 +0,0 @@
-/*
- * Dump R4x00 TLB for debugging purposes.
- *
- * Copyright (C) 1994, 1995 by Waldorf Electronics, written by Ralf Baechle.
- * Copyright (C) 1999 by Silicon Graphics, Inc.
- */
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-#include <asm/cachectl.h>
-#include <asm/cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
-
-static inline const char *msk2str(unsigned int mask)
-{
-	switch (mask) {
-	case PM_4K:
-		return "4kb";
-	case PM_16K:
-		return "16kb";
-	case PM_64K:
-		return "64kb";
-	case PM_256K:
-		return "256kb";
-#ifndef CONFIG_CPU_VR41XX
-	case PM_1M:
-		return "1Mb";
-	case PM_4M:
-		return "4Mb";
-	case PM_16M:
-		return "16Mb";
-	case PM_64M:
-		return "64Mb";
-	case PM_256M:
-		return "256Mb";
-#endif
-	}
-}
-
-#define BARRIER()					\
-	__asm__ __volatile__(				\
-		".set\tnoreorder\n\t"			\
-		"nop;nop;nop;nop;nop;nop;nop\n\t"	\
-		".set\treorder");
-
-void dump_tlb(int first, int last)
-{
-	unsigned int pagemask, c0, c1, asid;
-	unsigned long long entrylo0, entrylo1;
-	unsigned long entryhi;
-	int i;
-
-	asid = read_c0_entryhi() & 0xff;
-
-	printk("\n");
-	for (i = first; i <= last; i++) {
-		write_c0_index(i);
-		BARRIER();
-		tlb_read();
-		BARRIER();
-		pagemask = read_c0_pagemask();
-		entryhi = read_c0_entryhi();
-		entrylo0 = read_c0_entrylo0();
-		entrylo1 = read_c0_entrylo1();
-
-		/* Unused entries have a virtual address in KSEG0.  */
-		if ((entryhi & 0xf0000000) != 0x80000000
-		    && (entryhi & 0xff) == asid) {
-			/*
-			 * Only print entries in use
-			 */
-			printk("Index: %2d pgmask=%s ", i, msk2str(pagemask));
-
-			c0 = (entrylo0 >> 3) & 7;
-			c1 = (entrylo1 >> 3) & 7;
-
-			printk("va=%08lx asid=%02lx\n",
-			       (entryhi & 0xffffe000), (entryhi & 0xff));
-			printk("\t\t\t[pa=%08Lx c=%d d=%d v=%d g=%Ld]\n",
-			       (entrylo0 << 6) & PAGE_MASK, c0,
-			       (entrylo0 & 4) ? 1 : 0,
-			       (entrylo0 & 2) ? 1 : 0, (entrylo0 & 1));
-			printk("\t\t\t[pa=%08Lx c=%d d=%d v=%d g=%Ld]\n",
-			       (entrylo1 << 6) & PAGE_MASK, c1,
-			       (entrylo1 & 4) ? 1 : 0,
-			       (entrylo1 & 2) ? 1 : 0, (entrylo1 & 1));
-			printk("\n");
-		}
-	}
-
-	write_c0_entryhi(asid);
-}
-
-void dump_tlb_all(void)
-{
-	dump_tlb(0, current_cpu_data.tlbsize - 1);
-}
-
-void dump_tlb_wired(void)
-{
-	int wired;
-
-	wired = read_c0_wired();
-	printk("Wired: %d", wired);
-	dump_tlb(0, read_c0_wired());
-}
-
-void dump_tlb_addr(unsigned long addr)
-{
-	unsigned int flags, oldpid;
-	int index;
-
-	local_irq_save(flags);
-	oldpid = read_c0_entryhi() & 0xff;
-	BARRIER();
-	write_c0_entryhi((addr & PAGE_MASK) | oldpid);
-	BARRIER();
-	tlb_probe();
-	BARRIER();
-	index = read_c0_index();
-	write_c0_entryhi(oldpid);
-	local_irq_restore(flags);
-
-	if (index < 0) {
-		printk("No entry for address 0x%08lx in TLB\n", addr);
-		return;
-	}
-
-	printk("Entry %d maps address 0x%08lx\n", index, addr);
-	dump_tlb(index, index);
-}
-
-void dump_tlb_nonwired(void)
-{
-	dump_tlb(read_c0_wired(), current_cpu_data.tlbsize - 1);
-}
-
-void dump_list_process(struct task_struct *t, void *address)
-{
-	pgd_t *page_dir, *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte, page;
-	unsigned long addr, val;
-
-	addr = (unsigned long) address;
-
-	printk("Addr                 == %08lx\n", addr);
-	printk("task                 == %8p\n", t);
-	printk("task->mm             == %8p\n", t->mm);
-	//printk("tasks->mm.pgd        == %08x\n", (unsigned int) t->mm->pgd);
-
-	if (addr > KSEG0) {
-		page_dir = pgd_offset_k(0);
-		pgd = pgd_offset_k(addr);
-	} else if (t->mm) {
-		page_dir = pgd_offset(t->mm, 0);
-		pgd = pgd_offset(t->mm, addr);
-	} else {
-		printk("Current thread has no mm\n");
-		return;
-	}
-	printk("page_dir == %08x\n", (unsigned int) page_dir);
-	printk("pgd == %08x, ", (unsigned int) pgd);
-	pud = pud_offset(pgd, addr);
-	printk("pud == %08x, ", (unsigned int) pud);
-
-	pmd = pmd_offset(pud, addr);
-	printk("pmd == %08x, ", (unsigned int) pmd);
-
-	pte = pte_offset(pmd, addr);
-	printk("pte == %08x, ", (unsigned int) pte);
-
-	page = *pte;
-#ifdef CONFIG_64BIT_PHYS_ADDR
-	printk("page == %08Lx\n", pte_val(page));
-#else
-	printk("page == %08lx\n", pte_val(page));
-#endif
-
-	val = pte_val(page);
-	if (val & _PAGE_PRESENT)
-		printk("present ");
-	if (val & _PAGE_READ)
-		printk("read ");
-	if (val & _PAGE_WRITE)
-		printk("write ");
-	if (val & _PAGE_ACCESSED)
-		printk("accessed ");
-	if (val & _PAGE_MODIFIED)
-		printk("modified ");
-	if (val & _PAGE_R4KBUG)
-		printk("r4kbug ");
-	if (val & _PAGE_GLOBAL)
-		printk("global ");
-	if (val & _PAGE_VALID)
-		printk("valid ");
-	printk("\n");
-}
-
-void dump_list_current(void *address)
-{
-	dump_list_process(current, address);
-}
-
-unsigned int vtop(void *address)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	unsigned int addr, paddr;
-
-	addr = (unsigned long) address;
-	pgd = pgd_offset(current->mm, addr);
-	pud = pud_offset(pgd, addr);
-	pmd = pmd_offset(pud, addr);
-	pte = pte_offset(pmd, addr);
-	paddr = (KSEG1 | (unsigned int) pte_val(*pte)) & PAGE_MASK;
-	paddr |= (addr & ~PAGE_MASK);
-
-	return paddr;
-}
-
-void dump16(unsigned long *p)
-{
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		printk("*%08lx == %08lx, ", (unsigned long) p, *p);
-		p++;
-		printk("*%08lx == %08lx\n", (unsigned long) p, *p);
-		p++;
-	}
-}
diff --git a/arch/mips/lib-32/r3k_dump_tlb.c b/arch/mips/lib-32/r3k_dump_tlb.c
deleted file mode 100644
index 4f2cb74..0000000
--- a/arch/mips/lib-32/r3k_dump_tlb.c
+++ /dev/null
@@ -1,182 +0,0 @@
-/*
- * Dump R3000 TLB for debugging purposes.
- *
- * Copyright (C) 1994, 1995 by Waldorf Electronics, written by Ralf Baechle.
- * Copyright (C) 1999 by Silicon Graphics, Inc.
- * Copyright (C) 1999 by Harald Koerfgen
- */
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-#include <asm/cachectl.h>
-#include <asm/cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
-
-extern int r3k_have_wired_reg;	/* defined in tlb-r3k.c */
-
-void dump_tlb(int first, int last)
-{
-	int	i;
-	unsigned int asid;
-	unsigned long entryhi, entrylo0;
-
-	asid = read_c0_entryhi() & 0xfc0;
-
-	for (i = first; i <= last; i++) {
-		write_c0_index(i<<8);
-		__asm__ __volatile__(
-			".set\tnoreorder\n\t"
-			"tlbr\n\t"
-			"nop\n\t"
-			".set\treorder");
-		entryhi  = read_c0_entryhi();
-		entrylo0 = read_c0_entrylo0();
-
-		/* Unused entries have a virtual address of KSEG0.  */
-		if ((entryhi & 0xffffe000) != 0x80000000
-		    && (entryhi & 0xfc0) == asid) {
-			/*
-			 * Only print entries in use
-			 */
-			printk("Index: %2d ", i);
-
-			printk("va=%08lx asid=%08lx"
-			       "  [pa=%06lx n=%d d=%d v=%d g=%d]",
-			       (entryhi & 0xffffe000),
-			       entryhi & 0xfc0,
-			       entrylo0 & PAGE_MASK,
-			       (entrylo0 & (1 << 11)) ? 1 : 0,
-			       (entrylo0 & (1 << 10)) ? 1 : 0,
-			       (entrylo0 & (1 << 9)) ? 1 : 0,
-			       (entrylo0 & (1 << 8)) ? 1 : 0);
-		}
-	}
-	printk("\n");
-
-	write_c0_entryhi(asid);
-}
-
-void dump_tlb_all(void)
-{
-	dump_tlb(0, current_cpu_data.tlbsize - 1);
-}
-
-void dump_tlb_wired(void)
-{
-	int wired = r3k_have_wired_reg ? read_c0_wired() : 8;
-
-	printk("Wired: %d", wired);
-	dump_tlb(0, wired - 1);
-}
-
-void dump_tlb_addr(unsigned long addr)
-{
-	unsigned long flags, oldpid;
-	int index;
-
-	local_irq_save(flags);
-	oldpid = read_c0_entryhi() & 0xff;
-	write_c0_entryhi((addr & PAGE_MASK) | oldpid);
-	tlb_probe();
-	index = read_c0_index();
-	write_c0_entryhi(oldpid);
-	local_irq_restore(flags);
-
-	if (index < 0) {
-		printk("No entry for address 0x%08lx in TLB\n", addr);
-		return;
-	}
-
-	printk("Entry %d maps address 0x%08lx\n", index, addr);
-	dump_tlb(index, index);
-}
-
-void dump_tlb_nonwired(void)
-{
-	int wired = r3k_have_wired_reg ? read_c0_wired() : 8;
-	dump_tlb(wired, current_cpu_data.tlbsize - 1);
-}
-
-void dump_list_process(struct task_struct *t, void *address)
-{
-	pgd_t	*page_dir, *pgd;
-	pud_t	*pud;
-	pmd_t	*pmd;
-	pte_t	*pte, page;
-	unsigned int addr;
-	unsigned long val;
-
-	addr = (unsigned int) address;
-
-	printk("Addr                 == %08x\n", addr);
-	printk("tasks->mm.pgd        == %08x\n", (unsigned int) t->mm->pgd);
-
-	page_dir = pgd_offset(t->mm, 0);
-	printk("page_dir == %08x\n", (unsigned int) page_dir);
-
-	pgd = pgd_offset(t->mm, addr);
-	printk("pgd == %08x, ", (unsigned int) pgd);
-
-	pud = pud_offset(pgd, addr);
-	printk("pud == %08x, ", (unsigned int) pud);
-
-	pmd = pmd_offset(pud, addr);
-	printk("pmd == %08x, ", (unsigned int) pmd);
-
-	pte = pte_offset(pmd, addr);
-	printk("pte == %08x, ", (unsigned int) pte);
-
-	page = *pte;
-	printk("page == %08x\n", (unsigned int) pte_val(page));
-
-	val = pte_val(page);
-	if (val & _PAGE_PRESENT) printk("present ");
-	if (val & _PAGE_READ) printk("read ");
-	if (val & _PAGE_WRITE) printk("write ");
-	if (val & _PAGE_ACCESSED) printk("accessed ");
-	if (val & _PAGE_MODIFIED) printk("modified ");
-	if (val & _PAGE_GLOBAL) printk("global ");
-	if (val & _PAGE_VALID) printk("valid ");
-	printk("\n");
-}
-
-void dump_list_current(void *address)
-{
-	dump_list_process(current, address);
-}
-
-unsigned int vtop(void *address)
-{
-	pgd_t	*pgd;
-	pud_t	*pud;
-	pmd_t	*pmd;
-	pte_t	*pte;
-	unsigned int addr, paddr;
-
-	addr = (unsigned long) address;
-	pgd = pgd_offset(current->mm, addr);
-	pud = pud_offset(pgd, addr);
-	pmd = pmd_offset(pud, addr);
-	pte = pte_offset(pmd, addr);
-	paddr = (KSEG1 | (unsigned int) pte_val(*pte)) & PAGE_MASK;
-	paddr |= (addr & ~PAGE_MASK);
-
-	return paddr;
-}
-
-void dump16(unsigned long *p)
-{
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		printk("*%08lx == %08lx, ", (unsigned long)p, *p);
-		p++;
-		printk("*%08lx == %08lx\n", (unsigned long)p, *p);
-		p++;
-	}
-}
diff --git a/arch/mips/lib-64/Makefile b/arch/mips/lib-64/Makefile
index 8b94d4c..7bae849 100644
--- a/arch/mips/lib-64/Makefile
+++ b/arch/mips/lib-64/Makefile
@@ -3,21 +3,3 @@
 #
 
 lib-y	+= watch.o
-
-obj-$(CONFIG_CPU_MIPS32)	+= dump_tlb.o
-obj-$(CONFIG_CPU_MIPS64)	+= dump_tlb.o
-obj-$(CONFIG_CPU_NEVADA)	+= dump_tlb.o
-obj-$(CONFIG_CPU_R10000)	+= dump_tlb.o
-obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
-obj-$(CONFIG_CPU_R4300)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R4X00)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R5000)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R5432)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R6000)		+=
-obj-$(CONFIG_CPU_R8000)		+=
-obj-$(CONFIG_CPU_RM7000)	+= dump_tlb.o
-obj-$(CONFIG_CPU_RM9000)	+= dump_tlb.o
-obj-$(CONFIG_CPU_SB1)		+= dump_tlb.o
-obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
-obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
-obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
diff --git a/arch/mips/lib-64/dump_tlb.c b/arch/mips/lib-64/dump_tlb.c
deleted file mode 100644
index 8232900..0000000
--- a/arch/mips/lib-64/dump_tlb.c
+++ /dev/null
@@ -1,214 +0,0 @@
-/*
- * Dump R4x00 TLB for debugging purposes.
- *
- * Copyright (C) 1994, 1995 by Waldorf Electronics, written by Ralf Baechle.
- * Copyright (C) 1999 by Silicon Graphics, Inc.
- */
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-#include <asm/cachectl.h>
-#include <asm/cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
-
-static inline const char *msk2str(unsigned int mask)
-{
-	switch (mask) {
-	case PM_4K:	return "4kb";
-	case PM_16K:	return "16kb";
-	case PM_64K:	return "64kb";
-	case PM_256K:	return "256kb";
-#ifndef CONFIG_CPU_VR41XX
-	case PM_1M:	return "1Mb";
-	case PM_4M:	return "4Mb";
-	case PM_16M:	return "16Mb";
-	case PM_64M:	return "64Mb";
-	case PM_256M:	return "256Mb";
-#endif
-	}
-}
-
-#define BARRIER()					\
-	__asm__ __volatile__(				\
-		".set\tnoreorder\n\t"			\
-		"nop;nop;nop;nop;nop;nop;nop\n\t"	\
-		".set\treorder");
-
-void dump_tlb(int first, int last)
-{
-	unsigned long s_entryhi, entryhi, entrylo0, entrylo1, asid;
-	unsigned int s_index, pagemask, c0, c1, i;
-
-	s_entryhi = read_c0_entryhi();
-	s_index = read_c0_index();
-	asid = s_entryhi & 0xff;
-
-	for (i = first; i <= last; i++) {
-		write_c0_index(i);
-		BARRIER();
-		tlb_read();
-		BARRIER();
-		pagemask = read_c0_pagemask();
-		entryhi  = read_c0_entryhi();
-		entrylo0 = read_c0_entrylo0();
-		entrylo1 = read_c0_entrylo1();
-
-		/* Unused entries have a virtual address of CKSEG0.  */
-		if ((entryhi & ~0x1ffffUL) != CKSEG0
-		    && (entryhi & 0xff) == asid) {
-			/*
-			 * Only print entries in use
-			 */
-			printk("Index: %2d pgmask=%s ", i, msk2str(pagemask));
-
-			c0 = (entrylo0 >> 3) & 7;
-			c1 = (entrylo1 >> 3) & 7;
-
-			printk("va=%011lx asid=%02lx\n",
-			       (entryhi & ~0x1fffUL),
-			       entryhi & 0xff);
-			printk("\t[pa=%011lx c=%d d=%d v=%d g=%ld] ",
-			       (entrylo0 << 6) & PAGE_MASK, c0,
-			       (entrylo0 & 4) ? 1 : 0,
-			       (entrylo0 & 2) ? 1 : 0,
-			       (entrylo0 & 1));
-			printk("[pa=%011lx c=%d d=%d v=%d g=%ld]\n",
-			       (entrylo1 << 6) & PAGE_MASK, c1,
-			       (entrylo1 & 4) ? 1 : 0,
-			       (entrylo1 & 2) ? 1 : 0,
-			       (entrylo1 & 1));
-		}
-	}
-	printk("\n");
-
-	write_c0_entryhi(s_entryhi);
-	write_c0_index(s_index);
-}
-
-void dump_tlb_all(void)
-{
-	dump_tlb(0, current_cpu_data.tlbsize - 1);
-}
-
-void dump_tlb_wired(void)
-{
-	int	wired;
-
-	wired = read_c0_wired();
-	printk("Wired: %d", wired);
-	dump_tlb(0, read_c0_wired());
-}
-
-void dump_tlb_addr(unsigned long addr)
-{
-	unsigned int flags, oldpid;
-	int index;
-
-	local_irq_save(flags);
-	oldpid = read_c0_entryhi() & 0xff;
-	BARRIER();
-	write_c0_entryhi((addr & PAGE_MASK) | oldpid);
-	BARRIER();
-	tlb_probe();
-	BARRIER();
-	index = read_c0_index();
-	write_c0_entryhi(oldpid);
-	local_irq_restore(flags);
-
-	if (index < 0) {
-		printk("No entry for address 0x%08lx in TLB\n", addr);
-		return;
-	}
-
-	printk("Entry %d maps address 0x%08lx\n", index, addr);
-	dump_tlb(index, index);
-}
-
-void dump_tlb_nonwired(void)
-{
-	dump_tlb(read_c0_wired(), current_cpu_data.tlbsize - 1);
-}
-
-void dump_list_process(struct task_struct *t, void *address)
-{
-	pgd_t	*page_dir, *pgd;
-	pud_t	*pud;
-	pmd_t	*pmd;
-	pte_t	*pte, page;
-	unsigned long addr, val;
-
-	addr = (unsigned long) address;
-
-	printk("Addr                 == %08lx\n", addr);
-	printk("tasks->mm.pgd        == %08lx\n", (unsigned long) t->mm->pgd);
-
-	page_dir = pgd_offset(t->mm, 0UL);
-	printk("page_dir == %016lx\n", (unsigned long) page_dir);
-
-	pgd = pgd_offset(t->mm, addr);
-	printk("pgd == %016lx\n", (unsigned long) pgd);
-
-	pud = pud_offset(pgd, addr);
-	printk("pud == %016lx\n", (unsigned long) pud);
-
-	pmd = pmd_offset(pud, addr);
-	printk("pmd == %016lx\n", (unsigned long) pmd);
-
-	pte = pte_offset(pmd, addr);
-	printk("pte == %016lx\n", (unsigned long) pte);
-
-	page = *pte;
-	printk("page == %08lx\n", pte_val(page));
-
-	val = pte_val(page);
-	if (val & _PAGE_PRESENT) printk("present ");
-	if (val & _PAGE_READ) printk("read ");
-	if (val & _PAGE_WRITE) printk("write ");
-	if (val & _PAGE_ACCESSED) printk("accessed ");
-	if (val & _PAGE_MODIFIED) printk("modified ");
-	if (val & _PAGE_R4KBUG) printk("r4kbug ");
-	if (val & _PAGE_GLOBAL) printk("global ");
-	if (val & _PAGE_VALID) printk("valid ");
-	printk("\n");
-}
-
-void dump_list_current(void *address)
-{
-	dump_list_process(current, address);
-}
-
-unsigned long vtop(void *address)
-{
-	pgd_t	*pgd;
-	pud_t	*pud;
-	pmd_t	*pmd;
-	pte_t	*pte;
-	unsigned long addr, paddr;
-
-	addr = (unsigned long) address;
-	pgd = pgd_offset(current->mm, addr);
-	pud = pud_offset(pgd, addr);
-	pmd = pmd_offset(pud, addr);
-	pte = pte_offset(pmd, addr);
-	paddr = (CKSEG1 | (unsigned int) pte_val(*pte)) & PAGE_MASK;
-	paddr |= (addr & ~PAGE_MASK);
-
-	return paddr;
-}
-
-void dump16(unsigned long *p)
-{
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		printk("*%08lx == %08lx, ", (unsigned long)p, *p);
-		p++;
-		printk("*%08lx == %08lx\n", (unsigned long)p, *p);
-		p++;
-	}
-}
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 5dad13e..b27a326 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -8,5 +8,23 @@ lib-y	+= csum_partial.o memcpy.o memcpy-inatomic.o memset.o strlen_user.o \
 obj-y			+= iomap.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
 
+obj-$(CONFIG_CPU_MIPS32)	+= dump_tlb.o
+obj-$(CONFIG_CPU_MIPS64)	+= dump_tlb.o
+obj-$(CONFIG_CPU_NEVADA)	+= dump_tlb.o
+obj-$(CONFIG_CPU_R10000)	+= dump_tlb.o
+obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
+obj-$(CONFIG_CPU_R4300)		+= dump_tlb.o
+obj-$(CONFIG_CPU_R4X00)		+= dump_tlb.o
+obj-$(CONFIG_CPU_R5000)		+= dump_tlb.o
+obj-$(CONFIG_CPU_R5432)		+= dump_tlb.o
+obj-$(CONFIG_CPU_R6000)		+=
+obj-$(CONFIG_CPU_R8000)		+=
+obj-$(CONFIG_CPU_RM7000)	+= dump_tlb.o
+obj-$(CONFIG_CPU_RM9000)	+= dump_tlb.o
+obj-$(CONFIG_CPU_SB1)		+= dump_tlb.o
+obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
+obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
+obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
+
 # libgcc-style stuff needed in the kernel
 lib-y += ashldi3.o ashrdi3.o lshrdi3.o ucmpdi2.o
diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
new file mode 100644
index 0000000..fbf4b72
--- /dev/null
+++ b/arch/mips/lib/dump_tlb.c
@@ -0,0 +1,242 @@
+/*
+ * Dump R4x00 TLB for debugging purposes.
+ *
+ * Copyright (C) 1994, 1995 by Waldorf Electronics, written by Ralf Baechle.
+ * Copyright (C) 1999 by Silicon Graphics, Inc.
+ */
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cachectl.h>
+#include <asm/cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+static inline const char *msk2str(unsigned int mask)
+{
+	switch (mask) {
+	case PM_4K:	return "4kb";
+	case PM_16K:	return "16kb";
+	case PM_64K:	return "64kb";
+	case PM_256K:	return "256kb";
+#ifndef CONFIG_CPU_VR41XX
+	case PM_1M:	return "1Mb";
+	case PM_4M:	return "4Mb";
+	case PM_16M:	return "16Mb";
+	case PM_64M:	return "64Mb";
+	case PM_256M:	return "256Mb";
+#endif
+	}
+	return "";
+}
+
+#define BARRIER()					\
+	__asm__ __volatile__(				\
+		".set\tnoreorder\n\t"			\
+		"nop;nop;nop;nop;nop;nop;nop\n\t"	\
+		".set\treorder");
+
+void dump_tlb(int first, int last)
+{
+	unsigned long s_entryhi, entryhi, asid;
+	unsigned long long entrylo0, entrylo1;
+	unsigned int s_index, pagemask, c0, c1, i;
+
+	s_entryhi = read_c0_entryhi();
+	s_index = read_c0_index();
+	asid = s_entryhi & 0xff;
+
+	for (i = first; i <= last; i++) {
+		write_c0_index(i);
+		BARRIER();
+		tlb_read();
+		BARRIER();
+		pagemask = read_c0_pagemask();
+		entryhi  = read_c0_entryhi();
+		entrylo0 = read_c0_entrylo0();
+		entrylo1 = read_c0_entrylo1();
+
+		/* Unused entries have a virtual address of CKSEG0.  */
+		if ((entryhi & ~0x1ffffUL) != CKSEG0
+		    && (entryhi & 0xff) == asid) {
+#ifdef CONFIG_32BIT
+			int width = 8;
+#else
+			int width = 11;
+#endif
+			/*
+			 * Only print entries in use
+			 */
+			printk("Index: %2d pgmask=%s ", i, msk2str(pagemask));
+
+			c0 = (entrylo0 >> 3) & 7;
+			c1 = (entrylo1 >> 3) & 7;
+
+			printk("va=%0*lx asid=%02lx\n",
+			       width, (entryhi & ~0x1fffUL),
+			       entryhi & 0xff);
+			printk("\t[pa=%0*llx c=%d d=%d v=%d g=%d] ",
+			       width,
+			       (entrylo0 << 6) & PAGE_MASK, c0,
+			       (entrylo0 & 4) ? 1 : 0,
+			       (entrylo0 & 2) ? 1 : 0,
+			       (entrylo0 & 1) ? 1 : 0);
+			printk("[pa=%0*llx c=%d d=%d v=%d g=%d]\n",
+			       width,
+			       (entrylo1 << 6) & PAGE_MASK, c1,
+			       (entrylo1 & 4) ? 1 : 0,
+			       (entrylo1 & 2) ? 1 : 0,
+			       (entrylo1 & 1) ? 1 : 0);
+		}
+	}
+	printk("\n");
+
+	write_c0_entryhi(s_entryhi);
+	write_c0_index(s_index);
+}
+
+void dump_tlb_all(void)
+{
+	dump_tlb(0, current_cpu_data.tlbsize - 1);
+}
+
+void dump_tlb_wired(void)
+{
+	int	wired;
+
+	wired = read_c0_wired();
+	printk("Wired: %d", wired);
+	dump_tlb(0, read_c0_wired());
+}
+
+void dump_tlb_addr(unsigned long addr)
+{
+	unsigned int flags, oldpid;
+	int index;
+
+	local_irq_save(flags);
+	oldpid = read_c0_entryhi() & 0xff;
+	BARRIER();
+	write_c0_entryhi((addr & PAGE_MASK) | oldpid);
+	BARRIER();
+	tlb_probe();
+	BARRIER();
+	index = read_c0_index();
+	write_c0_entryhi(oldpid);
+	local_irq_restore(flags);
+
+	if (index < 0) {
+		printk("No entry for address 0x%08lx in TLB\n", addr);
+		return;
+	}
+
+	printk("Entry %d maps address 0x%08lx\n", index, addr);
+	dump_tlb(index, index);
+}
+
+void dump_tlb_nonwired(void)
+{
+	dump_tlb(read_c0_wired(), current_cpu_data.tlbsize - 1);
+}
+
+void dump_list_process(struct task_struct *t, void *address)
+{
+	pgd_t	*page_dir, *pgd;
+	pud_t	*pud;
+	pmd_t	*pmd;
+	pte_t	*pte, page;
+	unsigned long addr, val;
+	int width = sizeof(long) * 2;
+
+	addr = (unsigned long) address;
+
+	printk("Addr                 == %08lx\n", addr);
+#ifdef CONFIG_64BIT
+	printk("tasks->mm.pgd        == %08lx\n", (unsigned long) t->mm->pgd);
+#endif
+
+#ifdef CONFIG_64BIT
+	page_dir = pgd_offset(t->mm, 0UL);
+	pgd = pgd_offset(t->mm, addr);
+#else
+	if (addr > KSEG0) {
+		page_dir = pgd_offset_k(0);
+		pgd = pgd_offset_k(addr);
+	} else if (t->mm) {
+		page_dir = pgd_offset(t->mm, 0);
+		pgd = pgd_offset(t->mm, addr);
+	} else {
+		printk("Current thread has no mm\n");
+		return;
+	}
+#endif
+	printk("page_dir == %0*lx\n", width, (unsigned long) page_dir);
+	printk("pgd == %0*lx\n", width, (unsigned long) pgd);
+
+	pud = pud_offset(pgd, addr);
+	printk("pud == %0*lx\n", width, (unsigned long) pud);
+
+	pmd = pmd_offset(pud, addr);
+	printk("pmd == %0*lx\n", width, (unsigned long) pmd);
+
+	pte = pte_offset(pmd, addr);
+	printk("pte == %0*lx\n", width, (unsigned long) pte);
+
+	page = *pte;
+#ifdef CONFIG_64BIT_PHYS_ADDR
+	printk("page == %08Lx\n", pte_val(page));
+#else
+	printk("page == %0*lx\n", width, pte_val(page));
+#endif
+
+	val = pte_val(page);
+	if (val & _PAGE_PRESENT) printk("present ");
+	if (val & _PAGE_READ) printk("read ");
+	if (val & _PAGE_WRITE) printk("write ");
+	if (val & _PAGE_ACCESSED) printk("accessed ");
+	if (val & _PAGE_MODIFIED) printk("modified ");
+	if (val & _PAGE_R4KBUG) printk("r4kbug ");
+	if (val & _PAGE_GLOBAL) printk("global ");
+	if (val & _PAGE_VALID) printk("valid ");
+	printk("\n");
+}
+
+void dump_list_current(void *address)
+{
+	dump_list_process(current, address);
+}
+
+unsigned long vtop(void *address)
+{
+	pgd_t	*pgd;
+	pud_t	*pud;
+	pmd_t	*pmd;
+	pte_t	*pte;
+	unsigned long addr, paddr;
+
+	addr = (unsigned long) address;
+	pgd = pgd_offset(current->mm, addr);
+	pud = pud_offset(pgd, addr);
+	pmd = pmd_offset(pud, addr);
+	pte = pte_offset(pmd, addr);
+	paddr = (CKSEG1 | (unsigned int) pte_val(*pte)) & PAGE_MASK;
+	paddr |= (addr & ~PAGE_MASK);
+
+	return paddr;
+}
+
+void dump16(unsigned long *p)
+{
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		printk("*%08lx == %08lx, ", (unsigned long)p, *p);
+		p++;
+		printk("*%08lx == %08lx\n", (unsigned long)p, *p);
+		p++;
+	}
+}
diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
new file mode 100644
index 0000000..4f2cb74
--- /dev/null
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -0,0 +1,182 @@
+/*
+ * Dump R3000 TLB for debugging purposes.
+ *
+ * Copyright (C) 1994, 1995 by Waldorf Electronics, written by Ralf Baechle.
+ * Copyright (C) 1999 by Silicon Graphics, Inc.
+ * Copyright (C) 1999 by Harald Koerfgen
+ */
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cachectl.h>
+#include <asm/cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+extern int r3k_have_wired_reg;	/* defined in tlb-r3k.c */
+
+void dump_tlb(int first, int last)
+{
+	int	i;
+	unsigned int asid;
+	unsigned long entryhi, entrylo0;
+
+	asid = read_c0_entryhi() & 0xfc0;
+
+	for (i = first; i <= last; i++) {
+		write_c0_index(i<<8);
+		__asm__ __volatile__(
+			".set\tnoreorder\n\t"
+			"tlbr\n\t"
+			"nop\n\t"
+			".set\treorder");
+		entryhi  = read_c0_entryhi();
+		entrylo0 = read_c0_entrylo0();
+
+		/* Unused entries have a virtual address of KSEG0.  */
+		if ((entryhi & 0xffffe000) != 0x80000000
+		    && (entryhi & 0xfc0) == asid) {
+			/*
+			 * Only print entries in use
+			 */
+			printk("Index: %2d ", i);
+
+			printk("va=%08lx asid=%08lx"
+			       "  [pa=%06lx n=%d d=%d v=%d g=%d]",
+			       (entryhi & 0xffffe000),
+			       entryhi & 0xfc0,
+			       entrylo0 & PAGE_MASK,
+			       (entrylo0 & (1 << 11)) ? 1 : 0,
+			       (entrylo0 & (1 << 10)) ? 1 : 0,
+			       (entrylo0 & (1 << 9)) ? 1 : 0,
+			       (entrylo0 & (1 << 8)) ? 1 : 0);
+		}
+	}
+	printk("\n");
+
+	write_c0_entryhi(asid);
+}
+
+void dump_tlb_all(void)
+{
+	dump_tlb(0, current_cpu_data.tlbsize - 1);
+}
+
+void dump_tlb_wired(void)
+{
+	int wired = r3k_have_wired_reg ? read_c0_wired() : 8;
+
+	printk("Wired: %d", wired);
+	dump_tlb(0, wired - 1);
+}
+
+void dump_tlb_addr(unsigned long addr)
+{
+	unsigned long flags, oldpid;
+	int index;
+
+	local_irq_save(flags);
+	oldpid = read_c0_entryhi() & 0xff;
+	write_c0_entryhi((addr & PAGE_MASK) | oldpid);
+	tlb_probe();
+	index = read_c0_index();
+	write_c0_entryhi(oldpid);
+	local_irq_restore(flags);
+
+	if (index < 0) {
+		printk("No entry for address 0x%08lx in TLB\n", addr);
+		return;
+	}
+
+	printk("Entry %d maps address 0x%08lx\n", index, addr);
+	dump_tlb(index, index);
+}
+
+void dump_tlb_nonwired(void)
+{
+	int wired = r3k_have_wired_reg ? read_c0_wired() : 8;
+	dump_tlb(wired, current_cpu_data.tlbsize - 1);
+}
+
+void dump_list_process(struct task_struct *t, void *address)
+{
+	pgd_t	*page_dir, *pgd;
+	pud_t	*pud;
+	pmd_t	*pmd;
+	pte_t	*pte, page;
+	unsigned int addr;
+	unsigned long val;
+
+	addr = (unsigned int) address;
+
+	printk("Addr                 == %08x\n", addr);
+	printk("tasks->mm.pgd        == %08x\n", (unsigned int) t->mm->pgd);
+
+	page_dir = pgd_offset(t->mm, 0);
+	printk("page_dir == %08x\n", (unsigned int) page_dir);
+
+	pgd = pgd_offset(t->mm, addr);
+	printk("pgd == %08x, ", (unsigned int) pgd);
+
+	pud = pud_offset(pgd, addr);
+	printk("pud == %08x, ", (unsigned int) pud);
+
+	pmd = pmd_offset(pud, addr);
+	printk("pmd == %08x, ", (unsigned int) pmd);
+
+	pte = pte_offset(pmd, addr);
+	printk("pte == %08x, ", (unsigned int) pte);
+
+	page = *pte;
+	printk("page == %08x\n", (unsigned int) pte_val(page));
+
+	val = pte_val(page);
+	if (val & _PAGE_PRESENT) printk("present ");
+	if (val & _PAGE_READ) printk("read ");
+	if (val & _PAGE_WRITE) printk("write ");
+	if (val & _PAGE_ACCESSED) printk("accessed ");
+	if (val & _PAGE_MODIFIED) printk("modified ");
+	if (val & _PAGE_GLOBAL) printk("global ");
+	if (val & _PAGE_VALID) printk("valid ");
+	printk("\n");
+}
+
+void dump_list_current(void *address)
+{
+	dump_list_process(current, address);
+}
+
+unsigned int vtop(void *address)
+{
+	pgd_t	*pgd;
+	pud_t	*pud;
+	pmd_t	*pmd;
+	pte_t	*pte;
+	unsigned int addr, paddr;
+
+	addr = (unsigned long) address;
+	pgd = pgd_offset(current->mm, addr);
+	pud = pud_offset(pgd, addr);
+	pmd = pmd_offset(pud, addr);
+	pte = pte_offset(pmd, addr);
+	paddr = (KSEG1 | (unsigned int) pte_val(*pte)) & PAGE_MASK;
+	paddr |= (addr & ~PAGE_MASK);
+
+	return paddr;
+}
+
+void dump16(unsigned long *p)
+{
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		printk("*%08lx == %08lx, ", (unsigned long)p, *p);
+		p++;
+		printk("*%08lx == %08lx\n", (unsigned long)p, *p);
+		p++;
+	}
+}
