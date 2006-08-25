Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2006 09:55:44 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:31768 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038722AbWHYIzj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Aug 2006 09:55:39 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 25 Aug 2006 17:55:38 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 4281720451;
	Fri, 25 Aug 2006 17:55:32 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 2DC7B20041;
	Fri, 25 Aug 2006 17:55:32 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k7P8tVW0021385;
	Fri, 25 Aug 2006 17:55:32 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 25 Aug 2006 17:55:31 +0900 (JST)
Message-Id: <20060825.175531.99204769.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] do not use drop_mmu_context to flusing other task's icache
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The c-r4k.c and c-sb1.c use drop_mmu_context() to flushing virtually
tagged icache, but this would not work for flushing other task's
icache.  The ptrace() (and copy_to_user_page()) is the case.  Use
indexed flush for such cases.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 4e14982..2d729f6 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -475,7 +475,7 @@ static inline void local_r4k_flush_cache
 		}
 	}
 	if (exec) {
-		if (cpu_has_vtag_icache) {
+		if (cpu_has_vtag_icache && mm == current->active_mm) {
 			int cpu = smp_processor_id();
 
 			if (cpu_context(cpu, mm) != 0)
@@ -599,7 +599,7 @@ static inline void local_r4k_flush_icach
 	 * We're not sure of the virtual address(es) involved here, so
 	 * we have to flush the entire I-cache.
 	 */
-	if (cpu_has_vtag_icache) {
+	if (cpu_has_vtag_icache && vma->vm_mm == current->active_mm) {
 		int cpu = smp_processor_id();
 
 		if (cpu_context(cpu, vma->vm_mm) != 0)
diff --git a/arch/mips/mm/c-sb1.c b/arch/mips/mm/c-sb1.c
index 4bd9ad8..16bad7c 100644
--- a/arch/mips/mm/c-sb1.c
+++ b/arch/mips/mm/c-sb1.c
@@ -155,6 +155,26 @@ static inline void __sb1_flush_icache_al
 }
 
 /*
+ * Invalidate a range of the icache.  The addresses are virtual, and
+ * the cache is virtually indexed and tagged.  However, we don't
+ * necessarily have the right ASID context, so use index ops instead
+ * of hit ops.
+ */
+static inline void __sb1_flush_icache_range(unsigned long start,
+	unsigned long end)
+{
+	start &= ~(icache_line_size - 1);
+	end = (end + icache_line_size - 1) & ~(icache_line_size - 1);
+
+	while (start != end) {
+		cache_set_op(Index_Invalidate_I, start & icache_index_mask);
+		start += icache_line_size;
+	}
+	mispredict();
+	sync();
+}
+
+/*
  * Flush the icache for a given physical page.  Need to writeback the
  * dcache first, then invalidate the icache.  If the page isn't
  * executable, nothing is required.
@@ -173,8 +193,11 @@ #endif
 	/*
 	 * Bumping the ASID is probably cheaper than the flush ...
 	 */
-	if (cpu_context(cpu, vma->vm_mm) != 0)
-		drop_mmu_context(vma->vm_mm, cpu);
+	if (vma->vm_mm == current->active_mm) {
+		if (cpu_context(cpu, vma->vm_mm) != 0)
+			drop_mmu_context(vma->vm_mm, cpu);
+	} else
+		__sb1_flush_icache_range(addr, addr + PAGE_SIZE);
 }
 
 #ifdef CONFIG_SMP
@@ -210,26 +233,6 @@ void sb1_flush_cache_page(struct vm_area
 	__attribute__((alias("local_sb1_flush_cache_page")));
 #endif
 
-/*
- * Invalidate a range of the icache.  The addresses are virtual, and
- * the cache is virtually indexed and tagged.  However, we don't
- * necessarily have the right ASID context, so use index ops instead
- * of hit ops.
- */
-static inline void __sb1_flush_icache_range(unsigned long start,
-	unsigned long end)
-{
-	start &= ~(icache_line_size - 1);
-	end = (end + icache_line_size - 1) & ~(icache_line_size - 1);
-
-	while (start != end) {
-		cache_set_op(Index_Invalidate_I, start & icache_index_mask);
-		start += icache_line_size;
-	}
-	mispredict();
-	sync();
-}
-
 
 /*
  * Invalidate all caches on this CPU
@@ -326,9 +329,12 @@ #endif
 	 * If there's a context, bump the ASID (cheaper than a flush,
 	 * since we don't know VAs!)
 	 */
-	if (cpu_context(cpu, vma->vm_mm) != 0) {
-		drop_mmu_context(vma->vm_mm, cpu);
-	}
+	if (vma->vm_mm == current->active_mm) {
+		if (cpu_context(cpu, vma->vm_mm) != 0)
+			drop_mmu_context(vma->vm_mm, cpu);
+	} else
+		__sb1_flush_icache_range(start, start + PAGE_SIZE);
+
 }
 
 #ifdef CONFIG_SMP
