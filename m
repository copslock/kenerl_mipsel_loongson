Received:  by oss.sgi.com id <S554146AbRBCP17>;
	Sat, 3 Feb 2001 07:27:59 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:61704 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554143AbRBCP1o>;
	Sat, 3 Feb 2001 07:27:44 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D36607F4; Sat,  3 Feb 2001 16:27:31 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 81F07EEAD; Sat,  3 Feb 2001 16:27:58 +0100 (CET)
Date:   Sat, 3 Feb 2001 16:27:58 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: [PATCH] R3912 mm stuff from linux-vr tree 
Message-ID: <20010203162758.A1986@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
here is a patch against the OSS tree to basically add R3912
support - It has mainly be done by Harald Koerfgen - I did basically
change the stuff to get it into the oss tree. 

The CPU Probing with the PRID is definitly not right but probably
someone else can come up with solutions. I havent got any R4650 
hardwate so i cant try.

I only booted on an R3912 Board and it seemed to work at least for
Cache detection - Could someone verify if this doesnt break R3k
Decstations e.g ?

Index: include/asm-mips/bootinfo.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/bootinfo.h,v
retrieving revision 1.22
diff -u -r1.22 bootinfo.h
--- include/asm-mips/bootinfo.h	2000/12/13 19:43:03	1.22
+++ include/asm-mips/bootinfo.h	2001/02/03 15:25:58
@@ -176,14 +185,15 @@
 #define CPU_4KC                 30
 #define CPU_5KC                 31
 #define CPU_R4310               32
-#define CPU_LAST		32
+#define CPU_R3912		33
+#define CPU_LAST		33
 
 #define CPU_NAMES { "unknown", "R2000", "R3000", "R3000A", "R3041", "R3051", \
         "R3052", "R3081", "R3081E", "R4000PC", "R4000SC", "R4000MC",         \
         "R4200", "R4400PC", "R4400SC", "R4400MC", "R4600", "R6000",          \
         "R6000A", "R8000", "R10000", "R4300", "R4650", "R4700", "R5000",     \
         "R5000A", "R4640", "Nevada", "RM7000", "R5432", "MIPS 4Kc",          \
-        "MIPS 5Kc", "R4310" }
+        "MIPS 5Kc", "R4310", "R3912" }
 
 #define COMMAND_LINE_SIZE	256
 
Index: include/asm-mips/cpu.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/cpu.h,v
retrieving revision 1.3
diff -u -r1.3 cpu.h
--- include/asm-mips/cpu.h	2000/11/25 04:49:47	1.3
+++ include/asm-mips/cpu.h	2001/02/03 15:25:58
@@ -26,6 +26,8 @@
 #define PRID_IMP_R4700		0x2100
 #define PRID_IMP_R4640		0x2200
 #define PRID_IMP_R4650		0x2200		/* Same as R4640 */
+#define PRID_IMP_R3912		0x2210
+#define PRID_IMP_R3922		0x2230
 #define PRID_IMP_R5000		0x2300
 #define PRID_IMP_R5432		0x5400
 #define PRID_IMP_SONIC		0x2400
Index: arch/mips/mm/r2300.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/r2300.c,v
retrieving revision 1.27
diff -u -r1.27 r2300.c
--- arch/mips/mm/r2300.c	2000/12/13 20:34:08	1.27
+++ arch/mips/mm/r2300.c	2001/02/03 15:25:59
@@ -4,9 +4,11 @@
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  *
  * with a lot of changes to make this thing work for R3000s
- * Copyright (C) 1998, 2000 Harald Koerfgen
+ * Tx39XX R4k style caches added. HK
+ * Copyright (C) 1998, 1999, 2000 Harald Koerfgen
  * Copyright (C) 1998 Gleb Raiko & Vladimir Roganov
  */
+#include <asm/bootinfo.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -19,16 +21,26 @@
 #include <asm/isadep.h>
 #include <asm/io.h>
 #include <asm/wbflush.h>
+#include <asm/cpu.h>
 
