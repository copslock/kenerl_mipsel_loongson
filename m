Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2003 11:08:43 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:33548
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225073AbTDUKIj>; Mon, 21 Apr 2003 11:08:39 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 21 Apr 2003 10:08:37 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h3LA8PNr018399;
	Mon, 21 Apr 2003 19:08:25 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 21 Apr 2003 19:14:37 +0900 (JST)
Message-Id: <20030421.191436.78702188.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: TX39 fixes and cleanups
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Here is a patch for TX39 fixes and cleanups:

- kernel/cpu-probe.c:
	- TX39 does not have LLSC.
- mm/c-tx39.c
	- Remove unused functions.
	- Add missing extern declarations.
	- Sync with recent c-r4k.c changes. (including
	  _PAGE_VALID/_PAGE_PRESENT fix, dc_alias checking)
	- Use proper cp0.config macro.
	- Add TX39_STOP_STREAMING() to ensure icache-flushing.


diff -ur linux-mips-cvs/arch/mips/kernel/cpu-probe.c linux.new/arch/mips/kernel/cpu-probe.c
--- linux-mips-cvs/arch/mips/kernel/cpu-probe.c	Fri Apr 18 10:23:02 2003
+++ linux.new/arch/mips/kernel/cpu-probe.c	Mon Apr 21 16:39:50 2003
@@ -278,7 +278,7 @@
 		#endif
 		case PRID_IMP_TX39:
 			current_cpu_data.isa_level = MIPS_CPU_ISA_I;
