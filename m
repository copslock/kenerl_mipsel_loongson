Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:54:56 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:11907 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225212AbTC0CyS>;
	Thu, 27 Mar 2003 02:54:18 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 3DE1646A59; Thu, 27 Mar 2003 03:52:51 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: sync code of dump_tlb.c between mips & mips64 vers
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:52:51 +0100
Message-ID: <m2k7eled18.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

Merge the non-conflicting changes between both files.

Later, Juan.

 build/arch/mips/lib/dump_tlb.c   |   65 +++++++++++++++++----------------------
 build/arch/mips64/lib/dump_tlb.c |   22 ++++++-------
 2 files changed, 39 insertions(+), 48 deletions(-)

diff -puN build/arch/mips/lib/dump_tlb.c~sync_dump_tlb.c build/arch/mips/lib/dump_tlb.c
--- 24/build/arch/mips/lib/dump_tlb.c~sync_dump_tlb.c	2003-03-21 00:28:20.000000000 +0100
+++ 24-quintela/build/arch/mips/lib/dump_tlb.c	2003-03-21 01:33:48.000000000 +0100
@@ -11,13 +11,13 @@
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
-#include <asm/cpu.h>
 #include <asm/cachectl.h>
+#include <asm/cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
-static inline const char *msg2str(unsigned int mask)
+static inline const char *msk2str(unsigned int mask)
 {
 	switch (mask) {
 	case PM_4K:	return "4kb";
@@ -32,19 +32,18 @@ static inline const char *msg2str(unsign
 	case PM_256M:	return "256Mb";
 #endif
 	}
+	return "Unknown size";
 }
 
 void dump_tlb(int first, int last)
 {
-	int	i;
-	unsigned int pagemask, c0, c1, asid;
 	unsigned long long entrylo0, entrylo1;
-	unsigned long entryhi;
+	unsigned long entryhi, asid;
+	unsigned int pagemask, c0, c1, i;
 
 	asid = read_c0_entryhi() & 0xff;
 
-	printk("\n");
-	for(i=first;i<=last;i++) {
+	for (i = first; i <= last; i++) {
 		write_c0_index(i);
 		__asm__ __volatile__(
 			".set\tmips3\n\t"
@@ -65,26 +64,27 @@ void dump_tlb(int first, int last)
 			/*
 			 * Only print entries in use
 			 */
-			printk("Index: %2d pgmask=%s ", i, msg2str(pagemask));
+			printk("Index: %2d pgmask=%s ", i, msk2str(pagemask));
 
 			c0 = (entrylo0 >> 3) & 7;
 			c1 = (entrylo1 >> 3) & 7;
 
 			printk("va=%08lx asid=%02lx\n",
-			       (entryhi & 0xffffe000), (entryhi & 0xff));
-			printk("\t\t\t[pa=%08Lx c=%d d=%d v=%d g=%Ld]\n",
+			       (entryhi & 0xffffe000),
+			       (entryhi & 0xff));
+			printk("\t[pa=%08Lx c=%d d=%d v=%d g=%Ld]",
 			       (entrylo0 << 6) & PAGE_MASK, c0,
 			       (entrylo0 & 4) ? 1 : 0,
 			       (entrylo0 & 2) ? 1 : 0,
 			       (entrylo0 & 1));
-			printk("\t\t\t[pa=%08Lx c=%d d=%d v=%d g=%Ld]\n",
+			printk("[pa=%08Lx c=%d d=%d v=%d g=%Ld]\n",
 			       (entrylo1 << 6) & PAGE_MASK, c1,
 			       (entrylo1 & 4) ? 1 : 0,
 			       (entrylo1 & 2) ? 1 : 0,
 			       (entrylo1 & 1));
-			printk("\n");
 		}
 	}
+	printk("\n");
 
 	write_c0_entryhi(asid);
 }
@@ -109,8 +109,7 @@ void dump_tlb_wired(void)
 		"nop;nop;nop;nop;nop;nop;nop\n\t"	\
 		".set\treorder");
 
-void
-dump_tlb_addr(unsigned long addr)
+void dump_tlb_addr(unsigned long addr)
 {
 	unsigned long flags, oldpid;
 	int index;
@@ -135,45 +134,43 @@ dump_tlb_addr(unsigned long addr)
 	dump_tlb(index, index);
 }
 
-void
-dump_tlb_nonwired(void)
+void dump_tlb_nonwired(void)
 {
 	dump_tlb(read_c0_wired(), mips_cpu.tlbsize - 1);
 }
 
-void
-dump_list_process(struct task_struct *t, void *address)
+void dump_list_process(struct task_struct *t, void *address)
 {
 	pgd_t	*page_dir, *pgd;
 	pmd_t	*pmd;
 	pte_t	*pte, page;
-	unsigned int addr;
+	unsigned long addr;
 	unsigned long val;
 
-	addr = (unsigned int) address;
+	addr = (unsigned long) address;
 
-	printk("Addr                 == %08x\n", addr);
-	printk("task                 == %08p\n", t);
-	printk("task->mm             == %08p\n", t->mm);
-	//printk("tasks->mm.pgd        == %08x\n", (unsigned int) t->mm->pgd);
+	printk("Addr                 == %08lx\n", addr);
+	printk("task                 == %8p\n", t);
+	printk("task->mm             == %8p\n", t->mm);
+	//printk("tasks->mm.pgd        == %8p\n", t->mm->pgd);
 
 	if (addr > KSEG0)
 		page_dir = pgd_offset_k(0);
 	else
 		page_dir = pgd_offset(t->mm, 0);
-	printk("page_dir == %08x\n", (unsigned int) page_dir);
+	printk("page_dir == %08lx\n", (unsigned long) page_dir);
 
 	if (addr > KSEG0)
 		pgd = pgd_offset_k(addr);
 	else
 		pgd = pgd_offset(t->mm, addr);
-	printk("pgd == %08x, ", (unsigned int) pgd);
+	printk("pgd == %8p, ", pgd);
 
 	pmd = pmd_offset(pgd, addr);
-	printk("pmd == %08x, ", (unsigned int) pmd);
+	printk("pmd == %8p, ", pmd);
 
 	pte = pte_offset(pmd, addr);
-	printk("pte == %08x, ", (unsigned int) pte);
+	printk("pte == %8p, ", pte);
 
 	page = *pte;
 #ifdef CONFIG_64BIT_PHYS_ADDR
@@ -194,14 +191,12 @@ dump_list_process(struct task_struct *t,
 	printk("\n");
 }
 
-void
-dump_list_current(void *address)
+void dump_list_current(void *address)
 {
 	dump_list_process(current, address);
 }
 
-unsigned int
-vtop(void *address)
+unsigned int vtop(void *address)
 {
 	pgd_t	*pgd;
 	pmd_t	*pmd;
@@ -218,13 +213,11 @@ vtop(void *address)
 	return paddr;
 }
 
-void
-dump16(unsigned long *p)
+void dump16(unsigned long *p)
 {
 	int i;
 
-	for(i=0;i<8;i++)
-	{
+	for(i = 0; i < 8; i++) {
 		printk("*%8p = %08lx, ", p, *p); p++;
 		printk("*%8p = %08lx\n", p, *p); p++;
 	}
diff -puN build/arch/mips64/lib/dump_tlb.c~sync_dump_tlb.c build/arch/mips64/lib/dump_tlb.c
--- 24/build/arch/mips64/lib/dump_tlb.c~sync_dump_tlb.c	2003-03-21 00:42:47.000000000 +0100
+++ 24-quintela/build/arch/mips64/lib/dump_tlb.c	2003-03-21 01:13:38.000000000 +0100
@@ -29,11 +29,13 @@ static inline const char *msk2str(unsign
 	case PM_64M:	return "64Mb";
 	case PM_256M:	return "256Mb";
 	}
+	return "Unknown size";
 }
 
 void dump_tlb(int first, int last)
 {
-	unsigned long s_entryhi, entryhi, entrylo0, entrylo1, asid;
+	unsigned long entrylo0, entrylo1;
+	unsigned long s_entryhi, entryhi, asid;
 	unsigned int s_index, pagemask, c0, c1, i;
 
 	s_entryhi = read_c0_entryhi();
@@ -66,7 +68,7 @@ void dump_tlb(int first, int last)
 
 			printk("va=%011lx asid=%02lx\n",
 			       (entryhi & ~0x1fffUL),
-			       entryhi & 0xff);
+			       (entryhi & 0xff));
 			printk("\t[pa=%011lx c=%d d=%d v=%d g=%ld] ",
 			       (entrylo0 << 6) & PAGE_MASK, c0,
 			       (entrylo0 & 4) ? 1 : 0,
@@ -146,19 +148,19 @@ void dump_list_process(struct task_struc
 	addr = (unsigned long) address;
 
 	printk("Addr                 == %08lx\n", addr);
-	printk("tasks->mm.pgd        == %08lx\n", (unsigned long) t->mm->pgd);
+	printk("tasks->mm.pgd        == %8p\n", t->mm->pgd);
 
 	page_dir = pgd_offset(t->mm, 0);
 	printk("page_dir == %08lx\n", (unsigned long) page_dir);
 
 	pgd = pgd_offset(t->mm, addr);
-	printk("pgd == %08lx, ", (unsigned long) pgd);
+	printk("pgd == %8p, ", pgd);
 
 	pmd = pmd_offset(pgd, addr);
-	printk("pmd == %08lx, ", (unsigned long) pmd);
+	printk("pmd == %8p, ", pmd);
 
 	pte = pte_offset(pmd, addr);
-	printk("pte == %08lx, ", (unsigned long) pte);
+	printk("pte == %8p, ", pte);
 
 	page = *pte;
 	printk("page == %08lx\n", pte_val(page));
@@ -202,11 +204,7 @@ void dump16(unsigned long *p)
 	int i;
 
 	for(i = 0; i < 8; i++) {
-		printk("*%08lx == %08lx, ",
-		       (unsigned long)p, (unsigned long)*p);
-		p++;
-		printk("*%08lx == %08lx\n",
-		       (unsigned long)p, (unsigned long)*p);
-		p++;
+		printk("*%8p = %08lx, ", p, *p); p++;
+		printk("*%8p = %08lx\n", p, *p); p++;
 	}
 }

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
