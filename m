Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 17:47:00 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:49678 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012222AbbA2QqmJ8rqX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 17:46:42 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1YGsBB-00011X-DY; Thu, 29 Jan 2015 10:42:53 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 3/3] MIPS: Fix I-cache flushing for kmap'd pages.
Date:   Thu, 29 Jan 2015 10:46:16 -0600
Message-Id: <1422549976-10648-4-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1422549976-10648-1-git-send-email-Steven.Hill@imgtec.com>
References: <1422549976-10648-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Make the I-cache flush pages while taking into account the
address color by using kmap_coherent() when there is
I-cache aliasing present.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h |    3 +++
 arch/mips/mm/c-r4k.c                 |   17 ++++++++++++++---
 arch/mips/mm/init.c                  |    2 --
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 23db770..92aa321 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -142,6 +142,9 @@
 #ifndef cpu_has_vtag_dcache
 #define cpu_has_vtag_dcache     (cpu_data[0].dcache.flags & MIPS_CACHE_VTAG)
 #endif
+#ifndef cpu_has_ic_aliases
+#define cpu_has_ic_aliases      (cpu_data[0].icache.flags & MIPS_CACHE_ALIASES)
+#endif
 #ifndef cpu_has_dc_aliases
 #define cpu_has_dc_aliases	(cpu_data[0].dcache.flags & MIPS_CACHE_ALIASES)
 #endif
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 9096c5f..d48da56a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -552,6 +552,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 	pmd_t *pmdp;
 	pte_t *ptep;
 	void *vaddr;
+	int noflush = 0;
 
 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
@@ -611,6 +612,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 
 			if (cpu_context(cpu, mm) != 0)
 				drop_mmu_context(mm, cpu);
+			noflush = 1;
 		} else
 			vaddr ? r4k_blast_icache_page(addr) :
 				r4k_blast_icache_user_page(addr);
@@ -622,6 +624,13 @@ static inline void local_r4k_flush_cache_page(void *args)
 		else
 			kunmap_atomic(vaddr);
 	}
+
+	/*  If we have I-cache aliasing, then blast it via coherent page. */
+	if (exec && cpu_has_ic_aliases && !noflush && !map_coherent) {
+		vaddr = kmap_coherent(page, addr);
+		r4k_blast_icache_page((unsigned long)vaddr);
+		kunmap_coherent();
+	}
 }
 
 static void r4k_flush_cache_page(struct vm_area_struct *vma,
@@ -1317,10 +1326,12 @@ static void probe_pcache(void)
 		c->icache.ways = 1;
 	}
 
-	printk("Primary instruction cache %ldkB, %s, %s, linesize %d bytes.\n",
-	       icache_size >> 10,
+	printk("Primary instruction cache %ldkB, %s, %s, %slinesize %d bytes.\n",
+	       icache_size >> 10, way_string[c->icache.ways],
 	       c->icache.flags & MIPS_CACHE_VTAG ? "VIVT" : "VIPT",
-	       way_string[c->icache.ways], c->icache.linesz);
+	       (c->icache.flags & MIPS_CACHE_ALIASES) ?
+			"I-cache aliases, " : "",
+	       c->icache.linesz);
 
 	printk("Primary data cache %ldkB, %s, %s, %s, linesize %d bytes\n",
 	       dcache_size >> 10, way_string[c->dcache.ways],
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 0dc604a..b1584d6 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -88,8 +88,6 @@ static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
 	pte_t pte;
 	int tlbidx;
 
-	BUG_ON(Page_dcache_dirty(page));
-
 	pagefault_disable();
 	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
 	idx += in_interrupt() ? FIX_N_COLOURS : 0;
-- 
1.7.10.4
