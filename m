Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2003 14:17:02 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:33809 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8224827AbTDGNRB>;
	Mon, 7 Apr 2003 14:17:01 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id 61681B4FF
	for <linux-mips@linux-mips.org>; Mon,  7 Apr 2003 15:16:50 +0200 (CEST)
Message-ID: <3E917C50.BDDA8F7F@ekner.info>
Date: Mon, 07 Apr 2003 15:25:36 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Updated cache statistics patch for new c-mips32.c
Content-Type: multipart/mixed;
 boundary="------------C6C9B6962131A30E5060C143"
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------C6C9B6962131A30E5060C143
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Below is an updated cache statistics counter patch for c-mips32.c after Ralf nuked all the _sc routines.

/Hartvig


--------------C6C9B6962131A30E5060C143
Content-Type: text/plain; charset=us-ascii;
 name="cmips32_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmips32_patch"

Index: c-mips32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-mips32.c,v
retrieving revision 1.3.2.19
diff -u -r1.3.2.19 c-mips32.c
--- c-mips32.c	7 Apr 2003 00:17:06 -0000	1.3.2.19
+++ c-mips32.c	7 Apr 2003 13:14:09 -0000
@@ -17,6 +17,10 @@
  *
  * MIPS32 CPU variant specific MMU/Cache routines.
  */
+
+#undef	DEBUG_CACHE		/* Control debug printk's	*/
+#define	DEBUG_COUNTERS		/* Control statistics counters	*/
+
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -32,6 +36,34 @@
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
+static int cnt_mips32_flush_cache_all_pc = 0;
+static int cnt_mips32_flush_cache_mm_pc = 0;
+static int cnt_mips32_flush_cache_range_pc = 0;
+static int cnt_mips32_flush_cache_page_pc = 0;
+
+static int cnt_mips32_flush_icache_all = 0;
+static int cnt_mips32_flush_icache_range = 0;
+static int cnt_mips32_flush_icache_page = 0;
+
+static int cnt_mips32_flush_data_cache_page = 0;
+static int cnt_mips32_flush_cache_sigtramp = 0;
+
+static int cnt_dma_cache_wback_inv_pc = 0;
+static int cnt_dma_cache_inv_pc = 0;
+
+#endif
+
+
 /* Primary cache parameters. */
 int icache_size, dcache_size; 			/* Size in bytes */
 int ic_lsize, dc_lsize;				/* LineSize in bytes */
@@ -42,7 +74,6 @@
 #include <asm/cacheops.h>
 #include <asm/mips32_cache.h>
 
-#undef DEBUG_CACHE
 
 /*
  * Dummy cache handling routines for machines without boardcaches
@@ -60,25 +91,31 @@
 
 static inline void mips32_flush_cache_all_pc(void)
 {
+	DEBUG_INCCNT(cnt_mips32_flush_cache_all_pc);
+
 	blast_dcache();
 	blast_icache();
 }
 
+static void mips32_flush_cache_mm_pc(struct mm_struct *mm)
+{
+	DEBUG_INCCNT(cnt_mips32_flush_cache_mm_pc);
+
+	if (cpu_context(smp_processor_id(), mm) != 0)
+		mips32_flush_cache_all_pc();
+}
+
 static void mips32_flush_cache_range_pc(struct mm_struct *mm,
 	unsigned long start, unsigned long end)
 {
+	DEBUG_INCCNT(cnt_mips32_flush_cache_range_pc);
+
 	if (cpu_context(smp_processor_id(), mm) != 0) {
 		blast_dcache();
 		blast_icache();
 	}
 }
 
-static void mips32_flush_cache_mm_pc(struct mm_struct *mm)
-{
-	if (cpu_context(smp_processor_id(), mm) != 0)
-		mips32_flush_cache_all_pc();
-}
-
 static void mips32_flush_cache_page_pc(struct vm_area_struct *vma,
 				    unsigned long page)
 {
@@ -87,6 +124,8 @@
 	pmd_t *pmdp;
 	pte_t *ptep;
 
+	DEBUG_INCCNT(cnt_mips32_flush_cache_page_pc);
+
 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
 	 * this page into the cache.
@@ -126,20 +165,27 @@
 	}
 }
 
-static void mips32_flush_data_cache_page(unsigned long addr)
+static void mips32_flush_icache_all(void)
 {
-	blast_dcache_page(addr);
+	DEBUG_INCCNT(cnt_mips32_flush_icache_all);
+
+	if (current_cpu_data.icache.flags | MIPS_CACHE_VTAG_CACHE)
+		blast_icache();
 }
 
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
@@ -154,6 +200,26 @@
 	flush_cache_all();
 }
 
+static void mips32_flush_data_cache_page(unsigned long addr)
+{
+	DEBUG_INCCNT(cnt_mips32_flush_data_cache_page);
+
+	blast_dcache_page(addr);
+}
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
 /*
  * Writeback and invalidate the primary cache dcache before DMA.
  */
