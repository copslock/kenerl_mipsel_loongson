Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0J8JWZ24597
	for linux-mips-outgoing; Sat, 19 Jan 2002 00:19:32 -0800
Received: from crack-ext.ab.videon.ca (crack-ext.ab.videon.ca [206.75.216.33])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0J8I1P24577
	for <linux-mips@oss.sgi.com>; Sat, 19 Jan 2002 00:18:01 -0800
Received: (qmail 14966 invoked from network); 19 Jan 2002 07:17:56 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.86.210.128]) (envelope-sender <jgg@debian.org>)
          by crack-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <linux-mips@oss.sgi.com>; 19 Jan 2002 07:17:55 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16RplD-0003Ql-00
	for <linux-mips@oss.sgi.com>; Sat, 19 Jan 2002 00:17:55 -0700
Date: Sat, 19 Jan 2002 00:17:54 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
Reply-To: Jason Gunthorpe <jgg@debian.org>
To: linux-mips@oss.sgi.com
Subject: [PATCH] SR7100 support
Message-ID: <Pine.LNX.3.96.1020118235537.12785A-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hello, 

Here is a patch to add support for the new SandCraft SR7100 processor. The
SR7100 is a faster pin compatible replacement for the RM7000 family of
chips but implements MIPS64 and has a different cache configuration.

This patch includes a fix for 1 errata in current chips, the wait
instruction doesn't work quite right. It is possible to omit this (ugly!)
fix but the CPU runs a little hot.. :>

The patch is against the linux_2_4 branch of CVS, I have not yet tried
HEAD.. 

Jason

diff --exclude CVS -bBrNu ./arch/mips/Makefile ../linux_2_4_branch/arch/mips/Makefile
--- ./arch/mips/Makefile	Fri Jan 18 23:35:38 2002
+++ ../linux_2_4_branch/arch/mips/Makefile	Fri Jan 18 23:38:57 2002
@@ -93,6 +93,9 @@
 MODFLAGS       += -msb1-pass1-workarounds
 endif
 endif
+ifdef CONFIG_CPU_SR7100
+GCCFLAGS	+= -mcpu=r5000 -mips2 -Wa,--trap
+endif
 
 GCCFLAGS	+= -pipe
 
diff --exclude CVS -bBrNu ./arch/mips/config.in ../linux_2_4_branch/arch/mips/config.in
--- ./arch/mips/config.in	Fri Jan 18 23:35:39 2002
+++ ../linux_2_4_branch/arch/mips/config.in	Fri Jan 18 23:39:09 2002
@@ -331,6 +331,7 @@
 	 R5000 CONFIG_CPU_R5000	\
 	 R5432 CONFIG_CPU_R5432 \
 	 RM7000 CONFIG_CPU_RM7000 \
+	 SR7100 CONFIG_CPU_SR7100 \
 	 R52xx CONFIG_CPU_NEVADA \
 	 R10000 CONFIG_CPU_R10000 \
 	 SB1    CONFIG_CPU_SB1    \
diff --exclude CVS -bBrNu ./arch/mips/kernel/Makefile ../linux_2_4_branch/arch/mips/kernel/Makefile
--- ./arch/mips/kernel/Makefile	Fri Jan 18 23:35:39 2002
+++ ../linux_2_4_branch/arch/mips/kernel/Makefile	Sat Jan 12 15:54:45 2002
@@ -39,6 +39,7 @@
 obj-$(CONFIG_CPU_SB1)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS64)	+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_SR7100)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R6000)		+= r6000_fpu.o r4k_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
diff --exclude CVS -bBrNu ./arch/mips/kernel/entry.S ../linux_2_4_branch/arch/mips/kernel/entry.S
--- ./arch/mips/kernel/entry.S	Fri Jan 18 23:35:39 2002
+++ ../linux_2_4_branch/arch/mips/kernel/entry.S	Sun Jan 13 00:57:24 2002
@@ -50,7 +50,29 @@
 		lw	t0, PT_STATUS(sp)	# returning to kernel mode?
 		andi	t0, t0, KU_USER
 		bnez	t0, ret_from_sys_call
+EXPORT(ret_from_irq_sr7100)
 		j	restore_all
+
+/* SR7100 Errata: The wait instruction that does not advance EPC. The solution
+   is to check if epc is pointing at a wait instruction and if so, skip it.
+   This must be after ret_from_irq. The setup code will nop out the jump above 
+   so we fall through. wait instructions are only fixed if they are in the 
+   kernel */
+#ifdef CONFIG_CPU_SR7100
+                // Fetch EPC
+		lw      t0,PT_EPC(sp)
+				
+		// Is the instruction a wait?
+		li      t2,0x42000000
+		lw      t1,0(t0)
+		ori     t2,t2,0x20
+		bne     t1,t2,restore_all
+		
+		// Yep, go to the next instruction
+		addu    t1,t0,4
+		sw      t1,PT_EPC(sp)
+		j restore_all
+#endif
 
 reschedule:	jal	schedule 
 
