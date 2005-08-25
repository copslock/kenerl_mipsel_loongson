Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2005 22:46:12 +0100 (BST)
Received: from smtp102.biz.mail.mud.yahoo.com ([IPv6:::ffff:68.142.200.237]:34726
	"HELO smtp102.biz.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8225474AbVHYVpx>; Thu, 25 Aug 2005 22:45:53 +0100
Received: (qmail 45725 invoked from network); 25 Aug 2005 21:51:26 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp102.biz.mail.mud.yahoo.com with SMTP; 25 Aug 2005 21:51:26 -0000
Subject: patch / rfc
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 25 Aug 2005 14:51:21 -0700
Message-Id: <1125006681.14435.1065.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


This is an experimental (though tested) patch for early ioremap support
on mips, before mem_init runs. Something like this is only needed on
certain SoCs that have all of their I/O on high addresses such that they
can't me ioremapped through kseg1.

I think the CONFIG_64 stuff needs to removed since we don't need it. The
patch was tested on a MIPS32 CPU only. Some of the significant changes:

- trap_init() became early_trap_init() since too much stuff happens
there that is needed to support early ioremap. The old trap_init() is
now empty.

- added plat_setup_late() call. All ports would need to add that call,
or at least a placeholder. Early ioremap is possible only at that point.
However, most of the code in each plat_setup() can be moved to
plat_setup_late()

diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/kernel/setup.c linux-2.6-dev/arch/mips/kernel/setup.c
--- linux-2.6-orig/arch/mips/kernel/setup.c	2005-08-24 17:12:31.000000000 -0700
+++ linux-2.6-dev/arch/mips/kernel/setup.c	2005-08-25 10:56:40.000000000 -0700
@@ -42,7 +42,10 @@
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/system.h>
+#include <asm/traps.h>
+#include <asm/io.h>
 
+int init_bootmem_done;
 struct cpuinfo_mips cpu_data[NR_CPUS] __read_mostly;
 
 EXPORT_SYMBOL(cpu_data);
@@ -417,6 +420,8 @@
 
 	/* Reserve the bootmap memory.  */
 	reserve_bootmem(PFN_PHYS(first_usable_pfn), bootmap_size);
+
+	init_bootmem_done = 1;
 #endif /* CONFIG_SGI_IP27 */
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -511,7 +516,23 @@
 #undef MAXMEM
 #undef MAXMEM_PFN
 
+void __init early_ioremap_init(void)
+{
+#ifdef CONFIG_64BIT
+	ioremap_base = (VMALLOC_START + PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE);
+#else
+#ifdef CONFIG_HIGHMEM
+	ioremap_base = (PKMAP_BASE-2*PAGE_SIZE);
+#else
+	ioremap_base = (FIXADDR_START-2*PAGE_SIZE);
+#endif
+#endif /* CONFIG_64BIT */
+
+	ioremap_bot = ioremap_base;
+}
+
 extern void plat_setup(void);
+extern void plat_setup_late(void);
 
 void __init setup_arch(char **cmdline_p)
 {
@@ -540,6 +561,11 @@
 	sparse_init();
 	paging_init();
 	resource_init();
+
+	early_trap_init();
+	early_ioremap_init();
+
+	plat_setup_late();	/* safe to do early ioremap */
 }
 
 int __init fpu_disable(char *s)
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/kernel/traps.c linux-2.6-dev/arch/mips/kernel/traps.c
--- linux-2.6-orig/arch/mips/kernel/traps.c	2005-08-24 17:12:32.000000000 -0700
+++ linux-2.6-dev/arch/mips/kernel/traps.c	2005-08-25 00:39:39.000000000 -0700
@@ -1239,6 +1238,10 @@
 
 void __init trap_init(void)
 {
+}
+
+void __init early_trap_init(void)
+{
 	extern char except_vec3_generic, except_vec3_r4000;
 	extern char except_vec4;
 	unsigned long i;
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/mm/init.c linux-2.6-dev/arch/mips/mm/init.c
--- linux-2.6-orig/arch/mips/mm/init.c	2005-08-10 18:15:55.000000000 -0700
+++ linux-2.6-dev/arch/mips/mm/init.c	2005-08-25 00:39:40.000000000 -0700
@@ -47,6 +47,8 @@
  * don't have to care about aliases on other CPUs.
  */
 unsigned long empty_zero_page, zero_page_mask;
+int mem_init_done;
+extern int init_bootmem_done;
 
 /*
  * Not static inline because used by IP27 special magic initialization code
@@ -200,6 +202,17 @@
 	return 0;
 }
 
+void __init *early_get_page(void)
+{
+	void *p;
+	if (init_bootmem_done) {
+		p = alloc_bootmem_pages(PAGE_SIZE);
+	} else {
+		p = NULL;
+	}
+	return p;
+}
+
 void __init mem_init(void)
 {
 	unsigned long codesize, reservedpages, datasize, initsize;
@@ -258,6 +271,8 @@
 	       datasize >> 10,
 	       initsize >> 10,
 	       (unsigned long) (totalhigh_pages << (PAGE_SHIFT-10)));
+
+	mem_init_done = 1;
 }
 #endif /* !CONFIG_NEED_MULTIPLE_NODES */
 
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/mm/ioremap.c linux-2.6-dev/arch/mips/mm/ioremap.c
--- linux-2.6-orig/arch/mips/mm/ioremap.c	2005-08-10 18:15:55.000000000 -0700
+++ linux-2.6-dev/arch/mips/mm/ioremap.c	2005-08-25 13:35:25.045624752 -0700
@@ -15,6 +15,8 @@
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 
+extern int mem_init_done;
+
 static inline void remap_area_pte(pte_t * pte, unsigned long address,
 	phys_t size, phys_t phys_addr, unsigned long flags)
 {
@@ -141,8 +143,9 @@
 
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
+	 * mem_init() sets high_memory so only do the check after that.
 	 */
-	if (phys_addr < virt_to_phys(high_memory)) {
+	if (mem_init_done && (phys_addr < virt_to_phys(high_memory))) {
 		char *t_addr, *t_end;
 		struct page *page;
 
@@ -164,12 +167,18 @@
 	/*
 	 * Ok, go for it..
 	 */
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-	addr = area->addr;
+	if (mem_init_done) {
+		area = get_vm_area(size, VM_IOREMAP);
+		if (!area)
+			return NULL;
+		addr = area->addr;
+	}
+	else {
+		addr = (void *)(ioremap_bot -= size);
+	}
 	if (remap_area_pages((unsigned long) addr, phys_addr, size, flags)) {
-		vunmap(addr);
+		if (mem_init_done)
+			vunmap(addr);
 		return NULL;
 	}
 
@@ -185,13 +194,15 @@
 	if (IS_KSEG1(addr))
 		return;
 
-	p = remove_vm_area((void *) (PAGE_MASK & (unsigned long __force) addr));
-	if (!p) {
-		printk(KERN_ERR "iounmap: bad address %p\n", addr);
-		return;
-	}
+	if ((unsigned long) addr < ioremap_bot) {
+		p = remove_vm_area((void *) (PAGE_MASK & (unsigned long __force) addr));
+		if (!p) {
+			printk(KERN_ERR "iounmap: bad address %p\n", addr);
+			return;
+		}
 
-        kfree(p);
+		kfree(p);
+	}
 }
 
 EXPORT_SYMBOL(__ioremap);
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/mm/pgtable-32.c linux-2.6-dev/arch/mips/mm/pgtable-32.c
--- linux-2.6-orig/arch/mips/mm/pgtable-32.c	2005-08-10 18:15:56.000000000 -0700
+++ linux-2.6-dev/arch/mips/mm/pgtable-32.c	2005-08-23 00:46:14.000000000 -0700
@@ -13,6 +13,9 @@
 #include <asm/fixmap.h>
 #include <asm/pgtable.h>
 
+unsigned long ioremap_base;
+unsigned long ioremap_bot;
+
 void pgd_init(unsigned long page)
 {
 	unsigned long *p = (unsigned long *) page;
diff -Naur --exclude=CVS linux-2.6-orig/include/asm-mips/io.h linux-2.6-dev/include/asm-mips/io.h
--- linux-2.6-orig/include/asm-mips/io.h	2005-08-10 18:22:04.000000000 -0700
+++ linux-2.6-dev/include/asm-mips/io.h	2005-08-25 13:35:31.000000000 -0700
@@ -637,4 +637,6 @@
  */
 #define xlate_dev_kmem_ptr(p)	p
 
+extern void early_ioremap_init(void);
+
 #endif /* _ASM_IO_H */
diff -Naur --exclude=CVS linux-2.6-orig/include/asm-mips/pgalloc.h linux-2.6-dev/include/asm-mips/pgalloc.h
--- linux-2.6-orig/include/asm-mips/pgalloc.h	2005-08-10 18:22:02.000000000 -0700
+++ linux-2.6-dev/include/asm-mips/pgalloc.h	2005-08-25 01:49:04.000000000 -0700
@@ -67,8 +67,17 @@
 	unsigned long address)
 {
 	pte_t *pte;
+	extern int mem_init_done;
+	extern void *early_get_page(void);
 
-	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, PTE_ORDER);
+	if (mem_init_done) {
+		pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, PTE_ORDER);
+	} else {
+		pte = (pte_t *)early_get_page();
+		if (pte) {
+			clear_page(pte);
+		}
+	}
 
 	return pte;
 }
diff -Naur --exclude=CVS linux-2.6-orig/include/asm-mips/pgtable-32.h linux-2.6-dev/include/asm-mips/pgtable-32.h
--- linux-2.6-orig/include/asm-mips/pgtable-32.h	2005-08-25 13:02:30.000000000 -0700
+++ linux-2.6-dev/include/asm-mips/pgtable-32.h	2005-08-25 01:49:04.000000000 -0700
@@ -19,6 +19,8 @@
 
 #include <asm-generic/pgtable-nopmd.h>
 
+extern unsigned long ioremap_bot, ioremap_base;
+
 /*
  * - add_wired_entry() add a fixed TLB entry, and move wired register
  */
@@ -74,13 +76,9 @@
 #define USER_PTRS_PER_PGD	(0x80000000UL/PGDIR_SIZE)
 #define FIRST_USER_ADDRESS	0
 
-#define VMALLOC_START     MAP_BASE
+#define VMALLOC_START	MAP_BASE
 
-#ifdef CONFIG_HIGHMEM
-# define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
-#else
-# define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
-#endif
+#define VMALLOC_END	ioremap_bot
 
 #ifdef CONFIG_64BIT_PHYS_ADDR
 #define pte_ERROR(e) \
diff -Naur --exclude=CVS linux-2.6-orig/include/asm-mips/traps.h linux-2.6-dev/include/asm-mips/traps.h
--- linux-2.6-orig/include/asm-mips/traps.h	2005-08-10 18:22:04.000000000 -0700
+++ linux-2.6-dev/include/asm-mips/traps.h	2005-08-25 10:56:01.000000000 -0700
@@ -24,4 +24,6 @@
 extern void (*board_nmi_handler_setup)(void);
 extern void (*board_ejtag_handler_setup)(void);
 
+extern void early_trap_init(void);
+
 #endif /* _ASM_TRAPS_H */
