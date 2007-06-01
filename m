Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2007 17:06:13 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:26622 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022934AbXFAQGK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Jun 2007 17:06:10 +0100
Received: from localhost (p8230-ipad205funabasi.chiba.ocn.ne.jp [222.146.103.230])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6000FB656; Sat,  2 Jun 2007 00:29:58 +0900 (JST)
Date:	Sat, 02 Jun 2007 00:30:25 +0900 (JST)
Message-Id: <20070602.003025.51867254.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Remove unused dump_tlb functions
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
X-archive-position: 15220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Remove unused dump_tlb functions and cleanup some includes.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch can be applied after "[PATCH] Unify dump_tlb".

 arch/mips/lib/dump_tlb.c       |  144 +---------------------------------------
 arch/mips/lib/r3k_dump_tlb.c   |  122 +---------------------------------
 arch/mips/sgi-ip27/ip27-berr.c |    1 -
 3 files changed, 2 insertions(+), 265 deletions(-)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index fbf4b72..1a4db7d 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -6,12 +6,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/string.h>
 
-#include <asm/bootinfo.h>
-#include <asm/cachectl.h>
-#include <asm/cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -40,7 +35,7 @@ static inline const char *msk2str(unsigned int mask)
 		"nop;nop;nop;nop;nop;nop;nop\n\t"	\
 		".set\treorder");
 
-void dump_tlb(int first, int last)
+static void dump_tlb(int first, int last)
 {
 	unsigned long s_entryhi, entryhi, asid;
 	unsigned long long entrylo0, entrylo1;
@@ -103,140 +98,3 @@ void dump_tlb_all(void)
 {
 	dump_tlb(0, current_cpu_data.tlbsize - 1);
 }
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
-	int width = sizeof(long) * 2;
-
-	addr = (unsigned long) address;
-
-	printk("Addr                 == %08lx\n", addr);
-#ifdef CONFIG_64BIT
-	printk("tasks->mm.pgd        == %08lx\n", (unsigned long) t->mm->pgd);
-#endif
-
-#ifdef CONFIG_64BIT
-	page_dir = pgd_offset(t->mm, 0UL);
-	pgd = pgd_offset(t->mm, addr);
-#else
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
-#endif
-	printk("page_dir == %0*lx\n", width, (unsigned long) page_dir);
-	printk("pgd == %0*lx\n", width, (unsigned long) pgd);
-
-	pud = pud_offset(pgd, addr);
-	printk("pud == %0*lx\n", width, (unsigned long) pud);
-
-	pmd = pmd_offset(pud, addr);
-	printk("pmd == %0*lx\n", width, (unsigned long) pmd);
-
-	pte = pte_offset(pmd, addr);
-	printk("pte == %0*lx\n", width, (unsigned long) pte);
-
-	page = *pte;
-#ifdef CONFIG_64BIT_PHYS_ADDR
-	printk("page == %08Lx\n", pte_val(page));
-#else
-	printk("page == %0*lx\n", width, pte_val(page));
-#endif
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
diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index 4f2cb74..52f8779 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -7,19 +7,14 @@
  */
 #include <linux/kernel.h>
 #include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/string.h>
 
-#include <asm/bootinfo.h>
-#include <asm/cachectl.h>
-#include <asm/cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
 extern int r3k_have_wired_reg;	/* defined in tlb-r3k.c */
 
-void dump_tlb(int first, int last)
+static void dump_tlb(int first, int last)
 {
 	int	i;
 	unsigned int asid;
@@ -65,118 +60,3 @@ void dump_tlb_all(void)
 {
 	dump_tlb(0, current_cpu_data.tlbsize - 1);
 }
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
diff --git a/arch/mips/sgi-ip27/ip27-berr.c b/arch/mips/sgi-ip27/ip27-berr.c
index ce907ed..123141a 100644
--- a/arch/mips/sgi-ip27/ip27-berr.c
+++ b/arch/mips/sgi-ip27/ip27-berr.c
@@ -21,7 +21,6 @@
 #include <asm/traps.h>
 #include <asm/uaccess.h>
 
-extern void dump_tlb_addr(unsigned long addr);
 extern void dump_tlb_all(void);
 
 static void dump_hub_information(unsigned long errst0, unsigned long errst1)
