Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 16:49:23 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:14845 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133406AbWBCQtE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2006 16:49:04 +0000
Received: from localhost (p2023-ipad205funabasi.chiba.ocn.ne.jp [222.146.97.23])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 169F0A421; Sat,  4 Feb 2006 01:54:16 +0900 (JST)
Date:	Sat, 04 Feb 2006 01:53:56 +0900 (JST)
Message-Id: <20060204.015356.74753400.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] local_r4k_flush_cache_page fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060203144739.GB3375@linux-mips.org>
References: <20060201.000356.25911337.anemo@mba.ocn.ne.jp>
	<20060203.141424.72708300.nemoto@toshiba-tops.co.jp>
	<20060203144739.GB3375@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 3 Feb 2006 14:47:39 +0000, Ralf Baechle <ralf@linux-mips.org> said:

ralf> Maciej ran over what seems to be the same issue; I attach his
ralf> patch below.  Could you check if it resolves your issues?

It looks OK.  But now it can be fixed in one place --
_BUILD_BLAST_CACHE().  I also try to fix for physically indexed caches
(not tested while I do not have such platform...).

Here is a revised one.  Not including Maceij's 34K fix :-)

Description:

If dcache_size != icache_size or dcache_size != scache_size, or
set-associative cache, icache/scache does not flushed properly.  Make
blast_?cache_page_indexed() masks its index value correctly.  Also,
use physical address for physically indexed pcache/scache.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e51c38c..69dfd53 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -369,6 +369,7 @@ static void r4k_flush_cache_mm(struct mm
 struct flush_cache_page_args {
 	struct vm_area_struct *vma;
 	unsigned long addr;
+	unsigned long pfn;
 };
 
 static inline void local_r4k_flush_cache_page(void *args)
@@ -376,6 +377,7 @@ static inline void local_r4k_flush_cache
 	struct flush_cache_page_args *fcp_args = args;
 	struct vm_area_struct *vma = fcp_args->vma;
 	unsigned long addr = fcp_args->addr;
+	unsigned long paddr = fcp_args->pfn << PAGE_SHIFT;
 	int exec = vma->vm_flags & VM_EXEC;
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgdp;
@@ -425,11 +427,12 @@ static inline void local_r4k_flush_cache
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
@@ -449,6 +452,7 @@ static void r4k_flush_cache_page(struct 
 
 	args.vma = vma;
 	args.addr = addr;
+	args.pfn = pfn;
 
 	on_each_cpu(local_r4k_flush_cache_page, &args, 1, 1);
 }
@@ -1026,6 +1030,7 @@ static void __init probe_pcache(void)
 	switch (c->cputype) {
 	case CPU_20KC:
 	case CPU_25KF:
+		c->dcache.flags |= MIPS_CACHE_PINDEX;
 	case CPU_R10000:
 	case CPU_R12000:
 	case CPU_SB1:
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index 0a97a94..f74a52d 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -227,7 +227,6 @@ static void tx39_flush_cache_page(struct
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
index cc53196..a108940 100644
--- a/include/asm-mips/r4kcache.h
+++ b/include/asm-mips/r4kcache.h
@@ -273,7 +273,8 @@ static inline void blast_##pfx##cache##l
 									\
 static inline void blast_##pfx##cache##lsize##_page_indexed(unsigned long page) \
 {									\
-	unsigned long start = page;					\
+	unsigned long indexmask = current_cpu_data.desc.waysize - 1;	\
+	unsigned long start = INDEX_BASE + (page & indexmask);		\
 	unsigned long end = start + PAGE_SIZE;				\
 	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
 	unsigned long ws_end = current_cpu_data.desc.ways <<		\
