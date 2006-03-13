Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 09:14:22 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:8750 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133515AbWCMJOL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Mar 2006 09:14:11 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 13 Mar 2006 18:23:09 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 17C23203CE;
	Mon, 13 Mar 2006 18:23:05 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 0428A202E8;
	Mon, 13 Mar 2006 18:23:05 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k2D9N44D012644;
	Mon, 13 Mar 2006 18:23:04 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 13 Mar 2006 18:23:03 +0900 (JST)
Message-Id: <20060313.182303.115641770.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] local_r4k_flush_cache_page fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060201.000356.25911337.anemo@mba.ocn.ne.jp>
References: <20060201.000356.25911337.anemo@mba.ocn.ne.jp>
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
X-archive-position: 10785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 01 Feb 2006 00:03:56 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> If dcache_size != icache_size or dcache_size != scache_size,
anemo> icache/scache does not flushed properly.  Use correct cache size to
anemo> calculate index value for scache/icache.

Ping.  I believe current c-r4k.c still broken for CPUs with large
set-assotiative cache or physically indexed cache.  Here is a patch
against current GIT tree.


If dcache_size != icache_size or dcache_size != scache_size, or
set-associative cache, icache/scache does not flushed properly.  Make
blast_?cache_page_indexed() masks its index value correctly.  Also,
use physical address for physically indexed pcache/scache.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 0668e9b..9572ed4 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -375,6 +375,7 @@ static void r4k_flush_cache_mm(struct mm
 struct flush_cache_page_args {
 	struct vm_area_struct *vma;
 	unsigned long addr;
+	unsigned long pfn;
 };
 
 static inline void local_r4k_flush_cache_page(void *args)
@@ -382,6 +383,7 @@ static inline void local_r4k_flush_cache
 	struct flush_cache_page_args *fcp_args = args;
 	struct vm_area_struct *vma = fcp_args->vma;
 	unsigned long addr = fcp_args->addr;
+	unsigned long paddr = fcp_args->pfn << PAGE_SHIFT;
 	int exec = vma->vm_flags & VM_EXEC;
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgdp;
@@ -431,11 +433,12 @@ static inline void local_r4k_flush_cache
 	 * Do indexed flush, too much work to get the (possible) TLB refills
 	 * to work correctly.
 	 */
-	addr = INDEX_BASE + (addr & (dcache_size - 1));
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
-		r4k_blast_dcache_page_indexed(addr);
-		if (exec && !cpu_icache_snoops_remote_store)
-			r4k_blast_scache_page_indexed(addr);
+		r4k_blast_dcache_page_indexed(cpu_has_pindexed_dcache ?
+					      paddr : addr);
+		if (exec && !cpu_icache_snoops_remote_store) {
+			r4k_blast_scache_page_indexed(paddr);
+		}
 	}
 	if (exec) {
 		if (cpu_has_vtag_icache) {
@@ -455,6 +458,7 @@ static void r4k_flush_cache_page(struct 
 
 	args.vma = vma;
 	args.addr = addr;
+	args.pfn = pfn;
 
 	on_each_cpu(local_r4k_flush_cache_page, &args, 1, 1);
 }
@@ -956,6 +960,7 @@ static void __init probe_pcache(void)
 	switch (c->cputype) {
 	case CPU_20KC:
 	case CPU_25KF:
+		c->dcache.flags |= MIPS_CACHE_PINDEX;
 	case CPU_R10000:
 	case CPU_R12000:
 	case CPU_SB1:
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index 7c572be..fe232e3 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -210,7 +210,6 @@ static void tx39_flush_cache_page(struct
 	 * Do indexed flush, too much work to get the (possible) TLB refills
 	 * to work correctly.
 	 */
-	page = (KSEG0 + (page & (dcache_size - 1)));
 	if (cpu_has_dc_aliases || exec)
 		tx39_blast_dcache_page_indexed(page);
 	if (exec)
diff --git a/include/asm-mips/cpu-features.h b/include/asm-mips/cpu-features.h
index 78c9cc2..3f2b6d9 100644
--- a/include/asm-mips/cpu-features.h
+++ b/include/asm-mips/cpu-features.h
@@ -96,6 +96,9 @@
 #ifndef cpu_has_ic_fills_f_dc
 #define cpu_has_ic_fills_f_dc	(cpu_data[0].icache.flags & MIPS_CACHE_IC_F_DC)
 #endif
+#ifndef cpu_has_pindexed_dcache
+#define cpu_has_pindexed_dcache	(cpu_data[0].dcache.flags & MIPS_CACHE_PINDEX)
+#endif
 
 /*
  * I-Cache snoops remote store.  This only matters on SMP.  Some multiprocessors
diff --git a/include/asm-mips/cpu-info.h b/include/asm-mips/cpu-info.h
index d5cf519..140be1c 100644
--- a/include/asm-mips/cpu-info.h
+++ b/include/asm-mips/cpu-info.h
@@ -39,6 +39,7 @@ struct cache_desc {
 #define MIPS_CACHE_ALIASES	0x00000004	/* Cache could have aliases */
 #define MIPS_CACHE_IC_F_DC	0x00000008	/* Ic can refill from D-cache */
 #define MIPS_IC_SNOOPS_REMOTE	0x00000010	/* Ic snoops remote stores */
+#define MIPS_CACHE_PINDEX	0x00000020	/* Physically indexed cache */
 
 struct cpuinfo_mips {
 	unsigned long		udelay_val;
diff --git a/include/asm-mips/r4kcache.h b/include/asm-mips/r4kcache.h
index 9632c27..0bcb79a 100644
--- a/include/asm-mips/r4kcache.h
+++ b/include/asm-mips/r4kcache.h
@@ -257,7 +257,8 @@ static inline void blast_##pfx##cache##l
 									\
 static inline void blast_##pfx##cache##lsize##_page_indexed(unsigned long page) \
 {									\
-	unsigned long start = page;					\
+	unsigned long indexmask = current_cpu_data.desc.waysize - 1;	\
+	unsigned long start = INDEX_BASE + (page & indexmask);		\
 	unsigned long end = start + PAGE_SIZE;				\
 	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
 	unsigned long ws_end = current_cpu_data.desc.ways <<		\