diff --exclude CVS -bBrNu ./arch/mips/kernel/setup.c ../linux_2_4_branch/arch/mips/kernel/setup.c
--- ./arch/mips/kernel/setup.c	Fri Jan 18 23:35:39 2002
+++ ../linux_2_4_branch/arch/mips/kernel/setup.c	Fri Jan 18 23:40:56 2002
@@ -46,6 +46,7 @@
 #ifndef CONFIG_SMP
 struct cpuinfo_mips cpu_data[1];
 #endif
+#include <asm/cacheops.h>
 
 /*
  * Not all of the MIPS CPUs have the "wait" instruction available. Moreover,
@@ -121,10 +122,12 @@
 extern void SetUpBootInfo(void);
 extern void loadmmu(void);
 extern asmlinkage void start_kernel(void);
+extern asmlinkage void ret_from_irq_sr7100(void);
 extern void prom_init(int, char **, char **, int *);
 
 static struct resource code_resource = { "Kernel code" };
 static struct resource data_resource = { "Kernel data" };
+static void sr7100_wait(void);
 
 static inline void check_wait(void)
 {
@@ -153,6 +156,11 @@
 		cpu_wait = r4k_wait;
 		printk(" available.\n");
 		break;
+	   
+        case CPU_SR7100:
+		cpu_wait = sr7100_wait;
+		printk(" errata work around.\n");
+	        break;
 	default:
 		printk(" unavailable.\n");
 		break;
@@ -519,6 +527,21 @@
 			break;
 		}
 		break;
+	   
+	case PRID_COMP_SANDCRAFT:
+		mips_cpu.cputype = CPU_UNKNOWN;
+		switch (mips_cpu.processor_id & 0xff00) {
+			case PRID_IMP_SR7100:
+			mips_cpu.cputype = CPU_SR7100;
+			mips_cpu.isa_level = MIPS_CPU_ISA_M64;
+			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
+		                           MIPS_CPU_4KTLB | MIPS_CPU_FPU |
+			                   MIPS_CPU_COUNTER | MIPS_CPU_DIVEC |
+			                   MIPS_CPU_MCHECK;
+			mips_cpu.scache.ways = 8;
+			break;
+		}
+		break;
 	default:
 		mips_cpu.cputype = CPU_UNKNOWN;
 	}
@@ -802,6 +825,7 @@
                 hp_setup();
                 break;
 #endif
+	   
 	default:
 		panic("Unsupported architecture");
 	}
@@ -986,6 +1010,39 @@
 	__asm__(".set\tmips3\n\t"
 		"wait\n\t"
 		".set\tmips0");
+}
+
+/* Fix the sr7100 wait errata. We have a special ret_from_irq that is executed
+   when a jump is converted to a nop. Before we wait we do that conversion.
+   This engages the code that detects the errata. This way we don't loose any
+   speed in the normal case. Though it does make the timing race with wait 
+   longer.. */
+static void sr7100_wait(void)
+{
+   u32 *jump = ((u32 *)&ret_from_irq_sr7100);
+   __asm__ __volatile__
+      (
+       ".set push\n\t"
+       ".set noat\n\t"
+       ".set noreorder\n\t"
+       ".set mips3\n\t"
+       "lw $1,0(%0)\n\t"
+       "sw $0,0(%0)\n\t"
+       
+       // No snoopy i/d cache..
+       "cache %1,0(%0)\n\t"
+       "cache %2,0(%0)\n\t"
+       
+       "wait\n\t"
+       "sw $1,0(%0)\n\t"
+       
+       "cache %1,0(%0)\n\t"
+       "cache %2,0(%0)\n\t"
+       
+       ".set pop\n\t"
+       :
+       : "r" (jump), "i"(Hit_Writeback_D), "i"(Hit_Invalidate_I)
+       : "$1");
 }
 
 int __init fpu_disable(char *s)
diff --exclude CVS -bBrNu ./arch/mips/mm/Makefile ../linux_2_4_branch/arch/mips/mm/Makefile
--- ./arch/mips/mm/Makefile	Fri Jan 18 23:35:39 2002
+++ ../linux_2_4_branch/arch/mips/mm/Makefile	Sat Jan 12 15:59:04 2002
@@ -30,6 +30,7 @@
 obj-$(CONFIG_CPU_R10000)	+= pg-andes.o c-andes.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_MIPS32)	+= pg-mips32.o c-mips32.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_MIPS64)	+= pg-mips32.o c-mips32.o tlb-r4k.o tlbex-r4k.o