-			current_cpu_data.options = MIPS_CPU_TLB | MIPS_CPU_LLSC;
+			current_cpu_data.options = MIPS_CPU_TLB;
 
 			if ((current_cpu_data.processor_id & 0xf0) ==
 			    (PRID_REV_TX3927 & 0xf0)) {
diff -ur linux-mips-cvs/arch/mips/mm/c-tx39.c linux.new/arch/mips/mm/c-tx39.c
--- linux-mips-cvs/arch/mips/mm/c-tx39.c	Fri Apr 18 10:23:03 2003
+++ linux.new/arch/mips/mm/c-tx39.c	Mon Apr 21 16:39:16 2003
@@ -28,16 +28,23 @@
 static unsigned long icache_way_size, dcache_way_size;	/* Size divided by ways */
 extern long scache_size;
 
-#define icache_lsize	current_cpu_data.icache.linesz
-#define dcache_lsize	current_cpu_data.dcache.linesz
-
 #include <asm/r4kcache.h>
 
+extern void r3k_clear_page(void * page);
+extern void r3k_copy_page(void * to, void * from);
+
 extern int r3k_have_wired_reg;	/* in r3k-tlb.c */
 
-static void tx39h_flush_data_cache_page(unsigned long addr)
-{
-}
+/* This sequence is required to ensure icache is disabled immediately */
+#define TX39_STOP_STREAMING() \
+__asm__ __volatile__( \
+	".set    push\n\t" \
+	".set    noreorder\n\t" \
+	"b       1f\n\t" \
+	"nop\n\t" \
+	"1:\n\t" \
+	".set pop" \
+	)
 
 /* TX39H-style cache flush routines. */
 static void tx39h_flush_icache_all(void)
@@ -50,6 +57,7 @@
 	local_irq_save(flags);
 	config = read_c0_conf();
 	write_c0_conf(config & ~TX39_CONF_ICE);
+	TX39_STOP_STREAMING();
 
 	/* invalidate icache */
 	while (start < end) {
@@ -64,15 +72,15 @@
 static void tx39h_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
 	unsigned long end, a;
-	int lsize = dcache_lsize;
+	unsigned long dc_lsize = current_cpu_data.dcache.linesz;
 
 	iob();
-	a = addr & ~(lsize - 1);
-	end = (addr + size - 1) & ~(lsize - 1);
+	a = addr & ~(dc_lsize - 1);
+	end = (addr + size - 1) & ~(dc_lsize - 1);
 	while (1) {
 		invalidate_dcache_line(a); /* Hit_Invalidate_D */
 		if (a == end) break;
-		a += lsize;
+		a += dc_lsize;
 	}
 }
 
@@ -101,6 +109,7 @@
 	local_irq_save(flags);
 	config = read_c0_conf();
 	write_c0_conf(config & ~TX39_CONF_ICE);
+	TX39_STOP_STREAMING();
 	blast_icache16_page(addr);
 	write_c0_conf(config);
 	local_irq_restore(flags);
@@ -113,6 +122,7 @@
 	local_irq_save(flags);
 	config = read_c0_conf();
 	write_c0_conf(config & ~TX39_CONF_ICE);
+	TX39_STOP_STREAMING();
 	blast_icache16_page_indexed(addr);
 	write_c0_conf(config);
 	local_irq_restore(flags);
@@ -125,6 +135,7 @@
 	local_irq_save(flags);
 	config = read_c0_conf();
 	write_c0_conf(config & ~TX39_CONF_ICE);
+	TX39_STOP_STREAMING();
 	blast_icache16();
 	write_c0_conf(config);
 	local_irq_restore(flags);
@@ -132,12 +143,24 @@
 
 static inline void tx39_flush_cache_all(void)
 {
+	if (!cpu_has_dc_aliases)
+		return;
+
+	tx39_blast_dcache();
+	tx39_blast_icache();
+}
+
+static inline void tx39___flush_cache_all(void)
+{
 	tx39_blast_dcache();
 	tx39_blast_icache();
 }
 
 static void tx39_flush_cache_mm(struct mm_struct *mm)
 {
+	if (!cpu_has_dc_aliases)
+		return;
+
 	if (cpu_context(smp_processor_id(), mm) != 0) {
 		tx39_flush_cache_all();
 	}
@@ -147,6 +170,9 @@
 				    unsigned long start,
 				    unsigned long end)
 {
+	if (!cpu_has_dc_aliases)
+		return;
+
 	if (cpu_context(smp_processor_id(), mm) != 0) {
 		tx39_blast_dcache();
 		tx39_blast_icache();
@@ -178,7 +204,7 @@
 	 * If the page isn't marked valid, the page cannot possibly be
 	 * in the cache.
 	 */
-	if (!(pte_val(*ptep) & _PAGE_VALID))
+	if (!(pte_val(*ptep) & _PAGE_PRESENT))
 		return;
 
 	/*
@@ -187,8 +213,9 @@
 	 * for every cache flush operation.  So we do indexed flushes
 	 * in that case, which doesn't overly flush the cache too much.
 	 */
-	if (mm == current->active_mm) {
-		tx39_blast_dcache_page(page);
+	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
+		if (cpu_has_dc_aliases || exec)
+			tx39_blast_dcache_page(page);
 		if (exec)
 			tx39_blast_icache_page(page);
 
@@ -200,7 +227,8 @@
 	 * to work correctly.
 	 */
 	page = (KSEG0 + (page & (dcache_size - 1)));
-	tx39_blast_dcache_page_indexed(page);
+	if (cpu_has_dc_aliases || exec)
+		tx39_blast_dcache_page_indexed(page);
 	if (exec)
 		tx39_blast_icache_page_indexed(page);
 }
@@ -212,7 +240,45 @@
 
 static void tx39_flush_icache_range(unsigned long start, unsigned long end)
 {
-	flush_cache_all();
+	unsigned long dc_lsize = current_cpu_data.dcache.linesz;
+	unsigned long addr, aend;
+
+	if (end - start > dcache_size)
+		tx39_blast_dcache();
+	else {
+		addr = start & ~(dc_lsize - 1);
+		aend = (end - 1) & ~(dc_lsize - 1);
+
+		while (1) {
+			/* Hit_Writeback_Inv_D */
+			protected_writeback_dcache_line(addr);
+			if (addr == aend)
+				break;
+			addr += dc_lsize;
+		}
+	}
+
+	if (end - start > icache_size)
+		tx39_blast_icache();
+	else {
+		unsigned long flags, config;
+		addr = start & ~(dc_lsize - 1);
+		aend = (end - 1) & ~(dc_lsize - 1);
+		/* disable icache (set ICE#) */
+		local_irq_save(flags);
+		config = read_c0_conf();
+		write_c0_conf(config & ~TX39_CONF_ICE);
+		TX39_STOP_STREAMING();
+		while (1) {
+			/* Hit_Invalidate_I */
+			protected_flush_icache_line(addr);
+			if (addr == aend)
+				break;
+			addr += dc_lsize;
+		}
+		write_c0_conf(config);
+		local_irq_restore(flags);
+	}
 }
 
 /*
@@ -224,12 +290,22 @@
  */
 static void tx39_flush_icache_page(struct vm_area_struct *vma, struct page *page)
 {
-	if (vma->vm_flags & VM_EXEC) {
-		unsigned long addr = (unsigned long) page_address(page);
+	unsigned long addr;
+	/*
+	 * If there's no context yet, or the page isn't executable, no icache
+	 * flush is needed.
+	 */
+	if (!(vma->vm_flags & VM_EXEC))
+		return;
 
-		tx39_blast_dcache_page(addr);
-		tx39_blast_icache();
-	}
+	addr = (unsigned long) page_address(page);
+	tx39_blast_dcache_page(addr);
+
+	/*
+	 * We're not sure of the virtual address(es) involved here, so
+	 * we have to flush the entire I-cache.
+	 */
+	tx39_blast_icache();
 }
 
 static void tx39_dma_cache_wback_inv(unsigned long addr, unsigned long size)
@@ -245,13 +321,13 @@
 	} else if (size > dcache_size) {
 		tx39_blast_dcache();
 	} else {
-		int lsize = dcache_lsize;
-		a = addr & ~(lsize - 1);
-		end = (addr + size - 1) & ~(lsize - 1);
+		unsigned long dc_lsize = current_cpu_data.dcache.linesz;
+		a = addr & ~(dc_lsize - 1);
+		end = (addr + size - 1) & ~(dc_lsize - 1);
 		while (1) {
 			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
 			if (a == end) break;
-			a += lsize;
+			a += dc_lsize;
 		}
 	}
 }
@@ -269,73 +345,66 @@
 	} else if (size > dcache_size) {
 		tx39_blast_dcache();
 	} else {
-		int lsize = dcache_lsize;
-		a = addr & ~(lsize - 1);
-		end = (addr + size - 1) & ~(lsize - 1);
+		unsigned long dc_lsize = current_cpu_data.dcache.linesz;
+		a = addr & ~(dc_lsize - 1);
+		end = (addr + size - 1) & ~(dc_lsize - 1);
 		while (1) {
 			invalidate_dcache_line(a); /* Hit_Invalidate_D */
 			if (a == end) break;
-			a += lsize;
+			a += dc_lsize;
 		}
 	}
 }
 