-/* Primary cache parameters. */
-static unsigned long icache_size, dcache_size; /* Size in bytes */
-/* the linesizes are usually fixed on R3000s */
+/*
+ * According to the paper written by D. Miller about Linux cache & TLB
+ * flush implementation, DMA/Driver coherence should be done at the 
+ * driver layer.  Thus, normally, we don't need flush dcache for R3000.
+ * Define this if driver does not handle cache consistency during DMA ops.
+ */
+
+/* For R3000 cores with R4000 style caches */
+static unsigned long icache_size, icache_lsize;
+static unsigned long dcache_size, dcache_lsize;
+static unsigned int scache_size = 0;
+
+#include <asm/cacheops.h>
+#include <asm/r4kcache.h>
 
 #undef DEBUG_TLB
 #undef DEBUG_CACHE
 
-#define NTLB_ENTRIES       64  /* Fixed on all R23000 variants... */
-
 /* page functions */
 void r3k_clear_page(void * page)
 {
@@ -113,7 +125,7 @@
 
 	p = (volatile unsigned long *) KSEG0;
 
-	flags = read_32bit_cp0_register(CP0_STATUS);
+	save_and_cli(flags);
 
 	/* isolate cache space */
 	write_32bit_cp0_register(CP0_STATUS, (ca_flags|flags)&~ST0_IEC);
@@ -135,8 +147,7 @@
 		if (size > 0x40000)
 			size = 0;
 	}
-
-	write_32bit_cp0_register(CP0_STATUS, flags);
+	restore_flags(flags);
 
 	return size * sizeof(*p);
 }
@@ -144,27 +155,26 @@
 static void __init probe_dcache(void)
 {
 	dcache_size = r3k_cache_size(ST0_ISC);
-	printk("Primary data cache %lukb, linesize 4 bytes\n",
+	printk("Primary data cache %dkb, linesize 4 bytes\n",
 		dcache_size >> 10);
 }
 
 static void __init probe_icache(void)
 {
 	icache_size = r3k_cache_size(ST0_ISC|ST0_SWC);
-	printk("Primary instruction cache %lukb, linesize 4 bytes\n",
+	printk("Primary instruction cache %dkb, linesize 4 bytes\n",
 		icache_size >> 10);
 }
 
-static void r3k_flush_icache_range(unsigned long start, unsigned long end)
+static void r3k_flush_icache_range(unsigned long start, unsigned long size)
 {
-	unsigned long size, i, flags;
+	unsigned long i, flags;
 	volatile unsigned char *p = (char *)start;
 
-	size = end - start;
 	if (size > icache_size)
 		size = icache_size;
 
-	flags = read_32bit_cp0_register(CP0_STATUS);
+	save_and_cli(flags);
 
 	/* isolate cache space */
 	write_32bit_cp0_register(CP0_STATUS, (ST0_ISC|ST0_SWC|flags)&~ST0_IEC);
@@ -206,19 +216,18 @@
 		p += 0x080;
 	}
 
-	write_32bit_cp0_register(CP0_STATUS, flags);
+	restore_flags(flags);
 }
 
-static void r3k_flush_dcache_range(unsigned long start, unsigned long end)
+static void r3k_flush_dcache_range(unsigned long start, unsigned long size)
 {
-	unsigned long size, i, flags;
+	unsigned long i, flags;
 	volatile unsigned char *p = (char *)start;
 
-	size = end - start;
 	if (size > dcache_size)
 		size = dcache_size;
 
-	flags = read_32bit_cp0_register(CP0_STATUS);
+	save_and_cli(flags);
 
 	/* isolate cache space */
 	write_32bit_cp0_register(CP0_STATUS, (ST0_ISC|flags)&~ST0_IEC);
@@ -260,7 +269,7 @@
 		p += 0x080;
 	}
 
-	write_32bit_cp0_register(CP0_STATUS, flags);
+	restore_flags(flags);
 }
 
 static inline unsigned long get_phys_page (unsigned long addr,
@@ -357,7 +366,7 @@
 }
 
 static void r3k_flush_icache_page(struct vm_area_struct *vma,
-				  struct page *page)
+				  struct page *page, unsigned long address)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long physpage;
@@ -385,7 +394,7 @@
 	printk("csigtramp[%08lx]", addr);
 #endif
 
-	flags = read_32bit_cp0_register(CP0_STATUS);
+	save_and_cli(flags);
 
 	write_32bit_cp0_register(CP0_STATUS, (ST0_ISC|ST0_SWC|flags)&~ST0_IEC);
 
@@ -394,15 +403,66 @@
 		"sb\t$0,0x008(%0)\n\t"
 		: : "r" (addr) );
 
