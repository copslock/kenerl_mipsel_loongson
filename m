Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g646R0Rw008613
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 3 Jul 2002 23:27:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g646R0Aq008612
	for linux-mips-outgoing; Wed, 3 Jul 2002 23:27:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from r-bu.iij4u.or.jp (r-bu.iij4u.or.jp [210.130.0.89])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g646QaRw008597
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 23:26:36 -0700
Received: from pudding ([202.216.29.50])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id g646UaG02192
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 15:30:36 +0900 (JST)
Date: Thu, 4 Jul 2002 15:26:20 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: linux-mips@oss.sgi.com
Subject: patch for little problems
Message-Id: <20020704152620.47209cdd.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan Inc.
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__4_Jul_2002_15:26:20_+0900_08259f40"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

--Multipart_Thu__4_Jul_2002_15:26:20_+0900_08259f40
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Here is a patch for small problems.
This patch can keep silent about some warning from gcc.

Please commit linux_2_4 tag on CVS.

-Yoichi

--Multipart_Thu__4_Jul_2002_15:26:20_+0900_08259f40
Content-Type: text/plain;
 name="little-problems.patch"
Content-Disposition: attachment;
 filename="little-problems.patch"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/pci-dma.c linux/arch/mips/kernel/pci-dma.c
--- linux.orig/arch/mips/kernel/pci-dma.c	Mon Nov 26 20:14:37 2001
+++ linux/arch/mips/kernel/pci-dma.c	Wed Jul  3 18:59:44 2002
@@ -30,7 +30,7 @@
 		memset(ret, 0, size);
 #ifdef CONFIG_NONCOHERENT_IO
 		dma_cache_wback_inv((unsigned long) ret, size);
-		ret = KSEG1ADDR(ret);
+		ret = (void *)KSEG1ADDR(ret);
 #endif
 		*dma_handle = virt_to_bus(ret);
 	}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/scall_o32.S linux/arch/mips/kernel/scall_o32.S
--- linux.orig/arch/mips/kernel/scall_o32.S	Wed Jul  3 11:19:27 2002
+++ linux/arch/mips/kernel/scall_o32.S	Wed Jul  3 19:00:33 2002
@@ -17,6 +17,9 @@
 #include <asm/sysmips.h>
 #include <asm/unistd.h>
 