-static void tx39_dma_cache_wback(unsigned long addr, unsigned long size)
-{
-	panic("tx39_dma_cache called - should not happen.");
-}
-
 static void tx39_flush_cache_sigtramp(unsigned long addr)
 {
+	unsigned long ic_lsize = current_cpu_data.icache.linesz;
+	unsigned long dc_lsize = current_cpu_data.dcache.linesz;
 	unsigned long config;
 	unsigned long flags;
 
-	protected_writeback_dcache_line(addr & ~(dcache_lsize - 1));
+	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
 
 	/* disable icache (set ICE#) */
 	local_irq_save(flags);
 	config = read_c0_conf();
 	write_c0_conf(config & ~TX39_CONF_ICE);
-	protected_flush_icache_line(addr & ~(icache_lsize - 1));
+	TX39_STOP_STREAMING();
+	protected_flush_icache_line(addr & ~(ic_lsize - 1));
 	write_c0_conf(config);
 	local_irq_restore(flags);
 }
 
-/* currently clear_user_page/copy_user_page needs this... */
-void __flush_dcache_all(void)
-{
-	if (current_cpu_data.cputype != CPU_TX3912)
-		tx39_blast_dcache();
-}
-
 static __init void tx39_probe_cache(void)
 {
 	unsigned long config;
 
 	config = read_c0_conf();
 
-	icache_size = 1 << (10 + ((config >> 19) & 3));
-	dcache_size = 1 << (10 + ((config >> 16) & 3));
+	icache_size = 1 << (10 + ((config & TX39_CONF_ICS_MASK) >>
+				  TX39_CONF_ICS_SHIFT));
+	dcache_size = 1 << (10 + ((config & TX39_CONF_DCS_MASK) >>
+				  TX39_CONF_DCS_SHIFT));
 
-	icache_lsize = 16;
+	current_cpu_data.icache.linesz = 16;
 	switch (current_cpu_data.cputype) {
 	case CPU_TX3912:
 		current_cpu_data.icache.ways = 1;
 		current_cpu_data.dcache.ways = 1;
-		dcache_lsize = 4;
+		current_cpu_data.dcache.linesz = 4;
 		break;
 
 	case CPU_TX3927:
 		current_cpu_data.icache.ways = 2;
 		current_cpu_data.dcache.ways = 2;
-		dcache_lsize = 16;
+		current_cpu_data.dcache.linesz = 16;
 		break;
 
 	case CPU_TX3922:
 	default:
 		current_cpu_data.icache.ways = 1;
 		current_cpu_data.dcache.ways = 1;
-		dcache_lsize = 16;
+		current_cpu_data.dcache.linesz = 16;
 		break;
 	}
 }