+obj-$(CONFIG_CPU_SR7100)	+= pg-mips32.o c-sr7100.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_SB1)		+= pg-sb1.o c-sb1.o tlb-sb1.o tlbex-r4k.o
 
 obj-$(CONFIG_SGI_IP22)		+= umap.o
diff --exclude CVS -bBrNu ./arch/mips/mm/c-sr7100.c ../linux_2_4_branch/arch/mips/mm/c-sr7100.c
--- ./arch/mips/mm/c-sr7100.c	Wed Dec 31 17:00:00 1969
+++ ../linux_2_4_branch/arch/mips/mm/c-sr7100.c	Fri Jan 18 23:43:40 2002
@@ -0,0 +1,584 @@
+/*
+  Jason Gunthorpe <jgg@yottayotta.com>
+  Copyright (C) 2002 YottaYotta. Inc.
+   
+  Based on c-mips32:
+  Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
+  Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+
+  This file is subject to the terms and conditions of the GNU General Public
+  License.  See the file "COPYING" in the main directory of this archive
+  for more details.
+   
+  Sandcraft SR7100 cache routines. 
+  The SR7100 is a MIPS64 compatible CPU with 4 caches:
+   * 4 way 32K primary ICache - virtually indexed/physically tagged
+   * 4 way 32K primary DCache - virtually indexed/physically tagged
+   * 8 way 512K secondary cache - physically indexed/taged
+   * 8 way up to 16M tertiary cache - physically indexed/taged (and off chip)
+   
+  ICache and DCache do not have any sort of snooping. Unlike the RM7k,
+  the virtual index is 13 bits, and we use a 4k page size. This means you 
+  can have cache aliasing effects, so they have to be treated as virtually
+  tagged. (unless that can be solved elsewhere, should investigate)
+
+  Note that on this chip all the _SD type cache ops (ie Hit_Writeback_Inv_SD)
+  are really just _S. This is in line with what the MIPS64 spec permits.
+  Also, the line size of the tertiary cache is really the block size. The
+  line size is always 32 bytes. The chip can tag partial blocks and the cache
+  op instructions work on those partial blocks too. 
+  
+  See ./Documentation/cachetlb.txt
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cpu.h>
+#include <asm/bcache.h>
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/mmu_context.h>
+
+// Should move to mipsregs.h 
+#define read_32bit_cp0_registerx(source,sel)                    \
+({ int __res;                                                   \
+        __asm__ __volatile__(                                   \
+	".set\tpush\n\t"					\
+	".set\treorder\n\t"					\
+	".set\tmips64\n\t"					\
+        "mfc0\t%0,"STR(source)","STR(sel)"\n\t"                 \
+	".set\tmips0\n\t"					\
+	".set\tpop"						\
+        : "=r" (__res));                                        \
+        __res;})
+#define write_32bit_cp0_registerx(register,sel,value)           \
+        __asm__ __volatile__(                                   \
+	".set\tmips64\n\t"					\
+        "mtc0\t%0,"STR(register)","STR(sel)"\n\t"		\
+	".set\tmips0\n\t"					\
+	"nop"							\
+        : : "r" (value));
+
+#undef DEBUG_CACHE
+
+/* Primary cache parameters. */
+int icache_size, dcache_size; 			/* Size in bytes */
+int ic_lsize, dc_lsize;				/* LineSize in bytes */
+
+/* Secondary cache parameters. */
+unsigned int scache_size, sc_lsize;		/* Again, in bytes */
+
+/* tertiary cache (if present) parameters. */
+unsigned int tcache_size, tc_lsize;		/* Again, in bytes */
+
+#include <asm/cacheops.h>
+#include <asm/mips32_cache.h>
+
+// Unique the SR7100
+#define Index_Invalidate_T 0x2
+#define Hit_Invalidate_T 0x16
+static inline void blast_tcache(void)
+{
+	unsigned long start = KSEG0;
+	unsigned long end = KSEG0 + tcache_size;
+	
+	// Could use flash invalidate perhaps..
+	while(start < end)
+	{
+		cache_unroll(start,Index_Invalidate_T);
+		start += tc_lsize;
+	}	
+}
+
+static inline void flush_tcache_line(unsigned long addr)
+{
+	__asm__ __volatile__
+		(
+		 ".set noreorder\n\t"
+		 ".set mips3\n\t"
+		 "cache %1, (%0)\n\t"
+		 ".set mips0\n\t"
+		 ".set reorder"
+		 :
+		 : "r" (addr),
+		 "i" (Hit_Invalidate_T));
+}
+
+/*
+ * Dummy cache handling routines for machines without boardcaches
+ */
+static void no_sc_noop(void) {}
+
+static struct bcache_ops no_sc_ops = {
+	(void *)no_sc_noop, (void *)no_sc_noop,
+	(void *)no_sc_noop, (void *)no_sc_noop
+};
+struct bcache_ops *bcops = &no_sc_ops;
+
+// Clean all virtually indexed caches
+static inline void sr7100_flush_cache_all_pc(void)
+{
+	unsigned long flags;
+
+	__save_and_cli(flags);
+	blast_dcache(); blast_icache();
+	__restore_flags(flags);
+}
+
+// This clears all caches. It is only used from a syscall..
+static inline void sr7100_nuke_caches(void)
+{
+	unsigned long flags;
+
+	__save_and_cli(flags);
+	blast_dcache(); blast_icache(); blast_scache();
+	if (tcache_size != 0)
+		blast_tcache();
+	__restore_flags(flags);
+}
+
+/* This is called to clean out a virtual mapping. We only need to flush the
+   I and D caches since the other two are physically tagged */
+static void sr7100_flush_cache_range_pc(struct mm_struct *mm,
+				     unsigned long start,
+				     unsigned long end)
+{
+	if(mm->context != 0) {
+		unsigned long flags;
+
+#ifdef DEBUG_CACHE
+		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
+#endif
+		__save_and_cli(flags);
+		blast_dcache(); blast_icache();
+		__restore_flags(flags);
+	}
+}
+
+/*
+ * On architectures like the Sparc, we could get rid of lines in
+ * the cache created only by a certain context, but on the MIPS
+ * (and actually certain Sparc's) we cannot.
+ * Again, only clean the virtually tagged cache.
+ */
+static void sr7100_flush_cache_mm_pc(struct mm_struct *mm)
+{
+	if(mm->context != 0) {
+#ifdef DEBUG_CACHE
+		printk("cmm[%d]", (int)mm->context);
+#endif
+		sr7100_flush_cache_all_pc();
+	}
+}
+
+static void sr7100_flush_cache_page_pc(struct vm_area_struct *vma,
+				    unsigned long page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
+	pgd_t *pgdp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	/*
+	 * If ownes no valid ASID yet, cannot possibly have gotten
+	 * this page into the cache.
+	 */
+	if (mm->context == 0)
+		return;
+
+#ifdef DEBUG_CACHE
+	printk("cpage[%d,%08lx]", (int)mm->context, page);
+#endif
+	__save_and_cli(flags);
+	page &= PAGE_MASK;
+	pgdp = pgd_offset(mm, page);
+	pmdp = pmd_offset(pgdp, page);
+	ptep = pte_offset(pmdp, page);
+
+	/*
+	 * If the page isn't marked valid, the page cannot possibly be
+	 * in the cache.
+	 */
+	if (!(pte_val(*ptep) & _PAGE_VALID))
+		goto out;
+
+	/*
+	 * Doing flushes for another ASID than the current one is
+	 * too difficult since Mips32 caches do a TLB translation
+	 * for every cache flush operation.  So we do indexed flushes
+	 * in that case, which doesn't overly flush the cache too much.
+	 */
+	if (mm == current->active_mm) {
+		blast_dcache_page(page);
+	} else {
+		/* Do indexed flush, too much work to get the (possible)
+		 * tlb refills to work correctly.
+		 */
+		page = (KSEG0 + (page & (dcache_size - 1)));
+		blast_dcache_page_indexed(page);
+	}
+out:
+	__restore_flags(flags);
+}
+
+/* If the addresses passed to these routines are valid, they are
+ * either:
+ *
+ * 1) In KSEG0, so we can do a direct flush of the page.
+ * 2) In KSEG2, and since every process can translate those
+ *    addresses all the time in kernel mode we can do a direct
+ *    flush.
+ * 3) In KSEG1, no flush necessary.
+ */
+static void sr7100_flush_page_to_ram_pc(struct page *page)
+{
+	blast_dcache_page((unsigned long)page_address(page));
+}
+
+/* I-Cache and D-Cache are seperate and virtually tagged, these need to
+   flush them */
+static void sr7100_flush_icache_range(unsigned long start, unsigned long end)
+{
+	flush_cache_all();  // only does i and d, probably excessive
+}
+
+static void sr7100_flush_icache_page(struct vm_area_struct *vma,
+				     struct page *page)
+{
+	int address;
+
+	if (!(vma->vm_flags & VM_EXEC))
+		return;
+
+	address = KSEG0 + ((unsigned long)page_address(page) & PAGE_MASK & (dcache_size - 1));
+	blast_icache_page_indexed(address);
+}
+
+/* Writeback and invalidate the primary cache dcache before DMA.
+   See asm-mips/io.h 
+ */
+static void sr7100_dma_cache_wback_inv_sc(unsigned long addr,
+					  unsigned long size)
+{
+	unsigned long end, a;
+
+	if (size >= scache_size) {
+		sr7100_nuke_caches();
+		return;
+	}
+
+	a = addr & ~(sc_lsize - 1);
+	end = (addr + size) & ~(sc_lsize - 1);
+	while (1) {
+		flush_dcache_line(a);
+		flush_scache_line(a); // Hit_Writeback_Inv_SD
+		if (a == end) break;
+		a += sc_lsize;
+	}
+}
+
+static void sr7100_dma_cache_wback_inv_tc(unsigned long addr,
+					  unsigned long size)
+{
+	unsigned long end, a;
+
+	a = addr & ~(sc_lsize - 1);
+	end = (addr + size) & ~(sc_lsize - 1);
+	while (1) {
+		flush_dcache_line(a);
+		flush_scache_line(a); // Hit_Writeback_Inv_SD
+		flush_tcache_line(a); // Hit_Invalidate_T
+		if (a == end) break;
+		a += sc_lsize;
+	}
+}
+
+/* It is kind of silly to writeback for the inv case.. Oh well */
+static void sr7100_dma_cache_inv_sc(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+	if (size >= scache_size) {
+		sr7100_nuke_caches();
+		return;
+	}
+
+	a = addr & ~(sc_lsize - 1);
+	end = (addr + size) & ~(sc_lsize - 1);
+	while (1) {
+		flush_dcache_line(a);
+		flush_scache_line(a); // Hit_Writeback_Inv_SD 
+		if (a == end) break;
+		a += sc_lsize;
+	}
+}
+
+static void sr7100_dma_cache_inv_tc(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+	a = addr & ~(sc_lsize - 1);
+	end = (addr + size) & ~(sc_lsize - 1);
+	while (1) {
+		flush_dcache_line(a);
+		flush_scache_line(a); // Hit_Writeback_Inv_SD
+		flush_tcache_line(a); // Hit_Invalidate_T
+		if (a == end) break;
+		a += sc_lsize;
+	}
+}
+
+static void sr7100_dma_cache_wback(unsigned long addr, unsigned long size)
+{
+	panic("sr7100_dma_cache_wback called - should not happen.");
+}
+
+/*
+ * While we're protected against bad userland addresses we don't care
+ * very much about what happens in that case.  Usually a segmentation
+ * fault will dump the process later on anyway ...
+ */
+static void sr7100_flush_cache_sigtramp(unsigned long addr)
+{
+	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
+	protected_flush_icache_line(addr & ~(ic_lsize - 1));
+}
+
+/* Detect and size the various caches. */
+static void __init probe_icache(unsigned long config,unsigned long config1)
+{
+	unsigned int lsize;
+
+	config1 = read_mips32_cp0_config1(); 
+	
+	if ((lsize = ((config1 >> 19) & 7)))
+		mips_cpu.icache.linesz = 2 << lsize;
+	else 
+		mips_cpu.icache.linesz = lsize;
+	mips_cpu.icache.sets = 64 << ((config1 >> 22) & 7);
+	mips_cpu.icache.ways = 1 + ((config1 >> 16) & 7);
+	
+	ic_lsize = mips_cpu.icache.linesz;
+	icache_size = mips_cpu.icache.sets * mips_cpu.icache.ways * 
+		ic_lsize;
+	printk("Primary instruction cache %dkb, linesize %d bytes (%d ways)\n",
+	       icache_size >> 10, ic_lsize, mips_cpu.icache.ways);
+}
+
+static void __init probe_dcache(unsigned long config,unsigned long config1)
+{
+	unsigned int lsize;
+
+	if ((lsize = ((config1 >> 10) & 7)))
+		mips_cpu.dcache.linesz = 2 << lsize;
+	else 
+		mips_cpu.dcache.linesz = lsize;
+	mips_cpu.dcache.sets = 64 << ((config1 >> 13) & 7);
+	mips_cpu.dcache.ways = 1 + ((config1 >> 7) & 7);
+	
+	dc_lsize = mips_cpu.dcache.linesz;
+	dcache_size = 
+		mips_cpu.dcache.sets * mips_cpu.dcache.ways
+		* dc_lsize;
+	printk("Primary data cache %dkb, linesize %d bytes (%d ways)\n",
+	       dcache_size >> 10, dc_lsize, mips_cpu.dcache.ways);
+}
+
+static void __init probe_scache(unsigned long config,unsigned long config2)
+{
+	unsigned int lsize;
+
+	if ((lsize = ((config2 >> 4) & 7)))
+		mips_cpu.scache.linesz = 2 << lsize;
+	else 
+		mips_cpu.scache.linesz = lsize;
+	
+	mips_cpu.scache.sets = 64 << ((config2 >> 8) & 7);
+	mips_cpu.scache.ways = 1 + ((config2 >> 0) & 7);
+
+	sc_lsize = mips_cpu.scache.linesz;
+	scache_size = mips_cpu.scache.sets * mips_cpu.scache.ways * sc_lsize;
+	
+	printk("Secondary cache %dK, linesize %d bytes (%d ways)\n",
+	       scache_size >> 10, sc_lsize, mips_cpu.scache.ways);
+}
+
+static void __init probe_tcache(unsigned long config,unsigned long config2)
+{
+	unsigned int lsize;
+
+	/* Firmware or prom_init is required to configure the size of the 
+	   tertiary cache in config2 and set the TE bit in config2 to signal 
+	   the external SRAM chips are present. */
+	if ((config2 & (1<<28)) == 0)
+		return;
+	
+	if ((lsize = ((config2 >> 20) & 7)))
+		mips_cpu.tcache.linesz = 2 << lsize;
+	else 
+		mips_cpu.tcache.linesz = lsize;
+	
+	mips_cpu.tcache.sets = 64 << ((config2 >> 24) & 7);
+	mips_cpu.tcache.ways = 1 + ((config2 >> 16) & 7);
+
+	tc_lsize = mips_cpu.tcache.linesz;
+	tcache_size = mips_cpu.tcache.sets * mips_cpu.tcache.ways * tc_lsize;
+	
+	printk("Tertiary cache %dK, linesize %d bytes, blocksize %d "
+	       "bytes (%d ways)\n",
+	       tcache_size >> 10, sc_lsize, tc_lsize, mips_cpu.tcache.ways);
+}
+
+static void __init setup_scache_funcs(void)
+{
+        _flush_cache_all = sr7100_flush_cache_all_pc;
+        ___flush_cache_all = sr7100_nuke_caches;
+	_flush_cache_mm = sr7100_flush_cache_mm_pc;
+	_flush_cache_range = sr7100_flush_cache_range_pc;
+	_flush_cache_page = sr7100_flush_cache_page_pc;
+	_flush_page_to_ram = sr7100_flush_page_to_ram_pc;
+	_clear_page = (void *)mips32_clear_page_sc;
+	_copy_page = (void *)mips32_copy_page_sc;
+
+	_flush_icache_page = sr7100_flush_icache_page;
+
+	if (tcache_size == 0)
+	{
+		_dma_cache_wback_inv = sr7100_dma_cache_wback_inv_sc;
+		_dma_cache_inv = sr7100_dma_cache_inv_sc;
+	}
+	else
+	{
+		_dma_cache_wback_inv = sr7100_dma_cache_wback_inv_tc;
+		_dma_cache_inv = sr7100_dma_cache_inv_tc;
+	}
+		
+	_dma_cache_wback = sr7100_dma_cache_wback;
+}
+
+/* This implements the cache intialization stuff from the SR7100 guide. After
+   this all the caches will be empty and ready to run. It must be run from
+   uncached space. */
+static void __init clear_enable_caches(unsigned long config)
+{
+	config = (config & (~CONF_CM_CMASK)) | CONF_CM_CACHABLE_NONCOHERENT;
+	
+	/* Primary cache init (7.1.1)
+	   SR71000 Primary Cache initialization of 4-way, 32 Kbyte line I/D 
+	   caches. */
+	__asm__ __volatile__ 
+		(
+		 ".set push\n"
+		 ".set noreorder\n"
+		 ".set noat\n"
+		 ".set mips64\n"
+		 
+		 // Enable KSEG0 caching
+		 " mtc0 %0, $16\n"
+		 
+		 /* It is recommended that parity be disabled during cache 
+		    initialization. */
+		 " mfc0 $1, $12\n"      // Read CP0 Status Register.
+		 " li $2, 0x00010000\n" // DE Bit.
+		 " or $2, $1, $2\n"
+		 " mtc0 $2, $12\n"     // Disable Parity.
+		 
+		 " ori $3, %1, 0x1FE0\n" // 256 sets.
+		 " mtc0 $0, $28\n" // Set CP0 Tag_Lo Register
+		 "1:\n"
+		 " cache 8, 0x0000($3)\n" // Index_Store_Tag_I
+		 " cache 8, 0x2000($3)\n" // Index_Store_Tag_I
+		 " cache 8, 0x4000($3)\n" // Index_Store_Tag_I
+		 " cache 8, 0x6000($3)\n" // Index_Store_Tag_I
+		 " cache 9, 0x0000($3)\n" // Index_Store_Tag_D
+		 " cache 9, 0x2000($3)\n" // Index_Store_Tag_D
+		 " cache 9, 0x4000($3)\n" // Index_Store_Tag_D
+		 " cache 9, 0x6000($3)\n" // Index_Store_Tag_D
+		 " bne $3, %1, 1b\n"
+		 " addiu $3, $3, -0x0020\n" // 32 byte cache line
+		 " mtc0 $1, $12\n" // Put original back in Status Register.
+		 ".set pop\n"
+		 :
+		 : "r"(config), "r"(KSEG0) 
+		 : "$1","$2","$3");
+		 // Fixme: use settings from config register not hardwired
+		 
+	/* Secondary and tertiary flash invalidate (7.5.18)	   
+	    This code fragment, invalidates (also disables), and
+	    restores (re-enables) the secondary and tertiary caches.
+	    Ensure system is operating in uncached space. */
+	__asm__ __volatile__ 
+		 (
+		 ".set push\n"
+		 ".set noreorder\n"
+		 ".set noat\n"
+		 ".set mips64\n"
+		 "  sync\n"   // flush core pipeline
+		 "  lw $2, 0(%0)\n"             // flush pending accesses
+		 "  bne $2, $2, 1f\n"           // prevent I-fetches
+		 "  nop\n"
+		 "1: mfc0 $1, $16, 2\n"        // save current Config2
+		 "  li $2, 0x20002000\n"        // set flash invalidation bits
+		 "  or $2, $1, $2\n"
+		 "  mtc0 $2, $16, 2\n" // invalidate & disable caches
+		 "  mtc0 $1, $16, 2\n" // restore Config2
+		 ".set pop\n"
+		 :
+		 : "r"(KSEG1)
+		 : "$1","$2");		 
+}
+
+void __init ld_mmu_sr7100(void)
+{
+	unsigned long config = read_32bit_cp0_registerx(CP0_CONFIG,0);
+	unsigned long config1 = read_32bit_cp0_registerx(CP0_CONFIG,1);
+	unsigned long config2 = read_32bit_cp0_registerx(CP0_CONFIG,2);
+	void (*kseg1_cec)(unsigned long config) = (void *)KSEG1ADDR(&clear_enable_caches);
+
+	// Should never happen
+        if (!(config & (1 << 31)) || !(config1 & (1 << 31)))
+		panic("sr7100 does not have necessary config registers");
+
+	/* We should be uncached for this.. If the firmware has enabled
+	   the cache it may have dirty data and we really need to flush
+	   it before doing a mass invalidate, on the other hand if the
+	   cache has not been inited flushing it could corrupt ram.. */
+	if ((config & CONF_CM_CMASK) != CONF_CM_UNCACHED)
+	{
+		printk("Turning off cache.\n");
+		change_cp0_config(CONF_CM_CMASK,CONF_CM_UNCACHED);
+		
+		// flush core pipeline
+		__asm__ __volatile__ ("  sync\n");
+		
+		sr7100_flush_cache_all_pc();
+		
+		// Was the secondary cached turned on?
+		if ((config2 & (1<<12)) != 0)
+			blast_scache();
+		
+		// Tertiary is write through so it is safe
+	}	
+	
+	probe_icache(config,config1);
+	probe_dcache(config,config1);
+	probe_scache(config,config2);
+	probe_tcache(config,config2);
+	setup_scache_funcs();
+
+	// Make sure the the secondary cache is turned on (always present)
+	write_32bit_cp0_registerx(CP0_CONFIG,2,config2 | (1<<12));
+	
+#ifndef CONFIG_MIPS_UNCACHED
+	kseg1_cec(config);
+#endif
+						  
+	_flush_cache_sigtramp = sr7100_flush_cache_sigtramp;
+	_flush_icache_range = sr7100_flush_icache_range;
+}
diff --exclude CVS -bBrNu ./arch/mips/mm/loadmmu.c ../linux_2_4_branch/arch/mips/mm/loadmmu.c
--- ./arch/mips/mm/loadmmu.c	Fri Jan 18 23:35:39 2002
+++ ../linux_2_4_branch/arch/mips/mm/loadmmu.c	Sat Jan 12 15:56:36 2002
@@ -61,6 +61,7 @@
 extern void ld_mmu_andes(void);
 extern void ld_mmu_sb1(void);
 extern void ld_mmu_mips32(void);
