Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2003 20:08:43 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:1296 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225196AbTDBTIm>;
	Wed, 2 Apr 2003 20:08:42 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id D637AB527
	for <linux-mips@linux-mips.org>; Wed,  2 Apr 2003 21:08:39 +0200 (CEST)
Message-ID: <3E8B3703.3D9B09D5@ekner.info>
Date: Wed, 02 Apr 2003 21:16:20 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Cache flush statistics patch to c-mips32.c
Content-Type: multipart/mixed;
 boundary="------------1CADC4A811B853F927ABCAD0"
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------1CADC4A811B853F927ABCAD0
Content-Type: multipart/alternative;
 boundary="------------0DD04DD5AD4661B9F38FC2D6"


--------------0DD04DD5AD4661B9F38FC2D6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Below is a patch with some cache statistics counters added to c-mips32.c.
They are turned on by the local define DEBUG_COUNTERS in case somebody wants to
play with them.

A sample output:

[root@au01 root]# more /proc/cmips32_cache_stats

Cache statistics from c-mips32.c:

mips32_flush_cache_all_pc:      83384    mips32_flush_cache_all_sc:          0
mips32_flush_cache_range_pc:    37276    mips32_flush_cache_range_sc:        0
mips32_flush_cache_mm_pc:        2121    mips32_flush_cache_mm_sc:           0
mips32_flush_cache_page_pc:     36282    mips32_flush_cache_page_sc:         0

mips32_flush_icache_all:            0    mips32_flush_icache_page_s:         0
mips32_flush_icache_range:          4    mips32_flush_icache_page:       93545
mips32_flush_data_cache_page:   31905    mips32_flush_cache_sigtramp:     2467

dma_cache_wback_inv_pc:          7029    dma_cache_wback_inv_sc:             0
dma_cache_inv_pc:                   0    dma_cache_inv_sc:                   0


These counts are from a system which has just booted, nothing else. While running
some programs, the flush_cache_all is called up to 400 times pr. second (!).

/Hartvig


--------------0DD04DD5AD4661B9F38FC2D6
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<tt>Below is a patch with some cache statistics counters added to c-mips32.c.</tt>
<br><tt>They are turned on by the local define DEBUG_COUNTERS in case somebody
wants to</tt>
<br><tt>play with them.</tt><tt></tt>
<p><tt>A&nbsp;sample output:</tt><tt></tt>
<p><tt>[root@au01 root]# more /proc/cmips32_cache_stats</tt>
<br><tt>&nbsp;</tt>
<br><tt>Cache statistics from c-mips32.c:</tt>
<br><tt>&nbsp;</tt>
<br><tt>mips32_flush_cache_all_pc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83384&nbsp;&nbsp;&nbsp;
mips32_flush_cache_all_sc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0</tt>
<br><tt>mips32_flush_cache_range_pc:&nbsp;&nbsp;&nbsp; 37276&nbsp;&nbsp;&nbsp;
mips32_flush_cache_range_sc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0</tt>
<br><tt>mips32_flush_cache_mm_pc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2121&nbsp;&nbsp;&nbsp; mips32_flush_cache_mm_sc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0</tt>
<br><tt>mips32_flush_cache_page_pc:&nbsp;&nbsp;&nbsp;&nbsp; 36282&nbsp;&nbsp;&nbsp;
mips32_flush_cache_page_sc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0</tt>
<br><tt>&nbsp;</tt>
<br><tt>mips32_flush_icache_all:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; mips32_flush_icache_page_s:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0</tt>
<br><tt>mips32_flush_icache_range:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
4&nbsp;&nbsp;&nbsp; mips32_flush_icache_page:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
93545</tt>
<br><tt>mips32_flush_data_cache_page:&nbsp;&nbsp; 31905&nbsp;&nbsp;&nbsp;
mips32_flush_cache_sigtramp:&nbsp;&nbsp;&nbsp;&nbsp; 2467</tt>
<br><tt>&nbsp;</tt>
<br><tt>dma_cache_wback_inv_pc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
7029&nbsp;&nbsp;&nbsp; dma_cache_wback_inv_sc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0</tt>
<br><tt>dma_cache_inv_pc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp; dma_cache_inv_sc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0</tt>
<br><tt></tt>&nbsp;<tt></tt>
<p><tt>These counts are from a system which has just booted, nothing else.
While running</tt>
<br><tt>some programs, the flush_cache_all is called up to 400 times pr.
second (!).</tt><tt></tt>
<p><tt>/Hartvig</tt>
<br><tt></tt>&nbsp;</html>