@@ -382,7 +451,7 @@
 		/* board-dependent init code may set WBON */
 
 		_flush_cache_all = tx39_flush_cache_all;
-		___flush_cache_all = tx39_flush_cache_all;
+		___flush_cache_all = tx39___flush_cache_all;
 		_flush_cache_mm = tx39_flush_cache_mm;
 		_flush_cache_range = tx39_flush_cache_range;
 		_flush_cache_page = tx39_flush_cache_page;
@@ -393,7 +462,7 @@
 		_flush_data_cache_page = tx39_flush_data_cache_page;
 
 		_dma_cache_wback_inv = tx39_dma_cache_wback_inv;
-		_dma_cache_wback = tx39_dma_cache_wback;
+		_dma_cache_wback = tx39_dma_cache_wback_inv;
 		_dma_cache_inv = tx39_dma_cache_inv;
 
 		shm_align_mask = max_t(unsigned long,
@@ -406,17 +475,19 @@
 	icache_way_size = icache_size / current_cpu_data.icache.ways;
 	dcache_way_size = dcache_size / current_cpu_data.dcache.ways;
 
-	current_cpu_data.icache.sets = icache_way_size / icache_lsize;
-	current_cpu_data.dcache.sets = dcache_way_size / dcache_lsize;
+	current_cpu_data.icache.sets =
+		icache_way_size / current_cpu_data.icache.linesz;
+	current_cpu_data.dcache.sets =
+		dcache_way_size / current_cpu_data.dcache.linesz;
 
-	current_cpu_data.icache.sets = icache_way_size / icache_lsize;
-	current_cpu_data.dcache.sets = dcache_way_size / dcache_lsize;
+	if (dcache_way_size > PAGE_SIZE)
+		current_cpu_data.dcache.flags |= MIPS_CACHE_ALIASES;
 
 	current_cpu_data.icache.waybit = 0;
 	current_cpu_data.dcache.waybit = 0;
 
-	printk("Primary instruction cache %dkb, linesize %d bytes\n",
-		(int) (icache_size >> 10), (int) icache_lsize);
-	printk("Primary data cache %dkb, linesize %d bytes\n",
-		(int) (dcache_size >> 10), (int) dcache_lsize);
+	printk("Primary instruction cache %ldkb, linesize %d bytes\n",
+		icache_size >> 10, current_cpu_data.icache.linesz);
+	printk("Primary data cache %ldkb, linesize %d bytes\n",
+		dcache_size >> 10, current_cpu_data.dcache.linesz);
 }
---
Atsushi Nemoto