-	write_32bit_cp0_register(CP0_STATUS, flags);
+	restore_flags(flags);
 }
 
 static void r3k_dma_cache_wback_inv(unsigned long start, unsigned long size)
 {
 	wbflush();
-	r3k_flush_dcache_range(start, start + size);
+	r3k_flush_dcache_range(start, size);
 }
 
+static __init void r3912_size_caches(void)
+  {
+	unsigned long config;
+
+	config = read_32bit_cp0_register(CP0_ENTRYLO1);
+
+	icache_size = 1 << (10 + ((config >> 19) & 7));
+	icache_lsize = 16;
+
+	dcache_size = 1 << (10 + ((config >> 16) & 7));
+	dcache_lsize = 4;
+
+	printk("Primary instruction cache %dkb, linesize %d bytes\n",
+	       icache_size >> 10, icache_lsize);
+	printk("Primary data cache %dkb, linesize %d bytes\n",
+	       dcache_size >> 10, dcache_lsize);	
+}
+
+static void r3912_flush_icache_all(void)
+{
+	unsigned long start = KSEG0;
+	unsigned long end = (start + icache_size);
+	unsigned long dummy = 0;
+
+	/* disable icache and stop streaming */
+	__asm__ __volatile__("
+	.set	noreorder
+	mfc0	%0, $3
+	xori	%0, 32		/* toggle ICE bit */
+	mtc0	%0, $3
+	j	1f		/* stop streaming */
+	nop
+	1:	.set	reorder"
+	: : "r"(dummy));
+
+	/* invalidate icache */
+	while(start < end) {
+		cache16_unroll32(start,Index_Invalidate_I);
+		start += 0x200;
+	}
+
+	/* enable icache */
+	__asm__ __volatile__("
+	.set	noreorder
+	mfc0	%0, $3
+	xori	%0, 32		/* toggle ICE bit */
+	mtc0	%0, $3
+	.set	reorder"
+	: : "r"(dummy));
+}
+
 /* TLB operations. */
 void flush_tlb_all(void)
 {
@@ -417,7 +477,7 @@
 	save_and_cli(flags);
 	old_ctx = (get_entryhi() & 0xfc0);
 	write_32bit_cp0_register(CP0_ENTRYLO0, 0);
-	for(entry = 0; entry < NTLB_ENTRIES; entry++) {
+	for(entry = 8; entry < mips_cpu.tlbsize; entry++) {
 		write_32bit_cp0_register(CP0_INDEX, entry << 8);
 		write_32bit_cp0_register(CP0_ENTRYHI, ((entry | 0x80000) << 12));
 		__asm__ __volatile__("tlbwi");
@@ -455,7 +515,7 @@
 #endif
 		save_and_cli(flags);
 		size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
-		if(size <= NTLB_ENTRIES) {
+		if(size <= mips_cpu.tlbsize) {
 			int oldpid = (get_entryhi() & 0xfc0);
 			int newpid = (mm->context & 0xfc0);
 
@@ -590,19 +650,6 @@
 		printk("[HIT]");
 #endif
 	}
-#if 0
-	if(!strcmp(current->comm, "args")) {
-		printk("<");
-		for(idx = 0; idx < NTLB_ENTRIES; idx++) {
-			set_index(idx);
-			tlb_read();
-			address = get_entryhi();
-			if((address & 0xfc0) != 0)
-				printk("[%08lx]", address);
-		}
-		printk(">\n");
-	}
-#endif
 	set_entryhi(pid);
 	restore_flags(flags);
 }
@@ -643,10 +690,22 @@
 void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 				  unsigned long entryhi, unsigned long pagemask)
 {
-printk("r3k_add_wired_entry");
-        /*
-	 * FIXME, to be done
-	 */
+	unsigned long flags;
+	unsigned long old_ctx;
+	static unsigned long wired = 0;
+	
+	if (wired < 8) {
+		save_and_cli(flags);
+		old_ctx = get_entryhi() & 0xfc0;
+		set_entrylo0(entrylo0);
+		set_entryhi(entryhi);
+		set_index(wired);
+		wired++;
+		tlb_write_indexed();
+		set_entryhi(old_ctx);
+	        flush_tlb_all();    
+		restore_flags(flags);
+	}
 }
 
 void __init ld_mmu_r2300(void)
@@ -656,19 +715,49 @@
 	_clear_page = r3k_clear_page;
 	_copy_page = r3k_copy_page;
 
-	probe_icache();
-	probe_dcache();
+	switch (mips_cpu.cputype) {
+	case CPU_R2000:
+	case CPU_R3000:
+	case CPU_R3000A:
+		probe_icache();
+		probe_dcache();
+
+		_flush_cache_all = r3k_flush_cache_all;
+		_flush_cache_mm = r3k_flush_cache_mm;
+		_flush_cache_range = r3k_flush_cache_range;
+		_flush_cache_page = r3k_flush_cache_page;
+		_flush_cache_sigtramp = r3k_flush_cache_sigtramp;
+		_flush_page_to_ram = r3k_flush_page_to_ram;
+		_flush_icache_page = r3k_flush_icache_page;
+		_flush_icache_range = r3k_flush_icache_range;
+
+		_dma_cache_wback_inv = r3k_dma_cache_wback_inv;
+
+		break;
+	case CPU_R3912:
+		r3912_size_caches();
+
+		_flush_cache_all = r3912_flush_icache_all;
+		_flush_cache_mm = (void (*)(struct mm_struct *))r3912_flush_icache_all;
+		_flush_cache_range = (void (*)(struct mm_struct *, unsigned long, unsigned long))r3912_flush_icache_all;
+		_flush_cache_page = (void (*)(struct vm_area_struct *, unsigned long))r3912_flush_icache_all;
+		_flush_cache_sigtramp = (void (*)(unsigned long))r3912_flush_icache_all;
+		_flush_page_to_ram = r3k_flush_page_to_ram;
+
+#warning "This is extremely ineffective: I'm flushing all caches on r3912 when I should flush just one page"
+#warning "r3912_flush_icache_page needs to be written for r3912:"
+// MFK: I'm very confused here.  The above asignments for _flush_cache_{range,page} seem to
+//      only flush the icache, and apparently do the entire cache (not too unreasonable, given
+//      the size of the cache.  So this is probably a reasonable solution for
+//      _flush_icache_{page,range} below, but what about the dcache above???  Am I misisng
+//      something?  Can someone review and remove this comment (and above #warning lines)?
+		_flush_icache_page = r3912_flush_icache_all;
+		_flush_icache_range = r3912_flush_icache_all;
 
-	_flush_cache_all = r3k_flush_cache_all;
-	_flush_cache_mm = r3k_flush_cache_mm;
-	_flush_cache_range = r3k_flush_cache_range;
-	_flush_cache_page = r3k_flush_cache_page;
-	_flush_cache_sigtramp = r3k_flush_cache_sigtramp;
-	_flush_page_to_ram = r3k_flush_page_to_ram;
-	_flush_icache_page = r3k_flush_icache_page;
-	_flush_icache_range = r3k_flush_icache_range;
+	        _dma_cache_wback_inv = (void (*)(unsigned long, unsigned long))r3k_flush_page_to_ram;
 
-        _dma_cache_wback_inv = r3k_dma_cache_wback_inv;
+		break;
+	}
 
 	flush_tlb_all();
 }
Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.48
diff -u -r1.48 setup.c
--- arch/mips/kernel/setup.c	2001/01/10 17:17:55	1.48
+++ arch/mips/kernel/setup.c	2001/02/03 15:25:59
@@ -210,10 +210,18 @@
 		mips_cpu.tlbsize = 48;
 		break;
 	case PRID_IMP_R4650:
-		mips_cpu.cputype = CPU_R4650;
-		mips_cpu.isa_level = MIPS_CPU_ISA_III;
-		mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU;
-		mips_cpu.tlbsize = 48;
+		/* This might also be R3912 & R3922 */
+		if (mips_cpu.processor_id == PRID_IMP_R3912) {
+			mips_cpu.isa_level = MIPS_CPU_ISA_I;
+			mips_cpu.options = MIPS_CPU_TLB;
+			mips_cpu.tlbsize = 32;
+			mips_cpu.cputype = CPU_R3912;
+		} else {
+			mips_cpu.cputype = CPU_R4650;
+			mips_cpu.isa_level = MIPS_CPU_ISA_III;
+			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU;
+			mips_cpu.tlbsize = 48;
+		}
 		break;
 	case PRID_IMP_R4700:
 		mips_cpu.cputype = CPU_R4700;

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