@@ -163,6 +229,8 @@
 	unsigned long end, a;
 	unsigned long flags;
 
+	DEBUG_INCCNT(cnt_dma_cache_wback_inv_pc);
+
 	if (size >= dcache_size) {
 		blast_dcache();
 	} else {
@@ -185,6 +253,8 @@
 	unsigned long end, a;
 	unsigned long flags;
 
+	DEBUG_INCCNT(cnt_dma_cache_inv_pc);
+
 	if (size >= dcache_size) {
 		blast_dcache();
 	} else {
@@ -208,23 +278,6 @@
 	panic("mips32_dma_cache called - should not happen.");
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
-
-static void mips32_flush_icache_all(void)
-{
-	if (current_cpu_data.icache.flags | MIPS_CACHE_VTAG_CACHE)
-		blast_icache();
-}
-
 /* Detect and size the various caches. */
 static void __init probe_icache(unsigned long config)
 {
@@ -315,11 +368,12 @@
 	_flush_cache_mm		= mips32_flush_cache_mm_pc;
 	_flush_cache_range	= mips32_flush_cache_range_pc;
 	_flush_cache_page	= mips32_flush_cache_page_pc;
+
+	_flush_icache_all	= mips32_flush_icache_all;
 	_flush_icache_range	= mips32_flush_icache_range;	/* Ouch */
 	_flush_icache_page	= mips32_flush_icache_page;
 
 	_flush_cache_sigtramp	= mips32_flush_cache_sigtramp;
-	_flush_icache_all	= mips32_flush_icache_all;
 	_flush_data_cache_page	= mips32_flush_data_cache_page;
 
 	_dma_cache_wback_inv	= mips32_dma_cache_wback_inv_pc;
@@ -328,3 +382,67 @@
 
 	__flush_cache_all();
 }
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
+			"mips32_flush_icache_all:     %8d\n",
+			cnt_mips32_flush_cache_all_pc,
+			cnt_mips32_flush_icache_all);
+	p += sprintf(p, "mips32_flush_cache_mm_pc:    %8d\n",
+			cnt_mips32_flush_cache_mm_pc);
+	p += sprintf(p, "mips32_flush_cache_range_pc: %8d    "
+			"mips32_flush_icache_range:   %8d\n",
+			cnt_mips32_flush_cache_range_pc,
+			cnt_mips32_flush_icache_range);
+	p += sprintf(p, "mips32_flush_cache_page_pc:  %8d    "
+			"mips32_flush_icache_page:    %8d\n\n",
+			cnt_mips32_flush_cache_page_pc,
+			cnt_mips32_flush_icache_page);
+
+	p += sprintf(p, "mips32_flush_data_cache_page:%8d\n",
+			cnt_mips32_flush_data_cache_page);
+	p += sprintf(p,	"mips32_flush_cache_sigtramp: %8d\n\n",
+			cnt_mips32_flush_cache_sigtramp);
+
+	p += sprintf(p, "dma_cache_wback_inv_pc:      %8d\n",
+			cnt_dma_cache_wback_inv_pc);
+	p += sprintf(p,	"dma_cache_inv_pc:            %8d\n",
+			cnt_dma_cache_inv_pc);
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

--------------C6C9B6962131A30E5060C143--
