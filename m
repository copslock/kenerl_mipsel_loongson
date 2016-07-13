Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:14:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38459 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992754AbcGMNN3YA4Hh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:29 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 082609D7AF8AD;
        Wed, 13 Jul 2016 14:13:20 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:22 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 05/13] MIPS: c-r4k: Fix sigtramp SMP call to use kmap
Date:   Wed, 13 Jul 2016 14:12:48 +0100
Message-ID: <1468415576-12600-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
References: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Fix r4k_flush_cache_sigtramp() and local_r4k_flush_cache_sigtramp() to
flush the delay slot emulation trampoline cacheline through a kmap
rather than directly when the active_mm doesn't match that of the task
initiating the flush, a bit like local_r4k_flush_cache_page() does.

This would fix a corner case on SMP systems without hardware globalized
hit cache ops, where a migration to another CPU after the flush, where
that CPU did not have the same mm active at the time of the flush, could
result in stale icache content being executed instead of the trampoline,
e.g. from a previous delay slot emulation with a similar stack pointer.

This case was artificially triggered by replacing the icache flush with
a full indexed flush (not globalized on CM systems) and forcing the SMP
call to take place, with a test program that alternated two FPU delay
slots with a parent process repeatedly changing scheduler affinity.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r4k.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 9204d4e4f02f..600b0ad48319 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -792,25 +792,72 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 }
 #endif /* CONFIG_DMA_NONCOHERENT || CONFIG_DMA_MAYBE_COHERENT */
 
+struct flush_cache_sigtramp_args {
+	struct mm_struct *mm;
+	struct page *page;
+	unsigned long addr;
+};
+
 /*
  * While we're protected against bad userland addresses we don't care
  * very much about what happens in that case.  Usually a segmentation
  * fault will dump the process later on anyway ...
  */
-static void local_r4k_flush_cache_sigtramp(void * arg)
+static void local_r4k_flush_cache_sigtramp(void *args)
 {
+	struct flush_cache_sigtramp_args *fcs_args = args;
+	unsigned long addr = fcs_args->addr;
+	struct page *page = fcs_args->page;
+	struct mm_struct *mm = fcs_args->mm;
+	int map_coherent = 0;
+	void *vaddr;
+
 	unsigned long ic_lsize = cpu_icache_line_size();
 	unsigned long dc_lsize = cpu_dcache_line_size();
 	unsigned long sc_lsize = cpu_scache_line_size();
-	unsigned long addr = (unsigned long) arg;
+
+	/*
+	 * If owns no valid ASID yet, cannot possibly have gotten
+	 * this page into the cache.
+	 */
+	if (!has_valid_asid(mm))
+		return;
+
+	if (mm == current->active_mm) {
+		vaddr = NULL;
+	} else {
+		/*
+		 * Use kmap_coherent or kmap_atomic to do flushes for
+		 * another ASID than the current one.
+		 */
+		map_coherent = (cpu_has_dc_aliases &&
+				page_mapcount(page) &&
+				!Page_dcache_dirty(page));
+		if (map_coherent)
+			vaddr = kmap_coherent(page, addr);
+		else
+			vaddr = kmap_atomic(page);
+		addr = (unsigned long)vaddr + (addr & ~PAGE_MASK);
+	}
 
 	R4600_HIT_CACHEOP_WAR_IMPL;
 	if (dc_lsize)
-		protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
+		vaddr ? flush_dcache_line(addr & ~(dc_lsize - 1))
+		      : protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
 	if (!cpu_icache_snoops_remote_store && scache_size)
-		protected_writeback_scache_line(addr & ~(sc_lsize - 1));
+		vaddr ? flush_scache_line(addr & ~(sc_lsize - 1))
+		      : protected_writeback_scache_line(addr & ~(sc_lsize - 1));
 	if (ic_lsize)
-		protected_flush_icache_line(addr & ~(ic_lsize - 1));
+		vaddr ? flush_icache_line(addr & ~(ic_lsize - 1))
+		      : protected_flush_icache_line(addr & ~(ic_lsize - 1));
+
+	if (vaddr) {
+		if (map_coherent)
+			kunmap_coherent();
+		else
+			kunmap_atomic(vaddr);
+	}
+
 	if (MIPS4K_ICACHE_REFILL_WAR) {
 		__asm__ __volatile__ (
 			".set push\n\t"
@@ -835,7 +882,23 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
 
 static void r4k_flush_cache_sigtramp(unsigned long addr)
 {
-	r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
+	struct flush_cache_sigtramp_args args;
+	int npages;
+
+	down_read(&current->mm->mmap_sem);
+
+	npages = get_user_pages_fast(addr, 1, 0, &args.page);
+	if (npages < 1)
+		goto out;
+
+	args.mm = current->mm;
+	args.addr = addr;
+
+	r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, &args);
+
+	put_page(args.page);
+out:
+	up_read(&current->mm->mmap_sem);
 }
 
 static void r4k_flush_icache_all(void)
-- 
2.4.10