--------------0DD04DD5AD4661B9F38FC2D6--

--------------1CADC4A811B853F927ABCAD0
Content-Type: text/plain; charset=us-ascii;
 name="cmips32_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmips32_patch"

Index: c-mips32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-mips32.c,v
retrieving revision 1.3.2.17
diff -u -r1.3.2.17 c-mips32.c
--- c-mips32.c	31 Mar 2003 23:29:06 -0000	1.3.2.17
+++ c-mips32.c	2 Apr 2003 19:01:35 -0000
@@ -17,6 +17,10 @@
  *
  * MIPS32 CPU variant specific MMU/Cache routines.
  */
+
+#undef	DEBUG_CACHE		/* Control debug printk's	*/
+#undef	DEBUG_COUNTERS		/* Control statistics counters	*/
+
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -32,6 +36,40 @@
 #include <asm/system.h>
 #include <asm/mmu_context.h>
 
+
+#ifndef	DEBUG_COUNTERS
+#define	DEBUG_INCCNT(cnt)
+#else
+
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+
+#define	DEBUG_INCCNT(cnt)	cnt++
+
+static int cnt_mips32_flush_cache_all_sc = 0;	/* All the bean counters */
+static int cnt_mips32_flush_cache_all_pc = 0;
+static int cnt_mips32_flush_cache_range_sc = 0;
+static int cnt_mips32_flush_cache_range_pc = 0;
+static int cnt_mips32_flush_cache_mm_sc = 0;
+static int cnt_mips32_flush_cache_mm_pc = 0;
+static int cnt_mips32_flush_cache_page_sc = 0;
+static int cnt_mips32_flush_cache_page_pc = 0;
+
+static int cnt_mips32_flush_icache_all = 0;
+static int cnt_mips32_flush_icache_page_s = 0;
+static int cnt_mips32_flush_icache_range = 0;
+static int cnt_mips32_flush_icache_page = 0;
+static int cnt_mips32_flush_data_cache_page = 0;
+static int cnt_mips32_flush_cache_sigtramp = 0;
+
+static int cnt_dma_cache_wback_inv_pc = 0;
+static int cnt_dma_cache_wback_inv_sc = 0;
+static int cnt_dma_cache_inv_pc = 0;
+static int cnt_dma_cache_inv_sc = 0;
+
+#endif
+
+
 /* Primary cache parameters. */
 int icache_size, dcache_size; 			/* Size in bytes */
 int ic_lsize, dc_lsize;				/* LineSize in bytes */
@@ -42,7 +80,6 @@
 #include <asm/cacheops.h>
 #include <asm/mips32_cache.h>
 