+extern void ld_mmu_sr7100(void);
 extern void r3k_tlb_init(void);
 extern void r4k_tlb_init(void);
 extern void sb1_tlb_init(void);
@@ -89,6 +90,10 @@
 
 #if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
 		ld_mmu_mips32();
+		r4k_tlb_init();
+#endif
+#if defined(CONFIG_CPU_SR7100)
+		ld_mmu_sr7100();
 		r4k_tlb_init();
 #endif
 	} else switch(mips_cpu.cputype) {
diff --exclude CVS -bBrNu ./arch/mips/mm/tlb-r4k.c ../linux_2_4_branch/arch/mips/mm/tlb-r4k.c
--- ./arch/mips/mm/tlb-r4k.c	Fri Jan 18 23:35:39 2002
+++ ../linux_2_4_branch/arch/mips/mm/tlb-r4k.c	Sat Jan 12 16:09:30 2002
@@ -351,8 +351,6 @@
 		panic("No MMU present");
 	else
 		mips_cpu.tlbsize = ((config1 >> 25) & 0x3f) + 1;
-
-	printk("Number of TLB entries %d.\n", mips_cpu.tlbsize);
 }
 
 void __init r4k_tlb_init(void)
diff --exclude CVS -bBrNu ./include/asm-mips/bootinfo.h ../linux_2_4_branch/include/asm-mips/bootinfo.h
--- ./include/asm-mips/bootinfo.h	Fri Jan 18 23:35:38 2002
+++ ../linux_2_4_branch/include/asm-mips/bootinfo.h	Fri Jan 18 23:45:25 2002
@@ -37,7 +37,7 @@
 #define GROUP_NAMES { "unknown", "Jazz", "Digital", "ARC", "SNI", "ACN",      \
 	"SGI", "Cobalt", "NEC DDB", "Baget", "Cosine", "Galileo", "Momentum", \
 	"ITE", "Philips", "Globepspan", "SiByte", "Toshiba", "Alchemy",       \