+/* This duplicates the definition from <linux/sched.h> */
+#define PT_TRACESYS	0x00000002		/* tracing system calls */
+
 /* Highest syscall used of any syscall flavour */
 #define MAX_SYSCALL_NO	__NR_Linux + __NR_Linux_syscalls
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/setup.c linux/arch/mips/kernel/setup.c
--- linux.orig/arch/mips/kernel/setup.c	Mon Jul  1 11:46:55 2002
+++ linux/arch/mips/kernel/setup.c	Wed Jul  3 19:01:22 2002
@@ -517,8 +517,6 @@
 asmlinkage void __init
 init_arch(int argc, char **argv, char **envp, int *prom_vec)
 {
-	unsigned int s;
-
 	/* Determine which MIPS variant we are running on. */
 	cpu_probe();
 
@@ -866,7 +864,7 @@
 		max_low_pfn = MAXMEM_PFN;
 #ifndef CONFIG_HIGHMEM
 		/* Maximum memory usable is what is directly addressable */
-		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
+		printk(KERN_WARNING "Warning only %dMB will be used.\n",
 		       MAXMEM>>20);
 		printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
 #endif
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux.orig/arch/mips/kernel/traps.c	Wed Jul  3 11:19:27 2002
+++ linux/arch/mips/kernel/traps.c	Wed Jul  3 19:02:19 2002
@@ -67,6 +67,8 @@
 
 extern int fpu_emulator_cop1Handler(struct pt_regs *);
 
+extern void dump_tlb_all(void);
+
 char watch_available = 0;
 
 int (*be_board_handler)(struct pt_regs *regs, int is_fixup);
@@ -705,8 +707,6 @@
 
 asmlinkage void do_watch(struct pt_regs *regs)
 {
-	extern void dump_tlb_all(void);
-
 	/*
 	 * We use the watch exception where available to detect stack
 	 * overflows.
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/lib/dump_tlb.c linux/arch/mips/lib/dump_tlb.c
--- linux.orig/arch/mips/lib/dump_tlb.c	Mon Feb 25 20:25:17 2002
+++ linux/arch/mips/lib/dump_tlb.c	Wed Jul  3 19:03:24 2002
@@ -32,6 +32,7 @@
 	case PM_256M:	return "256Mb";
 #endif
 	}
+	return "unknown";
 }
 
 void dump_tlb(int first, int last)
@@ -153,8 +154,8 @@
 	addr = (unsigned int) address;
 
 	printk("Addr                 == %08x\n", addr);
-	printk("task                 == %08p\n", t);
-	printk("task->mm             == %08p\n", t->mm);
+	printk("task                 == %p\n", t);
+	printk("task->mm             == %p\n", t->mm);
 	//printk("tasks->mm.pgd        == %08x\n", (unsigned int) t->mm->pgd);
 
 	if (addr > KSEG0)
@@ -179,7 +180,7 @@
 #ifdef CONFIG_64BIT_PHYS_ADDR
 	printk("page == %08Lx\n", (unsigned long long) pte_val(page));
 #else
-	printk("page == %08lx\n", (unsigned int) pte_val(page));
+	printk("page == %08x\n", (unsigned int) pte_val(page));
 #endif
 
 	val = pte_val(page);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/mm/fault.c linux/arch/mips/mm/fault.c
--- linux.orig/arch/mips/mm/fault.c	Thu Jun 27 14:14:14 2002
+++ linux/arch/mips/mm/fault.c	Thu Jul  4 11:02:37 2002
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/version.h>
+#include <linux/vt_kern.h>
 
 #include <asm/branch.h>
 #include <asm/hardirq.h>
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/mm/init.c linux/arch/mips/mm/init.c
--- linux.orig/arch/mips/mm/init.c	Thu Jun 27 14:14:15 2002
+++ linux/arch/mips/mm/init.c	Thu Jul  4 11:01:47 2002
@@ -161,6 +161,8 @@
 extern char _ftext, _etext, _fdata, _edata;
 extern char __init_begin, __init_end;
 
+#ifdef CONFIG_HIGHMEM
+
 static void __init fixrange_init (unsigned long start, unsigned long end,
 	pgd_t *pgd_base)
 {
@@ -190,12 +192,17 @@
 	}
 }
 
+#endif
+
 void __init pagetable_init(void)
 {
+	pgd_t *pgd_base;
+#ifdef CONFIG_HIGHMEM
 	unsigned long vaddr;
-	pgd_t *pgd, *pgd_base;
+	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
+#endif
 
 	/* Initialize the entire pgd.  */
 	pgd_init((unsigned long)swapper_pg_dir);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/tools/offset.c linux/arch/mips/tools/offset.c
--- linux.orig/arch/mips/tools/offset.c	Wed Jul  3 11:19:31 2002
+++ linux/arch/mips/tools/offset.c	Thu Jul  4 11:11:06 2002
@@ -82,7 +82,6 @@
 	text("/* MIPS task_struct offsets. */");
 	offset("#define TASK_STATE         ", struct task_struct, state);
 	offset("#define TASK_FLAGS         ", struct task_struct, flags);
-	constant("  #define PT_TRACESYS        ", PT_TRACESYS);
 	offset("#define TASK_SIGPENDING    ", struct task_struct, sigpending);
 	offset("#define TASK_NEED_RESCHED  ", struct task_struct, need_resched);
 	offset("#define TASK_PTRACE        ", struct task_struct, ptrace);
@@ -92,7 +91,6 @@
 	offset("#define TASK_PROCESSOR     ", struct task_struct, processor);
 	offset("#define TASK_PID           ", struct task_struct, pid);
 	size(  "#define TASK_STRUCT_SIZE   ", struct task_struct);
-	constant("#define PT_TRACESYS        ", PT_TRACESYS);
 	linefeed;
 }
 

--Multipart_Thu__4_Jul_2002_15:26:20_+0900_08259f40--