-#undef DEBUG_CACHE
 
 /*
  * Dummy cache handling routines for machines without boardcaches
@@ -62,6 +99,8 @@
 {
 	unsigned long flags;
 
+	DEBUG_INCCNT(cnt_mips32_flush_cache_all_sc);
+
 	local_irq_save(flags);
 	blast_dcache(); blast_icache(); blast_scache();
 	local_irq_restore(flags);
@@ -71,6 +110,8 @@
 {
 	unsigned long flags;
 
+	DEBUG_INCCNT(cnt_mips32_flush_cache_all_pc);
+
 	local_irq_save(flags);
 	blast_dcache(); blast_icache();
 	local_irq_restore(flags);
@@ -84,6 +125,8 @@
 	struct vm_area_struct *vma;
 	unsigned long flags;
 
+	DEBUG_INCCNT(cnt_mips32_flush_cache_range_sc);
+
 	if (cpu_context(smp_processor_id(), mm) == 0)
 		return;
 
@@ -119,6 +162,8 @@
 				     unsigned long start,
 				     unsigned long end)
 {
+	DEBUG_INCCNT(cnt_mips32_flush_cache_range_pc);
+
 	if (cpu_context(smp_processor_id(), mm) != 0) {
 		unsigned long flags;
 
@@ -138,6 +183,8 @@
  */
 static void mips32_flush_cache_mm_sc(struct mm_struct *mm)
 {
+	DEBUG_INCCNT(cnt_mips32_flush_cache_mm_sc);
+
 	if (cpu_context(smp_processor_id(), mm) != 0) {
 #ifdef DEBUG_CACHE
 		printk("cmm[%d]", cpu_context(smp_processor_id(), mm));
@@ -148,6 +195,8 @@
 
 static void mips32_flush_cache_mm_pc(struct mm_struct *mm)
 {
+	DEBUG_INCCNT(cnt_mips32_flush_cache_mm_pc);
+
 	if (cpu_context(smp_processor_id(), mm) != 0) {
 #ifdef DEBUG_CACHE
 		printk("cmm[%d]", cpu_context(smp_processor_id(), mm));
@@ -164,6 +213,8 @@
 	pmd_t *pmdp;
 	pte_t *ptep;
 
+	DEBUG_INCCNT(cnt_mips32_flush_cache_page_sc);
+
 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
 	 * this page into the cache.
@@ -212,6 +263,8 @@
 	pmd_t *pmdp;
 	pte_t *ptep;
 
+	DEBUG_INCCNT(cnt_mips32_flush_cache_page_pc);
+
 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
 	 * this page into the cache.
@@ -251,17 +304,20 @@
 	}
 }
 
-static void mips32_flush_data_cache_page(unsigned long addr)
+static void mips32_flush_icache_all(void)
 {
-	if (sc_lsize)
-		blast_scache_page(addr);
-	else
-		blast_dcache_page(addr);
+	DEBUG_INCCNT(cnt_mips32_flush_icache_all);
+
+	if (mips_cpu.icache.flags | MIPS_CACHE_VTAG_CACHE) {
+		blast_icache();
+	}
 }
 
 static void
 mips32_flush_icache_page_s(struct vm_area_struct *vma, struct page *page)
 {
+	DEBUG_INCCNT(cnt_mips32_flush_icache_page_s);
+
 	/*
 	 * We did an scache flush therefore PI is already clean.
 	 */
@@ -270,12 +326,16 @@
 static void
 mips32_flush_icache_range(unsigned long start, unsigned long end)
 {
+	DEBUG_INCCNT(cnt_mips32_flush_icache_range);
+
 	flush_cache_all();
 }
 
 static void
 mips32_flush_icache_page(struct vm_area_struct *vma, struct page *page)
 {
+	DEBUG_INCCNT(cnt_mips32_flush_icache_page);
+
 	/*
 	 * If there's no context yet, or the page isn't executable, no icache 
 	 * flush is needed.
@@ -290,15 +350,45 @@
 	flush_cache_all();
 }
 
+static void mips32_flush_data_cache_page(unsigned long addr)
+{
+	DEBUG_INCCNT(cnt_mips32_flush_data_cache_page);
+
+	if (sc_lsize)
+		blast_scache_page(addr);
+	else
+		blast_dcache_page(addr);
+}
+
+
+/*
+ * While we're protected against bad userland addresses we don't care
+ * very much about what happens in that case.  Usually a segmentation
+ * fault will dump the process later on anyway ...
+ */
+static void mips32_flush_cache_sigtramp(unsigned long addr)
+{
+	DEBUG_INCCNT(cnt_mips32_flush_cache_sigtramp);
+
+	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
+	protected_flush_icache_line(addr & ~(ic_lsize - 1));
+}
+
+
 /*
  * Writeback and invalidate the primary cache dcache before DMA.
  */
+
+#ifdef	CONFIG_NONCOHERENT_IO
+
 static void
 mips32_dma_cache_wback_inv_pc(unsigned long addr, unsigned long size)
 {
 	unsigned long end, a;
 	unsigned long flags;
 
+	DEBUG_INCCNT(cnt_dma_cache_wback_inv_pc);
+
 	if (size >= dcache_size) {
 		blast_dcache();
 	} else {
@@ -320,6 +410,8 @@
 {
 	unsigned long end, a;
 
+	DEBUG_INCCNT(cnt_dma_cache_wback_inv_sc);
+
 	if (size >= scache_size) {
 		blast_scache();
 		return;
@@ -340,6 +432,8 @@
 	unsigned long end, a;
 	unsigned long flags;
 
+	DEBUG_INCCNT(cnt_dma_cache_inv_pc);
+
 	if (size >= dcache_size) {
 		blast_dcache();
 	} else {
@@ -362,6 +456,8 @@
 {
 	unsigned long end, a;
 
+	DEBUG_INCCNT(cnt_dma_cache_inv_sc);
+
 	if (size >= scache_size) {
 		blast_scache();
 		return;
@@ -379,26 +475,11 @@
 static void
 mips32_dma_cache_wback(unsigned long addr, unsigned long size)
 {
-	panic("mips32_dma_cache called - should not happen.");
+	panic("mips32_dma_cache_wback called - should not happen.");
 }
 
-/*
- * While we're protected against bad userland addresses we don't care
- * very much about what happens in that case.  Usually a segmentation
- * fault will dump the process later on anyway ...
- */
-static void mips32_flush_cache_sigtramp(unsigned long addr)
-{
-	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
-	protected_flush_icache_line(addr & ~(ic_lsize - 1));
-}
+#endif
 
-static void mips32_flush_icache_all(void)
-{
-	if (mips_cpu.icache.flags | MIPS_CACHE_VTAG_CACHE) {
-		blast_icache();
-	}
-}
 
 /* Detect and size the various caches. */
 static void __init probe_icache(unsigned long config)
@@ -586,36 +667,40 @@
 
 static void __init setup_noscache_funcs(void)
 {
-	_clear_page = (void *)mips32_clear_page_dc;
-	_copy_page = (void *)mips32_copy_page_dc;
-	_flush_cache_all = mips32_flush_cache_all_pc;
-	___flush_cache_all = mips32_flush_cache_all_pc;
-	_flush_cache_mm = mips32_flush_cache_mm_pc;
-	_flush_cache_range = mips32_flush_cache_range_pc;
-	_flush_cache_page = mips32_flush_cache_page_pc;
+	_clear_page = (void *) mips32_clear_page_dc;
+	_copy_page  = (void *) mips32_copy_page_dc;
+	_flush_cache_all     = mips32_flush_cache_all_pc;
+	___flush_cache_all   = mips32_flush_cache_all_pc;
+	_flush_cache_mm      = mips32_flush_cache_mm_pc;
+	_flush_cache_range   = mips32_flush_cache_range_pc;
+	_flush_cache_page    = mips32_flush_cache_page_pc;
 
-	_flush_icache_page = mips32_flush_icache_page;
+	_flush_icache_page   = mips32_flush_icache_page;
 
+#ifdef	CONFIG_NONCOHERENT_IO
 	_dma_cache_wback_inv = mips32_dma_cache_wback_inv_pc;
-	_dma_cache_wback = mips32_dma_cache_wback;
-	_dma_cache_inv = mips32_dma_cache_inv_pc;
+	_dma_cache_wback     = mips32_dma_cache_wback;
+	_dma_cache_inv       = mips32_dma_cache_inv_pc;
+#endif
 }
 
 static void __init setup_scache_funcs(void)
 {
-        _flush_cache_all = mips32_flush_cache_all_sc;
-        ___flush_cache_all = mips32_flush_cache_all_sc;
-	_flush_cache_mm = mips32_flush_cache_mm_sc;
-	_flush_cache_range = mips32_flush_cache_range_sc;
-	_flush_cache_page = mips32_flush_cache_page_sc;
-	_clear_page = (void *)mips32_clear_page_sc;
-	_copy_page = (void *)mips32_copy_page_sc;
+	_clear_page = (void *) mips32_clear_page_sc;
+	_copy_page  = (void *) mips32_copy_page_sc;
+        _flush_cache_all     = mips32_flush_cache_all_sc;
+        ___flush_cache_all   = mips32_flush_cache_all_sc;
+	_flush_cache_mm      = mips32_flush_cache_mm_sc;
+	_flush_cache_range   = mips32_flush_cache_range_sc;
+	_flush_cache_page    = mips32_flush_cache_page_sc;
 
-	_flush_icache_page = mips32_flush_icache_page_s;
+	_flush_icache_page   = mips32_flush_icache_page_s;
 
+#ifdef	CONFIG_NONCOHERENT_IO
 	_dma_cache_wback_inv = mips32_dma_cache_wback_inv_sc;
-	_dma_cache_wback = mips32_dma_cache_wback;
-	_dma_cache_inv = mips32_dma_cache_inv_sc;
+	_dma_cache_wback     = mips32_dma_cache_wback;
+	_dma_cache_inv       = mips32_dma_cache_inv_sc;
+#endif
 }
 
 typedef int (*probe_func_t)(unsigned long);
@@ -669,10 +754,89 @@
 	shm_align_mask = max_t(unsigned long, mips_cpu.dcache.sets * dc_lsize,
 	                       PAGE_SIZE) - 1;
 
-	_flush_cache_sigtramp = mips32_flush_cache_sigtramp;
-	_flush_icache_range = mips32_flush_icache_range;	/* Ouch */
+	_flush_icache_all      = mips32_flush_icache_all;
+	_flush_icache_range    = mips32_flush_icache_range;	/* Ouch */
 	_flush_data_cache_page = mips32_flush_data_cache_page;
-	_flush_icache_all = mips32_flush_icache_all;
+	_flush_cache_sigtramp  = mips32_flush_cache_sigtramp;
 
 	__flush_cache_all();
 }
+
+
+
+#ifdef	DEBUG_COUNTERS
+
+static int cmips32_read_proc(char *buf, char **start, off_t fpos,
+			 int length, int *eof, void *data)
+{
+	int	len;
+	char	*p = buf;
+
+	p += sprintf(p, "\nCache statistics from c-mips32.c:\n\n");
+
+	p += sprintf(p, "mips32_flush_cache_all_pc:   %8d    "
+	                "mips32_flush_cache_all_sc:   %8d\n",
+			cnt_mips32_flush_cache_all_pc,
+			cnt_mips32_flush_cache_all_sc);
+	p += sprintf(p, "mips32_flush_cache_range_pc: %8d    "
+	                "mips32_flush_cache_range_sc: %8d\n",
+			cnt_mips32_flush_cache_range_pc,
+			cnt_mips32_flush_cache_range_sc);
+	p += sprintf(p, "mips32_flush_cache_mm_pc:    %8d    "
+	                "mips32_flush_cache_mm_sc:    %8d\n",
+			cnt_mips32_flush_cache_mm_pc,
+			cnt_mips32_flush_cache_mm_sc);
+	p += sprintf(p, "mips32_flush_cache_page_pc:  %8d    "
+	                "mips32_flush_cache_page_sc:  %8d\n\n",
+			cnt_mips32_flush_cache_page_pc,
+			cnt_mips32_flush_cache_page_sc);
+
+	p += sprintf(p, "mips32_flush_icache_all:     %8d    "
+			"mips32_flush_icache_page_s:  %8d\n",
+			cnt_mips32_flush_icache_all,
+			cnt_mips32_flush_icache_page_s);
+	p += sprintf(p, "mips32_flush_icache_range:   %8d    "
+			"mips32_flush_icache_page:    %8d\n",
+			cnt_mips32_flush_icache_range,
+			cnt_mips32_flush_icache_page);
+	p += sprintf(p, "mips32_flush_data_cache_page:%8d    "
+			"mips32_flush_cache_sigtramp: %8d\n\n",
+			cnt_mips32_flush_data_cache_page,
+			cnt_mips32_flush_cache_sigtramp);
+
+	p += sprintf(p, "dma_cache_wback_inv_pc:      %8d    "
+			"dma_cache_wback_inv_sc:      %8d\n",
+			cnt_dma_cache_wback_inv_pc,
+			cnt_dma_cache_wback_inv_sc);
+	p += sprintf(p, "dma_cache_inv_pc:            %8d    "
+			"dma_cache_inv_sc:            %8d\n\n",
+			cnt_dma_cache_inv_pc,
+			cnt_dma_cache_inv_sc);
+
+	len = p - buf;
+	if (fpos >= len) {
+		/* Nothing to return... */
+		*start = buf;
+		*eof = 1;
+		return 0;
+	}
+
+	*start = buf + fpos;
+	if ((len -= fpos) > length)
+		return length;
+
+	*eof = 1;
+	return len;
+}
+
+static int __init cmips32_init_module(void)
+{
+	create_proc_read_entry ("cmips32_cache_stats", 0, NULL,
+		cmips32_read_proc, NULL);
+
+	return 0;
+}
+
+module_init(cmips32_init_module);
+
+#endif

--------------1CADC4A811B853F927ABCAD0--