-	"NEC Vr41xx", "HP LaserJet" }
+	"NEC Vr41xx", "HP LaserJet"}
 
 /*
  * Valid machtype values for group unknown (low order halfword of mips_machtype)
@@ -253,7 +253,8 @@
 #define CPU_R5500		41
 #define CPU_TX49XX		42
 #define CPU_TX39XX		43
-#define CPU_LAST		43
+#define CPU_SR7100              44
+#define CPU_LAST		44
 
 #define CPU_NAMES { "unknown", "R2000", "R3000", "R3000A", "R3041", "R3051", \
         "R3052", "R3081", "R3081E", "R4000PC", "R4000SC", "R4000MC",         \
@@ -262,7 +263,7 @@
         "R5000A", "R4640", "Nevada", "RM7000", "R5432", "MIPS 4Kc",          \
         "MIPS 5Kc", "R4310", "SiByte SB1", "TX3912", "TX3922", "TX3927",     \
 	"Au1000", "MIPS 4KEc", "MIPS 4KSc", "NEC Vr41xx", "R5500", "TX49xx", \
-	"TX39xx" }
+	"TX39xx", "SR7100" }
 
 #define COMMAND_LINE_SIZE	256
 
diff --exclude CVS -bBrNu ./include/asm-mips/cpu.h ../linux_2_4_branch/include/asm-mips/cpu.h
--- ./include/asm-mips/cpu.h	Fri Jan 18 23:35:38 2002
+++ ../linux_2_4_branch/include/asm-mips/cpu.h	Thu Jan 10 20:21:53 2002
@@ -29,6 +29,7 @@
 #define PRID_COMP_BROADCOM     0x020000
 #define PRID_COMP_ALCHEMY      0x030000
 #define PRID_COMP_SIBYTE       0x040000
+#define PRID_COMP_SANDCRAFT    0x050000
 
 /*
  * Assigned values for the product ID register.  In order to detect a
@@ -73,6 +74,12 @@
  */
 
 #define PRID_IMP_SB1            0x0100
+
+/*
+ * These are the PRID's for when 23:16 == PRID_COMP_SANDCRAFT
+ */
+
+#define PRID_IMP_SR7100         0x0400
 
 /*
  * Definitions for 7:0 on legacy processors
