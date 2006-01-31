Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 14:59:39 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:35816 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133485AbWAaO7V (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2006 14:59:21 +0000
Received: from localhost (p2155-ipad27funabasi.chiba.ocn.ne.jp [220.107.193.155])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A9F7AA4EC; Wed,  1 Feb 2006 00:04:17 +0900 (JST)
Date:	Wed, 01 Feb 2006 00:03:56 +0900 (JST)
Message-Id: <20060201.000356.25911337.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] local_r4k_flush_cache_page fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 10254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

If dcache_size != icache_size or dcache_size != scache_size,
icache/scache does not flushed properly.  Use correct cache size to
calculate index value for scache/icache.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e51c38c..d70d700 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -376,6 +376,7 @@ static inline void local_r4k_flush_cache
 	struct flush_cache_page_args *fcp_args = args;
 	struct vm_area_struct *vma = fcp_args->vma;
 	unsigned long addr = fcp_args->addr;
+	unsigned long index;
 	int exec = vma->vm_flags & VM_EXEC;
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgdp;
@@ -425,11 +426,13 @@ static inline void local_r4k_flush_cache
 	 * Do indexed flush, too much work to get the (possible) TLB refills
 	 * to work correctly.
 	 */
-	addr = INDEX_BASE + (addr & (dcache_size - 1));
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
-		r4k_blast_dcache_page_indexed(addr);
-		if (exec && !cpu_icache_snoops_remote_store)
-			r4k_blast_scache_page_indexed(addr);
+		index = INDEX_BASE + (addr & (dcache_size - 1));
+		r4k_blast_dcache_page_indexed(index);
+		if (exec && !cpu_icache_snoops_remote_store) {
+			index = INDEX_BASE + (addr & (scache_size - 1));
+			r4k_blast_scache_page_indexed(index);
+		}
 	}
 	if (exec) {
 		if (cpu_has_vtag_icache) {
@@ -437,8 +440,10 @@ static inline void local_r4k_flush_cache
 
 			if (cpu_context(cpu, mm) != 0)
 				drop_mmu_context(mm, cpu);
-		} else
-			r4k_blast_icache_page_indexed(addr);
+		} else {
+			index = INDEX_BASE + (addr & (icache_size - 1));
+			r4k_blast_icache_page_indexed(index);
+		}
 	}
 }
 
